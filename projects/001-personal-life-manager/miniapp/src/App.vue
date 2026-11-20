<script setup lang="ts">
import { onLaunch } from "@dcloudio/uni-app";

onLaunch(() => {
  // 预留：后续在此初始化登录态、本地存储与全局配置
});
</script>

<style lang="scss">
page {
  background-color: $scaffold;
  color: $navy;
  font-family: $font-family;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

view,
text,
image,
scroll-view {
  box-sizing: border-box;
}

image {
  display: block;
}

/* #ifdef H5 */
/* H5 预览使用页面内自绘玻璃 TabBar，隐藏 uni-app 内置 TabBar */
uni-tabbar {
  display: none !important;
}

html,
body,
uni-page-body {
  background-color: #d9e7fe;
}

::-webkit-scrollbar {
  width: 0;
  height: 0;
}
/* #endif */
</style>
