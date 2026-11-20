<template>
  <sub-page-scaffold background="/static/images/bg_detail.webp">
    <view class="ph-page">
      <sub-page-header :title="title" />
      <view class="ph-content">
        <glass-card pad="24">
          <view class="ph-badge">
            <app-icon name="rocket_launch_rounded" :size="34" color="#4A87F8" />
          </view>
          <text class="ph-title">{{ title }}</text>
          <text class="ph-desc">该页面将在后续批次移植</text>
          <text class="ph-hint">当前批次已完成：首页 · 分类 · 日程 · 我的</text>
          <view class="ph-action">
            <gradient-pill-button
              label="返回"
              icon="arrow_back_rounded"
              :height="42"
              :font-size="14"
              @tap="back"
            />
          </view>
        </glass-card>
      </view>
    </view>
  </sub-page-scaffold>
</template>

<script setup lang="ts">
import { ref } from "vue";
import { onLoad } from "@dcloudio/uni-app";

const title = ref("拾记");

onLoad((options) => {
  const raw = options?.title;
  if (raw) {
    title.value = decodeURIComponent(raw);
  }
});

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
.ph-page {
  padding: 0 dp(20);
}

.ph-content {
  margin-top: dp(24);
}

.ph-badge {
  width: dp(64);
  height: dp(64);
  border-radius: dp(20);
  background-color: #e3eeff;
  display: flex;
  align-items: center;
  justify-content: center;
}

.ph-title {
  display: block;
  margin-top: dp(18);
  font-size: dp(20);
  line-height: 1;
  font-weight: 800;
  color: $navy;
}

.ph-desc {
  display: block;
  margin-top: dp(10);
  font-size: dp(15);
  line-height: 1.4;
  color: $text-sub;
}

.ph-hint {
  display: block;
  margin-top: dp(6);
  font-size: dp(12);
  line-height: 1.4;
  color: $text-light;
}

.ph-action {
  margin-top: dp(20);
  width: dp(140);
}
</style>
