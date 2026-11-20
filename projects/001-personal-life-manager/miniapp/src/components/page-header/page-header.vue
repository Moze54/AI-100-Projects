<template>
  <view class="ph" :style="rowStyle">
    <image class="ph-logo" src="/static/images/logo.png" mode="aspectFill" />
    <view class="ph-main">
      <text class="ph-name">拾记</text>
      <text class="ph-sub">{{ subtitle }}</text>
    </view>
    <glass-icon-btn icon="search_rounded" @tap="emit('search')" />
    <view class="ph-gap" />
    <glass-icon-btn icon="settings_rounded" @tap="emit('settings')" />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";

const props = withDefaults(
  defineProps<{
    subtitle: string;
    /** 微信胶囊预留间距（px），避免右上角按钮与胶囊重叠 */
    capsuleInset?: number;
  }>(),
  {
    capsuleInset: 0,
  },
);

const emit = defineEmits<{ (e: "search"): void; (e: "settings"): void }>();

const rowStyle = computed(() =>
  props.capsuleInset > 0 ? `padding-right:${props.capsuleInset}px;` : "",
);
</script>

<style lang="scss">
/* 页面顶部通用头部（对应 PageHeader） */
.ph {
  display: flex;
  align-items: center;
  padding: 0 0 0 dp(15);
}

.ph-logo {
  width: dp(30);
  height: dp(30);
  border-radius: dp(10);
  flex-shrink: 0;
}

.ph-main {
  flex: 1;
  min-width: 0;
  margin-left: dp(8);
  display: flex;
  flex-direction: column;
}

.ph-name {
  font-size: dp(18);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.ph-sub {
  margin-top: dp(3);
  font-size: dp(10);
  line-height: 1;
  color: #6e7ba8;
  @include ellipsis(1);
}

.ph-gap {
  width: dp(18);
  flex-shrink: 0;
}
</style>
