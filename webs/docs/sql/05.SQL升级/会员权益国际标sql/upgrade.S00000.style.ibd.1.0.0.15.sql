drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	-- ==================================================================================
    -- mysql升级版本
	-- ==================================================================================
    -- 获取当前数据用户
    -- SELECT MAX(USERNAME) INTO CURDB FROM USER_USERS; -- BSDB、FDDB、ECDB
    -- -----------------------------------------------------------
    -- 日期 人员 功能简单说明，不要写COMMIT，统一由模块提交
    -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
    -- 范围的SQL出现。
    -- 模版见：UPGRADE.TEMPLATE.SQL
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- 请注意：不要在本文件中填写对数据库表结构或者存储过程、视图等非数据类操作的脚本
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- -----------------------------------------------------------
    -- =======================2019年5月21日14:01:57 huangyaoyu======================BD_PACKAGE_EXT  修改字段类型====start====================
    set @num=0;
    set @tableName='BD_DQ';
    select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql = '
			create table BD_DQ
      (
		  PKID int(23) NOT NULL AUTO_INCREMENT COMMENT ''自增主键'',
		  CODE varchar(30) NOT NULL COMMENT ''代码'',
		  NAME varchar(30) NOT NULL COMMENT ''名称'',
		  FATHER varchar(30) COMMENT ''父级代码'',
		  CODES varchar(100) COMMENT ''层级所有代码值'',
		  ISCHILD bigint COMMENT ''是否包含子类（0 or other - 否，1 - 是）'',
		  PLEVEL bigint COMMENT ''当前节点层级（1-第一层，2-第二层，3-第三层...）'',
		  ISSHOW bigint COMMENT ''是否在前台显示（0 or other - 否，1 - 是）'',
		  CDATE datetime COMMENT ''新增时间'',
		  UDATE datetime COMMENT ''最后修改时间'',
		  BSCODE varchar(30) COMMENT ''基础关联代码'',
		  PRIMARY KEY (PKID)
      )comment=''标段（包）分类''
		';
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    -- =======================2019年5月21日14:01:57 huangyaoyu======================BD_PACKAGE_EXT  修改字段类型====end====================
end
$$
CALL P_IM_UPGRADE();