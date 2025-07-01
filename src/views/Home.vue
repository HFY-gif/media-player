<template>
  <div>
    <header class="navbar">
      <div class="nav-title">媒体播放器</div>
      <nav class="nav-links">
        <router-link to="/"exact>媒体播放</router-link>
        <router-link to="/history">历史播放</router-link>
      </nav>
    </header>

    <main class="home-container">
      <img src="@/assets/bofang.png" class="banner-img" />
      <div class="buttons">
        <input type="file" ref="videoInput" accept="video/*" @change="handleVideoSelect" hidden />
        <input type="file" ref="audioInput" accept="audio/*" @change="handleAudioSelect" hidden />
        <button @click="$refs.videoInput.click()">选择视频</button>
        <button @click="$refs.audioInput.click()">选择音频</button>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  methods: {
    handleVideoSelect() {
      const file = this.$refs.videoInput.files[0]
      if (file) {
        const url = URL.createObjectURL(file)
        this.$router.push({ path: '/video-player', query: { src: url } })
      }
    },
    handleAudioSelect() {
      const file = this.$refs.audioInput.files[0]
      if (file) {
        const url = URL.createObjectURL(file)
        this.$router.push({ path: '/audio-player', query: { src: url } })
      }
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
  box-shadow: 0 10px 100px rgba(0, 0, 0, 0.1);
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

.home-container {
  margin-top: 200px;
  text-align: center;
}
.banner-img {
  width: 650px;
  margin-bottom: 30px;
  border-radius: 8px;
}
.buttons button {
  margin: 10px 100px;
  padding: 10px 20px;
  font-size: 16px;
  border-radius: 8px;
}
</style>
