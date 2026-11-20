<template>
  <view class="page">
    <bg-layer src="/static/images/bg_schedule.webp" />

    <view class="page-body" :style="bodyStyle">
      <page-header
        subtitle="收藏生活 · 记录美好"
        :capsule-inset="nav.capsuleInset"
        @search="openSearch"
        @settings="openSettings"
      />

      <view class="gap-14" />

      <!-- 日期标题 -->
      <view class="date-title">
        <text class="date-text">4月29日</text>
        <view class="date-badge">
          <text class="date-week">周二</text>
          <app-icon name="expand_more_rounded" :size="14" color="#6E7BA8" />
        </view>
      </view>

      <view class="gap-86" />

      <!-- 周历条 -->
      <glass-card pad="8 6" :alpha="0.62">
        <view class="week">
          <app-icon name="chevron_left_rounded" :size="18" color="#C4CFE8" />
          <view class="week-days">
            <view v-for="day in days" :key="day.date" class="day">
              <text class="day-week">{{ day.week }}</text>
              <view class="day-box" :class="{ 'day-box-active': day.selected }">
                <text class="day-date" :class="{ 'day-date-active': day.selected }">
                  {{ day.date }}
                </text>
              </view>
              <view class="day-dot" :class="{ 'day-dot-active': day.selected }" />
              <text class="day-lunar">{{ day.lunar }}</text>
            </view>
          </view>
          <app-icon name="chevron_right_rounded" :size="18" color="#C4CFE8" />
        </view>
      </glass-card>

      <view class="gap-12" />

      <!-- 今日安排 -->
      <glass-card pad="24 14 12" :alpha="0.70">
        <section-header
          icon="calendar_month_rounded"
          icon-color="#4A87F8"
          icon-bg="#E3EEFF"
          title="今日安排"
          trailing="全部"
          @trailing="openCalendar"
        />
        <view class="plan-gap-16" />
        <view v-for="(plan, index) in plans" :key="plan.time" class="plan-row">
          <view class="plan-time">
            <text class="plan-clock">{{ plan.time }}</text>
            <view class="plan-until">
              <app-icon name="schedule_rounded" :size="11" color="#A6AFC9" />
              <text class="plan-until-text">{{ plan.until }}</text>
            </view>
          </view>
          <view class="plan-track">
            <view class="plan-dot" :style="{ backgroundColor: plan.lineColor }" />
            <view
              class="plan-rail"
              :style="{ backgroundColor: plan.lineFade }"
            />
          </view>
          <view class="plan-main">
            <text class="plan-title">{{ plan.title }}</text>
            <view class="plan-place">
              <app-icon name="place_rounded" :size="12" color="#8A94B8" />
              <text class="plan-place-text">{{ plan.place }}</text>
            </view>
          </view>
          <view class="plan-check" :class="{ 'plan-check-done': plan.done }">
            <app-icon
              v-if="plan.done"
              name="check_rounded"
              :size="16"
              color="#FFFFFF"
            />
          </view>
        </view>
      </glass-card>

      <view class="gap-10" />

      <!-- 纪念日 / 待办双卡 -->
      <view class="dual">
        <view class="dual-item" @tap="openAnniversary">
          <glass-card pad="13" :alpha="0.64" class="dual-card">
            <section-header
              compact
              icon="cake_rounded"
              icon-color="#FF8FB0"
              icon-bg="#FFEAF2"
              title="纪念日"
            />
            <view class="anniv-row">
              <image class="anniv-img" src="/static/images/cake.png" mode="aspectFill" />
              <view class="anniv-main">
                <text class="anniv-title">小猫的生日</text>
                <view class="anniv-count">
                  <text class="anniv-pre">还有</text>
                  <text class="anniv-days">26</text>
                  <text class="anniv-pre">天</text>
                </view>
              </view>
            </view>
          </glass-card>
        </view>
        <view class="dual-gap" />
        <view class="dual-item" @tap="openTodos">
          <glass-card pad="13" :alpha="0.64" class="dual-card">
            <section-header
              compact
              icon="verified_rounded"
              icon-color="#9C6BFF"
              icon-bg="#EFE9FF"
              title="待办事项"
            />
            <view class="todo-list">
              <view v-for="todo in todos" :key="todo.label" class="todo-row">
                <view class="todo-box" :class="{ 'todo-box-done': todo.done }">
                  <app-icon
                    v-if="todo.done"
                    name="check_rounded"
                    :size="13"
                    color="#FFFFFF"
                  />
                </view>
                <text class="todo-label" :class="{ 'todo-label-done': todo.done }">
                  {{ todo.label }}
                </text>
              </view>
            </view>
          </glass-card>
        </view>
      </view>

      <view class="gap-16" />

      <!-- 日程分类 -->
      <glass-card pad="10 14" :alpha="0.74" class="sc-card">
        <section-header
          icon="layers_rounded"
          icon-color="#4A87F8"
          icon-bg="#E3EEFF"
          title="日程分类"
        />
        <view class="sc-row">
          <view v-for="cat in scheduleCategories" :key="cat.label" class="sc-item">
            <gradient-icon-box
              :icon="cat.icon"
              :gradient="cat.gradient"
              :size="36"
              :icon-size="17"
              :radius="12"
            />
            <text class="sc-label" :class="{ 'sc-label-active': cat.active }">
              {{ cat.label }}
            </text>
            <view class="sc-indicator" :class="{ 'sc-indicator-active': cat.active }" />
          </view>
        </view>
      </glass-card>
    </view>

    <add-fab @tap="openAdd" />
    <!-- #ifndef MP-WEIXIN -->
    <glass-nav-bar :active="2" />
    <!-- #endif -->
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { getNavMetrics } from "@/utils/nav";
import { go } from "@/utils/router";

