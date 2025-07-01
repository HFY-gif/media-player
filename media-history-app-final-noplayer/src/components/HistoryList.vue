<template>
  <div>
    <div
      v-for="item in filteredList"
      :key="item.name"
      class="mb-4 border-b pb-2 flex justify-between items-center"
    >
      <span class="text-lg">{{ item.name }}</span>
      <button
        @click="goToPlayer(item)"
        class="text-white bg-blue-500 hover:bg-blue-600 px-4 py-1 rounded"
      >
        播放
      </button>
    </div>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { computed } from 'vue'

const props = defineProps({ type: String })
const router = useRouter()

const historyData = [
  { name: '周杰伦-晴天.mp3', url: '/media/sunny.mp3', type: 'music' },
  { name: '短片-海边.mp4', url: '/media/beach.mp4', type: 'video' }
]

const filteredList = computed(() => historyData.filter(item => item.type === props.type))

function goToPlayer(item) {
  const route = item.type === 'music' ? '/audio-player' : '/video-player'
  router.push({ path: route, query: { src: item.url } })
}
</script>
