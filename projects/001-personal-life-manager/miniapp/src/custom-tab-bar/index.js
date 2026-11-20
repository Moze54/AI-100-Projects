const TAB_ROUTES = [
  "/pages/home/index",
  "/pages/category/index",
  "/pages/schedule/index",
  "/pages/profile/index",
];

Component({
  data: {
    active: 0,
    items: [
      { label: "首页", icon: String.fromCodePoint(0xf7f5) },
      { label: "分类", icon: String.fromCodePoint(0xf7c4) },
      { label: "日程", icon: String.fromCodePoint(0xf06c8) },
      { label: "我的", icon: String.fromCodePoint(0xf0071) },
    ],
  },

  lifetimes: {
    attached() {
      const pages = getCurrentPages();
      const page = pages[pages.length - 1];
      const route = page && page.route ? "/" + page.route : "";
      const index = TAB_ROUTES.indexOf(route);
      if (index >= 0) this.setData({ active: index });
    },
  },

  methods: {
    onTap(e) {
      const index = Number(e.currentTarget.dataset.index);
      if (index === this.data.active) return;
      wx.switchTab({ url: TAB_ROUTES[index] });
    },
  },
});
