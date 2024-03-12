<!--
 * @Description: 
 * @Author: Rabbiter
 * @Date: 2022-06-11 13:41:22
-->
<template>
    <el-container>
        <Nav></Nav>
        <el-container>
            <Menu :menuList="this.$store.state.menus.children"></Menu>
            <el-main class="fater-body">
                <el-breadcrumb
                    v-if="this.$router.currentRoute.path != '/index'"
                    class="fater-body-breadcrumb"
                >
                    <el-breadcrumb-item>系统首页</el-breadcrumb-item>
                    <el-breadcrumb-item>{{
                        this.$router.currentRoute.name
                    }}</el-breadcrumb-item>
                </el-breadcrumb>
                <router-view></router-view>
            </el-main>
        </el-container>
    </el-container>
</template>

<style>
</style>

<script>
import Nav from "../components/nav.vue";
import Menu from "../components/menu.vue";
import { getLoginUser } from "../api";

export default {
    data() {
        return {};
    },
    methods: {},
    mounted() {
        getLoginUser(this.$store.state.token).then((resp) => {
            this.$store.state.user = resp.data;
        });
    },
    components: {
        Nav,
        Menu,
    },
};
</script>