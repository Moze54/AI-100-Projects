<template>
  <view class="sph">
    <glass-icon-btn icon="arrow_back_rounded" @tap="back" />
    <view class="sph-center">
      <text class="sph-title">{{ title }}</text>
    </view>
    <view class="sph-right">
      <glass-icon-btn
        v-if="actionIcon"
        :icon="actionIcon"
        @tap="emit('action')"
      />
    </view>
  </view>
</template>

<script setup lang="ts">
withDefaults(
  defineProps<{
    title: string;
    actionIcon?: string;
  }>(),
  {
    actionIcon: "",
  },
);

const emit = defineEmits<{ (e: "action"): void }>();

const back = () => {
  uni.navigateBack({
    delta: 1,
    fail: () => {
      uni.switchTab({ url: "/pages/home/index" });
    },
  });
};
</script>

<style lang="scss">
/* 子页面顶部导航（对应 SubPageHeader）：返回 + 居中标题 + 右侧动作 */
.sph {
  display: flex;
  align-items: center;
}

.sph-center {
  flex: 1;
  min-width: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sph-title {
  font-size: dp(17);
  line-height: 1;
  font-weight: 800;
  color: $navy;
  @include ellipsis(1);
}

.sph-right {
  width: dp(44);
  flex-shrink: 0;
  display: flex;
  justify-content: flex-end;
}
</style>
