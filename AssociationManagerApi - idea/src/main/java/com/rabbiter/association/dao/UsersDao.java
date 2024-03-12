package com.rabbiter.association.dao;

import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.rabbiter.association.entity.Users;

/**
 * 数据层处理接口
 * 系统用户
 */
@Repository("usersDao")
public interface UsersDao extends BaseMapper<Users> {
	

}