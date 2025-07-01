<template>
    <div class="sidebar">
    <h2 class="text-xl font-semibold mb-6">历史记录</h2>
    <ul class="space-y-4">
      <li @click="emitType('music')" class="cursor-pointer hover:text-blue-600">🎵 音乐历史</li>
      <li @click="emitType('video')" class="cursor-pointer hover:text-blue-600">🎬 媒体视频</li>
    </ul>
  </div>
</template>

<script setup>
const emit = defineEmits(['changeType'])
function emitType(type) {
  emit('changeType', type)
}
</script>
<style scoped>
.sidebar {
  width: 16rem; /* w-64 */
  padding: 1.5rem; /* p-6 */
  background-color: #ffffff;
  box-shadow: 2px 0 8px rgba(0, 0, 0, 0.08); /* 右侧阴影感 */
  border-right: 1px solid #e5e7eb; /* 边界线 */
  height: 100vh; /* ✅ 关键：占满整个视口高度 */
  box-sizing: border-box;
  position: sticky;
  top: 60px; /* 与导航栏高度保持一致 */
}
</style>

