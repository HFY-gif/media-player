// src/router/index.js
import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import AudioPlayer from '@/views/AudioPlayer.vue'
import VideoPlayer from '@/views/VideoPlayer.vue'

const routes = [
  { path: '/', component: Home },
  { path: '/audio-player', component: AudioPlayer },
  { path: '/video-player', component: VideoPlayer }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
