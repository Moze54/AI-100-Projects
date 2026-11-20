<template>
  <view class="rt" :class="{ 'rt-compact': compact }" @tap="emit('tap')">
    <image class="rt-thumb" :src="thumb" mode="aspectFill" />
    <view class="rt-main">
      <view class="rt-title-row">
        <app-icon
          v-if="titleIcon"
          :name="titleIcon"
          :size="compact ? 12 : 13"
          :color="titleIconColor"
        />
        <text class="rt-title" :class="{ 'rt-title-with-icon': !!titleIcon }">
          {{ title }}
        </text>
      </view>
      <text class="rt-subtitle">{{ subtitle }}</text>
    </view>
    <app-icon name="more_horiz_rounded" :size="compact ? 14 : 18" color="#A6AFC9" />
  </view>
</template>

<script setup lang="ts">
withDefaults(
  defineProps<{
    thumb: string;
    title: string;
    subtitle: string;
    titleIcon?: string;
    titleIconColor?: string;
    /** 紧凑模式：资料页最近浏览使用 */
    compact?: boolean;
  }>(),
  {
    titleIcon: "",
    titleIconColor: "#4A87F8",
    compact: false,
  },
);

const emit = defineEmits<{ (e: "tap"): void }>();
</script>

<style lang="scss">
/* 最近记录 / 最近浏览列表条目（对应 RecordTile） */
.rt {
  display: flex;
  align-items: center;
  height: dp(66);
}

.rt-thumb {
  width: dp(68);
  height: dp(54);
  border-radius: dp(12);
  flex-shrink: 0;
}

.rt-main {
  flex: 1;
  min-width: 0;
  margin-left: dp(15);
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.rt-title-row {
  display: flex;
  align-items: center;
  min-width: 0;
}

.rt-title {
  font-size: dp(15);
  line-height: 1;
  font-weight: 600;
  color: $navy;
  min-width: 0;
  @include ellipsis(1);
}

.rt-title-with-icon {
  margin-left: dp(4);
}

.rt-subtitle {
  margin-top: dp(5);
  font-size: dp(12);
  line-height: 1;
  color: $text-sub;
  @include ellipsis(1);
}

/* 紧凑模式：资料页最近浏览 */
.rt-compact {
  height: dp(56);
}

.rt-compact .rt-thumb {
  width: dp(68);
  height: dp(45);
  border-radius: dp(10);
}

.rt-compact .rt-main {
  margin-left: dp(15);
}

.rt-compact .rt-title {
  font-size: dp(13);
}

.rt-compact .rt-title-with-icon {
  margin-left: dp(3);
}

.rt-compact .rt-subtitle {
  margin-top: dp(4);
  font-size: dp(10);
}
</style>
