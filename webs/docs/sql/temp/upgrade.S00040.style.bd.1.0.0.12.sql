declare
  curdb varchar(255); -- 当前用户（数据名称）
  msg varchar2(500);
  num int;
  curVersion varchar2(30);
  tmp1 varchar2(255);
  tmp2 varchar2(255);
begin
  num:=0;
  select count(0) into num from SYS_SYSINFO where sysid='BD';
  if num = 0 then
    RAISE_APPLICATION_ERROR(-20000,'当前升级脚本与数据库不匹配');
  end if;
  -- 获取当前数据用户
  -- select max(username) into curdb from user_users; -- BSDB、FDDB、ECDB
  -------------------------------------------------------------
  -- 日期 人员 功能简单说明，不要写commit，统一由模块提交
  -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
  -- 范围的SQL出现。
  -- 模版见：upgrade.template.sql
  -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -- 请注意：不要在本文件中填写对数据类的操作，本文件仅对数据库表结构或者存储过程、视图等脚本的操作
  -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  -------------------------------------------------------------

	------------add by zhaoy 2018年05月08日 start---------------
	-- 增加 tknr_tmp
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('tknr_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
	end if;
	-- 赋值 tknr_tmp
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('tknr_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set tknr_tmp = csvalue';
	end if;
	-- 清空 tknr
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('csvalue');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set csvalue=null';
	end if;
	-- 修改 tknr
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('csvalue');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(4000))';
	end if;
	-- 赋值 tknr
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('csvalue');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set csvalue = tknr_tmp';
	end if;
	-- 删除 tknr_tmp
	tmp1:=upper('BD_CSSZ');
	tmp2:=upper('tknr_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by zhaoy 2018年05月08日 end---------------



  ------------add by nieche 2018年05月30日 start---------------
    --bd_fb_zbcssz    tbyxqts 字段长度从2改成4
    -- 增加 tbyxqts_tmp
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(4))';
  end if;
-- 赋值 tbyxqts_tmp
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set tbyxqts_tmp = tbyxqts';
  end if;
-- 清空 tknr
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set tbyxqts=null';
  end if;
-- 修改 tknr
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(4))';
	end if;
-- 赋值 tknr
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('tbyxqts');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set tbyxqts = tbyxqts_tmp';
	end if;
