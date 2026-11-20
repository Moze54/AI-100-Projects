#!/usr/bin/env python3
"""从 Flutter 工程生成拾记小程序图标字体。

做三件事：
1. 解析 Flutter SDK 的 icons.dart，取出归档 App 源码中用到的全部图标 codepoint；
2. 用 fontTools 对 MaterialIcons 字体做子集化，只保留用到的字形（WOFF2）；
3. 生成 app-icon 组件使用的 TS 码表与 SCSS 字体声明（base64 内嵌）。

用法（在 miniapp/ 目录）：
    python scripts/gen-icons.py
"""

from __future__ import annotations

import base64
import io
import re
import sys
from pathlib import Path

from fontTools import subset

MINIAPP_DIR = Path(__file__).resolve().parents[1]
PROJECT_ROOT = MINIAPP_DIR.parent
APP_LIB_DIR = PROJECT_ROOT / "archive" / "app-flutter" / "lib"
LOCAL_PROPERTIES = PROJECT_ROOT / "archive" / "app-flutter" / "android" / "local.properties"
OUT_DIR = MINIAPP_DIR / "src" / "components" / "app-icon"
STATIC_FONT_DIR = MINIAPP_DIR / "src" / "static" / "fonts"


def flutter_root() -> Path:
    if LOCAL_PROPERTIES.exists():
        for line in LOCAL_PROPERTIES.read_text(encoding="utf-8").splitlines():
            if line.startswith("flutter.sdk="):
                return Path(line.split("=", 1)[1].strip().replace("\\\\", "\\"))
    sys.exit("未找到 flutter.sdk，请检查 archive/app-flutter/android/local.properties")


def collect_used_icons() -> set[str]:
    names: set[str] = set()
    for dart_file in APP_LIB_DIR.rglob("*.dart"):
        names.update(re.findall(r"Icons\.([a-zA-Z0-9_]+)", dart_file.read_text(encoding="utf-8")))
    if not names:
        sys.exit("未在 App 源码中找到任何图标引用")
    return names


def parse_codepoints(icons_dart: Path) -> dict[str, int]:
    source = icons_dart.read_text(encoding="utf-8")
    pairs = re.findall(
        r"static const IconData ([a-zA-Z0-9_]+) = IconData\(\s*(0x[0-9a-fA-F]+)",
        source,
    )
    return {name: int(code, 16) for name, code in pairs}


def build_subset(font_path: Path, codepoints: list[int]) -> bytes:
    options = subset.Options()
    options.glyph_names = False
    options.notdef_outline = True
    options.drop_tables += ["DSIG"]
    font = subset.load_font(str(font_path), options)
    subsetter = subset.Subsetter(options=options)
    subsetter.populate(unicodes=codepoints)
    subsetter.subset(font)
    font.flavor = "woff2"
    buffer = io.BytesIO()
    font.save(buffer)
    return buffer.getvalue()


def main() -> None:
    root = flutter_root()
    icons_dart = root / "packages" / "flutter" / "lib" / "src" / "material" / "icons.dart"
    font_path = root / "bin" / "cache" / "artifacts" / "material_fonts" / "materialicons-regular.otf"
    license_path = root / "bin" / "cache" / "artifacts" / "material_fonts" / "materialicons_license.txt"

    for path in (icons_dart, font_path):
        if not path.exists():
            sys.exit(f"缺少文件：{path}")

    used = sorted(collect_used_icons())
    mapping = parse_codepoints(icons_dart)
    missing = [name for name in used if name not in mapping]
    if missing:
        sys.exit(f"icons.dart 中找不到以下图标：{missing}")

    codepoints = sorted({mapping[name] for name in used})
    font_bytes = build_subset(font_path, codepoints)

    OUT_DIR.mkdir(parents=True, exist_ok=True)
    STATIC_FONT_DIR.mkdir(parents=True, exist_ok=True)

    lines = [
        "// 由 scripts/gen-icons.py 生成，请勿手改。",
        "// 图标来自 Flutter Material Icons（Apache-2.0）。",
        "// 注意：Flutter 的 codepoint 多数超出 BMP，必须用 fromCodePoint 生成，",
        "// 不能写成 \\uXXXX（会被截断成 4 位 + 字面量）。",
        "",
        "export const ICON_GLYPHS: Record<string, string> = {",
    ]
    for name in used:
        lines.append(f"  {name}: String.fromCodePoint(0x{mapping[name]:x}),")
    lines.append("};")
    lines.append("")
    lines.append("export type IconName = keyof typeof ICON_GLYPHS;")
    (OUT_DIR / "icons.ts").write_text("\n".join(lines) + "\n", encoding="utf-8")

    encoded = base64.b64encode(font_bytes).decode("ascii")
    scss = f"""// 由 scripts/gen-icons.py 生成，请勿手改。
// 子集：{len(codepoints)} 个字形，{len(font_bytes) / 1024:.1f}KB（WOFF2）
@font-face {{
  font-family: "shiji-icons";
  font-weight: normal;
  font-style: normal;
  font-display: block;
  src: url("data:font/woff2;base64,{encoded}") format("woff2");
}}

.si-icon {{
  font-family: "shiji-icons" !important;
  font-style: normal;
  font-weight: normal;
  line-height: 1;
  display: inline-block;
  vertical-align: middle;
  -webkit-font-smoothing: antialiased;
  text-rendering: optimizeLegibility;
}}
"""
    (OUT_DIR / "icon-font.scss").write_text(scss, encoding="utf-8")

    if license_path.exists():
        (STATIC_FONT_DIR / "materialicons-license.txt").write_text(
            license_path.read_text(encoding="utf-8"), encoding="utf-8"
        )

    print(f"图标 {len(used)} 个，字形 {len(codepoints)} 个")
    print(f"字体 {len(font_bytes) / 1024:.1f}KB，base64 {len(encoded) / 1024:.1f}KB")
    print(f"输出：{OUT_DIR / 'icons.ts'}")
    print(f"输出：{OUT_DIR / 'icon-font.scss'}")


if __name__ == "__main__":
    main()
