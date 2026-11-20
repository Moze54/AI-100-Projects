<template>
  <view v-if="compact" class="shc">
    <view class="shc-icon" :style="plainIconStyle">
      <app-icon :name="icon" :size="15" :color="iconColor" />
    </view>
    <text class="shc-title">{{ title }}</text>
    <text class="shc-trailing">{{ trailing }}</text>
    <app-icon name="chevron_right_rounded" :size="14" color="#B9C4DE" />
  </view>
  <view v-else class="sh">
    <gradient-icon-box
      :icon="icon"
      :gradient="tone"
      :size="20"
      :icon-size="12"
      :radius="shape === 'circle' ? 10 : 6"
    />
    <text class="sh-title">{{ title }}</text>
    <view class="sh-spacer" />
    <view class="sh-more" @tap="emit('trailing')">
      <text class="sh-trailing">{{ trailing }}</text>
      <app-icon name="chevron_right_rounded" :size="15" color="#B9C4DE" />
    </view>
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    icon: string;
    iconColor: string;
    iconBg: string;
    title: string;
    trailing?: string;
    /** 紧凑模式：半宽卡片使用 */
    compact?: boolean;
    /** 普通模式的图标形状：设计稿中「今日安排」为方形，「最近记录」为圆形 */
    shape?: "square" | "circle";
    /** 普通模式图标渐变，默认品牌蓝 */
    tone?: "blue" | "purple" | "teal" | "orange" | "green" | "grey" | "pink";
  }>(),
  {
    trailing: "更多",
    compact: false,
    shape: "square",
    tone: "blue",
  },
);

const emit = defineEmits<{ (e: "trailing"): void }>();

const plainIconStyle = computed(() => `width:${toRpx(22)};height:${toRpx(22)};`);
</script>

<style lang="scss">
/* 卡片区块标题行（对应 SectionHeader） */
.sh,
.shc {
  display: flex;
  align-items: center;
}

.sh-title {
  margin-left: dp(8);
  font-size: dp(15);
  line-height: 1;
  font-weight: 800;
  color: $navy;
  flex-shrink: 0;
}

.sh .sh-title {
  margin-left: dp(7);
}

.sh-spacer {
  flex: 1;
}

.sh-more {
  display: flex;
  align-items: center;
}

.sh-trailing {
  font-size: dp(13);
  color: $text-sub;
}

.shc-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.shc-title {
  margin-left: dp(7);
  flex: 1;
  min-width: 0;
  font-size: dp(14);
  line-height: 1;
  font-weight: 800;
  color: $navy;
  @include ellipsis(1);
}

.shc-trailing {
  margin-left: dp(4);
  font-size: dp(12);
  color: $text-sub;
  flex-shrink: 0;
}
</style>
