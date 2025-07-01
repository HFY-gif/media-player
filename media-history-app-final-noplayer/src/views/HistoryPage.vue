<template>
    <div>
    <!-- 顶部导航栏 -->
    <header class="navbar">
      <div class="nav-title">媒体播放器</div>
      <nav class="nav-links">
        <router-link to="/" exact>媒体播放</router-link>
        <router-link to="/history">历史播放</router-link>
      </nav>
    </header>
      
   <div class="page-container">
      <div class="flex">
        <HistorySidebar @changeType="mediaType = $event" />
        <div class="flex-1 p-8">
    <h2 class="text-2xl font-bold mb-4">{{ type === 'music' ? '🎵 音乐历史' : '🎬 视频历史' }}</h2>
    <HistoryList :type="mediaType" />
  </div>
  </div>
</div>
</div>
</template>

<script setup>
import { ref } from 'vue'
import HistorySidebar from '../components/HistorySidebar.vue'
import HistoryList from '../components/HistoryList.vue'
const mediaType = ref('music')
</script>

<style scoped>
/* 顶部导航栏样式 */
.navbar {
  width: 100vw;
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  padding: 0 5vw;
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  z-index: 1000;
}

.nav-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

.nav-links {
  display: flex;
  gap: 30px;
}

.nav-links a {
  text-decoration: none;
  color: #333;
  font-size: 16px;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #409eff;
}

.router-link-exact-active {
  font-weight: normal;
  font-size: 18px;
  text-decoration: underline;
}

.page-container {
  margin-top: 80px;
  padding: 0;
  box-sizing: border-box;
}
</style>
