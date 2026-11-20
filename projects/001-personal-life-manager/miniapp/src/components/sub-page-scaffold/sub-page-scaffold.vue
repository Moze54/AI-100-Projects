<template>
  <view class="sps">
    <bg-layer :src="background" />
    <view class="sps-body" :style="bodyStyle">
      <slot />
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { getNavMetrics } from "@/utils/nav";

const props = withDefaults(
  defineProps<{
    /** 整页背景图 */
    background?: string;
  }>(),
  {
    background: "/static/images/bg_detail.webp",
  },
);

const bodyStyle = computed(() => `padding-top:${getNavMetrics().headerTop}px;`);
</script>

<style lang="scss">
/* 子页面通用骨架（对应 SubPageScaffold）：全屏背景 + 自定义导航区留白 */
.sps {
  position: relative;
  min-height: 100vh;
}

.sps-body {
  position: relative;
  z-index: 1;
}
</style>
