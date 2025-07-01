<template>
  <div class="flex h-screen text-gray-800">
    <HistorySidebar @changeType="mediaType = $event" />
    <div class="flex-1 overflow-auto p-8">
      <HistoryPage :type="mediaType" />
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import HistorySidebar from './components/HistorySidebar.vue'
import HistoryPage from './views/HistoryPage.vue'

const mediaType = ref('music')
</script>
