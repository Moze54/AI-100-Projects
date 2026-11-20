<template>
  <view class="gc" :class="{ 'gc-fill': fill, 'gc-elevated': elevated }" :style="cardStyle">
    <slot />
  </view>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { dpShorthand, toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    /** 内边距，dp 简写（同 CSS padding 顺序），如 "14" / "13 6" */
    pad?: string;
    /** 圆角（dp） */
    radius?: number;
    /** 外边距，dp 简写 */
    margin?: string;
    /** 白色底透明度 */
    alpha?: number;
    /** 可选背景色/渐变；传入后覆盖默认白色底 */
    tint?: string;
    /** 撑满父容器并垂直居中内容（小程序插槽不会继承 height:100%，用它兜底） */
    fill?: boolean;
    /** 加强投影，用于需要从背景中“浮起来”的独立按钮 */
    elevated?: boolean;
  }>(),
  {
    pad: "14",
    radius: 18,
    margin: "",
    alpha: 0.68,
    tint: "",
    fill: false,
    elevated: false,
  },
);

const cardStyle = computed(() => {
  const styles = [
    `padding:${dpShorthand(props.pad)}`,
    `border-radius:${toRpx(props.radius)}`,
  ];
  if (props.tint) {
    styles.push(`background:${props.tint}`);
  } else {
    styles.push(`background-color:rgba(248,250,255,${props.alpha})`);
  }
  if (props.margin) {
    styles.push(`margin:${dpShorthand(props.margin)}`);
  }
  return styles.join(";");
});
</script>

<style lang="scss">
/* 毛玻璃卡片：半透明白 + 白描边 + 背景模糊 + 柔和投影（对应 GlassCard） */
.gc {
  border: 1px solid rgba(255, 255, 255, 0.78);
  box-shadow: $shadow-glass;
  overflow: hidden;
  @include backdrop-blur(20);
}

/* 小程序的插槽内容在外面包了一层节点，height:100% 不会向下传递；
   需要等高的卡片统一用 fill，让卡片自身垂直居中内容。 */
.gc-fill {
  width: 100%;
  height: 100%;
  box-sizing: border-box;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.gc-elevated {
  border-color: rgba(255, 255, 255, 0.95);
  box-shadow: 0 dp(4) dp(14) rgba(74, 135, 248, 0.24),
    inset 0 1px 0 rgba(255, 255, 255, 0.85);
}
</style>
