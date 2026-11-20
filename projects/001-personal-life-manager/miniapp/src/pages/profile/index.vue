<template>
  <view class="page">
    <bg-layer src="/static/images/bg_profile.webp" />

    <view class="page-body" :style="bodyStyle">
      <view class="top-actions" :style="capsuleStyle">
        <glass-icon-btn
          icon="notifications_rounded"
          show-red-dot
          @tap="openNotifications"
        />
        <view class="top-gap" />
        <glass-icon-btn icon="settings_rounded" @tap="openSettings" />
      </view>

      <view class="gap-14" />

      <!-- 用户信息 -->
      <view class="profile-row">
        <view class="avatar">
          <image class="avatar-img" src="/static/images/avatar.png" mode="aspectFill" />
        </view>
        <view class="profile-main">
          <view class="profile-name-row">
            <text class="profile-name">拾记用户</text>
            <view class="profile-chevron">
              <app-icon name="chevron_right_rounded" :size="18" color="#1B2D55" />
            </view>
          </view>
          <text class="profile-sub">记录生活，收藏美好</text>
        </view>
      </view>

      <view class="gap-16" />

      <!-- 高级会员 -->
      <view class="vip">
        <app-icon
          class="vip-icon"
          name="workspace_premium_rounded"
          :size="26"
          color="#E8A23D"
        />
        <view class="vip-main">
          <text class="vip-title">高级会员</text>
          <text class="vip-sub">尊享更多专属功能</text>
        </view>
        <view class="vip-btn">
          <text class="vip-btn-text">立即开通</text>
          <app-icon name="chevron_right_rounded" :size="14" color="#C87F2B" />
        </view>
      </view>

      <view class="gap-135" />

      <!-- 云空间 -->
      <glass-card pad="9 14" :alpha="0.88">
        <view class="cloud">
          <view class="cloud-icon">
            <app-icon name="cloud_rounded" :size="34" color="#6BA4FF" />
          </view>
          <view class="cloud-main">
            <text class="cloud-title">云空间使用情况</text>
            <text class="cloud-size">128 MB / 10 GB</text>
            <view class="progress">
              <view class="progress-fill" />
            </view>
          </view>
          <view class="cloud-btn" @tap="openStorage">
            <text class="cloud-btn-text">管理空间</text>
            <app-icon name="chevron_right_rounded" :size="14" color="#FFFFFF" />
          </view>
        </view>
      </glass-card>

      <view class="gap-18" />

      <!-- 功能宫格 -->
      <glass-card pad="0 6" :alpha="0.88">
        <view v-for="(row, rowIndex) in menuRows" :key="rowIndex" class="menu-row">
          <template v-for="(item, colIndex) in row" :key="item.label">
            <view v-if="colIndex > 0" class="menu-vdiv" />
            <view class="menu-cell" @tap="item.action">
              <gradient-icon-box
                :icon="item.icon"
                :gradient="item.gradient"
                :size="36"
                :icon-size="18"
              />
              <text class="menu-label">{{ item.label }}</text>
            </view>
          </template>
        </view>
      </glass-card>

      <view class="gap-5" />

      <!-- 设置列表 -->
      <glass-card pad="0 16" :alpha="0.88">
        <template v-for="(item, index) in settingsItems" :key="item.label">
          <view v-if="index > 0" class="settings-divider-indent" />
          <view class="settings-row" @tap="item.action">
            <view class="settings-icon">
              <app-icon :name="item.icon" :size="22" color="#4A87F8" />
            </view>
            <text class="settings-label">{{ item.label }}</text>
            <view class="settings-spacer" />
            <text v-if="item.trailing" class="settings-trailing">{{ item.trailing }}</text>
            <view class="settings-chevron">
              <app-icon name="chevron_right_rounded" :size="18" color="#B9C4DE" />
            </view>
          </view>
        </template>
      </glass-card>

      <view class="gap-22" />

      <!-- 退出登录（设计图：设置卡下方独立按钮） -->
      <view class="logout-wrap" @tap="openLogin">
        <glass-card
          pad="0"
          :radius="26"
          fill
          elevated
          class="logout-btn"
          tint="linear-gradient(135deg, rgba(255,255,255,0.98) 0%, rgba(220,234,255,0.96) 100%)"
        >
          <view class="logout-inner">
            <app-icon name="logout_rounded" :size="20" color="#4A87F8" />
            <text class="logout-btn-text">退出登录</text>
          </view>
        </glass-card>
      </view>
    </view>

    <!-- #ifndef MP-WEIXIN -->
    <glass-nav-bar :active="3" />
    <!-- #endif -->
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { getNavMetrics } from "@/utils/nav";
import { go } from "@/utils/router";

