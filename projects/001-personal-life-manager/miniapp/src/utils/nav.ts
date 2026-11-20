import { DESIGN_WIDTH } from "./layout";

export interface NavMetrics {
  /** 状态栏高度（px） */
  statusBarHeight: number;
  /** 页面内容起始 y（px）：状态栏 + 8px */
  headerTop: number;
  /** 顶栏右侧需要额外预留的胶囊间距（px），仅微信小程序非 0 */
  capsuleInset: number;
}

let cached: NavMetrics | null = null;

/**
 * 读取导航区尺寸。
 * 微信小程序使用自定义导航栏，必须给右上角胶囊让出空间；
 * H5 / 抖音等平台暂不预留，后续在对应平台分支补充。
 */
export function getNavMetrics(): NavMetrics {
  if (cached) return cached;

  const info = uni.getSystemInfoSync();
  const width = info.windowWidth || info.screenWidth || 375;
  let statusBarHeight = info.statusBarHeight || 0;
  let headerGap = 8;

  // #ifdef H5
  // H5 浏览器没有系统状态栏，按 iPhone X 的 44px 模拟，
  // 保证浏览器预览与设计图的布局基线一致（背景图按整屏铺满）。
  if (!statusBarHeight) statusBarHeight = 44;
  headerGap = 4;
  // #endif

  let capsuleInset = 0;

  // #ifdef MP-WEIXIN
  const wxApi = (globalThis as unknown as { wx?: any }).wx;
  try {
    const rect = wxApi?.getMenuButtonBoundingClientRect?.();
    if (rect && rect.left) {
      const pagePadding = 20 * (width / DESIGN_WIDTH);
      capsuleInset = Math.max(0, width - rect.left + 8 - pagePadding);
    }
  } catch (error) {
    capsuleInset = 0;
  }
  // #endif

  cached = {
    statusBarHeight,
    headerTop: statusBarHeight + headerGap,
    capsuleInset,
  };
  return cached;
}
