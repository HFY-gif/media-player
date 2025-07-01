import { createRouter, createWebHistory } from 'vue-router'
import Home from '@/views/Home.vue'
import AudioPlayer from '@/views/AudioPlayer.vue'
import VideoPlayer from '@/views/VideoPlayer.vue'
import HistoryPage from '@/views/HistoryPage.vue'
import Login from '@/views/Login.vue'
import Register from '@/views/Register.vue'

const routes = [
  { path: '/', component: Login },
  { path: '/audio-player', component: AudioPlayer },
  { path: '/video-player', component: VideoPlayer },
  { path: '/history', component: HistoryPage },
  { path: '/home', component: Home },
  { path: '/register', component: Register },
  { path: '/:pathMatch(.*)*', redirect: '/' }
]

const router = createRouter({
  history: createWebHistory(),
  routes
})

export default router
