<template>
    <div class="fater-body-show">
        <el-card shadow="never">
            <div
                class="el-card-header"
                slot="header"
                style="font-size: 26px"
            >
            <i class="iconfont icon-r-find" style="font-size: 26px"></i>
                信息查询
            </div>
            <div>
                <el-form :inline="true" :model="qryForm">
                    <el-form-item>
                        <el-input
                            v-model="qryForm.userName"
                            placeholder="输入用户账号…"
                            autocomplete="off"
                        ></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model="qryForm.name"
                            placeholder="输入用户姓名…"
                            autocomplete="off"
                        ></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model="qryForm.phone"
                            placeholder="输入用户联系电话…"
                            autocomplete="off"
                        ></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-button
                            type="primary"
                            @click="getPageLikeInfo()"
                            style="font-size: 18px"
                        >
                            搜索</el-button
                        >
                    </el-form-item>
                </el-form>
            </div>
        </el-card>

        <el-card shadow="never">
            <div v-if="userType == 0" slot="header">
                <el-button
                    type="primary"
                    style="font-size: 18px"
                    @click="showAddWin()"
                >
                    
                    新增</el-button
                >
            </div>
            <div>
                <el-table
                    v-loading="loading"
                    element-loading-text="拼命加载中"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(124, 124, 124, 0.8)"
                    :data="pageInfos"
                    border
                >
                    <el-table-column
                        align="center"
                        type="index"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="id"
                        label="用户ID"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="userName"
                        label="用户账号"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="name"
                        label="用户姓名"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="gender"
                        label="用户性别"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="age"
                        label="用户年龄"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="phone"
                        label="联系电话"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="address"
                        label="联系地址"
                    ></el-table-column>
                    <el-table-column align="center" label="用户身份">
                        <template slot-scope="scope">
                            <span v-if="scope.row.type == 0">系统管理员</span>
                            <span v-if="scope.row.type == 1">社团管理员</span>
                            <span v-if="scope.row.type == 2">用户</span>
                        </template>
                    </el-table-column>
                    <el-table-column
                        align="center"
                        label="操作处理"
                        fixed="right"
                        width="250"
                    >
                        <template slot-scope="scope">
                            <el-button
                                type="primary"
                                @click="showUpdWin(scope.row)"
                                style="font-size: 18px"
                                >
                                编辑</el-button
                            >
                            <el-button
                                type="danger"
                                @click="delInfo(scope.row.id)"
                                style="font-size: 18px"
                                >
                                删除</el-button
                            >
                        </template>
                    </el-table-column>
                </el-table>
                <el-pagination
                    v-if="pageTotal >= 0"
                    style="margin-top: 15px"
                    @size-change="handleSizeChange"
                    @current-change="handleCurrentChange"
                    :current-page="pageIndex"
                    :page-sizes="[5, 10, 20, 50]"
                    :page-size="pageSize"
                    layout="total, sizes, prev, pager, next, jumper"
                    :total="totalInfo"
                >
                </el-pagination>
            </div>
        </el-card>

        <el-dialog title="添加信息" width="600px" :visible.sync="showAddFlag">
            <el-form label-width="90px" :model="usersForm">
                <el-row :gutter="15">
                    <el-col :span="24">
                        <el-form-item label="用户角色">
                            <el-select
                                v-model="usersForm.type"
                                placeholder="请选择角色"
                            >
                                <el-option :label="'系统管理员'" :value="0">
                                    系统管理员
                                </el-option>
                                <el-option :label="'社团管理员'" :value="1">
                                    社团管理员
                                </el-option>
                                <el-option :label="'用户'" :value="2">
                                    用户
                                </el-option>
                            </el-select>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户账号">
                            <el-input
                                v-model="usersForm.userName"
                                placeholder="请输入用户账号…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户密码">
                            <el-input
                                v-model="usersForm.passWord"
                                type="password"
                                placeholder="请输入用户密码…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户姓名">
                            <el-input
                                v-model="usersForm.name"
                                placeholder="请输入用户姓名…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户年龄">
                            <el-input
                                v-model="usersForm.age"
                                placeholder="请输入用户年龄…"
                                autocomplete="off"
                            ></el-input>
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
                            <el-input
                                v-model="usersForm.phone"
                                placeholder="请输入联系电话…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item label="联系地址">
                    <el-input
                        rows="4"
                        type="textarea"
                        v-model="usersForm.address"
                        placeholder="请输入联系地址…"
                        autocomplete="off"
                    ></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="showAddFlag = false" style="font-size: 18px"
                    >
                    取 消</el-button
                >
                <el-button
                    type="primary"
                    @click="addInfo()"
                    style="font-size: 18px"
                    >
                    确 定</el-button
                >
            </div>
        </el-dialog>

        <el-dialog title="修改信息" width="600px" :visible.sync="showUpdFlag">
            <el-form label-width="90px" :model="usersForm">
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户账号">
                            <el-input
                                v-model="usersForm.userName"
                                placeholder="请输入用户账号…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户密码">
                            <el-input
                                v-model="usersForm.passWord"
                                type="password"
                                placeholder="请输入用户密码…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-row :gutter="15">
                    <el-col :span="12">
                        <el-form-item label="用户姓名">
                            <el-input
                                v-model="usersForm.name"
                                placeholder="请输入用户姓名…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                    <el-col :span="12">
                        <el-form-item label="用户年龄">
                            <el-input
                                v-model="usersForm.age"
                                placeholder="请输入用户年龄…"
                                autocomplete="off"
                            ></el-input>
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
                            <el-input
                                v-model="usersForm.phone"
                                placeholder="请输入联系电话…"
                                autocomplete="off"
                            ></el-input>
                        </el-form-item>
                    </el-col>
                </el-row>
                <el-form-item label="联系地址">
                    <el-input
                        rows="4"
                        type="textarea"
                        v-model="usersForm.address"
                        placeholder="请输入联系地址…"
                        autocomplete="off"
                    ></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="showUpdFlag = false" style="font-size: 18px"
                    >
                    取 消</el-button
                >
                <el-button
                    type="primary"
                    @click="updInfo()"
                    style="font-size: 18px"
                    >
                    确 定</el-button
                >
            </div>
        </el-dialog>
    </div>
