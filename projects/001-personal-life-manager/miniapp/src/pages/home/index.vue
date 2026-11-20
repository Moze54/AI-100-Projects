<template>
  <view class="page">
    <bg-layer src="/static/images/bg_home.webp" />

    <view class="page-body" :style="bodyStyle">
      <page-header
        subtitle="珍藏生活 · 收藏美好"
        :capsule-inset="nav.capsuleInset"
        @search="openSearch"
        @settings="openSettings"
      />

      <view class="gap-144" />

      <!-- 今日概览 -->
      <glass-card pad="14 16" :alpha="0.56">
        <view class="today-head">
          <gradient-icon-box
            icon="calendar_month_rounded"
            gradient="blue"
            :size="20"
            :icon-size="12"
            :radius="6"
          />
          <text class="today-title">今日 · 周二 4月29日</text>
          <view class="spacer" />
          <text class="today-more">查看全部</text>
          <app-icon name="chevron_right_rounded" :size="16" color="#B9C4DE" />
        </view>

        <view class="today-stats">
          <view class="stat">
            <text class="stat-value">3</text>
            <view class="stat-label-row">
              <view class="stat-dot" style="background-color: #5b9bf8" />
              <text class="stat-label">待办事项</text>
            </view>
          </view>
          <view class="stat-divider" />
          <view class="stat">
            <text class="stat-value">1</text>
            <view class="stat-label-row">
              <view class="stat-dot" style="background-color: #ff8fb0" />
              <text class="stat-label">纪念日</text>
            </view>
          </view>
          <view class="stat-divider" />
          <view class="cloud">
            <view class="ring">
              <image class="ring-img" src="/static/images/ring_28.png" mode="aspectFit" />
              <view class="ring-core">
                <app-icon name="cloud_rounded" :size="20" color="#4A87F8" />
              </view>
            </view>
            <view class="cloud-info">
              <text class="cloud-percent">28%</text>
              <text class="cloud-label">云空间</text>
              <text class="cloud-size">(42GB / 150GB)</text>
            </view>
          </view>
        </view>
      </glass-card>

      <view class="gap-16" />

      <!-- 2x2 快捷入口 -->
      <view class="quick-grid">
        <view
          v-for="(item, index) in quickItems"
          :key="item.title"
          class="quick-cell"
          :class="{ 'quick-cell-last-row': index >= 2 }"
        >
          <glass-card pad="0 20" :alpha="0.56" fill class="quick-card">
            <view class="quick-inner" @tap="item.action">
              <gradient-icon-box
                :icon="item.icon"
                :gradient="item.gradient"
                :size="36"
                :icon-size="18"
                :radius="10"
              />
              <view class="quick-main">
                <text class="quick-title">{{ item.title }}</text>
                <text class="quick-sub">{{ item.subtitle }}</text>
              </view>
              <app-icon name="chevron_right_rounded" :size="15" color="#B9C4DE" />
            </view>
          </glass-card>
        </view>
      </view>

      <view class="gap-18" />

      <!-- 最近记录 -->
      <glass-card pad="14 15" :alpha="0.60">
        <section-header
          icon="schedule_rounded"
          icon-color="#4A87F8"
          icon-bg="#E3EEFF"
          title="最近记录"
          trailing="更多"
          shape="circle"
        />
        <view class="recent-gap" />
        <record-tile
          thumb="/static/images/thumb_sea.png"
          title="旅行照片"
          subtitle="今天 09:12 · 图片"
          title-icon="image_rounded"
          title-icon-color="#4A87F8"
          @tap="openDetail"
        />
        <view class="tile-divider" />
        <record-tile
          thumb="/static/images/thumb_doc.png"
          title="租房合同"
          subtitle="昨天 21:30 · 文件"
          title-icon="description_rounded"
          title-icon-color="#4A87F8"
          @tap="openDetail"
        />
        <view class="tile-divider" />
        <record-tile
          thumb="/static/images/thumb_cat.png"
          title="小猫的疫苗记录"
          subtitle="4月27日 · 生活"
          title-icon="favorite_rounded"
          title-icon-color="#F5484E"
          @tap="openDetail"
        />
      </glass-card>
    </view>

    <add-fab @tap="openAdd" />
    <!-- #ifndef MP-WEIXIN -->
    <glass-nav-bar :active="0" />
    <!-- #endif -->
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { getNavMetrics } from "@/utils/nav";
import { go } from "@/utils/router";

