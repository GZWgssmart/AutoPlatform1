CREATE DATABASE IF NOT EXISTS auto_platform
DEFAULT CHARSET utf8 COLLATE utf8_general_ci;

USE auto_platform;

/**
用户表，包括管理员和普通用户
 */
DROP TABLE IF EXISTS t_user;
CREATE TABLE t_user(
  userId VARCHAR(128) PRIMARY KEY COMMENT '用户id',
  userEmail VARCHAR(100) NOT NULL UNIQUE COMMENT '登录邮箱',
  userPhone VARCHAR(20) NOT NULL COMMENT '手机号',
  userPwd VARCHAR(50) NOT NULL COMMENT '登录密码'
) ENGINE = InnoDB DEFAULT CHARSET  = utf8;

/**
公司表，每一个汽修店都对应一条记录
 */
DROP TABLE IF EXISTS t_company;
CREATE TABLE t_company(
  companyId VARCHAR(128) PRIMARY KEY COMMENT '公司id',
  companyName VARCHAR(100) NOT NULL COMMENT '公司名称',
  companyAddress VARCHAR(100) NOT NULL COMMENT '公司地址'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

/**
角色表，不同的公司可以创建不同的角色，如果companyId为空，则说明是通用角色
 */
DROP TABLE IF EXISTS t_role;
CREATE TABLE t_role(
  roleId VARCHAR(128) PRIMARY KEY COMMENT '角色id',
  roleName VARCHAR(20) COMMENT '角色名称',
  companyId VARCHAR(128) COMMENT '公司id'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

/**
模块表
 */
DROP TABLE IF EXISTS t_module;
CREATE TABLE t_module(
  moduleId VARCHAR(128) PRIMARY KEY COMMENT '模块id',
  moduleName VARCHAR(100) NOT NULL COMMENT '模块名称'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

/**
权限表
 */
DROP TABLE IF EXISTS t_permission;
CREATE TABLE t_permission(
  permissionId VARCHAR(128) PRIMARY KEY COMMENT '权限id',
  permissionName VARCHAR(100) NOT NULL COMMENT '权限名称',
  moduleId VARCHAR(128) NOT NULL COMMENT '模块id'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

/**
用户与角色的关联表
 */
DROP TABLE IF EXISTS t_user_role;
CREATE TABLE t_user_role(
  userRoleId VARCHAR(128) PRIMARY KEY COMMENT '用户与权限的关联id',
  userId VARCHAR(128) NOT NULL COMMENT '用户id',
  roleId VARCHAR(128) NOT NULL COMMENT '角色id',
  urCreatedTime DATETIME DEFAULT now() COMMENT '分配时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;

/**
角色与权限的关联表
 */
DROP TABLE IF EXISTS t_role_permission;
CREATE TABLE t_role_permission(
  rpId VARCHAR(128) PRIMARY KEY COMMENT '角色与权限的关联id',
  roleId VARCHAR(128) NOT NULL COMMENT '角色id',
  permissionId VARCHAR(128) NOT NULL COMMENT '权限id',
  rpCreatedTime DATETIME DEFAULT now() COMMENT '分配时间'
) ENGINE = InnoDB DEFAULT CHARSET = utf8;
