declare
  curdb varchar(255); -- 当前用户（数据名称）
  msg varchar2(500);
  num int;  
  curVersion varchar2(30);
  tmp1 varchar2(255);
  tmp2 varchar2(255);
begin
  num:=0;
  select count(0) into num from SYS_SYSINFO where sysid='BS';
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

  ------------------zyy --start-----------------------------
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('JSXZTJJJ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
   execute immediate 'comment on column BS_MENBER.JSXZTJJJ is ''交易角色提交时间''';
  end if;
  
  tmp1:=upper('BS_MENBER_JSXZ');
  tmp2:=upper('STR06');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300))';
   execute immediate 'comment on column BS_MENBER_JSXZ.STR06 is ''角色管理名称''';
  end if;
  ------------------zyy --start-----------------------------

  	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_BANK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_BANK  (
		   PKID                 INTEGER                         not null,
		   HYDM                 VARCHAR2(30),
		   YHDM                 VARCHAR2(10),
		   BKNAME               VARCHAR2(100),
		   KHNAME               VARCHAR2(150),
		   KHBANK               VARCHAR2(80),
		   KHBKNO               VARCHAR2(30),
		   KHZH                 VARCHAR2(30),
		   KHZM                 VARCHAR2(300),
		   BASICYH              INT,
		   BILLINGYH            INT,
		   STATUS               INT,
		   JJLY                 VARCHAR2(200),
		   JBYH                 INT,
		   KHYH                 INT,
		   constraint PK_BS_MENBER_BANK primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_MENBER_BANK is''会员银行信息管理''';
		execute immediate 'comment on column BS_MENBER_BANK.PKID is''序号''';
		execute immediate 'comment on column BS_MENBER_BANK.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_BANK.YHDM is''银行代码''';
		execute immediate 'comment on column BS_MENBER_BANK.BKNAME is''银行名称''';
		execute immediate 'comment on column BS_MENBER_BANK.KHNAME is''开户名''';
		execute immediate 'comment on column BS_MENBER_BANK.KHBANK is''开户行名称''';
		execute immediate 'comment on column BS_MENBER_BANK.KHBKNO is''开户行支行代码''';
		execute immediate 'comment on column BS_MENBER_BANK.KHZH is''帐号''';
		execute immediate 'comment on column BS_MENBER_BANK.KHZM is''基本银行开户证明''';
		execute immediate 'comment on column BS_MENBER_BANK.BASICYH is''是否基本银行： 0-否  1-是''';
		execute immediate 'comment on column BS_MENBER_BANK.BILLINGYH is''是否开票银行： 0-否  1-是''';
		execute immediate 'comment on column BS_MENBER_BANK.STATUS is''状态： 0-待提交  1-待审核  2-已审核 3-审核不通过''';
		execute immediate 'comment on column BS_MENBER_BANK.JJLY is''拒绝理由''';
		execute immediate 'comment on column BS_MENBER_BANK.JBYH is''基本银行： 0-不是  1- 是（一个用户只能存在一个）''';
		execute immediate 'comment on column BS_MENBER_BANK.KHYH is''开票银行：  0-不是  1- 是（一个用户只能存在一个）''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_MENBER_BANK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_MENBER_BANK_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;
     
     
     
     -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_GNVQ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_GNVQ  (
		   PKID                 INTEGER                         not null,
		   HYDM                 VARCHAR2(30),
		   CNVQCODE             VARCHAR2(30),
		   CNVQNAME             VARCHAR2(100),
		   INDCODE              VARCHAR2(30),
		   INDNAME              VARCHAR2(100),
		   MAJCODE              VARCHAR2(30),
		   MAJNAME              VARCHAR2(100),
		   GRADE                INT,
		   CERT                 VARCHAR2(300),
		   CERTBH               VARCHAR2(150),
		   ZZKSSJ               DATE,
		   ZZJSSJ               DATE,
		   STATUS               INT,
		   constraint PK_BS_MENBER_GNVQ primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_MENBER_GNVQ is''会员银行信息管理''';
		execute immediate 'comment on column BS_MENBER_GNVQ.PKID is''序号''';
		execute immediate 'comment on column BS_MENBER_GNVQ.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_GNVQ.CNVQCODE is''资质序列代码''';
		execute immediate 'comment on column BS_MENBER_GNVQ.CNVQNAME is''资质序列名称''';
		execute immediate 'comment on column BS_MENBER_GNVQ.INDCODE is''行业代码''';
		execute immediate 'comment on column BS_MENBER_GNVQ.INDNAME is''行业名称''';
		execute immediate 'comment on column BS_MENBER_GNVQ.MAJCODE is''专业类别代码''';
		execute immediate 'comment on column BS_MENBER_GNVQ.MAJNAME is''专业类别名称''';
		execute immediate 'comment on column BS_MENBER_GNVQ.GRADE is''资质等级''';
		execute immediate 'comment on column BS_MENBER_GNVQ.CERT is''资质证书''';
		execute immediate 'comment on column BS_MENBER_GNVQ.CERTBH is''资质证书编号''';
		execute immediate 'comment on column BS_MENBER_GNVQ.ZZKSSJ is''资质开始时间''';
		execute immediate 'comment on column BS_MENBER_GNVQ.ZZJSSJ is''资质结束时间''';
		execute immediate 'comment on column BS_MENBER_GNVQ.STATUS is''状态： 0-待提交  1-待审核  2-已审核 3-审核不通过''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_MENBER_GNVQ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_MENBER_GNVQ_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;
     
     
     
	tmp1:=upper('BS_MENBER_TMP');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_SYSTEM');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
  
	tmp1:=upper('BS_MENBER_JYPZ_TMP');
	tmp2:=upper('JSBZH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(100)';
	end if;
	
	tmp1:=upper('BS_MENBER_JYPZ');
	tmp2:=upper('JSBZH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(100)';
	end if;
	----------wangch start---------
    --增加字段印章编码
	tmp1:=upper('BS_MBOPT');
	tmp2:=upper('YZBM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''印章编码，''';
	end if;
	
	--增加字段印章密码
	tmp1:=upper('BS_MBOPT');
	tmp2:=upper('YZMM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''印章密码，''';
	end if;
	
	-----xuz start-----
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MENBER_JSXZ');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MENBER_JYPZ');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_SUPPLIER_MG');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;	

	-----xuz end-------

	tmp1:=upper('BS_MBOPT');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;

	tmp1:=upper('BS_SUPPLIER_PF');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;

	
	tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('LIABLE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''信息申报责任人''';
	end if;
	
	tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('GRADE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table '||tmp1||' modify('||tmp2||' varchar2(30))';
	end if;

	
	tmp1:=upper('BS_MBOPT');
	tmp2:=upper('IMGURL');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(300)';
	end if;
	
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('SHR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核人''';
	end if;
	
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('SHRQ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核日期''';
	end if;
	
	
	
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_ZYRY');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_ZYRY  (
		   CODE                 VARCHAR2(30)                    not null,
		   HYDM                 VARCHAR2(30),
		   NAME                 VARCHAR2(30),
		   GENDER               INTEGER,
		   YEAR                 VARCHAR2(30),
		   MONTH                VARCHAR2(30),
		   ADMINDQ1CODE         VARCHAR2(6),
		   ADMINDQ1NAME         VARCHAR2(100),
		   ADMINDQCODE          VARCHAR2(6),
		   ADMINDQNAME          VARCHAR2(100),
		   ADMINXJCODE          VARCHAR2(6),
		   ADMINXJNAME          VARCHAR2(100),
		   EDUCATION            VARCHAR2(30),
		   TEL                  VARCHAR2(30),
		   MAILPRCODE           VARCHAR2(6),
		   MAILPRNAME           VARCHAR2(100),
		   MAILCITYCODE         VARCHAR2(6),
		   MAILCITYNAME         VARCHAR2(100),
		   MAILCYCODE           VARCHAR2(6),
		   MAILCYNAME           VARCHAR2(100),
		   POSTCODE             VARCHAR2(30),
		   COMPANY              VARCHAR2(300),
		   ISWORKING            INTEGER,
		   POST                 VARCHAR2(300),
		   TITLE                VARCHAR2(300),
		   EXPERIENCE           VARCHAR2(3000),
		   LIFE                 VARCHAR2(8),
		   constraint PK_BS_MENBER_ZYRY primary key (CODE)
		)
		';

		execute immediate 'comment on table BS_MENBER_ZYRY is''职业人员管理''';
		execute immediate 'comment on column BS_MENBER_ZYRY.CODE is''职业人员代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.NAME is''姓名''';
		execute immediate 'comment on column BS_MENBER_ZYRY.GENDER is''性别: 1-男 2-女''';
		execute immediate 'comment on column BS_MENBER_ZYRY.YEAR is''出生年份''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MONTH is''出生月份''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINDQ1CODE is''所在行政区域省代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINDQ1NAME is''所在行政区域省名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINDQCODE is''所在行政区域市代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINDQNAME is''所在行政区域市名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINXJCODE is''所在行政区域县代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ADMINXJNAME is''所在行政区域县名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.EDUCATION is''最高学历''';
		execute immediate 'comment on column BS_MENBER_ZYRY.TEL is''联系电话''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILPRCODE is''通信地址省代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILPRNAME is''通信地址省名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILCITYCODE is''通信地址市代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILCITYNAME is''通信地址市名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILCYCODE is''通信地址县代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.MAILCYNAME is''通信地址县名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.POSTCODE is''邮政编码''';
		execute immediate 'comment on column BS_MENBER_ZYRY.COMPANY is''所在单位''';
		execute immediate 'comment on column BS_MENBER_ZYRY.ISWORKING is''是否在职： 0-不在 1-在''';
		execute immediate 'comment on column BS_MENBER_ZYRY.POST is''职务''';
		execute immediate 'comment on column BS_MENBER_ZYRY.TITLE is''技术职称''';
		execute immediate 'comment on column BS_MENBER_ZYRY.EXPERIENCE is''从业经历''';
		execute immediate 'comment on column BS_MENBER_ZYRY.LIFE is''从业年限''';
		
	end if;
		
	
	
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_ZYRY_GNVQ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_ZYRY_GNVQ  (
		   PKID                 INTEGER                         not null,
		   ZCDJZSBH             VARCHAR2(150),
		   CODE                 VARCHAR2(30),
		   CNVQCODE             VARCHAR2(30),
		   CNVQNAME             VARCHAR2(100),
		   GRADE                VARCHAR2(30),
		   CERTBH               VARCHAR2(150),
		   HYDM                 VARCHAR2(30),
		   constraint PK_BS_MENBER_ZYRY_GNVQ primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_MENBER_ZYRY_GNVQ is''职业人员资质信息''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.PKID is''自增主键''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.ZCDJZSBH is''注册等级证书编号''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.CODE is''职业人员代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.CNVQCODE is''资质序列代码''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.CNVQNAME is''资质序列名称''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.GRADE is''资质等级''';
		execute immediate 'comment on column BS_MENBER_ZYRY_GNVQ.CERTBH is''资质证书编号''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_MENBER_ZYRY_GNVQ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_MENBER_ZYRY_GNVQ_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;
     
     
    -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_CA_CERT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- CA证书管理建表
		execute immediate '
		  create table BS_CA_CERT  (
		   CERTID               NUMBER(10)                      not null,
		   STATUS               INT,
		   CERTYP               INT,
		   APPTYP               INT,
		   SEALTYP              INT,
		   USERID               VARCHAR2(80),
		   USERNAME             VARCHAR2(80),
		   MOBILE               VARCHAR2(30),
		   HYDM                 VARCHAR2(30),
		   MBNAME               VARCHAR2(250),
		   BLR                  VARCHAR2(30),
		   BLRTEL               VARCHAR2(30),
		   CARD_TYPE            VARCHAR2(30),
		   CARD_NUM             VARCHAR2(50),
		   CDATE                DATE,
		   DATE00               DATE,
		   DATE01               DATE,
		   DATE02               DATE,
		   DATE03               DATE,
		   DATE04               DATE,
		   DATE05               DATE,
		   STARTDATE            DATE,
		   ENDDATE              DATE,
		   PRICELX              VARCHAR2(30),
		   YEARS                INT,
		   AMT0                 NUMBER(11,2),
		   AMT1                 NUMBER(11,2),
		   AMT2                 NUMBER(11,2),
		   AMT3                 NUMBER(11,2),
		   AMT4                 NUMBER(11,2),
		   AMT5                 NUMBER(11,2),
		   SHOPT                VARCHAR2(30),
		   REASON               VARCHAR2(250),
		   MCERTID              NUMBER(10),
		   constraint PK_BS_CA_CERT primary key (CERTID)
		)
		';

		execute immediate 'comment on column BS_CA_CERT.CERTID is''CA证书申请编号''';
		execute immediate 'comment on column BS_CA_CERT.STATUS is''状态:内详 1待支付2待处理（已支付）3已拒绝 4已发货 5已生效9已失效''';
		execute immediate 'comment on column BS_CA_CERT.CERTYP is''证书类别 1-企业 2-个人''';
		execute immediate 'comment on column BS_CA_CERT.APPTYP is''申请类型 1-新签 2-续签 3-补办''';
		execute immediate 'comment on column BS_CA_CERT.SEALTYP is''电子印章类别 0-无印章 1-企业印章 2-个人签名''';
		execute immediate 'comment on column BS_CA_CERT.USERID is''绑定账号''';
		execute immediate 'comment on column BS_CA_CERT.USERNAME is''绑定账号姓名''';
		execute immediate 'comment on column BS_CA_CERT.MOBILE is''绑定人联系方式''';
		execute immediate 'comment on column BS_CA_CERT.HYDM is''会员代码''';
		execute immediate 'comment on column BS_CA_CERT.MBNAME is''企业全称''';
		execute immediate 'comment on column BS_CA_CERT.BLR is''办理人''';
		execute immediate 'comment on column BS_CA_CERT.BLRTEL is''办理人联系方式''';
		execute immediate 'comment on column BS_CA_CERT.CARD_TYPE is''证件类型''';
		execute immediate 'comment on column BS_CA_CERT.CARD_NUM is''证件号码''';
		execute immediate 'comment on column BS_CA_CERT.CDATE is''创建日期''';
		execute immediate 'comment on column BS_CA_CERT.DATE00 is''支付日期''';
		execute immediate 'comment on column BS_CA_CERT.DATE01 is''审核日期''';
		execute immediate 'comment on column BS_CA_CERT.DATE02 is''发货日期''';
		execute immediate 'comment on column BS_CA_CERT.DATE03 is''到货日期''';
		execute immediate 'comment on column BS_CA_CERT.DATE04 is''备用''';
		execute immediate 'comment on column BS_CA_CERT.DATE05 is''备用''';
		execute immediate 'comment on column BS_CA_CERT.STARTDATE is''有效开始日期''';
		execute immediate 'comment on column BS_CA_CERT.ENDDATE is''有效结束日期''';
		execute immediate 'comment on column BS_CA_CERT.PRICELX is''价格类型：1年 300元 , 2年 500元, 3年 700元''';
		execute immediate 'comment on column BS_CA_CERT.YEARS is''申请有效期年限 1年 2年 3年''';
		execute immediate 'comment on column BS_CA_CERT.AMT0 is''总金额''';
		execute immediate 'comment on column BS_CA_CERT.AMT1 is''申请有效期价格''';
		execute immediate 'comment on column BS_CA_CERT.AMT2 is''运费''';
		execute immediate 'comment on column BS_CA_CERT.AMT3 is''备用''';
		execute immediate 'comment on column BS_CA_CERT.AMT4 is''备用''';
		execute immediate 'comment on column BS_CA_CERT.AMT5 is''备用''';
		execute immediate 'comment on column BS_CA_CERT.SHOPT is''审核操作员''';
		execute immediate 'comment on column BS_CA_CERT.REASON is''拒绝理由''';
		execute immediate 'comment on column BS_CA_CERT.MCERTID is''新签编号 （续签,补办有效）''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_CA_CERT_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_CA_CERT_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;

     
    tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('JJLY');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''拒绝理由''';
	end if;
	
	tmp1:=upper('BS_MENBER_ZYRY');
	tmp2:=upper('ADDRESS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''详细地址''';
	end if;
	
	tmp1:=upper('BS_MENBER_ZYRY_GNVQ');
	tmp2:=upper('ZGZS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格证书''';
	end if;
	
	tmp1:=upper('BS_MENBER_ZYRY_GNVQ');
	tmp2:=upper('ZCDJZS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册登记证书''';
	end if;

     
    tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('FLAG00');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	   execute immediate 'comment on column BS_CA_CERT.FLAG00 is ''是否被替换 1是 0orNull 否''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('FLAG01');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	   execute immediate 'comment on column BS_CA_CERT.FLAG01 is ''资料是否齐全1是 0否''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('FLAG02');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	   execute immediate 'comment on column BS_CA_CERT.FLAG02 is ''备用''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('FLAG03');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	   execute immediate 'comment on column BS_CA_CERT.FLAG03 is ''备用''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('FPHM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(32))';
	   execute immediate 'comment on column BS_CA_CERT.FLAG03 is ''订单编号''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('KEYBH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(32))';
	   execute immediate 'comment on column BS_CA_CERT.KEYBH is ''KEY编号''';
	end if;
	
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_CA_CERT_ZFQD');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- CA证书支付清单
		execute immediate '
		  create table BS_CA_CERT_ZFQD  (
		   FPHM                 VARCHAR2(32)                    not null,
		   STATUS               INT,
		   COPT                 VARCHAR2(30),
		   CDATE                DATE,
		   AMT0                 NUMBER(11,2),
		   AMT1                 NUMBER(11,2),
		   AMT2                 NUMBER(11,2),
		   AMT3                 NUMBER(11,2),
		   AMT4                 NUMBER(11,2),
		   AMT5                 NUMBER(11,2),
		   IS_INVOICE           INT,
		   INVOICE_TIT          VARCHAR2(200),
		   INVOICE_ACC          VARCHAR2(200),
		   SHLXR                VARCHAR2(30),
		   SHLXTEL              VARCHAR2(30),
		   SHADDR               VARCHAR2(250),
		   WLMC                 VARCHAR2(30),
		   WLDH                 VARCHAR2(30),
		   constraint PK_BS_CA_CERT_ZFQD primary key (FPHM)
		)
		';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.FPHM is ''订单编号''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.STATUS is ''状态:1待支付2已支付3已退款''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.COPT is ''提交操作员''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.CDATE is ''提交时间''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT0 is ''总金额''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT1 is ''证书金额''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT2 is ''运费''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT3 is ''备用''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT4 is ''备用''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.AMT5 is ''备用''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.IS_INVOICE is ''是否开票1是 0OrNull 否''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.INVOICE_TIT is ''发票抬头''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.INVOICE_ACC is ''发票科目''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.SHLXR is ''收货联系人''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.SHLXTEL is ''收货联系方式''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.SHADDR is ''收货地址''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.WLMC is ''物流商''';
		execute immediate 'comment on column BS_CA_CERT_ZFQD.WLDH is ''运单编号''';
	end if;
	
	tmp1:=upper('BS_CA_CERT_ZFQD');
	tmp2:=upper('HYDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
	   execute immediate 'comment on column BS_CA_CERT_ZFQD.HYDM is ''会员代码''';
	end if;
	
	tmp1:=upper('BS_CA_CERT_ZFQD');
    tmp2:=upper('WBNO00');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(32)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''BK平台支付申请单号'''; 
    end if;  

	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('PROFESSNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
	   execute immediate 'comment on column BS_MB_EXT.PROFESSNAME is ''职业人员名称''';
	end if;

	
	
	tmp1:=upper('BS_LOGINSESSION');
	tmp2:=upper('USERMAC');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''登录用户MAC地址''';
	end if;


	tmp1:=upper('BS_LOGINSESSION_BAK');
	tmp2:=upper('USERMAC');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''登录用户MAC地址''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('REGFUNDDW');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册资本单位''';
	end if;
	
	tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('QUALIFICODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(6))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格分类代码''';
	end if;
	
	tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('GRADECODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资质等级''';
	end if;
	
	tmp1:=upper('BS_MENBER_BANK');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MENBER_GNVQ');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MENBER_ZYRY');
	tmp2:=upper('SYSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员系统类型（0或者null-原有老系统，1-军民一体化系统，2....  后面还有其他系统序号相应增加） 所有业务系统用来区分数据都要使用该标识。 业务系统数据标识应该落地到具体业务数据表中，但是对应的字段都应该是这样的，并且名称和值要和该字段保持一致。''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('PROFESSSTATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职业人员信息状态  ：0--未保存   1--以保存''';
	end if;
	
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('dn');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(520))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''证书DN ''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('SEQUENCENO');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(8))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''证书序列号 ''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('SERIALNO');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(40))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''序列号 ''';
	end if;
  
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('AUTHCODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(160))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''授权码 ''';
	end if;
	
	----------------- 2016-11-08 zhangzq CA证书增加材料编号 start--------------------
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('CLBH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''材料编号 ''';
	end if;
	----------------- 2016-11-08 zhangzq CA证书增加材料编号 end--------------------
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('REGFUND');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Number(20，2))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册资本''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('POSTCODE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(6))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邮政编码''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BIDSUBJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招投标交易主体类型''';
	end if;
	
	tmp1:=upper('BS_CA_CERT');
	tmp2:=upper('KEYBH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify('||tmp2||' VARCHAR2(50))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''CA证书编号（公共服务平台）''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BIRTHDATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''出生年月''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('professpostcode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(6))';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('REGFUNDDW');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(1))';
	end if;
	
	-- bs_menber 增加 招投标角色标识 字段
	tmp1:=upper('bs_menber');
	tmp2:=upper('bidderjs');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招投标角色标识 1 or null-招标方 2-代理机构 3-投标方''';
	end if;
	
	tmp1:=upper('Bs_Menber_Zyry_Gnvq');
	tmp2:=upper('indcode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''行业代码''';
	end if;
	
	tmp1:=upper('Bs_Menber_Zyry_Gnvq');
	tmp2:=upper('indname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''行业名称''';
	end if;
	
	tmp1:=upper('Bs_Menber_Zyry_Gnvq');
	tmp2:=upper('majcode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专业类别代码''';
	end if;
	
	tmp1:=upper('Bs_Menber_Zyry_Gnvq');
	tmp2:=upper('majname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专业类别名称''';
	end if;
	
	tmp1:=upper('Bs_Menber_Zyry_Gnvq');
	tmp2:=upper('qualificode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(6))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格分类代码''';
	end if;
	
	tmp1:=upper('BS_MENBER_TMP');
	tmp2:=upper('REGFLAG');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(6))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''用于区分是注册来源   1-招投标  0-其他''';
	end if;
	
	----------zyy start---------
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('YHDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：银行代码''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BKNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：银行名称''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('KHNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(150))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：开户名''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('KHBANK');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：开户行名称''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('KHBKNO');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：开户行支行代码''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('KHZH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：银行帐号''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('KHZM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：基本银行开户证明''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BASICYH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易角色：是否基本银行： 0-否  1-是''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BILLINGYH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(6))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否开票银行： 0-否  1-是''';
	end if;
	
	tmp1:=upper('BS_MB_EXT');
	tmp2:=upper('BANKSTATE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''银行信息状态（只用于交易角色管理）： 0--未保存   1--以保存''';
	end if;
	-----zyy end-------

	tmp1:=upper('BS_LOGINSESSION_BAK');
	tmp2:=upper('ISMOBILE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(3))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''增加手机端登录标识    1-手机端   （0ornull）pc ''';
	end if;
	
	---add by dongbin start---
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_BASE_BANK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_BASE_BANK  (
		    PKID                 INTEGER                         not null,
			CODE                 VARCHAR2(30),
			NAME                 VARCHAR2(200),
			ADDR                 VARCHAR2(300),
			BKNO                 VARCHAR2(50),
			LOGIMG               VARCHAR2(300),
			LXR                  VARCHAR2(50),
			LXFS                 VARCHAR2(30),
			LXADDR               VARCHAR2(300),
		   constraint PK_BS_BASE_BANK primary key (PKID)
		)
		';
		execute immediate 'comment on table BS_BASE_BANK is''基础银行信息维护''';
		execute immediate 'comment on column BS_BASE_BANK.PKID is''自增主键''';
		execute immediate 'comment on column BS_BASE_BANK.CODE is''银行代码（唯一）(英文或者数字)''';
		execute immediate 'comment on column BS_BASE_BANK.NAME is''银行名称''';
		execute immediate 'comment on column BS_BASE_BANK.ADDR is''银行地址''';
		execute immediate 'comment on column BS_BASE_BANK.BKNO is''支付联行号（唯一）(数字)''';
		execute immediate 'comment on column BS_BASE_BANK.LOGIMG is''银行log图片''';
		execute immediate 'comment on column BS_BASE_BANK.LXR is''联系人''';
		execute immediate 'comment on column BS_BASE_BANK.LXFS is''联系方式（手机号）''';
		execute immediate 'comment on column BS_BASE_BANK.LXADDR is''联系地址''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_BASE_BANK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_BASE_BANK_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;
     
     
    tmp1:=upper('BS_BASE_BANK');
	tmp2:=upper('LXFS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''联系方式（手机号）''';
	end if;
	---dongbin end--- 

	--- huangxq start ---
	
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_APPLICATION');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate 'create table BS_APPLICATION  (
		  	PKID                 INTEGER      not null,
		   APPID                 VARCHAR2(30),
		   APPNAME               VARCHAR2(100),
		   APPKEY                VARCHAR2(100),
		   SYSID              	 VARCHAR2(30),
		   REMARK                VARCHAR2(200),
		   OPT                	VARCHAR2(80),
		  CDATE					DATE,
		   constraint BS_APPLICATION  primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_APPLICATION is''站点应用维护''';
		execute immediate 'comment on column BS_APPLICATION.PKID  is''自增主键''';
		execute immediate 'comment on column BS_APPLICATION.APPID is''应用id(英文或者数字)''';
		execute immediate 'comment on column BS_APPLICATION.APPNAME is''应用名称''';
		execute immediate 'comment on column BS_APPLICATION.APPKEY is''应用KEY(英文或者数字)''';
		execute immediate 'comment on column BS_APPLICATION.SYSID is''系统id(英文或者数字)''';
		execute immediate 'comment on column BS_APPLICATION.REMARK is''备注''';
		execute immediate 'comment on column BS_APPLICATION.OPT is''操作员''';
		execute immediate 'comment on column BS_APPLICATION.CDATE is''时间''';
		
	end if;
	
	 num:=0; 
    tmp1:=upper('BS_APPLICATION_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BS_APPLICATION_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
		
		 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_SYS');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_SYS (
		  	PKID                 INTEGER      not null,
		  	SYSID                VARCHAR2(30),
   			SYSNAME              VARCHAR2(100),
  			SYSKEY               VARCHAR2(100),
   			REMARK               VARCHAR2(200),
  		 	OPT                  VARCHAR2(80),
   			CDATE                DATE,
		   constraint BS_SYS  primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_SYS is''系统站点维护''';
		execute immediate 'comment on column BS_SYS.PKID is''自增主键''';
		execute immediate 'comment on column BS_SYS.SYSID is''系统id(英文或者数字)''';
		execute immediate 'comment on column BS_SYS.SYSNAME is''系统名称''';
		execute immediate 'comment on column BS_SYS.SYSKEY is''系统KEY(英文或者数字)''';
		execute immediate 'comment on column BS_SYS.REMARK is''备注''';
		execute immediate 'comment on column BS_SYS.OPT is''操作员''';
		execute immediate 'comment on column BS_SYS.CDATE is''时间''';
		
	end if;
	
	num:=0; 
    tmp1:=upper('BS_SYS_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BS_SYS_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
	---end by huangxq---
	------接口对接报文记录表---BY.hejw------------------------------------
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BS_INTERFACE_LOG');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        execute immediate 'create table BS_INTERFACE_LOG(
            PKID                 NUMBER         not null,
            RQ                   DATE,
            PTYP                 INT,
            FPHM                 VARCHAR2(100),
            REMARK               VARCHAR2(200),
            MESSAGE              CLOB,
            constraint PK_BS_INTERFACE_LOG primary key (PKID)
         )';
         execute immediate 'comment on table BS_INTERFACE_LOG is ''接口对接报文记录表''';
         execute immediate 'comment on column BS_INTERFACE_LOG.PKID is ''主键自增长''';
         execute immediate 'comment on column BS_INTERFACE_LOG.RQ is ''日期''';
         execute immediate 'comment on column BS_INTERFACE_LOG.PTYP is ''接口类型: 内详1 公告服务平台数据同步2 公告服务平台文件上传3 中金在线支付''';
         execute immediate 'comment on column BS_INTERFACE_LOG.FPHM is ''相关单号''';
         execute immediate 'comment on column BS_INTERFACE_LOG.REMARK is ''接口描述''';
         execute immediate 'comment on column BS_INTERFACE_LOG.MESSAGE is ''报文信息''';
     end if;
    -- Create sequence 
    num:=0; 
    tmp1:=upper('BS_INTERFACE_LOG_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BS_INTERFACE_LOG_0
        minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order';
    end if;
	
	--add by chenxp start--
    tmp1:=upper('bs_menber');
    tmp2:=upper('bondflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招投标保证金提现标志 0 or null 不予许提现 ,1-允许提现''';
    end if;
    --add by chenxp end--

	----------------------------------------- hanglong 2017-1-11 申请开通票据业务标识  start -----------------------------------------
    tmp1:=upper('BS_MENBER_JSXZ');
    tmp2:=upper('BPSTATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请开通票据业务标识-网超采购商、供应商、代理商、结算商（0或者null-待申请，1-待审核，2-已审核，3-已拒绝）''';
    end if;
    
    tmp1:=upper('BS_MENBER_JSXZ');
    tmp2:=upper('BPJJLY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1000))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请开通票据业务拒绝理由''';
    end if;
    ----------------------------------------- hanglong 2017-1-11 申请开通票据业务标识  end ------------------------------------------

	---add zyy  扩大会员表法人字段 start---
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('FR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(50))';
	end if;
	---add zyy end---

    --------------------add by songw 2017年2月14日 start------------------
    --add 增加CA证书信息 审核人字段
    tmp1:=upper('BS_CA_CERT');
    tmp2:=upper('SHR');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核人''';
    end if;
    --------------------add by songw 2017年2月14日 end------------------
  -------------------------------------------------------------
end;
