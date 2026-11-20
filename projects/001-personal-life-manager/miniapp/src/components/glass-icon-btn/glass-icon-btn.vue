<template>
  <view class="rq-btn" :style="rootStyle" @tap="onTap">
    <app-icon :name="icon" :size="16" color="#1B2D55" />
    <view v-if="showRedDot" class="rq-dot" :style="dotStyle" />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    icon: string;
    showRedDot?: boolean;
    /** 按钮直径（dp） */
    size?: number;
  }>(),
  {
    showRedDot: false,
    size: 34,
  },
);

const emit = defineEmits<{ (e: "tap"): void }>();

const rootStyle = computed(() => `width:${toRpx(props.size)};height:${toRpx(props.size)};`);
const dotStyle = computed(() => `width:${toRpx(7)};height:${toRpx(7)};`);
const onTap = () => emit("tap");
</script>

<style lang="scss">
/* 顶部圆形毛玻璃图标按钮（对应 RoundGlassButton） */
.rq-btn {
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.55);
  border: 1px solid rgba(255, 255, 255, 0.82);
  box-shadow: 0 dp(4) dp(10) rgba(92, 122, 190, 0.06);
  flex-shrink: 0;
}

.rq-dot {
  position: absolute;
  top: dp(7);
  right: dp(8);
  border-radius: 50%;
  background-color: $red;
}
</style>
