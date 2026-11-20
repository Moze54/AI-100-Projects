#!/usr/bin/env python3
"""把归档 App 的设计素材转换为小程序可用资源。

- 8 张 852x1846 整页背景 → WebP（quality 78，单张约 20KB）
- logo / 头像 / 缩略图 / 蛋糕图 → 优化后的 PNG（体积小，保留无损）

用法（在 miniapp/ 目录）：
    python scripts/optimize-images.py
"""

from __future__ import annotations

import math
import sys
from pathlib import Path

from PIL import Image, ImageDraw

MINIAPP_DIR = Path(__file__).resolve().parents[1]
PROJECT_ROOT = MINIAPP_DIR.parent
SRC_DIR = PROJECT_ROOT / "archive" / "app-flutter" / "assets" / "images"
DESIGN_DIR = PROJECT_ROOT / "设计图"
DST_DIR = MINIAPP_DIR / "src" / "static" / "images"

BACKGROUNDS = [
    "bg_add",
    "bg_category",
    "bg_detail",
    "bg_home",
    "bg_profile",
    "bg_schedule",
    "bg_search",
    "bg_vault",
]

# 4 个 Tab 以设计图为准：优先使用 设计图/ 下独立导出的背景层，
# 避免继续沿用归档 App 的旧版背景（人物/插画位置与设计稿有差异）。
DESIGN_BACKGROUNDS = {
    "bg_home": "首页背景.png",
    "bg_category": "资料页背景.png",
    "bg_schedule": "日程背景.png",
    "bg_profile": "我的页面背景.png",
}

SMALL_PNGS = ["avatar", "cake", "logo", "thumb_cat", "thumb_doc", "thumb_sea"]


def lerp_color(start: tuple[int, int, int], end: tuple[int, int, int], t: float) -> tuple[int, int, int, int]:
    return (
        round(start[0] + (end[0] - start[0]) * t),
        round(start[1] + (end[1] - start[1]) * t),
        round(start[2] + (end[2] - start[2]) * t),
        255,
    )


def generate_cloud_ring(target: Path, percent: float = 0.28) -> None:
    """生成 56dp 云空间进度环（3x 168px），对应 Flutter 首页 _CloudProgress。"""
    supersample = 12  # 1dp = 12px，最后缩到 3x
    size = 56 * supersample
    stroke = 6 * supersample
    center = size / 2
    radius = 56 * supersample / 2 - stroke / 2
    box = [
        center - radius - stroke / 2,
        center - radius - stroke / 2,
        center + radius + stroke / 2,
        center + radius + stroke / 2,
    ]

    image = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(image)

    # 轨道
    draw.ellipse(box, outline=(217, 230, 251, 255), width=stroke)

    # 渐变弧（从正上方开始，顺时针）
    start_angle = -90.0
    sweep = 360.0 * percent
    steps = max(1, round(sweep))
    for i in range(steps):
        t0 = i / steps
        t1 = (i + 1) / steps
        color = lerp_color((107, 164, 255), (61, 123, 245), (t0 + t1) / 2)
        draw.arc(
            box,
            start=start_angle + t0 * sweep,
            end=start_angle + t1 * sweep,
            fill=color,
            width=stroke,
        )

    # 圆头端点
    cap_radius = stroke / 2
    for t, color in [
        (0.0, (107, 164, 255, 255)),
        (1.0, (61, 123, 245, 255)),
    ]:
        angle = math.radians(start_angle + t * sweep)
        x = center + radius * math.cos(angle)
        y = center + radius * math.sin(angle)
        draw.ellipse(
            [x - cap_radius, y - cap_radius, x + cap_radius, y + cap_radius],
            fill=color,
        )

    image = image.resize((168, 168), Image.LANCZOS)
    image.save(target, "PNG", optimize=True)
    print(f"ring_28.png  {target.stat().st_size / 1024:.0f}KB")


def main() -> None:
    if not SRC_DIR.exists():
        sys.exit(f"素材目录不存在：{SRC_DIR}")
    DST_DIR.mkdir(parents=True, exist_ok=True)

    for name in BACKGROUNDS:
        source = SRC_DIR / f"{name}.png"
        if name in DESIGN_BACKGROUNDS:
            design_source = DESIGN_DIR / DESIGN_BACKGROUNDS[name]
            if design_source.exists():
                source = design_source
        if not source.exists():
            print(f"跳过（缺失）：{source.name}")
            continue
        image = Image.open(source).convert("RGB")
        target = DST_DIR / f"{name}.webp"
        image.save(target, "WEBP", quality=78, method=6)
        print(f"{source.name} -> {name}.webp  {target.stat().st_size / 1024:.0f}KB")

    for name in SMALL_PNGS:
        source = SRC_DIR / f"{name}.png"
        if not source.exists():
            print(f"跳过（缺失）：{source.name}")
            continue
        image = Image.open(source)
        target = DST_DIR / f"{name}.png"
        image.save(target, "PNG", optimize=True)
        print(f"{name}.png  {target.stat().st_size / 1024:.0f}KB")

    generate_cloud_ring(DST_DIR / "ring_28.png")

    total = sum(p.stat().st_size for p in DST_DIR.iterdir() if p.is_file())
    print(f"资源合计 {total / 1024:.0f}KB -> {DST_DIR}")


if __name__ == "__main__":
    main()
