<template>
  <div class="w-64 bg-white border-r shadow-md p-6">
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
