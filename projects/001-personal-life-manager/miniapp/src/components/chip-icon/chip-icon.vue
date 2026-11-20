<template>
  <view class="chip" :style="boxStyle">
    <app-icon :name="icon" :size="13" :color="color" />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

const props = defineProps<{
  icon: string;
  color: string;
  background: string;
}>();

const boxStyle = computed(
  () =>
    `width:${toRpx(20)};height:${toRpx(20)};border-radius:${toRpx(7)};background-color:${props.background};`,
);
</script>

<style lang="scss">
/* 彩色小圆角图标底（对应 ChipIcon） */
.chip {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
</style>
