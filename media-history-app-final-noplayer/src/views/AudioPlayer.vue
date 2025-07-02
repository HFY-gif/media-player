<template>
  <div>
    <main class="player-container">
      <img src="@/assets/yinpin.jpg" alt="封面" class="media-image" />
      <audio
        ref="audio"
        :src="src"
        controls
        @timeupdate="updateProgress"
        @loadedmetadata="onLoaded"
        class="audio-player"
      ></audio>

    </main>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data() {
    return {
      src: '',
      currentTime: 0,
      duration: 0,
      userId: null,
      fileName: '',
      startTime: 0,
      timer: null
    }
  },
  computed: {
    progressPercent() {
      if (!this.duration) return 0
      return (this.currentTime / this.duration) * 100
    }
  },
  mounted() {
    const query = this.$route.query
    this.src = query.src
    this.fileName = query.title || '未命名音频'
    this.startTime = Number(query.start || 0)

    const user = JSON.parse(localStorage.getItem('currentUser'))
    this.userId = user?.user_id

    // 等待音频加载完成再设置起始时间
    this.$nextTick(() => {
      const audio = this.$refs.audio
      audio.addEventListener('loadedmetadata', () => {
        if (this.startTime > 0 && this.startTime < audio.duration) {
          audio.currentTime = this.startTime
        }
        this.duration = Math.floor(audio.duration)
        this.addOrUpdateRecord() // ✅ 初次播放记录
      })
    })

    this.timer = setInterval(this.syncPlayTime, 5000)
  },
  beforeUnmount() {
    clearInterval(this.timer)
  },
  methods: {
    updateProgress() {
      this.currentTime = this.$refs.audio.currentTime
    },
    async addOrUpdateRecord() {
      if (!this.userId || !this.src) return
      try {
        const res = await axios.post('http://localhost:5000/api/play_records', {
          user_id: this.userId,
          media_type: 'audio',
          media_id: this.src,
          media_title: this.fileName,
          media_url: this.src,
          duration: Math.floor(this.$refs.audio.currentTime)
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
          media_type: 'audio',
          media_id: this.src,
          media_title: this.fileName,
          media_url: this.src,
          duration: Math.floor(this.$refs.audio.currentTime)
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
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
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
  margin-top: 150px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  text-align: center;
  padding: 0 20px;
}

.media-image {
  width: 100%;
  max-width: 550px;
  margin-bottom: 20px;
  border-radius: 8px;
}

.audio-player {
  width: 70%;
  max-width: 500px;
  margin-top: 20px;
}

</style>
