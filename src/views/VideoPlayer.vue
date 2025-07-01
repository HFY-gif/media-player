<!-- src/views/VideoPlayer.vue -->
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
export default {
  data() {
    return {
      src: '',
      playbackRate: '1'
    }
  },
  mounted() {
    this.src = this.$route.query.src
  },
  methods: {
    onLoaded() {
      this.$refs.video.playbackRate = parseFloat(this.playbackRate)
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
