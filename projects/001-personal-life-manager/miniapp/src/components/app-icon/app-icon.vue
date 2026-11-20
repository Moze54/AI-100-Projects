<template>
  <text class="si-icon" :style="iconStyle">{{ glyph }}</text>
</template>

<script setup lang="ts">
import { computed } from "vue";
import { ICON_GLYPHS } from "./icons";
import { toRpx } from "@/utils/layout";

const props = withDefaults(
  defineProps<{
    /** 图标名，对应 Flutter Icons.xxx */
    name: string;
    /** 设计稿尺寸（dp） */
    size?: number;
    color?: string;
  }>(),
  {
    size: 16,
    color: "#1B2D55",
  },
);

const glyph = computed(() => ICON_GLYPHS[props.name] ?? "");
const iconStyle = computed(() => `font-size:${toRpx(props.size)};color:${props.color};`);
</script>

<style lang="scss">
@import "./icon-font.scss";
</style>
