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

	--mazg start--
	--修改注释
	tmp1:=upper('bd_td_dd');
	tmp2:=upper('flag1');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
		if num = 1 then
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''0-未申请 1-已申请 2-已支付''';
	end if;
	--mazg end--
--修改公告状态描述
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('STATUS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''公告状态为0-未发布，1-待审核，2-审核通过，3审核拒绝''';
	end if;
	
-- BD_ZBGG 增加hydm,hymc,depid,depname, 字段 xuz start--
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('hydm');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员代码''';
	end if;	
	
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('hymc');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员名称''';
	end if;	
	
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('depid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门代码''';
	end if;	
	
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('depname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门名称''';
	end if;	
	
	tmp1:=upper('BD_ZBGG');
	tmp2:=upper('sfkxg');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否可修改 0 or null可修改,1-不可修改''';
	end if;	
-- BD_ZBGG 增加hydm,hymc,depid,depname 字段 xuz end--

-- BD_PACKAGE 增加yswjzt,字段 xuz start--
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('yswjzt');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审文件状态0 or null 未发布 1-已发布''';
	end if;	
-- BD_PACKAGE 增加yswjzt,字段 xuz end--


--澄清文件回执---zhaiyy---start--
   -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CC_RECEIPT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
	create table BD_CC_RECEIPT  (
	   BDID                 VARCHAR(23)                     not null,
	   ZBID                 VARCHAR(50),
	   TBRID                VARCHAR(30),
	   TBRNAME              VARCHAR(250),
	   RECEIPT              CHAR(1),
	   HZFILE               VARCHAR(100),
	   CQID                 VARCHAR2(50),
	   TITLE                VARCHAR(200),
	   constraint PK_BD_CC_RECEIPT primary key (BDID)
	)
		';
	-- 注释	
		execute immediate 'comment on table BD_CC_RECEIPT is ''澄清文件回执'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.BDID is ''标段包编号'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.ZBID is ''招标项目编号'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.TBRID is ''投标人代码'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.TBRNAME is ''投标人名称'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.RECEIPT is ''是否回执： 0-否  1-是'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.CQID is ''澄清文件编号'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.TITLE is ''公告标题'' ';
		execute immediate 'comment on column BD_CC_RECEIPT.HZFILE is ''回执附件'' ';
	end if; 
  
  --澄清文件回执---zhaiyy---end--

	--linqinging start--
	--职业资格序列
    num :=0;
    tmp1 := upper('BD_JOB_TYPE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_JOB_TYPE  (
		   PKID                 INT                             not null,
		   CODE                 VARCHAR2(30)                     not null,
		   NAME                 VARCHAR2(100)                    not null,
		   FATHER               VARCHAR2(30),
		   CODES                VARCHAR2(100),
		   ISCHILD              INT,
		   PLEVEL              	INT,
		   ISSHOW               INT,
		   CDATE                TIMESTAMP,
		   UDATE                TIMESTAMP,
		   constraint PK_BD_JOB_TYPE primary key (PKID)
		)';
	  execute immediate 'comment on table BD_JOB_TYPE is ''职业资格序列''';
    execute immediate 'comment on column BD_JOB_TYPE.PKID is ''自增主键''';
    execute immediate 'comment on column BD_JOB_TYPE.CODE is ''代码''';
    execute immediate 'comment on column BD_JOB_TYPE.NAME is ''名称''';
    execute immediate 'comment on column BD_JOB_TYPE.FATHER is ''父级代码''';
    execute immediate 'comment on column BD_JOB_TYPE.CODES is ''层级组合代码值''';
    execute immediate 'comment on column BD_JOB_TYPE.ISCHILD is ''是否包含子类（0 or other - 否，1 - 是）''';
    execute immediate 'comment on column BD_JOB_TYPE.PLEVEL is ''当前节点层级（1-第一层，2-第二层，3-第三层...）''';
    execute immediate 'comment on column BD_JOB_TYPE.ISSHOW is ''是否在前台显示（0 or other - 否，1 - 是）''';
    execute immediate 'comment on column BD_JOB_TYPE.CDATE is ''新增时间''';
    execute immediate 'comment on column BD_JOB_TYPE.UDATE is ''最后修改时间''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_JOB_TYPE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_JOB_TYPE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
    
   --公告表
    num :=0;
    tmp1 := upper('BD_NOTICE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_NOTICE  (
       PKID                 INT                             not null,
       TITLE                VARCHAR2(300),
       SUBTITLE             VARCHAR2(300),
       CONTENT              CLOB,
       AUTHOR               VARCHAR2(80),
       FILENAME             VARCHAR2(300),
       FILEPATH             VARCHAR2(300),
       TYP                  INT,
       ISSHOW               INT,
       FPHM                 VARCHAR2(100),
       CDATE                DATE,
       UDATE                DATE,
       CHECKAU              VARCHAR2(80),
       SDATE                DATE,
       constraint PK_BD_NOTICE primary key (PKID)
    )';
  execute immediate 'comment on column BD_NOTICE.TITLE is ''公告标题''';
  execute immediate 'comment on column BD_NOTICE.SUBTITLE is ''公告副标题''';
  execute immediate 'comment on column BD_NOTICE.CONTENT is ''公告内容''';
  execute immediate 'comment on column BD_NOTICE.AUTHOR is ''公告作者''';

  execute immediate 'comment on column BD_NOTICE.FILENAME is ''附件名称''';

  execute immediate 'comment on column BD_NOTICE.FILEPATH is ''附件地址''';

  execute immediate 'comment on column BD_NOTICE.TYP is ''公告类型（1-系统公告，...）''';

  execute immediate 'comment on column BD_NOTICE.ISSHOW is ''是否在前台显示（0 or other - 否，1 - 是）''';

  execute immediate 'comment on column BD_NOTICE.FPHM is ''公告关联的业务单据号''';

  execute immediate 'comment on column BD_NOTICE.CDATE is ''公告发布时间''';

  execute immediate 'comment on column BD_NOTICE.UDATE is ''最后修改时间''';

  execute immediate 'comment on column BD_NOTICE.CHECKAU is ''审核人''';

  execute immediate 'comment on column BD_NOTICE.SDATE is ''审核时间''';

    end if;
  
    num:=0; 
    tmp1:=upper('BD_NOTICE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_NOTICE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;  


  --投标邀请书编制
    num :=0;
    tmp1 := upper('BD_TBYQSBZ');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_TBYQSBZ  (
       PKID                 INT                             not null,
       PROBID               VARCHAR(100),
       PRONAME              VARCHAR(200),
       INVITEUNIT           VARCHAR(200),
       ORNAME               VARCHAR(200),
       APNAME               VARCHAR(200),
       APNUMBER             VARCHAR(100),
       PROOWNER             VARCHAR(100),
       SOUFUND              VARCHAR(100),
       PROPORTION           VARCHAR(100),
       SITUATION            CLOB,
       QUATION              VARCHAR(100),
       PREULT               VARCHAR(100),
       WHETHER              VARCHAR(100),
       REQUIREMENT          CLOB,
       PROFESSIONAL         VARCHAR(100),
       PLEVEL               VARCHAR(100),
       BSTIME               DATE,
       BOTIME               DATE,
       MSTIME               VARCHAR(10),
       MOTIME               VARCHAR(10),
       ASTIME               VARCHAR(10),
       AOTIME               VARCHAR(10),
       BUEDRESS             VARCHAR(100),
       PRICE                VARCHAR(100),
       DEPOSIT              VARCHAR(100),
       POUNDAGE             VARCHAR(100),
       MAILTIME             VARCHAR(10),
       TBOTIME              DATE,
       TBADRESS             VARCHAR(100),
       CONTIME              DATE,
       TENDERER             VARCHAR(100),
       TENADD               VARCHAR(100),
       TENZIP               VARCHAR(100),
       TENCON               VARCHAR(100),
       TENPHONE             VARCHAR(100),
       TENFAX               VARCHAR(100),
       TENMAIL              VARCHAR(100),
       TENURL               VARCHAR(100),
       TENBANK              VARCHAR(100),
       TENCCO               VARCHAR(100),
       AGPENT               VARCHAR(100),
       AGADD                VARCHAR(100),
       AGZIP                VARCHAR(100),
       AGCON                VARCHAR(100),
       AGPHONE              VARCHAR(100),
       AGFAX                VARCHAR(100),
       AGMAIL               VARCHAR(100),
       AGURL                VARCHAR(100),
       AGBANK               VARCHAR(100),
       AGCCO                VARCHAR(100),
       TSTATE               VARCHAR(100),
       TBBON                VARCHAR(100),
       TBBZTO               VARCHAR(100),
       TBBZTH               VARCHAR(100),
       FBDATE               DATE,
       FBAUTHOR             VARCHAR(100),
       PERIOD               VARCHAR(200),
       FBMJ                 VARCHAR(200),
       QTMJ                 VARCHAR(200),
       FILENAME             VARCHAR(300),
   	   FILEPATH             VARCHAR(300),
       constraint PK_BD_TBYQSBZ primary key (PKID)
    )';
    execute immediate 'comment on table BD_TBYQSBZ  is ''投标邀请书编制''';
    execute immediate 'comment on column BD_TBYQSBZ.PKID is ''自增主键''';
    execute immediate 'comment on column BD_TBYQSBZ.PROBID is ''招标项目编号''';
    execute immediate 'comment on column BD_TBYQSBZ.PRONAME is ''项目名称''';
    execute immediate 'comment on column BD_TBYQSBZ.INVITEUNIT is ''被邀请单位''';
    execute immediate 'comment on column BD_TBYQSBZ.ORNAME is ''项目审批、核准或备案机关名称''';
    execute immediate 'comment on column BD_TBYQSBZ.APNAME is ''批文名称''';
    execute immediate 'comment on column BD_TBYQSBZ.APNUMBER is ''批文编号''';
    execute immediate 'comment on column BD_TBYQSBZ.PROOWNER is ''项目业主''';
    execute immediate 'comment on column BD_TBYQSBZ.SOUFUND is ''资金来源''';
    execute immediate 'comment on column BD_TBYQSBZ.PROPORTION is ''出资比例''';
    execute immediate 'comment on column BD_TBYQSBZ.SITUATION is ''项目概况与招标范围''';
    execute immediate 'comment on column BD_TBYQSBZ.QUATION is ''资质''';
    execute immediate 'comment on column BD_TBYQSBZ.PREULT is ''业绩''';
    execute immediate 'comment on column BD_TBYQSBZ.WHETHER is ''可以或者不可以''';
    execute immediate 'comment on column BD_TBYQSBZ.REQUIREMENT is ''联合体投标要求''';
    execute immediate 'comment on column BD_TBYQSBZ.PROFESSIONAL is ''专业''';
    execute immediate 'comment on column BD_TBYQSBZ.PLEVEL is ''级别''';
    execute immediate 'comment on column BD_TBYQSBZ.BSTIME is ''购买招标文件开始时间''';
    execute immediate 'comment on column BD_TBYQSBZ.BOTIME is ''购买招标文件结束时间''';
    execute immediate 'comment on column BD_TBYQSBZ.MSTIME is ''上午开始时间''';
    execute immediate 'comment on column BD_TBYQSBZ.MOTIME is ''上午结束时间''';
    execute immediate 'comment on column BD_TBYQSBZ.ASTIME is ''下午开始时间''';
    execute immediate 'comment on column BD_TBYQSBZ.AOTIME is ''下午结束时间''';
    execute immediate 'comment on column BD_TBYQSBZ.BUEDRESS is ''购买招标文件地址''';
    execute immediate 'comment on column BD_TBYQSBZ.PRICE is ''招标文件单价（每套）''';
    execute immediate 'comment on column BD_TBYQSBZ.DEPOSIT is ''押金''';
    execute immediate 'comment on column BD_TBYQSBZ.POUNDAGE is ''手续费''';
    execute immediate 'comment on column BD_TBYQSBZ.MAILTIME is ''时间内寄送''';
    execute immediate 'comment on column BD_TBYQSBZ.TBOTIME is ''投票截止时间/投标文件递交的截止时间''';
    execute immediate 'comment on column BD_TBYQSBZ.TBADRESS is ''投标文件递交地址''';
    execute immediate 'comment on column BD_TBYQSBZ.CONTIME is ''收到投标邀请书确认时间''';
    execute immediate 'comment on column BD_TBYQSBZ.TENDERER is ''招标人''';
    execute immediate 'comment on column BD_TBYQSBZ.TENADD is ''招标人地址''';
    execute immediate 'comment on column BD_TBYQSBZ.TENZIP is ''招标人邮编''';
    execute immediate 'comment on column BD_TBYQSBZ.TENCON is ''招标联系人''';
    execute immediate 'comment on column BD_TBYQSBZ.TENPHONE is ''招标人电话''';
    execute immediate 'comment on column BD_TBYQSBZ.TENFAX is ''招标人传真''';
    execute immediate 'comment on column BD_TBYQSBZ.TENMAIL is ''招标人电子邮件''';
    execute immediate 'comment on column BD_TBYQSBZ.TENURL is ''招标人网址''';
    execute immediate 'comment on column BD_TBYQSBZ.TENBANK is ''招标人开户银行''';
    execute immediate 'comment on column BD_TBYQSBZ.TENCCO is ''招标人银行账号''';
    execute immediate 'comment on column BD_TBYQSBZ.AGPENT is ''招标代理机构''';
    execute immediate 'comment on column BD_TBYQSBZ.AGADD is ''代理地址''';
    execute immediate 'comment on column BD_TBYQSBZ.AGZIP is ''代理邮编''';
    execute immediate 'comment on column BD_TBYQSBZ.AGCON is ''代理联系人''';
    execute immediate 'comment on column BD_TBYQSBZ.AGPHONE is ''代理电话''';
    execute immediate 'comment on column BD_TBYQSBZ.AGFAX is ''代理传真''';
    execute immediate 'comment on column BD_TBYQSBZ.AGMAIL is ''代理电子邮件''';
    execute immediate 'comment on column BD_TBYQSBZ.AGURL is ''代理网址''';
    execute immediate 'comment on column BD_TBYQSBZ.AGBANK is ''代理银行''';
    execute immediate 'comment on column BD_TBYQSBZ.AGCCO is ''代理银行账号''';
    execute immediate 'comment on column BD_TBYQSBZ.TSTATE is ''是否已发布0-否，1-是''';
    execute immediate 'comment on column BD_TBYQSBZ.TBBON is ''会员代码''';
    execute immediate 'comment on column BD_TBYQSBZ.TBBZTO is ''新增邀请书时间''';
    execute immediate 'comment on column BD_TBYQSBZ.TBBZTH is ''修改邀请书时间''';
    execute immediate 'comment on column BD_TBYQSBZ.FBDATE is ''邀请书发布日期''';
    execute immediate 'comment on column BD_TBYQSBZ.FBAUTHOR is ''邀请书发布人''';
    execute immediate 'comment on column BD_TBYQSBZ.PERIOD is ''投标有效期''';
    execute immediate 'comment on column BD_TBYQSBZ.FBMJ is ''公告发布的媒介''';
    execute immediate 'comment on column BD_TBYQSBZ.QTMJ is ''其他公告发布的媒介''';
    execute immediate 'comment on column BD_TBYQSBZ.FILENAME is ''附件名称''';
    execute immediate 'comment on column BD_TBYQSBZ.FILEPATH is ''附件地址''';

    end if;
  
    num:=0; 
    tmp1:=upper('BD_TBYQSBZ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_TBYQSBZ_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
	--linqinging end--

	-- BD_PACKAGE 增加 招标文件状态 字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('ZBWJZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件状态 0 or null-未上传 1-已上传未预览提交 2-已预览提交 3-已预览确认（委托招标） 4-已发布''';
	end if;
	
	--mazg start--
	--招标异常表
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_ZB_YC');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_ZB_YC  (
		   PKID                 INT                             not null,
		   PROBID               VARCHAR2(20),
		   PROBNAME             VARCHAR2(100),
		   BDID                 VARCHAR2(23),
		   PACKNAME             VARCHAR2(200),
		   FILEPATH             VARCHAR2(200),
		   YCMS                 VARCHAR2(500),
		   DATE0                DATE,
		   HYDM                 VARCHAR2(9),
		   HYNAME               VARCHAR2(50),
		   SHYDM                VARCHAR2(9),
		   SHYNAME              VARCHAR2(50),
		   SHJG                 CLOB,
		   DATE1                DATE,
		   constraint PK_BD_ZB_YC primary key (PKID)
		)
		';		
		-- 注释			
		execute immediate ' 	comment on table BD_ZB_YC is ''招标异常'' ';		
		execute immediate '	comment on column BD_ZB_YC.PKID is ''自增主键'' ';
		execute immediate '	comment on column BD_ZB_YC.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_ZB_YC.PROBNAME is ''招标项目名称'' ';
		execute immediate '	comment on column BD_ZB_YC.BDID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_ZB_YC.PACKNAME is ''标段（包）名称'' ';
		execute immediate '	comment on column BD_ZB_YC.FILEPATH is ''附件路径'' ';
		execute immediate '	comment on column BD_ZB_YC.YCMS is ''异常描述'' ';
		execute immediate '	comment on column BD_ZB_YC.DATE0 is ''提交时间'' ';
		execute immediate '	comment on column BD_ZB_YC.HYDM is ''提交人代码'' ';
		execute immediate '	comment on column BD_ZB_YC.HYNAME is ''提交人名称'' ';
		execute immediate '	comment on column BD_ZB_YC.SHYDM is ''审核或核准人代码'' ';
		execute immediate '	comment on column BD_ZB_YC.SHYNAME is ''审核或核准人名称'' ';
		execute immediate '	comment on column BD_ZB_YC.SHJG is ''审批或核准结果'' ';
		execute immediate '	comment on column BD_ZB_YC.DATE1 is ''审批或核准时间'' ';

	end if;
	
	num:=0; 
    tmp1:=upper('BD_ZB_YC_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_ZB_YC_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
  	--mazg end--

	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('flag02');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否制作招标文件''';
	end if;
	
	-- 项目清单增加字段 hanglong start--
	tmp1:=upper('BD_PROJECT_ITEM');
	tmp2:=upper('itemCode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项编码''';
	end if;	
	
	tmp1:=upper('BD_PROJECT_ITEM');
	tmp2:=upper('itemDes');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项名称''';
	end if;	
	
	tmp1:=upper('BD_PROJECT_ITEM');
	tmp2:=upper('tbpcCode');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''TBPC编码''';
	end if;	
	
	tmp1:=upper('BD_PROJECT_ITEM');
	tmp2:=upper('features');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''特征''';
	end if;	
	-- 项目清单增加字段 hanglong end--
	--add by xuz start--
	  tmp1:=upper('BD_DISSENT');
	  tmp2:=upper('qfilepath');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	  execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(100)';
	  end if; 
	  
	  tmp1:=upper('BD_DISSENT');
	  tmp2:=upper('afilepath');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	  execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(100)';
	  end if; 
	--add by xuz end--
	
	-- BD_FB_TB_FILE 增加 文件种类 字段
	tmp1:=upper('BD_FB_TB_FILE');
	tmp2:=upper('FILEKIND');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件种类 1-招标文件 2-数据包 3-价格清单 9-其它''';
	end if;
	
	-- 预审/招标文件合同表增加字段 hanglong start--
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('userid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成合同的操作员id''';
	end if;	
	
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('username');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成合同的操作员名称''';
	end if;	
	
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('depid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成合同的操作员部门id''';
	end if;	
	
	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('depname');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成合同的操作员部门名称''';
	end if;	
	-- 预审/招标文件合同表增加字段 hanglong end--

	--更改bd_subproject表的flag3字段备注 xuz start--
	tmp1:=upper('BD_SUBPROJECT');
	tmp2:=upper('flag3');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then		
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审公告状态 1-已编制，0 or null 未编制,2-已发布''';
	end if;
	--更改bd_subproject表的flag3字段备注 xuz end--

	--add by hejw start--
    tmp1:=upper('BD_SUBPROJECT_ITEM');
  tmp2:=upper('itemCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项编码''';
  end if;  
  
  tmp1:=upper('BD_SUBPROJECT_ITEM');
  tmp2:=upper('itemDes');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项名称''';
  end if;  
  
  tmp1:=upper('BD_SUBPROJECT_ITEM');
  tmp2:=upper('tbpcCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''TBPC编码''';
  end if;  
  
  tmp1:=upper('BD_SUBPROJECT_ITEM');
  tmp2:=upper('features');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''特征''';
  end if;  
  
  
  tmp1:=upper('BD_PACKAGE_ITEM');
  tmp2:=upper('itemCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项编码''';
  end if;  
  
  tmp1:=upper('BD_PACKAGE_ITEM');
  tmp2:=upper('itemDes');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分项名称''';
  end if;  
  
  tmp1:=upper('BD_PACKAGE_ITEM');
  tmp2:=upper('tbpcCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''TBPC编码''';
  end if;  
  
  tmp1:=upper('BD_PACKAGE_ITEM');
  tmp2:=upper('features');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''特征''';
  end if;  
  
   tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('gdcgbm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''固定资产投资项目采购编码''';
  end if;  
  
    tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('JSDW');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''建设单位''';
  end if;  
  
    tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('SBOPT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申报责任人''';
  end if;  
  
    tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('SBOPTTEL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申报责任人 联系方式''';
  end if;  
  
      tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('DLZBDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构招标编号''';
  end if;
--add by hejw end--

--BD_OBJECTION 修改 附件 字段长度   zhaiyy---
	execute immediate 'alter table BD_OBJECTION modify FILESTR1 VARCHAR2(200)';
	execute immediate 'alter table BD_OBJECTION modify FILESTR VARCHAR2(200)';

--add by chenxp start--
  tmp1:=upper('bd_package_yqdw');
  tmp2:=upper('packname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）名称'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('optid');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员ID'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('optname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('depid');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门ID'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('depname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门名称'''; 
  end if; 
  
  
  tmp1:=upper('bd_package');
  tmp2:=upper('edtDate');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）修改时间'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('sigFlg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''签章标志 1-是，0 or other -否'''; 
  end if; 

  tmp1:=upper('bd_package');
  tmp2:=upper('signer');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''签章人'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('packStatus');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）状态0-未开标 ,1-流标中 ,2-已流标 ,3-已开标'''; 
  end if; 


 tmp1:=upper('bd_package');
  tmp2:=upper('zbxmjh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目计划'''; 
  end if;
  
  
  tmp1:=upper('bd_package');
  tmp2:=upper('gbr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关闭标段包人'''; 
  end if; 
  
  
  tmp1:=upper('bd_package');
  tmp2:=upper('gbDate');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关闭标段包时间'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('gbly');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关闭标段包理由'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('gbfj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关闭标段包附件路径'''; 
  end if; 
  
  
  tmp1:=upper('bd_package');
  tmp2:=upper('zbrSinFlg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人签章标志1-是,0 or other-否'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('dljgSinFlg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标代理机构签章标志1-是,0 or other-否'''; 
  end if; 
  
  tmp1:=upper('bd_package');
  tmp2:=upper('jdrSinFlg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then 
  execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''监督人签章标志1-是,0 or other-否'''; 
  end if; 
  
  --招标结束公告-chenxp---
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_ZBSTOPGG');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then 
     -- 建表
   execute immediate '
    create table BD_ZBSTOPGG  (
       PKID                   NUMBER                          not null,
       PROBID                 VARCHAR2(20),
       BDID                   VARCHAR2(23),
       TITLE                  VARCHAR2(200),
       CONTENT                CLOB,
       ZBFSIGNER              VARCHAR2(30),
       ZBFSIGFLG              NUMBER,
       ZBFSIGDATE             DATE,
       DLJGSIGNER             VARCHAR2(30),      
       DLJGSIGFLG             NUMBER,
       DLJGSIGDATE            DATE,
       ACCESSORY              VARCHAR2(300),
       FBDATE                 DATE,
       FBR                    VARCHAR2(30),
       constraint PK_BD_ZBSTOPGG primary key (PKID)
    )';
    execute immediate 'comment on table BD_ZBSTOPGG is ''招标结束公告''';
    execute immediate 'comment on column BD_ZBSTOPGG.PKID is ''自增主键''';
    execute immediate 'comment on column BD_ZBSTOPGG.PROBID is ''招标项目编号''';
    execute immediate 'comment on column BD_ZBSTOPGG.BDID is ''标段包编号''';
    execute immediate 'comment on column BD_ZBSTOPGG.TITLE is ''公告标题''';
    execute immediate 'comment on column BD_ZBSTOPGG.CONTENT is ''公告内容''';
    execute immediate 'comment on column BD_ZBSTOPGG.ZBFSIGNER is ''招标方签章人''';
    execute immediate 'comment on column BD_ZBSTOPGG.ZBFSIGFLG is ''招标方签章标志1-是，0 or other -否''';
    execute immediate 'comment on column BD_ZBSTOPGG.ZBFSIGDATE is ''招标方签章时间''';
    execute immediate 'comment on column BD_ZBSTOPGG.DLJGSIGNER is ''代理机构签章人''';
    execute immediate 'comment on column BD_ZBSTOPGG.DLJGSIGFLG is ''代理机构签章标志1-是，0 or other -否''';
    execute immediate 'comment on column BD_ZBSTOPGG.DLJGSIGDATE is ''代理机构签章时间''';
    execute immediate 'comment on column BD_ZBSTOPGG.ACCESSORY is ''附件上传路径''';
    execute immediate 'comment on column BD_ZBSTOPGG.FBDATE is ''发布公告的时间''';
    execute immediate 'comment on column BD_ZBSTOPGG.FBR is ''公告发布人''';
    end if;
    
    
    num:=0; 
    tmp1:=upper('BD_ZBSTOPGG_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_ZBSTOPGG_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 
    
    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('fbStatus');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布状态1-是，0 or other -否'''; 
    end if; 
  
--add by chenxp end--

--add by xuz中标候选人公示 start--
	 num :=0;
    tmp1 := upper('BD_DB_HXRGS');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_DB_HXRGS  (
	   PKID                 INT                             not null,
	   PROBID               VARCHAR2(20),
	   PROBNAME             VARCHAR2(200),
	   PACKID               VARCHAR2(23),
	   TITLE                VARCHAR2(200),
	   YYJZSJ               DATE,
	   LXR                  VARCHAR2(50),
	   LXDH                 VARCHAR2(20),
	   GSKSSJ               DATE,
	   GSJSSJ               DATE,
	   FILE1               VARCHAR2(150),
	   GSSJ                 DATE,
	   HYDM                 VARCHAR2(30),
	   HYMC                 VARCHAR2(50),
	   constraint PK_BD_DB_HXRGS primary key (PKID)
	)';

	execute immediate 'comment on column BD_DB_HXRGS.PKID is ''主键''';
    execute immediate 'comment on column BD_DB_HXRGS.PROBID is ''招标项目编号''';
    execute immediate 'comment on column BD_DB_HXRGS.PROBNAME is ''招标项目名称''';
    execute immediate 'comment on column BD_DB_HXRGS.PACKID is ''标段包编号''';
    execute immediate 'comment on column BD_DB_HXRGS.TITLE is ''标题''';
    execute immediate 'comment on column BD_DB_HXRGS.YYJZSJ is ''评标结果异议截止时间''';
    execute immediate 'comment on column BD_DB_HXRGS.LXR is ''联系人''';
    execute immediate 'comment on column BD_DB_HXRGS.LXDH is ''联系电话''';
    execute immediate 'comment on column BD_DB_HXRGS.GSKSSJ is ''公示开始时间''';
    execute immediate 'comment on column BD_DB_HXRGS.GSJSSJ is ''公示结束时间''';
    execute immediate 'comment on column BD_DB_HXRGS.FILE1 is ''附件''';
    execute immediate 'comment on column BD_DB_HXRGS.GSSJ is ''公示时间''';
    execute immediate 'comment on column BD_DB_HXRGS.HYDM is ''会员代码''';
    execute immediate 'comment on column BD_DB_HXRGS.HYMC is ''会员名称''';
    end if;
    
     num:=0; 
    tmp1:=upper('BD_DB_HXRGS_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_DB_HXRGS_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;  
--add by xuz end--

	----------2016/06/27 hanglong 合同登记相关表sql start-----------------
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CONTRACT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then 
		-- 建表
		execute immediate '
	    create table BD_CONTRACT  (
	      FPHM         VARCHAR2(32) not null,
	      BDID		   VARCHAR2(23),
	      PROBID	   VARCHAR2(20),
	      PROID		   VARCHAR2(17),
	      PROMC		   VARCHAR2(200),
	      PRONO		   VARCHAR2(200),
	      PACKNAME	   VARCHAR2(200),
	      PROBNAME	   VARCHAR2(100),
		  HYDM         VARCHAR2(30) not null,
		  HYNAME       VARCHAR2(250),
		  HZDM         VARCHAR2(30) not null,
		  HZNAME       VARCHAR2(250),
		  STATUS       INTEGER,
		  PRICE        NUMBER(20,6) not null,
		  SUMSL2       NUMBER(20,6),
		  SUMAMT       NUMBER(20,2),
		  EXTBILLNO    VARCHAR2(32) not null,
		  COPT         VARCHAR2(30),
		  CDATE        DATE,
		  DELIVERYTYPE INTEGER,
		  DELIVERYADDR VARCHAR2(200),
		  PAYTYPE      INTEGER,
		  PROMISE      VARCHAR2(2000),
		  REMARK       VARCHAR2(200),
		  TIMEMD5      VARCHAR2(32),
		  FLAG00       INTEGER,
		  FLAG01       INTEGER,
		  FLAG02       INTEGER,
		  OPT00        VARCHAR2(30),
		  OPT01        VARCHAR2(30),
		  OPT02        VARCHAR2(30),
		  DATE00       DATE,
		  DATE01       DATE,
		  DATE02       DATE,
		  BUSITYP      INTEGER,
		  GROUPID      NUMBER,
		  LEVEL1       INTEGER,
		  LEVEL2       INTEGER,
		  LEVEL3       INTEGER,
		  AMT00        NUMBER(20,2),
		  AMT01        NUMBER(20,2),
		  AMT02        NUMBER(20,2),
		  AMT03        NUMBER(20,2),
		  HTSTR1       VARCHAR2(50),
		  HTSTR2       VARCHAR2(50),
		  DEPID1       VARCHAR2(30),
		  DEPNAME1     VARCHAR2(100),
		  BSGID1       VARCHAR2(30),
		  BSGNAME1     VARCHAR2(100),
		  DEPID2       VARCHAR2(30),
		  DEPNAME2     VARCHAR2(100),
		  BSGID2       VARCHAR2(30),
		  BSGNAME2     VARCHAR2(100),
		  PAYBL        VARCHAR2(30),
		  GYSLX        INTEGER,
		  OTHER        VARCHAR2(200),
		  FKREMARK     VARCHAR2(200),
		  PRICESPR     VARCHAR2(50),
		  SPLD         VARCHAR2(50),
		  CGLEVEL      VARCHAR2(50),
		  CGTYPE       VARCHAR2(50),
		  CGMODE       VARCHAR2(50),
		  HTDW         VARCHAR2(50),
		  HTDWNAME     VARCHAR2(100),
		  ZGDW         VARCHAR2(50),
		  ZGDWNAME     VARCHAR2(100),
	      constraint PK_BD_CONTRACT primary key (FPHM)
	    )';
	    execute immediate 'comment on column BD_CONTRACT.FPHM is ''合同号码''';
	    execute immediate 'comment on column BD_CONTRACT.BDID is ''标段（包）编号''';
	    execute immediate 'comment on column BD_CONTRACT.PROBID is ''招标项目编号''';
	    execute immediate 'comment on column BD_CONTRACT.PROID is ''项目编号''';
	    execute immediate 'comment on column BD_CONTRACT.PROMC is ''项目名称''';
	    execute immediate 'comment on column BD_CONTRACT.PRONO is ''固定资产编号''';
	    execute immediate 'comment on column BD_CONTRACT.PACKNAME is ''标段包名称''';
	    execute immediate 'comment on column BD_CONTRACT.PROBNAME is ''招标项目名称''';
	    execute immediate 'comment on column BD_CONTRACT.HYDM is ''会员代码''';
	    execute immediate 'comment on column BD_CONTRACT.HYNAME is ''会员名称''';
	    execute immediate 'comment on column BD_CONTRACT.HZDM is ''供应商代码''';
	    execute immediate 'comment on column BD_CONTRACT.HZNAME is ''供应商名称''';
	    execute immediate 'comment on column BD_CONTRACT.STATUS is ''合同状态''';
	    execute immediate 'comment on column BD_CONTRACT.PRICE is ''成交价''';
	    execute immediate 'comment on column BD_CONTRACT.SUMSL2 is ''总重量/总数量''';
	    execute immediate 'comment on column BD_CONTRACT.SUMAMT is ''合同金额（不含费用）：PRICE*SL2''';
	    execute immediate 'comment on column BD_CONTRACT.EXTBILLNO is ''相关单号(唯一性检查)''';
	    execute immediate 'comment on column BD_CONTRACT.COPT is ''登记人''';
	    execute immediate 'comment on column BD_CONTRACT.CDATE is ''创建日期''';
	    execute immediate 'comment on column BD_CONTRACT.DELIVERYTYPE is ''交货方式：0 - 送货   1 - 自提''';
	    execute immediate 'comment on column BD_CONTRACT.DELIVERYADDR is ''交货地址''';
	    execute immediate 'comment on column BD_CONTRACT.PAYTYPE is ''支付方式：1-货到付款  2-预付款  3-验收合格付款  4-挂账后付款  5-发货当月付款  6-发货前付款''';
	    execute immediate 'comment on column BD_CONTRACT.PROMISE is ''相关约定''';
	    execute immediate 'comment on column BD_CONTRACT.REMARK is ''备注''';
	    execute immediate 'comment on column BD_CONTRACT.TIMEMD5 is ''时间戳，用于防止同步修改冲突''';
	    execute immediate 'comment on column BD_CONTRACT.BUSITYP is ''业务类型''';
	    execute immediate 'comment on column BD_CONTRACT.GROUPID is ''审核组id''';
	    execute immediate 'comment on column BD_CONTRACT.LEVEL1 is ''审核总级别''';
	    execute immediate 'comment on column BD_CONTRACT.LEVEL2 is ''当前级别''';
	    execute immediate 'comment on column BD_CONTRACT.DEPID1 is ''会员核算部门编码''';
	    execute immediate 'comment on column BD_CONTRACT.DEPNAME1 is ''会员核算部门名称''';
	    execute immediate 'comment on column BD_CONTRACT.BSGID1 is ''会员部门编码''';
	    execute immediate 'comment on column BD_CONTRACT.BSGNAME1 is ''会员部门名称''';
	    execute immediate 'comment on column BD_CONTRACT.DEPID2 is ''供应商核算部门编码''';
	    execute immediate 'comment on column BD_CONTRACT.DEPNAME2 is ''供应商核算部门名称''';
	    execute immediate 'comment on column BD_CONTRACT.BSGID2 is ''供应商部门编码''';
	    execute immediate 'comment on column BD_CONTRACT.BSGNAME2 is ''供应商部门名称''';
	    execute immediate 'comment on column BD_CONTRACT.PAYBL is ''付款比例或者付款天数''';
	    execute immediate 'comment on column BD_CONTRACT.GYSLX is ''供应商类型（1-系统会员，2-会员维护供应商）''';
	    execute immediate 'comment on column BD_CONTRACT.OTHER is ''交货方式其他说明''';
	    execute immediate 'comment on column BD_CONTRACT.FKREMARK is ''付款备注''';
	    execute immediate 'comment on column BD_CONTRACT.PRICESPR is ''价格审批人''';
	    execute immediate 'comment on column BD_CONTRACT.SPLD is ''合同签订审批领导''';
	    execute immediate 'comment on column BD_CONTRACT.CGLEVEL is ''采购级别''';
	    execute immediate 'comment on column BD_CONTRACT.CGTYPE is ''采购类型''';
	    execute immediate 'comment on column BD_CONTRACT.CGMODE is ''采购方式''';
	    execute immediate 'comment on column BD_CONTRACT.HTDW is ''合同单位''';
	    execute immediate 'comment on column BD_CONTRACT.HTDWNAME is ''合同单位名称''';
	    execute immediate 'comment on column BD_CONTRACT.ZGDW is ''子集团或直管单位''';
	    execute immediate 'comment on column BD_CONTRACT.ZGDWNAME is ''子集团或直管单位名称''';
    end if;
    
    -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CONTRACT_ITEM');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then 
		-- 建表
		execute immediate '
	    create table BD_CONTRACT_ITEM  (
	      FPHM   VARCHAR2(32) not null,
		  ITEM00 VARCHAR2(4000),
		  ITEM01 VARCHAR2(4000),
		  ITEM02 VARCHAR2(4000),
		  ITEM03 VARCHAR2(4000),
		  ITEM04 VARCHAR2(4000),
		  ITEM05 VARCHAR2(4000),
		  ITEM06 VARCHAR2(4000),
		  ITEM07 VARCHAR2(32),
		  ITEM08 VARCHAR2(1000),
		  ITEM09 VARCHAR2(1000),
		  ITEM10 VARCHAR2(1000),
		  ITEM11 VARCHAR2(500),
		  ITEM12 VARCHAR2(500),
		  ITEM13 VARCHAR2(1000),
		  ITEM14 VARCHAR2(1000),
		  ITEM15 VARCHAR2(1000),
		  ITEM16 VARCHAR2(1000),
		  ITEM17 VARCHAR2(1000),
		  ITEM18 VARCHAR2(1000),
		  ITEM19 VARCHAR2(1000),
		  ITEM20 VARCHAR2(1000),
		  ITEM21 VARCHAR2(1000),
		  ITEM22 VARCHAR2(1000),
	      constraint PK_BD_CONTRACT_ITEM primary key (FPHM)
	    )';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.FPHM is ''合同号码''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM00 is ''质量要求技术标准、供方对质量负责的条件和期限''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM01 is ''交（提）货地点、方式''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM02 is ''运输方式及到达站港和费用负担''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM03 is ''合理损耗及计算方法''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM04 is ''包装标准、包装物的供应与回收''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM05 is ''验收标准、方法及提出异议期限''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM06 is ''随机备品、配件工具数量及供应方法''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM07 is ''结算方式''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM08 is ''如需提供担保、另立合同担保书，作为本合同附件''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM09 is ''解决合同纠纷的方式''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM10 is ''其它约定事项''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM11 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM12 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM13 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM14 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM15 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM16 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM17 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM18 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM19 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM20 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM21 is ''备用''';
	    execute immediate 'comment on column BD_CONTRACT_ITEM.ITEM22 is ''备用''';
    end if;
    
    -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CONTRACT_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then 
		-- 建表
		execute immediate '
	    create table BD_CONTRACT_MX  (
	      FPHM      VARCHAR2(32) not null,
		  HTXH      INTEGER not null,
		  WZDM      VARCHAR2(30),
		  WZMC_CH   VARCHAR2(60),
		  WCMC_EN   VARCHAR2(60),
		  SL1       NUMBER(20,3),
		  SL2       NUMBER(20,6),
		  PRICE     NUMBER(20,6) not null,
		  PRICE00   NUMBER(20,6),
		  PRICE01   NUMBER(20,6),
		  AMT       NUMBER(20,2),
		  SL100     NUMBER(20,3),
		  SL200     NUMBER(20,6),
		  SCRQ      DATE,
		  RKRQ      DATE,
		  SL101     NUMBER(16,3),
		  SL201     NUMBER(16,6),
		  SL102     NUMBER(16,3),
		  SL202     NUMBER(16,6),
		  FLAG00    INTEGER,
		  FLAG01    INTEGER,
		  FLAG02    INTEGER,
		  OPT00     VARCHAR2(30),
		  OPT01     VARCHAR2(30),
		  FLAG03    INTEGER,
		  OPT02     VARCHAR2(30),
		  DATE00    DATE,
		  DATE01    DATE,
		  OPT03     VARCHAR2(30),
		  DATE02    DATE,
		  WZSTR1    VARCHAR2(100),
		  WZSTR2    VARCHAR2(100),
		  DATE03    DATE,
		  WZSTR3    VARCHAR2(100),
		  WZSTR4    VARCHAR2(100),
		  WZSTR5    VARCHAR2(100),
		  WZSTR6    VARCHAR2(100),
		  WZSTR7    VARCHAR2(100),
		  WZSTR8    VARCHAR2(100),
		  WZSTR9    VARCHAR2(100),
		  WZADDR    VARCHAR2(100),
		  SL103     NUMBER(16,3),
		  SL203     NUMBER(16,6),
		  STATUS    INTEGER,
		  MXID      NUMBER not null,
		  SL104     NUMBER(16,6),
		  SL204     NUMBER(16,6),
		  ZZSID     VARCHAR2(30),
		  ZZSNAME   VARCHAR2(200),
		  CURRENCY  VARCHAR2(200),
		  PRICETYPE INTEGER,
		  JHQSRQ    DATE,
		  JTFLDM    VARCHAR2(30),
		  JTFLMC    VARCHAR2(60),
		  TJFLDM    VARCHAR2(30),
		  TJFLMC    VARCHAR2(60),
		  WZJC      VARCHAR2(30),
		  WZBM      VARCHAR2(30),
		  REFSTR7   VARCHAR2(30),
		  GZBZH     VARCHAR2(30),
		  JSBZH     VARCHAR2(30),
		  PP        VARCHAR2(30),
		  PH        VARCHAR2(30),
		  CAIZ      VARCHAR2(30),
		  CPDJ      VARCHAR2(30),
		  XNDJ      VARCHAR2(30),
		  ZLZB      VARCHAR2(30),
		  TC        VARCHAR2(30),
		  LONGD     VARCHAR2(30),
		  COLOR     VARCHAR2(30),
		  QUYU      VARCHAR2(30),
		  DC        VARCHAR2(30),
		  RCLGY     VARCHAR2(30),
		  DH        VARCHAR2(30),
		  GZQZF     VARCHAR2(30),
		  JGGY      VARCHAR2(30),
		  BMCL      VARCHAR2(30),
		  YCD       VARCHAR2(30),
		  TYPE      VARCHAR2(30),
		  TSYQ      VARCHAR2(30),
		  ZCQK      VARCHAR2(30),
		  REMARK    VARCHAR2(2000),
		  WZXQJSON  VARCHAR2(3000),
		  
		  GQ        VARCHAR2(30),
		  accessory VARCHAR2(300),
		  GCZLBZ    VARCHAR2(250),
		  JSDD      VARCHAR2(500),
		  FWQ       VARCHAR2(30),
		  FWDD      VARCHAR2(500),
		  FWNR      VARCHAR2(500),
		  GCGM      VARCHAR2(500),
		  FL        NUMBER,
		  itemCode  VARCHAR2(100),
		  itemDes   VARCHAR2(2000),
		  tbpcCode  VARCHAR2(500),
		  features  VARCHAR2(4000),
	      constraint PK_BD_CONTRACT_MX primary key (FPHM, HTXH)
	    )';
	    execute immediate 'comment on column BD_CONTRACT_MX.FPHM is ''合同号码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.HTXH is ''合同序号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZDM is ''物资代码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZMC_CH is ''物资名称(中文)''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WCMC_EN is ''物资名称(英文文)''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL1 is ''采购数量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL2 is ''采购重量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.PRICE is ''采购单价''';
	    execute immediate 'comment on column BD_CONTRACT_MX.AMT is ''合同金额（不含费用）：PRICE*SL2''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL100 is ''交货数量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL200 is ''交货重量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SCRQ is ''生产日期''';
	    execute immediate 'comment on column BD_CONTRACT_MX.RKRQ is ''入库日期''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL101 is ''发货数量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL201 is ''发货重量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL102 is ''到货数量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL202 is ''到货重量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.FLAG00 is ''交货登记完成''';
	    execute immediate 'comment on column BD_CONTRACT_MX.FLAG01 is ''发货登记完成''';
	    execute immediate 'comment on column BD_CONTRACT_MX.FLAG02 is ''到货登记完成''';
	    execute immediate 'comment on column BD_CONTRACT_MX.OPT00 is ''最后交货登记人''';
	    execute immediate 'comment on column BD_CONTRACT_MX.OPT01 is ''最后发货登记人''';
	    execute immediate 'comment on column BD_CONTRACT_MX.FLAG03 is ''入库登记完成''';
	    execute immediate 'comment on column BD_CONTRACT_MX.OPT02 is ''最后到货登记人''';
	    execute immediate 'comment on column BD_CONTRACT_MX.DATE00 is ''最后交货登记时间''';
	    execute immediate 'comment on column BD_CONTRACT_MX.DATE01 is ''最后发货登记时间''';
	    execute immediate 'comment on column BD_CONTRACT_MX.OPT03 is ''最后入库登记人''';
	    execute immediate 'comment on column BD_CONTRACT_MX.DATE02 is ''最后到货登记时间''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZSTR1 is ''产品型号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZSTR2 is ''产品标准''';
	    execute immediate 'comment on column BD_CONTRACT_MX.DATE03 is ''最后入库登记时间''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZSTR3 is ''产品规格''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZSTR5 is ''产品标准号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZADDR is ''资源所在详细地址''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL103 is ''入库数量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.SL203 is ''入库重量''';
	    execute immediate 'comment on column BD_CONTRACT_MX.ZZSID is ''供应商id''';
	    execute immediate 'comment on column BD_CONTRACT_MX.ZZSNAME is ''供应商名称''';
	    execute immediate 'comment on column BD_CONTRACT_MX.CURRENCY is ''币种''';
	    execute immediate 'comment on column BD_CONTRACT_MX.PRICETYPE is ''0:出厂价1:到厂价''';
	    execute immediate 'comment on column BD_CONTRACT_MX.JHQSRQ is ''交货起始日期''';
	    execute immediate 'comment on column BD_CONTRACT_MX.JTFLDM is ''集团分类代码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.JTFLMC is ''集团分类名称''';
	    
	    execute immediate 'comment on column BD_CONTRACT_MX.TJFLDM is ''统计分类代码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.TJFLMC is ''统计分类名称''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZJC is ''物资简称''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZBM is ''物资别名''';
	    execute immediate 'comment on column BD_CONTRACT_MX.REFSTR7 is ''英文名称''';
	    execute immediate 'comment on column BD_CONTRACT_MX.GZBZH is ''规格标准号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.JSBZH is ''技术标准号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.PP is ''品牌''';
	    execute immediate 'comment on column BD_CONTRACT_MX.PH is ''牌号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.CAIZ is ''材质''';
	    execute immediate 'comment on column BD_CONTRACT_MX.CPDJ is ''产品等级''';
	    execute immediate 'comment on column BD_CONTRACT_MX.XNDJ is ''性能等级''';
	    execute immediate 'comment on column BD_CONTRACT_MX.ZLZB is ''质量指标''';
	    execute immediate 'comment on column BD_CONTRACT_MX.TC is ''涂层''';
	    execute immediate 'comment on column BD_CONTRACT_MX.LONGD is ''长度''';
	    execute immediate 'comment on column BD_CONTRACT_MX.COLOR is ''颜色''';
	    execute immediate 'comment on column BD_CONTRACT_MX.QUYU is ''区域''';
	    execute immediate 'comment on column BD_CONTRACT_MX.DC is ''导线''';
	    execute immediate 'comment on column BD_CONTRACT_MX.RCLGY is ''热处理工艺''';
	    
	    execute immediate 'comment on column BD_CONTRACT_MX.DH is ''代号''';
	    execute immediate 'comment on column BD_CONTRACT_MX.GZQZF is ''规格前置符''';
	    execute immediate 'comment on column BD_CONTRACT_MX.JGGY is ''加工工艺''';
	    execute immediate 'comment on column BD_CONTRACT_MX.BMCL is ''表面处理''';
	    execute immediate 'comment on column BD_CONTRACT_MX.YCD is ''原产地''';
	    execute immediate 'comment on column BD_CONTRACT_MX.TYPE is ''状态''';
	    execute immediate 'comment on column BD_CONTRACT_MX.TSYQ is ''特殊要求''';
	    execute immediate 'comment on column BD_CONTRACT_MX.ZCQK is ''注册情况''';
	    execute immediate 'comment on column BD_CONTRACT_MX.REMARK is ''备注''';
	    execute immediate 'comment on column BD_CONTRACT_MX.WZXQJSON is ''物资详情''';
	    
	    execute immediate 'comment on column BD_CONTRACT_MX.gq is ''工期''';
	    execute immediate 'comment on column BD_CONTRACT_MX.accessory is ''附件路径''';
	    execute immediate 'comment on column BD_CONTRACT_MX.gczlbz is ''工程质量标准''';
	    execute immediate 'comment on column BD_CONTRACT_MX.jsdd is ''工程建设地点''';
	    execute immediate 'comment on column BD_CONTRACT_MX.fwq is ''服务期''';
	    execute immediate 'comment on column BD_CONTRACT_MX.fwdd is ''服务地点''';
	    execute immediate 'comment on column BD_CONTRACT_MX.fwnr is ''服务内容''';
	    execute immediate 'comment on column BD_CONTRACT_MX.gcgm is ''工程规模''';
	    execute immediate 'comment on column BD_CONTRACT_MX.fl is ''分类1-货物，2-工程，3-服务''';
	    execute immediate 'comment on column BD_CONTRACT_MX.itemCode is ''分项编码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.itemDes is ''分项名称''';
	    execute immediate 'comment on column BD_CONTRACT_MX.tbpcCode is ''TBPC编码''';
	    execute immediate 'comment on column BD_CONTRACT_MX.features is ''特征''';
    end if;
    
    -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CONTRACT_PAYPLAN');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then 
		-- 建表
		execute immediate '
	    create table BD_CONTRACT_PAYPLAN  (
	      PKID       NUMBER not null,
		  FPHM       VARCHAR2(32) not null,
		  PLANXH     INTEGER not null,
		  AMT        NUMBER(20,2),
		  COPT       VARCHAR2(30),
		  CDATE      DATE,
		  CONTENT    VARCHAR2(200),
		  PAYTYPE    INTEGER,
		  REMARK     VARCHAR2(200),
		  STATUS     INTEGER,
		  AMT00      NUMBER(20,2),
		  AMT01      NUMBER(20,2),
		  CURRENCY   VARCHAR2(200),
		  PAYTYPESTR VARCHAR2(200),
	      constraint PK_BD_CONTRACT_PAYPLAN primary key (PKID)
	    )';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.PKID is ''自增主键''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.FPHM is ''合同主表''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.PLANXH is ''合同序号''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.AMT is ''计划付款金额''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.COPT is ''登记人''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.CDATE is ''创建日期''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.CONTENT is ''内容''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.PAYTYPE is ''支付方式 1 现金 2 承兑''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.REMARK is ''备注''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.CURRENCY is ''币种''';
	    execute immediate 'comment on column BD_CONTRACT_PAYPLAN.PAYTYPESTR is ''付款种类''';
    end if;
    
	num:=0; 
	tmp1:=upper('BD_CONTRACT_PAYPLAN_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'create sequence BD_CONTRACT_PAYPLAN_0 
		minvalue 1
		maxvalue 9999999999999999999999999999
		start with 1
		increment by 1
		nocache
		order
	';
	end if; 
	----------2016/06/27 hanglong 合同登记相关表sql end-----------------

	--add by longf start ---
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('date00');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评审报告日期''';
    end if;
    
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('psyj');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审意见''';
    end if;
    
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('filepath');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评审报告-附件路径''';
    end if;
	--add by longf end ---

--add by linqinging start--
----（货物中标和工程中标和招标结果）通知书表
   -- 判断表是否存在
    num :=0;-- 注意：查询前必须初始化此变量
    tmp1 := upper('BD_HGZJTZS');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
  execute immediate 'create table BD_HGZJTZS  (
     PKID                 INT                             not null,
     PROID                VARCHAR(200),
     PRNAME               VARCHAR(300),
     PROBID               VARCHAR(200),
     PRBNAME              VARCHAR(300),
     BDBNUM               VARCHAR(300),
     DLNUM                VARCHAR(200),
     BDBNAME              VARCHAR(300),
     ZBDW                 VARCHAR(300),
     NZBDW                VARCHAR(500),
     ZBHWNAME             VARCHAR(300),
     ZBCOUNT              VARCHAR(200),
     ZBMONEY              VARCHAR(200),
     EXINFO               CLOB,
     DLJG                 VARCHAR(200),
     ZBR                  VARCHAR(200),
     CZR                  VARCHAR(200),
     BCSJ                 DATE,
     FCSJ                 DATE,
     PSDATE               DATE,
     QDDATE               DATE,
     GQSC                 VARCHAR(100),
     ZLBZ                 VARCHAR(100),
     XMJL                 VARCHAR(100),
     WTR                  VARCHAR(100),
     TZZT                 VARCHAR(100),
     QTDATE               DATE,
     BYZD                 VARCHAR(200),
     BYZDT                VARCHAR(200),
     constraint PK_BD_HGZJTZS primary key (PKID)
  )';
  execute immediate 'comment on table BD_HGZJTZS is ''（货物中标和工程中标和招标结果）通知书''';

  execute immediate 'comment on column BD_HGZJTZS.PKID is ''自增主键''';

  execute immediate 'comment on column BD_HGZJTZS.PROID is ''项目编号''';
  
  execute immediate 'comment on column BD_HGZJTZS.PRNAME is''项目名称''';

  execute immediate 'comment on column BD_HGZJTZS.PROBID is ''招标项目编号''';
  
  execute immediate 'comment on column BD_HGZJTZS.PRBNAME is''招标项目名称''';

  execute immediate 'comment on column BD_HGZJTZS.BDBNUM is ''标段包编号''';

  execute immediate 'comment on column BD_HGZJTZS.DLNUM is ''代理机构招标编号''';

  execute immediate 'comment on column BD_HGZJTZS.BDBNAME is ''标段包名称''';

  execute immediate 'comment on column BD_HGZJTZS.ZBDW is ''中标单位''';
  
  execute immediate 'comment on column BD_HGZJTZS.NZBDW is''未中标单位''';

  execute immediate 'comment on column BD_HGZJTZS.ZBHWNAME is ''中标货物名称''';

  execute immediate 'comment on column BD_HGZJTZS.ZBCOUNT is ''中标数量''';

  execute immediate 'comment on column BD_HGZJTZS.ZBMONEY is ''中标金额''';

  execute immediate 'comment on column BD_HGZJTZS.EXINFO is ''说明信息''';

  execute immediate 'comment on column BD_HGZJTZS.DLJG is ''代理机构''';

  execute immediate 'comment on column BD_HGZJTZS.ZBR is ''招标人''';

  execute immediate 'comment on column BD_HGZJTZS.CZR is ''操作人''';

  execute immediate 'comment on column BD_HGZJTZS.BCSJ is ''保存时间''';

  execute immediate 'comment on column BD_HGZJTZS.FCSJ is ''发送中标通知书时间''';

  execute immediate 'comment on column BD_HGZJTZS.PSDATE is ''评审推荐日期''';

  execute immediate 'comment on column BD_HGZJTZS.QDDATE is ''建设单位确定日期''';

  execute immediate 'comment on column BD_HGZJTZS.GQSC is ''工期''';

  execute immediate 'comment on column BD_HGZJTZS.ZLBZ is ''质量标准''';

  execute immediate 'comment on column BD_HGZJTZS.XMJL is ''项目经理''';

  execute immediate 'comment on column BD_HGZJTZS.WTR is ''法定代表人或授权委托人''';

  execute immediate 'comment on column BD_HGZJTZS.TZZT is ''通知书状态1-已保存 2-已发送中标通知书 3-已签章并提交''';

  execute immediate 'comment on column BD_HGZJTZS.QTDATE is ''签章并提交时间''';

  execute immediate 'comment on column BD_HGZJTZS.BYZD is ''备用字段''';

  execute immediate 'comment on column BD_HGZJTZS.BYZDT is ''备用字段2''';
  
  end if;
  
      num:=0; 
      tmp1:=upper('BD_HGZJTZS_0');
      select count(1) into num from user_sequences where sequence_name=tmp1;
      if num = 0 then
        execute immediate '
        create sequence BD_HGZJTZS_0
      minvalue 1
      maxvalue 9999999999999999999999999999
      start with 1
      increment by 1
      nocache
      order
      ';
      end if; 

--add by linqinging end--

	tmp1:=upper('BD_ZB_FILE');
  	tmp2:=upper('nodetype');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件类型 1-申请人须知 2-评审办法 3-申请文件格式 4-参考资料''';
    end if;
    
    
	tmp1:=upper('BD_CONTRACT');
  	tmp2:=upper('type');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同类型（1-买家生成的合同，2-卖家生成的合同）''';
    end if;
    
    
   --add by lvchuanyong  start-- 
--自定义属性
	num:=0; -- 注意：查询前必须初始化此变量
	  tmp1:=upper('BD_PROPERTY');
	  select count(1) into num from user_tables where table_name=tmp1;       
	  if num = 0 then
	    -- 建表
	    execute immediate '
	    create table BD_PROPERTY  (
	   PROPID               INT                             not null,
	   PNAME                VARCHAR2(100),
	   PDESC                VARCHAR2(500),
	   SORTNO               INT,
	   ISUSE                CHAR(1),
	   constraint PK_BD_PROPERTY primary key (PROPID)
	)';
	
	  execute immediate ' comment on table BD_PROPERTY is ''自定义属性模板''';
	
		execute immediate ' comment on column BD_PROPERTY.PROPID is ''主键''';
		
		execute immediate ' comment on column BD_PROPERTY.PNAME is ''名称''';
		
		execute immediate ' comment on column BD_PROPERTY.PDESC is ''描述''';
		
		execute immediate ' comment on column BD_PROPERTY.SORTNO is ''排序''';
		
		execute immediate ' comment on column BD_PROPERTY.ISUSE is ''是否使用''';
	 end if; 
 
     num:=0; 
    tmp1:=upper('BD_PROPERTY_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_PACKAGE_YQDW_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 

--自定义属性明细
	num:=0; -- 注意：查询前必须初始化此变量
	  tmp1:=upper('BD_PROPERTY_MX');
	  select count(1) into num from user_tables where table_name=tmp1;       
	  if num = 0 then
	    -- 建表
	    execute immediate '
	    create table BD_PROPERTY_MX  (
	   PKID                 INT                             not null,
	   PROPID               INT,
	   SHOWTEXT             VARCHAR2(100),
	   TAGS                 VARCHAR2(50),
	   TNAME                VARCHAR2(50),
	   TFIELD               VARCHAR2(100),
	   PDESC                VARCHAR2(500),
	   TYP                  VARCHAR2(50),
	   JTYP                 VARCHAR2(50),
	   SORTNO               INT,
	   ISUSE                CHAR(1),
	   ISEDIT               CHAR(1),
	   constraint PK_BD_PROPERTY_MX primary key (PKID)
	)';
	
	  execute immediate ' comment on table BD_PROPERTY_MX is ''自定义属性明细''';

	execute immediate ' comment on column BD_PROPERTY_MX.PKID is ''主键''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.PROPID is ''属性ID''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.SHOWTEXT is ''显示文字''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.TAGS is ''标签''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.TNAME is ''表名称''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.TFIELD is ''表字段名称''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.PDESC is ''描述''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.TYP is ''字段类型''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.JTYP is ''TYP对应的Java类型''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.SORTNO is ''排序''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.ISUSE is ''是否使用''';
	
	execute immediate ' comment on column BD_PROPERTY_MX.ISEDIT is ''是否可编辑''';
		  
	 end if; 
 
     num:=0; 
    tmp1:=upper('BD_PROPERTY_MX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_PACKAGE_YQDW_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 
  --add by lvchuanyong  end-- 
	
	-- SQL升级实例-CREATE TABLE		BD_FB_ZBCSSZ--招标文件参数设置
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_ZBCSSZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_ZBCSSZ  (
				PKID                 INT                             not null,
				BDID                 VARCHAR2(23)                    not null,
				PACKNAME             VARCHAR2(100),
				ZBFL                 VARCHAR2(2),
				ZGSHFS               VARCHAR2(2),
				HYDM                 VARCHAR2(50),
				HYNAME               VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				DEPID                VARCHAR2(30),
				DEPNAME              VARCHAR2(80),
				CDATE                DATE,
				TYPE                 VARCHAR2(2),
				ISKT                 VARCHAR2(2),
				KTSJ                 DATE,
				KTDD                 VARCHAR2(100),
				TBRTWJZSJ            DATE,
				TBRSMCQSJ            DATE,
				ISPL                 VARCHAR2(2),
				TBRYQCQJZSJ          DATE,
				TBRQRSDCQSJ          DATE,
				TBRQRSDXGSJ          DATE,
				TBXJ                 VARCHAR2(100),
				TBYXQ                DATE,
				ISDJTBBZJ            VARCHAR2(2),
				TBBZJXS              VARCHAR2(100),
				TBBZJJE              NUMBER(20,3),
				PBWYHRS              INTEGER,
				ZBRDBRS              INTEGER,
				ZJRS                 INTEGER,
				PBZJQDFS             VARCHAR2(100),
				SFSQ                 VARCHAR2(2),
				LYDBXS               VARCHAR2(100),
				LYDBJE               NUMBER(20,3),
				PBBF                 VARCHAR2(500),
				constraint PK_BD_FB_ZBCSSZ primary key (PKID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_FB_ZBCSSZ is ''招标文件参数设置'' ';		
		execute immediate '	comment on column BD_FB_ZBCSSZ.PKID is ''主键'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.BDID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.PACKNAME is ''标段（包）名称'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ZBFL is ''招标项目分类 1-货物 2-工程 3-服务'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ZGSHFS is ''资格审核方式 1-预审   2-后审'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.HYNAME is ''创建会员名称'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.DEPID is ''部门ID'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.DEPNAME is ''部门名称'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TYPE is ''类型 1-简明版 2-标准版'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ISKT is ''是否踏勘现场 0-不组织 1-组织'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.KTSJ is ''踏勘时间(如果踏勘现场选择的是[组织])'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.KTDD is ''踏勘集中地点(如果踏勘现场选择的是[组织])'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBRTWJZSJ is ''投标人提出问题的截止时间(当出现变更开标时间时，这个时间默认不变)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBRSMCQSJ is ''招标人书面澄清的时间(当出现变更开标时间时，这个时间默认不变)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ISPL is ''偏离 0-不允许 1-允许'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBRYQCQJZSJ is ''投标人要求澄清招标文件的截止时间(当出现变更开标时间时，这个时间默认不变)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBRQRSDCQSJ is ''投标人确认收到招标文件澄清的时间(当出现变更开标时间时，这个时间默认不变)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBRQRSDXGSJ is ''投标人确认收到招标文件修改的时间(当出现变更开标时间时，这个时间默认不变)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBXJ is ''最高投标限价或其计算方法：
																	 最高投标限价一般开标截止日前5天公布，
																	 当直接写明最高投标限价时，
																	 高于最高投标限价的投标报价在系统中直接判定为无效报价'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBYXQ is ''投标有效期'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ISDJTBBZJ is ''投标保证金 0-不要求递交投标保证金 1-要求递交投标保证金'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBBZJXS is ''投标保证金的形式(当投标保证金选择[要求递交投标保证金])'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.TBBZJJE is ''投标保证金的金额(当投标保证金选择[要求递交投标保证金])'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.PBWYHRS is ''评标委员会构成(人数)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ZBRDBRS is ''招标人代表(人数)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.ZJRS is ''专家(人数)'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.PBZJQDFS is ''评标专家确定方式'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.SFSQ is ''是否授权评标委员会确定中标人 0-否 1-是'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.LYDBXS is ''履约担保的形式'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.LYDBJE is ''履约担保的金额'' ';
		execute immediate '	comment on column BD_FB_ZBCSSZ.PBBF is ''评标办法 默认为综合评估法（详见招标文件第五部分）'' ';
	end if;
	-- SQL升级实例-CREATE SEQUENCE
	num:=0;
	tmp1 :=upper('BD_FB_ZBCSSZ_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'CREATE SEQUENCE BD_FB_ZBCSSZ_0
		MINVALUE 1
		MAXVALUE 9999999999999999999999999999
		START WITH 1
		INCREMENT BY 1
		NOCACHE
		ORDER
	';
	end if;
	
  -------------------------------------------------------------
end;