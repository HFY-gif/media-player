<template>
  <div>
    <div
      v-for="item in filteredList"
      :key="item.record_id"
      class="mb-4 border-b pb-2 flex justify-between items-center"
    >
      <span class="text-lg">{{ item.media_title }}</span>
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
import { onMounted, ref, computed } from 'vue'
import axios from 'axios'

const props = defineProps({ type: String })
const router = useRouter()

const historyData = ref([])

// ✅ 正确获取 user_id
const user = JSON.parse(localStorage.getItem('currentUser') || '{}')
const userId = user.user_id

onMounted(fetchRecords)

async function fetchRecords() {
  if (!userId) {
    console.warn('用户未登录，无法获取记录')
    return
  }

  try {
    const res = await axios.get(`http://localhost:5000/api/play_records/${userId}`)
    historyData.value = res.data.records
    console.log('✅ 播放记录获取成功:', historyData.value)
  } catch (err) {
    console.error('获取播放记录失败:', err)
  }
}

const filteredList = computed(() =>
  historyData.value.filter(item => item.media_type === (props.type === 'music' ? 'audio' : 'video'))
)

function goToPlayer(item) {
  const route = item.media_type === 'audio' ? '/audio-player' : '/video-player'
  router.push({
    path: route,
    query: {
      src: item.media_url,
      title: item.media_title,
      record_id: item.record_id,
      start: item.duration || 0
    }
  })
}
</script>
