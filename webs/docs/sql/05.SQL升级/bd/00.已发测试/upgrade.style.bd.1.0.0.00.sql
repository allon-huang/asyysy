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
  
  	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_ZBGG');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_ZBGG  (
   PKID                 INT  not null,
   TITLE                varchar2(200),
   PROID                varchar2(20),
   PRONAME              varchar2(200),
   JGMC                 varchar2(100),
   PWMORNO              varchar2(100),
   XMYZ                 varchar2(100),
   ZJLY                 varchar2(100),
   ZBR                  VARCHAR2(9),
   ZBRMC                VARCHAR2(100),
   ZBTRO                clob,
   TBRZZ                clob,
   TBRYJ                clob,
   QTYQ                 clob,
   FLAG1                CHAR(1),
   LHTTBYQ              clob,
   BDGS                 NUMBER(10),
   GGFBMT               varchar2(1000),
   BSKSSJ               DATE,
   BSJSSJ               DATE,
   BSSJ                 varchar2(30),
   TZYJ                 varchar2(30),
   JZSJ                 DATE,
   KBSJ                 DATE,
   KBADDR               VARCHAR2(200),
   TBWJDJ               clob,
   STATUS               INT,
   TYP                  VARCHAR2(1),
   DATE1                DATE,
   DATE2                DATE,
   SHR                  VARCHAR2(50),
   ZBRADDR              VARCHAR2(250),
   ZBRPOST              VARCHAR2(10),
   ZBLXR                VARCHAR2(100),
   ZBLXTEL              VARCHAR2(20),
   ZBLXFAX              VARCHAR2(20),
   ZBEMAIL              VARCHAR2(100),
   ZBURL                VARCHAR2(200),
   ZBBANK               VARCHAR2(100),
   ZBACCOUNT            VARCHAR2(100),
   ZBLHH                VARCHAR2(100),
   DLJGID               VARCHAR2(9),
   DLJGNAME             VARCHAR2(100),
   DLJGADDR             VARCHAR2(250),
   DLJGPOST             VARCHAR2(10),
   DLJGLXR              VARCHAR2(100),
   DLJGLXTEL            VARCHAR2(20),
   DLJGFAX              VARCHAR2(20),
   DLJGMAIL             VARCHAR2(100),
   DLJGURL              VARCHAR2(200),
   DLJGBANK             VARCHAR2(100),
   DLJGACCOUNT          VARCHAR2(100),
   DLJGLHH              VARCHAR2(100),
   GGXZ                 VARCHAR2(1),
   GETMETHOD            CLOB,
   FILE1                VARCHAR2(50),
   CONTENT              CLOB,
   FBR                  VARCHAR2(50),
   RELPACKID            CLOB,
   FLAG2                CHAR(1),
   ZGYSRS               INT,
   QYHFJZSJ             DATE,
   constraint PK_BD_ZBGG primary key (PKID)
)
		';
-- 注释	
		execute immediate 'comment on table BD_ZBGG is ''--招标公告/资格预审公告'' ';
		execute immediate 'comment on column BD_ZBGG.PKID is ''主键'' ';
		execute immediate 'comment on column BD_ZBGG.TITLE is ''公告标题'' ';
		execute immediate 'comment on column BD_ZBGG.PROID is ''招标项目编号'' ';
		execute immediate 'comment on column BD_ZBGG.PRONAME is ''招标项目名称'' ';
		execute immediate 'comment on column BD_ZBGG.JGMC is ''机关名称'' ';
		execute immediate 'comment on column BD_ZBGG.PWMORNO is ''批文名及编号'' ';
		execute immediate 'comment on column BD_ZBGG.XMYZ is ''项目业主'' ';
		execute immediate 'comment on column BD_ZBGG.ZJLY is ''资金来源'' ';
		execute immediate 'comment on column BD_ZBGG.ZBR is ''招标人代码'' ';
		execute immediate 'comment on column BD_ZBGG.ZBRMC is ''招标人名称'' ';
		execute immediate 'comment on column BD_ZBGG.ZBTRO is ''项目概况与招标范围'' ';
		execute immediate 'comment on column BD_ZBGG.TBRZZ is ''投标人资质'' ';
		execute immediate 'comment on column BD_ZBGG.TBRYJ is ''投标人业绩'' ';
		execute immediate 'comment on column BD_ZBGG.QTYQ is ''投标人其它要求'' ';
		execute immediate 'comment on column BD_ZBGG.FLAG1 is ''是否接受联合体招标 1- 接受，0 or other 不接受'' ';
		execute immediate 'comment on column BD_ZBGG.LHTTBYQ is ''联合体投标要求'' ';
		execute immediate 'comment on column BD_ZBGG.BDGS is ''标段个数'' ';
		execute immediate 'comment on column BD_ZBGG.GGFBMT is ''公告发布媒体'' ';
		execute immediate 'comment on column BD_ZBGG.BSKSSJ is ''购买投标文件/资格预审文件开始时间'' ';
		execute immediate 'comment on column BD_ZBGG.BSJSSJ is ''购买标投标文件/资格预审文件结束时间'' ';
		execute immediate 'comment on column BD_ZBGG.BSSJ is ''投标文件/资格预审文件售价'' ';
		execute immediate 'comment on column BD_ZBGG.TZYJ is ''图纸押金'' ';
		execute immediate 'comment on column BD_ZBGG.JZSJ is ''投标/预审截止时间'' ';
		execute immediate 'comment on column BD_ZBGG.KBSJ is ''开标时间'' ';
		execute immediate 'comment on column BD_ZBGG.KBADDR is ''开标地址'' ';
		execute immediate 'comment on column BD_ZBGG.TBWJDJ is ''投标/资格预审文件递交方法'' ';
		execute immediate 'comment on column BD_ZBGG.STATUS is ''公告状态'' ';
		execute immediate 'comment on column BD_ZBGG.TYP is ''公告类型1-招标 2-资格预审 9-其它'' ';
		execute immediate 'comment on column BD_ZBGG.DATE1 is ''公告发布时间'' ';
		execute immediate 'comment on column BD_ZBGG.DATE2 is ''公告结束时间'' ';
		execute immediate 'comment on column BD_ZBGG.SHR is ''公告审核人'' ';
		execute immediate 'comment on column BD_ZBGG.ZBRADDR is ''招标人地址'' ';
		execute immediate 'comment on column BD_ZBGG.ZBRPOST is ''招标人邮编'' ';
		execute immediate 'comment on column BD_ZBGG.ZBLXR is ''招标联系人'' ';
		execute immediate 'comment on column BD_ZBGG.ZBLXTEL is ''招标联系电话'' ';
		execute immediate 'comment on column BD_ZBGG.ZBLXFAX is ''招标传真'' ';
		execute immediate 'comment on column BD_ZBGG.ZBEMAIL is ''招标电子邮件'' ';
		execute immediate 'comment on column BD_ZBGG.ZBURL is ''招标网址'' ';
		execute immediate 'comment on column BD_ZBGG.ZBBANK is ''招标开户银行'' ';
		execute immediate 'comment on column BD_ZBGG.ZBACCOUNT is ''招标账号'' ';
		execute immediate 'comment on column BD_ZBGG.ZBLHH is ''招标联行号'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGID is ''代理机构代码'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGNAME is ''代理机构名称'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGADDR is ''代理机构地址'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGPOST is ''代理机构邮编'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGLXR is ''代理机构联系人'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGLXTEL is ''代理机构联系电话'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGFAX is ''代理机构传真'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGMAIL is ''代理机构电子邮件'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGURL is ''代理机构网址'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGBANK is ''代理机构开户银行'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGACCOUNT is ''代理机构账号'' ';
		execute immediate 'comment on column BD_ZBGG.DLJGLHH is ''代理机构联行号'' ';
		execute immediate 'comment on column BD_ZBGG.GGXZ is ''公告性质1-正常公告 2-更正公告 9-其它'' ';
		execute immediate 'comment on column BD_ZBGG.GETMETHOD is ''投标/资格预审文件获取方法'' ';
		execute immediate 'comment on column BD_ZBGG.FILE1 is ''公告附件'' ';
		execute immediate 'comment on column BD_ZBGG.CONTENT is ''公告内容'' ';
		execute immediate 'comment on column BD_ZBGG.FBR is ''公告发布人'' ';
		execute immediate 'comment on column BD_ZBGG.RELPACKID is ''相关标段（包）编号，半角分号隔开'' ';
		execute immediate 'comment on column BD_ZBGG.FLAG2 is ''资格预审采用方式 1-合格制 2-有限数量制'' ';
		execute immediate 'comment on column BD_ZBGG.ZGYSRS is ''通过资格预审的人数'' ';
		execute immediate 'comment on column BD_ZBGG.QYHFJZSJ is ''邀请回复截止时间'' ';
		
end if; 

