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
  
  	----tanqinli-start----
  	-- BD_PACKAGE 增加 是否制作招标文件 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('flag02');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''买家代码，卖家买自己的资源时选择的买家''';
	end if;
	-- BD_PACKAGE 增加 是否制作招标文件选择模板 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('flag03');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否制作招标文件选择模板 0 or null-未选择 1-已选择''';
	end if;	
	
	----tanqinli-end----

	--add by longf start ---
	tmp1:=upper('BD_JURY');
  	tmp2:=upper('gbunit');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规避单位，多个逗号隔开''';
    end if;
	--add by longf end ---

  	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_OBJECTION');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_OBJECTION  (
		   PKID                 INT                             not null,
		   PROBID               VARCHAR2(20)                    not null,
		   PROBNAME             VARCHAR2(1000),
		   BDID               	VARCHAR2(23)                    not null,
		   PACKNAME             VARCHAR2(200),
		   TYP                  CHAR(1),
		   STATUS               CHAR(1),
		   HYDM                 VARCHAR2(18),
		   HYNAME               VARCHAR2(100),
		   REASON               CLOB,
		   CONTENT              CLOB,
		   FILESTR              VARCHAR2(50),
		   CDATE                DATE,
		   HZDM                 VARCHAR2(18),
		   HZNAME               VARCHAR2(100),
		   DATE1                DATE,
		   RESULT               CLOB,
		   DATE2                DATE,
		   FILESTR1             VARCHAR2(50),
		   constraint PK_BD_OBJECTION primary key (PKID)
	)
		';
		-- 注释	
		execute immediate 'comment on column BD_OBJECTION.PKID is''主键''';
		execute immediate 'comment on column BD_OBJECTION.PROBID is''招标项目编号''';
		execute immediate 'comment on column BD_OBJECTION.PROBNAME is''招标项目名称''';
		execute immediate 'comment on column BD_OBJECTION.BDID is''标段包编号''';
		execute immediate 'comment on column BD_OBJECTION.PACKNAME is''标段包名称''';
		execute immediate 'comment on column BD_OBJECTION.TYP is''类型1.资格预审文件2.资格预审结果3.招标文件4.开标过程5.中标候选人公示''';
		execute immediate 'comment on column BD_OBJECTION.STATUS is''状态0. 未回复 1.已受理 2.已回复''';
		execute immediate 'comment on column BD_OBJECTION.HYDM is''异议人会员代码''';
		execute immediate 'comment on column BD_OBJECTION.HYNAME is''异议人会员全程''';
		execute immediate 'comment on column BD_OBJECTION.REASON is''依据和理由''';
		execute immediate 'comment on column BD_OBJECTION.CONTENT is''异议内容''';
		execute immediate 'comment on column BD_OBJECTION.FILESTR is''附件''';
		execute immediate 'comment on column BD_OBJECTION.CDATE is''异议提交时间''';
		execute immediate 'comment on column BD_OBJECTION.HZDM is''受理人会员代码''';
		execute immediate 'comment on column BD_OBJECTION.HZNAME is''受理人单位''';
		execute immediate 'comment on column BD_OBJECTION.DATE1 is''受理时间''';
		execute immediate 'comment on column BD_OBJECTION.RESULT is''处理结果''';
		execute immediate 'comment on column BD_OBJECTION.DATE2 is''反馈时间''';
		execute immediate 'comment on column BD_OBJECTION.FILESTR1 is''反馈附件''';
end if; 

num:=0; 
    tmp1:=upper('BD_OBJECTION_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_OBJECTION_0 
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
  end if; 
  
  
    --标的物标价明细表---hejw---start--
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_OFFER_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_OFFER_MX  (
			   PKID                 NUMBER                          not null,
			   ZBFDM                VARCHAR2(30)                    not null,
			   TBFDM                VARCHAR2(30)                    not null,
			   BDWID                VARCHAR2(200),
			   BDWMC                VARCHAR2(200),
			   BDID                 VARCHAR2(23)                    not null,
			   GG                   VARCHAR2(300),
			   CGSL                 NUMBER,
			   PRICE                NUMBER(30,2),
			   JHDATE               DATE,
			   ZZSNAME              VARCHAR2(400),
		constraint PK_BD_OFFER_MX primary key (PKID)
	   )';

		execute immediate '	comment on table BD_OFFER_MX is ''标的物报价明细''';
		execute immediate '	comment on column BD_OFFER_MX.PKID is ''自增主键''';
		execute immediate '	comment on column BD_OFFER_MX.ZBFDM is ''招标方代码''';
		execute immediate '	comment on column BD_OFFER_MX.TBFDM is ''投标方代码''';
		execute immediate '	comment on column BD_OFFER_MX.BDWID is ''标的物id''';
		execute immediate '	comment on column BD_OFFER_MX.BDWMC is ''标的物名称''';
		execute immediate '	comment on column BD_OFFER_MX.BDID is ''标段包id''';
		execute immediate '	comment on column BD_OFFER_MX.GG is ''规格''';
		execute immediate '	comment on column BD_OFFER_MX.CGSL is ''采购数量''';
		execute immediate '	comment on column BD_OFFER_MX.PRICE is ''报价''';
    execute immediate '  comment on column BD_OFFER_MX.JHDATE is ''交货时间''';
    execute immediate '  comment on column BD_OFFER_MX.ZZSNAME is ''制造商名称''';
  end if; 
  
  num:=0; 
    tmp1:=upper('BD_OFFER_MX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_OFFER_MX_0 
      minvalue 1
      maxvalue 9999999999999999999999999999
      start with 1
      increment by 1
      nocache
      order
      ';
  end if; 	
  
  --标的物标价明细表---hejw---end--

    -- BD_ZBGG 增加 购买招标开始时间 字段
  tmp1:=upper('BD_ZBGG');
  tmp2:=upper('zbbskssj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''购买招标开始时间''';
	end if;

    -- BD_ZBGG 增加 购买招标结束时间 字段
  tmp1:=upper('BD_ZBGG');
  tmp2:=upper('zbbsjssj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''购买招标结束时间''';
	end if;  
	
	-- BD_TB_SIGNUP 增加 会员名称 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('HYNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(250) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员名称''';
	end if;
	-- BD_TB_SIGNUP 增加 会员部门ID 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('DEPID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员部门ID''';
	end if;
	-- BD_TB_SIGNUP 增加 会员部门名称 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('DEPNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员部门名称''';
	end if;
	
  -------------------------------------------------------------
end;