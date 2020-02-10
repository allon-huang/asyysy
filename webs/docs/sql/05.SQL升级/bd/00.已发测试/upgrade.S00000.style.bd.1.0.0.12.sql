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
   tmp1:=upper('BD_TD_DD');
   tmp2:=upper('ISDLFWF');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
      execute immediate 'alter table '||tmp1||' add '||tmp2||' Integer';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否扣除代理服务费''';
   end if; 
   
   tmp1:=upper('BD_TD_DD');
   tmp2:=upper('DLFWF');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
      execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(20,2)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理服务费''';
   end if; 
   
   ------------2017-12-12-11-03-  hejw start-------------
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('SPECIAL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标审核 0-不申请 1-申请'''; 
    end if;    
    
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('SPECIALSTATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(3)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标状态 0-不申请保存 1-申请保存 3-审核不通过 7-审核通过'''; 
    end if; 
    
        tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(600)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-申请原因'''; 
    end if;    
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-文件路径'''; 
    end if; 
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-文件原名称'''; 
    end if; 
   ------------2017-12-12-11-03-  hejw end-------------

   -- 增加 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(400))';
	end if;
-- 赋值 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbiddm_tmp = winbiddm';
	end if;
-- 清空 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbiddm=null';
	end if;
-- 修改 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(400))';
	end if;
-- 赋值 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbiddm = winbiddm_tmp';
	end if;
-- 删除 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
------------修改有数据字段长度结束---------------------------------------------------
    --------------add by zhaoy 2017年12月12日 start-----------------
    -- 增加 审核人
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('OPTXETSNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额特殊招标审核人''';
	end if;
	-- 增加 审核时间
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('OPTXETSDATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额特殊招标审核时间''';
	end if;
	-- 增加 审核意见
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('OPTXETSREASON');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(600))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额特殊招标审核意见''';
	end if;
    --------------add zhaoy 2017年12月12日 end-----------------  
    --------------add zhaoy 2017年12月13日 start-----------------  
	-- 增加 更正中标金额字段	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('GZZBJE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,2))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更正中标金额''';
	end if;

    --------------add zhaoy 2017年12月12日 end----------------- 
   
   -- 新增非依法必招时间节点参数表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_CSSZ_STANDARD');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
			create table BD_CSSZ_STANDARD  
			(
		   CSKEY                VARCHAR2(30)                    not null,
		   TYPE                 INT                         not null,
		   CSMC                 VARCHAR2(100),
		   CSVALUE              VARCHAR2(1000),
		   MRP                  VARCHAR2(40),
		   OPT                  VARCHAR2(80),
		   REMARK               VARCHAR2(100),
		   FLAG0                INT,
		   UNIT                 VARCHAR2(30),
		   ORDERNO              INTEGER,
		   CSBZ                 VARCHAR2(100),
		   constraint PK_BD_CSSZ_STANDARD primary key (CSKEY, TYPE)
		)';
		execute immediate 'comment on column BD_CSSZ_STANDARD.CSKEY is ''参数字段''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.TYPE is ''模板类型''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.CSMC is ''参数名称''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.CSVALUE is ''参数内容''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.MRP is ''默认值''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.OPT is ''操作员''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.REMARK is ''备注描述''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.FLAG0 is ''状态0-不启用 1-启用''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.UNIT is ''单位''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.ORDERNO is ''排序''';
		execute immediate 'comment on column BD_CSSZ_STANDARD.CSBZ is ''参数备注''';
    end if;
   
      -- 增加 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	end if;
-- 赋值 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbidmc_tmp = winbidmc';
	end if;
-- 清空 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbidmc=null';
	end if;
-- 修改 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
	end if;
-- 赋值 tknr
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set winbidmc = winbidmc_tmp';
	end if;
-- 删除 tknr_tmp
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
------------修改有数据字段长度结束---------------------------------------------------
   
   --------2017-12-20 hejw start---------------------------------
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('CERTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''相关证书名称''';
    end if;
  
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('CERTDM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''相关证书编号''';
    end if;
   --------2017-12-20 hejw end---------------------------------
   ------------add by lijb 2017年12月25日 start--------------- 
    -- 新增专家请假记录表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_LEAVE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EXPERT_LEAVE  (
           PKID                 INTEGER                        not null,
           ZJDM                 VARCHAR2(100),
           STARTTIME            DATE,
           ENDTIME              DATE,
           STATUS               VARCHAR(100),
           CDATE                DATE,
           constraint PK_BD_EXPERT_LEAVE primary key (PKID)
        )';

        execute immediate 'comment on table BD_EXPERT_LEAVE is ''专家请假记录表''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.PKID is ''自增主键''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.ZJDM is ''专家代码''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.STARTTIME is ''开始时间''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.ENDTIME is ''结束时间''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.STATUS is ''状态1:生效;2:撤销3:结束''';
        execute immediate 'comment on column BD_EXPERT_LEAVE.CDATE is ''创建时间''';
    end if;

    num:=0;
    tmp1:=upper('BD_EXPERT_LEAVE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_EXPERT_LEAVE_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
 
  -- 增加 专家来源
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('EXPERTSOURCE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家来源1:专家库管理新增;2:模版导入;3:前台自荐专家申请''';
	end if;
  
  -- 增加 视频时段
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('VIDEOTIME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''视频时段(记录上次观看的时段.实现断点续看)''';
	end if;
  
  -- 增加 视频时段
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('VIDEOSTATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否观看完视频0:未观看完;1观看完''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('IDCARDFILE2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证附件反面''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('IDCARDFILENAME2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证附件反面原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('DIPLOMAFILE2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书附件''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('DIPLOMAFILENAME2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书附件原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('DIPLOMACODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书编号''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('HIGHESTDEGREE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高学位''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('OTHERINFO');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''单位信息(其他)''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('NOWMAJORTIME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''现从事专业开始时间''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('AGEFILE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的附件''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('AGEFILENAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的附件原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('AGEEXPLAIN');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的说明''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('CONDITION');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否同意专家入库条件;同意Agree''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('SMSFLAG');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1为已发送短信''';
	end if;
  
  tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('AGING');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''用于6月1日为提交审核的专家使用----提交过状态为submit''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('IDCARDFILE2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证附件反面''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('IDCARDFILENAME2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证附件反面原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('DIPLOMAFILE2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书附件''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('DIPLOMAFILENAME2');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书附件原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('DIPLOMACODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书编号''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('HIGHESTDEGREE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高学位''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('OTHERINFO');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''单位信息(其他)''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('NOWMAJORTIME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''现从事专业开始时间''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('AGEFILE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的附件''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('AGEFILENAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的附件原名称''';
	end if;
  
  tmp1:=upper('BD_EXPERT');
	tmp2:=upper('AGEEXPLAIN');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄超过70岁的说明''';
	end if;
   ------------add by lijb 2017年12月25日 end---------------
   
   
   -------------add by nieche 2017年12月26日 start-------------
  --增加货物类项目标的物的技术规格
    tmp1:=upper('bd_project_item');
    tmp2:=upper('technicalSpecifications');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''货物类项目标的物的技术规格''';
    end if;
    
    --增加货物类招标项目标的物的技术规格
    tmp1:=upper('BD_SUBPROJECT_ITEM');
    tmp2:=upper('technicalSpecifications');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''货物类招标项目标的物的技术规格''';
    end if;
    
    --增加货物类标段包标的物的技术规格
    tmp1:=upper('BD_PACKAGE_ITEM');
    tmp2:=upper('technicalSpecifications');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''货物类标段包标的物的技术规格''';
    end if;
    
    --增加招标公告的服务和货物类招标出资比例
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('proportion');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务和货物类招标出资比例''';
    end if;
    
    --增加招标公告的服务类招标项目建设规模
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('scale');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务类招标项目建设规模''';
    end if;
    
    --增加招标公告的货物类招标的货物名称
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('itemName');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''货物类招标的货物名称''';
    end if;
    
    --增加投标邀请书的服务类招标项目建设规模
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('scale');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务类招标项目建设规模''';
    end if;
    
    --增加投标邀请书的货物类招标的货物名称
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('itemName');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''货物类招标的货物名称''';
    end if;
    
    --增加投标邀请书的开标时间
	tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('kbsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标时间''';
    end if;
	
   -----------------2017-12-26- hejw start ---------------------------
    tmp1:=upper('BD_ENTRUST_FILE');
    tmp2:=upper('JD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''节点'''; 
    end if;  
   -----------------2017-12-26- hejw end ---------------------------
   
	--增加候选人中标候选人响应招标文件要求的资格能力条件
    tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('CONTENT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人响应招标文件要求的资格能力条件''';
	end if;
   ------------add by lijb 2017年12月27日 start--------------- 
    tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('REMARKS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT_ZJ modify( REMARKS VARCHAR2(4000))';
	end if;	
	
  tmp1:=upper('BD_EXPERT_TEMP');
  tmp2:=upper('NOWMAJORTIME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''现从事专业开始时间''';
  end if;
  
  tmp1:=upper('BD_EXPERT_TEMP');
	tmp2:=upper('HIGHESTDEREE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高学位''';
	end if;
  
  tmp1:=upper('BD_EXPERT_TEMP');
	tmp2:=upper('DIPLOMACODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学位证书编号''';
	end if;
  
  tmp1:=upper('BD_EXPERT_TEMP');
	tmp2:=upper('RESTEL');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备用联系方式''';
	end if;
	------------add by lijb 2017年12月27日 end---------------

	------------add by jinyanhui 2017年12月27日 start---------------
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('TBYQSPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标邀请书pdf路径''';
	end if;
	
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('ZBGGPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标公告pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('KBJLPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('HXRGSPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('ZBJGGGPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标结果公告pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('DZGTZSPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代资格预审通过通知书pdf路径''';
	end if;
	------------add by jinyanhui 2017年12月27日 end---------------

	------------add by nieche 2018年01月03日 start---------------
    --BD_MESSAGE    jsuserid 字段长度从20改成50
    -- 增加 jsuserid_tmp
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
	end if;
-- 赋值 jsuserid_tmp
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set jsuserid_tmp = jsuserid';
	end if;
-- 清空 tknr
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set jsuserid=null';
	end if;
-- 修改 tknr
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(50))';
	end if;
-- 赋值 tknr
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set jsuserid = jsuserid_tmp';
	end if;
-- 删除 jsuserid_tmp
	tmp1:=upper('BD_MESSAGE');
	tmp2:=upper('jsuserid_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by nieche 2018年01月03日 end---------------
	------------add by lijb 2018年01月04日 start-------------
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('UPMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''二级专业''';
	end if;
	
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('DOWNMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''二级专业''';
	end if;
	------------add by lijb 2018年01月04日 end---------------

	------------add by hejw 2018年01月05日 start---------------
    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('EXAMINEOPINION');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
    end if;
	------------add by hejw 2018年01月05日 end---------------
	------------add by zhaoy 2018年01月08日 start---------------
	--预审记录pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('YSJLPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审记录pdf路径''';
	end if;
	--招标文件购买登记表pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('ZBWJGMPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件购买pdf路径''';
	end if;	
	--招标异常pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('ZBYCPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标异常pdf路径''';
	end if;	
	--踏勘通知pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('TKTZPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘通知pdf路径''';
	end if;	
	--踏勘记录pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('TKJLPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘记录pdf路径''';
	end if;
	--投标保证金接收登记表pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('TBBZJJSPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金接收登记表pdf路径''';
	end if;
	--投标文件接收登记表pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('TBWJJSPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件接收登记表pdf路径''';
	end if;
	--开启记录表pdf
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('KQJLPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开启记录pdf路径''';
	end if;
	------------add by zhaoy 2018年01月08日 end---------------
	------------add by lijb 2018年01月10日 start-------------
	tmp1:=upper('BD_EXPERT');
	tmp2:=upper('UPMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''二级专业''';
	end if;
	
	tmp1:=upper('BD_EXPERT');
	tmp2:=upper('DOWNMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''三级专业''';
	end if;
	
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('RESETDATA');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重置数据''';
	end if;
	------------add by lijb 2018年01月10日 end---------------

	------------add by hejw 2018年01月10日 start---------------
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('CURRENTRS3');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''抽取时(此时此刻生成此抽取条件时) 符合总人数'''; 
    end if; 
    
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('CURRENTRS4');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''抽取时(此时此刻生成此抽取条件时) 符合总人数'''; 
    end if; 
    
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('IS_JOB');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工作状态 1-在职 0-退休 2-其他 '''; 
    end if;  
    
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('FLDMNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分类代码名称'''; 
    end if; 
	------------add by hejw 2018年01月10日 end---------------

	------------add by lijb 2018年01月10日 start-------------
	tmp1:=upper('BD_EXPERT_RELATE');
	tmp2:=upper('ONLYID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''唯一标识''';
	end if;
	
	tmp1:=upper('BD_EXPERT_ZJ_RELATE');
	tmp2:=upper('ONLYID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''唯一标识''';
	end if;
	------------add by lijb 2018年01月10日 end---------------
	------------add by lijb 2018年01月11日 start--------------- 
    -- 新增专家黑名单
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_BLACK');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EXPERT_BLACK  (
           ZJDM                 VARCHAR2(17),
           ZJMC                 VARCHAR2(50),
           AGE                  NUMBER(6),
           CARD_NUM             VARCHAR2(30)                        not null,
           DQ_NAME1             VARCHAR2(30),
           DQ_NAME2             VARCHAR2(30),
           LXTEL                VARCHAR2(100),
           UNIT_NAME            VARCHAR2(100),       
           MAJOR                VARCHAR2(1000),
           CDATE                DATE,                              
           STARTTIME            DATE,
           ENDTIME              DATE,
           STATE                VARCHAR(10),
           REASON               VARCHAR(1000),
           ORIGIN               VARCHAR(10),
           OPTID                VARCHAR(200),                
           constraint PK_BD_EXPERT_BLACK primary key (CARD_NUM)
        )';

        execute immediate 'comment on table BD_EXPERT_BLACK is ''专家黑名单''';
        execute immediate 'comment on column BD_EXPERT_BLACK.ZJDM is ''专家代码''';
        execute immediate 'comment on column BD_EXPERT_BLACK.ZJMC is ''专家名称''';
        execute immediate 'comment on column BD_EXPERT_BLACK.AGE is ''年龄''';
        execute immediate 'comment on column BD_EXPERT_BLACK.CARD_NUM is ''身份证件号码''';
        execute immediate 'comment on column BD_EXPERT_BLACK.DQ_NAME1 is ''省''';
        execute immediate 'comment on column BD_EXPERT_BLACK.DQ_NAME2 is ''市''';
        execute immediate 'comment on column BD_EXPERT_BLACK.LXTEL is ''联系电话''';
        execute immediate 'comment on column BD_EXPERT_BLACK.UNIT_NAME is ''所在单位名称''';
        execute immediate 'comment on column BD_EXPERT_BLACK.MAJOR is ''专业''';
        execute immediate 'comment on column BD_EXPERT_BLACK.CDATE is ''创建时间''';
        execute immediate 'comment on column BD_EXPERT_BLACK.STARTTIME is ''开始时间''';
        execute immediate 'comment on column BD_EXPERT_BLACK.ENDTIME is ''结束时间''';
        execute immediate 'comment on column BD_EXPERT_BLACK.STATE is ''状态1:暂停2:停用''';
        execute immediate 'comment on column BD_EXPERT_BLACK.REASON is ''原因''';
        execute immediate 'comment on column BD_EXPERT_BLACK.ORIGIN is ''来源1:新增2:专家库3:待审核4:审核不通过5:待启用6:已启用''';
        execute immediate 'comment on column BD_EXPERT_BLACK.OPTID is ''操作员''';
        
    end if;
    ------------add by lijb 2018年01月11日 end--------------- 

------------add by nieche 2018年01月11日 start-------------
    tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('ZGYSGGPDF');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审公告pdf路径''';
	end if;
	
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('yswjgmpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审文件购买登记表pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('predissentPrepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提问与回复(资格预审阶段的提问回复，招标方或代理机构与投标人之间的提问回复)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('predissentpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提问与回复(发标阶段的提问回复，招标方或代理机构与投标人之间的提问回复)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('dissentPrepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提问与回复(资格预审开启的提问回复，专家与投标人之间的提问回复)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('dissentpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提问与回复(评标的提问回复，专家与投标人之间的提问回复)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('objectionzgyswjpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议(资格预审文件)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('objectionzgysjgpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议(资格预审结果)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('objectionzbwjpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议(招标文件)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('objectionkbgcpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议(开标过程)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('objectionzbhxrgspdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议(中标候选人公示)pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('zgyssqwjjsdjbpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审申请文件接收登记表pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('expertRecordPrepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审阶段 专家抽取记录（评审）pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('expertRecordpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家抽取记录（评标）pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('expertResultPrepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审阶段 专家抽取结果（评审）pdf路径''';
	end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('expertResultpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家抽取结果（评标）pdf路径''';
	end if;

	
	tmp1:=upper('BD_SUBPROJECT_EXT');
	tmp2:=upper('zzchangeNoticepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止公告pdf路径''';
	end if;
	
	tmp1:=upper('BD_CCNOTICE');
	tmp2:=upper('changeNoticepdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''typ值为1保存澄清与修改公告pdf路径，typ值为2保存变更公告pdf路径''';
	end if;
------------add by nieche 2018年01月11日 end-------------

  ------------add by nieche 2018年01月16日 start--------------- 
    -- 新增培训多人优惠活动
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_TRAINING_ACTIVITY');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
  create table BD_TRAINING_ACTIVITY  (
     PKID                 INT                            not null,
     ACTIVITYNAME         VARCHAR2(200),
     PROMPTPREFIX         VARCHAR2(200),
     PROMPTSUFFIX         VARCHAR2(200),
     REMARK               VARCHAR2(1024),
     constraint PK_BD_TRAINING_ACTIVITY primary key (PKID)
  )
    ';
-- 注释  
    execute immediate 'comment on table BD_TRAINING_ACTIVITY is ''培训多人优惠活动'' ';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY.PKID is ''自增主键培训多人优惠活动id'' ';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY.ACTIVITYNAME is ''活动名称'' ';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY.PROMPTPREFIX is ''活动提示前缀'' ';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY.PROMPTSUFFIX is ''活动提示后缀'' ';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY.REMARK is ''备注'' ';

  end if;
  
  num:=0; 
    tmp1:=upper('BD_TRAINING_ACTIVITY_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_TRAINING_ACTIVITY_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
  
  -- 新增培训多人优惠活动明细表
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_TRAINING_ACTIVITY_MX');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_TRAINING_ACTIVITY_MX  (
         ACTIVITYID           INT                             not null,
       BUYNUM               INT,
       REBATE               NUMBER(2,2),
       constraint PK_BD_TRAINING_ACTIVITY_MX primary key (ACTIVITYID, BUYNUM)
      )';
    execute immediate 'comment on table BD_TRAINING_ACTIVITY_MX is ''培训多人优惠活动明细表''';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY_MX.ACTIVITYID is ''培训多人优惠活动id''';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY_MX.BUYNUM is ''购买数量''';
    execute immediate 'comment on column BD_TRAINING_ACTIVITY_MX.REBATE is ''折扣''';
  end if;
  
    -- 新增培训期次
    num :=0;
    tmp1 := upper('BD_TRAINING_PERIOD');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_TRAINING_PERIOD  (
       PKID                 INT                             not null,
       PERIODNAME           VARCHAR2(200),
       PERIODTITLE          VARCHAR2(200),
       STARTTIME            DATE,
       ENDTEME              DATE,
       PICTUREPATH          VARCHAR2(200),
       CREATETIME           DATE,
       UPDATETIME           DATE,
       OPTID                VARCHAR2(30),
       ACTIVITYID           INT,
       REMARK               VARCHAR2(1024),
       STATUS               VARCHAR(1),
       constraint PK_BD_TRAINING_PERIOD primary key (PKID)
    )';
    execute immediate 'comment on table BD_TRAINING_PERIOD is ''培训期次''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.PKID is ''自增主键''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.PERIODNAME is ''培训期次名称用于在订单的详细信息中展示期次''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.PERIODTITLE is ''培训期次标题，与课程类型一起组成2017年中国兵器电子招标投标交易平台电子投标实务高级培训班''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.STARTTIME is ''期次开始时间''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.ENDTEME is ''期次结束时间''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.PICTUREPATH is ''期次图片路径''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.CREATETIME is ''期次新增时间''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.UPDATETIME is ''期次最后修改时间''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.OPTID is ''创建人操作员ID''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.ACTIVITYID is ''培训多人优惠活动id''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.REMARK is ''备注''';
    execute immediate 'comment on column BD_TRAINING_PERIOD.STATUS is ''期次状态0 待启用 1 已启用 2 已停用''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_TRAINING_PERIOD_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_TRAINING_PERIOD_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
  
  
    -- 新增培训课程
    num :=0;
    tmp1 := upper('BD_TRAINING_COURSE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_TRAINING_COURSE  (
       PKID                 INT                             not null,
       PERIODID             INT,
       COURSENAME           VARCHAR2(200),
       COURSETYPE           VARCHAR2(200),
       COURSEPRICE          NUMBER(20,2),
       STARTTIME            DATE,
       ENDTEME              DATE,
       LOCATION             VARCHAR2(1024),
       ADDR                 VARCHAR2(1024),
       FILEPATH             VARCHAR2(200),
       FILEPATHNAME         VARCHAR2(200),
       CREATETIME           DATE,
       UPDATETIME           DATE,
       OPTID                VARCHAR2(30),
       REMARK               VARCHAR2(1024),
       constraint PK_BD_TRAINING_COURSE primary key (PKID)
    )';
    execute immediate 'comment on table BD_TRAINING_COURSE is ''培训课程''';
    execute immediate 'comment on column BD_TRAINING_COURSE.PKID is ''自增主键''';
    execute immediate 'comment on column BD_TRAINING_COURSE.PERIODID is ''培训期次id''';
    execute immediate 'comment on column BD_TRAINING_COURSE.COURSENAME is ''课程名称''';
    execute immediate 'comment on column BD_TRAINING_COURSE.COURSETYPE is ''课程类型''';
    execute immediate 'comment on column BD_TRAINING_COURSE.COURSEPRICE is ''课程价格''';
    execute immediate 'comment on column BD_TRAINING_COURSE.STARTTIME is ''课程开始时间''';
    execute immediate 'comment on column BD_TRAINING_COURSE.ENDTEME is ''课程结束时间''';
    execute immediate 'comment on column BD_TRAINING_COURSE.LOCATION is ''课程地点，相当于省市区但可由客户任意输入，后台需提供模糊查询'' ';
    execute immediate 'comment on column BD_TRAINING_COURSE.ADDR is ''课程详细地址'' ';
    execute immediate 'comment on column BD_TRAINING_COURSE.FILEPATH is ''附件'' ';
    execute immediate 'comment on column BD_TRAINING_COURSE.FILEPATHNAME is ''附件名称'' ';
    execute immediate 'comment on column BD_TRAINING_COURSE.CREATETIME is ''课程新增时间''';
    execute immediate 'comment on column BD_TRAINING_COURSE.UPDATETIME is ''课程最后修改时间''';
    execute immediate 'comment on column BD_TRAINING_COURSE.OPTID is ''创建人操作员ID''';
    execute immediate 'comment on column BD_TRAINING_COURSE.REMARK is ''备注''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_TRAINING_COURSE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_TRAINING_COURSE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;

  
    -- 新增培训内容
    num :=0;
    tmp1 := upper('BD_COURSE_SCHEDULE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_COURSE_SCHEDULE  (
       PKID                 INT                             not null,
       PERIODID             INT,
       COURSEID             INT,
       STARTTIME            DATE,
       ENDTEME              DATE,
       TITLE                VARCHAR2(1024),
       INTRODUCTION         VARCHAR2(1024),
       constraint PK_BD_COURSE_SCHEDULE primary key (PKID)
    )';
    execute immediate 'comment on table BD_COURSE_SCHEDULE is ''培训课程内容''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.PKID is ''自增主键''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.PERIODID is ''培训期次id''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.COURSEID is ''培训课程id''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.STARTTIME is ''开始时间''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.ENDTEME is ''结束时间''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.TITLE is ''标题''';
    execute immediate 'comment on column BD_COURSE_SCHEDULE.INTRODUCTION is ''备注''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_COURSE_SCHEDULE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_COURSE_SCHEDULE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
  
  
   -- 新增培训课程订单
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_TRAINING_ORDER');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
  create table BD_TRAINING_ORDER  (
     DDHM                 VARCHAR(30)                     not null,
     PAYMONEY             NUMBER(20,2),
     HANDLEPAYMONEY             NUMBER(20,2),
     COUPONMONEY          NUMBER(20,2),
     DISCOUNTMONEY        NUMBER(20,2),
     ORDERMONEY           NUMBER(20,2),
     COUPONID             INT,
     FLAG1                VARCHAR(1),
     DATE1                DATE,
     DATE2                DATE,
     DATE3                DATE,
     PayDATE              DATE,
     HYDM                 VARCHAR(30),
     HYNAME               VARCHAR(250),
     KPFLAG               VARCHAR2(2),
       FPTYPE               VARCHAR2(3),
       DWMC                 VARCHAR2(250),
       NSRSBH               VARCHAR2(100),
     INVOICETITLE         VARCHAR2(200),
     INVOICETEL           VARCHAR2(30),
     INVOICEEMAIL         VARCHAR2(100),
     INVOICEREMARK        VARCHAR2(1024),
     REMARK               VARCHAR2(1024),
     PayType               VARCHAR(1),
     UPDATETIME            DATE,
     UOPTID                VARCHAR2(30),
     UHYDM                 VARCHAR(30),
     UHYNAME               VARCHAR(250),
     HYUPDATETIME          DATE,
     constraint PK_BD_TRAINING_ORDER primary key (DDHM)
  )
    ';
-- 注释  
    execute immediate 'comment on table BD_TRAINING_ORDER is ''培训课程的订单'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DDHM is ''培训课程订单号码'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.PAYMONEY is ''订单付款金额'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.HANDLEPAYMONEY is ''订单应付金额'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.COUPONMONEY is ''优惠券抵扣金额'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DISCOUNTMONEY is ''折扣优惠金额'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.ORDERMONEY is ''订单金额'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.COUPONID is ''优惠券id'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.FLAG1 is ''支付状态（0-未提交 1-已提交 2-已支付）'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DATE1 is ''创建时间'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DATE2 is ''提交时间'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DATE3 is ''支付时间'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.PayDATE is ''支付成功时间'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.HYDM is ''会员代码'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.HYNAME is ''会员名称'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.KPFLAG is ''是否开票0-否,1-是'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.FPTYPE is ''发票类型 1-增值税普通发票'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.DWMC is ''发票单位名称'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.NSRSBH is ''发票纳税人识别号'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.INVOICETITLE is ''发票抬头'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.INVOICETEL is ''发票接收联系人联系方式手机号'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.INVOICEEMAIL is ''发票电子邮箱'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.INVOICEREMARK is ''发票备注'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.REMARK is ''订单备注'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.PayType is ''支付类型 1 支付宝 2 网银 3 线下汇款'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.UPDATETIME is ''操作员最后修改时间'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.UOPTID is ''最后修改操作员id'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.UHYDM is ''最后修改会员编码'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.UHYNAME is ''最后修改会员名称'' ';
    execute immediate 'comment on column BD_TRAINING_ORDER.HYUPDATETIME is ''会员最后修改时间'' ';

  end if;
  
  -- 新增培训课程订单明细表
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_TRAINING_ORDER_MX');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_TRAINING_ORDER_MX  (
         DDHM                 VARCHAR(30)                     not null,
       XH                   INT,
       COURSEID             INT,
       COURSENAME           VARCHAR2(200),
       COURSETYPE           VARCHAR2(200),
       COURSEPRICE          NUMBER(20,2),
       STARTTIME            DATE,
       ENDTEME              DATE,
       LOCATION             VARCHAR2(1024),
       ADDR                 VARCHAR2(1024),
       PERIODID             INT,
       PERIODNAME           VARCHAR2(200),
       PERIODTITLE          VARCHAR2(200),
       CDATE                DATE,
       PayDATE              DATE,
       STUDENTNAME          VARCHAR(250),
       PHONENUMBER          VARCHAR(30),
       CERTIFICATEPATH      VARCHAR(200),
       HYDM                 VARCHAR(30),
         HYNAME               VARCHAR(250),
       UPDATETIME            DATE,
         UOPTID                VARCHAR2(30),
         UHYDM                 VARCHAR(30),
         UHYNAME               VARCHAR(250),
         HYUPDATETIME          DATE                            not null,
       constraint PK_BD_TRAINING_ORDER_MX primary key (DDHM, XH)
      )';
    execute immediate 'comment on table BD_TRAINING_ORDER_MX is ''培训课程订单明细表''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.DDHM is ''培训课程订单号码''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.XH is ''序号''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.COURSEID is ''培训课程id''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.COURSENAME is ''培训课程名称''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.COURSETYPE is ''培训课程类型''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.COURSEPRICE is ''培训课程价格''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.STARTTIME is ''培训课程开始时间''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.ENDTEME is ''培训课程结束时间''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.LOCATION is ''培训课程地点，相当于省市区但可由客户任意输入，后台需提供模糊查询''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.ADDR is ''培训课程详细地址''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.PERIODID is ''培训期次id''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.PERIODNAME is ''培训期次名称用于在订单的详细信息中展示期次''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.PERIODTITLE is ''培训期次标题，与课程类型一起组成2017年中国兵器电子招标投标交易平台电子投标实务高级培训班''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.CDATE is ''创建时间''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.PayDATE is ''支付成功时间''';
    execute immediate 'comment on column BD_TRAINING_ORDER_MX.STUDENTNAME is ''学员名称''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.PHONENUMBER is ''学员电话号码''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.CERTIFICATEPATH is ''学员证书下载地址''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.HYDM is ''会员代码''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.HYNAME is ''会员名称''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.UPDATETIME is ''操作员最后修改时间''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.UOPTID is ''最后修改操作员id''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.UHYDM is ''最后修改会员代码''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.UHYNAME is ''最后修改会员名称''';
		execute immediate 'comment on column BD_TRAINING_ORDER_MX.HYUPDATETIME is ''会员最后修改时间''';
	end if;
    ------------add by nieche 2018年01月16日 end---------------

    ------------add by nieche 2018年01月17日 start--------------- 
	
	tmp1:=upper('BD_TRAINING_ORDER_MX');
	tmp2:=upper('CERTIFICATENAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学员证书下载文件名''';
	end if;
	
	-- 删除 培训内容表的培训课程id 培训内容是期次的培训内容不记录课程id
	tmp1:=upper('BD_COURSE_SCHEDULE');
	tmp2:=upper('COURSEID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by nieche 2018年01月17日 end--------------- 

    ------------add by nieche 2018年01月18日 start--------------- 
	tmp1:=upper('BD_TRAINING_ORDER_MX');
	tmp2:=upper('sex');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' char(1))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学员性别 1-男性 2-女性''';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER_MX');
	tmp2:=upper('studentemail');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学员电子邮箱''';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER_MX');
	tmp2:=upper('companyname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(250))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学员公司名''';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER_MX');
	tmp2:=upper('position');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学员职务''';
	end if;
	------------add by nieche 2018年01月18日 end--------------- 
	------------add by hejw 2018年01月19日 start-- 调整订单表bdid长度------------- 
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('BDID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
    end if;
	------------add by hejw 2018年01月19日 end--------------- 
	------------add by hejw 2018年01月20日 start--------------- 
    tmp1:=upper('BD_MB_PBMB_BAK'); 
    tmp2:=upper('RIDMAXMIN');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INT';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评分结果汇总方式 0ornull-汇总所有评委评分取平均值  1-去掉最高最低分后取剩余评委评分平均值'''; 
    end if; 
	------------add by hejw 2018年01月20日 end--------------- 

	------------add by zhaoy 2018年01月20日 start--------------- 
	--添加操作员名称字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('czydmmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;
	------------add by zhaoy 2018年01月20日 end--------------- 
	------------add by lijb 2018年01月22日 start--------------- 
	--新增优惠卷表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_COUPON');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_COUPON
        (
          COUPONID             VARCHAR2(100)                    not null,
          HYDM                 VARCHAR2(100),
          HYNAME               VARCHAR2(100),
          COUPONTYPE		   VARCHAR2(10),
          SCOPEUSE			   VARCHAR2(1000),
          COUPONNAME		   VARCHAR2(200),
          COUPONMONEY		   VARCHAR2(20),
          CDATE                DATE,
          STARTTIME            DATE,
          ENDTIME              DATE,
          REMARK			   VARCHAR2(2000),
          STATE				   VARCHAR2(10),
          MFPHM				   VARCHAR2(100),
          MDDHM				   VARCHAR2(100),
          constraint PK_BD_COUPON primary key (COUPONID)
        )';
        execute immediate 'comment on table BD_COUPON is ''优惠卷表''';
        execute immediate 'comment on column BD_COUPON.COUPONID is ''优惠卷ID''';
        execute immediate 'comment on column BD_COUPON.HYDM is ''会员代码''';
        execute immediate 'comment on column BD_COUPON.HYNAME is ''会员名称''';
        execute immediate 'comment on column BD_COUPON.COUPONTYPE is ''优惠卷类型(1:折扣卷2:抵用卷3:代金卷)''';
        execute immediate 'comment on column BD_COUPON.SCOPEUSE is ''使用范围(能在哪种订单中使用)''';
        execute immediate 'comment on column BD_COUPON.COUPONNAME is ''优惠卷名称''';
        execute immediate 'comment on column BD_COUPON.COUPONMONEY is ''优惠卷金额/折扣''';
        execute immediate 'comment on column BD_COUPON.CDATE is ''创建日期''';
        execute immediate 'comment on column BD_COUPON.STARTTIME is ''使用开始时间''';
        execute immediate 'comment on column BD_COUPON.ENDTIME is ''过期时间''';
        execute immediate 'comment on column BD_COUPON.REMARK is ''备注''';
        execute immediate 'comment on column BD_COUPON.STATE is ''使用状态(1:未使用2:已使用)''';
        execute immediate 'comment on column BD_COUPON.MFPHM is ''关联发票号码''';
        execute immediate 'comment on column BD_COUPON.MDDHM is ''关联订单号码''';
    end if;
    ------------add by lijb 2018年01月20日 end---------------
    ------------add by hejw 2018年01月23日 start---------------
  tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('CREDITCODE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''纳税人识别号（统一社会信用代码）''';
    end if;
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('GBCREDIT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(4000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规避统一信用代码，多个逗号隔开'''; 
    end if;  
    ------------add by hejw 2018年01月23日 end---------------

------------add by nieche 2018年01月25日 start---------------
	-- 删除 培训课程订单表的优惠券id 优惠券表id不为int类型，并且一个订单可以选择多张优惠券
	tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('COUPONID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('COUPONIDS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''优惠卷ID可以多选，以逗号分隔''';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('studentActivityNum');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''多人优惠活动有效优惠人数''';
	end if;
	------------add by nieche 2018年01月25日 end---------------

	------------add by hejw 2018年01月27日 start---------------
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('PRE_SCORE2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(10,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审祥审得分(总分数)'''; 
    end if;    
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('SCORE2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(10,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''祥审得分(总分数)'''; 
    end if; 
	------------add by hejw 2018年01月27日 end---------------
   
    ------------add by nieche 2018年01月29日 start---------------
    tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('doPaymentFlag');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR(1))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''订单是否已点击去支付请求监管平台状态 0或为空表示未请求监管平台;1表示已点击去支付请求监管平台''';
	end if;
	
	tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('doPaymentTime');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''订单点击去支付请求监管平台时间（每次点击均更新该时间）''';
	end if;
	------------add by nieche 2018年01月29日 end---------------
	------------add by lijb 2018年01月30日 start---------------
	tmp1:=upper('BD_TRAINING_ORDER');
	tmp2:=upper('xxoptid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR(30))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''记录线下汇款的审核人 ''';
	end if;
	-----------add by lijb 2018年01月30日 end---------------

	------------add by hejw 2018年01月29日 start---------------
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('RIDMAXMIN');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标- 最高分最低分去掉人数'''; 
    end if;    
    
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('PRE_RIDMAXMIN');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审-最高分最低分去掉人数 1-最高最低各减1人'''; 
    end if;
	------------add by hejw 2018年01月29日 end---------------
	-----------add by zhaoy 2018年02月06日 start---------------
 	tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('HYFLMC');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员分类名称'''; 
    end if;
	------------add by zhaoy 2018年02月06日 end---------------
   
   ------------add by nieche 2018年02月06日 start---------------
    tmp1:=upper('BD_TRAINING_COURSE');
	tmp2:=upper('limitedFlag');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR(1))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''培训课程是否名额紧张 0或为空表示名额不紧张 1表示名额紧张''';
	end if;
	------------add by nieche 2018年02月06日 end---------------
	------------add by zhaoy 2018年02月23日 start---------------
	--添加交货期字段
	tmp1:=upper('BD_PROJECT_ITEM');
    tmp2:=upper('JHQ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货期'''; 
    end if;
    
    --添加交货地点字段
	tmp1:=upper('BD_PROJECT_ITEM');
    tmp2:=upper('JHDD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货地点'''; 
    end if;
    
    --添加交货期字段
	tmp1:=upper('BD_SUBPROJECT_ITEM');
    tmp2:=upper('JHQ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货期'''; 
    end if;
    
    --添加交货地点字段
	tmp1:=upper('BD_SUBPROJECT_ITEM');
    tmp2:=upper('JHDD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货地点'''; 
    end if;
    ------------add by zhaoy 2018年02月23日 end---------------

    ------------add by hejw 2018年02月27日 start---------------
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALPROPOSER');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-申请人'''; 
    end if;    
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALTEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-申请人联系方式'''; 
    end if; 
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALZAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(22,6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-项目总投资金额'''; 
    end if; 
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALYAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(22,6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-预算金额'''; 
    end if; 
    
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALSEALPATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-签章附件'''; 
    end if;
    
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALFLAG01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-是否为首次招标 1-是 0ornull-否'''; 
    end if;
    
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALZBWJSTART');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-招标文件发售开始时间'''; 
    end if;
    
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALZBWJEND');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-招标文件发售截止时间'''; 
    end if;
    
   tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SPECIALBIDDERS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(4000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-潜在投标人（已报名）'''; 
    end if;
    ------------add by hejw 2018年02月27日 end---------------

    ------------add by nieche 2018年02月26日 start---------------
    tmp1:=upper('BD_COURSE_SCHEDULE');
	tmp2:=upper('gradeFlag');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR(1) default ''5'')';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''培训课程内容等级 5表示高级班 1表示初级班''';
	end if;
	------------add by nieche 2018年02月26日 end---------------
	------------add by lijb 2018年02月26日 start---------------
	tmp1:=upper('BD_EXPERT_ZJ_RELATE');
    tmp2:=upper('PARENTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''父级ID'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT_ZJ_RELATE');
    tmp2:=upper('LEVELID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''级别ID'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT_ZJ_RELATE');
    tmp2:=upper('FILELEVEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件级别1:高级2:中级'''; 
    end if;
    ------------add by lijb 2018年02月26日 end---------------

	------------add by lijb 2018年02月27日 start---------------
	tmp1:=upper('BD_EXPERT_RELATE');
    tmp2:=upper('PARENTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''父级ID'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT_RELATE');
    tmp2:=upper('LEVELID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''级别ID'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT_RELATE');
    tmp2:=upper('FILELEVEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件级别1:高级2:中级'''; 
    end if;
    ------------add by lijb 2018年02月27日 end---------------

	------------add by zhaoy 2018年03月02日 start---------------
	tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('ZBHXRMC');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人名称'''; 
    end if;
    ------------add by zhaoy 2018年03月02日 end---------------

    ------------add by nieche 2018年03月07日 start---------------
	tmp1:=upper('BD_JURY_CENSOR');
	tmp2:=upper('evaluateContinueReason');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''继续评标理由''';
	end if;
	
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('FLAG06');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已确认继续评标理由环节''';
    end if;
	------------add by nieche 2018年03月07日 end---------------
	------------add by lijb 2018年03月13日 start---------------
	tmp1:=upper('BD_EXPERT_ZJ');
    tmp2:=upper('SUBMITDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交时间'''; 
    end if;
    ------------add by lijb 2018年03月13日 end---------------
	------------add by zhaoy 2018年03月13日 start---------------
	tmp1:=upper('Bd_Notice');
    tmp2:=upper('ABSTRACT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''摘要'''; 
    end if;
    
    tmp1:=upper('Bd_Notice');
    tmp2:=upper('STATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''状态:1发布中,2未发布'''; 
    end if;
    ------------add by zhaoy 2018年03月13日 end---------------
	------------add by lijb 2018年03月13日 start---------------
	tmp1:=upper('BD_TRAINING_ORDER');
    tmp2:=upper('KPFLAG2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已经开票0-否,1-是'''; 
    end if;
    
    tmp1:=upper('BD_TRAINING_ORDER');
    tmp2:=upper('OPPACCNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(250)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''线下汇款支付账户名称'''; 
    end if;
    
    tmp1:=upper('BD_TRAINING_ORDER');
    tmp2:=upper('OPPACCNO');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(250)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''线下汇款支付账户'''; 
    end if;
    
    tmp1:=upper('BD_TRAINING_ORDER');
    tmp2:=upper('OPPBRANCHNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(250)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''线下汇款开户银行 '''; 
    end if;
    
    tmp1:=upper('BD_TRAINING_ORDER');
    tmp2:=upper('OPPBRANCHNO');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(250)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''线下汇款支付联行号'''; 
    end if;
    ------------add by lijb 2018年03月13日 end---------------
	
	------------add by nieche 2018年01月20日 start--------------- 
    tmp1:=upper('BD_TRAINING_PERIOD');
	tmp2:=upper('location');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''培训期次地点''';
	end if;
	
	
	tmp1:=upper('BD_TRAINING_COURSE');
	tmp2:=upper('sortNum');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''培训课程排序数字''';
	end if;
    ------------add by nieche 2018年01月20日 end---------------

------------add by nieche 2018年03月26日 start--------------- 
    -- 新增评委主任退回评标
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_EVALUATION_REVERT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
	create table BD_EVALUATION_REVERT  (
	   PKID                 INT                            not null,
	   WYHDM                VARCHAR2(20),
	   XH                   INT,
	   BDID                 VARCHAR2(23),
	   STATUS               INT,
	   MBXH                 INT,
	   NODEMC               VARCHAR2(60),
	   FLAG01               INT,
	   FLAG02               INT,
	   DATE00               DATE,
	   DATE01               DATE,
	   DATE02               DATE,
	   DATE03               DATE,
	   REASON               VARCHAR2(2000),
	   REMARK               VARCHAR2(2000),
	   ZJMC                 VARCHAR2(50),
	   constraint PK_BD_EVALUATION_REVERT primary key (PKID)
	)
		';
-- 注释	
		execute immediate 'comment on table BD_EVALUATION_REVERT is ''评委主任退回评标'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.PKID is ''自增主键评委退回评标id'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.WYHDM is ''委员会编号'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.XH is ''成员序号（BD_JURY_MEMBER.XH）'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.BDID is ''标段（包）PKID'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.STATUS is ''状态 0-已保存 1-待确认 2-已生效 '' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.MBXH is ''重新评标退回到的环节模版序号'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.NODEMC is ''重新评标退回到环节的环节名称'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.FLAG01 is ''退回评标保存或生效时评委主任已评审环节'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.FLAG02 is ''退回评标保存或生效时评委主任已评分环节'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.DATE00 is ''评委主任新增退回评标时间'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.DATE01 is ''评委主任最后修改退回评标时间'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.DATE02 is ''评委主任发送退回评标时间'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.DATE03 is ''退回评标确认完成时间'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.REASON is ''评委主任勾选的申请原因可以多选已逗号分隔'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.REMARK is ''备注(评委主任填写的申请原因)'' ';
		execute immediate 'comment on column BD_EVALUATION_REVERT.ZJMC is ''评委主任专家名称(业主代表姓名)'' ';

	end if;
	
	num:=0; 
    tmp1:=upper('BD_EVALUATION_REVERT_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_EVALUATION_REVERT_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
	
	-- 新增评委确认退回评标
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_REVERT_CONFIRM');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
  create table BD_REVERT_CONFIRM  (
     PKID                 INT                            not null,
     EVALUATIONREVERTID   INT                            not null,
     WYHDM                VARCHAR2(20),
     XH                   INT,
     BDID                 VARCHAR2(23),
     STATUS               INT,
     FLAG01               INT,
     FLAG02               INT,
     DATE00               DATE,
	 ZJMC                 VARCHAR2(50),
     constraint PK_BD_REVERT_CONFIRM primary key (PKID)
  )
    ';
-- 注释  
    execute immediate 'comment on table BD_REVERT_CONFIRM is ''评委确认退回评标'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.PKID is ''自增主键评委确认退回评标id'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.EVALUATIONREVERTID is ''评委退回评标id(BD_EVALUATION_REVERT.PKID)'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.WYHDM is ''委员会编号'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.XH is ''成员序号（BD_JURY_MEMBER.XH）'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.BDID is ''标段（包）PKID'' ';
    execute immediate 'comment on column BD_REVERT_CONFIRM.STATUS is ''状态 1-待确认 2-已确认 '' ';
		execute immediate 'comment on column BD_REVERT_CONFIRM.FLAG01 is ''退回评标保存或生效时评委已评审环节'' ';
		execute immediate 'comment on column BD_REVERT_CONFIRM.FLAG02 is ''退回评标保存或生效时评委已评分环节'' ';
		execute immediate 'comment on column BD_REVERT_CONFIRM.DATE00 is ''评委确认退回评标时间'' ';
		execute immediate 'comment on column BD_REVERT_CONFIRM.ZJMC is ''专家名称(业主代表姓名)'' ';

	end if;
	
	num:=0; 
    tmp1:=upper('BD_REVERT_CONFIRM_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_REVERT_CONFIRM_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    
    tmp1:=upper('BD_EVALUATION_REVERT');
    tmp2:=upper('FLAG03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退回评标保存或生效时可回退的最大环节模版序号''';
    end if;
    
    tmp1:=upper('BD_EVALUATION_REVERT');
    tmp2:=upper('mblx');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50) )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重新评标退回到环节的模板类型 1-资审模板 2-评标模板''';
    end if;
	
	tmp1:=upper('BD_EVALUATION_REVERT');
    tmp2:=upper('nodelx');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重新评标退回到环节的环节类型 1-资格预审环节(评审办法) 10-评审环节(评标办法) 20-评分环节(评标办法)''';
    end if;
	
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('cxpbjlbpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重新评标记录表pdf路径''';
	end if;
	
------------add by nieche 2018年03月26日 end--------------- 

------------add by nieche 2018年03月29日 start--------------- 
    tmp1:=upper('BD_EVALUATION_REVERT');
    tmp2:=upper('revertfile');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300) )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-重新评标附件''';
    end if;	
	
	tmp1:=upper('BD_EVALUATION_REVERT');
    tmp2:=upper('revertfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) )';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-重新评标附件名称''';
    end if;	
	
	 tmp1:=upper('BD_EVALUATION_REVERT');
	  tmp2:=upper('sealdata');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''主任发送重新评标关联标识''';
	  end if;
	  
	  tmp1:=upper('BD_REVERT_CONFIRM');
	  tmp2:=upper('sealdata');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认重新评标关联标识''';
	  end if;
	
------------add by nieche 2018年03月29日 end--------------- 

------------add by nieche 2018年03月30日 start--------------- 
    -- 标段包扩展表相关字段
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID014');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回评标报告操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME014');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回评标报告操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE014');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回评标报告操作时间'''; 
    end if;
------------add by nieche 2018年03月30日 end--------------- 

------------add by hejw 2018年04月03日 start--------------- 
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('DLFWDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-扣取代理服务费的操作时间'''; 
    end if;   
    
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('TKDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-（保证金|图纸押金|履约保证金）退款操作时间'''; 
    end if;  
------------add by hejw 2018年04月03日 end--------------- 


	------------add by lijb 2018年04月03日 start--------------- 
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OLDBDID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''驳回后存放标段包号'''; 
    end if;
    ------------add by lijb 2018年04月03日 end--------------- 

	------------add by lijb 2018年04月23日 start---------------
	tmp1:=upper('BD_COUPON');
    tmp2:=upper('CHARGESCOUPONID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''计费平台优惠券ID'''; 
    end if;
    ------------add by lijb 2018年04月03日 end--------------- 

	------------add by lijb 2018年05月18日 start---------------
	tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('KBCOMPLETER');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标完成1完成0ornull未完成'''; 
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('FIRSTSPECIALZBWJSTART');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-首次招标文件发售开始时间'''; 
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('FIRSTSPECIALZBWJEND');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-首次招标文件发售截止时间'''; 
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('FIRSTSPECIALREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(600)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''小额/特殊招标-首次招标的信息'''; 
    end if;
    ------------add by lijb 2018年05月18日 end--------------- 

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

	------------add by lijb 2018年06月01日 start---------------
	tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('YSKBCOMPLETER');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审开标完成1完成0ornull未完成'''; 
    end if;
    ------------add by lijb 2018年05月01日 end---------------

	------------add by nieche 2018年06月21日 start---------------
    tmp1:=upper('BD_EVALUATION_REVERT');
  	tmp2:=upper('IS_PRE');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT default 0 )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-资格预审委员会 0OrNull 评标委员会''';
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('cxpsjlbpdf');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重新评审记录表pdf路径''';
	end if;
	------------add by nieche 2018年06月21日 end---------------

    -------------------------------------------------------------------------------------------------------
end;
