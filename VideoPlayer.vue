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
  margin-top: 120px;
  text-align: center;
}
.video-player {
  width: 100%;
  max-height: 80vh;
}
</style>
