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
                            v-model="qryForm.teamName"
                            placeholder="输入社团名称…"
                            autocomplete="off"
                        ></el-input>
                    </el-form-item>
                    <el-form-item>
                        <el-input
                            v-model="qryForm.userName"
                            placeholder="输入用户姓名…"
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
                        prop="userId"
                        label="成员ID"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="userName"
                        label="成员姓名"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="userGender"
                        label="成员性别"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="userAge"
                        label="成员年龄"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="userPhone"
                        label="成员电话"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="teamName"
                        label="社团名称"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        prop="createTime"
                        label="入团时间"
                    ></el-table-column>
                    <el-table-column
                        align="center"
                        label="操作处理"
                        fixed="right"
                        width="140"
                    >
                        <template slot-scope="scope">
                            <el-button
                                type="danger"
                                style="font-size: 18px"
                                @click="delInfo(scope.row.id)"
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
    </div>
</template>

<style>
</style>

<script>
import { getPageMembers, delMembers } from "../../api";


export default {
    data() {
        return {
            pageInfos: [],
            pageIndex: 1,
            pageSize: 10,
            pageTotal: 0,
            totalInfo: 0,
            loading: true,
            qryForm: {
                token: this.$store.state.token,
                teamName: "",
                userName: "",
            },
        };
    },
    methods: {
        getPageInfo(pageIndex, pageSize) {
            getPageMembers(pageIndex, pageSize, this.qryForm.token).then(
                (resp) => {
                    this.pageInfos = resp.data.data;
                    this.pageIndex = resp.data.pageIndex;
                    this.pageSize = resp.data.pageSize;
                    this.pageTotal = resp.data.pageTotal;
                    this.totalInfo = resp.data.count;

                    this.loading = false;
					
                }
            );
        },
        getPageLikeInfo() {
            getPageMembers(
                1,
                this.pageSize,
                this.qryForm.token,
                this.qryForm.teamName,
                this.qryForm.userName
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
                this.qryForm.token,
                this.qryForm.teamName,
                this.qryForm.userName
            );
        },
        handleCurrentChange(pageIndex) {
            this.getPageInfo(
                pageIndex,
                this.pageSize,
                this.qryForm.token,
                this.qryForm.teamName,
                this.qryForm.userName
            );
        },
        delInfo(id) {
            this.$confirm("移除成员将移除相关记录，确认继续吗?", "提示", {
                confirmButtonText: "确定",
                cancelButtonText: "取消",
                type: "warning",
            }).then(() => {
                delMembers(id).then((resp) => {
                    if (resp.code == 0) {
                        this.$message({
                            message: resp.msg,
                            type: "success",
                        });

                        this.getPageInfo(1, this.pageSize, this.qryForm.token);
                    } else {
                        this.$message({
                            message: resp.msg,
                            type: "warning",
                        });
                    }
                });
            });
        },
    },
    mounted() {
        this.getPageInfo(1, this.pageSize, this.qryForm.token);
    },
};
</script>