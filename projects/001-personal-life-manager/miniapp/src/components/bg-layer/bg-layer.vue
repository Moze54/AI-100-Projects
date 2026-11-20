<template>
  <view class="bg-layer">
    <image class="bg-img" :src="src" mode="widthFix" />
  </view>
</template>

<script setup lang="ts">
withDefaults(
  defineProps<{
    src: string;
  }>(),
  {},
);
</script>

<style lang="scss">
/*
 * 整页插画背景（对应 Image.asset fit: cover + topCenter）。
 * 设计图比例约 852:1846 ≈ 19.5:9，与主流手机一致；宽度铺满后高度自然贴合，
 * 超出部分由容器裁掉，不足部分露出页面底色 $scaffold。
 */
.bg-layer {
  position: fixed;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  z-index: 0;
  background-color: $scaffold;
}

.bg-img {
  position: absolute;
  left: 0;
  top: 0;
  width: 750rpx;
}
</style>
