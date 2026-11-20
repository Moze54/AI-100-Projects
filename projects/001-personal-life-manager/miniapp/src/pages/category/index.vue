<template>
  <view class="page">
    <bg-layer src="/static/images/bg_category.webp" />

    <view class="page-body" :style="bodyStyle">
      <page-header
        subtitle="收藏生活 · 记录美好"
        :capsule-inset="nav.capsuleInset"
        @search="openSearch"
        @settings="openSettings"
      />

      <view class="gap-121" />

      <!-- 资料统计 -->
      <glass-card pad="16 4" :alpha="0.64">
        <view class="stats">
          <template v-for="(item, index) in stats" :key="item.label">
            <view v-if="index > 0" class="stats-divider" />
            <view class="stats-item">
              <view class="stats-icon">
                <app-icon :name="item.icon" :size="15" color="#FFFFFF" />
              </view>
              <text class="stats-value">{{ item.value }}</text>
              <text class="stats-label">{{ item.label }}</text>
            </view>
          </template>
        </view>
      </glass-card>

      <view class="gap-12" />

      <!-- 搜索框 -->
      <glass-card :radius="17" pad="0 16" :alpha="0.64">
        <view class="search" @tap="openSearch">
          <app-icon name="search_rounded" :size="20" color="#8A94B8" />
          <text class="search-placeholder">搜索我的资料...</text>
          <app-icon name="tune_rounded" :size="20" color="#1B2D55" />
        </view>
      </glass-card>

      <view class="gap-10" />

      <!-- 分类入口 2x3 -->
      <view class="cat-grid">
        <view
          v-for="(item, index) in categories"
          :key="item.title"
          class="cat-cell"
          :class="{ 'cat-cell-last-row': index >= 4 }"
        >
          <glass-card :tint="item.tint" pad="0 16" fill class="cat-card">
            <view class="cat-inner">
              <gradient-icon-box
                :icon="item.icon"
                :gradient="item.gradient"
                :size="32"
                :icon-size="16"
                :radius="10"
              />
              <view class="cat-main">
                <text class="cat-title">{{ item.title }}</text>
                <text class="cat-sub">{{ item.subtitle }}</text>
              </view>
              <app-icon name="chevron_right_rounded" :size="16" color="#B9C4DE" />
            </view>
          </glass-card>
        </view>
      </view>

      <view class="gap-16" />

      <!-- 最近浏览 -->
      <glass-card pad="15" :alpha="0.68" class="recent-card">
        <section-header
          icon="schedule_rounded"
          icon-color="#4A87F8"
          icon-bg="#E3EEFF"
          title="最近浏览"
          trailing="查看更多"
          shape="circle"
        />
        <view class="recent-gap" />
        <record-tile
          compact
          thumb="/static/images/thumb_sea.png"
          title="旅行照片"
          subtitle="今天 09:12 · 图片"
          @tap="openDetail"
        />
        <view class="tile-divider" />
        <record-tile
          compact
          thumb="/static/images/thumb_doc.png"
          title="租房合同"
          subtitle="昨天 21:30 · 文件"
        />
        <view class="tile-divider" />
        <record-tile
          compact
          thumb="/static/images/thumb_cat.png"
          title="小猫的疫苗记录"
          subtitle="4月27日 · 生活"
        />
      </glass-card>
    </view>

    <add-fab @tap="openAdd" />
    <!-- #ifndef MP-WEIXIN -->
    <glass-nav-bar :active="1" />
    <!-- #endif -->
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { getNavMetrics } from "@/utils/nav";
import { go } from "@/utils/router";

import { useTabBarActive } from "@/utils/tabbar";

const nav = getNavMetrics();
useTabBarActive(1);
const bodyStyle = computed(() => `padding-top:${nav.headerTop}px;`);

const openSearch = () => go("search", "全局搜索");
const openSettings = () => go("settings", "设置");
const openAdd = () => go("addRecord", "新增记录");
const openDetail = () => go("detail", "资料详情");

