/** 底部 4 Tab 页面路径（顺序与 GlassNavBar 一致） */
export const TAB_PAGES = [
  "/pages/home/index",
  "/pages/category/index",
  "/pages/schedule/index",
  "/pages/profile/index",
] as const;

/**
 * 子页面路由登记表。
 * 后续批次每移植完一页，把 key 加入 PORTED，所有入口就会自动跳转到真实页面。
 */
const ROUTES: Record<string, string> = {
  addRecord: "/pages/add-record/index",
  detail: "/pages/detail/index",
  search: "/pages/search/index",
  vault: "/pages/vault/index",
  health: "/pages/health/index",
  healthDetail: "/pages/health-detail/index",
  assets: "/pages/assets/index",
  assetDetail: "/pages/asset-detail/index",
  calendar: "/pages/calendar/index",
  anniversary: "/pages/anniversary/index",
  todos: "/pages/todos/index",
  recurring: "/pages/recurring/index",
  subscriptions: "/pages/subscriptions/index",
  favorites: "/pages/favorites/index",
  trash: "/pages/trash/index",
  notifications: "/pages/notifications/index",
  notifySettings: "/pages/notify-settings/index",
  settings: "/pages/settings/index",
  storage: "/pages/storage/index",
  devices: "/pages/devices/index",
  security: "/pages/security/index",
  sync: "/pages/sync/index",
  backup: "/pages/backup/index",
  feedback: "/pages/feedback/index",
  about: "/pages/about/index",
  help: "/pages/help/index",
  privacy: "/pages/privacy/index",
  login: "/pages/login/index",
  tags: "/pages/tags/index",
  categories: "/pages/categories/index",
};

/** 已移植完成的页面 key；未加入的入口统一进入占位页 */
const PORTED = new Set<string>();

export function isPorted(key: string): boolean {
  return PORTED.has(key);
}

/** 跳转子页面：已移植则进真实页面，否则进占位页 */
export function go(key: string, title: string): void {
  const path = ROUTES[key];
  if (path && PORTED.has(key)) {
    uni.navigateTo({ url: path });
    return;
  }
  uni.navigateTo({
    url: `/pages/placeholder/index?title=${encodeURIComponent(title)}`,
  });
}

/** 切换底部 Tab */
export function switchTab(index: number): void {
  const url = TAB_PAGES[index];
  if (!url) return;
  uni.switchTab({ url });
}