-- 删除 tbyxqts_tmp
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('tbyxqts_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by nieche 2018年05月30日 end---------------
	------------add by zhaoy 2018年11月24日 end---------------
	tmp1:=upper('BD_JURY_SIGN');
	tmp2:=upper('AVOID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否回避评标''';
	end if;

	tmp1:=upper('BD_JURY_SIGN');
	tmp2:=upper('HBREASON');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回避原因''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILEPATH1');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件路径''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILEPATH2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件路径''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILEPATH3');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件路径''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILENAME1');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILENAME2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILENAME3');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
	end if;

	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('DJZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''递交状态''';
	end if;
	------------add by zhaoy 2018年11月24日 end---------------
	------------add by zhaoy 2018年11月26日 start---------------
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('ZBRZZ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人职责''';
	end if;

	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('DLJGZZ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构职责''';
	end if;

	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('TBRZZ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人职责''';
	end if;

	tmp1:=upper('BD_JURY_REQUIRE');
	tmp2:=upper('ZYZGNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职业资格等级名称''';
	end if;

	tmp1:=upper('BD_JURY_REQUIRE');
	tmp2:=upper('ZYZGCODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职业资格等级代码''';
	end if;


	------------add by zhaoy 2018年11月26日 end---------------
	------------add by zhaoy 2018年11月29日 start---------------
	--记录职责分工信息
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_PACK_ZZFG');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
    -- 建表
    execute immediate '
	  create table BD_PACK_ZZFG  (
        PKID                 INT                             not null,
        BDID				 VARCHAR2(23)                    not null,
        PACKNAME			 VARCHAR2(2000),
        CYNAME			 	 VARCHAR2(100),
        ZBRZZ			     VARCHAR2(1000),
        constraint PK_BD_PACK_ZZFG primary key (PKID)
    )';
	execute immediate 'comment on column BD_PACK_ZZFG.PKID is''编号''';
	execute immediate 'comment on column BD_PACK_ZZFG.BDID is''标段宝编号''';
	execute immediate 'comment on column BD_PACK_ZZFG.PACKNAME is''标段包名称''';
	execute immediate 'comment on column BD_PACK_ZZFG.CYNAME is''成员名称''';
	execute immediate 'comment on column BD_PACK_ZZFG.ZBRZZ is''职责代码''';
   end if;

 	num:=0;
    tmp1:=upper('BD_PACK_ZZFG_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_PACK_ZZFG_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;

    tmp1:=upper('BD_CONTRACT');
	tmp2:=upper('CONOPT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同验证人''';
	end if;

	tmp1:=upper('BD_CONTRACT');
	tmp2:=upper('CONOPTDATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同验证时间''';
	end if;

	tmp1:=upper('BD_REWARD');
	tmp2:=upper('TYP');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''类型1奖励 2惩罚''';
	end if;

	---------------------
------------add by zhaoy 2018年11月29日 end---------------
------------add by zhaoy 2018年12月21日 start---------------
	-- 增加 tknr_tmp
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('dlzbdm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	end if;
	-- 赋值 tknr_tmp
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('dlzbdm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set dlzbdm_tmp = dlzbdm';
	end if;
	-- 清空 tknr
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('dlzbdm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set dlzbdm=null';
	end if;
	-- 修改 tknr
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('dlzbdm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(100))';
	end if;
	-- 赋值 tknr
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('dlzbdm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set dlzbdm = dlzbdm_tmp';
	end if;
	-- 删除 tknr_tmp
	tmp1:=upper('BD_CBD_SUBPROJECTSSZ');
	tmp2:=upper('dlzbdm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by zhaoy 2018年12月21日 end---------------

    ------------add by huangyaoyu 2019年6月26日 end---------------
    tmp1:=upper('BD_PROJECT');
    tmp2:=upper('PSHQB_FILE_PATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件评审汇签表-路径''';
    end if;

    tmp1:=upper('BD_PROJECT');
    tmp2:=upper('PSHQB_FILE_NAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件评审汇签表-名称''';
    end if;
    ------------add by huangyaoyu 2019年6月26日 end---------------

	------------add by huangyaoyu 2019年7月25日 end---------------
 	tmp1:=upper('BD_ZBGG');
    tmp2:=upper('DLJGZBID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
       execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(100))';
    end if;
    ------------add by huangyaoyu 2019年7月25日 end---------------


	------------add by huangyaoyu 2019年8月15日 start---------------
 	tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('WTXYFILEPATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目委托协-附件路径''';
    end if;
    
 	tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('WTXYFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目委托协议-附件名称''';
    end if;
    ------------add by huangyaoyu 2019年8月15日 end---------------


	------------add by huangyaoyu 2019年9月2日 start---------------
	------------add by huangyaoyu 2019年9月2日 start---------------
	tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('RECOR_DOPT_NAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录 操作员名称''';
    end if;
    
	tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('YSJLQRR_NAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审记录   确认人名称''';
    end if;

    ------------add by huangyaoyu 2019年9月2日 end---------------

	------------add by huangyaoyu 2019年9月5日 start---------------
	tmp1:=upper('BD_TRADE_TYPE');
    tmp2:=upper('JCW_FL_NAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招投标对应军采网分类名称''';
    end if;

    ------------add by huangyaoyu 2019年9月5日 end---------------
	------------add by huangyaoyu 2019年9月12日 start---------------
	tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('JCW_PARENT_ID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(30) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''军采网-父公告ID''';
    end if;

    ------------add by huangyaoyu 2019年9月12日 end---------------

	------------add by huangyaoyu 2019年09月19日 start-------------
	tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('JCW_PUSH_FLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''军采网-是否推送0orNUll-否 1-是''';
    end if;
    
	tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('JCW_TYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50) )';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''军采网-采购领域''';
    end if;

	------------add by huangyaoyu 2019年09月19日 end-------------
	------------add by huangyaoyu 2019年09月19日 start-------------
	-- 修改 招标异常异常描述
	tmp1:=upper('BD_ZB_YC');
	tmp2:=upper('YCMS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
	end if;
	------------add by huangyaoyu 2019年09月19日 end-------------



    -------------------------------------------------------------------------------------------------------
end;
