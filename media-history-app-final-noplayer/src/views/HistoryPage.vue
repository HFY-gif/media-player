<template>
  <div class="bg-white shadow-md p-6 rounded">
    <h2 class="text-2xl font-bold mb-4">{{ type === 'music' ? '🎵 音乐历史' : '🎬 视频历史' }}</h2>
    <HistoryList :type="type" />
  </div>
</template>

<script setup>
import HistoryList from '../components/HistoryList.vue'
defineProps({ type: String })
</script>
