<template>
  <div>
    <header class="navbar">
      <div class="nav-title">媒体播放器</div>
      <nav class="nav-links">
        <router-link to="/home">媒体播放</router-link>
        <router-link to="/history">历史播放</router-link>
      </nav>
    </header>

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
  display: flex;
  justify-content: space-between;
  padding: 20px 70px;
  position: fixed;
  width: 90%;
  top: 0;
  background-color: #fff;
  box-shadow: 0 10px 100px rgba(0,0,0,0.1);
}
.nav-links a {
  margin-left: 40px;
  text-decoration: none;
  color: #333;
}
.router-link-exact-active {
  font-weight: bold;
  font-size: 20px;
  text-decoration: underline;
}
.player-container {
  margin-top: 150px;
  text-align: center;
}
.media-image {
  width: 100%;
  max-width: 550px;
  margin-bottom: 20px;
  border-radius: 8px;
}
.audio-player {
  width: 70%;
  margin-top: 20px;
}
.controls {
  margin-top: 20px;
}
</style>