</template>

<style>
</style>

<script>
import {
    getPageUsers,
    addUsers,
    updUsers,
    delUsers,
    getLoginUser,
} from "../../api";


export default {
    data() {
        return {
            userType: "",
            pageInfos: [],
            pageIndex: 1,
            pageSize: 10,
            pageTotal: 0,
            totalInfo: 0,
            loading: true,
            showAddFlag: false,
            showUpdFlag: false,
            qryForm: {
                userName: "",
                name: "",
                phone: "",
            },
            usersForm: {
                id: "",
                userName: "",
                passWord: "",
                type: "",
                name: "",
                gender: "",
                age: "",
                phone: "",
                address: "",
            },
        };
    },
    methods: {
        getPageInfo(pageIndex, pageSize) {
            getPageUsers(pageIndex, pageSize).then((resp) => {
                this.pageInfos = resp.data.data;
                this.pageIndex = resp.data.pageIndex;
                this.pageSize = resp.data.pageSize;
                this.pageTotal = resp.data.pageTotal;
                this.totalInfo = resp.data.count;

                this.loading = false;
                
            });
        },
        getPageLikeInfo() {
            getPageUsers(
                1,
                this.pageSize,
                this.qryForm.userName,
                this.qryForm.name,
                this.qryForm.phone
            ).then((resp) => {
                this.pageInfos = resp.data.data;
                this.pageIndex = resp.data.pageIndex;
                this.pageSize = resp.data.pageSize;
                this.totalInfo = resp.data.count;
                this.pageTotal = resp.data.pageTotal;
                this.loading = false;
                
            });
        },
        handleSizeChange(pageSize) {
            this.getPageInfo(
                this.pageIndex,
                pageSize,
                this.qryForm.userName,
                this.qryForm.name,
                this.qryForm.phone
            );
        },
        handleCurrentChange(pageIndex) {
            this.getPageInfo(
                pageIndex,
                this.pageSize,
                this.qryForm.userName,
                this.qryForm.name,
                this.qryForm.phone
            );
        },
        initForm() {
            this.usersForm = {
                id: "",
                userName: "",
                passWord: "",
                name: "",
                gender: "",
                age: "",
                phone: "",
                address: "",
            };
        },

        showAddWin() {
            this.initForm();
            this.showAddFlag = true;
        },
        showUpdWin(row) {
            this.usersForm = row;
            this.showUpdFlag = true;
        },
        addInfo() {
            this.usersForm["status"] = 1;

            addUsers(this.usersForm).then((resp) => {
                this.$message({
                    message: resp.msg,
                    type: "success",
                });

                this.getPageInfo(1, this.pageSize);

                this.showAddFlag = false;
            });
        },
        updInfo() {
            updUsers(this.usersForm).then((resp) => {
                this.$message({
                    message: resp.msg,
                    type: "success",
                });

                this.getPageInfo(1, this.pageSize);

                this.showUpdFlag = false;
            });
        },
        delInfo(id) {
            this.$confirm("即将删除相关信息, 是否继续?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            }).then(() => {
                delUsers(id).then((resp) => {
                    this.$message({
                        message: resp.msg,
                        type: "success",
                    });

                    this.getPageInfo(1, this.pageSize);
                });
            });
        },
    },
    mounted() {
        this.getPageInfo(1, this.pageSize);

        getLoginUser(this.$store.state.token).then((resp) => {
            this.userType = resp.data.type;
        });
    },
};
</script>