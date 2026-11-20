<template>
  <view class="gib" :class="`gib-${gradient}`" :style="boxStyle">
    <app-icon :name="icon" :size="iconSize" color="#FFFFFF" />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

export type GradientName = "blue" | "purple" | "teal" | "orange" | "green" | "grey" | "pink";

const props = withDefaults(
  defineProps<{
    icon: string;
    gradient?: GradientName;
    /** 方块边长（dp） */
    size?: number;
    /** 图标尺寸（dp） */
    iconSize?: number;
    /** 圆角（dp） */
    radius?: number;
  }>(),
  {
    gradient: "blue",
    size: 46,
    iconSize: 22,
    radius: 14,
  },
);

const boxStyle = computed(
  () =>
    `width:${toRpx(props.size)};height:${toRpx(props.size)};border-radius:${toRpx(props.radius)};`,
);
</script>

<style lang="scss">
/* 彩色渐变圆角方块图标（对应 GradientIconBox） */
.gib {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.gib-blue {
  background: $grad-blue;
  box-shadow: 0 dp(4) dp(10) rgba(61, 123, 245, 0.35);
}

.gib-purple {
  background: $grad-purple;
  box-shadow: 0 dp(4) dp(10) rgba(143, 107, 255, 0.35);
}

.gib-teal {
  background: $grad-teal;
  box-shadow: 0 dp(4) dp(10) rgba(47, 184, 168, 0.35);
}

.gib-orange {
  background: $grad-orange;
  box-shadow: 0 dp(4) dp(10) rgba(255, 157, 66, 0.35);
}

.gib-green {
  background: $grad-green;
  box-shadow: 0 dp(4) dp(10) rgba(61, 187, 122, 0.35);
}

.gib-grey {
  background: $grad-grey;
  box-shadow: 0 dp(4) dp(10) rgba(185, 193, 210, 0.35);
}

.gib-pink {
  background: $grad-pink;
  box-shadow: 0 dp(4) dp(10) rgba(255, 123, 163, 0.32);
}
</style>
