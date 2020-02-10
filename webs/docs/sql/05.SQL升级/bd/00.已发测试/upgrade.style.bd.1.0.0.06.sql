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
    tmp2:=upper('dljgstep');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构步骤'''; 
    end if;  
   
   
	------------2016/07/09 hanglong 支付申请记录表 start--------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_PAY_REQUEST');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_PAY_REQUEST  (
	       FPHM                 VARCHAR2(30)                    not null,
		   HYDM                 VARCHAR2(30),
		   HYNAME               VARCHAR2(100),
		   EXTBILLNO            VARCHAR2(30),
		   RECVACCNM            VARCHAR2(100),
		   RECVACCNO            VARCHAR2(60),
		   RECVBANKNM           VARCHAR2(100),
		   RECVTGFI             VARCHAR2(60),
		   RECVBANKTYPE         INT,
		   RQ                   DATE,
		   STATUS               INT,
		   BANKERROR            VARCHAR2(200),
		   OPT                  VARCHAR2(30),
		   AMT                  NUMBER(20,6),
		   HZDM                 VARCHAR2(30),
		   HZNAME               VARCHAR2(100),
		   SWLX                 VARCHAR2(30),
		   constraint PK_BD_PAY_REQUEST primary key (FPHM)
	    )';
	
		execute immediate 'comment on table BD_PAY_REQUEST is ''会员出金支付申请记录表''';
	    execute immediate 'comment on column BD_PAY_REQUEST.FPHM is''单据号码（PR + yyyyMMdd + 5位流水号）''';
	    execute immediate 'comment on column BD_PAY_REQUEST.HYDM is''申请会员代码''';
	    execute immediate 'comment on column BD_PAY_REQUEST.HYNAME is''申请会员名称''';
	    execute immediate 'comment on column BD_PAY_REQUEST.EXTBILLNO is''业务单据号码（这里对应的是标段包编码，可以为空）''';
	    execute immediate 'comment on column BD_PAY_REQUEST.RECVACCNM is''收款账号开户名''';
	    execute immediate 'comment on column BD_PAY_REQUEST.RECVACCNO is''收款账号''';
	    execute immediate 'comment on column BD_PAY_REQUEST.RECVBANKNM is''收款账户开户行''';
	    
	    execute immediate 'comment on column BD_PAY_REQUEST.RECVTGFI is''收款账户开户行支付联行号''';
	    execute immediate 'comment on column BD_PAY_REQUEST.RECVBANKTYPE is''收款账户开户行类型（0 - 中信银行，1 - 其他银行）''';
	    execute immediate 'comment on column BD_PAY_REQUEST.RQ is''申请日期''';
	    execute immediate 'comment on column BD_PAY_REQUEST.STATUS is''状态（1-已申请待发送银行，2-已发送银行待处理，3-处理成功）''';
	    execute immediate 'comment on column BD_PAY_REQUEST.BANKERROR is''银行返回错误代码''';
	    execute immediate 'comment on column BD_PAY_REQUEST.OPT is''操作员''';
	    execute immediate 'comment on column BD_PAY_REQUEST.AMT is''金额''';
	    execute immediate 'comment on column BD_PAY_REQUEST.HZDM is''收款方会员代码''';
	    execute immediate 'comment on column BD_PAY_REQUEST.HZNAME is''收款方会员名称''';
	    execute immediate 'comment on column BD_PAY_REQUEST.SWLX is''事务类型：1、招标人提款，2、招标人透支，3、招标人退保证金''';
	end if;
	
	tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('BONDTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INT';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保证金类型（当swlx为3时才有值）3-投标保证金，4-图纸押金，5-履约保证金'''; 
    end if; 
    
    tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('ZFQDID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(32)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中信平台支付清单id'''; 
    end if; 
	------------2016/07/09 hanglong 支付申请记录表 end--------------
    
    -----chenxp start-----
	--招标项目计划   
    tmp1:=upper('bd_subproject');
    tmp2:=upper('zbxmjh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目计划'''; 
    end if; 
	-----chenxp end-------

	------------- 2016/07/11 lvcy 客户模板  --start-----------------
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CLIENT_TEMPLATE');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_CLIENT_TEMPLATE  (
		   ID                   INT                             not null,
		   HYDM                 VARCHAR2(30),
		   MBNAME               VARCHAR2(250),
		   USERID               VARCHAR2(80),
		   USERNAME             VARCHAR2(80),
		   MBFL                 VARCHAR2(2),
		   UPLOAD_TIME          DATE,
		   CREATE_TIME          DATE,
		   UPDATE_TIME          DATE,
		   TEMP_NAME            VARCHAR2(500),
		   TYP                  VARCHAR2(2),
		   LB                   VARCHAR2(2),
		   ZBFS                 VARCHAR2(2),
		   ISUSE                VARCHAR2(2),
		   TDESC                VARCHAR2(4000),
		   constraint PK_BD_CLIENT_TEMPLATE primary key (ID)
		)';
	
		execute immediate 'comment on table BD_CLIENT_TEMPLATE is ''模板表''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.ID is ''主键''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.HYDM is ''会员代码''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.MBNAME is ''会员名称''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.USERID is ''操作员代码''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.USERNAME is ''操作员名称''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.MBFL is ''模板分类 1-会员模板，0 or othe-系统模板''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.UPLOAD_TIME is ''上传时间''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.CREATE_TIME is ''创建时间''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.UPDATE_TIME is ''修改时间''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.TEMP_NAME is ''模板名称''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.TYP is ''模板类型1-资格预审 2-招标文件''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.LB is ''模板类别 1-货物 2-工程 3-服务''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.ZBFS is ''招标方式 1-公开 2-邀请 9-其它''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.ISUSE is ''是否使用 1-是， 0 or other-否''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE.TDESC is ''描述''';

	end if;
	
	num:=0; 
    tmp1:=upper('BD_CLIENT_TEMPLATE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_CLIENT_TEMPLATE_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
    
    --------------

	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CLIENT_TEMPLATE_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_CLIENT_TEMPLATE_MX  (
		   PKID                 INT                             not null,
		   ID                   INT,
		   NODE_NAME            VARCHAR2(500),
		   PID                  INT,
		   CONTENTS_PATH        VARCHAR2(100),
		   TEMP_ID              INT,
		   ISEDIT               VARCHAR2(2),
		   XH                   INT,
		   TAGS                 CLOB,
		   TYP                  VARCHAR2(2),
		   NODETYPE             VARCHAR2(2),
		   ZBFS                 VARCHAR2(2),
		   LEVELS              INT,
		   constraint PK_BD_CLIENT_TEMPLATE_MX primary key (PKID)
		)';
	
		execute immediate 'comment on table BD_CLIENT_TEMPLATE_MX is ''模板明细表''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.PKID is ''主键''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.ID is ''ID''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.NODE_NAME is ''节点名称''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.PID is ''父节点''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.CONTENTS_PATH is ''文件存储路径''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.TEMP_ID is ''模板ID''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.ISEDIT is ''是否可编辑 1-是 0 or other-否''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.XH is ''序号''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.TAGS is ''变量字符串，以, 分隔''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.TYP is ''模板类型1-资格预审 2-招标文件''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.NODETYPE is ''节点类型''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.ZBFS is ''招标方式 1-公开 2-邀请 9-其它''';
		execute immediate 'comment on column BD_CLIENT_TEMPLATE_MX.LEVELS is ''节点层级''';

	end if;
	
	num:=0; 
    tmp1:=upper('BD_CLIENT_TEMPLATE_MX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_CLIENT_TEMPLATE_MX_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;

	------------- 2016/07/11 lvcy 客户模板  --end-----------------


	-----zyy start-----
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('MTCFEE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(20,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''咨询维护费'''; 
    end if; 
	-----zyy end-------
   

	------------- mazg start-----------------
	--订单-支付方式
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('ZFFS');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付方式 0-线上 1-线下''';  
	end if;
   	------------- mazg end-----------------
    
    ------------xuzhen start-----------
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('SFZFLVBZJ');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否支付履约保证金 0-否 1-是''';  
	end if;
    ------------xuzhen end-------------

	---chenxp start-----
	tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zczjbzname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册资金币种名称'''; 
    end if;
	---chenxp end-------

	------------2016/07/11 hanglong 添加合同履约登记相关字段 start--------------
	tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('SETTLEAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(20,6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''结算金额'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('FINISHDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同实际完成时间'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('TERM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' INT';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同履约期限（天）'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('CHECKNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''验收单位'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('CHECKOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''验收负责人'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('CHECKSTANDARD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''验收标准'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('STANDARDINFO');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''达标情况'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('CHANGECONTENT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''履约变更内容''';
    end if;
	------------2016/07/11 hanglong 添加合同履约登记相关字段 end--------------

	---zyy start-----
	tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZJWHFNOTE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CHAR(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家维护费情况  1-已维护'''; 
    end if;
	---zyy end-------

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('TBSTEP0');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方报名节点''';
    end if;	
    
  tmp1:=upper('Bd_Tb_Signup');
  tmp2:=upper('flag04');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
  execute immediate 'comment on column Bd_Tb_Signup.flag04 is ''是否确认 预审通过通知书   0-确认不参加   1-确认参加''';
  end if; 

	-- BD_TB_SIGNUP 增加 资格预审文件递交状态 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('zgyswjdjzt');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交状态 0 or null-未上传 1-已上传未提交 2-已提交''';
	end if;
	-- BD_TB_SIGNUP 增加 资格预审文件递交时间 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('zgyswjdjsj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交时间''';
	end if;
	-- BD_TB_SIGNUP 增加 资格预审文件递交操作员 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('zgyswjdjczydm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交操作员''';
	end if;
	-- BD_TB_SIGNUP 增加 资格预审文件递交操作员姓名 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('zgyswjdjczyname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交操作员姓名''';
	end if;
	
	
	----chenxp start-----
	----标段包邀请单位名称 字段修改
	tmp1:=upper('bd_package_yqdw');
	tmp2:=upper('dwmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(250))';
	end if;
	----chenxp end-------

	-- BD_PACKAGE 增加 中标通知书状态 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('zbtzszt');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标通知书状态 o or null-未保存 1-已保存 2-已发送待招标人确认 3-招标人已确认 4-招标人已拒绝 5-已签章并提交''';
	end if;
	
  -- add by longf start ---
  
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_FB_SURVEY');
  select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
      -- 建表
    execute immediate '
      create table BD_FB_SURVEY  (
     PKID                 INT                             not null,
     PROBID               VARCHAR2(20),
     PROBNAME             VARCHAR2(100),
     PACKID               VARCHAR2(23),
     PACKNAME             VARCHAR2(200),
     KTDATE               DATE,
     KTADDR               VARCHAR2(100),
     LXR                  VARCHAR2(50),
     LXRTEL               VARCHAR2(30),
	 TITLE                VARCHAR2(200),
     CONTENT              CLOB,
     FILENAME             VARCHAR(100),
     FILEPATH             VARCHAR(100),
     OPTID                VARCHAR2(50),
     OPTNAME              VARCHAR2(100),
     TJDATE               DATE,
     STATUS               CHAR(1),
     STATUS00             CHAR(1),
     SHOPTID              VARCHAR2(50),
     SHOPTNAME            VARCHAR2(100),
     SHDATE               DATE,
       constraint PK_BD_FB_SURVEY primary key (PKID)
    )';

    execute immediate 'comment on table BD_FB_SURVEY is ''踏勘现场通知'' ';
    execute immediate 'comment on column BD_FB_SURVEY.PKID is ''自增主键'' ';
    execute immediate 'comment on column BD_FB_SURVEY.PROBID is ''招标项目编号'' ';
    execute immediate 'comment on column BD_FB_SURVEY.PROBNAME is ''招标项目名称'' ';
    execute immediate 'comment on column BD_FB_SURVEY.PACKID is ''标段（包）编号'' ';
    execute immediate 'comment on column BD_FB_SURVEY.PACKNAME is ''标段（包）名称'' ';
    execute immediate 'comment on column BD_FB_SURVEY.KTDATE is ''踏勘时间'' ';
    execute immediate 'comment on column BD_FB_SURVEY.KTADDR is ''踏勘地点'' ';
    execute immediate 'comment on column BD_FB_SURVEY.LXR is ''联系人'' ';
    execute immediate 'comment on column BD_FB_SURVEY.LXRTEL is ''联系方式'' ';
	execute immediate 'comment on column BD_FB_SURVEY.TITLE is ''通知标题'' ';
    execute immediate 'comment on column BD_FB_SURVEY.CONTENT is ''通知内容'' ';
    execute immediate 'comment on column BD_FB_SURVEY.FILENAME is ''附件名称'' ';
    execute immediate 'comment on column BD_FB_SURVEY.FILEPATH is ''附件路径'' ';
    execute immediate 'comment on column BD_FB_SURVEY.OPTID is ''提交人ID'' ';
    execute immediate 'comment on column BD_FB_SURVEY.OPTNAME is ''提交人名称'' ';
    execute immediate 'comment on column BD_FB_SURVEY.TJDATE is ''提交时间'' ';
    execute immediate 'comment on column BD_FB_SURVEY.STATUS is ''通知状态 0-未发布，1-待平台审核，2-审核通过，3审核拒绝'' ';
    execute immediate 'comment on column BD_FB_SURVEY.STATUS00 is ''确认情况 0 or null-未确认 1-已确认'' ';
    execute immediate 'comment on column BD_FB_SURVEY.SHOPTID is ''审核操作员ID'' ';
    execute immediate 'comment on column BD_FB_SURVEY.SHOPTNAME is ''审核操作员名称'' ';
    execute immediate 'comment on column BD_FB_SURVEY.SHDATE is ''审核通知时间'' ';
	end if; 
  
  num:=0; 
    tmp1:=upper('BD_FB_SURVEY_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
    execute immediate '
      create sequence BD_FB_SURVEY_0
      minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order
      ';
    end if; 

	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('is_survey');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' CHAR(1)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否确认参加踏勘现场 1-是 2-否'''; 
	end if;
	
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('survey');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' CHAR(1)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已踏勘现场 1-是 2-否'''; 
	end if;	
	
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('tkname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘单位代表姓名'''; 
	end if;	
	
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('tkbz');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘备注'''; 
	end if;
	
	tmp1:=upper('bd_package');
	tmp2:=upper('tktitle');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘现场标题'''; 
	end if;
	
	tmp1:=upper('bd_package');
	tmp2:=upper('tkdate');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘现场日期'''; 
	end if;
	
	tmp1:=upper('bd_package');
	tmp2:=upper('tkfilepath');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘现场附件路径'''; 
	end if;
	
	tmp1:=upper('bd_package');
	tmp2:=upper('tknote');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' CHAR(1)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘现场记录情况 1-已提交'''; 
	end if;
	
	-- BD_HGZJTZS 修改备注 通知书状态
	tmp1:=upper('BD_HGZJTZS');
	tmp2:=upper('TZZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书状态 o or null-未保存 1-已保存 2-已发送待招标人确认 3-招标人已确认 4-招标人已拒绝 5-已签章并提交''';
	end if;	
	
	------------2016/07/15 zhangdelong 添加自定义属性 start ---------------------
	tmp1:=upper('BD_PROPERTY');
    tmp2:=upper('CLASSIFY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分类:无=0或null,公告=1,邀请书=2'''; 
    end if;
	------------2016/07/15 zhangdelong 添加自定义属性 end -------------------------

	
	
	--------------------创建购买文件订单明细表----BY。zhminfu----------------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_TD_DD_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_TD_DD_MX  (
	       DDHM                 VARCHAR(30)                     not null,
		   XH                   INT,
		   BDID                 VARCHAR(23),
		   PACKNAME             VARCHAR(200),
		   AMT0                 NUMBER(20,2),
		   AMT1                 NUMBER(20,2),
		   AMT2                 NUMBER(20,2),
		   CDATE                DATE,
		   DATE01               DATE,
		   DATE02               DATE,
		   HYDM                 VARCHAR(30),
		   HYNAME               VARCHAR(250),
		   HZDM                 VARCHAR(30),
		   HZNAME               VARCHAR(250),
		   constraint PK_BD_TD_DD_MX primary key (DDHM, XH)
	    )';
		execute immediate 'comment on table BD_TD_DD_MX is ''购买文件的订单明细表''';
		execute immediate 'comment on column BD_TD_DD_MX.DDHM is ''订单号码''';
		execute immediate 'comment on column BD_TD_DD_MX.XH is ''序号''';
		execute immediate 'comment on column BD_TD_DD_MX.BDID is ''标段包编码''';
		execute immediate 'comment on column BD_TD_DD_MX.PACKNAME is ''标段包名称''';
		execute immediate 'comment on column BD_TD_DD_MX.AMT0 is ''金额''';
		execute immediate 'comment on column BD_TD_DD_MX.AMT1 is ''备用''';
		execute immediate 'comment on column BD_TD_DD_MX.AMT2 is ''备用''';
		execute immediate 'comment on column BD_TD_DD_MX.CDATE is ''创建时间''';
		execute immediate 'comment on column BD_TD_DD_MX.DATE01 is ''备用''';
		execute immediate 'comment on column BD_TD_DD_MX.DATE02 is ''备用''';
		execute immediate 'comment on column BD_TD_DD_MX.HYDM is ''会员代码''';
		execute immediate 'comment on column BD_TD_DD_MX.HYNAME is ''会员名称''';
		execute immediate 'comment on column BD_TD_DD_MX.HZDM is ''招标方会员代码''';
		execute immediate 'comment on column BD_TD_DD_MX.HZNAME is ''招标方会员名称''';
	end if;
	
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('BDID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(230))';
	end if;
	
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('BDNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(2000))';
	end if;
	
	-- add by xuz  start--
	tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('RETURNLYBZJ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否退还履约保证金 0 or null 否 1-是'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('RETURNTBBZJ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否退还投标保证金 0 or null 否 1-是'''; 
    end if;
	-- add by xuz  end --

	tmp1:=upper('BD_TD_DD');
    tmp2:=upper('WBNO00');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(32)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''BK平台支付申请单号'''; 
    end if;  
    
    -- BD_TB_SIGNUP 增加 投标文件递交操作员联系方式 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJDJCZYLXFS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交操作员联系方式''';
	end if;
	
	---add by chenxp---
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('ZGYSWJDJCZYLXFS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交操作员联系方式''';
	end if;
	---end by chenxp---
	
	-------添加业主代表人数字段----BY。zhminfu
	tmp1:=upper('BD_JURY');
  	tmp2:=upper('RSNUM0');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评委专家人数''';
      execute immediate 'comment on column '||tmp1||'.RSNUM is ''评委总人数''';
    end if;
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('RSNUM1');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评委招标人代表人数''';
    end if;
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('QRWAY');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认方式1：指定 2抽取 3指定+抽取''';
    end if;
    
    tmp1:=upper('Bd_Td_Dd');
  	tmp2:=upper('PAYAMT');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已支付金额（用于一个订单多次支付）''';
    end if;
    
    -- add by longf start ---
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('pbprice');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(30,2)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标价格'''; 
	end if;

	tmp1:=upper('BD_EXPERT');
	tmp2:=upper('major');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then 
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(32))';
	end if;
	
	tmp1:=upper('BD_JURY_MEMBER');
	tmp2:=upper('major');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then 
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(32))';
	end if;
	-- add by longf end ---


	----chenxp start-----
	-- 判断回执记录表是否存在
  	num:=0; -- 注意：查询前必须初始化此变量
  	tmp1:=upper('BD_HZJL');
  	select count(1) into num from user_tables where table_name=tmp1;       
  	if num = 0 then
    -- 建表
    execute immediate '
    create table BD_HZJL  (
    PKID        NUMBER  not null,
    hydm        VARCHAR2(32), 
    bdid        VARCHAR2(23),
    hzuuid      VARCHAR2(32),
    typ         VARCHAR2(2),  
    tbfdm       VARCHAR2(32),
    tbfopt      VARCHAR2(30),
    cdate       DATE,
    hztyp       VARCHAR2(2),   
    hzwj        VARCHAR2(80),    
    scfs        VARCHAR2(10),    
    file01      VARCHAR2(200),    
    file02      VARCHAR2(200),    
    fname02     VARCHAR2(60),
    fsize02     VARCHAR2(20),
    file03      VARCHAR2(200),    
    fname03     VARCHAR2(60),    
    fsize03     VARCHAR2(20),
       constraint PK_BD_HZJL primary key (PKID)
    )
    ';    
    -- 注释      
    execute immediate ' comment on column BD_HZJL.pkid is ''唯一主键'' '; 
    execute immediate '  comment on column BD_HZJL.hydm is ''招标人或代理机构代码'' ';
    execute immediate '  comment on column BD_HZJL.bdid is ''标段(包)编号'' ';
    execute immediate '  comment on column BD_HZJL.hzuuid is ''与报名表关联标识'' ';
    execute immediate '  comment on column BD_HZJL.typ is ''1-投标人预审文件回执  2-投标人投标文件回执'' ';
    execute immediate '  comment on column BD_HZJL.tbfdm is ''投标方代码'' ';
    execute immediate '  comment on column BD_HZJL.tbfopt is ''投标方操作员'' ';
    execute immediate '  comment on column BD_HZJL.cdate is ''操作时间'' ';
    execute immediate '  comment on column BD_HZJL.hztyp is ''回执文件类型 1-递交回执  2-撤销回执'' ';
    execute immediate '  comment on column BD_HZJL.hzwj is ''回执文件'' ';    
    execute immediate '  comment on column BD_HZJL.scfs is ''上传方式'' ';
    execute immediate '  comment on column BD_HZJL.file01 is ''回执文件服务器存放路径'' ';
    execute immediate '  comment on column BD_HZJL.file02 is ''电子投标文件服务器路径'' ';
    execute immediate '  comment on column BD_HZJL.fname02 is ''电子投标原文件名'' ';
    execute immediate '  comment on column BD_HZJL.fsize02 is ''电子投标原文件大小(KB)'' ';
    execute immediate '  comment on column BD_HZJL.file03 is ''数据包服务器存放路径'' ';
    execute immediate '  comment on column BD_HZJL.fname03 is ''数据包原文件名'' ';
    execute immediate '  comment on column BD_HZJL.fsize03 is ''数据包原文件大小(KB)'' ';
	

	end if; 
	
	num:=0; 
    tmp1:=upper('BD_HZJL_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_HZJL_0 
        minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order
        ';
     end if; 
     
     ---投标文件修改filesize字段
   	tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
    end if;
    
    -- 赋值 tknr_tmp
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set tknr_tmp = filesize';
    end if;
    
    -- 清空 filesize
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set filesize=null';
    end if;
    
    -- 修改 filesize
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(20))';
        execute immediate '  comment on column BD_ZB_FILE.filesize is ''文件大小（KB）'' ';
    end if;
    
    -- 赋值 filesize
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set filesize = tknr_tmp';
    end if;
    
    -- 删除 tknr_tmp临时字段
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
    
    
   
   
   --预审文件修改filesize字段
    -- 增加 tknr_tmp临时字段
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
    end if;
    
    -- 赋值 tknr_tmp
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set tknr_tmp = filesize';
    end if;
    
    -- 清空 filesize
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set filesize=null';
    end if;
    
    -- 修改 filesize
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(20))';
        execute immediate '  comment on column BD_ZB_FILE.filesize is ''文件大小（KB）'' ';
    end if;
    
    -- 赋值 filesize
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('filesize');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set filesize = tknr_tmp';
    end if;
    
    -- 删除 tknr_tmp临时字段
    tmp1:=upper('BD_ZB_FILE');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;


    --修改标段包状态备注
    tmp1:=upper('bd_package');
    tmp2:=upper('packStatus');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then 
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）状态 0-未开标 ,1-流标中 ,2-已流标 ,3-开标失败,4-已开标,5-开标记录确认  14-中标候选人公示,15-已中标,16-未中标'' '; 
    end if;
	
	
	---投标保证金金额单位
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('tbbzjjedw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
         execute immediate '  comment on column BD_FB_ZBCSSZ.tbbzjjedw is ''投标保证金金额单位）'' ';
    end if;

	----chenxp end-------
	
	
	---xuz  start----

	---币种
	tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('biz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
         execute immediate '  comment on column BD_TBYQSBZ.biz is ''币种）'' ';
    end if;
    
    ---价格单位
	tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('jgdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
         execute immediate '  comment on column BD_TBYQSBZ.jgdw is ''价格单位）'' ';
    end if;
	---xuz  end-----

    -- add by longf start ---
	tmp1:=upper('BD_JURY_REQUIRE');
	tmp2:=upper('majormc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' varchar2(1000)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专业-名称，多个用逗号隔开'''; 
	end if;

	tmp1:=upper('BD_JURY_REQUIRE');
	tmp2:=upper('major');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then 
		execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(500))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专业-代码，多个用逗号隔开'''; 
	end if;
	
	-- add by longf end ---

	--add by xuz start---
	tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('status');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
         execute immediate '  comment on column BD_ZB_YC.status is ''异常状态 0-待提交 1-已提交 2-招标方审核通过 3-招标方审核不通过 4-待平台审核 5-平台审核通过 6-平台审核不通过'' ';
    end if;
    
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('czydm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(9) )';
         execute immediate '  comment on column BD_ZB_YC.czydm is ''操作员代码'' ';
    end if;
    
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('czymc');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50) )';
         execute immediate '  comment on column BD_ZB_YC.czymc is ''操作员名称'' ';
    end if;
    
     tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('ycjd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
         execute immediate '  comment on column BD_ZB_YC.ycjd is ''异常阶段 1-资格预审 2-发标 3-开标'' ';
    end if;
    
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('date2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
         execute immediate '  comment on column BD_ZB_YC.date2 is ''平台审核时间'' ';
    end if;
	--add by xuz end---


	--add by hejw start---
    tmp1:=upper('BD_ZBSTOPGG');
	tmp2:=upper('section');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(3,0))';
	execute immediate 'comment on column BD_ZBSTOPGG.section is ''1-资格预审   2-发标  3-开标   4-评标   5-定标''';
	end if;
  
  tmp1:=upper('BD_ZBSTOPGG');
	tmp2:=upper('YCQK');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	execute immediate 'comment on column BD_ZBSTOPGG.YCQK is ''异常情况''';
	end if; 
  
  tmp1:=upper('BD_ZBSTOPGG');
	tmp2:=upper('YCOPINION');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
	execute immediate 'comment on column BD_ZBSTOPGG.YCOPINION is ''审批或核准意见''';
	end if; 
  
  tmp1:=upper('BD_ZBSTOPGG');
	tmp2:=upper('YCOPT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
	execute immediate 'comment on column BD_ZBSTOPGG.YCOPT is ''异常创建操作员''';
	end if; 
  
  tmp1:=upper('BD_ZBSTOPGG');
	tmp2:=upper('YCDATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
	execute immediate 'comment on column BD_ZBSTOPGG.YCDATE is ''异常创建时间''';
	end if; 
	--add by hejw end---

	--add by chenxp start---
	 ---投标方澄清文件 
    tmp1:=upper('bd_cc_receipt');
    tmp2:=upper('content');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
         execute immediate '  comment on column bd_cc_receipt.content is ''公告内容'' ';
    end if;
    
    tmp1:=upper('bd_cc_receipt');
    tmp2:=upper('ggfile');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate '  comment on column bd_cc_receipt.ggfile is ''公告附件'' ';
    end if;
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('ysflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
         execute immediate '  comment on column bd_ccnotice.ysflag is ''预审标志 1-预审 2-发标'' ';
    end if;
    
    tmp1:=upper('bd_cc_receipt');
    tmp2:=upper('ysflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
         execute immediate '  comment on column bd_ccnotice.ysflag is ''预审标志 1-预审 2-发标'' ';
    end if;
    
    tmp1:=upper('bd_cc_receipt');
    tmp2:=upper('probname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1000))';
         execute immediate '  comment on column bd_cc_receipt.probname is ''招标项目名称'' ';
    end if;
    
    tmp1:=upper('bd_cc_receipt');
    tmp2:=upper('PACKNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
         execute immediate '  comment on column bd_cc_receipt.PACKNAME is ''标段包名称'' ';
    end if;
	--end by chenxp end----

  -------------------------------------------------------------
end;