import { useTabBarActive } from "@/utils/tabbar";

const nav = getNavMetrics();
useTabBarActive(2);
const bodyStyle = computed(() => `padding-top:${nav.headerTop}px;`);

const openSearch = () => go("search", "全局搜索");
const openSettings = () => go("settings", "设置");
const openAdd = () => go("addRecord", "新增记录");
const openCalendar = () => go("calendar", "日历");
const openAnniversary = () => go("anniversary", "重要日期");
const openTodos = () => go("todos", "待办清单");

const days = [
  { week: "一", date: "28", lunar: "廿一", selected: false },
  { week: "二", date: "29", lunar: "廿二", selected: true },
  { week: "三", date: "30", lunar: "廿三", selected: false },
  { week: "四", date: "1", lunar: "廿四", selected: false },
  { week: "五", date: "2", lunar: "廿五", selected: false },
  { week: "六", date: "3", lunar: "廿六", selected: false },
  { week: "日", date: "4", lunar: "廿七", selected: false },
];

const plans = [
  {
    time: "09:30",
    until: "1小时后",
    title: "去银行办理业务",
    place: "银行网点",
    done: true,
    lineColor: "#6FA3FE",
    lineFade: "rgba(111, 163, 254, 0.45)",
  },
  {
    time: "19:00",
    until: "10小时后",
    title: "家庭聚餐",
    place: "家里",
    done: false,
    lineColor: "#66C79A",
    lineFade: "rgba(102, 199, 154, 0.45)",
  },
];

const todos = [
  { label: "整理房间", done: false },
  { label: "购买生活用品", done: false },
  { label: "阅读一本好书", done: true },
];

