<template>
  <view class="spb">
    <slot />
  </view>
</template>

<script setup lang="ts"></script>

<style lang="scss">
/* 底部毛玻璃操作条（对应 SubPageBottomBar） */
.spb {
  position: fixed;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 25;
  overflow: hidden;
  border-top-left-radius: $radius-bottom-bar;
  border-top-right-radius: $radius-bottom-bar;
  background-color: rgba(255, 255, 255, 0.8);
  border-top: 1px solid rgba(255, 255, 255, 0.9);
  padding: dp(12) dp(20) calc(#{dp(12)} + env(safe-area-inset-bottom));
  @include backdrop-blur(18);
}
</style>