import { useTabBarActive } from "@/utils/tabbar";

const nav = getNavMetrics();
useTabBarActive(0);
const bodyStyle = computed(
  () => `padding-top:${nav.headerTop}px;`,
);

const openSearch = () => go("search", "全局搜索");
const openSettings = () => go("settings", "设置");
const openAdd = () => go("addRecord", "新增记录");
const openDetail = () => go("detail", "资料详情");

const quickItems = [
  {
    title: "新增记录",
    subtitle: "记录重要的事",
    icon: "add_rounded",
    gradient: "blue" as const,
    action: openAdd,
  },
  {
    title: "上传文件",
    subtitle: "保存重要文件",
    icon: "folder_rounded",
    gradient: "purple" as const,
    action: openAdd,
  },
  {
    title: "保险箱",
    subtitle: "加密私密内容",
    icon: "shield_rounded",
    gradient: "teal" as const,
    action: () => go("vault", "保险箱"),
  },
  {
    title: "健康记录",
    subtitle: "关注身体健康",
    icon: "favorite_rounded",
    gradient: "orange" as const,
    action: () => go("health", "健康记录"),
  },
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
  padding: 0 dp(15) calc(#{dp(110)} + env(safe-area-inset-bottom));
}

.gap-144 {
  height: dp(134);
}

.gap-16 {
  height: dp(20);
}

.gap-18 {
  height: dp(15);
}

.spacer {
  flex: 1;
}

/* ---------- 今日概览 ---------- */
.today-head {
  display: flex;
  align-items: center;
}

.today-title {
  margin-left: dp(6);
  font-size: dp(16);
  line-height: 1;
  font-weight: 700;
  color: $navy;
}

.today-more {
  font-size: dp(12);
  color: $text-sub;
}

.today-stats {
  margin-top: dp(19);
  display: flex;
  align-items: center;
  justify-content: center;
}

.stat {
  width: dp(74);
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stat-value {
  font-size: dp(28);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.stat-label-row {
  margin-top: dp(6);
  display: flex;
  align-items: center;
}

.stat-dot {
  width: dp(6);
  height: dp(6);
  border-radius: 50%;
}

.stat-label {
  margin-left: dp(6);
  font-size: dp(11);
  line-height: 1;
  color: $text-sub;
}

.stat-divider {
  width: 1px;
  height: dp(42);
  margin: 0 dp(10);
  background-color: rgba(255, 255, 255, 0.9);
}

.cloud {
  width: dp(162);
  display: flex;
  align-items: center;
}

.ring {
  position: relative;
  width: dp(60);
  height: dp(60);
  flex-shrink: 0;
}

.ring-img {
  width: dp(60);
  height: dp(60);
}

.ring-core {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  width: dp(28);
  height: dp(28);
  border-radius: 50%;
  background: transparent;
  display: flex;
  align-items: center;
  justify-content: center;
}

.cloud-info {
  margin-left: dp(10);
  min-width: 0;
}

.cloud-percent {
  display: block;
  font-size: dp(24);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.cloud-label {
  display: block;
  margin-top: dp(4);
  font-size: dp(12);
  line-height: 1;
  color: $text-sub;
}

.cloud-size {
  display: block;
  margin-top: dp(2);
  font-size: dp(10);
  line-height: 1;
  color: $text-light;
}

/* ---------- 快捷入口 ---------- */
.quick-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

/* 卡宽 (396 - 10) / 2 = 193dp，高 69dp */
.quick-cell {
  width: calc((100% - #{dp(10)}) / 2);
  height: dp(69);
  margin-bottom: dp(10);
}

.quick-cell-last-row {
  margin-bottom: 0;
}

.quick-card {
  height: 100%;
}

.quick-inner {
  height: 100%;
  display: flex;
  align-items: center;
}

.quick-main {
  flex: 1;
  min-width: 0;
  margin-left: dp(19);
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.quick-title {
  display: block;
  font-size: dp(14);
  line-height: 1;
  font-weight: 700;
  color: $navy;
  @include ellipsis(1);
}

.quick-sub {
  display: block;
  margin-top: dp(5);
  font-size: dp(10.5);
  line-height: 1;
  color: $text-sub;
  @include ellipsis(1);
}

/* ---------- 最近记录 ---------- */
.recent-gap {
  height: dp(8);
}

.tile-divider {
  height: 1px;
  margin-left: dp(66);
  margin-right: dp(4);
  background-color: $divider;
}
</style>
