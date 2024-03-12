package com.rabbiter.association.dao;

import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.rabbiter.association.entity.TeamTypes;

/**
 * 数据层处理接口
 * 社团类型
 */
@Repository("teamTypesDao")
public interface TeamTypesDao extends BaseMapper<TeamTypes> {
	

}