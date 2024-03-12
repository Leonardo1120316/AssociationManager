/*
 * @Description: 
 * @Author: Rabbiter
 * @Date: 2022-06-11 13:41:22
 */
import axios from 'axios'
import qs from 'qs'
import {
	Message
} from 'element-ui'

axios.defaults.headers['Content-Type'] = 'application/x-www-form-urlencoded';

const service = axios.create({
	// withCredentials: true,
	baseURL: 'http://localhost:9211/association',
	timeout: 15000 // 请求超时时间
})

service.interceptors.request.use(config => {
	
	if(config.method === "post"){
		
		config.data = qs.stringify(config.data,  { indices: false });
	}
	
	return config;
}, error => {
	Promise.reject(error)
})

// respone拦截器
service.interceptors.response.use(
	resp => {

		if (resp.data.code != 2) {

			return resp.data;
		} else {

			Message({
				message: resp.data.msg,
				type: 'error',
				center: true
			});
			return Promise.reject(resp);
		}
	},
	error => {
		console.log(error);
		if (error.response == undefined ||
			error.response.data == undefined) {
			Message({
				message: error,
				type: 'error',
				center: true,
				duration: 5000,
			});
		} else {
			Message({
				message: error.response.data,
				type: 'error',
				center: true,
				duration: 5000,
			});
		}
		return Promise.reject(error);
	}
)

export default service
