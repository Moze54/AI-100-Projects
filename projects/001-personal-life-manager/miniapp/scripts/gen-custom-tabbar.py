"""生成微信原生 custom-tab-bar 的 WXSS（内嵌图标字体子集）。

微信要求 tabBar.custom=true 时存在原生 custom-tab-bar 组件；该组件不在
uni-app 的 Vue 编译链路内，因此样式与图标字体需要单独生成。
运行：python scripts/gen-custom-tabbar.py
"""

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
font_scss = (ROOT / "src/components/app-icon/icon-font.scss").read_text(encoding="utf-8")
match = re.search(r'src:\s*(url\("data:font/woff2;base64,[A-Za-z0-9+/=]+"\)\s*format\("woff2"\));', font_scss)
if not match:
    raise SystemExit("未在 icon-font.scss 中找到 WOFF2 字体数据")
font_src = match.group(1)

DP = 750 / 426


def rpx(value: float) -> str:
    return f"{value * DP:.2f}"


wxss = f'''/* 由 scripts/gen-custom-tabbar.py 生成，请勿手改。 */
@font-face {{
  font-family: "shiji-icons";
  font-weight: normal;
  font-style: normal;
  font-display: block;
  src: {font_src};
}}

.gnb {{
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 30;
  overflow: hidden;
  border-top-left-radius: {rpx(28)}rpx;
  border-top-right-radius: {rpx(28)}rpx;
  background-color: rgba(255, 255, 255, 0.74);
  border-top: 1px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 -6px 18px rgba(92, 122, 190, 0.08);
  padding-bottom: env(safe-area-inset-bottom);
  -webkit-backdrop-filter: blur(20px);
  backdrop-filter: blur(20px);
}}

.gnb-row {{
  display: flex;
  height: {rpx(52)}rpx;
}}

.gnb-item {{
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}}

.gnb-icon {{
  font-family: "shiji-icons";
  font-style: normal;
  font-weight: normal;
  line-height: 1;
  display: inline-block;
  vertical-align: middle;
  -webkit-font-smoothing: antialiased;
  font-size: {rpx(27)}rpx;
  color: #99a3b9;
}}

.gnb-icon-active {{
  color: #4a87f8;
}}

.gnb-label {{
  margin-top: {rpx(3)}rpx;
  font-size: {rpx(12)}rpx;
  line-height: 1;
  font-weight: 500;
  color: #99a3b9;
}}

.gnb-label-active {{
  font-weight: 700;
  color: #4a87f8;
}}

.gnb-indicator {{
  margin-top: {rpx(5)}rpx;
  width: {rpx(20)}rpx;
  height: {rpx(3)}rpx;
  border-radius: {rpx(2)}rpx;
  background-color: transparent;
}}

.gnb-indicator-active {{
  background-color: #4a87f8;
}}
'''

out = ROOT / "src/custom-tab-bar/index.wxss"
out.write_text(wxss, encoding="utf-8")
print(f"输出：{out}")
print(f"字体 base64 {len(font_src)} 字符，WXSS {len(wxss)} 字符")
