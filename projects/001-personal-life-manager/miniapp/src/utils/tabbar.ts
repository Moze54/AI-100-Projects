import { onShow } from "@dcloudio/uni-app";

/**
 * 微信自定义 tabBar 高亮同步。
 * 微信的 custom-tab-bar 为原生组件，页面 onShow 时通过 getTabBar() 更新选中项；
 * 其他平台使用页面内自绘导航栏，无需处理。
 */
export function useTabBarActive(index: number) {
  // #ifdef MP-WEIXIN
  onShow(() => {
    const pages = getCurrentPages();
    const page = pages[pages.length - 1] as unknown as {
      getTabBar?: () => { setData: (data: { active: number }) => void } | undefined;
    };
    page?.getTabBar?.()?.setData({ active: index });
  });
  // #endif
}