import { useTabBarActive } from "@/utils/tabbar";

const nav = getNavMetrics();
useTabBarActive(3);
const bodyStyle = computed(() => `padding-top:${nav.headerTop}px;`);
const capsuleStyle = computed(() =>
  nav.capsuleInset > 0 ? `padding-right:${nav.capsuleInset}px;` : "",
);

const openNotifications = () => go("notifications", "通知中心");
const openSettings = () => go("settings", "设置");
const openStorage = () => go("storage", "存储空间");
const openLogin = () => go("login", "登录");

const menuRows = [
  [
    { label: "保险箱", icon: "lock_rounded", gradient: "blue" as const, action: () => go("vault", "保险箱") },
    { label: "健康记录", icon: "monitor_heart_rounded", gradient: "pink" as const, action: () => go("health", "健康记录") },
    { label: "生活资产", icon: "cottage_rounded", gradient: "orange" as const, action: () => go("assets", "生活资产") },
  ],
  [
    { label: "我的日程", icon: "calendar_month_rounded", gradient: "purple" as const, action: () => go("calendar", "日历") },
    { label: "我的收藏", icon: "star_rounded", gradient: "green" as const, action: () => go("favorites", "我的收藏") },
    { label: "回收站", icon: "delete_outline_rounded", gradient: "grey" as const, action: () => go("trash", "回收站") },
  ],
];

const settingsItems = [
  { label: "设备管理", trailing: "2 台设备", icon: "computer_rounded", action: () => go("devices", "设备管理") },
  { label: "数据安全", trailing: "", icon: "verified_user_rounded", action: () => go("security", "数据安全") },
  { label: "同步管理", trailing: "已开启", icon: "cloud_sync_rounded", action: () => go("sync", "同步管理") },
  { label: "意见反馈", trailing: "", icon: "question_answer_rounded", action: () => go("feedback", "意见反馈") },
  { label: "关于拾记", trailing: "v1.0.0", icon: "info_rounded", action: () => go("about", "关于拾记") },
];
</script>

<style lang="scss">
.page {
  position: relative;
  min-height: 100vh;
}