num:=0; 
    tmp1:=upper('BD_ZBGG_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_ZBGG_0 
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
	tmp1:=upper('BD_ZB_FILE');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '	
		create table BD_ZB_FILE  (
		   ID                   INT                             not null,
		   PACKID               VARCHAR2(23),
		   TITLE                VARCHAR2(60),
		   FILESIZE             NUMBER(10,1),
		   FILENAME             VARCHAR2(100),
		   FILEPATH             VARCHAR2(100),
		   FILETYPE             NUMBER(10),
		   HYDM                 VARCHAR2(30),
		   CZYDM                VARCHAR2(30),
		   RQ                   DATE,
		   constraint PK_BD_ZB_FILE primary key (ID)
		);
		';
  -- 注释
		execute immediate 'comment on table BD_ZB_FILE is ''招标上传文件'' ';
		execute immediate 'comment on column BD_ZB_FILE.ID is ''编号'' ';		
		execute immediate 'comment on column BD_ZB_FILE.PACKID is ''标段（包）编号'' ';		
		execute immediate 'comment on column BD_ZB_FILE.TITLE is ''标题'' ';		
		execute immediate 'comment on column BD_ZB_FILE.FILESIZE is ''文件大小（M）'' ';		
		execute immediate 'comment on column BD_ZB_FILE.FILENAME is ''文件名称'' ';		
		execute immediate 'comment on column BD_ZB_FILE.FILEPATH is ''文件路径'' ';	
		execute immediate 'comment on column BD_ZB_FILE.FILETYPE is ''文件类型（1-资格预审须知，2-评审办法，3-参考资料）'' ';		
		execute immediate 'comment on column BD_ZB_FILE.HYDM is ''会员代码'' ';		
		execute immediate 'comment on column BD_ZB_FILE.CZYDM is ''操作员'' ';		
		execute immediate 'comment on column BD_ZB_FILE.RQ is ''日期'' ';
		
	end if; 
	
	num:=0; 
    tmp1:=upper('BD_ZB_FILE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_ZB_FILE_0 
  minvalue 1
  maxvalue 9999999999999999999999999999
  start with 1
  increment by 1
  nocache
  order
  ';
  
  end if;  	

	
	--新建项目建档
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_PROJECT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_PROJECT  (
			   PROID                VARCHAR2(17)                    not null,
			   PROMC                VARCHAR2(200),
			   PRONO                VARCHAR2(17),
			   ZBR                  VARCHAR2(9),
			   ZBRMC                VARCHAR2(50),
			   ZJLY                 VARCHAR2(100),
			   ZJLYDESC             VARCHAR2(1000),
			   DEPID                VARCHAR2(30),
			   DEPNAME              VARCHAR2(80),
			   OPTID                VARCHAR2(30),
			   OPTNAME              VARCHAR2(80),
			   YFBZ                 CHAR(1),
			   XMHYFL               VARCHAR2(3),
			   PROVINCE             VARCHAR2(6),
			   PROVINCENAME         VARCHAR2(100),
			   CITY                 VARCHAR2(6),
			   CITYNAME             VARCHAR2(100),
			   COUNTY               VARCHAR2(6),
			   COUNTYNAME           VARCHAR2(100),
			   ADDR                 VARCHAR2(250),
			   XMFR                 VARCHAR2(100),
			   XMGM                 VARCHAR2(1000),
			   LXR                  VARCHAR2(100),
			   LXTEL                VARCHAR2(100),
			   PZWH                 VARCHAR2(50),
			   constraint PK_BD_PROJECT primary key (PROID)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_PROJECT is ''--项目建档'' ';		
		execute immediate '	comment on column BD_PROJECT.PROID is ''项目编号'' ';
		execute immediate '	comment on column BD_PROJECT.PROMC is ''项目名称'' ';
		execute immediate '	comment on column BD_PROJECT.PRONO is ''引用项目编号'' ';
		execute immediate '	comment on column BD_PROJECT.ZBR is ''招标人代码'' ';
		execute immediate '	comment on column BD_PROJECT.ZBRMC is ''招标人名称'' ';
		execute immediate '	comment on column BD_PROJECT.ZJLY is ''资金来源'' ';
		execute immediate '	comment on column BD_PROJECT.ZJLYDESC is ''资金来源描述'' ';
		execute immediate '	comment on column BD_PROJECT.DEPID is ''部门ID'' ';
		execute immediate '	comment on column BD_PROJECT.DEPNAME is ''部门名称'' ';
		execute immediate '	comment on column BD_PROJECT.OPTID is ''操作员ID'' ';
		execute immediate '	comment on column BD_PROJECT.OPTNAME is ''操作员名称'' ';
		execute immediate '	comment on column BD_PROJECT.YFBZ is ''是否属于强制性招标项目 1-是 0 or other 否'' ';
		execute immediate '	comment on column BD_PROJECT.XMHYFL is ''项目行业分类'' ';
		execute immediate '	comment on column BD_PROJECT.PROVINCE is ''省代码'' ';
		execute immediate '	comment on column BD_PROJECT.PROVINCENAME is ''省名称'' ';
		execute immediate '	comment on column BD_PROJECT.CITY is ''市代码'' ';
		execute immediate '	comment on column BD_PROJECT.CITYNAME is ''市名称'' ';
		execute immediate '	comment on column BD_PROJECT.COUNTY is ''县代码'' ';
		execute immediate '	comment on column BD_PROJECT.COUNTYNAME is ''县名称'' ';
		execute immediate '	comment on column BD_PROJECT.ADDR is ''项目地址'' ';
		execute immediate '	comment on column BD_PROJECT.XMFR is ''项目法人'' ';
		execute immediate '	comment on column BD_PROJECT.XMGM is ''项目规模'' ';
		execute immediate '	comment on column BD_PROJECT.LXR is ''联系人'' ';
		execute immediate '	comment on column BD_PROJECT.LXTEL is ''联系方式'' ';
		execute immediate '	comment on column BD_PROJECT.PZWH is ''立项批准文号'' ';

	
	end if; 
	
	--项目行业分类
    num :=0;
    tmp1 := upper('BD_TRADE_TYPE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_TRADE_TYPE  (
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
		   constraint PK_BD_TRADE_TYPE primary key (PKID)
		)';
	  execute immediate 'comment on table BD_TRADE_TYPE is ''项目行业分类''';
	  execute immediate 'comment on column BD_TRADE_TYPE.PKID is ''自增主键''';
	  execute immediate 'comment on column BD_TRADE_TYPE.CODE is ''代码''';
	  execute immediate 'comment on column BD_TRADE_TYPE.NAME is ''名称''';
	  execute immediate 'comment on column BD_TRADE_TYPE.FATHER is ''父级代码''';
	  execute immediate 'comment on column BD_TRADE_TYPE.CODES is ''层级组合代码值''';
	  execute immediate 'comment on column BD_TRADE_TYPE.ISCHILD is ''是否包含子类（0 or other - 否，1 - 是）''';
	  execute immediate 'comment on column BD_TRADE_TYPE.PLEVEL is ''当前节点层级（1-第一层，2-第二层，3-第三层...）''';
	  execute immediate 'comment on column BD_TRADE_TYPE.ISSHOW is ''是否在前台显示（0 or other - 否，1 - 是）''';
	  execute immediate 'comment on column BD_TRADE_TYPE.CDATE is ''新增时间''';
	  execute immediate 'comment on column BD_TRADE_TYPE.UDATE is ''最后修改时间''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_TRADE_TYPE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_TRADE_TYPE_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    
    -- add zhminfu 评审专家管理建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_EXPERT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_EXPERT  (
		   ZJDM                 VARCHAR2(17)                    not null,
		   ZJMC                 VARCHAR2(100),
		   CDATE                DATE,
		   BIRTH_DATE           DATE,
		   AGE                  NUMBER(6),
		   SEX                  CHAR(1),
		   CARD_TYPE            CHAR(2),
		   CARD_NUM             VARCHAR2(18),
		   DQ_CODE1             VARCHAR2(6),
		   DQ_NAME1             VARCHAR2(30),
		   DQ_CODE2             VARCHAR2(6),
		   DQ_NAME2             VARCHAR2(30),
		   DQ_CODE3             VARCHAR2(6),
		   DQ_NAME3             VARCHAR2(30),
		   ADDRESS              VARCHAR2(100),
		   POSTCODE             VARCHAR2(6),
		   LXTEL                VARCHAR2(100),
		   EMAIL                VARCHAR2(100),
		   IS_JOB               VARCHAR2(1),
		   UNIT_NAME            VARCHAR2(100),
		   POSITION             VARCHAR2(50),
		   LASTSCHOOL           VARCHAR2(100),
		   DEGREE               VARCHAR2(30),
		   MAJOR                VARCHAR2(6),
		   WORK_YEARS           NUMBER(2),
		   JSZC                 VARCHAR2(50),
		   ZYZGXL               VARCHAR2(50),
		   HYDM                 VARCHAR2(50),
		   CZYDM                VARCHAR2(30),
		   ZYZGDJ               VARCHAR2(50),
		   ZJLY                 NUMBER(10),
		   RESUME               CLOB,
		   BONUS_MALUS          CLOB,
		   constraint PK_BD_EXPERT primary key (ZJDM)
			)
		';		
		-- 注释			
		execute immediate ' comment on column BD_EXPERT.ZJDM is ''专家代码'' ';	
		execute immediate ' comment on column BD_EXPERT.ZJMC is ''专家名称'' ';	
		execute immediate ' comment on column BD_EXPERT.AGE is ''年龄'' ';	
		execute immediate ' comment on column BD_EXPERT.CDATE is ''创建日期'' ';	
		execute immediate ' comment on column BD_EXPERT.BIRTH_DATE is ''出生年月日YYYYMMDD'' ';	
		execute immediate ' comment on column BD_EXPERT.SEX is ''性别 1-男性 2-女性'' ';	
		execute immediate ' comment on column BD_EXPERT.CARD_TYPE is ''证件类型 01-身份证'' ';	
		execute immediate ' comment on column BD_EXPERT.CARD_NUM is ''证件号码'' ';	
		execute immediate ' comment on column BD_EXPERT.LXTEL is ''联系电话'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_CODE1 is ''省代码'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_NAME1 is ''省名称'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_CODE2 is ''市代码'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_NAME2 is ''市名称'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_CODE3 is ''县代码'' ';	
		execute immediate ' comment on column BD_EXPERT.DQ_NAME3 is ''县名称'' ';	
		execute immediate ' comment on column BD_EXPERT.EMAIL is ''邮箱地址'' ';	
		execute immediate ' comment on column BD_EXPERT.ADDRESS is ''详细地址'' ';	
		execute immediate ' comment on column BD_EXPERT.POSTCODE is ''邮政编码'' ';	
		execute immediate ' comment on column BD_EXPERT.IS_JOB is ''是否在职 1-是 0-否'' ';	
		execute immediate ' comment on column BD_EXPERT.UNIT_NAME is ''所在单位名称'' ';	
		execute immediate ' comment on column BD_EXPERT.POSITION is ''职务'' ';	
		execute immediate ' comment on column BD_EXPERT.RESUME is ''工作简历'' ';	
		execute immediate ' comment on column BD_EXPERT.LASTSCHOOL is ''毕业院校'' ';	
		execute immediate ' comment on column BD_EXPERT.DEGREE is ''学历'' ';	
		execute immediate ' comment on column BD_EXPERT.MAJOR is ''专业'' ';	
		execute immediate ' comment on column BD_EXPERT.WORK_YEARS is ''从业年限（工龄）'' ';	
		execute immediate ' comment on column BD_EXPERT.JSZC is ''技术职称'' ';	
		execute immediate ' comment on column BD_EXPERT.ZYZGXL is ''职业资格序列'' ';	
		execute immediate ' comment on column BD_EXPERT.HYDM is ''会员代码'' ';	
		execute immediate ' comment on column BD_EXPERT.CZYDM is ''操作员代码 操作员代码'' ';	
		execute immediate ' comment on column BD_EXPERT.ZYZGDJ is ''职业资格等级'' ';	
		execute immediate ' comment on column BD_EXPERT.ZJLY is ''专家来源  平台库/公共库'' ';	
		execute immediate ' comment on column BD_EXPERT.BONUS_MALUS is ''奖惩记录'' ';	
	end if; 
	
	
	-- add 异议澄清及回复
	num :=0;-- 注意：查询前必须初始化此变量
    tmp1 := upper('BD_DISSENT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_DISSENT  (
		   PKID                 NUMBER                           not null,
		   PACKID               varchar2(23),
		   QDWNAME              VARCHAR2(100),
		   QCODE                VARCHAR2(9),
		   QNAME                VARCHAR2(100),
		   QTEL                 VARCHAR2(20),
		   QCONTENT             CLOB,
		   QREASON              CLOB,
		   QFILEPATH            VARCHAR2(50),
		   QFILENAME            VARCHAR2(200),
		   QDATE                DATE,
		   AOBJECT              CHAR(1),
		   ADWNAME              VARCHAR2(100),
		   ACODE                VARCHAR2(9),
		   ANAME                VARCHAR2(100),
		   ATEL                 VARCHAR2(20),
		   ACONTENT             CLOB,
		   AFILEPATH            VARCHAR2(50),
		   AFILENAME            VARCHAR2(200),
		   ADATE                DATE,
		   ISANSWER             CHAR(1),
		   FKDATE               DATE,
		   TYP                  NUMBER(10),
		   ANDATE               DATE,
		   constraint PK_BD_DISSENT primary key (PKID)
		)';
	  execute immediate 'comment on table BD_DISSENT is ''异议澄清与回复''';
	  execute immediate 'comment on column BD_DISSENT.PKID is ''自增主键''';
	  execute immediate 'comment on column BD_DISSENT.PACKID is ''标段（包）编号''';
	  execute immediate 'comment on column BD_DISSENT.QDWNAME is ''提问人单位名称''';
	  execute immediate 'comment on column BD_DISSENT.QCODE is ''提问人代码''';
	  execute immediate 'comment on column BD_DISSENT.QNAME is ''提问人姓名''';
	  execute immediate 'comment on column BD_DISSENT.QTEL is ''提问人联系方式''';
	  execute immediate 'comment on column BD_DISSENT.QCONTENT is ''提问内容''';
	  execute immediate 'comment on column BD_DISSENT.QREASON is ''提问依据和理由''';
	  execute immediate 'comment on column BD_DISSENT.QFILEPATH is ''提问文件路径''';
	  execute immediate 'comment on column BD_DISSENT.QFILENAME is ''提问文件名称''';
	  execute immediate 'comment on column BD_DISSENT.QDATE is ''提问时间''';
	  execute immediate 'comment on column BD_DISSENT.AOBJECT is ''回复对象1-回复提问人 2-回复所有人''';
	  execute immediate 'comment on column BD_DISSENT.ADWNAME is ''回复人单位名称''';
	  execute immediate 'comment on column BD_DISSENT.ACODE is ''回复人代码''';
	  execute immediate 'comment on column BD_DISSENT.ANAME is ''回复人姓名''';
	  execute immediate 'comment on column BD_DISSENT.ATEL is ''回复人联系方式''';
	  execute immediate 'comment on column BD_DISSENT.ACONTENT is ''回复内容''';
	  execute immediate 'comment on column BD_DISSENT.AFILEPATH is ''回复文件路径''';
	  execute immediate 'comment on column BD_DISSENT.AFILENAME is ''回复文件名称''';
	  execute immediate 'comment on column BD_DISSENT.ADATE is ''回复时间''';
	  execute immediate 'comment on column BD_DISSENT.ISANSWER is ''是否回复 1-是，0 or other-- 否''';
	  execute immediate 'comment on column BD_DISSENT.FKDATE is ''反馈时间''';
	  execute immediate 'comment on column BD_DISSENT.TYP is ''异议类型  1-专家澄清问题提问与回复''';
	  execute immediate 'comment on column BD_DISSENT.ANDATE is ''回复截止时间''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_DISSENT_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_DISSENT_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
	
	
	
    -- add zhminfu 评审委员会建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_JURY  (
		   WYHDM                VARCHAR2(20)                    not null,
		   WYHMC                VARCHAR2(500),
		   HYDM                 VARCHAR2(30),
		   HYNAME               VARCHAR2(250),
		   CDATE                DATE,
		   ZBRDM                VARCHAR2(9),
		   ZBRMC                VARCHAR2(100),
		   DLRDM                VARCHAR2(9),
		   DLRMC                VARCHAR2(100),
		   LXR                  VARCHAR2(30),
		   LXRTEL               VARCHAR2(30),
		   OPT00                VARCHAR2(30),
		   DATE00               DATE,
		   DATE01               DATE,
		   DATE02               DATE,
		   DATE03               DATE,
		   PSADDR               VARCHAR2(100),
		   TIMES                NUMBER(10,1),
		   REQUIE               CLOB,
		   IS_SCALE             INT,
		   PROBIDS              VARCHAR2(200),
		   PROBNAMES            VARCHAR2(1000),
		   constraint PK_BD_JURY primary key (WYHDM)
			)
		';		
		-- 注释			
		execute immediate ' comment on column BD_JURY.WYHDM is ''委员会编号'' ';
		execute immediate ' comment on column BD_JURY.WYHMC is ''委员会名称'' ';
		execute immediate ' comment on column BD_JURY.HYDM is ''创建人代码'' ';
		execute immediate ' comment on column BD_JURY.HYNAME is ''创建人名称'' ';
		execute immediate ' comment on column BD_JURY.CDATE is ''创建日期'' ';
		execute immediate ' comment on column BD_JURY.ZBRDM is ''招标人代码'' ';
		execute immediate ' comment on column BD_JURY.ZBRMC is ''招标人名称'' ';
		execute immediate ' comment on column BD_JURY.DLRDM is ''代理机构代码'' ';
		execute immediate ' comment on column BD_JURY.DLRMC is ''代理机构名称'' ';
		execute immediate ' comment on column BD_JURY.LXR is ''代理机构联系人'' ';
		execute immediate ' comment on column BD_JURY.LXRTEL is ''联系人电话'' ';
		execute immediate ' comment on column BD_JURY.OPT00 is ''抽取人'' ';
		execute immediate ' comment on column BD_JURY.DATE00 is ''抽取时间'' ';
		execute immediate ' comment on column BD_JURY.DATE01 is ''评审时间'' ';
		execute immediate ' comment on column BD_JURY.DATE02 is ''签到时间'' ';
		execute immediate ' comment on column BD_JURY.DATE03 is ''开标时间'' ';
		execute immediate ' comment on column BD_JURY.PSADDR is ''评审地址'' ';
		execute immediate ' comment on column BD_JURY.TIMES is ''评审耗时: 1天'' ';
		execute immediate ' comment on column BD_JURY.REQUIE is ''抽取要求'' ';
		execute immediate ' comment on column BD_JURY.IS_SCALE is ''是否定标1-是 0-否'' ';	
		execute immediate ' comment on column BD_JURY.PROBIDS is ''合并招标项目编号,多个逗号隔开'' ';
		execute immediate ' comment on column BD_JURY.PROBNAMES is ''合并招标项目名称,多个逗号隔开'' ';
	end if; 
	
	tmp1:=upper('BD_JURY');
  	tmp2:=upper('JDDW');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(250))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''监督单位''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('JDR');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''监督人员''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('JDRTEL');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''监督人电话''';
    end if; 
    
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('BDIDS');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(230))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）编号,多个逗号隔开''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('PACKNAMES');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）名称,多个逗号隔开''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('STATUS');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''0-生成 1-已抽取专家 2-已选择业主代表''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('PROBID');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目编号''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('PROBNAME');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目名称''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('IS_PRE');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-资格预审委员会 0OrNull 评标委员会''';
    end if; 
    
    tmp1:=upper('BD_JURY');
  	tmp2:=upper('RSNUM');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评委专家人数''';
    end if;
	
	-- add zhminfu 评审委员会成员建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY_MEMBER');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_JURY_MEMBER  (
		   WYHDM                VARCHAR2(20)                    not null,
		   XH                   INT                             not null,
		   ZJDM                 VARCHAR2(17),
		   ZJMC                 VARCHAR2(50),
		   STATUS               INT,
		   TYP                  CHAR(1),
		   SEX                  CHAR(1),
		   DEGREE               VARCHAR2(30),
		   MAJOR                VARCHAR2(6),
		   UNIT_NAME            VARCHAR2(100),
		   ZYZGDJ               VARCHAR2(50),
		   NOTICE               VARCHAR2(50),
		   DATE00               DATE,
		   LXRTEL               VARCHAR2(11),
		   IS_CX                CHAR(1),
		   NICKNAME             VARCHAR2(50),
		   ASSESS               CLOB,
		   constraint PK_BD_JURY_MEMBER primary key (WYHDM, XH)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_JURY_MEMBER is ''--评审委员会成员'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.WYHDM is ''委员会编号'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.XH is ''序号'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.ZJDM is ''专家代码'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.ZJMC is ''专家名称(业主代表姓名)'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.STATUS is ''状态：0-停用 1-正常（签到后离场，手动停用，重新抽取）'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.TYP is ''评委类型 1-专家 2-业主代表'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.SEX is ''性别 1-男性 2-女性'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.DEGREE is ''学历'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.MAJOR is ''专业'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.UNIT_NAME is ''所在单位名称'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.ZYZGDJ is ''职业资格等级'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.NOTICE is ''通知方式'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.DATE00 is ''通知时间'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.LXRTEL is ''联系电话'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.IS_CX is ''是否出席 1-是 0-否'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.NICKNAME is ''业主代表昵称'' ';
		execute immediate ' comment on column BD_JURY_MEMBER.ASSESS is ''考核记录'' ';	
	end if;
	
	tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('USERID');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员代码''';
    end if; 
    
    tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('PWD');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(32))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''登录密码''';
    end if; 
    
    tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('BDIDS');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''可评审的标段（包）PKID 多个逗号隔开''';
    end if;
    
    tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('IS_SING');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已签到 1-是 0-否''';
    end if;
	
	
	-- add zhminfu 评审委员会成员建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY_SIGN');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_JURY_SIGN  (
		   PKID                 INT                             not null,
		   WYHDM                VARCHAR2(20),
		   XH                   INT,
		   ZJDM                 VARCHAR2(17),
		   ZJMC                 VARCHAR2(50),
		   STATUS               INT,
		   PROBID               VARCHAR2(20),
		   PROBNAME             VARCHAR2(100),
		   BDID                 VARCHAR2(23),
		   PACKNAME             VARCHAR2(200),
		   DATE00               DATE,
		   DATE01               DATE,
		   DATE02               DATE,
		   DATE03               DATE,
		   DATE04               DATE,
		   IS_SING              CHAR(1),
		   IS_PUSH              CHAR(1),
		   IS_DEAN              CHAR(1),
		   PUSH_NAME            VARCHAR2(50),
		   VOTES                INT,
		   constraint PK_BD_JURY_SIGN primary key (PKID)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_JURY_SIGN is ''--评委签到详情'' ';
		execute immediate ' comment on column BD_JURY_SIGN.PKID is ''自增ID'' ';
		execute immediate ' comment on column BD_JURY_SIGN.WYHDM is ''委员会编号'' ';
		execute immediate ' comment on column BD_JURY_SIGN.XH is ''成员序号（BD_JURY_MEMBER.XH）'' ';
		execute immediate ' comment on column BD_JURY_SIGN.ZJDM is ''专家代码'' ';
		execute immediate ' comment on column BD_JURY_SIGN.ZJMC is ''专家名称(业主代表姓名)'' ';
		execute immediate ' comment on column BD_JURY_SIGN.STATUS is ''状态：0-停用 1-正常（签到后离场，手动停用，重新抽取）'' ';
		execute immediate ' comment on column BD_JURY_SIGN.PROBID is ''招标项目编号'' ';
		execute immediate ' comment on column BD_JURY_SIGN.PROBNAME is ''招标项目名称'' ';
		execute immediate ' comment on column BD_JURY_SIGN.BDID is ''标段（包）PKID'' ';
		execute immediate ' comment on column BD_JURY_SIGN.PACKNAME is ''标段（包）名称'' ';
		execute immediate ' comment on column BD_JURY_SIGN.DATE00 is ''签到开始时间'' ';
		execute immediate ' comment on column BD_JURY_SIGN.DATE01 is ''签到时间'' ';
		execute immediate ' comment on column BD_JURY_SIGN.DATE02 is ''确认回避承诺时间'' ';
		execute immediate ' comment on column BD_JURY_SIGN.DATE03 is ''确认廉洁自律承诺时间'' ';
		execute immediate ' comment on column BD_JURY_SIGN.DATE04 is ''备用'' ';
		execute immediate ' comment on column BD_JURY_SIGN.IS_SING is ''是否已签到 1-是 0-否'' ';
		execute immediate ' comment on column BD_JURY_SIGN.IS_PUSH is ''是否已推荐 1-是 0-否'' ';
		execute immediate ' comment on column BD_JURY_SIGN.IS_DEAN is ''是否是评审主任1-是 0-否'' ';
		execute immediate ' comment on column BD_JURY_SIGN.PUSH_NAME is ''最后一次推荐主任的姓名'' ';
		execute immediate ' comment on column BD_JURY_SIGN.VOTES is ''获得推荐票数'' ';
	end if;
	
	num:=0; 
    tmp1:=upper('BD_JURY_SIGN_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_JURY_SIGN_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
  	tmp2:=upper('TOTAL_VOTES');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合计多轮共获得票数''';
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
  	tmp2:=upper('PUSH_TIME');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''推荐次数（第1轮，第2轮）''';
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
  	tmp2:=upper('STATUS00');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' 
			is ''评审状态:1： 已提交初审2： 已汇总（主任才有）3： 已提交详审4： 已确认报告（主任生成并确认，其他评委直接确认）''';
    end if;
    
    
	-- add zhminfu 抽取专家条件 -建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY_REQUIRE');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_JURY_REQUIRE  (
		   PKID                 INT                             not null,
		   WYHDM                VARCHAR2(20),
		   FHRS                 INT,
		   CQRS                 INT,
		   MAJOR                VARCHAR2(60),
		   DQ_CODE1             VARCHAR2(6),
		   DQ_NAME1             VARCHAR2(30),
		   DQ_CODE2             VARCHAR2(6),
		   DQ_NAME2             VARCHAR2(30),
		   DQ_CODE3             VARCHAR2(6),
		   DQ_NAME3             VARCHAR2(30),
		   constraint PK_BD_JURY_REQUIRE primary key (PKID)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_JURY_REQUIRE is ''--抽取专家条件'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.PKID is ''自增ID'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.WYHDM is ''委员会编号'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.FHRS is ''符合人数'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.CQRS is ''抽取人数'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.MAJOR is ''专业'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_CODE1 is ''省代码'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_NAME1 is ''省名称'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_CODE2 is ''市代码'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_NAME2 is ''市名称'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_CODE3 is ''县代码'' ';
		execute immediate ' comment on column BD_JURY_REQUIRE.DQ_NAME3 is ''县名称'' ';
	end if;
	
	num:=0; 
    tmp1:=upper('BD_JURY_REQUIRE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_JURY_REQUIRE_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    
    -- add zhminfu 评委审查 -建表
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY_CENSOR');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_JURY_CENSOR  (
		   PKID                 INT                             not null,
		   BDID                 VARCHAR2(23),
		   MBDM                 VARCHAR2(32),
		   MBXH                 INT,
		   WYHDM                VARCHAR2(20),
		   XH                   INT,
		   HYDM                 VARCHAR2(30),
		   CDATE                DATE,
		   IS_ACCORD            INT,
		   SCORE                NUMBER(10,2),
		   REASON               VARCHAR2(500),
		   constraint PK_BD_JURY_CENSOR primary key (PKID)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_JURY_CENSOR is ''--评委审查表'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.PKID is ''自增ID'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.BDID is ''标段（包）PKID'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.MBDM is ''评审模版编号'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.MBXH is ''评审模版序号'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.WYHDM is ''委员会编号'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.XH is ''成员序号（BD_JURY_MEMBER.XH）'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.HYDM is ''会员代码(投标方)'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.CDATE is ''创建日期'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.IS_ACCORD is ''是否符合  0orNull不符合 1-符合'' ';
		execute immediate ' comment on column BD_JURY_CENSOR.SCORE is ''详审得分 '' ';
		execute immediate ' comment on column BD_JURY_CENSOR.REASON is ''不符合理由'' ';
	end if;
	
	num:=0; 
    tmp1:=upper('BD_JURY_CENSOR_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_JURY_CENSOR_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    
    tmp1:=upper('BD_JURY_CENSOR');
  	tmp2:=upper('PSJD');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
      execute immediate 'alter table '||tmp1||' drop ('||tmp2||' )';
    end if;
    
    tmp1:=upper('BD_JURY_CENSOR');
  	tmp2:=upper('MBLX');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审阶段 1-资格评审 2-评标''';
    end if;
    
    tmp1:=upper('BD_JURY_CENSOR');
  	tmp2:=upper('SCLX');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查类型 1-初审 2-祥审''';
    end if;
    
    tmp1:=upper('BD_JURY_CENSOR');
  	tmp2:=upper('XZXH');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''细则序号''';
    end if;
    
    --新建项目标的物
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_PROJECT_ITEM');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_PROJECT_ITEM  (
			   XMBDWID              INT                             not null,
			   PROID                VARCHAR2(17),
			   ITEMNAME             VARCHAR2(200),
			   XH                   VARCHAR2(100),
			   GG                   VARCHAR2(250),
			   JSBZ                 VARCHAR2(250),
			   JLDW                 VARCHAR2(10),
			   SL1                  VARCHAR2(30),
			   BZ                   VARCHAR2(500),
			   JHRQ                 DATE,
			   ZBFW                 VARCHAR2(500),
			   GQ                   VARCHAR2(30),
			   FLAG1                NUMBER,
			   DEPID                VARCHAR2(30),
			   DEPNAME              VARCHAR2(80),
			   OPTID                VARCHAR2(30),
			   OPTNAME              VARCHAR2(80),
			   ACCESSORY            VARCHAR2(300),
			   GCZLBZ               VARCHAR(250),
			   JSDD                 VARCHAR(500),
			   FWQ                  VARCHAR(30),
			   FWDD                 VARCHAR(500),
			   FWNR                 VARCHAR(500),
			   GCGM                 VARCHAR(500),
			   FL                   NUMBER,
			   SYSL                 VARCHAR2(30),
			   constraint PK_BD_PROJECT_ITEM primary key (XMBDWID)
			)
		';		
		-- 注释			
		execute immediate ' comment on table BD_PROJECT_ITEM is ''--项目标的物'' ';		
		execute immediate '	comment on column BD_PROJECT_ITEM.XMBDWID is ''主键'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.PROID is ''项目编号'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.ITEMNAME is ''标的物/服务/工程名称'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.XH is ''型号'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.GG is ''规格'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.JSBZ is ''技术标准'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.JLDW is ''计量单位'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.SL1 is ''采购数量'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.BZ is ''备注'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.JHRQ is ''交货日期'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.ZBFW is ''招标范围'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.GQ is ''工期'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.FLAG1 is ''是否参与集中招标1-是，0 or other 否'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.DEPID is ''部门ID'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.DEPNAME is ''部门名称'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.OPTID is ''操作员ID'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.OPTNAME is ''操作员名称'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.ACCESSORY is ''附件路径'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.GCZLBZ is ''工程质量标准'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.JSDD is ''工程建设地点'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.FWQ is ''服务期'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.FWDD is ''服务地点'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.FWNR is ''服务内容'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.GCGM is ''工程规模'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.FL is ''分类1-货物，2-工程，3-服务'' ';
		execute immediate '	comment on column BD_PROJECT_ITEM.SYSL is ''剩余数量'' ';

	end if; 
	
	num:=0; 
    tmp1:=upper('BD_PROJECT_ITEM_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_PROJECT_ITEM_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
    --标段(包)分类
    num :=0;
    tmp1 := upper('BD_BIDPACKAGE_TYPE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_BIDPACKAGE_TYPE  (
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
		   constraint PK_BD_BIDPACKAGE_TYPE primary key (PKID)
		)';
	  execute immediate 'comment on table BD_BIDPACKAGE_TYPE is ''标段(包)分类''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.PKID is ''自增主键''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.CODE is ''代码''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.NAME is ''名称''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.FATHER is ''父级代码''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.CODES is ''层级组合代码值''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.ISCHILD is ''是否包含子类（0 or other - 否，1 - 是）''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.PLEVEL is ''当前节点层级（1-第一层，2-第二层，3-第三层...）''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.ISSHOW is ''是否在前台显示（0 or other - 否，1 - 是）''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.CDATE is ''新增时间''';
	  execute immediate 'comment on column BD_BIDPACKAGE_TYPE.UDATE is ''最后修改时间''';
    end if;
  
    num:=0; 
    tmp1:=upper('BD_BIDPACKAGE_TYPE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_BIDPACKAGE_TYPE_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
    end if;
	


	
---招标项目--start--hejw----
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
  execute immediate '
   create table BD_SUBPROJECT  (
     PROBID                 VARCHAR2(20) not null,
     PROBNAME              VARCHAR2(100),
     PROID                VARCHAR2(17),
     PROMC                VARCHAR2(200),
     HYDM                 VARCHAR2(30),
     ZBR                  VARCHAR2(9),
     ZBRMC                VARCHAR2(50),
     ZBFS                 VARCHAR2(1),
     ZBZZFS               VARCHAR2(1),
     FLAG1                NUMBER,
     FLAG2                NUMBER,
     JDBMID               VARCHAR2(9),
     JDBMNAME             VARCHAR2(100),
     DEPID                VARCHAR2(30),
     DEPNAME              VARCHAR2(80),
     OPTID                VARCHAR2(30),
     OPTNAME              VARCHAR2(80),
     ZBRS                 NUMBER,
     TBYXQ                NUMBER(10,1),
     ZBTRO                CLOB,
     ZBTRO2               CLOB,
     DATE1                DATE,
     SHDEPID              VARCHAR2(9),
     SHDEPNAME            VARCHAR2(100),
     BSCODE               VARCHAR2(10),
     SBZRR                VARCHAR2(100),
   ZGSHFS            VARCHAR2(2),
   ZCBXM            VARCHAR2(2),
     constraint PK_BD_SUBPROJECT primary key (PROBID)
  )';
  execute immediate ' comment on column BD_SUBPROJECT.PROBID is ''招标项目编号'' ';
  execute immediate ' comment on column BD_SUBPROJECT.PROBNAME is ''招标项目名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.PROID is ''项目编号'' ';
  execute immediate ' comment on column BD_SUBPROJECT.PROMC is ''项目名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.HYDM is ''会员名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBR is ''招标人代码'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBRMC is ''招标人名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBFS is ''招标方式1-公开招标 2-邀请招标 9-其它'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBZZFS is ''招标组织方式 1-自行招标 2-委托招标 9-其它'' ';
  execute immediate ' comment on column BD_SUBPROJECT.FLAG1 is ''委托评标委员会定标 1-是，0 or other -否'' ';
  execute immediate ' comment on column BD_SUBPROJECT.FLAG2 is ''是否集中预审招标项目 1-是，0 or other -否'' ';
  execute immediate ' comment on column BD_SUBPROJECT.JDBMID is ''监督部门代码'' ';
  execute immediate ' comment on column BD_SUBPROJECT.JDBMNAME is ''监督部门名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.DEPID is ''部门ID'' ';
  execute immediate ' comment on column BD_SUBPROJECT.DEPNAME is ''部门名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.OPTID is ''操作员ID'' ';
  execute immediate ' comment on column BD_SUBPROJECT.OPTNAME is ''操作员名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBRS is ''中标人数'' ';
  execute immediate ' comment on column BD_SUBPROJECT.TBYXQ is ''投标有效期(天)'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBTRO is ''招标内容与范围'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZBTRO2 is ''招标方案说明'' ';
  execute immediate ' comment on column BD_SUBPROJECT.DATE1 is ''招标项目建立时间'' ';
  execute immediate ' comment on column BD_SUBPROJECT.SHDEPID is ''审核部门代码'' ';
  execute immediate ' comment on column BD_SUBPROJECT.SHDEPNAME is ''审核部门名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT.BSCODE is ''交换公告服务平台标识码'' ';
  execute immediate ' comment on column BD_SUBPROJECT.SBZRR is ''申报责任人'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZGSHFS is ''资格审核方式 1-预审   2-后审'' ';
  execute immediate ' comment on column BD_SUBPROJECT.ZCBXM is ''是否总承包项目  1-是  0-否'' ';

  end if; 
  --end--------------
	
  

  --招标项目-标段（包）-hejw---
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_PACKAGE');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
  execute immediate '
    create table BD_PACKAGE  (
       BDID                 VARCHAR2(23) not null,
       HYDM           VARCHAR2(30),
       PROBID                VARCHAR2(20),
       PACKNAME             VARCHAR2(200),
       FLDM                 VARCHAR2(7),
       ZBR                  VARCHAR2(9),
       ZBRMC                VARCHAR2(50),
       HTGSJ                NUMBER(20,2),
       BZ                   VARCHAR2(3),
       HTGSDW               VARCHAR2(1),
       ZGTJ                 CLOB,
       CONTENT              CLOB,
       WYHBH                VARCHAR2(20),
       constraint PK_BD_PACKAGE primary key (BDID)
    )';

    execute immediate ' comment on column BD_PACKAGE.BDID is ''标段（包）编号'' ';
    execute immediate ' comment on column BD_PACKAGE.PROBID is ''招标项目编号'' ';
    execute immediate ' comment on column BD_PACKAGE.HYDM is ''会员代码'' ';
    execute immediate ' comment on column BD_PACKAGE.PACKNAME is ''标段（包）名称'' ';
  execute immediate ' comment on column BD_PACKAGE.FLDM is ''标段（包）分类代码'' ';
  execute immediate ' comment on column BD_PACKAGE.ZBR is ''招标人代码'' ';
  execute immediate ' comment on column BD_PACKAGE.ZBRMC is ''招标人名称'' ';
  execute immediate ' comment on column BD_PACKAGE.HTGSJ is ''标段合同估算价'' ';
  execute immediate ' comment on column BD_PACKAGE.BZ is ''币种代码'' ';
  execute immediate ' comment on column BD_PACKAGE.HTGSDW is ''标段合同估算单位1-元 2-万元'' ';
  execute immediate ' comment on column BD_PACKAGE.ZGTJ is ''投标人资格条件'' ';
  execute immediate ' comment on column BD_PACKAGE.CONTENT is ''标段（包）内容'' ';
  execute immediate ' comment on column BD_PACKAGE.WYHBH is ''委员会编号'' ';

  end if; 
  
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('CHECK_STATUS');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' 
		is ''审查状态：0：待评委签到1：评委都已签到2：已产生主任3：已初审完成4：主任已汇总5：已详情完成6：主任已生成评审报告7：评委都已确认报告''';
  end if; 

  
---招标项目 标的物--start--hejw----
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT_ITEM');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
  execute immediate '
  create table BD_SUBPROJECT_ITEM  (
     ZBBDWID              INT                    not null,
     PROBID               VARCHAR2(20),
     XMBDWID              VARCHAR2(23),
     
     ITEMNAME             VARCHAR2(200),
     XH                   VARCHAR2(100),
     GG                   VARCHAR2(250),
     JSBZ                 VARCHAR2(250),
     JLDW                 VARCHAR2(10),
     SL1                  VARCHAR2(30),
     BZ                   VARCHAR2(500),
     JHRQ                 DATE,
     ZBFW                 VARCHAR2(500),
     GQ                   VARCHAR2(30),
     FLAG1                NUMBER,
     
     DEPID                VARCHAR2(30),
     DEPNAME              VARCHAR2(80),
     OPTID                VARCHAR2(30),
     OPTNAME              VARCHAR2(80),
     ACCESSORY            VARCHAR2(300),
   GCZLBZ               VARCHAR(250),
   JSDD                 VARCHAR(500),
   FWQ                  VARCHAR(30),
   FWDD                 VARCHAR(500),
   FWNR                 VARCHAR(500),
   GCGM                 VARCHAR(500),
   FL                   NUMBER,
   SYSL                 NUMBER(20,3),
     constraint PK_BD_SUBPROJECT_ITEM primary key (ZBBDWID)
  )';

  execute immediate ' comment on column BD_SUBPROJECT_ITEM.ZBBDWID is ''招标项目-标的物id'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.PROBID is ''招标项目-编号'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.XMBDWID is ''项目-标的物id'' ';

  execute immediate ' comment on column BD_SUBPROJECT_ITEM.ITEMNAME is ''标的物/服务/工程名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.XH is ''型号'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.GG is ''规格'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.JSBZ is ''技术标准'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.JLDW is ''计量单位'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.SL1 is ''采购数量'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.BZ is ''备注'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.JHRQ is ''交货日期'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.ZBFW is ''招标范围'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.GQ is ''工期'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.FLAG1 is ''是否参与集中招标1-是，0 or other 否'' ';

  execute immediate ' comment on column BD_SUBPROJECT_ITEM.ACCESSORY is ''附件路径'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.DEPID is ''部门ID'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.DEPNAME is ''部门名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.OPTID is ''操作员ID'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.OPTNAME is ''操作员名称'' ';

  execute immediate ' comment on column BD_SUBPROJECT_ITEM.GCZLBZ is ''工程质量标准'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.JSDD is ''工程建设地点'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.FWQ is ''服务期'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.FWDD is  ''服务地点'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.FWNR is ''服务内容'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.GCGM is ''工程规模'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.FL is ''分类1-货物，2-工程，3-服务'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ITEM.SYSL is ''剩余数量'' ';
  
  end if; 



  ---标段包 标的物--start---hejw---
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_PACKAGE_ITEM');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
  execute immediate '
  create table BD_PACKAGE_ITEM  (
     PKID                 INT                    not null,
     BDID                 VARCHAR2(23),
     ZBBDWID              INT,
     
     ITEMNAME             VARCHAR2(200),
     XH                   VARCHAR2(100),
     GG                   VARCHAR2(250),
     JSBZ                 VARCHAR2(250),
     JLDW                 VARCHAR2(10),
     SL1                  VARCHAR2(30),
     BZ                   VARCHAR2(500),
     JHRQ                 DATE,
     ZBFW                 VARCHAR2(500),
     GQ                   VARCHAR2(30),
     FLAG1                NUMBER,
     
     DEPID                VARCHAR2(30),
     DEPNAME              VARCHAR2(80),
     OPTID                VARCHAR2(30),
     OPTNAME              VARCHAR2(80),
     accessory            VARCHAR2(300),
     GCZLBZ               VARCHAR(250),
     JSDD                 VARCHAR(500),
     FWQ                  VARCHAR(30),
     FWDD                 VARCHAR(500),
     FWNR                 VARCHAR(500),
     GCGM                 VARCHAR(500),
     FL                   NUMBER,
     SYSL                 NUMBER(20,3),
     constraint PK_BD_PACKAGE_ITEM primary key (PKID)
  )';

  execute immediate ' comment on column BD_PACKAGE_ITEM.PKID is ''标段包-标的物id'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.BDID is ''标段包-编号'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.ZBBDWID is ''招标项目-标的物id'' ';

  execute immediate ' comment on column BD_PACKAGE_ITEM.ITEMNAME is ''标的物/服务/工程名称'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.XH is ''型号'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.GG is ''规格'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.JSBZ is ''技术标准'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.JLDW is ''计量单位'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.SL1 is ''采购数量'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.BZ is ''备注'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.JHRQ is ''交货日期'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.ZBFW is ''招标范围'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.GQ is ''工期'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.FLAG1 is ''是否参与集中招标1-是，0 or other 否'' ';

  execute immediate ' comment on column BD_PACKAGE_ITEM.accessory is ''附件路径'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.DEPID is ''部门ID'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.DEPNAME is ''部门名称'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.OPTID is ''操作员ID'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.OPTNAME is ''操作员名称'' ';
  
   execute immediate ' comment on column BD_PACKAGE_ITEM.GCZLBZ is ''工程质量标准'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.JSDD is ''工程建设地点'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.FWQ is ''服务期'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.FWDD is  ''服务地点'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.FWNR is ''服务内容'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.GCGM is ''工程规模'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.FL is ''分类1-货物，2-工程，3-服务'' ';
  execute immediate ' comment on column BD_PACKAGE_ITEM.SYSL is ''剩余数量'' ';

  end if; 
  
    num:=0; 
    tmp1:=upper('BD_PACKAGE_ITEM_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_PACKAGE_ITEM_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
	
	num:=0; 
    tmp1:=upper('BD_SUBPROJECT_ITEM_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_SUBPROJECT_ITEM_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
    
    
  ---招标项目扩展表----
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT_EXT');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
	  -- 建表
	  execute immediate '
	  create table BD_SUBPROJECT_EXT  (
	     PROBID               VARCHAR2(20)                    not null,
	     DLJG                 VARCHAR2(9),
	     DLJGNAME             VARCHAR2(100),
	     INTRO                CLOB,
	     FILE1                VARCHAR2(200),
	     yyqx                 DATE,
	     zczj                 VARCHAR2(70),
	     zczz          VARCHAR2(2000),
	     zcd          VARCHAR2(120),
	     fr          VARCHAR2(100),
	     
	     DLFY                 NUMBER(20,2),
	     DLFYDW               VARCHAR2(20),
	     XMJL                 VARCHAR2(30),
	     XMJLNAME             VARCHAR2(100),
	     XMJLLXFS             VARCHAR2(20),   
	     constraint PK_BD_SUBPROJECT_EXT primary key (PROBID)
	  )';
	
	
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.PROBID is ''招标项目编号'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.DLJG is ''代理机构代码'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.DLJGNAME is ''代理机构名称'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.INTRO is ''招标代理内容与范围'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.FILE1 is ''委托合同附件'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.yyqx is ''营业期限'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.zczj is ''注册资金'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.zczz is ''资质及资质等级'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.zcd is ''注册地'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.fr is ''法人'' ';
	
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.DLFY is ''代理费用'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.DLFYDW is ''代理费用单位'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.XMJL is ''项目经理代码'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.XMJLNAME is ''项目经理名称'' ';
	  execute immediate ' comment on column BD_SUBPROJECT_EXT.XMJLLXFS is ''项目经理联系方式'' ';
  end if; 
    
  ---招标项目 邀请单位----
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT_YQDW');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_SUBPROJECT_YQDW  (
       PKID               int          not null,
       probid             VARCHAR2(20) not null,
       dwdm               VARCHAR2(30),
       dwmc               VARCHAR2(250),
       
       constraint PK_BD_SUBPROJECT_YQDW primary key (PKID)
    )';
  
    execute immediate ' comment on column BD_SUBPROJECT_YQDW.PKID is ''主键'' ';
    execute immediate ' comment on column BD_SUBPROJECT_YQDW.probid is ''招标项目id'' ';
    execute immediate ' comment on column BD_SUBPROJECT_YQDW.dwdm is ''邀请单位代码'' ';
    execute immediate ' comment on column BD_SUBPROJECT_YQDW.dwmc is ''邀请单位名称'' ';
  end if; 
  
  
    num:=0; 
    tmp1:=upper('BD_SUBPROJECT_YQDW_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_SUBPROJECT_YQDW_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;  
  
   --bd_zbgg表添加jgsw(价格单位)和)biz(币种)字段,更改proid更改为probid，proname改为probname	add by xuz start
	tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('jgdw');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar(10))';
      execute immediate 'comment on column BD_ZBGG.jgdw is ''价格单位''';
    end if; 
    
    tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('biz');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar(10))';
      execute immediate 'comment on column BD_ZBGG.biz is ''币种''';
    end if; 
    
    tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('proid');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||''; 
  	end if; 
    
    tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('probid');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
      execute immediate 'comment on column BD_ZBGG.probid is ''招标项目编号''';
    end if; 
    
    tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('proname');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||''; 
  	end if; 
    
    tmp1:=upper('BD_ZBGG');
  	tmp2:=upper('probname');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column BD_ZBGG.probname is ''招标项目名称''';
    end if; 
 --bd_zbgg表添加jgsw(价格单位)和)biz(币种)字段,更改proid更改为probid，proname改为probname	add by xuz end  
	
	
  tmp1:=upper('BD_PACKAGE_ITEM');
  tmp2:=upper('sl1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,3)';
  end if; 
  
    tmp1:=upper('BD_PROJECT_ITEM');
  tmp2:=upper('sl1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,3)';
  end if; 
  
    tmp1:=upper('BD_SUBPROJECT_ITEM');
  tmp2:=upper('sl1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,3)';
  end if; 
  
  tmp1:=upper('BD_PROJECT_ITEM');
  tmp2:=upper('SYSL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,3)';
  end if; 
	
  tmp1:=upper('BD_SUBPROJECT');
  	tmp2:=upper('flag3');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar(10))';
      execute immediate 'comment on column BD_SUBPROJECT.flag3 is ''是否已编制预审公告，1-是，0 or 其他 否''';
    end if; 	

	-- add 澄清/变更公告
	num :=0;-- 注意：查询前必须初始化此变量
    tmp1 := upper('BD_CCNOTICE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
      execute immediate 'create table BD_CCNOTICE  (
		   PKID                 NUMBER                          not null,
		   PROBID               VARCHAR(20),
		   PROBNAME             VARCHAR(1000),
		   BDID                 VARCHAR(23),
		   PACKNAME             VARCHAR2(200),
		   CQID                 VARCHAR2(50),
		   TITLE                VARCHAR(200),
		   CONTENT              CLOB,
		   TYP                  CHAR(1),
		   ISDELAYYS            CHAR(1),
		   YSSJ                 DATE,
		   ISALTERDD            CHAR(1),
		   BGDD                 VARCHAR2(200),
		   GGFILE               VARCHAR(100),
		   STATE                CHAR(1),
		   BSKSSJ               DATE,
		   BSJSSJ               DATE,
		   SQZG                 CLOB,
		   SQYXQ                VARCHAR2(200),
		   BSJSSJSTR            DATE,
		   TBWJDJ               CLOB,
		   KBSJSTR              DATE,
		   KQFS                 CLOB,
		   PSBF                 CLOB,
		   JYPTYZR              VARCHAR2(100),
		   TBRZZ                CLOB,
		   BZJSUM               NUMBER(20,2),
		   BIZ                  VARCHAR(10),
		   BZJUNIT              CHAR(1),
		   QTYP                 CHAR(1),
		   GGXZ                 CHAR(1),
		   ATYP                 CHAR(1),
		   DATE1                DATE,
		   SHR                  VARCHAR2(50),
		   GGFBMT               VARCHAR2(1000),
		   ZBR                  VARCHAR2(9),
		   ZBRMC                VARCHAR2(100),
		   DLJGID               VARCHAR2(9),
		   DIJGNAME             VARCHAR2(100),
		   OPTID00              VARCHAR2(30),
		   OPTNAME00            VARCHAR2(100),
		   DATE00				DATE,
		   OPTID01				VARCHAR2(30),
		   OPTNAME01			VARCHAR2(100),
		   DATE01				DATE,
		   constraint PK_BD_CCNOTICE primary key (PKID)
		)';
	  execute immediate 'comment on table BD_CCNOTICE is ''澄清/变更公告''';
	  execute immediate 'comment on column BD_CCNOTICE.PKID is ''自增主键''';
	  execute immediate 'comment on column BD_CCNOTICE.PROBID is ''招标项目编号''';
	  execute immediate 'comment on column BD_CCNOTICE.PROBNAME is ''招标项目名称''';
	  execute immediate 'comment on column BD_CCNOTICE.BDID is ''标段（包）编号''';
	  execute immediate 'comment on column BD_CCNOTICE.PACKNAME is ''标段（包）名称''';
	  execute immediate 'comment on column BD_CCNOTICE.CQID is ''澄清文件编号''';
	  execute immediate 'comment on column BD_CCNOTICE.TITLE is ''公告标题''';
	  execute immediate 'comment on column BD_CCNOTICE.CONTENT is ''公告内容''';
	  execute immediate 'comment on column BD_CCNOTICE.TYP is ''公告类型: 1-澄清 2-变更''';
	  execute immediate 'comment on column BD_CCNOTICE.ISDELAYYS is ''是否延迟预审 1-是，0-否''';
	  execute immediate 'comment on column BD_CCNOTICE.YSSJ is ''预审时间/招标时间''';
	  execute immediate 'comment on column BD_CCNOTICE.ISALTERDD is ''是否变更地点 1-是，0-否''';
	  execute immediate 'comment on column BD_CCNOTICE.BGDD is ''变更地点''';
	  execute immediate 'comment on column BD_CCNOTICE.GGFILE is ''公告附件''';
	  execute immediate 'comment on column BD_CCNOTICE.STATE is ''状态    1-待提交   2-待审核  3-已审核''';
	  execute immediate 'comment on column BD_CCNOTICE.BSKSSJ is ''资格预审文件递交的时间''';
	  execute immediate 'comment on column BD_CCNOTICE.BSJSSJ is ''澄清与修改文件递交时间''';
	  execute immediate 'comment on column BD_CCNOTICE.STATE is ''状态    1-待提交   2-待审核  3-已审核''';
	  execute immediate 'comment on column BD_CCNOTICE.SQZG is ''申请资格''';
	  execute immediate 'comment on column BD_CCNOTICE.SQYXQ is ''申请有效期''';
	  execute immediate 'comment on column BD_CCNOTICE.BSJSSJSTR is ''申请/投标文件递交截止时间''';
	  execute immediate 'comment on column BD_CCNOTICE.TBWJDJ is ''申请/投标文件递交方法''';
	  execute immediate 'comment on column BD_CCNOTICE.KBSJSTR is ''文件/开标开启时间''';
	  execute immediate 'comment on column BD_CCNOTICE.KQFS is ''文件/开标开启方式''';
	  execute immediate 'comment on column BD_CCNOTICE.PSBF is ''评审办法''';
	  execute immediate 'comment on column BD_CCNOTICE.JYPTYZR is ''交易平台验证人''';
	  execute immediate 'comment on column BD_CCNOTICE.TBRZZ is ''投标资格''';
	  execute immediate 'comment on column BD_CCNOTICE.BZJSUM is ''投标保证金金额''';
	  execute immediate 'comment on column BD_CCNOTICE.BIZ is ''投标保证金币种代码''';
	  execute immediate 'comment on column BD_CCNOTICE.BZJUNIT is ''投标保证金单位''';
	  execute immediate 'comment on column BD_CCNOTICE.QTYP is ''资格审查方式 1-资格预审 2-资格后审''';
	  execute immediate 'comment on column BD_CCNOTICE.GGXZ is ''公告性质 1-正常公告 2-更正公告 9-其他''';
	  execute immediate 'comment on column BD_CCNOTICE.ATYP is ''公告类型 1-招标公告 2-资格预审公告 9-其他''';
	  execute immediate 'comment on column BD_CCNOTICE.DATE1 is ''公告发布时间''';
	  execute immediate 'comment on column BD_CCNOTICE.SHR is ''公告发布责任人''';
	  execute immediate 'comment on column BD_CCNOTICE.GGFBMT is ''公告发布媒体''';
	  execute immediate 'comment on column BD_CCNOTICE.ZBR is ''招标人代码''';
	  execute immediate 'comment on column BD_CCNOTICE.ZBRMC is ''招标人名称''';
	  execute immediate 'comment on column BD_CCNOTICE.DLJGID is ''代理机构代码''';
	  execute immediate 'comment on column BD_CCNOTICE.DIJGNAME is ''代理机构名称''';
	  execute immediate 'comment on column BD_CCNOTICE.OPTID00 is ''新增操作员ID''';
	  execute immediate 'comment on column BD_CCNOTICE.OPTNAME00 is ''新增操作员名称''';
	  execute immediate 'comment on column BD_CCNOTICE.DATE00 is ''新增公告时间''';
	  execute immediate 'comment on column BD_CCNOTICE.OPTID01 is ''审核操作员ID''';
	  execute immediate 'comment on column BD_CCNOTICE.OPTNAME01 is ''审核操作员名称''';
	  execute immediate 'comment on column BD_CCNOTICE.DATE01 is ''审核公告时间''';
    end if;
    
        num:=0; 
    tmp1:=upper('BD_CCNOTICE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_CCNOTICE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
	
    
  --hejw
  tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('DLJG');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(9))';
  execute immediate 'comment on column BD_SUBPROJECT.DLJG is ''代理机构''';
  end if;

  tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('DLJGNAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
  execute immediate 'comment on column BD_SUBPROJECT.DLJGNAME is ''代理机构名称''';
  end if;
  

  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT_DLZQ');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_SUBPROJECT_DLZQ  (
     PKID                 INT                             not null,
     PROBID               VARCHAR2(20),
     DLJG                 VARCHAR2(30),
     DLJGNAME             VARCHAR2(100),
     XMJL                 VARCHAR2(30),
     XMJLNAME             VARCHAR2(100),
     QXID                 VARCHAR2(30),
     constraint PK_BD_SUBPROJECT_DLZQ primary key (PKID)
  )';

  execute immediate ' comment on table BD_SUBPROJECT_DLZQ is ''--招标项目代理职权'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.PKID is ''主键'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.PROBID is ''项目ID'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.DLJG is ''代理机构代码'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.DLJGNAME is ''代理机构名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.XMJL is ''项目经理代码'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.XMJLNAME is ''项目经理名称'' ';
  execute immediate ' comment on column BD_SUBPROJECT_DLZQ.QXID is ''权限编码'' ';
  end if; 
  
    num:=0; 
    tmp1:=upper('BD_SUBPROJECT_DLZQ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_SUBPROJECT_DLZQ_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 
  
  
  
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SUBPROJECT_ZQMX');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
  create table BD_SUBPROJECT_ZQMX  (
     PKID                 int                             not null,
     ZID                  VARCHAR2(10),
     QXID                 VARCHAR2(20)                    not null,
     QXNAME               VARCHAR2(100)                    not null,
     constraint PK_BD_SUBPROJECT_ZQMX primary key (PKID)
  )';

  execute immediate ' comment on table BD_SUBPROJECT_ZQMX is ''招标项目代理职权-职权明细'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ZQMX.PKID is ''自增主键'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ZQMX.ZID is ''权限组id'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ZQMX.QXID is ''权限id'' ';
  execute immediate ' comment on column BD_SUBPROJECT_ZQMX.QXNAME is ''权限对应名称'' ';
    
    end if; 
  
       num:=0; 
    tmp1:=upper('BD_SUBPROJECT_ZQMX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_SUBPROJECT_ZQMX_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 
    
    -- 增加 BD_SUBPROJECT_ITEM
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid_tmp');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
end if;
-- 赋值 tknr_tmp
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid_tmp');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 1 then
execute immediate 'update '||tmp1||' set xmbdwid_tmp = xmbdwid';
end if;
-- 清空 tknr
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 1 then
execute immediate 'update '||tmp1||' set xmbdwid=null';
end if;
-- 修改 tknr
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 1 then
execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(22))';
end if;
-- 赋值 tknr
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 1 then
execute immediate 'update '||tmp1||' set xmbdwid = xmbdwid_tmp';
end if;
-- 删除 tknr_tmp
tmp1:=upper('BD_SUBPROJECT_ITEM');
tmp2:=upper('xmbdwid_tmp');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 1 then
execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
end if;
------------修改有数据字段长度结束----------------------------------------------------
	


--资格预审申请人须知
 num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SQRXZ');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
	create table BD_SQRXZ  (
   PKID                 INT                             not null,
   PACKID               VARCHAR2(23),
   PACKNAME             VARCHAR2(100),
   ZBRMC                VARCHAR2(100),
   ZBR                  VARCHAR2(9),
   ZBRADDR              VARCHAR2(250),
   ZBLXR                VARCHAR2(100),
   ZBLXTEL              VARCHAR2(20),
   DLJGID               VARCHAR2(9),
   DLJGNAME             VARCHAR2(100),
   DLJGADDR             VARCHAR2(250),
   DLJGLXR              VARCHAR2(100),
   DLJGLXTEL            VARCHAR2(20),
   PROBNAME             VARCHAR2(100),
   JSDD                 VARCHAR2(500),
   ZJLY                 VARCHAR2(100),
   CZBL                 VARCHAR2(100),
   ZJLSQQ               VARCHAR2(500),
   ZBFW                 VARCHAR2(500),
   JHGQ                 NUMBER,
   JHKGDATE             DATE,
   JHJGDATE             DATE,
   ZLYQ                 VARCHAR2(250),
   ZZTJ                 VARCHAR2(250),
   CWYQ                 VARCHAR2(250),
   YJYQ                 VARCHAR2(250),
   XYYQ                 VARCHAR2(250),
   XMJLZG               VARCHAR2(250),
   QTYQ                 VARCHAR2(250),
   FLAG1                CHAR(1),
   LHTYQ                VARCHAR2(250),
   SQRCQJZSJ            DATE,
   ZBRCQJZSJ            DATE,
   SQRQRSDSJ            DATE,
   ZBRXGJZSJ            DATE,
   SQRQRXGSJ            DATE,
   SQRBCCL              VARCHAR2(250),
   CWNF                 NUMBER,
   SSZCNF               NUMBER,
   QZYQ                 VARCHAR2(250),
   FBFS                 INT,
   ZDYQ                 VARCHAR2(250),
   KBSJ                 DATE,
   SQJZSJ               DATE,
   DJADDR               VARCHAR2(500),
   FLAG2                CHAR(1),
   SCRS                 INT,
   ZGSCFF               VARCHAR2(500),
   JGTZSJ               DATE,
   JGQRSJ               DATE,
   XBCNR                VARCHAR2(500),
   XMGK                 VARCHAR2(500),
   ZJLYLSQK             VARCHAR2(500),
   ZBFWZL               VARCHAR2(500),
   SQRZGYQ              VARCHAR2(500),
   YYWZ                 VARCHAR2(250),
   FYCD                 VARCHAR2(250),
   ZGYSWJZC             VARCHAR2(500),
   ZGYSWJCQ             VARCHAR2(500),
   ZGYSWJXG             VARCHAR2(500),
   ZGYSSQWJZC           VARCHAR2(500),
   ZGYSSQWJBZ           VARCHAR2(500),
   ZGYSSQWJZD           VARCHAR2(500),
   ZGYSSQWJMF           VARCHAR2(250),
   ZGYSSQWJDJ           VARCHAR2(500),
   SCWYH                VARCHAR2(500),
   ZGSC                 VARCHAR2(500),
   NOTICE               VARCHAR2(500),
   EXPLAIN              VARCHAR2(500),
   CONFIRM              VARCHAR2(500),
   SQRZGGB              VARCHAR2(500),
   YJHL                 VARCHAR2(500),
   GRZGSC               VARCHAR2(500),
   SECRECY              VARCHAR2(500),
   COMPLAIN             VARCHAR2(500),
   BCQTNR               VARCHAR2(500),
   constraint PK_BD_SQRXZ primary key (PKID)
)';

 execute immediate 'comment on table BD_SQRXZ is ''资格预审申请人须知'' ';
 execute immediate 'comment on table BD_SQRXZ is ''资格预审申请人须知'' ';
 execute immediate 'comment on column BD_SQRXZ.PKID is ''主键'' ';
 execute immediate 'comment on column BD_SQRXZ.PACKID is ''标段（包）编号'' ';
 execute immediate 'comment on column BD_SQRXZ.PACKNAME is ''标段（包）名称'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBRMC is ''招标人名称'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBR is ''招标人代码'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBRADDR is ''招标人地址'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBLXR is ''招标联系人'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBLXTEL is ''招标人电话'' ';
 execute immediate 'comment on column BD_SQRXZ.DLJGID is ''代理机构代码'' ';
 execute immediate 'comment on column BD_SQRXZ.DLJGNAME is ''代理机构名称'' ';
 execute immediate 'comment on column BD_SQRXZ.DLJGADDR is ''代理机构地址'' ';
 execute immediate 'comment on column BD_SQRXZ.DLJGLXR is ''代理机构联系人'' ';
 execute immediate 'comment on column BD_SQRXZ.DLJGLXTEL is ''代理机构电话'' ';
 execute immediate 'comment on column BD_SQRXZ.PROBNAME is ''招标项目名称'' ';
 execute immediate 'comment on column BD_SQRXZ.JSDD is ''建设地点'' ';
 execute immediate 'comment on column BD_SQRXZ.ZJLY is ''资金来源'' ';
 execute immediate 'comment on column BD_SQRXZ.CZBL is ''出资比例'' ';
 execute immediate 'comment on column BD_SQRXZ.ZJLSQQ is ''资金落实情况'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBFW is ''招标范围'' ';
 execute immediate 'comment on column BD_SQRXZ.JHGQ is ''计划工期'' ';
 execute immediate 'comment on column BD_SQRXZ.JHKGDATE is ''计划开工日期'' ';
 execute immediate 'comment on column BD_SQRXZ.JHJGDATE is ''计划竣工日期'' ';
 execute immediate 'comment on column BD_SQRXZ.ZLYQ is ''质量要求'' ';
 execute immediate 'comment on column BD_SQRXZ.ZZTJ is ''资质条件'' ';
 execute immediate 'comment on column BD_SQRXZ.CWYQ is ''财务要求'' ';
 execute immediate 'comment on column BD_SQRXZ.YJYQ is ''业绩要求'' ';
 execute immediate 'comment on column BD_SQRXZ.XYYQ is ''信誉要求'' ';
 execute immediate 'comment on column BD_SQRXZ.XMJLZG is ''项目经理(建造师)资格'' ';
 execute immediate 'comment on column BD_SQRXZ.QTYQ is ''其他要求'' ';
 execute immediate 'comment on column BD_SQRXZ.FLAG1 is ''是否接受联合体招标 1- 接受，0 or other 不接受'' ';
 execute immediate 'comment on column BD_SQRXZ.LHTYQ is ''接受联合体招标满足要求'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRCQJZSJ is ''申请人要求澄清资格预审文件的截止时间'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBRCQJZSJ is ''招标人要求澄清资格预审文件的截止时间'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRQRSDSJ is ''申请人确认收到资格预审文件澄清的时间'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBRXGJZSJ is ''招标人修改资格预审文件的截止时间'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRQRXGSJ is ''申请人确认收到资格预审文件修改的时间'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRBCCL is ''申请人需补充的其他材料'' ';
 execute immediate 'comment on column BD_SQRXZ.CWNF is ''近年财务状况的年份要求'' ';
 execute immediate 'comment on column BD_SQRXZ.SSZCNF is ''近年发生的诉讼及仲裁情况的年份要求'' ';
 execute immediate 'comment on column BD_SQRXZ.QZYQ is ''签字或盖章要求'' ';
 execute immediate 'comment on column BD_SQRXZ.FBFS is ''资格预审申请文件副本份数'' ';
 execute immediate 'comment on column BD_SQRXZ.ZDYQ is ''资格预审申请文件装订要求'' ';
 execute immediate 'comment on column BD_SQRXZ.KBSJ is ''开标时间'' ';
 execute immediate 'comment on column BD_SQRXZ.SQJZSJ is ''申请截止时间'' ';
 execute immediate 'comment on column BD_SQRXZ.DJADDR is ''递交资格预审申请文件的地点'' ';
 execute immediate 'comment on column BD_SQRXZ.FLAG2 is ''是否退还资格预审申请文件0-否，1-是'' ';
 execute immediate 'comment on column BD_SQRXZ.SCRS is ''审查委员会人数'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGSCFF is ''资格审查方法'' ';
 execute immediate 'comment on column BD_SQRXZ.JGTZSJ is ''资格预审结果的通知时间'' ';
 execute immediate 'comment on column BD_SQRXZ.JGQRSJ is ''资格预审结果的确认时间'' ';
 execute immediate 'comment on column BD_SQRXZ.XBCNR is ''需补充的其他内容'' ';
 execute immediate 'comment on column BD_SQRXZ.XMGK is ''项目概况'' ';
 execute immediate 'comment on column BD_SQRXZ.ZJLYLSQK is ''资金来源及落实情况'' ';
 execute immediate 'comment on column BD_SQRXZ.ZBFWZL is ''招标范围、计划工期和质量要求'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRZGYQ is ''申请人资格要求'' ';
 execute immediate 'comment on column BD_SQRXZ.YYWZ is ''语言文字'' ';
 execute immediate 'comment on column BD_SQRXZ.FYCD is ''费用承担'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSWJZC is ''资格预审文件的组成'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSWJCQ is ''资格预审文件的澄清'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSWJXG is ''资格预审文件的修改'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSSQWJZC is ''资格预审申请文件的组成'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSSQWJBZ is ''资格预审申请文件的编制要求'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSSQWJZD is ''资格预审申请文件的装订、签字'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSSQWJMF is ''资格预审申请文件的密封和标识'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGYSSQWJDJ is ''资格预审申请文件的递交'' ';
 execute immediate 'comment on column BD_SQRXZ.SCWYH is ''审查委员会'' ';
 execute immediate 'comment on column BD_SQRXZ.ZGSC is ''资格审查'' ';
 execute immediate 'comment on column BD_SQRXZ.NOTICE is ''通知'' ';
 execute immediate 'comment on column BD_SQRXZ.EXPLAIN is ''解释'' ';
 execute immediate 'comment on column BD_SQRXZ.CONFIRM is ''确认'' ';
 execute immediate 'comment on column BD_SQRXZ.SQRZGGB is ''申请人的资格改变'' ';
 execute immediate 'comment on column BD_SQRXZ.YJHL is ''严禁贿赂'' ';
 execute immediate 'comment on column BD_SQRXZ.GRZGSC is ''不得干扰资格审查工作'' ';
 execute immediate 'comment on column BD_SQRXZ.SECRECY is ''保密'' ';
 execute immediate 'comment on column BD_SQRXZ.COMPLAIN is ''投诉'' ';
 execute immediate 'comment on column BD_SQRXZ.BCQTNR is ''需补充其他内容'' ';
 
    end if;

	num:=0; 
    tmp1:=upper('BD_SQRXZ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_SQRXZ_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;  
    
        
    
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag04 is ''备用''';
    end if; 
  
       tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag05');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag05 is ''备用''';
    end if; 
  
       tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag06');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag06 is ''备用''';
    end if; 
  
       tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag07');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag07 is ''备用''';
    end if; 
  
       tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag08');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag08 is ''备用''';
    end if; 
  
       tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag09');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag09 is ''备用''';
    end if; 
  
  tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag10');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag10 is ''备用''';
    end if; 
  
  tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag11');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag11 is ''备用''';
    end if; 
  
  tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag12');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag12 is ''备用''';
    end if; 
  
  tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag13');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag13 is ''备用''';
    end if; 
  
  tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('flag14');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.flag14 is ''备用''';
    end if; 
  

    tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('rwjh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
  execute immediate 'comment on column BD_SUBPROJECT.rwjh is ''工作任务计划''';
  end if;
  
      tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('zzfg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
  execute immediate 'comment on column BD_SUBPROJECT.zzfg is ''项目团队成员组成与职责分工''';
  end if;
  
--投标资料表
 num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_FB_TBZLB');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '  
	  create table BD_FB_TBZLB  (
	   BDID					VARCHAR2(23)                    not null,
	   PROID				VARCHAR2(17)                    not null,
	   PROBID               VARCHAR2(20)                    not null,
	   MBLX                 VARCHAR2(2),
	   HYDM                 VARCHAR2(50),
	   CZYDM                VARCHAR2(30),
	   CDATE                DATE,
	   ZGSHFS               VARCHAR2(2),
	   ZJLSQK               VARCHAR2(200),
	   BIDNAME              VARCHAR2(200),
	   BIDADDR              VARCHAR2(200),
	   BIDLXFS              VARCHAR2(200),
	   ZBFW                 CLOB,
	   JLDW                 VARCHAR2(30),
	   TBYY                 VARCHAR2(30),
	   BJFW                 CLOB,
	   ZGZMWJ               CLOB,
	   BXFA                 VARCHAR2(200),
	   TBBZJXS              VARCHAR2(200),
	   TBBZJAMT             NUMBER(6,2),
	   TBBZJACCOUNT         VARCHAR2(200),
	   BBZJDW               VARCHAR2(80),
	   TBBZJBANK            VARCHAR2(200),
	   TBYXQ                DATE,
	   TBSL                 VARCHAR2(30),
	   ZBWJDJ               VARCHAR2(200),
	   ZBNR                 VARCHAR2(300),
	   TBJZSJ               DATE,
	   DJDD                 VARCHAR2(200),
	   PBBF                 VARCHAR2(200),
	   CPQK                 CLOB,
	   ZBDLFWF              CLOB,
	   constraint PK_BD_FB_TBZLB primary key (BDID)
)';

 execute immediate 'comment on column BD_FB_TBZLB.BDID is''标段宝编号''';
 execute immediate 'comment on column BD_FB_TBZLB.PROID is''总项目编号'''; 
 execute immediate 'comment on column BD_FB_TBZLB.PROBID is''招标项目编号''';
 execute immediate 'comment on column BD_FB_TBZLB.MBLX is''模版类型 1 货物 2服务 3工程''';
 execute immediate 'comment on column BD_FB_TBZLB.HYDM is''创建会员''';
 execute immediate 'comment on column BD_FB_TBZLB.CZYDM is''创建操作员''';
 execute immediate 'comment on column BD_FB_TBZLB.CDATE is''创建时间''';
 execute immediate 'comment on column BD_FB_TBZLB.ZGSHFS is''资格审核方式 1-预审   2-后审''';
 execute immediate 'comment on column BD_FB_TBZLB.ZJLSQK is''资金落实情况''';
 execute immediate 'comment on column BD_FB_TBZLB.BIDNAME is''招标人名称''';
 execute immediate 'comment on column BD_FB_TBZLB.BIDADDR is''招标人地址''';
 execute immediate 'comment on column BD_FB_TBZLB.BIDLXFS is''联系人及联系方式''';
 execute immediate 'comment on column BD_FB_TBZLB.ZBFW is''招标范围''';
 execute immediate 'comment on column BD_FB_TBZLB.JLDW is''国家计量单位''';
 execute immediate 'comment on column BD_FB_TBZLB.TBYY is''投标语言''';
 execute immediate 'comment on column BD_FB_TBZLB.BJFW is''报价范围''';
 execute immediate 'comment on column BD_FB_TBZLB.ZGZMWJ is''证明其中标后能履行合同的资格证明文件''';
 execute immediate 'comment on column BD_FB_TBZLB.BXFA is''备选方案''';
 execute immediate 'comment on column BD_FB_TBZLB.TBBZJXS is''投标保证金的形式''';
 execute immediate 'comment on column BD_FB_TBZLB.TBBZJAMT is''投标保证金的数额''';
 execute immediate 'comment on column BD_FB_TBZLB.TBBZJACCOUNT is''投标保证金开户银行及银行账号''';
 execute immediate 'comment on column BD_FB_TBZLB.BBZJDW is''单位''';
 execute immediate 'comment on column BD_FB_TBZLB.TBBZJBANK is''开户银行''';
 execute immediate 'comment on column BD_FB_TBZLB.TBYXQ is''投标有效期''';
 execute immediate 'comment on column BD_FB_TBZLB.TBSL is''投标文件数量''';
 execute immediate 'comment on column BD_FB_TBZLB.ZBWJDJ is''投标文件递交至''';
 execute immediate 'comment on column BD_FB_TBZLB.ZBNR is''招标编号、标的名称、投标人名称''';
 execute immediate 'comment on column BD_FB_TBZLB.TBJZSJ is''投标截止时间''';
 execute immediate 'comment on column BD_FB_TBZLB.DJDD is''投标文件递交地点''';
 execute immediate 'comment on column BD_FB_TBZLB.PBBF is''评标办法''';
 execute immediate 'comment on column BD_FB_TBZLB.CPQK is''初评后否决投标的情况''';
 execute immediate 'comment on column BD_FB_TBZLB.ZBDLFWF is''招标代理服务费''';
   end if;
   
--投标须知
 num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_FB_TBXZ');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '  
	  create table BD_FB_TBXZ  (
   BDID					VARCHAR2(23)                    not null,
   PROID				VARCHAR2(17)                    not null,
   PROBID               VARCHAR2(20)                    not null,
   MBLX                 VARCHAR2(2),
   HYDM                 VARCHAR2(50),
   CZYDM                VARCHAR2(30),
   CDATE                DATE,
   ZGSHFS               VARCHAR2(2),
   XMGK                 VARCHAR2(200),
   HGTBRFW              VARCHAR2(200),
   TBBD                 VARCHAR2(200),
   TBFY                 VARCHAR2(200),
   ZBWJGC               VARCHAR2(200),
   ZBWJXG               VARCHAR2(200),
   TBWJYY               VARCHAR2(200),
   TBWJDW               VARCHAR2(200),
   TBWJZC               VARCHAR2(200),
   TBH                  VARCHAR2(200),
   TBZM                 VARCHAR2(200),
   BASM                 VARCHAR2(200),
   TBBJ                 VARCHAR2(200),
   SWJSXY               VARCHAR2(200),
   TBRZGZM              VARCHAR2(200),
   TBBDWZM              VARCHAR2(200),
   TBBZJ                VARCHAR2(200),
   TBYXQ                VARCHAR2(200),
   TBWJYS               VARCHAR2(200),
   TBWJBJ               VARCHAR2(200),
   TBWJDJ               VARCHAR2(200),
   TBWJBC               VARCHAR2(200),
   KB                   VARCHAR2(200),
   PBJG                 VARCHAR2(200),
   ZBRQD                VARCHAR2(200),
   LYNLSC               VARCHAR2(200),
   ZBTZS                VARCHAR2(200),
   LYBZJ                VARCHAR2(200),
   ZBDLFWF              VARCHAR2(200),
   TBBZJTH              VARCHAR2(200),
   BMYQ                 VARCHAR2(200),
   JNYQ                 VARCHAR2(200),
   constraint PK_BD_FB_TBXZ primary key (PROBID)
)';
	execute immediate 'comment on column BD_FB_TBXZ.BDID is''标段宝编号''';
	execute immediate 'comment on column BD_FB_TBXZ.PROID is''总项目编号''';
	execute immediate 'comment on column BD_FB_TBXZ.PROBID is''招标项目编号''';
	execute immediate 'comment on column BD_FB_TBXZ.MBLX is''模版类型 1 货物 2服务 3工程''';
	execute immediate 'comment on column BD_FB_TBXZ.HYDM is''创建会员''';
	execute immediate 'comment on column BD_FB_TBXZ.CZYDM is''创建操作员''';
	execute immediate 'comment on column BD_FB_TBXZ.CDATE is''创建时间''';
	execute immediate 'comment on column BD_FB_TBXZ.ZGSHFS is''资格审核方式 1-预审   2-后审''';
	execute immediate 'comment on column BD_FB_TBXZ.XMGK is''项目概况与招标项目当事人''';
	execute immediate 'comment on column BD_FB_TBXZ.HGTBRFW is''合格投标人的范围''';
	execute immediate 'comment on column BD_FB_TBXZ.TBBD is''投标标的''';
	execute immediate 'comment on column BD_FB_TBXZ.TBFY is''投标费用''';
	execute immediate 'comment on column BD_FB_TBXZ.ZBWJGC is''投标文件的编制及构成''';
	execute immediate 'comment on column BD_FB_TBXZ.ZBWJXG is''招标文件的澄清和修改''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJYY is''投标文件语言''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJDW is''投标文件计量单位''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJZC is''投标文件的组成''';
	execute immediate 'comment on column BD_FB_TBXZ.TBH is''投标函''';
	execute immediate 'comment on column BD_FB_TBXZ.TBZM is''投标单位负责人及授权代理人的证明''';
	execute immediate 'comment on column BD_FB_TBXZ.BASM is''签字章、投标专用章等备案说明''';
	execute immediate 'comment on column BD_FB_TBXZ.TBBJ is''投标报价''';
	execute immediate 'comment on column BD_FB_TBXZ.SWJSXY is''商务及技术响应''';
	execute immediate 'comment on column BD_FB_TBXZ.TBRZGZM is''投标人资格证明材料''';
	execute immediate 'comment on column BD_FB_TBXZ.TBBDWZM is''投标标的物合格性证明材料''';
	execute immediate 'comment on column BD_FB_TBXZ.TBBZJ is''投标保证金''';
	execute immediate 'comment on column BD_FB_TBXZ.TBYXQ is''投标有效期''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJYS is''投标文件的式样和签署''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJBJ is''投标文件的密封及标记''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJDJ is''投标文件的递交''';
	execute immediate 'comment on column BD_FB_TBXZ.TBWJBC is''投标文件的补充、修改与撤回''';
	execute immediate 'comment on column BD_FB_TBXZ.KB is''开标''';
	execute immediate 'comment on column BD_FB_TBXZ.PBJG is''评标及结果公示''';
	execute immediate 'comment on column BD_FB_TBXZ.ZBRQD is''中标人的确定''';
	execute immediate 'comment on column BD_FB_TBXZ.LYNLSC is''履约能力审查''';
	execute immediate 'comment on column BD_FB_TBXZ.ZBTZS is''中标通知书''';
	execute immediate 'comment on column BD_FB_TBXZ.LYBZJ is''履约保证金''';
	execute immediate 'comment on column BD_FB_TBXZ.ZBDLFWF is''招标代理服务费''';
	execute immediate 'comment on column BD_FB_TBXZ.TBBZJTH is''投标保证金的退还''';
	execute immediate 'comment on column BD_FB_TBXZ.BMYQ is''保密要求''';
	execute immediate 'comment on column BD_FB_TBXZ.JNYQ is''节能要求''';
   end if;   
   
 --投标须知
 num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_FB_TB_FILE');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '  
	  create table BD_FB_TB_FILE  (
   PKID                 INT                             not null,
   BDID					VARCHAR2(23)                    not null,
   PROID				VARCHAR2(17)                    not null,
   PROBID               VARCHAR2(20)                    not null,
   MBLX                 VARCHAR2(2),
   HYDM                 VARCHAR2(50),
   CZYDM                VARCHAR2(30),
   CDATE                DATE,
   ZGSHFS               VARCHAR2(2),
   TITLE                VARCHAR2(60),
   FILESIZE             NUMBER(10,1),
   FILENAME             VARCHAR2(100),
   FILEPATH             VARCHAR2(100),
   FILETYPE             VARCHAR2(2),
   constraint PK_BD_FB_TB_FILE primary key (PKID)
)';
	execute immediate 'comment on column BD_FB_TB_FILE.PKID is''编号''';
	execute immediate 'comment on column BD_FB_TB_FILE.BDID is''标段宝编号''';
	execute immediate 'comment on column BD_FB_TB_FILE.PROID is''总项目编号''';	
	execute immediate 'comment on column BD_FB_TB_FILE.PROBID is''招标项目编号''';
	execute immediate 'comment on column BD_FB_TB_FILE.MBLX is''模版类型 1 货物 2服务 3工程''';
	execute immediate 'comment on column BD_FB_TB_FILE.HYDM is''创建会员''';
	execute immediate 'comment on column BD_FB_TB_FILE.CZYDM is''创建操作员''';
	execute immediate 'comment on column BD_FB_TB_FILE.CDATE is''创建时间''';
	execute immediate 'comment on column BD_FB_TB_FILE.ZGSHFS is''资格审核方式 1-预审   2-后审''';
	execute immediate 'comment on column BD_FB_TB_FILE.TITLE is''标题''';
	execute immediate 'comment on column BD_FB_TB_FILE.FILESIZE is''文件大小（M）''';
   end if;
 
 	num:=0; 
    tmp1:=upper('BD_FB_TB_FILE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate '
      create sequence BD_FB_TB_FILE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if; 
    
  tmp1:=upper('bd_fb_tbzlb');
  tmp2:=upper('account');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80))';
  execute immediate 'comment on column bd_fb_tbzlb.account is ''账号''';
  end if;     
  
    tmp1:=upper('BD_SQRXZ');
  	tmp2:=upper('LSXMNF');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SQRXZ.LSXMNF is ''近年完成的类似项目的年份要求'' ';
    end if; 
    
    ----tanqinli-start----
    -- SQL升级实例-CREATE TABLE		BD_MB_PSBF--评审办法模板
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PSBF');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PSBF  (
				PACKID               VARCHAR2(23)                    not null,
				MBDM                 VARCHAR2(32)                    not null,
				MBMC                 VARCHAR2(60),
				MBLX                 VARCHAR2(50),
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZGSHFS               VARCHAR2(2),
				ZGYSFF               VARCHAR2(2),
				PSJD                 VARCHAR2(2),
				PSLX                 VARCHAR2(2),
				DESCRIPTION          VARCHAR2(1000),
				FILE01               VARCHAR2(200),
				FILE02               VARCHAR2(200),
				REFSTR01             VARCHAR2(2),
				REFSTR02             VARCHAR2(2),
				constraint PK_BD_MB_PSBF primary key (PACKID, MBDM)		
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PSBF is ''评审办法模板'' ';		
		execute immediate '	comment on column BD_MB_PSBF.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_MB_PSBF.MBDM is ''模版代码'' ';
		execute immediate '	comment on column BD_MB_PSBF.MBMC is ''模版名称'' ';
		execute immediate '	comment on column BD_MB_PSBF.MBLX is ''模板分类  货物类/服务类/工程类'' ';
		execute immediate '	comment on column BD_MB_PSBF.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_MB_PSBF.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_MB_PSBF.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_MB_PSBF.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_MB_PSBF.ZGYSFF is ''资格预审方法 1-合格制 2-有限数量制'' ';		
		execute immediate '	comment on column BD_MB_PSBF.PSJD is ''评审节点 1-约标 2-发标'' ';	
		execute immediate '	comment on column BD_MB_PSBF.PSLX is ''评审类型 1-审查标准 2-评分标准'' ';
		execute immediate '	comment on column BD_MB_PSBF.DESCRIPTION is ''说明'' ';
		execute immediate '	comment on column BD_MB_PSBF.FILE01 is ''附件1'' ';
		execute immediate '	comment on column BD_MB_PSBF.FILE02 is ''附件2'' ';
		execute immediate '	comment on column BD_MB_PSBF.REFSTR01 is ''备用字段1'' ';
		execute immediate '	comment on column BD_MB_PSBF.REFSTR02 is ''备用字段2'' ';		
	end if;
	
	-- BD_MB_PSBF 增加 审查类型 字段
	tmp1:=upper('BD_MB_PSBF');
	tmp2:=upper('sclx');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查类型''';
	end if;
	
	-- SQL升级实例-CREATE TABLE		BD_MB_PSBF_MX--评审办法模板明细
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PSBF_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PSBF_MX  (
				PACKID               VARCHAR2(23)                    not null,
				MBDM                 VARCHAR2(32)                    not null,
				MBXH                 NUMBER(10)                      not null,
				TKNAME               VARCHAR2(100),
				PSYS                 VARCHAR2(100),
				PSBZ                 VARCHAR2(100),
				MINFZ                NUMBER(10,6),
				MAXFZ                NUMBER(10,6),
				constraint PK_评审办法模板明细 primary key (PACKID, MBXH, MBDM)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PSBF_MX is ''评审办法模板明细'' ';		
		execute immediate '	comment on column BD_MB_PSBF_MX.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.MBDM is ''模版代码'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.MBXH is ''模版序号'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.TKNAME is ''条款名称'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.PSYS is ''评审因素'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.PSBZ is ''评审标准'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.MINFZ is ''最小分'' ';
		execute immediate '	comment on column BD_MB_PSBF_MX.MAXFZ is ''最大分'' ';					
	end if;
	
	-- BD_MB_PSBF_MX 增加 是否符合
	tmp1:=upper('BD_MB_PSBF_MX');
	tmp2:=upper('ISACCORD');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否符合''';
	end if;
    
    -- SQL升级实例-CREATE TABLE		BD_FB_PBBZXZ--评标标准及细则
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_PBBZXZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_PBBZXZ  (
			    BDID				VARCHAR2(23)                    not null,
			    PROID				VARCHAR2(17)                    not null,
			    PROBID               VARCHAR2(20)                    not null,
				MBLX                 VARCHAR2(2),
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZGSHFS               VARCHAR2(2),
				ZZ                   VARCHAR2(200),
				PBBF                 VARCHAR2(200),
				PBGCBM               VARCHAR2(200),
				PBCX                 VARCHAR2(200),
				constraint PK_BD_FB_PBBZXZ primary key (BDID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_FB_PBBZXZ is ''评标标准及细则'' ';		
		execute immediate '	comment on column BD_FB_PBBZXZ.BDID is ''标段宝编号'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.PROID is ''总项目编号'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.MBLX is ''模版类型 1 货物 2服务 3工程'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.ZZ is ''总则'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.PBBF is ''评标办法'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.PBGCBM is ''评标过程的保密'' ';
		execute immediate '	comment on column BD_FB_PBBZXZ.PBCX is ''评标程序'' ';
	end if;
	
	-- SQL升级实例-CREATE TABLE		BD_FB_HTYBTK--合同一般条款
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_HTYBTK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_HTYBTK  (
			   BDID					VARCHAR2(23)                    not null,
			   PROID				VARCHAR2(17)                    not null,
			   PROBID               VARCHAR2(20)                    not null,
				MBLX                 VARCHAR2(2),
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZGSHFS               VARCHAR2(2),
				DY                   VARCHAR2(200),
				SYFL                 VARCHAR2(200),
				JSGGYQ               VARCHAR2(200),
				JSZL                 VARCHAR2(200),
				ZSCQ                 VARCHAR2(200),
				LYBZJ                VARCHAR2(200),
				JY                   VARCHAR2(200),
				BZYQ                 VARCHAR2(200),
				ZYBZ                 VARCHAR2(200),
				ZYTZ                 VARCHAR2(200),
				JHFS                 VARCHAR2(200),
				BX                   VARCHAR2(200),
				BSFW                 VARCHAR2(200),
				BJ                   VARCHAR2(200),
				FKFS                 VARCHAR2(200),
				ZLBZ                 VARCHAR2(200),
				SP                   VARCHAR2(200),
				YQJH                 VARCHAR2(200),
				WYPC                 VARCHAR2(200),
				BKKL                 VARCHAR2(200),
				SF                   VARCHAR2(200),
				ZC                   VARCHAR2(200),
				WYZZ                 VARCHAR2(200),
				PCZZ                 VARCHAR2(200),
				ZRFB                 VARCHAR2(200),
				HTXG                 VARCHAR2(200),
				TZ                   VARCHAR2(200),
				HTSX                 VARCHAR2(200),
				constraint PK_BD_FB_HTYBTK primary key (BDID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_FB_HTYBTK is ''合同一般条款'' ';		
		execute immediate '	comment on column BD_FB_HTYBTK.BDID is ''标段包编号'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.PROID is ''总项目编号'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.MBLX is ''模版类型 1 货物 2服务 3工程'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.DY is ''定义'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.SYFL is ''适用法律'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.JSGGYQ is ''技术规格和技术要求'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.JSZL is ''技术资料'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZSCQ is ''知识产权'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.LYBZJ is ''履约保证金'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.JY is ''检验'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.BZYQ is ''包装要求'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZYBZ is ''装运标志'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZYTZ is ''装运通知'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.JHFS is ''交货方式'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.BX is ''保险'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.BSFW is ''伴随服务'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.BJ is ''备件'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.FKFS is ''付款方式'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZLBZ is ''质量保证'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.SP is ''索赔'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.YQJH is ''延期交货'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.WYPC is ''违约赔偿'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.BKKL is ''不可抗力'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.SF is ''税费'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZC is ''仲裁'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.WYZZ is ''违约终止合同'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.PCZZ is ''破产终止合同'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.ZRFB is ''转让和分包'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.HTXG is ''合同修改'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.TZ is ''通知'' ';
		execute immediate '	comment on column BD_FB_HTYBTK.HTSX is ''合同生效及其它'' ';	
							
	end if;
	
	-- SQL升级实例-CREATE TABLE		BD_FB_HTTSTK--合同特殊条款
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_HTTSTK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_HTTSTK  (
			   BDID					VARCHAR2(23)                    not null,
			   PROID				VARCHAR2(17)                    not null,
			   PROBID               VARCHAR2(20)                    not null,
				MBLX                 VARCHAR2(2),
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZGSHFS               VARCHAR2(2),
				BUYNAME              VARCHAR2(30),
				BUYADDR              VARCHAR2(80),
				SELLNAME             VARCHAR2(30),
				SELLADDR             VARCHAR2(80),
				LYBZJ                NUMBER(6,2),
				BIZ                  VARCHAR2(80),
				LYBZJXS              VARCHAR2(80),
				JHFS                 VARCHAR2(80),
				BSFW                 VARCHAR2(300),
				BZ                   CLOB,
				FLAG1                VARCHAR2(30),
				FLAG2                VARCHAR2(30),
				FLAG3                VARCHAR2(30),
				FLAG4                VARCHAR2(30),
				ZBQ                  VARCHAR2(30),
				WXQX                 VARCHAR2(30),
				STZADDR              VARCHAR2(80),
				BTZADDR              VARCHAR2(80),
				constraint PK_BD_FB_HTTSTK primary key (BDID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_FB_HTTSTK is ''合同特殊条款'' ';		
		execute immediate '	comment on column BD_FB_HTTSTK.BDID is ''标段宝编号'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.PROID is ''总项目编号'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.MBLX is ''模版类型 1 货物 2服务 3工程'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BUYNAME is ''买方名称'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BUYADDR is ''买方地址'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.SELLNAME is ''卖方名称'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.SELLADDR is ''卖方地址'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.LYBZJ is ''履约保证金金额'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BIZ is ''履约保证金币种'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.LYBZJXS is ''履约保证金币种'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.JHFS is ''交货方式'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BSFW is ''伴随服务'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BZ is ''备件'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.FLAG1 is ''合同生效后预付合同总额的'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.FLAG2 is ''货物制造完成并运至买方经初步验收合格后付合同总额的'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.FLAG3 is ''货物安装、调试，终验收合格后付合同总额的'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.FLAG4 is ''质保期满后的30天内付合同总额的'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.ZBQ is ''质保期'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.WXQX is ''免费维修与更换缺陷不见的期限'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.STZADDR is ''卖方通知送达地址'' ';
		execute immediate '	comment on column BD_FB_HTTSTK.BTZADDR is ''买方通知送达地址'' ';
							
	end if;
		
	-- SQL升级实例-CREATE TABLE		BD_FB_GHXQJSGG-供货需求及需求规格
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_GHXQJSGG');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_GHXQJSGG  (
			   BDID					VARCHAR2(23)                    not null,
			   PROID				VARCHAR2(17)                    not null,
			   PROBID               VARCHAR2(20)                    not null,
				MBLX                 VARCHAR2(2),
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZGSHFS               VARCHAR2(2),
				TBYQ                 CLOB,
				BNAME                VARCHAR2(80),
				SL                   NUMBER(6,2),
				YT                   VARCHAR2(80),
				JSGGYQ               CLOB,
				JSZL                 CLOB,
				AZTSYS               CLOB,
				SHFWPX               CLOB,
				YSFSBZYQ             CLOB,
				JHSJJHDD             CLOB,
				QTYQ                 CLOB,
				constraint PK_BD_FB_GHXQJSGG primary key (BDID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_FB_GHXQJSGG is ''供货需求及需求规格'' ';	
		execute immediate '	comment on column BD_FB_GHXQJSGG.BDID is ''标段宝编号'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.PROID is ''总项目编号'' ';	
		execute immediate '	comment on column BD_FB_GHXQJSGG.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.MBLX is ''模版类型 1 货物 2服务 3工程'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.TBYQ is ''投标要求'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.BNAME is ''标的名称'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.SL is ''数量'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.YT is ''用途'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.JSGGYQ is ''技术规格及要求'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.JSZL is ''各阶段需提交的技术资料'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.AZTSYS is ''安装、调试及验收'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.SHFWPX is ''售后服务及培训'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.YSFSBZYQ is ''运输方式及包装要求'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.JHSJJHDD is ''交货时间及交货地点'' ';
		execute immediate '	comment on column BD_FB_GHXQJSGG.QTYQ is ''其他要求'' ';			
	end if;
	----tanqinli-end----
	
  tmp1:=upper('bd_fb_tbzlb');
  tmp2:=upper('tbbzjamt');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,2)';
  end if; 
  
  tmp1:=upper('bd_fb_httstk');
  tmp2:=upper('lybzj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,2)';
  end if;  
  
  tmp1:=upper('bd_fb_ghxqjsgg');
  tmp2:=upper('sl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' NUMBER(20,2)';
  end if;
  
  	-- BD_FB_PBBZXZ 增加 附件 字段
	tmp1:=upper('BD_FB_PBBZXZ');
	tmp2:=upper('filestr');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件''';
	end if;
	
	-- SQL升级实例-CREATE TABLE		BD_FB_PBBZ-发标评标标准
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_PBBZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_PBBZ  (
			   BDID					VARCHAR2(23)                    not null,
			   MBDM                 VARCHAR2(32)                    not null,
			   MBMC                 VARCHAR2(60),
			   MBLX                 VARCHAR2(50),
			   HYDM                 VARCHAR2(50),
			   CZYDM                VARCHAR2(30),
			   CDATE                DATE,
			   ZGSHFS               VARCHAR2(2),
			   ZGYSFF               VARCHAR2(2),
			   PSLX                 VARCHAR2(2),
			   REFSTR01             VARCHAR2(2),
			   REFSTR02             VARCHAR2(2),
			   constraint PK_BD_FB_PBBZ primary key (BDID, MBDM)
			)
		';	
		-- 注释			
		execute immediate 'comment on column BD_FB_PBBZ.BDID is''标段宝编号''';
		execute immediate 'comment on column BD_FB_PBBZ.MBDM is''模版代码''';
		execute immediate 'comment on column BD_FB_PBBZ.MBMC is''模版名称''';
		execute immediate 'comment on column BD_FB_PBBZ.MBLX is''招标项目分类 1-货物 2-工程 3-服务''';
		execute immediate 'comment on column BD_FB_PBBZ.HYDM is''创建会员''';
		execute immediate 'comment on column BD_FB_PBBZ.CZYDM is''创建操作员''';
		execute immediate 'comment on column BD_FB_PBBZ.CDATE is''创建时间''';
		execute immediate 'comment on column BD_FB_PBBZ.ZGSHFS is''资格审核方式 1-预审   2-后审''';
		execute immediate 'comment on column BD_FB_PBBZ.ZGYSFF is''资格预审方法 1-合格制 2-有限数量制''';
		execute immediate 'comment on column BD_FB_PBBZ.PSLX is''评审类型 1-审查标准 2-评分标准''';
		execute immediate 'comment on column BD_FB_PBBZ.REFSTR01 is''排序''';
		execute immediate 'comment on column BD_FB_PBBZ.REFSTR02 is''备用字段2''';
	end if;	
	
		-- SQL升级实例-CREATE TABLE		BD_FB_PBBZ-发标评标标准明细
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_FB_PBBZ_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_FB_PBBZ_MX  (
			   BDID               	VARCHAR2(23)                    not null,
			   MBDM                 VARCHAR2(32)                    not null,
			   MBXH                 NUMBER(10)                      not null,
			   TKNAME               VARCHAR2(100),
			   PSYS                 VARCHAR2(100),
			   PSBZ                 VARCHAR2(100),
			   ISACCORD             VARCHAR2(100),
			   MINFZ                NUMBER(10,6),
			   MAXFZ                NUMBER(10,6),
			   FZ                   NUMBER(10,6),
			   constraint PK_BD_FB_PBBZ_MX primary key (BDID, MBDM, MBXH)
			)
		';	
		-- 注释			
			execute immediate 'comment on column BD_FB_PBBZ_MX.BDID is''标段宝编号''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.MBDM is''模版代码''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.MBXH is''模版序号''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.TKNAME is''条款名称''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.PSYS is''评审因素''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.PSBZ is''评审标准''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.ISACCORD is''是否符合''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.MINFZ is''最小分''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.MAXFZ is''最大分''';
			execute immediate 'comment on column BD_FB_PBBZ_MX.FZ is''评分''';
	end if;		
	
	----tanqinli-start----
	-- SQL升级实例-CREATE TABLE		BD_TB_SIGNUP--投标报名
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_TB_SIGNUP');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_TB_SIGNUP  (
				PKID                 INT                             not null,
				PROBID               VARCHAR2(20),
				PACKID               VARCHAR2(23),
				HYDM                 VARCHAR2(30),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				ZBFL                 VARCHAR2(2),
				ZBFS                 VARCHAR2(1),
				ZBZZFS               VARCHAR2(1),
				ZGSHFS               VARCHAR2(2),
				ISYQDW               CHAR(1),
				STATUS               CHAR(1),
				ISYSSIGNON           CHAR(1),
				YSSIGNONDATE         DATE,
				ISTBSIGNON           CHAR(1),
				TBSIGNONDATE         DATE,
				ISTBWJDECRYPT        CHAR(1),
				BSSJ                 varchar2(30),
				ISPAYZGYSWJ          CHAR(1),
				ZGYSWJPAYDATE        DATE,
				ISPAYZBWJ            CHAR(1),
				ZBWJPAYDATE          DATE,
				ISPAYBZJ             CHAR(1),
				BZJPAYDATE           DATE,
				constraint PK_BD_TB_SIGNUP primary key (PKID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_TB_SIGNUP is ''投标报名'' ';		
		execute immediate '	comment on column BD_TB_SIGNUP.PKID is ''主键'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.PROBID is ''招标项目编号'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.HYDM is ''会员代码'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.CZYDM is ''操作员'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZBFL is ''招标项目分类 1-货物 2-工程 3-服务'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZBFS is ''招标方式1-公开招标 2-邀请招标 9-其它'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZBZZFS is ''招标组织方式 1-自行招标 2-委托招标 9-其它'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.BSSJ is ''投标文件/资格预审文件售价'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZGSHFS is ''资格审核方式 1-预审 2-后审'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISYQDW is ''是否是邀请单位 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.STATUS is ''状态 1-已报名 2-报名已确认 3-拒绝报名'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISYSSIGNON is ''是否预审签到 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.YSSIGNONDATE is ''预审签到时间'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISTBSIGNON is ''是否投标签到 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.TBSIGNONDATE is ''投标签到时间'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISTBWJDECRYPT is ''投标文件状态 0-未解密 1-已解密'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISPAYZGYSWJ is ''资格预审文件费用支付情况 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZGYSWJPAYDATE is ''资格预审文件费用支付时间'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISPAYZBWJ is ''招标文件费用支付情况 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ZBWJPAYDATE is ''招标文件费用支付时间'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.ISPAYBZJ is ''保证金支付情况 0-否 1-是'' ';
		execute immediate '	comment on column BD_TB_SIGNUP.BZJPAYDATE is ''保证金支付时间'' ';
	end if;
	-- SQL升级实例-CREATE SEQUENCE
	num:=0;
	tmp1 :=upper('BD_TB_SIGNUP_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'CREATE SEQUENCE BD_TB_SIGNUP_0
		MINVALUE 1
		MAXVALUE 9999999999999999999999999999
		START WITH 1
		INCREMENT BY 1
		NOCACHE
		ORDER
	';
	end if;	
	
	tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('IS_ACCORD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''初审是否符合  0orNull不符合 1-符合''';
    end if; 
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('SCORE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(10,2))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''详审得分 ''';
    end if;
    
    -- BD_TB_SIGNUP 增加 联系人 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('LXR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''联系人''';
	end if;
	-- BD_TB_SIGNUP 增加 联系电话 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('LXTEL');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''联系电话''';
	end if;
	-- BD_TB_SIGNUP 增加 附件路径 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILEPATH0');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件路径''';
	end if;
	-- BD_TB_SIGNUP 增加 附件名称 字段
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('FILENAME0');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
	end if;
	
	----tanqinli-end----


  tmp1:=upper('BD_SUBPROJECT');
  tmp2:=upper('fl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
  execute immediate 'comment on column BD_SUBPROJECT.fl is ''分类1-货物，2-工程，3-服务''';
  end if;
  
  --招标项目 标段（包）  邀请单位
	num:=0; -- 注意：查询前必须初始化此变量
	  tmp1:=upper('BD_PACKAGE_YQDW');
	  select count(1) into num from user_tables where table_name=tmp1;       
	  if num = 0 then
	    -- 建表
	    execute immediate '
	    create table BD_PACKAGE_YQDW  (
	     PKID                 NUMBER                          not null,
	     PROBID               VARCHAR2(20)                    not null,
	     BDID                 VARCHAR2(23)                    not null,
	     DWBM                 VARCHAR2(30)                    not null,
	     DWMC                 VARCHAR2(80),
	     OPT                  VARCHAR2(50),
	     DATE01               DATE,
	     constraint PK_BD_PACKAGE_YQDW primary key (PKID)
	  )';
	
	  execute immediate ' comment on table BD_PACKAGE_YQDW is ''招标项目-  邀请后审-   标段（包）邀请单位'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.PKID is ''主键'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.PROBID is ''招标项目编号'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.BDID is ''标段（包）编号'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.DWBM is ''单位编码-hydm'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.DWMC is ''单位名称'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.OPT is ''操作员'' ';
	  execute immediate ' comment on column BD_PACKAGE_YQDW.DATE01 is ''操作时间'' ';
	 end if; 
 
     num:=0; 
    tmp1:=upper('BD_PACKAGE_YQDW_0');
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

	--mazg 修改兵器平台项目编号（13-200）
	execute immediate 'alter table BD_PROJECT modify prono VARCHAR2(200)';
	
    --xuzhen 公告表添加字段start--
	  tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('bskssjstr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.bskssjstr is ''购买投标文件/资格预审文件开始时间''';
	  end if;
	  
	  tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('bsjssjstr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.bsjssjstr is ''购买标投标文件/资格预审文件结束时间''';
	  end if;
	  
	   tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('jzsjstr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.jzsjstr is ''投标/预审截止时间''';
	  end if;
	  
	   tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('kbsjstr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.kbsjstr is ''开标时间''';
	  end if;
	  
	   tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('date1str');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.date1str is ''公告开始时间''';
	  end if;
	  
	   tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('date2str');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
	  execute immediate 'comment on column BD_ZBGG.date2str is ''公告结束时间''';
	  end if;
	  
	  tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('kqfs');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
	  execute immediate 'comment on column BD_ZBGG.kqfs is ''资格预审文件开启方式''';
	  end if;
    --xuzhen end--
	
	--xuzhen 标段包表添加字段start--
	  tmp1:=upper('BD_PACKAGE');
	  tmp2:=upper('bskssj');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
	  execute immediate 'comment on column BD_PACKAGE.bskssj is ''购买投标文件/资格预审文件开始时间''';
	  end if;
	  
	   tmp1:=upper('BD_PACKAGE');
	  tmp2:=upper('bsjssj');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
	  execute immediate 'comment on column BD_PACKAGE.bsjssj is ''购买标投标文件/资格预审文件结束时间''';
	  end if;
	  
	   tmp1:=upper('BD_PACKAGE');
	  tmp2:=upper('jzsj');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
	  execute immediate 'comment on column BD_PACKAGE.jzsj is ''投标/预审截止时间''';
	  end if;
	  
	  tmp1:=upper('BD_PACKAGE');
	  tmp2:=upper('kbsj');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
	  execute immediate 'comment on column BD_PACKAGE.kbsj is ''开标时间''';
	  end if;
	  
	--xuzhen 标段包表添加字段end--

	--xuzhen 公告表添加字段start--
		tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('sqyxq');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(10) )';
	  execute immediate 'comment on column BD_ZBGG.sqyxq is ''申请有效期''';
	  end if;
	  
	  tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('dljgzbid');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20) )';
	  execute immediate 'comment on column BD_ZBGG.dljgzbid is ''代理机构招标编号''';
	  end if;
	  
	   tmp1:=upper('BD_ZBGG');
	  tmp2:=upper('qtfbmj');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) )';
	  execute immediate 'comment on column BD_ZBGG.qtfbmj is ''其他发布媒体''';
	  end if;
	--xuzhen 公告表添加字段end--
	--mazg start 上次操作时间
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('DATE0');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''上次操作时间''';  
	end if;
	--mazg end

	----tanqinli-start----
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB--评标模板
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB  (
				MBDM                 VARCHAR2(32)                    not null,
				MBMC                 VARCHAR2(60)                    not null,
				MBLX                 VARCHAR2(50)                    not null,
				HYDM                 VARCHAR2(50)                    not null,
				CZYDM                VARCHAR2(30)                    not null,
				CDATE                DATE,
				DESCRIPTION          VARCHAR2(1000),
				FILE01               VARCHAR2(200),
				FILE02               VARCHAR2(200),
				REFSTR01             VARCHAR2(2),
				REFSTR02             VARCHAR2(2),
				constraint PK_BD_MB_PBMB primary key (MBDM)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB is ''评标模板'' ';		
		execute immediate '	comment on column BD_MB_PBMB.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB.MBMC is ''模板名称'' ';
		execute immediate '	comment on column BD_MB_PBMB.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
		execute immediate '	comment on column BD_MB_PBMB.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_MB_PBMB.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_MB_PBMB.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_MB_PBMB.DESCRIPTION is ''说明'' ';
		execute immediate '	comment on column BD_MB_PBMB.FILE01 is ''附件1'' ';
		execute immediate '	comment on column BD_MB_PBMB.FILE02 is ''附件2'' ';
		execute immediate '	comment on column BD_MB_PBMB.REFSTR01 is ''备用字段1'' ';
		execute immediate '	comment on column BD_MB_PBMB.REFSTR02 is ''备用字段2'' ';
	end if;
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB_XZ--评标模板细则
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB_XZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB_XZ  (
				MBDM                 VARCHAR2(32)                    not null,
				MBXH                 INT                             not null,
				XZMC                 VARCHAR2(60)                    not null,
				PSLX                 VARCHAR2(2)                     not null,
				SCLX                 VARCHAR2(2)                     not null,
				ORDERNO              INT,
				constraint PK_BD_MB_PBMB_XZ primary key (MBDM, MBXH)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB_XZ is ''评标模板细则'' ';		
		execute immediate '	comment on column BD_MB_PBMB_XZ.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ.MBXH is ''模板序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ.XZMC is ''细则名称'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ.PSLX is ''评审类型 1-审查标准 2-评分标准'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ.SCLX is ''审查类型 1-初审 2-祥审'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ.ORDERNO is ''排序'' ';
	end if;
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB_XZ_MX_MX--评标模板细则明细
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB_XZ_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB_XZ_MX  (
				MBDM                 VARCHAR2(32)                    not null,
				MBXH                 INT                             not null,
				XZXH                 INT                             not null,
				PSYS                 VARCHAR2(100),
				PSBZ                 VARCHAR2(100),
				ISACCORD             VARCHAR2(100),
				MINFZ                NUMBER(10,6),
				MAXFZ                NUMBER(10,6),
				constraint PK_BD_MB_PBMB_XZ_MX primary key (MBDM, MBXH, XZXH)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB_XZ_MX is ''评标模板细则明细'' ';		
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.MBXH is ''模板序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.XZXH is ''细则序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.PSYS is ''评审因素'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.PSBZ is ''评审标准'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.ISACCORD is ''是否符合'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.MINFZ is ''最小分'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX.MAXFZ is ''最大分'' ';
	end if;
	
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB_BAK--评标模板-标段（包）
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB_BAK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB_BAK  (
				PKID                 INT                             not null,
				PACKID               VARCHAR2(23)                    not null,
				MBDM                 VARCHAR2(32)                    not null,
				MBMC                 VARCHAR2(60)                    not null,
				MBLX                 VARCHAR2(50)                    not null,
				HYDM                 VARCHAR2(50),
				CZYDM                VARCHAR2(30),
				CDATE                DATE,
				DESCRIPTION          VARCHAR2(1000),
				FILE01               VARCHAR2(200),
				FILE02               VARCHAR2(200),
				REFSTR01             VARCHAR2(2),
				REFSTR02             VARCHAR2(2),
				constraint PK_BD_MB_PBMB_BAK primary key (PKID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB_BAK is ''评标模板-标段（包）'' ';		
		execute immediate '	comment on column BD_MB_PBMB_BAK.PKID is ''主键，自增'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.MBMC is ''模板名称'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.HYDM is ''创建会员'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.CZYDM is ''创建操作员'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.CDATE is ''创建时间'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.DESCRIPTION is ''说明'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.FILE01 is ''附件1'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.FILE02 is ''附件2'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.REFSTR01 is ''备用字段1'' ';
		execute immediate '	comment on column BD_MB_PBMB_BAK.REFSTR02 is ''备用字段2'' ';
	end if;
	-- SQL升级实例-CREATE SEQUENCE
	num:=0;
	tmp1 :=upper('BD_MB_PBMB_BAK_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'CREATE SEQUENCE BD_MB_PBMB_BAK_0
		MINVALUE 1
		MAXVALUE 9999999999999999999999999999
		START WITH 1
		INCREMENT BY 1
		NOCACHE
		ORDER
	';
	end if;
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB_XZ_BAK_BAK--评标模板细则-标段（包）
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB_XZ_BAK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB_XZ_BAK  (
				PKID                 INT                             not null,
				PACKID               VARCHAR2(23)                    not null,
				MBDM                 VARCHAR2(32)                    not null,
				MBXH                 INT                             not null,
				MBLX                 VARCHAR2(50)                    not null,
				XZMC                 VARCHAR2(60)                    not null,
				PSLX                 VARCHAR2(2)                     not null,
				SCLX                 VARCHAR2(2)                     not null,
				ORDERNO              INT,
				constraint PK_BD_MB_PBMB_XZ_BAK primary key (PKID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB_XZ_BAK is ''评标模板细则-标段（包）'' ';		
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.PKID is ''主键，自增'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.MBXH is ''模板序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.XZMC is ''细则名称'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.PSLX is ''评审类型 1-审查标准 2-评分标准'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.SCLX is ''审查类型 1-初审 2-祥审'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_BAK.ORDERNO is ''排序'' ';
	end if;
	-- SQL升级实例-CREATE SEQUENCE
	num:=0;
	tmp1 :=upper('BD_MB_PBMB_XZ_BAK_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'CREATE SEQUENCE BD_MB_PBMB_XZ_BAK_0
		MINVALUE 1
		MAXVALUE 9999999999999999999999999999
		START WITH 1
		INCREMENT BY 1
		NOCACHE
		ORDER
	';
	end if;
	-- SQL升级实例-CREATE TABLE		BD_MB_PBMB_XZ_MX_BAK_BAK--评标模板细则明细-标段（包）
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_MB_PBMB_XZ_MX_BAK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
			create table BD_MB_PBMB_XZ_MX_BAK  (
				PKID                 INT                             not null,
				PACKID               VARCHAR2(23)                    not null,
				MBDM                 VARCHAR2(32)                    not null,
				MBXH                 INT                             not null,
				XZXH                 INT                             not null,
				MBLX                 VARCHAR2(50)                    not null,
				PSYS                 VARCHAR2(100),
				PSBZ                 VARCHAR2(100),
				ISACCORD             VARCHAR2(100),
				MINFZ                NUMBER(10,6),
				MAXFZ                NUMBER(10,6),
				constraint PK_BD_MB_PBMB_XZ_MX_BAK primary key (PKID)
			)
		';	
		-- 注释			
		execute immediate ' comment on table BD_MB_PBMB_XZ_MX_BAK is ''评标模板细则明细-标段（包）'' ';		
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.PKID is ''主键，自增'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.PACKID is ''标段（包）编号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.MBDM is ''模板代码'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.MBXH is ''模板序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.XZXH is ''细则序号'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.PSYS is ''评审因素'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.PSBZ is ''评审标准'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.ISACCORD is ''是否符合'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.MINFZ is ''最小分'' ';
		execute immediate '	comment on column BD_MB_PBMB_XZ_MX_BAK.MAXFZ is ''最大分'' ';
	end if;
	-- SQL升级实例-CREATE SEQUENCE
	num:=0;
	tmp1 :=upper('BD_MB_PBMB_XZ_MX_BAK_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	execute immediate 'CREATE SEQUENCE BD_MB_PBMB_XZ_MX_BAK_0
		MINVALUE 1
		MAXVALUE 9999999999999999999999999999
		START WITH 1
		INCREMENT BY 1
		NOCACHE
		ORDER
	';
	end if;
		
	----tanqinli-end----

	----mazg start----
	-- 国拨资金百分比
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('ZJBFB');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,1) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''国拨资金百分比''';  
	end if;
	-- 债务资金百分比
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('ZJBFB1');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,1) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''债务资金百分比''';  
	end if;
	-- 自有资金百分比
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('ZJBFB2');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,1) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自有资金百分比''';  
	end if;
	-- 其他资金百分比
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('ZJBFB3');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,1) )';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他资金百分比''';  
	end if;
	--修改资金来源描述
	tmp1:=upper('BD_PROJECT');
	tmp2:=upper('ZJLY');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资金来源（0-国拨资金 1-债务资金 2-自有资金 3-其他资金）''';
	end if;
	
 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_TD_DD');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
	create table BD_TD_DD  (
	   DDHM                 VARCHAR(30)                     not null,
	   BDID                 VARCHAR(23),
	   BDNAME               VARCHAR(200),
	   FL                   VARCHAR(10),
	   MONEY                NUMBER(20,2),
	   FLAG1                VARCHAR(1),
	   STATUS               VARCHAR(1),
	   DATE1                DATE,
	   DATE2                DATE,
	   DATE3                DATE,
	   HYDM                 VARCHAR(30),
	   HYNAME               VARCHAR(250),
	   FYLY                 VARCHAR(1),
	   constraint PK_BD_TD_DD primary key (DDHM)
	)
		';
-- 注释	
		execute immediate 'comment on table BD_TD_DD is ''购买文件的订单'' ';
		execute immediate 'comment on column BD_TD_DD.DDHM is ''订单号码'' ';
		execute immediate 'comment on column BD_TD_DD.BDID is ''标段包编码'' ';
		execute immediate 'comment on column BD_TD_DD.BDNAME is ''标段包名称'' ';
		execute immediate 'comment on column BD_TD_DD.FL is ''分类(1-货物 2-工程 3-服务)'' ';
		execute immediate 'comment on column BD_TD_DD.MONEY is ''金额'' ';
		execute immediate 'comment on column BD_TD_DD.FLAG1 is ''支付状态（0-未提交 1-已提交 2-已支付）'' ';
		execute immediate 'comment on column BD_TD_DD.STATUS is ''状态（0-待预审 1-待招标）'' ';
		execute immediate 'comment on column BD_TD_DD.DATE1 is ''创建时间'' ';
		execute immediate 'comment on column BD_TD_DD.DATE2 is ''提交时间'' ';
		execute immediate 'comment on column BD_TD_DD.DATE3 is ''支付时间'' ';
		execute immediate 'comment on column BD_TD_DD.HYDM is ''会员代码'' ';
		execute immediate 'comment on column BD_TD_DD.HYNAME is ''会员名称'' ';
		execute immediate 'comment on column BD_TD_DD.FYLY is ''费用来源（1-资格预审文件 2-招标文件）'' ';

	end if; 
	
	--bdtddd表中添加两个字段
	tmp1:=upper('BD_TD_DD');
  	tmp2:=upper('HZDM');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方会员代码''';
    end if; 
    
    tmp1:=upper('BD_TD_DD');
  	tmp2:=upper('HZNAME');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(250))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方会员名称''';
    end if; 
---mazg end----

	
	
	--hejw 招标项目 -------start-----
 tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('qtsx');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.qtsx is ''代理机构权限  其他事项''';
    end if; 

    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('opt01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.opt01 is ''招标项目委托协议编制 签章提交 操作人''';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('date01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.date01 is ''招标项目委托协议编制  签章提交  时间''';
    end if; 
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('xmjlpost');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.xmjlpost is ''代表人职务 代理机构''';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('lxr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.lxr is ''招标方 代表人代码''';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('lxrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(180))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.lxrname is ''招标方 代表人名称''';
    end if;  
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('lxrpost');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.lxrpost is ''招标方 代表人职务''';
    end if;    
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('lxrlxfs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(20))';
      execute immediate 'comment on column BD_SUBPROJECT_EXT.lxrlxfs is ''招标方 代表人联系方式''';
    end if;   
--hejw 招标项目 -------end-----


--hejw 修改字段长度 start--------
	
	tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('STATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column BD_SUBPROJECT.STATUS is ''招标项目状态''';
    end if; 
--hejw 修改字段长度 end--------
---hejw--增加委托字段---start------
  tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('wtdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80))';
      execute immediate 'comment on column Bd_Subproject_Ext.wtdd is ''委托地点''';
    end if; 
   
  tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('WTSJ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column Bd_Subproject_Ext.WTSJ is ''委托时间''';
    end if;  
---hejw--增加委托字段---end------

  tmp1:=upper('Bd_Package');
  tmp2:=upper('flag01');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
  execute immediate 'comment on column Bd_Package.flag01 is ''是否选择模板  other未选择   1-已选择'''; 
  end if; 

	--add by longf start ---
	-- 删除 nickname
	tmp1:=upper('BD_JURY_MEMBER');
	tmp2:=upper('NICKNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
    
	tmp1:=upper('BD_JURY');
  	tmp2:=upper('KBADDR');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点''';
    end if;
    
	tmp1:=upper('BD_JURY');
  	tmp2:=upper('BDADDR');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点''';
    end if;
    
	tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('AGE');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(6))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''年龄''';
    end if;
    
	tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('JSZC');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术职称''';
    end if;
    
	tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('SAMPLE_TIME');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''抽取次数 1-第一轮 2-第二轮''';
    end if;
    
	tmp1:=upper('BD_JURY_MEMBER');
  	tmp2:=upper('ZJQDFS');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确定方式 1-指定 2-随机抽取''';
    end if;
	--add by longf end ---
	

  -------------------------------------------------------------
end;