<template>
  <view class="gpb" :style="rootStyle" @tap="emit('tap')">
    <app-icon :name="icon" :size="fontSize + 4" color="#FFFFFF" />
    <text class="gpb-label" :style="labelStyle">{{ label }}</text>
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    label: string;
    icon: string;
    /** 按钮高度（dp） */
    height?: number;
    /** 字号（dp） */
    fontSize?: number;
  }>(),
  {
    height: 48,
    fontSize: 15,
  },
);

const emit = defineEmits<{ (e: "tap"): void }>();

const rootStyle = computed(
  () => `height:${toRpx(props.height)};border-radius:${toRpx(props.height / 2)};`,
);
const labelStyle = computed(() => `font-size:${toRpx(props.fontSize)};`);
</script>

<style lang="scss">
/* 彩色渐变主按钮（对应 GradientPillButton） */
.gpb {
  display: flex;
  align-items: center;
  justify-content: center;
  background: $grad-blue;
  box-shadow: $shadow-pill;
}

.gpb-label {
  margin-left: dp(7);
  line-height: 1;
  font-weight: 700;
  color: #ffffff;
}
</style>