.page-body {
  position: relative;
  z-index: 1;
  padding: 0 dp(15) calc(#{dp(130)} + env(safe-area-inset-bottom));
}

.gap-14 {
  height: 0;
}

.gap-16 {
  height: dp(31.5);
}

.gap-135 {
  height: dp(15);
}

.gap-18 {
  height: dp(22);
}

.gap-5 {
  height: dp(5);
}

.gap-22 {
  height: dp(22);
}

/* ---------- 顶部按钮 ---------- */
.top-actions {
  display: flex;
  justify-content: flex-end;
  margin-right: dp(-10);
}

.top-gap {
  width: dp(16);
  flex-shrink: 0;
}

/* ---------- 用户信息 ---------- */
.profile-row {
  display: flex;
  align-items: center;
}

.avatar {
  width: dp(50);
  height: dp(50);
  border-radius: 50%;
  border: 2px solid rgba(255, 255, 255, 0.9);
  box-shadow: 0 dp(6) dp(14) rgba(64, 107, 174, 0.13);
  overflow: hidden;
  flex-shrink: 0;
}

.avatar-img {
  width: 100%;
  height: 100%;
}

.profile-main {
  margin-left: dp(16);
  flex: 1;
  min-width: 0;
}

.profile-name-row {
  display: flex;
  align-items: center;
}

.profile-name {
  font-size: dp(19);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.profile-chevron {
  margin-left: dp(6);
  display: flex;
  align-items: center;
}

.profile-sub {
  display: block;
  margin-top: dp(6);
  font-size: dp(12);
  line-height: 1;
  color: #7a86a8;
}

/* ---------- 会员横幅 ---------- */
.vip {
  height: dp(60);
  padding: 0 dp(16);
  border-radius: dp(20);
  background: linear-gradient(
    160deg,
    rgba(252, 245, 237, 0.94) 0%,
    rgba(251, 238, 224, 0.93) 55%,
    rgba(249, 209, 167, 0.93) 82%,
    rgba(248, 200, 150, 0.94) 100%
  );
  border: 1px solid rgba(255, 255, 255, 0.82);
  box-shadow: 0 dp(6) dp(20) rgba(224, 166, 92, 0.10);
  display: flex;
  align-items: center;
}

.vip-icon {
  flex-shrink: 0;
  text-shadow: 0 dp(2) dp(6) rgba(232, 162, 61, 0.22);
}

.vip-main {
  margin-left: dp(10);
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.vip-title {
  display: block;
  font-size: dp(16);
  line-height: 1;
  font-weight: 800;
  color: #4a3826;
}

.vip-sub {
  display: block;
  margin-top: dp(5);
  font-size: dp(11);
  line-height: 1;
  color: #b08050;
}

.vip-btn {
  height: dp(28);
  padding: 0 dp(12);
  border-radius: dp(14);
  background: linear-gradient(180deg, rgba(255, 248, 238, 0.92) 0%, rgba(252, 227, 198, 0.92) 100%);
  border: 1px solid rgba(255, 255, 255, 0.85);
  display: flex;
  align-items: center;
  flex-shrink: 0;
}

.vip-btn-text {
  font-size: dp(12);
  line-height: 1;
  font-weight: 700;
  color: #a4692a;
}

/* ---------- 云空间 ---------- */
.cloud {
  display: flex;
  align-items: center;
}

.cloud-icon {
  width: dp(36);
  height: dp(36);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  text-shadow: 0 dp(6) dp(14) rgba(74, 135, 248, 0.35);
}

.cloud-main {
  margin-left: dp(12);
  flex: 1;
  min-width: 0;
}

.cloud-title {
  display: block;
  font-size: dp(15);
  line-height: 1;
  font-weight: 700;
  color: $navy;
}

.cloud-size {
  display: block;
  margin-top: dp(5);
  font-size: dp(12);
  line-height: 1;
  color: $text-sub;
}

.progress {
  margin-top: dp(9);
  height: dp(5);
  border-radius: dp(3);
  background-color: rgba(255, 255, 255, 0.75);
  overflow: hidden;
}

.progress-fill {
  width: 1.28%;
  height: 100%;
  border-radius: dp(3);
  background: $grad-blue;
}

.cloud-btn {
  margin-left: dp(8);
  height: dp(28);
  padding: 0 dp(12);
  border-radius: dp(14);
  background: $grad-blue;
  box-shadow: 0 dp(5) dp(12) rgba(61, 123, 245, 0.28);
  display: flex;
  align-items: center;
  flex-shrink: 0;
}

.cloud-btn-text {
  font-size: dp(12);
  line-height: 1;
  font-weight: 700;
  color: #ffffff;
}

/* ---------- 功能宫格 ---------- */
.menu-row {
  display: flex;
  align-items: center;
  height: dp(82);
}

.menu-row + .menu-row {
  border-top: 1px solid $divider;
}

.menu-cell {
  flex: 1;
  min-width: 0;
  display: flex;
  flex-direction: column;
  align-items: center;
  padding: dp(6) 0;
}

.menu-label {
  margin-top: dp(6);
  font-size: dp(12);
  line-height: 1;
  font-weight: 600;
  color: #44507a;
}

.menu-vdiv {
  width: 1px;
  height: dp(44);
  background-color: $divider;
  flex-shrink: 0;
}

/* ---------- 设置列表 ---------- */
.settings-divider-indent {
  height: 1px;
  margin-left: dp(38);
  background-color: $divider;
}

.settings-row {
  height: dp(48);
  display: flex;
  align-items: center;
}

.settings-icon {
  width: dp(26);
  height: dp(26);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
  text-shadow: 0 dp(4) dp(9) rgba(74, 135, 248, 0.28);
}

.settings-label {
  margin-left: dp(12);
  font-size: dp(14.5);
  line-height: 1;
  font-weight: 600;
  color: $navy;
}

.settings-spacer {
  flex: 1;
}

.settings-trailing {
  font-size: dp(12);
  color: $text-sub;
}

.settings-chevron {
  margin-left: dp(3);
  display: flex;
  align-items: center;
}

/* ---------- 退出登录 ---------- */
.logout-btn {
  display: block;
}

.logout-inner {
  width: 100%;
  height: dp(52);
  display: flex;
  align-items: center;
  justify-content: center;
}

.logout-btn-text {
  margin-left: dp(6);
  font-size: dp(15);
  line-height: 1;
  font-weight: 600;
  color: $primary;
}
</style>
