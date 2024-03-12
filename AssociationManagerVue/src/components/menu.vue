<!--
 * @Description: 
 * @Author: Rabbiter
 * @Date: 2022-06-11 13:41:22
-->
<template>
  <el-aside class="fater-left">
      <el-menu active-text-color="#6495ED" :default-active="this.$router.currentRoute.path" router>
          <template v-for="(item, index) in menuList">
            <el-menu-item :key="index" :index="item.path">
                <i :class="item.icon" style="font-size: 26px;"></i> 
                <span slot="title" > {{ item.name }}</span>
            </el-menu-item>
          </template>
      </el-menu>
  </el-aside>
</template>

<style>
.el-menu-item .is-active i {
  color: #6495ED;
}
</style>

<script>


    export default{
      props: {
              menuList: []
      },
          
      mounted() {
          
      }
    }
</script>