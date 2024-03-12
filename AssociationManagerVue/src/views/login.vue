<template>
    <div class="login-container">
        <div class="login-body">
            <div class="login-title">社团管理系统</div>
            <div class="login-form">
                <el-form :model="loginForm" :rules="rules" ref="loginForm">
                    <el-form-item prop="userName">
                        <el-input type="text" v-model="loginForm.userName" suffix-icon="iconfont icon-r-user1"
                            placeholder="请输入您的账号"></el-input>
                    </el-form-item>
                    <el-form-item prop="passWord">
                        <el-input type="password" v-model="loginForm.passWord" suffix-icon="iconfont icon-r-lock"
                            placeholder="请输入您的密码">

                        </el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button style="
                                margin-top: 15px;
                                width: 100%;
                                background-color: #6495ed;
                                
                            " @click="submitForm('loginForm')" type="primary">
                            <b style="font-size: 22px;"> 用户登录</b></el-button><br />
                        <el-button style="width: 100%; margin-top: 5px" @click="showAddWin()" :underline="false"
                            type="info">
                            <b style="font-size: 22px;"> 注册新账号</b></el-button>
                    </el-form-item>
                </el-form>
            </div>
        </div>

        <el-dialog title="用户注册" width="700px" :modal="false" :visible.sync="showAddFlag">
            <el-form label-width="90px" :model="usersForm">
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户账号">
                            <el-input v-model="usersForm.userName" placeholder="请输入用户账号…" autocomplete="off"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户密码">
                            <el-input v-model="usersForm.passWord" type="password" placeholder="请输入用户密码…"
                                autocomplete="off"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户姓名">
                            <el-input v-model="usersForm.name" placeholder="请输入用户姓名…" autocomplete="off"></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户年龄">
                            <el-input v-model="usersForm.age" placeholder="请输入用户年龄…" autocomplete="off"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户性别">
                            <el-radio-group v-model="usersForm.gender">
                                <el-radio label="男"></el-radio>
                                <el-radio label="女"></el-radio>
                            </el-radio-group>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="联系电话">
                            <el-input v-model="usersForm.phone" placeholder="请输入联系电话…" autocomplete="off"></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item label="联系地址">
                    <el-input rows="4" type="textarea" v-model="usersForm.address" placeholder="请输入联系地址…"
                        autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="showAddFlag = false" style="font-size: 18px"> 取 消</el-button>
                <el-button type="primary" @click="addInfo()" style="font-size: 18px"> 确 定</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<style>
.login-container {
    position: fixed;
    left: 0;
    top: 0;
    bottom: 0;
    right: 0;
    background-image: url("../assets/back.jpg");
    background-repeat: no-repeat;
    background-size: 100%;
    /* background-color: #b0c4de; */
    /* background-image: url("data:image/svg+xml,%3Csvg width='6' height='6' viewBox='0 0 6 6' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='%23ffffff' fill-opacity='0.4' fill-rule='evenodd'%3E%3Cpath d='M5 0h1L0 6V5zM6 5v1H5z'/%3E%3C/g%3E%3C/svg%3E"); */
}

.login-win {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 550px;
    height: 300px;
    padding: 15px;
    border-radius: 5px;
    background-size: cover;
}

.login-body {
    padding: 30px 40px;

    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background-color: white;
    border-radius: 20px;
    border: 2px solid #6495ed;
    opacity: 0.9;
}

.login-title {
    text-align: center;
    font-size: 30px;
    font-weight: bold;
    color: #6495ed;
    margin-bottom: 35px;
}
</style>

<script>
import initMenu from "../utils/menus.js";
import { login, addUsers } from "../api/index.js";
export default {
    data() {
        return {
            showAddFlag: false,
            usersForm: {
                id: "",
                userName: "",
                passWord: "",
                name: "",
                gender: "",
                age: "",
                phone: "",
                address: "",
                type: 2,
                status: 1,
            },
            loginForm: {
                userName: "",
                passWord: "",
            },
            rules: {
                userName: [
                    {
                        required: true,
                        message: "用户账号必须输入",
                        trigger: "blur",
                    },
                ],
                passWord: [
                    {
                        required: true,
                        message: "用户密码必须输入",
                        trigger: "blur",
                    },
                ],
            },
        };
    },
    methods: {
        showAddWin() {
            this.showAddFlag = true;
        },
        submitForm(formName) {
            this.$refs[formName].validate((valid) => {
                if (valid) {
                    login(this.loginForm)
                        .then((res) => {
                            this.$store.commit("setToken", res.data);
                            sessionStorage.setItem("token", res.data);
                            initMenu(this.$router, this.$store);
                            this.$router.push("/index");
                        })
                } else {
                    return false;
                }
            });
        },
        addInfo() {
            if (this.usersForm.userName.trim() == '') {
                this.$message({
                    message: "请填写账号",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.passWord.trim() == '') {
                this.$message({
                    message: "请填写密码",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.name.trim() == '') {
                this.$message({
                    message: "请填写姓名",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.age.trim() == '') {
                this.$message({
                    message: "请填写年龄",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.gender.trim() == '') {
                this.$message({
                    message: "请选择性别",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.phone.trim() == '') {
                this.$message({
                    message: "请填写手机号码",
                    type: "warning",
                });
                return;
            }
            if (this.usersForm.address.trim() == '') {
                this.$message({
                    message: "请填写地址",
                    type: "warning",
                });
                return;
            }
            
            addUsers(this.usersForm).then((resp) => {
                if (resp.code == 0) {
                    this.$confirm("注册成功, 立即登陆?", "提示", {
                        confirmButtonText: "确定",
                        cancelButtonText: "取消",
                        type: "warning",
                    }).then(() => {
                        login({
                            userName: this.usersForm.userName,
                            passWord: this.usersForm.passWord,
                        }).then((res) => {
                            this.$store.commit("setToken", res.data);
                            sessionStorage.setItem("token", res.data);
                            initMenu(this.$router, this.$store);
                            this.$router.push("/index");
                        });
                    });
                } else {
                    this.$message({
                        message: resp.msg,
                        type: "warning",
                    });
                }
            });
        },
    },
    mounted() {

    }
};
</script>