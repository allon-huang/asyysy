drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	-- ==================================================================================
    -- mysql升级版本
	-- ==================================================================================
	
	-- --------------------------- 招标公告添加字段 start  ----------------------------- 
    set @num=0;
	set @tableName='BD_ZBGG';
	set @columnName='REMARKS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(1000)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_ZBGG';
	set @columnName='SOUFUND';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(1000)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- --------------------------- 招标公告添加字段 end  ----------------------------- 	


   -- --2018-07-26-14- hejw start --增加报名扩展表------------
	set @num=0;
	set @tableName='BD_TB_SIGNUP_EXT';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table BD_TB_SIGNUP_EXT (
					PKID int(23) NOT NULL AUTO_INCREMENT ,
					HYDM varchar(20) NOT NULL ,
					PACKID varchar(30) NOT NULL ,
					TBRNAME varchar(40) DEFAULT NULL ,
					TBRDQ varchar(100) DEFAULT NULL ,
					ZZS varchar(255) DEFAULT NULL ,
					ZZSDQ varchar(100) DEFAULT NULL,
					BJFS varchar(255) DEFAULT NULL ,
					BZ varchar(10) DEFAULT NULL ,
					BZVAL varchar(30) DEFAULT NULL ,
					AMT01 double(12,2) DEFAULT NULL ,
					TBSM varchar(200) DEFAULT NULL ,
					AMT02 double(12,2) DEFAULT NULL ,
					JHQ varchar(200) DEFAULT NULL ,
					DHDD varchar(200) DEFAULT NULL ,
					REMARK varchar(2000) DEFAULT NULL ,
					primary key (PKID)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	-- ============================ 投标报名表添加字段 start   ============================
    set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='ISZBHXR';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(11)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='ZSHTBJG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(20,2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='JGTZSM';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- ============================ 投标报名表添加字段 end   ============================
	
	-- ============================ 投标候选人公示表 非中标候选人title 添加字段 start ======================
	set @num=0;
	set @tableName='BD_HXRGS';
	set @columnName='UNTITLE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	-- ============================ 投标候选人公示表 非中标候选人title 添加字段 end ======================
	
	-- ============================ 组建评标委员会 线下选取专家 添加字段 start ======================
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='LEVEL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(1)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='PROVINCE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='PROVINCENAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='CITY';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='CITYNAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='MEMBERFILE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER';
	set @columnName='MEMBERFILENAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='LEVEL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(1)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='PROVINCE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='PROVINCENAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='CITY';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='CITYNAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='MEMBERFILE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	set @columnName='MEMBERFILENAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	-- ============================ 组建评标委员会 线下选取专家 添加字段 end ========================
	
	-- --2018-08-02 huiyu start --增加组建评标委员会线下选取专家历史记录表------------
	set @num=0;
	set @tableName='BD_JURY_MEMBER_HISTORY';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table BD_JURY_MEMBER_HISTORY (
					  PKID int(11) NOT NULL AUTO_INCREMENT ,
					  WYHDM varchar(20) NOT NULL ,
					  XH int(11) NOT NULL ,
					  ZJDM varchar(17) DEFAULT NULL ,
					  ZJMC varchar(50) DEFAULT NULL,
					  STATUS int(11) DEFAULT NULL ,
					  TYP char(1) DEFAULT NULL ,
					  SEX char(1) DEFAULT NULL ,
					  DEGREE varchar(30) DEFAULT NULL ,
					  MAJOR varchar(2000) DEFAULT NULL ,
					  UNIT_NAME varchar(100) DEFAULT NULL ,
					  ZYZGDJ varchar(50) DEFAULT NULL ,
					  NOTICE varchar(50) DEFAULT NULL ,
					  DATE00 datetime DEFAULT NULL ,
					  IS_CX char(1) DEFAULT NULL ,
					  ASSESS text ,
					  USERID varchar(80) DEFAULT NULL ,
					  PWD varchar(32) DEFAULT NULL ,
					  BDIDS varchar(500) DEFAULT NULL ,
					  IS_SING char(1) DEFAULT NULL ,
					  AGE decimal(6,0) DEFAULT NULL ,
					  JSZC varchar(50) DEFAULT NULL ,
					  SAMPLE_TIME int(11) DEFAULT NULL ,
					  ZJQDFS int(11) DEFAULT NULL ,
					  LXRTEL varchar(30) DEFAULT NULL ,
					  WYHNUM varchar(10) DEFAULT NULL ,
					  RECEIVEDATE datetime DEFAULT NULL ,
					  REASON varchar(200) DEFAULT NULL ,
					  PKREQUIRE decimal(8,0) DEFAULT NULL ,
					  SMSFLAG decimal(8,0) DEFAULT NULL ,
					  SAMPLE_TIME2 decimal(8,0) DEFAULT NULL ,
					  ISFLAG01 varchar(3) DEFAULT NULL ,
					  SUBSYSTEM varchar(30) DEFAULT NULL ,
					  CARDNO varchar(40) DEFAULT NULL ,
					  MAJORMC varchar(4000) DEFAULT NULL ,
					  SOURCESREMARK varchar(4000) DEFAULT NULL ,
					  OPTID001 varchar(50) DEFAULT NULL ,
					  OPTNAME001 varchar(50) DEFAULT NULL ,
					  OPTDATE001 datetime DEFAULT NULL ,
					  OPTID002 varchar(50) DEFAULT NULL ,
					  OPTNAME002 varchar(100) DEFAULT NULL ,
					  OPTDATE002 datetime DEFAULT NULL ,
					  REASON2 varchar(200) DEFAULT NULL ,
					  IS_JOB varchar(10) DEFAULT NULL ,
					  LEVEL varchar(1) DEFAULT NULL ,
					  PROVINCE varchar(6) DEFAULT NULL ,
					  PROVINCENAME varchar(100) DEFAULT NULL ,
					  CITY varchar(6) DEFAULT NULL ,
					  CITYNAME varchar(100) DEFAULT NULL ,
					  PRIMARY KEY (`PKID`)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- --2018-08-02 huiyu end --增加组建评标委员会线下选取专家历史记录表------------
	
   -- --2018-07-26-14- hejw start --------------

	-- --------------------------- 异议添加字段 start  ----------------------------- 
    set @num=0;
	set @tableName='BD_OBJECTION';
	set @columnName='ISRECALL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	-- --------------------------- 异议添加字段 end  -----------------------------
	

    -- --2018-07-26-14- hejw start --------------
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG55';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG56';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG60';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG61';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG65';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG66';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_MB_PBMB_NODE_BAK';
	set @columnName='XH';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(3,0)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- ----20180730 hejw 增加环节记录字段 -end-------------------


	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='ZZSDQ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(300) comment ''制造商 国家或地区''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='BJFS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''报价方式''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='BZ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(20) comment ''币种''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='TBSM';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200) comment ''投标声明'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='ZDDHDD';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200) comment ''指定到货地点''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

    -- ====================================================
	-- 表创建  技术评议投标人因素数据关联表
	set @num=0;
	set @tableName='BD_JURY_CENSOR_TK_MX';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table BD_JURY_CENSOR_TK_MX
      (
		  PKID bigint(23) NOT NULL AUTO_INCREMENT COMMENT ''主键'',
		  HYDM varchar(20) COMMENT ''投标方会员代码'',
		  PACKID varchar(30) COMMENT ''标段包编号'',
		  MBDM varchar(30) COMMENT ''模板代码'',
		  MBXH decimal(10,0) COMMENT ''模板序号'',
		  MBLX varchar(10) COMMENT ''模板类型 1-资审模板 2-评标模板'',
		  NODEXH decimal(10,0) COMMENT ''环节序号'',
		  TKXH decimal(10,0) COMMENT ''条款序号'',
		  JSCS varchar(200) COMMENT ''技术参数'',
		  NODELX varchar(20) COMMENT ''条款类型'',
		  CDATE datetime COMMENT ''创建时间'',
		  PRIMARY KEY (PKID)
      )comment=''技术评议投标人因素数据关联表''
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='JBHJS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(20) comment ''价格评议-进口环节税''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='GLYBF';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(20) comment ''价格评议-国内运保费''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='PBJG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(40) comment ''价格评议-评标价格''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='PBJGPX';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''价格评议-评标价格排序''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='FILEPATH65';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200) comment ''价格评议-开标当日中国银行首次发布的现汇卖出价-附件路径''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='FILENAME65';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''价格评议-开标当日中国银行首次发布的现汇卖出价-附件名称''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_JURY_CENSOR';
	set @columnName='GJYS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(2) comment ''关键因素 -不显示 1-是 0-否''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

    -- ----20180806 hejw end -------------

	-- --------------------------- 投诉添加字段 start  ----------------------------- 
    set @num=0;
	set @tableName='BD_TSSL';
	set @columnName='SLRESULT';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(400)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_TSSL';
	set @columnName='DFCONTENT';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(400)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_TSSL';
	set @columnName='CLRESULT';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(400)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	-- --------------------------- 投诉添加字段 end  -----------------------------

	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='TYP';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(3) comment ''1-专家  4-监标人'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	

	-- --- 2018-09-06 hejw 退回指定节点 start ---------------
	set @num=0;
	set @tableName='BD_EVALUATION_REVERT';
	set @columnName='flag55';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''商务评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	

	set @num=0;
	set @tableName='BD_EVALUATION_REVERT';
	set @columnName='flag60';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''技术评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_EVALUATION_REVERT';
	set @columnName='flag65';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''价格评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	-- ----------------
	set @num=0;
	set @tableName='BD_REVERT_CONFIRM';
	set @columnName='flag55';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''商务评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	

	set @num=0;
	set @tableName='BD_REVERT_CONFIRM';
	set @columnName='flag60';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''技术评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_REVERT_CONFIRM';
	set @columnName='flag65';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int comment ''价格评议环节-已评环节'''); 
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	-- --- 2018-09-06 hejw 退回指定节点 end ---------------
	
	
    -- 表创建  --评委主任终止评标 start----------
	set @num=0;
	set @tableName='BD_JUDGE_INVALID';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table BD_JUDGE_INVALID
      (
		  PKID bigint(23) NOT NULL AUTO_INCREMENT COMMENT ''主键'',
		  PROBID varchar(30) COMMENT ''招标项目编号'',
		  PROBNAME varchar(100) COMMENT ''招标项目名称'',
		  BDID varchar(30) COMMENT ''标段（包）编号'',
		  PACKNAME varchar(200) COMMENT ''标段包名称'',
		  WYHDM varchar(30) COMMENT ''委员会编号'',
		  XH bigint COMMENT ''成员序号（BD_JURY_MEMBER.XH）'',
		  ZJMC varchar(50) COMMENT ''评委主任专家名称(业主代表姓名)'',
		  STATUS bigint COMMENT ''状态 0-已保存 1-待确认 2-已终止 3-发起失败'',
		  DATE00 datetime COMMENT ''评委主任新增终止评标时间'',
		  DATE01 datetime COMMENT ''评委主任最后修改终止评标时间'',
		  DATE02 datetime COMMENT ''评委主任发送终止评标时间'',
		  DATE03 datetime COMMENT ''终止评标确认完成时间'',
		  INVALIDREASON varchar(1000) COMMENT ''备注(评委主任填写的终止理由)'',
		  INVALIDFILE varchar(200) COMMENT ''评委主任上传终止评标附件路径'',
		  INVALIDFILENAME varchar(100) COMMENT ''评委主任上传终止评标附件名称'',
		  SEALDATA varchar(200) COMMENT ''评委主任发送终止评标关联标识'',
		  IS_PRE bigint COMMENT ''1-资格预审委员会 0OrNull 评标委员会'',
		  OLDDATAFLAG bigint COMMENT ''区分新老数据标识 0-老数据 1-新数据'',
		  PRIMARY KEY (PKID)
      )comment=''评委主任终止评标申请表''
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- 表创建  --评委主任终止评标 end ----------
	
	-- 表创建  --评委确认终止评标申请 start----------
	set @num=0;
	set @tableName='BD_JUDGE_INVALID_CONFIRM';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table BD_JUDGE_INVALID_CONFIRM
      (
		  PKID bigint(23) NOT NULL AUTO_INCREMENT COMMENT ''主键'',
		  JUDGEINVALIDPKID bigint COMMENT ''评委主任终止评标id(BD_JUDGE_INVALID.PKID)'',
		  BDID varchar(30) COMMENT ''标段（包）编号'',
		  WYHDM varchar(30) COMMENT ''委员会编号'',
		  XH bigint COMMENT ''成员序号（BD_JURY_MEMBER.XH）'',
		  ZJMC varchar(50) COMMENT ''专家名称(业主代表姓名)'',
		  STATUS bigint COMMENT ''状态 1-待确认 2-同意 3-不同意'',
		  DATE00 datetime COMMENT ''评委确认终止评标时间'',
		  CONFIRMREMARK varchar(1000) COMMENT ''备注(评委填写的是否同意终止的原因)'',
		  SEALDATA varchar(200) COMMENT ''评委确认终止评标关联标识'',
		  PRIMARY KEY (PKID)
      )comment=''评委确认终止评标申请''
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- 表创建  --评委主任终止评标 end ----------
	
	


	-- ==================================================================================
	
	
	
	
	
	-- =======================20181017 huangyaoyu======================BD_JURY_SIGN falg67 字段增加====start==========================
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='REMARK';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255) comment ''评标最终汇总-备注''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG67';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0) comment ''服务及其他评议''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================20181017 huangyaoyu======================BD_JURY_SIGN falg67 字段增加====end==========================
	
	-- 表创建  --综合评标最终评分-扩展表 start----------
	set @num=0;
	set @tableName='BD_JURY_FINAL_SCORE';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table BD_JURY_FINAL_SCORE
			(
			PKID bigint(23) NOT NULL AUTO_INCREMENT COMMENT ''主键'',
			BDID varchar(30) COMMENT ''标段（包）编号'',
			WYHDM varchar(30) COMMENT ''委员会编号'',
			HYDM varchar(30) COMMENT ''会员代码(投标方)'',
			SCORE decimal(10,0) COMMENT ''最终得分'',
			CORRSCORE decimal(10,0) COMMENT ''评分修正值'',
			AVGSCORE decimal(10,0) COMMENT ''均分'',
			SUMSCORE decimal(10,0) COMMENT ''总分'',
			MBXH varchar(255) COMMENT ''模板序号'',
			NODELX varchar(255) COMMENT ''55-商务评议环节   60-技术评议环节   65-价格评议环节 70-服务与其他环节'',
			CDATE datetime COMMENT ''创建时间''
			)comment=''综合评标最终评分-扩展表''
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- 表创建  --综合评标最终评分-扩展表 end ----------
		
	-- =======================20181105 huangyaoyu======================BD_JURY_SIGN FLAG70 字段增加====start==========================
			set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FLAG70';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' decimal(22,0) comment ''服务及其他评议-个数''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================20181105 huangyaoyu======================BD_JURY_SIGN FLAG70 字段增加====end==========================
	
	
	-- ======================= wyd======================BD_JURY_SIGN  字段增加====start==========================
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FAX';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(40) comment ''传真''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='WINBIDREASON';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500) comment ''中标候选人排名及主要理由''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='NOTWINBIDREASON';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500) comment ''其他投标人未进入中标候选人名单的主要理由''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FILENAME01';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500) comment ''上传委员会签字文件,文件名称''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY_SIGN';
	set @columnName='FILEPATH01';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500) comment ''上传委员会签字文件,文件路径''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	-- ======================= wyd======================BD_JURY_SIGN  字段增加====end==========================
	
	
	
	
		-- =======================20181109 huangyaoyu======================BD_TB_SIGNUP_EXT ZZSEN 字段增加====start==========================
			set @num=0;
	set @tableName='BD_TB_SIGNUP_EXT';
	set @columnName='ZZSEN';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255) comment ''英文版评标结果公告-制造商''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
			set @num=0;
	set @tableName='BD_TB_SIGNUP_EXT';
	set @columnName='ZZSDQEN';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255) comment ''英文版评标结果公告-制造商-国家或地区''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================20181109 huangyaoyu======================BD_TB_SIGNUP_EXT FLAG70 字段增加====end==========================
	
	-- =======================2018年11月21日11:33:11 wyd======================BD_TB_SIGNUP 修改字段类型====start==========================
	set @num=0;
    set @tableName='BD_TB_SIGNUP';
    set @columnName='ZSHTBJG';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	set @num=0;
    set @tableName='BD_TB_SIGNUP';
    set @columnName='PBPRICE';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	-- =======================2018年11月21日11:33:11 wyd======================BD_TB_SIGNUP 修改字段类型====end==========================
	
	
	-- =======================2018年11月22日19:26:55 wyd======================BD_DB_ZBJGGG  字段增加====start==========================
			set @num=0;
	set @tableName='BD_DB_ZBJGGG';
	set @columnName='ZBJGFBSJ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' datetime comment ''中标结果公告发布时间''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
			set @num=0;
	set @tableName='BD_DB_ZBJGGG_EN';
	set @columnName='ZBJGFBSJ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' datetime comment ''中标结果公告发布时间''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================2018年11月22日19:26:58 wyd======================BD_DB_ZBJGGG  字段增加====end==========================
	
	
	
	
	-- =======================2018年11月24日15:54:55 hyy======================BD_PACKAGE_EXT  字段增加====start==========================
			set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='BIDDINGAGENCY';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''评标结果公告en-Bidding Agency''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
			set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='PURCHASERS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''评标结果公告en-Purchasers''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================2018年11月24日15:54:55 hyy======================BD_PACKAGE_EXT  字段增加====end==========================
	
	
	-- =======================2018年11月29日09:33:11 whn======================BD_PACKAGE 修改字段类型====start==========================
	set @num=0;
    set @tableName='BD_PACKAGE';
    set @columnName='CONTENTENG';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' text');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	-- =======================2018年11月29日09:33:11 whn======================BD_PACKAGE 修改字段类型====end==========================
	
	
	-- =======================2018年12月5日09:33:11 whn======================BD_DB_ZBJGGG_EN 修改字段类型====start==========================
	set @num=0;
    set @tableName='BD_DB_ZBJGGG_EN';
    set @columnName='BIDDING_CONTENT_EN';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' text');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	-- =======================2018年12月5日09:33:11 whn======================BD_DB_ZBJGGG_EN 修改字段类型====end==========================
	
	-- =======================2018年12月27日11:50:57 wyd======================BD_TB_SIGNUP  字段增加====start====================
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP_EXT';
	set @columnName='HYNAMEEN';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''投标单位英文名''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	-- =======================2018年12月27日11:50:57 wyd======================BD_TB_SIGNUP  字段增加====end==========================
	
    -- =======================2019年1月16日10:45:57 wh======================BD_REFUND_APPLY  修改字段类型====start====================
	

	set @num=0;
	set @tableName='BD_REFUND_APPLY';
	set @columnName='PKID';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=1 then
		set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' bigint(23) AUTO_INCREMENT');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	-- =======================2019年1月16日10:45:57 wh======================BD_REFUND_APPLY  修改字段类型====start====================

	-- =======================2019年1月4日23:46:43 wyd======================BD_TB_SIGNUP  字段增加====start==========================
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='PFBF';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(3) comment ''评分办法''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='PFJGDF';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(3) comment ''评分价格得分''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='BRHXYY';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500) comment ''表决-不进入中标候选人名单原因''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	

	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='BJ_FILEPATH';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255) comment ''表决_附件路径''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='BJ_FILENAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(255) comment ''表决_附件名称''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='BJ_FLAGE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(2) comment ''表决标识（1，提交  0，null 正常）''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_PACKAGE';
	set @columnName='PACKNAMEENG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100) comment ''标段包名称英文版''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_PACKAGE';
	set @columnName='CONTENTENG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' text comment ''标段包内容英文版''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_PACKAGE';
	set @columnName='ZZSTEP0';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(6) comment ''终止步骤''');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	-- =======================2019年1月4日23:46:43 wyd======================BD_TB_SIGNUP  字段增加====end==========================
	
	
	-- =======================2019年1月25日10:45:57 wh======================BD_PACKAGE_EXT  修改字段类型====start====================
	
	set @num=0;
    set @tableName='BD_PACKAGE_EXT';
    set @columnName='ZBJG';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	-- =======================2019年1月25日10:45:57 wh======================BD_PACKAGE_EXT  修改字段类型====start====================
	


	-- =======================2019年1月26日15:01:57 huangyaoyu======================BD_PACKAGE_EXT  修改字段类型====start====================
	
    set @num=0;
    set @tableName='BD_PACKAGE_EXT';
    set @columnName='ZBSMC';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(500)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	set @num=0;
    set @tableName='BD_PACKAGE_EXT';
    set @columnName='ZBSDZ';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(500)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;

    set @num=0;
    set @tableName='BD_PACKAGE_EXT';
    set @columnName='ZZSMC';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(500)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	set @num=0;
    set @tableName='BD_PACKAGE_EXT';
    set @columnName='ZZSDZ';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=1 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,' varchar(500)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	-- =======================2019年1月26日15:01:57 huangyaoyu======================BD_PACKAGE_EXT  修改字段类型====start====================
	
	
end
$$
CALL P_IM_UPGRADE();