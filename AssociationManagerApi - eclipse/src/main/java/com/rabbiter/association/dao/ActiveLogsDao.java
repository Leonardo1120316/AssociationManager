package com.rabbiter.association.dao;

import org.springframework.stereotype.Repository;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;

import com.rabbiter.association.entity.ActiveLogs;

/**
 * 数据层处理接口
 * 报名记录
 */
@Repository("activeLogsDao")
public interface ActiveLogsDao extends BaseMapper<ActiveLogs> {
	

}