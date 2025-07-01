<template>
  <div>
    <div v-for="item in filteredList" :key="item.name" class="mb-4 border-b pb-2 flex justify-between items-center">
      <span class="text-lg">{{ item.name }}</span>
      <button class="text-white bg-blue-400 cursor-not-allowed px-4 py-1 rounded opacity-60" disabled>播放</button>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({ type: String })

const historyData = [
  { name: '周杰伦-晴天.mp3', url: '/media/sunny.mp3', type: 'music' },
  { name: '短片-海边.mp4', url: '/media/beach.mp4', type: 'video' }
]

const filteredList = computed(() => historyData.filter(item => item.type === props.type))
</script>
