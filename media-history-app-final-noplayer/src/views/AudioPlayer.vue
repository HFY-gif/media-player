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

      <div class="controls">
        <label>播放进度：</label>
        <progress :value="progressPercent" max="100"></progress>
        <span>{{ progressPercent.toFixed(0) }}%</span>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  data() {
    return {
      src: '',
      currentTime: 0,
      duration: 0
    }
  },
  computed: {
    progressPercent() {
      if (!this.duration) return 0
      return (this.currentTime / this.duration) * 100
    }
  },
  mounted() {
    this.src = this.$route.query.src
  },
  methods: {
    onLoaded() {
      this.duration = this.$refs.audio.duration
    },
    updateProgress() {
      this.currentTime = this.$refs.audio.currentTime
    },
    formatTime(seconds) {
      const min = Math.floor(seconds / 60)
      const sec = Math.floor(seconds % 60).toString().padStart(2, '0')
      return `${min}:${sec}`
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

/* ✅ 标题加粗 + 统一样式 */
.nav-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
}

/* ✅ 导航链接样式与其它页面统一 */
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

/* ✅ 播放器内容区域布局 */
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

.controls {
  margin-top: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
}


</style>
