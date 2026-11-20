<template>
  <view class="gnb">
    <view class="gnb-row">
      <view
        v-for="(item, i) in items"
        :key="item.label"
        class="gnb-item"
        @tap="select(i)"
      >
        <app-icon
          :name="item.icon"
          :size="27"
          :color="i === active ? '#4A87F8' : '#99A3B9'"
        />
        <text class="gnb-label" :class="{ 'gnb-label-active': i === active }">
          {{ item.label }}
        </text>
        <view class="gnb-indicator" :class="{ 'gnb-indicator-active': i === active }" />
      </view>
    </view>
  </view>
</template>

<script setup lang="ts">
import { switchTab } from "@/utils/router";

const props = defineProps<{ active: number }>();

const items = [
  { label: "首页", icon: "home_rounded", path: "/pages/home/index" },
  { label: "分类", icon: "grid_view_rounded", path: "/pages/category/index" },
  { label: "日程", icon: "calendar_month_rounded", path: "/pages/schedule/index" },
  { label: "我的", icon: "person_rounded", path: "/pages/profile/index" },
];

const select = (index: number) => {
  if (index === props.active) return;
  switchTab(index);
};
</script>

<style lang="scss">
/* 底部 4 Tab 毛玻璃导航栏（对应 GlassNavBar） */
.gnb {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 30;
  overflow: hidden;
  border-top-left-radius: $radius-nav-top;
  border-top-right-radius: $radius-nav-top;
  background-color: rgba(255, 255, 255, 0.74);
  border-top: 1px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 dp(-6) dp(18) rgba(92, 122, 190, 0.08);
  padding-bottom: env(safe-area-inset-bottom);
  @include backdrop-blur(20);
}

.gnb-row {
  display: flex;
  height: dp(68);
}

.gnb-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.gnb-label {
  margin-top: dp(3);
  font-size: dp(12);
  line-height: 1;
  font-weight: 500;
  color: $nav-inactive;
}

.gnb-label-active {
  font-weight: 700;
  color: $primary;
}

.gnb-indicator {
  margin-top: dp(5);
  width: dp(20);
  height: dp(3);
  border-radius: dp(2);
  background-color: transparent;
}

.gnb-indicator-active {
  background-color: $primary;
}
</style>
