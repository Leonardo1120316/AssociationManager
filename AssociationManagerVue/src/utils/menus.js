import {getLoginUser} from "../api";

// 系统管理员
export const adminMenus = {
    path: '/home',
    name: 'home',
    component: require("../views/home.vue").default,
    children: [
        {
            path: '/index',
            name: '首页',
            icon: "iconfont icon-r-home",
            component: require("../views/pages/Index.vue").default
        },
        {
            path: '/users',
            name: '用户管理',
            icon: "iconfont icon-r-user1",
            component: require("../views/pages/Users.vue").default
        },
        {
            path: '/teams',
            name: '社团管理',
            icon: "iconfont icon-r-mark1",
            component: require("../views/pages/Teams.vue").default
        },
        {
            path: '/teamTypes',
            name: '社团类型管理',
            icon: "iconfont icon-r-list",
            component: require("../views/pages/TeamTypes.vue").default
        },
        {
            path: '/members',
            name: '社团成员管理',
            icon: "iconfont icon-r-user2",
            component: require("../views/pages/Members.vue").default
        },
        {
            path: '/activities',
            name: '社团活动管理',
            icon: "iconfont icon-r-paper",
            component: require("../views/pages/Activities.vue").default
        },
        {
            path: '/notices',
            name: '通知信息管理',
            icon: "iconfont icon-r-edit",
            component: require("../views/pages/Notices.vue").default
        },
        {
            path: '/applyLogs',
            name: '入团申请',
            icon: "iconfont icon-r-add",
            component: require("../views/pages/ApplyLogs.vue").default
        },
        {
            path: '/payLogs',
            name: '费用管理',
            icon: "iconfont icon-r-shield",
            component: require("../views/pages/PayLogs.vue").default
        }
    ]
};

// 社团管理员
export const manMenus = {
    path: '/home',
    name: 'home',
    component: require("../views/home.vue").default,
    children: [
        {
            path: '/index',
            name: '首页',
            icon: "iconfont icon-r-home",
            component: require("../views/pages/Index.vue").default
        },
        {
            path: '/teams',
            name: '社团信息管理',
            icon: "iconfont icon-r-mark1",
            component: require("../views/pages/Teams.vue").default
        },
        {
            path: '/members',
            name: '社团成员管理',
            icon: "iconfont icon-r-user2",
            component: require("../views/pages/Members.vue").default
        },
        {
            path: '/applyLogs',
            name: '入团申请',
            icon: "iconfont icon-r-add",
            component: require("../views/pages/ApplyLogs.vue").default
        },
        {
            path: '/activities',
            name: '社团活动管理',
            icon: "iconfont icon-r-paper",
            component: require("../views/pages/Activities.vue").default
        },
        {
            path: '/notices',
            name: '通知信息管理',
            icon: "iconfont icon-r-edit",
            component: require("../views/pages/Notices.vue").default
        },
        {
            path: '/payLogs',
            name: '费用管理',
            icon: "iconfont icon-r-shield",
            component: require("../views/pages/PayLogs.vue").default
        }
    ]
};

export const memYMenus = {
    path: '/home',
    name: 'home',
    component: require("../views/home.vue").default,
    children: [
        {
            path: '/index',
            name: '首页',
            icon: "iconfont icon-r-home",
            component: require("../views/pages/Index.vue").default
        },
        {
            path: '/teams',
            name: '社团信息管理',
            icon: "iconfont icon-r-mark1",
            component: require("../views/pages/Teams.vue").default
        },
        {
            path: '/activities',
            name: '社团活动管理',
            icon: "iconfont icon-r-paper",
            component: require("../views/pages/Activities.vue").default
        },
        {
            path: '/applyLogs',
            name: '入团申请',
            icon: "iconfont icon-r-add",
            component: require("../views/pages/ApplyLogs.vue").default
        },
        {
            path: '/payLogs',
            name: '费用管理',
            icon: "iconfont icon-r-shield",
            component: require("../views/pages/PayLogs.vue").default
        }
    ]
};

export const memNMenus = {
    path: '/home',
    name: 'home',
    component: require("../views/home.vue").default,
    children: [
        {
            path: '/index',
            name: '首页',
            icon: "iconfont icon-r-home",
            component: require("../views/pages/Index.vue").default
        }
    ]
};

export default function initMenu(router, store){

    let token = null;
    if(store.state.token){

        token = store.state.token;
    }else{

        token = sessionStorage.getItem("token");
        store.state.token = sessionStorage.getItem("token");
    }

    getLoginUser(token).then(resp =>{

        if(resp.data.type == 0){
            router.addRoute(adminMenus);
            store.commit("setMenus", adminMenus);
        }
    
        if(resp.data.type == 1){
            router.addRoute(manMenus);
            store.commit("setMenus", manMenus);
        }

        if(resp.data.type == 2){

            if(resp.data.status == 0){

                router.addRoute(memNMenus);
                store.commit("setMenus", memNMenus);
            }else{

                router.addRoute(memYMenus);
                store.commit("setMenus", memYMenus);
            }
            
        }
    });
}

