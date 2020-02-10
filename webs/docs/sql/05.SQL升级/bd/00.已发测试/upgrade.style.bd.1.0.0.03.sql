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
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('PRE_WYHDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审委员会代码''';
	end if;	
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('WYHDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标委员会代码''';
	end if;	
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('PRE_STATUS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' 
			is ''资格预审评审状态：0：待评委签到 1：评委都已签到 2：已产生主任 3：已初审完成 4：主任已汇总 5：已详情完成 6：主任已生成评审报告 7：评委都已确认报告''';
	end if;	
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('WYHBH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_PACKAGE add( CHECK_STATUS_TMP INT)';
		execute immediate 'update BD_PACKAGE SET CHECK_STATUS_TMP = CHECK_STATUS';
		execute immediate 'alter table BD_PACKAGE drop column CHECK_STATUS';
		execute immediate 'alter table BD_PACKAGE drop column WYHBH';
		execute immediate 'alter table BD_PACKAGE add( CHECK_STATUS INT)';
		execute immediate 'comment on column BD_PACKAGE.CHECK_STATUS 
			is ''评标状态：0：待评委签到 1：评委都已签到 2：已产生主任 3：已初审完成 4：主任已汇总 5：已详情完成 6：主任已生成评审报告 7：评委都已确认报告''';
		execute immediate 'update BD_PACKAGE SET CHECK_STATUS = CHECK_STATUS_TMP';
		execute immediate 'alter table BD_PACKAGE drop column CHECK_STATUS_TMP';
	end if;	
	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('PRE_ACCORD');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审初审是否符合  0orNull不符合 1-符合''';
	end if;	
	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('PRE_SCORE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(10,2))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审详审得分 ''';
	end if;	
	
	-- BD_CCNOTICE 更换主键  zhaiyy start--
	tmp1:=upper('bd_cc_receipt');
	tmp2:=upper('pkid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' DROP PRIMARY KEY';
		execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER not null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自增主键''';
		execute immediate 'alter table '||tmp1||' add PRIMARY KEY('||tmp2||')';
	end if;	

	num:=0; 
    tmp1:=upper('BD_CONTRACT_MX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_CONTRACT_MX_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
    
    num:=0; 
    tmp1:=upper('BD_CONTRACT_MX');
    select count(1) into num from user_triggers where trigger_name=tmp1;
    if num = 0 then
    	execute immediate '
			CREATE OR REPLACE TRIGGER BD_CONTRACT_MX
			BEFORE INSERT ON BD_CONTRACT_MX FOR EACH ROW
			DECLARE last_Sequence NUMBER; last_InsertID NUMBER;
			BEGIN
			  IF (:NEW.MXID IS NULL)
			  THEN
			    SELECT BD_CONTRACT_MX_0.NEXTVAL INTO :NEW.MXID FROM DUAL;
			  ELSE
			    SELECT Last_Number-1 INTO last_Sequence FROM User_Sequences WHERE UPPER(Sequence_Name) = UPPER(''BD_CONTRACT_MX_0'');
			    SELECT :NEW.MXID INTO last_InsertID FROM DUAL;
			    WHILE (last_InsertID > last_Sequence)
			    LOOP
			      SELECT BD_CONTRACT_MX_0.NEXTVAL INTO last_Sequence FROM DUAL;
			    END LOOP;
			  END IF;
			END;
		';
	end if;

	
	-- BD_PACKAGE 增加中标人代码，中标人名称 字段 xuz start--
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbiddm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标人代码''';
	end if;	
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('winbidmc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标人名称''';
	end if;	
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('dbrq');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标日期''';
	end if;
	-- BD_PACKAGE 增加中标人代码，中标人名称 字段 xuz end--

	--修改标段包状态描述
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('packstatus');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）状态 0-未开标 ,1-流标中 ,2-已流标 ,3-已开标,4-开标记录确认,5-已中标''';
	end if;
	
	
	-- BD_TB_SIGNUP 增加中标状态 字段 xuz start--
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('ISWINBID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否中标 0 or null 未中标 1-已中标''';
	end if;	
	
	--BD_HGZJTZS增加字段 linqingqing start--

	tmp1:=upper('BD_HGZJTZS');
	tmp2:=upper('XZSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''限制时间、多少天内''';
	end if;	
	
	tmp1:=upper('BD_HGZJTZS');
	tmp2:=upper('TZSLB');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书类别0-货物中标通知书 1-工程中标通知书 2-招标结果通知书''';
	end if;	
	
	tmp1:=upper('BD_HGZJTZS');
	tmp2:=upper('GCNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程名称''';
	end if;	
	--linqingqing end--

	--修改投标报名状态描述
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('STATUS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is 
		''状态: 1已报名 2已确认报名 3已拒绝报名 4已购买资格预审文件 5已上传资格预审文 6预审未通过7预审通过 8已购买投标文件 9已上传投标文件 10未中标 11已中标''';
	end if;
	
	--hejw-投标方 确认开标记录---start-------
  tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('RECORD');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
    execute immediate 'comment on column BD_TB_SIGNUP.RECORD is ''开标记录确认 1-已确认''';
  end if; 
  
  tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('RECORDOPT');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
    execute immediate 'comment on column BD_TB_SIGNUP.RECORDOPT is ''开标记录操作员''';
  end if; 
  
  tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('RECORDDATE');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column BD_TB_SIGNUP.RECORDDATE is ''开标记录确认时间''';
  end if; 
	--hejw-投标方 确认开标记录---end-------

	--xuz 新增中标结果公告 start--
	 	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_DB_ZBJGGG');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_DB_ZBJGGG  (
		   PKID                 INT                             not null,
		   PROBID               VARCHAR2(20),
		   PACKID               VARCHAR2(23),
		   HYDM                 VARCHAR2(30),
		   HYMC                 VARCHAR2(80),
		   CONTENT              VARCHAR2(500),
		   FILE1                VARCHAR2(150),
		   ZBRDM                VARCHAR2(30),
		   ZBRMC                VARCHAR2(50),
		   GGDATE               DATE,
		   constraint PK_BD_DB_ZBJGGG primary key (PKID)
		)';

		execute immediate 'comment on table BD_DB_ZBJGGG.PKID is ''主键'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.PROBID is ''招标项目编号'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.PACKID is ''标段包编号'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.HYDM is ''中标人代码'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.HYMC is ''中标人名称'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.CONTENT is ''备注'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.FILE1 is ''附件'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.ZBRDM is ''招标人代码'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.ZBR is ''招标人代码'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.ZBRMC is ''招标人名称'' ';
		execute immediate 'comment on column BD_DB_ZBJGGG.GGDATE is ''公告时间'' ';
	end if; 

	  num:=0; 
	    tmp1:=upper('BD_DB_ZBJGGG_0');
	    select count(1) into num from user_sequences where sequence_name=tmp1;
	    if num = 0 then
	      execute immediate 'create sequence BD_DB_ZBJGGG_0 
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
  
  end if; 
	--xuz 新增中标结果公告 start--

	----2016/06/29 审批流 hanglong start----
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_BILLCHECK_LIST');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_BILLCHECK_LIST
		(
		  PKID       NUMBER(18) not null,
		  CHECKTYP   INTEGER,
		  FPHM       VARCHAR2(30),
		  HYDM       VARCHAR2(30),
		  GROUPID    VARCHAR2(30),
		  GROUPNAME  VARCHAR2(30),
		  USERID     VARCHAR2(30),
		  USERNAME   VARCHAR2(30),
		  SHLEVEL    INTEGER,
		  FLAG1      INTEGER,
		  FLAG2      INTEGER,
		  FLAG3      INTEGER,
		  DATE1      DATE,
		  DATE2      DATE,
		  DATE3      DATE,
		  REF1       VARCHAR2(250),
		  REF2       VARCHAR2(250),
		  REF3       VARCHAR2(250),
		  TOTALLEVEL INTEGER,
		  FLAG4      INTEGER,
		  FLAG5      INTEGER,
		  REF4       VARCHAR2(30),
		  REF5       VARCHAR2(30),
		  BSGID      VARCHAR2(30),
		  BSGNAME    VARCHAR2(100),
		  constraint PK_BD_BILLCHECK_LIST primary key (PKID)
		)';

		execute immediate 'comment on table BD_BILLCHECK_LIST is ''单据审核流水'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.PKID is ''自增主键'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.CHECKTYP is ''审核类型： 7-合同'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.FPHM is ''单据号'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.HYDM is ''会员代码'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.GROUPID is ''审核组id'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.USERID is ''审核人'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.SHLEVEL is ''节点级别（该节点在总级别中所处的等级） ：取基础平台的审核组bs_check_group 级别'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.FLAG1 is ''审核标识： 0 作废 1 未审核 2 已审核 3 已拒绝'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.FLAG2 is ''扩展用（暂时值默认2）节点审批类型 1：有序 2 ：无序'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.FLAG3 is ''扩展用（暂时值默认0）节点审批顺序 ：当flag2 = 1 时，第1位、第2位...当flag2= 2时，值为0，表示无序'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.DATE1 is ''审核日期'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.REF1 is ''拒绝理由'' ';
		execute immediate 'comment on column BD_BILLCHECK_LIST.TOTALLEVEL is ''审批等级（总等级），1级表示无序。大于1级，表示有序。每个级别可以添加多个审批人。同一级别内的审核员为无序审核'' ';
	end if; 

	num:=0; 
    tmp1:=upper('BD_BILLCHECK_LIST_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_BILLCHECK_LIST_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
    ----2016/06/29 审批流 hanglong end----
	
	-- BD_TB_SIGNUP 增加 投标文件递交状态 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJDJZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交状态 0 or null-未上传 1-已上传未提交 2-已提交''';
	end if;
	-- BD_TB_SIGNUP 增加 投标文件递交时间 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJDJSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交时间''';
	end if;
	-- BD_TB_SIGNUP 增加 投标文件递交操作员 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJDJCZYDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交操作员''';
	end if;
	-- BD_TB_SIGNUP 增加 投标文件递交操作员姓名 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJDJCZYNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交操作员姓名''';
	end if;
	
	-- BD_FB_TB_FILE 修改备注 文件类型
	tmp1:=upper('BD_FB_TB_FILE');
	tmp2:=upper('FILETYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件类型 1-投标文件格式 2-技术标准和要求（工程类招标） 3-图纸（工程类招标） 4-工程量清单（工程类招标） 5-标书模板文件 6-投标模板文件''';
	end if;
	-- BD_FB_TB_FILE 修改备注 文件种类
	tmp1:=upper('BD_FB_TB_FILE');
	tmp2:=upper('FILEKIND');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件种类 1-招标文件 2-数据包 3-价格清单 4-投标文件 9-其它''';
	end if;

------------修改有数据字段 bd_tb_signup status 长度----------------------------------------------------
	-- 增加 status_tmp
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
	end if;
	-- 赋值 status_tmp
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set status_tmp = status';
	end if;
	-- 清空 status
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set status=null';
	end if;
	-- 修改 status
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2))';
	end if;	
	-- 赋值 status
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set status = status_tmp';
	end if;
	-- 删除 status_tmp
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('status_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;	
	
	-- BD_ZB_FILE 修改备注 文件类型
	tmp1:=upper('BD_ZB_FILE');
	tmp2:=upper('FILETYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件类型 nodetype=1时 1-申请人须知 2-评审办法 3-申请文件格式 4-参考资料 5-资格预审文件 6-资格预审申请文件''';
	end if;
	
	------------修改有数据字段长度结束----------------------------------------------------

	--add by longf start ---
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('date01');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评标报告日期''';
    end if;
    
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('pbyj');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标意见''';
    end if;
    
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('filepath01');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评标报告-附件路径''';
    end if;
	--add by longf end ---

	-- BD_FB_ZBCSSZ 增加字段 start--
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('CSTYPE');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''参数类型 1-预审文件参数 2-招标文件参数''';
	end if;
	

	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('SQRYQCQZGYSJZSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请人要求澄清资格预审文件的截止时间''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('ZBRCQZGYSJZSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人澄清资格预审文件的截止时间''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('SQRQRSDYSCQSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请人确认收到资格预审文件澄清的时间''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('ZBRXGZGYSJZSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人修改资格预审文件的截止时间''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('SQRQRSDYSXGSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请人确认收到资格预审文件修改的时间''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('SCWYHNUM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查委员会人数''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('QZWHYRS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其中委员会人数''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('QZZJRS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其中专家人数''';
	end if;
	
	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('STATUS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''参数状态 0 or null 未提交 1-已提交''';
	end if;
	-- BD_FB_ZBCSSZ 增加字段 end--
	
	--hejw-------start---
 -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_PACKAGE_EXT');
  select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
      -- 建表
    execute immediate '
      create table BD_PACKAGE_EXT  (
       PKID                 NUMBER                          not null,
       BDID                 VARCHAR2(23)                    not null,
       ZBROPT               VARCHAR2(50),
       ZBRSEAL              CLOB,
       DLJGOPT              VARCHAR2(50),
       DLJGSEAL             CLOB,
       JDROPT               VARCHAR2(50),
       JDRSEAL              CLOB,
       constraint PK_BD_PACKAGE_EXT primary key (PKID)
    )';

    execute immediate 'comment on table BD_PACKAGE_EXT is ''标段（包）扩展表'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.PKID is ''主键自增'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.BDID is ''标段（包）编号'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.ZBROPT is ''开标记录确认  招标方签章确认人'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.ZBRSEAL is ''开标记录确认   招标方签章'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.DLJGOPT is ''开标记录确认  代理机构确认人'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.DLJGSEAL is ''开标记录确认  代理机构签章'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.JDROPT is ''开标记录确认   监标人'' ';
    execute immediate 'comment on column BD_PACKAGE_EXT.JDRSEAL is ''开标记录确认  监标人签章'' ';
  end if;
  
   num:=0; 
    tmp1:=upper('BD_PACKAGE_EXT_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_PACKAGE_EXT_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if; 
	--hejw-------end---


	--add by longf start ---
   	-- 修改 lxrtel 字段长度
	tmp1:=upper('BD_JURY_MEMBER');
	tmp2:=upper('LXRTEL');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_JURY_MEMBER modify( LXRTEL VARCHAR2(30))';
	end if;	
	--add by longf end ---

	-- BD_TBYQSBZ 增加字段 start --
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('TYP');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邀请书类型：1-邀请后审  2-资格预审投标  3-资格预审结果''';
	end if;
	-- BD_TBYQSBZ 增加字段 end--

  --hejw
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('autoflag');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3))';
  execute immediate 'comment on column BD_PACKAGE.autoflag is ''用于定时任务判断  10-标段包30分钟内签到人数没有达到3家 已发送过短信   20-到达开标时间已解密过投标方文件''';
  end if;

	
	-- BD_TD_DD 增加 备注 字段
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('BZ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(250) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
	end if;
	-- BD_TD_DD 增加 凭证路径 字段
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('PZPATH');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证路径''';
	end if;
	-- BD_TD_DD 增加 凭证名称 字段
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('PZNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证名称''';
	end if;
	
	-- BD_TD_DD 修改备注 支付状态
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('FLAG1');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付状态 0-未提交 1-已提交 2-已支付 3-已确认''';
	end if;
	-- BD_TD_DD 修改备注 费用来源
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('FYLY');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''费用来源 1-资格预审文件 2-招标文件 3-保证金 ''';
	end if;	
	
	-- BD_TBYQSBZ 增加字段 start  --
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('BDID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(23))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）编号''';
	end if;
	-- BD_TBYQSBZ 增加字段 end--
	
	-- BD_TBYQSBZ 增加字段 start  --
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('DATE01');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评标报告日期''';
	end if;
	
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('INVITEUNITID');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''被邀请单位ID''';
	end if;
	-- BD_TBYQSBZ 增加字段 end--

  -------------------------------------------------------------
end;