const stats = [
  { icon: "description_rounded", value: "286", label: "全部资料" },
  { icon: "image_rounded", value: "128", label: "图片" },
  { icon: "folder_shared_rounded", value: "64", label: "文件" },
  { icon: "verified_user_rounded", value: "3", label: "重要资料" },
];

/* 分类卡：淡色渐变 + 高透白底（设计稿中每张卡片左上角带一点主题色） */
const catTint = (rgb: string) =>
  `linear-gradient(135deg, rgba(${rgb},0.20) 0%, rgba(${rgb},0.10) 48%, rgba(248,252,255,0.02) 82%), rgba(248,251,255,0.78)`;

const categories = [
  {
    title: "图片",
    subtitle: "共 128 张",
    icon: "image_rounded",
    gradient: "blue" as const,
    tint: catTint("74,135,248"),
  },
  {
    title: "文件",
    subtitle: "共 64 个",
    icon: "description_rounded",
    gradient: "purple" as const,
    tint: catTint("143,107,255"),
  },
  {
    title: "证件",
    subtitle: "共 42 项",
    icon: "badge_rounded",
    gradient: "green" as const,
    tint: catTint("61,187,122"),
  },
  {
    title: "重要资料",
    subtitle: "共 18 项",
    icon: "star_rounded",
    gradient: "orange" as const,
    tint: catTint("255,157,66"),
  },
  {
    title: "其他资料",
    subtitle: "共 34 项",
    icon: "category_rounded",
    gradient: "teal" as const,
    tint: catTint("47,184,168"),
  },
  {
    title: "回收站",
    subtitle: "保留 30 天",
    icon: "delete_rounded",
    gradient: "grey" as const,
    tint: catTint("153,163,185"),
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
  padding: 0 dp(15) calc(#{dp(40)} + env(safe-area-inset-bottom));
}

.gap-121 {
  height: dp(112);
}

.gap-12 {
  height: dp(15);
}

.gap-10 {
  height: dp(17.5);
}

.gap-16 {
  height: dp(7);
}

/* ---------- 资料统计 ---------- */
.stats {
  display: flex;
  align-items: center;
}

.stats-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.stats-divider {
  width: 1px;
  height: dp(40);
  background-color: rgba(255, 255, 255, 0.9);
}

.stats-icon {
  width: dp(28);
  height: dp(28);
  border-radius: dp(9);
  background: $grad-blue;
  box-shadow: 0 dp(5) dp(12) rgba(61, 123, 245, 0.32);
  display: flex;
  align-items: center;
  justify-content: center;
}

.stats-value {
  margin-top: dp(3);
  font-size: dp(20);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.stats-label {
  margin-top: dp(2);
  font-size: dp(10.5);
  line-height: 1;
  color: $text-sub;
}

/* ---------- 搜索框 ---------- */
.search {
  height: dp(55);
  display: flex;
  align-items: center;
}

.search-placeholder {
  flex: 1;
  min-width: 0;
  margin-left: dp(12);
  font-size: dp(14);
  line-height: 1;
  color: $text-light;
  @include ellipsis(1);
}

/* ---------- 分类网格 ---------- */
.cat-grid {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

/* 卡宽 (396 - 9) / 2 = 193.5dp，高 55dp */
.cat-cell {
  width: calc((100% - #{dp(9)}) / 2);
  height: dp(55);
  margin-bottom: dp(8);
}

.cat-cell-last-row {
  margin-bottom: 0;
}

.cat-card {
  height: 100%;
}

.cat-inner {
  height: 100%;
  display: flex;
  align-items: center;
}

.cat-main {
  flex: 1;
  min-width: 0;
  margin-left: dp(20);
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.cat-title {
  display: block;
  font-size: dp(14);
  line-height: 1;
  font-weight: 700;
  color: $navy;
  @include ellipsis(1);
}

.cat-sub {
  display: block;
  margin-top: dp(4);
  font-size: dp(10.5);
  line-height: 1;
  color: $text-sub;
  @include ellipsis(1);
}

/* ---------- 最近浏览 ---------- */
.recent-gap {
  height: dp(3);
}

.tile-divider {
  height: 1px;
  margin-left: dp(66);
  margin-right: dp(4);
  background-color: $divider;
}
</style>
