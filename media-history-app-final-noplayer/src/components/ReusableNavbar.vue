<template>
  <header class="navbar">
    <div class="nav-title">媒体播放器</div>
    <div class="nav-right">
      <nav class="nav-links">
        <router-link to="/home" exact>媒体播放</router-link>
        <router-link to="/history">历史播放</router-link>
      </nav>
      <div class="user-info">
        <img src="@/assets/headimage.png" alt="头像" class="avatar" />
        <span class="username">{{ username }}</span>
      </div>
    </div>
  </header>
</template>

<script>
export default {
  data() {
    return {
      username: ''
    }
  },
  mounted() {
    const user = JSON.parse(localStorage.getItem('currentUser'))
    this.username = user?.username || '游客'
  }
}
</script>

<style scoped>
.navbar {
  width: 100vw;
  position: fixed;
  top: 0;
  left: 0;
  padding: 0 5vw;
  height: 60px;
  display: flex;
  align-items: center;
  background-color: #fff;
  box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  z-index: 1000;
}

.nav-title {
  font-size: 24px;
  font-weight: bold;
  color: #333;
  margin-right: auto;
}

.nav-right {
  display: flex;
  align-items: center;
  gap: 40px;
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

.user-info {
  display: flex;
  align-items: center;
  gap: 10px;
}

.avatar {
  width: 32px;
  height: 32px;
  border-radius: 50%;
}

.username {
  font-size: 16px;
  color: #333;
}
</style>
