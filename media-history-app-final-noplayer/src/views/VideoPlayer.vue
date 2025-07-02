<template>
  <div>
    <main class="player-container">
      <video
        ref="video"
        :src="src"
        controls
        @loadedmetadata="onLoaded"
        class="video-player"
        playsinline
        webkit-playsinline
      ></video>
    </main>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      src: '',
      playbackRate: '1',
      duration: 0,
      userId: null,
      fileName: '',
      startTime: 0,
      timer: null
    }
  },
  mounted() {
    const query = this.$route.query
    this.src = query.src
    this.fileName = query.title || '未命名视频'
    this.startTime = Number(query.start || 0)

    const user = JSON.parse(localStorage.getItem('currentUser'))
    this.userId = user?.user_id

    this.$nextTick(() => {
      const video = this.$refs.video
      video.addEventListener('loadedmetadata', () => {
        if (this.startTime > 0 && this.startTime < video.duration) {
          video.currentTime = this.startTime
        }
        this.duration = Math.floor(video.duration)
        this.addOrUpdateRecord() // ✅ 初始播放记录
      })
    })

    this.timer = setInterval(this.syncPlayTime, 5000)
  },
  beforeUnmount() {
    clearInterval(this.timer)
  },
  methods: {
    async addOrUpdateRecord() {
      if (!this.userId || !this.src) return
      try {
        const res = await axios.post('http://localhost:5000/api/play_records', {
          user_id: this.userId,
          media_type: 'video',
          media_id: this.src,
          media_title: this.fileName,
          media_url: this.src,
          duration: Math.floor(this.$refs.video.currentTime)
        })
        console.log('✅ 初始播放记录添加成功', res.data)
      } catch (err) {
        console.error('添加记录失败', err)
      }
    },
    async syncPlayTime() {
      if (!this.userId || !this.src) return
      try {
        const res = await axios.post('http://localhost:5000/api/play_records', {
          user_id: this.userId,
          media_type: 'video',
          media_id: this.src,
          media_title: this.fileName,
          media_url: this.src,
          duration: Math.floor(this.$refs.video.currentTime)
        })
        console.log('⏱ 播放进度同步成功', res.data)
      } catch (err) {
        console.error('同步失败', err)
      }
    }
  }
}
</script>


<style scoped>
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
  max-width: none;
  margin: 0;
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
  font-weight: bold;
  font-size: 18px;
  text-decoration: underline;
}

.player-container {
  margin-top: 120px;
  text-align: center;
}

.video-player {
  width: 100%;
  max-height: 80vh;
}
</style>