const scheduleCategories = [
  { label: "全部", icon: "calendar_month_rounded", gradient: "blue" as const, active: true },
  { label: "工作", icon: "work_rounded", gradient: "green" as const, active: false },
  { label: "生活", icon: "home_rounded", gradient: "orange" as const, active: false },
  { label: "健康", icon: "favorite_rounded", gradient: "purple" as const, active: false },
  { label: "出行", icon: "flight_takeoff_rounded", gradient: "teal" as const, active: false },
  { label: "其他", icon: "more_horiz_rounded", gradient: "grey" as const, active: false },
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

.gap-14 {
  height: dp(20);
}

.gap-86 {
  height: dp(77);
}

.gap-12 {
  height: dp(14);
}

.gap-10 {
  height: dp(13.5);
}

.gap-22 {
  height: dp(22);
}

.gap-16 {
  height: dp(10);
}

/* ---------- 日期标题 ---------- */
.date-title {
  display: flex;
  align-items: center;
}

.date-text {
  font-size: dp(26);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.date-badge {
  margin-left: dp(10);
  padding: dp(3) dp(7);
  border-radius: dp(12);
  background-color: rgba(255, 255, 255, 0.55);
  display: flex;
  align-items: center;
}

.date-week {
  font-size: dp(12);
  color: #6e7ba8;
}

/* ---------- 周历 ---------- */
.week {
  display: flex;
  align-items: center;
}

.week-days {
  flex: 1;
  min-width: 0;
  display: flex;
}

.day {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.day-week {
  font-size: dp(10);
  line-height: 1;
  color: $text-sub;
}

.day-box {
  margin-top: dp(6);
  width: dp(28);
  height: dp(42);
  border-radius: dp(12);
  display: flex;
  align-items: center;
  justify-content: center;
}

.day-box-active {
  background: $grad-blue;
}

.day-date {
  font-size: dp(18);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.day-date-active {
  color: #ffffff;
}

.day-dot {
  margin-top: dp(4);
  width: dp(3.5);
  height: dp(3.5);
  border-radius: 50%;
  background-color: transparent;
}

.day-dot-active {
  background-color: $primary;
}

.day-lunar {
  margin-top: dp(2);
  font-size: dp(10);
  line-height: 1;
  color: $text-light;
}

/* ---------- 今日安排 ---------- */
.plan-gap-16 {
  height: dp(8);
}

.plan-row {
  display: flex;
  align-items: center;
  min-height: dp(52);
}

.plan-row + .plan-row {
  margin-top: dp(6);
  border-top: 1px solid rgba(227, 236, 249, 0.9);
}

.plan-time {
  width: dp(62);
  flex-shrink: 0;
}

.plan-clock {
  display: block;
  font-size: dp(16);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.plan-until {
  margin-top: dp(6);
  display: flex;
  align-items: center;
}

.plan-until-text {
  margin-left: dp(3);
  font-size: dp(11);
  line-height: 1;
  color: $text-light;
}

.plan-track {
  position: relative;
  width: dp(10);
  height: dp(34);
  margin-right: dp(14);
  flex-shrink: 0;
}

.plan-dot {
  position: absolute;
  left: 50%;
  top: dp(3);
  transform: translateX(-50%);
  width: dp(7);
  height: dp(7);
  border-radius: 50%;
}

.plan-rail {
  position: absolute;
  left: 50%;
  top: dp(13);
  bottom: dp(4);
  width: dp(2.5);
  transform: translateX(-50%);
  border-radius: dp(1.25);
}

.plan-main {
  flex: 1;
  min-width: 0;
}

.plan-title {
  display: block;
  font-size: dp(15);
  line-height: 1;
  font-weight: 700;
  color: $navy;
  @include ellipsis(1);
}

.plan-place {
  margin-top: dp(6);
  display: flex;
  align-items: center;
}

.plan-place-text {
  margin-left: dp(3);
  font-size: dp(12);
  line-height: 1;
  color: $text-sub;
}

.plan-check {
  width: dp(26);
  height: dp(26);
  border-radius: 50%;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  border: 2px solid #c9d4ea;
}

.plan-check-done {
  border: none;
  background-color: #6fa3fe;
}

/* ---------- 纪念日 / 待办 ---------- */
.dual {
  display: flex;
  align-items: stretch;
}

.dual-item {
  flex: 1;
  min-width: 0;
  height: dp(137.5);
}

.dual-card {
  height: 100%;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.dual-card .anniv-row,
.dual-card .todo-list {
  flex: 1;
  min-height: 0;
}

.dual-gap {
  width: dp(12);
  flex-shrink: 0;
}

.anniv-row {
  margin-top: dp(14);
  display: flex;
  align-items: center;
}

.anniv-img {
  width: dp(48);
  height: dp(48);
  border-radius: dp(10);
  flex-shrink: 0;
}

.anniv-main {
  margin-left: dp(8);
  flex: 1;
  min-width: 0;
}

.anniv-title {
  display: block;
  font-size: dp(13);
  line-height: 1;
  font-weight: 700;
  color: $navy;
  @include ellipsis(1);
}

.anniv-count {
  margin-top: dp(8);
  display: flex;
  align-items: flex-end;
}

.anniv-pre {
  font-size: dp(12);
  line-height: 1.2;
  color: $text-sub;
}

.anniv-days {
  margin: 0 dp(2);
  font-size: dp(22);
  line-height: 1;
  font-weight: 800;
  color: $red;
}

.todo-list {
  margin-top: dp(14);
}

.todo-row {
  padding: dp(4) 0;
  display: flex;
  align-items: center;
}

.todo-box {
  width: dp(18);
  height: dp(18);
  border-radius: dp(5);
  border: 1.5px solid #c9d4ea;
  background-color: #ffffff;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.todo-box-done {
  border: none;
  background-color: #c9cfe0;
}

.todo-label {
  margin-left: dp(8);
  font-size: dp(13);
  line-height: 1;
  color: $navy;
  @include ellipsis(1);
}

.todo-label-done {
  color: #b0bacc;
  text-decoration: line-through;
}

/* ---------- 日程分类 ---------- */
.sc-card {
  height: dp(131);
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
}

.sc-row {
  flex: 1;
  margin-top: dp(10);
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.sc-item {
  display: flex;
  flex-direction: column;
  align-items: center;
}

.sc-label {
  margin-top: dp(6);
  font-size: dp(11);
  line-height: 1;
  font-weight: 500;
  color: $text-sub;
}

.sc-label-active {
  font-weight: 700;
  color: $primary;
}

.sc-indicator {
  margin-top: dp(3);
  width: dp(14);
  height: dp(2.5);
  border-radius: dp(2);
  background-color: transparent;
}

.sc-indicator-active {
  background-color: $primary;
}
</style>
