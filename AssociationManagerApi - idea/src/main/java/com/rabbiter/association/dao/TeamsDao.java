package com.rabbiter.association.dao;

import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.rabbiter.association.entity.Teams;

/**
 * 数据层处理接口
 * 社团信息
 */
@Repository("teamsDao")
public interface TeamsDao extends BaseMapper<Teams> {
	

}