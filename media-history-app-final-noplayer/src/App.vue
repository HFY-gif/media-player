<template>
  <div class="app-container">
    <!-- 判断当前路由，如果不是登录或注册页，则显示导航栏 -->
    <ReusableNavbar v-if="!isAuthPage" />
    
    <router-view />
  </div>
</template>

<script setup>
import { computed } from 'vue'
import { useRoute } from 'vue-router'
import ReusableNavbar from '@/components/ReusableNavbar.vue'

// 当前路由信息
const route = useRoute()

// 登录注册页路径列表
const authPages = ['/login', '/register']

// 判断是否为登录注册页
const isAuthPage = computed(() => authPages.includes(route.path))
</script>

<style>
body {
  margin: 0;
  font-family: sans-serif;
  background-color: #fff;
}
</style>
