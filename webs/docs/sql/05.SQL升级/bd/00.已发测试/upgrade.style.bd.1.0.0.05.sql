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
    tmp1:=upper('bd_subproject');
    tmp2:=upper('zbstep');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方步骤1:招标方案 2:资格预审（约标） 3:发标 4:开标 5:评标 6:定标 7:执行合同'''; 
    end if; 
    
    tmp1:=upper('bd_subproject');
    tmp2:=upper('tbstep');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方步骤1:报名 2:投标 3:开标 4:评标 5:中标 6:签订合同'''; 
    end if; 
    
    tmp1:=upper('bd_package');
    tmp2:=upper('zbstep0');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方步骤(辅)'''; 
    end if; 
    
    tmp1:=upper('bd_package');
    tmp2:=upper('tbstep0');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方步骤(辅)'''; 
    end if;
 
	--jinyanhui 新增招投标步骤跳转表 start--
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_STEPURL');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_STEPURL  (
       STEP                 VARCHAR2(2)                     not null,
       STEP0                VARCHAR2(2)                     not null,
       TYP                  INTEGER,
       URL                  VARCHAR2(300),
       STR01                VARCHAR2(30),
       STR02                VARCHAR2(30),
       STR03                VARCHAR2(30),
       STR04                VARCHAR2(30),
       STR05                VARCHAR2(30),
       STR06                VARCHAR2(30),
       constraint PK_BD_STEPURL primary key (STEP, STEP0)
    )';

    execute immediate 'comment on column BD_STEPURL.STEP is''招标项目步骤''';
    execute immediate 'comment on column BD_STEPURL.STEP0 is''标段包步骤''';
    execute immediate 'comment on column BD_STEPURL.TYP is''类型 1 招标方 2 投标方''';
    execute immediate 'comment on column BD_STEPURL.URL is''地址''';
    execute immediate 'comment on column BD_STEPURL.STR01 is''参数 招标方代码''';
    execute immediate 'comment on column BD_STEPURL.STR02 is''参数 投标方代码''';
    execute immediate 'comment on column BD_STEPURL.STR03 is''参数 招标项目编号''';
    execute immediate 'comment on column BD_STEPURL.STR04 is''参数 标段(包)编号（bdid）''';
    execute immediate 'comment on column BD_STEPURL.STR05 is''参数 标段(包)编号（packid）''';
    execute immediate 'comment on column BD_STEPURL.STR06 is''备用''';
  end if;
  	--jinyanhui 新增招投标步骤跳转表 end--
 	----chenxp start-----
	----招标项目 代理机构相关信息
 	tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zczjdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册资金单位1-元 2-万元'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zczjbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(3)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册资金币种代码'''; 
    end if;
    ----chenxp end-------
	
	-- BD_PACKAGE 增加 资格预审文件审核意见 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('YSWJSHYJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件审核意见''';
	end if;
	-- BD_PACKAGE 修改备注 预审文件状态
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('YSWJZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审文件状态 0 or null-未上传 1-已发布 2-已上传 3-已发送待招标人审核 4-招标人审核通过 5-招标人审核未通过''';
	end if;
	
	-- BD_PACKAGE 增加 招标文件审核意见 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('ZBWJSHYJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件审核意见''';
	end if;
	-- BD_PACKAGE 修改备注 招标文件状态
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('zbwjzt');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件状态 0 or null-未上传 1-已上传 2-已发送待招标人审核 3-招标人审核通过 4-已发布 5-招标人审核未通过''';
	end if;

  tmp1:=upper('bd_stepurl');
  tmp2:=upper('step');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;	
  
  tmp1:=upper('bd_stepurl');
  tmp2:=upper('step0');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;    
  
  tmp1:=upper('bd_subproject');
  tmp2:=upper('zbstep');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;	
  
  tmp1:=upper('bd_subproject');
  tmp2:=upper('tbstep');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;
  
  tmp1:=upper('bd_package');
  tmp2:=upper('zbstep0');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;	
  
  tmp1:=upper('bd_package');
  tmp2:=upper('tbstep0');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if; 	

	---add by xuz start ---
	tmp1:=upper('bd_zbgg');
	tmp2:=upper('file1');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(150))';
	end if;	
	
	 tmp1:=upper('bd_zbgg');
    tmp2:=upper('filename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件名称'''; 
    end if;
 
	---add by xuz end ---
	
	------------2016/07/09 hanglong 资金支付清单业务处理队列 start--------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_ZFQD_QUENUE');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_ZFQD_QUENUE  (
	       ID                   NUMBER                          not null,
		   FPHM                 VARCHAR2(30),
		   SWLX                 VARCHAR2(30),
		   RQ                   DATE,
		   XH                   INT,
		   STYP                 INT,
		   HYDM                 VARCHAR2(30),
		   constraint PK_BD_ZFQD_QUENUE primary key (ID)
	    )';
	
		execute immediate 'comment on table BD_ZFQD_QUENUE is ''资金支付清单业务处理队列''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.ID is''队列号''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.FPHM is''单据号码''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.SWLX is''事务类型：1、招标人提款，2、招标人透支，3、投标人退保证金''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.RQ is''发送日期''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.XH is''明细序号''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.STYP is''1 - 发送请求，2 - 结果查询''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE.HYDM is''会员代码''';
	end if;
	
	num:=0; 
    tmp1:=upper('BD_ZFQD_QUENUE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_ZFQD_QUENUE_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_ZFQD_QUENUE_BAK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_ZFQD_QUENUE_BAK  (
	       ID                   NUMBER                          not null,
		   FPHM                 VARCHAR2(30),
		   SWLX                 VARCHAR2(30),
		   RQ                   DATE,
		   XH                   INT,
		   STYP                 INT,
		   HYDM                 VARCHAR2(30),
		   constraint PK_BD_ZFQD_QUENUE_BAK primary key (ID)
	    )';
	
		execute immediate 'comment on table BD_ZFQD_QUENUE_BAK is ''资金支付清单业务处理队列历史记录''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.ID is''队列号''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.FPHM is''单据号码''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.SWLX is''事务类型：1、招标人提款，2、招标人透支，3、投标人退保证金''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.RQ is''发送日期''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.XH is''明细序号''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.STYP is''1 - 发送请求，2 - 结果查询''';
	    execute immediate 'comment on column BD_ZFQD_QUENUE_BAK.HYDM is''会员代码''';
	end if;
	
	------------2016/07/09 hanglong 资金支付清单业务处理队列 end--------------
	
    tmp1:=upper('bd_package');
    tmp2:=upper('dljgstep0');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构步骤（辅）'''; 
    end if; 
  -------------------------------------------------------------
end;