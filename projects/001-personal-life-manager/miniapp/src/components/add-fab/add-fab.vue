<template>
  <view class="fab" :style="rootStyle" @tap="emit('tap')">
    <app-icon name="add_rounded" :size="24" color="#FFFFFF" />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    /** 距底部距离（dp），按页面设计图微调 */
    bottom?: number;
  }>(),
  { bottom: 91 },
);

const emit = defineEmits<{ (e: "tap"): void }>();
const rootStyle = computed(
  () => `bottom:calc(${toRpx(props.bottom)} + env(safe-area-inset-bottom));`,
);
</script>

<style lang="scss">
/* 蓝色渐变悬浮新增按钮（对应 AddFab），固定在设计图底栏上方 */
.fab {
  position: fixed;
  right: dp(17.5);
  z-index: 40;
  display: flex;
  align-items: center;
  justify-content: center;
  width: dp(56);
  height: dp(56);
  border-radius: 50%;
  background: $grad-blue;
  border: 2px solid rgba(255, 255, 255, 0.6);
  box-shadow: $shadow-fab;
}
</style>
