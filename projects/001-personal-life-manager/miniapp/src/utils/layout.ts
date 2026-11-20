/** 设计稿基准宽度（dp），对应原 Flutter kDesignWidth = 426 */
export const DESIGN_WIDTH = 426;

/** 1dp → rpx 系数：750 / 426 */
export const DP_RATIO = 750 / DESIGN_WIDTH;

/** 把设计稿 dp 数值转成 rpx 字符串 */
export function toRpx(value: number): string {
  const n = Number((value * DP_RATIO).toFixed(3));
  return `${n}rpx`;
}

/** 把 dp 空格分隔简写（同 CSS padding/margin 顺序）转成 rpx 简写 */
export function dpShorthand(value: string): string {
  return value
    .trim()
    .split(/\s+/)
    .filter(Boolean)
    .map((part) => toRpx(Number(part)))
    .join(" ");
}
