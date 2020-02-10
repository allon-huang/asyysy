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

   -------------add by songw 2017年8月22日 start-----------------
   -- 增加投标方是否下载过招标文件的标记（用于更新节点）
   tmp1:=upper('bd_tb_signup');
   tmp2:=upper('DOWNLOADZBWJFLAG');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' CHAR(1))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否下载过招标文件 1-是''';
   end if;
   -------------add by songw 2017年8月22日 end-----------------
------------add by lijb 2017年8月21日 start-------------
    -- 终止公告相关字段
    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ZZGGHYDM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止公告-编制保存-会员编号'''; 
    end if;
    ------------add by lijb 2017年8月21日 end---------------

    ------------add by hejw 2017年8月24日 start---------------
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散操作员''';
    end if; 
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散操作员名称''';
    end if; 
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散时间''';
    end if; 
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDREMARK');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(400))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散备注''';
    end if; 
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散上传文件路径''';
    end if; 
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('DISBANDFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解散上传文件原文件名称''';
    end if; 
    ------------add by hejw 2017年8月24日 end---------------


    -------------add by songw 2017年8月23日 start----------------
    -- 增加招标文件参数设置最高投标限价类型 1 or null-统一设置 2-分标段（包）设置
    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('TBXJTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CHAR(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高投标限价类型 1 or null-统一设置 2-分标段（包）设置'''; 
    end if;
    -------------add by songw 2017年8月23日 end----------------
   
    -------------add by songw 2017年8月25日 start----------------
    -- 新增常用银行信息
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_COMMON_BANK');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_COMMON_BANK  (
           PKID                 NUMBER                          not null,
           HYDM                 VARCHAR2(30),
           KHZH                 VARCHAR2(30),
           KHNAME               VARCHAR2(150),
           KHBKNO               VARCHAR(30),
           KHBANK               VARCHAR2(80),
           DEFAULTFLAG          INTEGER,
           CDATE                DATE,
           OPTUSERID            VARCHAR2(60),
           OPTUSERNAME          VARCHAR2(60),
           OPTDEPID             VARCHAR2(60),
           TYPE                 INTEGER,
           SUBSYSTEM            VARCHAR2(30),
           constraint PK_BD_COMMON_BANK primary key (PKID)
        )';

        execute immediate 'comment on table BD_COMMON_BANK is ''常用银行信息''';
        execute immediate 'comment on column BD_COMMON_BANK.PKID is ''自增主键''';
        execute immediate 'comment on column BD_COMMON_BANK.HYDM is ''会员代码''';
        execute immediate 'comment on column BD_COMMON_BANK.KHZH is ''银行帐号''';
        execute immediate 'comment on column BD_COMMON_BANK.KHNAME is ''开户名''';
        execute immediate 'comment on column BD_COMMON_BANK.KHBKNO is ''开户支行联行号''';
        execute immediate 'comment on column BD_COMMON_BANK.KHBANK is ''开户银行''';
        execute immediate 'comment on column BD_COMMON_BANK.DEFAULTFLAG is ''是否为默认常用银行 1-是''';
        execute immediate 'comment on column BD_COMMON_BANK.CDATE is ''创建时间''';
        execute immediate 'comment on column BD_COMMON_BANK.OPTUSERID is ''操作员userid''';
        execute immediate 'comment on column BD_COMMON_BANK.OPTUSERNAME is ''操作员名称''';
        execute immediate 'comment on column BD_COMMON_BANK.OPTDEPID is ''操作员部门编号''';
        execute immediate 'comment on column BD_COMMON_BANK.TYPE is ''常用银行信息引用类型 1-转出提现''';
        execute immediate 'comment on column BD_COMMON_BANK.SUBSYSTEM is ''子平台系统标识''';
    end if;

    num:=0;
    tmp1:=upper('BD_COMMON_BANK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_COMMON_BANK_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    -------------add by songw 2017年8月25日 end----------------
   
   --------------add by songw 2017年8月28日 start-------------
   -- 资金流水增加入金流水备注字段
   tmp1:=upper('BD_IN_OUT_AMT');
   tmp2:=upper('RJLSBZ');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''入金流水备注''';
   end if; 
   --------------add by songw 2017年8月28日 end-------------
   --------------add by hejw 2017年8月30日 start-------------
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('CHTML');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已生成 静态html''';
    end if; 
    
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('REASON2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异常原因''';
    end if; 
   --------------add by hejw 2017年8月30日 end-------------
   
   ------------add by lijb 2017年9月12日 start-------------
    -- 终止公告相关字段
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('YCFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异常附件'''; 
    end if;
    ------------add by lijb 2017年9月12日 end---------------
	------------add by lijb 2017年9月18日 start-------------	
	--新增专家信息关联表
	num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_ZJ_RELATE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EXPERT_ZJ_RELATE
        (
          PKID                 INT                             not null,
          ZJDM                 VARCHAR2(17),
          JSZC                 VARCHAR2(50),
          ZSBH                 VARCHAR2(200),
          ZYZGXL               VARCHAR2(50),
          ZYZGDJ               VARCHAR2(50),
          ZCDJZSBH             VARCHAR2(200),
          CERTFILE             VARCHAR2(200),
          CERTFILENAME         VARCHAR2(200),
          INFOTYPE                VARCHAR2(10),
          CDATE                DATE,
          constraint PK_BD_EXPERT_ZJ_RELATE primary key (PKID)
        )';
        execute immediate 'comment on table BD_EXPERT_ZJ_RELATE is ''专家信息关联表''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.PKID is''自增主键''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.ZJDM is''专家代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.JSZC is''技术职称''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.ZSBH is''职称证书编号/职业资格证书编号''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.ZYZGXL is''职业资格序列''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.ZYZGDJ is''职业资格等级''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.ZCDJZSBH is''注册登记证书编号''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.CERTFILE is''证书文件上传''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.CERTFILENAME is''证书文件原名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.INFOTYPE is''信息类型:1,职称信息2,职业资格信息''';
        execute immediate 'comment on column BD_EXPERT_ZJ_RELATE.CDATE is''创建时间''';
    end if;
    
    num:=0;
    tmp1:=upper('BD_EXPERT_ZJ_RELATE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_EXPERT_ZJ_RELATE_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    
    --新增专家自荐表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_ZJ');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EXPERT_ZJ
        (
          ZJDM                 VARCHAR2(17)                    not null,
          ZJMC                 VARCHAR2(100),
          AGE                  NUMBER(6),
          CDATE                DATE,
          BIRTH_DATE           DATE,
          SEX                  CHAR(1),
          CARD_TYPE            CHAR(2),
          CARD_NUM             VARCHAR2(18),
          LXTEL                VARCHAR2(100),
          DQ_CODE1             VARCHAR2(6),
          DQ_NAME1             VARCHAR2(30),
          DQ_CODE2             VARCHAR2(6),
          DQ_NAME2             VARCHAR2(30),
          DQ_CODE3             VARCHAR2(6),
          DQ_NAME3             VARCHAR2(30),
          EMAIL                VARCHAR2(100),
          ADDRESS              VARCHAR2(100),
          POSTCODE             VARCHAR2(6),
          CZYDM                VARCHAR2(30),
          UNIT_NAME            VARCHAR2(100),
          POSITION             VARCHAR2(50),
          RESUME               CLOB,
          LASTSCHOOL           VARCHAR2(100),
          DEGREE               VARCHAR2(30),
          MAJOR                VARCHAR2(1000),
          WORK_YEARS             NUMBER(2),
          HYDM                 VARCHAR2(50),
          ZJLY                 NUMBER(10),
          IS_JOB               VARCHAR2(1),
          BONUS_MALUS          CLOB,
          QYFLAG               VARCHAR2(10),
          XLZSBH               VARCHAR2(200),
          ZJBH                 VARCHAR2(18),
          CARD_NUM_TMP         VARCHAR2(18),
          ORIGIN               VARCHAR2(200),
          IDCARDFILE           VARCHAR2(200),
          CREDITCODE           VARCHAR2(20),
          GRADUATIONDATE       DATE,
          DIPLOMAFILE          VARCHAR2(200),
          MAJORINSTUDY         VARCHAR2(100),
          NOWMAJOR             VARCHAR2(100),
          WORKTEL              VARCHAR2(20),
          HOMETEL              VARCHAR2(20),
          FAX                  VARCHAR2(20),
          STATE                VARCHAR2(10),
          RESTEL               VARCHAR2(50),
          AUDITOR              VARCHAR2(50),
          AUDITDATE            DATE,
          REMARKS              VARCHAR2(400),
          SUBSYSTEM			   VARCHAR2(30),
          USERNAME			   VARCHAR2(30),
          PASSWORD			   VARCHAR2(100),
          constraint PK_BD_EXPERT_ZJ primary key (ZJDM)
        )';
        execute immediate 'comment on table BD_EXPERT_ZJ is ''自荐专家信息表''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ZJDM is ''专家代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ZJMC is ''专家名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ.AGE is ''年龄''';
        execute immediate 'comment on column BD_EXPERT_ZJ.CDATE is ''创建日期''';
        execute immediate 'comment on column BD_EXPERT_ZJ.BIRTH_DATE is ''出生年月日YYYYMMDD''';
        execute immediate 'comment on column BD_EXPERT_ZJ.SEX is ''性别 1-男性 2-女性''';
        execute immediate 'comment on column BD_EXPERT_ZJ.CARD_TYPE is ''证件类型 01-身份证''';
        execute immediate 'comment on column BD_EXPERT_ZJ.CARD_NUM is ''证件号码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.LXTEL is ''联系电话''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_CODE1 is ''省代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_NAME1 is ''省名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_CODE2 is ''市代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_NAME2 is ''市名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_CODE3 is ''县代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DQ_NAME3 is ''县名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ.EMAIL is ''邮箱地址''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ADDRESS is ''详细地址''';
        execute immediate 'comment on column BD_EXPERT_ZJ.POSTCODE is ''邮政编码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.CZYDM is ''操作员代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.UNIT_NAME is ''所在单位名称''';
        execute immediate 'comment on column BD_EXPERT_ZJ.POSITION is ''职务''';
        execute immediate 'comment on column BD_EXPERT_ZJ.RESUME is ''工作简历''';
        execute immediate 'comment on column BD_EXPERT_ZJ.LASTSCHOOL is ''毕业院校''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DEGREE is ''学历''';
        execute immediate 'comment on column BD_EXPERT_ZJ.MAJOR is ''专业''';
        execute immediate 'comment on column BD_EXPERT_ZJ.WORK_YEARS is ''从业年限（工龄）''';
        execute immediate 'comment on column BD_EXPERT_ZJ.HYDM is ''会员代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ZJLY is ''专家来源  平台库/公共库/自荐''';
        execute immediate 'comment on column BD_EXPERT_ZJ.IS_JOB is ''是否在职 1-是 0-否''';
        execute immediate 'comment on column BD_EXPERT_ZJ.BONUS_MALUS is ''奖惩记录''';
        execute immediate 'comment on column BD_EXPERT_ZJ.QYFLAG is ''专家是否启用标志  0-暂停 1-启用''';
        execute immediate 'comment on column BD_EXPERT_ZJ.XLZSBH is ''学历证书编号''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ZJBH is ''专家编号，编码长度为18''';
        execute immediate 'comment on column BD_EXPERT_ZJ.ORIGIN is ''专家来源''';
        execute immediate 'comment on column BD_EXPERT_ZJ.IDCARDFILE is ''身份证件上传''';
        execute immediate 'comment on column BD_EXPERT_ZJ.CREDITCODE is ''统一社会信用代码''';
        execute immediate 'comment on column BD_EXPERT_ZJ.GRADUATIONDATE is ''毕业时间''';
        execute immediate 'comment on column BD_EXPERT_ZJ.DIPLOMAFILE is ''学历证书上传''';
        execute immediate 'comment on column BD_EXPERT_ZJ.MAJORINSTUDY is ''所学专业''';
        execute immediate 'comment on column BD_EXPERT_ZJ.NOWMAJOR is ''现从事专业''';
        execute immediate 'comment on column BD_EXPERT_ZJ.WORKTEL is ''单位电话''';
        execute immediate 'comment on column BD_EXPERT_ZJ.HOMETEL is ''家庭电话''';
        execute immediate 'comment on column BD_EXPERT_ZJ.FAX is ''传真''';
        execute immediate 'comment on column BD_EXPERT_ZJ.STATE is ''状态''';
        execute immediate 'comment on column BD_EXPERT_ZJ.RESTEL is ''备用联系信息''';
        execute immediate 'comment on column BD_EXPERT_ZJ.AUDITOR is ''审核人''';
        execute immediate 'comment on column BD_EXPERT_ZJ.AUDITDATE is ''审核时间''';
        execute immediate 'comment on column BD_EXPERT_ZJ.REMARKS is ''审核原因''';
        execute immediate 'comment on column BD_EXPERT_ZJ.SUBSYSTEM is ''子平台标识-表示是哪个子平台的数据''';
        execute immediate 'comment on column BD_EXPERT_ZJ.USERNAME is ''登陆帐号''';
        execute immediate 'comment on column BD_EXPERT_ZJ.PASSWORD is ''登陆密码''';
    end if;
    
    --新增专家信息关联表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_RELATE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EXPERT_RELATE
        (
          PKID                 INT                             not null,
          ZJDM                 VARCHAR2(17),
          JSZC                 VARCHAR2(50),
          ZSBH                 VARCHAR2(200),
          ZYZGXL               VARCHAR2(50),
          ZYZGDJ               VARCHAR2(50),
          ZCDJZSBH             VARCHAR2(200),
          CERTFILE             VARCHAR2(200),
          CERTFILENAME         VARCHAR2(200),
          INFOTYPE                 VARCHAR2(10),
          CDATE                DATE,
          constraint PK_BD_EXPERT_RELATE primary key (PKID)
        )';
        execute immediate 'comment on table BD_EXPERT_RELATE is ''专家信息关联表''';
        execute immediate 'comment on column BD_EXPERT_RELATE.PKID is''自增主键''';
        execute immediate 'comment on column BD_EXPERT_RELATE.ZJDM is''专家代码''';
        execute immediate 'comment on column BD_EXPERT_RELATE.JSZC is''技术职称''';
        execute immediate 'comment on column BD_EXPERT_RELATE.ZSBH is''职称证书编号/职业资格证书编号''';
        execute immediate 'comment on column BD_EXPERT_RELATE.ZYZGXL is''职业资格序列''';
        execute immediate 'comment on column BD_EXPERT_RELATE.ZYZGDJ is''职业资格等级''';
        execute immediate 'comment on column BD_EXPERT_RELATE.ZCDJZSBH is''注册登记证书编号''';
        execute immediate 'comment on column BD_EXPERT_RELATE.CERTFILE is''证书文件上传''';
        execute immediate 'comment on column BD_EXPERT_RELATE.CERTFILENAME is''证书文件原名称''';
        execute immediate 'comment on column BD_EXPERT_RELATE.INFOTYPE is''信息类型:1,职称信息2,职业资格信息''';
        execute immediate 'comment on column BD_EXPERT_RELATE.CDATE is''创建时间''';
    end if;
    
    num:=0;
    tmp1:=upper('BD_EXPERT_RELATE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_EXPERT_RELATE_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
	------------add by lijb 2017年9月18日 end---------------
	------------add by jinyanhui 2017年9月21日 start---------------
   -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_POST_QUEUE');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_POST_QUEUE  (
       ID                   NUMBER(20)                      not null,
       FPHM                 VARCHAR2(30),
       TYPE                 NUMBER(6),
       RQDATE               DATE,
       SENDDATE             DATE,
       SUCCESSDATE          DATE,
       STATUS               NUMBER(6),
       ERRMSG               VARCHAR2(300),
       MSGTIMES             NUMBER(6),
       CALLBACKURL          VARCHAR2(300),
       CALLBACKPARAM        VARCHAR2(300),
       SUBSYSTEM          VARCHAR2(100),
       constraint PK_BD_POST_QUEUE primary key (ID)
    )
    ';

    execute immediate 'comment on table BD_POST_QUEUE is ''消息通知队列''';
    execute immediate 'comment on column BD_POST_QUEUE.ID is ''队列号''';
    execute immediate 'comment on column BD_POST_QUEUE.FPHM is ''单据号码''';
    execute immediate 'comment on column BD_POST_QUEUE.TYPE is ''通知类型（1 - 招标公告通知，2 - 结果公告通知，3 - 投标邀请书通知，4 - 合同数据传输通知）''';
    execute immediate 'comment on column BD_POST_QUEUE.RQDATE is ''请求通知时间''';
    execute immediate 'comment on column BD_POST_QUEUE.SENDDATE is ''发送通知时间''';
    execute immediate 'comment on column BD_POST_QUEUE.SUCCESSDATE is ''消息通知成功时间''';
    execute immediate 'comment on column BD_POST_QUEUE.STATUS is ''状态：1 - 待发送，2 - 发送成功，3 - 发送失败''';
    execute immediate 'comment on column BD_POST_QUEUE.ERRMSG is ''错误消息''';
    execute immediate 'comment on column BD_POST_QUEUE.MSGTIMES is ''发送次数''';
    execute immediate 'comment on column BD_POST_QUEUE.CALLBACKURL is ''消息回调通知地址''';
    execute immediate 'comment on column BD_POST_QUEUE.CALLBACKPARAM is ''消息回调通知参数（json数据）''';
    execute immediate 'comment on column BD_POST_QUEUE.SUBSYSTEM is ''子系统标识''';
  end if;
  
	num:=0; 
    tmp1:=upper('BD_POST_QUEUE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate 'create sequence BD_POST_QUEUE_0 
			minvalue 1
			maxvalue 9999999999999999999999999999
			start with 1
			increment by 1
			nocache
			order
	  ';
	end if; 
	
	-- 标段包-中标候选人公示人数
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('HXRGSRS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示人数'''; 
    end if;
    
    -- 标段包-是否框架协议
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('AGREEMENT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否框架协议'''; 
    end if;
    
    -- 招标项目-是否框架协议
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('AGREEMENT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否框架协议'''; 
    end if;    
	------------add by jinyanhui 2017年9月21日 end---------------   
	------------add by hejw 2017年9月23日 start---------------   
    tmp1:=upper('BD_EXPERT_ZJ');
    tmp2:=upper('SMSCODE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''重置密码短信验证码'''; 
    end if; 
	------------add by hejw 2017年9月23日 end---------------   
	------------add by lijb 2017年9月26日 start---------------   
    tmp1:=upper('BD_EXPERT_ZJ');
    tmp2:=upper('TELCODE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改手机号短信验证码'''; 
    end if; 
	------------add by lijb 2017年9月26日 end--------------- 
	tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('YCLY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' Integer';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异常来源 1-评标终止'''; 
    end if; 
 
 	tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('STOPLY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' Integer';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止来源 1-评标终止'''; 
    end if; 
    ------------add by lijb 2017年9月27日 start---------------   
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('YCFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异常附件原名称'''; 
    end if; 
	------------add by lijb 2017年9月27日 end--------------- 
	
	-------------------------add by lijb 2017年10月11日 start-----------------
   	-- 修改 CARD_NUM 字段长度
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('CARD_NUM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT_ZJ modify( CARD_NUM VARCHAR2(30))';
	end if;	
	-- 修改 CARD_NUM_TMP 字段长度
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('CARD_NUM_TMP');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT_ZJ modify( CARD_NUM_TMP VARCHAR2(30))';
	end if;	
	------------------------add by lijb 2017年9月27日 end---------------

	------------------------add by hejw 2017年10月12日 start----------------------------------------------------------------------------------------

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('LYBZJTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''履约保证金 1-统一设置 2-分标段（包）设置'''; 
    end if; 
    
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('TBBZJTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金 1-统一设置 2-分标段（包）设置'''; 
    end if;
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('ISDJTBBZJ');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金 0-不要求递交投标保证金 1-要求递交投标保证金'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJXS');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金的形式(当投标保证金选择[要求递交投标保证金])'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJZFFS');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付方式 1-按比例 2-固定金额'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJPERCENT');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(5)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付比例'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    ---tmp2:=upper('TBBZJPERCENTMAX');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(5)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付比例上限'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJPERCENT_MIN');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(5)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付比例下限'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJJEDW');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金金额单位'''; 
    --end if; 
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJBZ');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金币种'''; 
    --end if;
    
    --tmp1:=upper('BD_PACKAGE');
    --tmp2:=upper('TBBZJJE');
    --num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    --if num = 0 then 
    --   execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(20,3)';
    --   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金的金额(当投标保证金选择[要求递交投标保证金])'''; 
    --end if;
    --------------------------------------------------------------------------------------------------------------
   num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_PACKAGE_CSSZ');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate 'create table BD_PACKAGE_CSSZ  (
       BDID                 VARCHAR2(30) not null,
       PACKNAME             VARCHAR2(200),
       PROBID               VARCHAR2(20),
       ISDJTBBZJ            VARCHAR2(2),
       TBBZJXS              VARCHAR2(100),
       TBBZJZFFS            VARCHAR2(2),
       TBBZJPERCENT         VARCHAR2(5),
       TBBZJPERCENT_MIN     VARCHAR2(5),
       TBBZJPERCENTMAX      VARCHAR2(5),
       TBBZJJE              NUMBER(20,3),
       TBBZJJEDW            VARCHAR2(100),
       TBBZJBZ              VARCHAR2(100),
       SFZFLVBZJ            VARCHAR2(2),
       LYDBPERCENT          NUMBER(20,3),
       LYDBJE               NUMBER(20,3),
       LYDBJEDW             VARCHAR2(100),
       LYDBFS               VARCHAR2(2),
       LYDBBZ               VARCHAR2(100),
       LYDBXS               VARCHAR2(100),
       constraint PK_BD_PACKAGE_CSSZ primary key (BDID)
    )';

    execute immediate 'comment on table BD_PACKAGE_CSSZ is ''-标段（包）价格参数设置''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.BDID is ''标段包编号''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.PACKNAME is ''标段包名称''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.PROBID is ''招标项目编号''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.ISDJTBBZJ is ''投标保证金 0-不要求递交投标保证金 1-要求递交投标保证金''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJXS is ''投标保证金的形式(当投标保证金选择[要求递交投标保证金])''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJZFFS is ''投标保证金支付方式 1-按比例 2-固定金额 3-比例范围''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJPERCENT is ''投标保证金支付比例''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJPERCENT_MIN is ''投标保证金支付比例下限''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJPERCENTMAX is ''投标保证金支付比例上限''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJJE is ''投标保证金的金额(当投标保证金选择[要求递交投标保证金])''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJJEDW is ''投标保证金金额单位''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.TBBZJBZ is ''投标保证金币种''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.SFZFLVBZJ is ''履约保证金是否支付 0-否 1-是''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBPERCENT is ''履约担保百分比''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBJE is ''履约担保的金额''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBJEDW is ''履约担保金额单位''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBFS is ''履约担保方式1百分比2固定金额''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBBZ is ''履约担保币种''';
    execute immediate 'comment on column BD_PACKAGE_CSSZ.LYDBXS is ''履约担保的形式''';
  end if;
    
	------------------------add by hejw 2017年10月12日 end---------------
	------------------------add by hejw 2017年10月20日 start---------------
   tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('AMTREMARK');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(800)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''转出提现备注'''; 
    end if; 
    
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('XJDDHM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''在线委托招标-关联询价订单单号'''; 
       execute immediate 'comment on column '||tmp1||'.FLAG08 is ''代理机构来源  1-采购询价'''; 
    end if;  
	------------------------add by hejw 2017年10月20日 end---------------
	------------add by lijb 2017年10月23日 start-------------	
	--新增扣款明细表
	num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_DEDUCTIONS_DETAIL');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_DEDUCTIONS_DETAIL
        (
          PKID                 INT                             not null,
          HYDM                 VARCHAR2(30),
          PROBID               VARCHAR2(20),
          PROBMC               VARCHAR2(200),
          BDID                 VARCHAR2(23),
          PACKNAME             VARCHAR2(200),
          TBDWCODE             VARCHAR2(30),
          TBDWMC               VARCHAR2(200),
          CHARGETYPE           VARCHAR2(10),
          KAMT                 NUMBER(20,2),
          REMARK               VARCHAR2(2000),
          CDATE                DATE,
          constraint PK_BD_DEDUCTIONS_DETAIL primary key (PKID)
        )';
        execute immediate 'comment on table BD_DEDUCTIONS_DETAIL is ''扣款明细表''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.PKID is''自增主键''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.HYDM is''会员代码''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.PROBID is''招标项目编号''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.PROBMC is''招标项目名称''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.BDID is''标段(包)编号''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.PACKNAME is''标段(包)名称''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.TBDWCODE is''投标单位代码''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.TBDWMC is''投标单位名称''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.CHARGETYPE is''扣款类型(1:代理服务费2:投标保证金3:图纸押金4:履约保证金)''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.KAMT is''扣款金额''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.REMARK is''备注''';
        execute immediate 'comment on column BD_DEDUCTIONS_DETAIL.CDATE is''扣款时间''';
    end if;
    
    num:=0;
    tmp1:=upper('BD_DEDUCTIONS_DETAIL_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_DEDUCTIONS_DETAIL_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
	--------------add by lijb 2017年10月23日 end---------------
	
    ------------------------add by jinyanhui 2017年10月18日 end---------------
	tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('zdts');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''框架协议-指定天数'''; 
    end if; 
    
    tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('zdaddr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''框架协议-指定地点'''; 
    end if;
    
    tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('zdfilepath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''框架协议-附件'''; 
    end if;
    
    tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('zdfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''框架协议-附件名称'''; 
    end if;
    
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('iswin');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then 
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否中标 1- 中标 0 - 未中标'''; 
	end if;    
    
    ------------------------add by jinyanhui 2017年10月18日 end---------------
	-------------------------add by lijb 2017年10月23日 start-----------------
   	-- 修改 NOWMAJOR 字段长度
	tmp1:=upper('BD_EXPERT_TEMP');
	tmp2:=upper('NOWMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT_TEMP modify( NOWMAJOR VARCHAR2(200))';
	end if;	
	-- 修改 NOWMAJOR 字段长度
	tmp1:=upper('BD_EXPERT');
	tmp2:=upper('NOWMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT modify( NOWMAJOR VARCHAR2(200))';
	end if;	
	-- 修改 NOWMAJOR 字段长度
	tmp1:=upper('BD_EXPERT_ZJ');
	tmp2:=upper('NOWMAJOR');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table BD_EXPERT_ZJ modify( NOWMAJOR VARCHAR2(200))';
	end if;	
	-------------------------add by lijb 2017年10月23日 end-----------------
	------------add by lijb 2017年10月24日 start-------------
    -- 新增专家表备用信息字段
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('RESTEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备用联系信息'''; 
    end if;
    
    -- 新增专家自荐表身份附件原名称字段
    tmp1:=upper('BD_EXPERT_ZJ');
    tmp2:=upper('IDCARDFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份附件原名称'''; 
    end if;
    
    -- 新增专家自荐表学历附件原名称字段
    tmp1:=upper('BD_EXPERT_ZJ');
    tmp2:=upper('DIPLOMAFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学历附件原名称'''; 
    end if;
    ------------add by lijb 2017年10月24日 end---------------

   	-- 修改 CARD_NUM 字段长度
	tmp1:=upper('bd_hgzjtzs');
	tmp2:=upper('ZDTS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
		execute immediate 'alter table bd_hgzjtzs modify( ZDTS VARCHAR2(30))';
	end if;	
  -------------------------------------------------------------

	------------add by lijb 2017年10月31日 start-------------
    -- 投标人资格预审投标文件递交签名UUID相关字段
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('SEALDATA08');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人资格预审投标文件递交签名UUID'''; 
    end if;
    ------------add by lijb 2017年10月31日 end---------------

    ------------add by hejw 2017年11月03日 start---------------
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_BILLING_DETAILS');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_BILLING_DETAILS  (
           PKID                 NUMBER                          not null,
           TYP                  VARCHAR2(2),
           WORTH                VARCHAR2(60),
           REMARKS              VARCHAR2(200),
           CODEORDER            NUMBER,
           CDATE                DATE,
           COPT                 VARCHAR2(40),
           CATEGORY             VARCHAR2(60),
           CATEGORYID           VARCHAR2(30),
           CONTENT              VARCHAR2(60),
           CONTENTID            VARCHAR2(30),
           CONTENTTYPE          VARCHAR2(30),
           SYSCODE              VARCHAR2(20),
           constraint PK_BD_BILLING_DETAILS primary key (PKID)
        )';

        -- Add comments to the columns 
        execute immediate 'comment on table BD_BILLING_DETAILS is ''计费服务项模板详情''';
        execute immediate 'comment on column BD_BILLING_DETAILS.PKID is ''组建''';
        execute immediate 'comment on column BD_BILLING_DETAILS.TYP is ''1-业务判断 2-纯文字''';
        execute immediate 'comment on column BD_BILLING_DETAILS.WORTH is ''值 CONTENTTYPE=1（0-不选中  1-选中）''';
        execute immediate 'comment on column BD_BILLING_DETAILS.REMARKS is ''附记、描述''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CODEORDER is ''顺序''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CDATE is ''创建时间''';
        execute immediate 'comment on column BD_BILLING_DETAILS.COPT is ''创建人''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CATEGORY is ''服务-类别''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CATEGORYID is ''服务-类别-编号''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CONTENT is ''服务-内容项''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CONTENTID is ''内容项编号''';
        execute immediate 'comment on column BD_BILLING_DETAILS.CONTENTTYPE is ''内容项类别''';
        execute immediate 'comment on column BD_BILLING_DETAILS.SYSCODE is ''系统编号''';
    end if;
    
        num:=0;
    tmp1:=upper('BD_BILLING_DETAILS_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_BILLING_DETAILS_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    
    tmp1:=upper('BD_BILLING_DETAILS');
    tmp2:=upper('WORTHL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''值-左边'''; 
    end if;    
    
    tmp1:=upper('BD_BILLING_DETAILS');
    tmp2:=upper('WORTHR');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''值-右边'''; 
    end if; 
    ------------add by hejw 2017年11月03日 end---------------
	------------add by lijb 2017年11月07日 start-------------
    tmp1:=upper('BD_BILLING_DETAILS');
    tmp2:=upper('ICOFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务项图标'''; 
    end if;
    ------------add by lijb 2017年11月07日 end---------------

    tmp1:=upper('Bd_Subproject');
    tmp2:=upper('ysggpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审公告静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Subproject');
    tmp2:=upper('zbggpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标公告静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Subproject');
    tmp2:=upper('dzgtzspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代资格审核通过通知书静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Subproject');
    tmp2:=upper('tbyqspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标邀请通知书静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('hxrgspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''候选人公示静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('jgtzspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''结果通知书静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('zbjgggpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标结果静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('kbjlpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('ysjlpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审记录静态页面'''; 
    end if;
    
    tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('zbtzspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标通知书静态页面'''; 
    end if;
    ------------add by lijb 2017年11月13日 start-------------
     num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_ENTRUST_FILE');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_ENTRUST_FILE
        (
          PKID                 INT                             not null,
          BDID                 VARCHAR2(30),
          PROBID               VARCHAR2(30),
          TYP                  VARCHAR2(2),      
          HYDM                 VARCHAR2(30),
          OPTID                VARCHAR2(30),                         
          CDATE                DATE,
          FILEPATH             VARCHAR2(200),
          FILENAME             VARCHAR2(200),
          TYPE                 VARCHAR2(10),
          constraint PK_BD_ENTRUST_FILE primary key (PKID)
        )';
        execute immediate 'comment on table BD_ENTRUST_FILE is ''资料归档附件表''';
        execute immediate 'comment on column BD_ENTRUST_FILE.PKID is''自增主键''';
        execute immediate 'comment on column BD_ENTRUST_FILE.BDID is''标段包编号''';
        execute immediate 'comment on column BD_ENTRUST_FILE.PROBID is''项目编号''';
        execute immediate 'comment on column BD_ENTRUST_FILE.TYP is''类型''';
        execute immediate 'comment on column BD_ENTRUST_FILE.HYDM is''会员代码''';
        execute immediate 'comment on column BD_ENTRUST_FILE.OPTID is''操作员代码''';
        execute immediate 'comment on column BD_ENTRUST_FILE.CDATE is''创建时间''';
        execute immediate 'comment on column BD_ENTRUST_FILE.FILEPATH is''附件路径''';
        execute immediate 'comment on column BD_ENTRUST_FILE.FILENAME is''附件名称''';
        execute immediate 'comment on column BD_ENTRUST_FILE.TYPE is''章节''';
    end if;
    
    num:=0;
    tmp1:=upper('BD_ENTRUST_FILE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_ENTRUST_FILE_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    ------------add by lijb 2017年11月13日 end---------------
	------------add by lijb 2017年11月15日 start-------------
    tmp1:=upper('BD_ENTRUST_FILE');
    tmp2:=upper('CHAPTER');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''章节'''; 
    end if;
    ------------add by lijb 2017年11月15日 end---------------
    
    tmp1:=upper('Bd_Hgzjtzs');
    tmp2:=upper('content');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标通知书其他情况说明'''; 
    end if;
    ------------add by lijb 2017年11月15日 start-------------
     num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_SCHEME_BUSINESS');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_SCHEME_BUSINESS
        (
          PKID                 INT                             not null,
          SCHEMEID             VARCHAR2(30),
          SCHEMENAME           VARCHAR2(200),
          BUSINESSID           VARCHAR2(30),      
          BUSINESSNAME         VARCHAR2(200),
          constraint PK_BD_SCHEME_BUSINESS primary key (PKID)
        )';
        execute immediate 'comment on table BD_SCHEME_BUSINESS is ''方案业务绑定表''';
        execute immediate 'comment on column BD_SCHEME_BUSINESS.PKID is''自增主键''';
        execute immediate 'comment on column BD_SCHEME_BUSINESS.SCHEMEID is''方案编号''';
        execute immediate 'comment on column BD_SCHEME_BUSINESS.SCHEMENAME is''方案名称''';
        execute immediate 'comment on column BD_SCHEME_BUSINESS.BUSINESSID is''业务编号''';
        execute immediate 'comment on column BD_SCHEME_BUSINESS.BUSINESSNAME is''业务名称''';
    end if;
    
    num:=0;
    tmp1:=upper('BD_SCHEME_BUSINESS_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_SCHEME_BUSINESS_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    ------------add by lijb 2017年11月15日 end---------------

	tmp1:=upper('Bd_Package');
    tmp2:=upper('dzgtzspath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代资格审核通过通知书静态页面'''; 
    end if;
    
    ----2017-11-20- hejw start----
    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdids');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(4000))';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('CONTROLPRICE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否控制平台收费限价 1-控制  0orNull-不控制'''; 
    end if;  
    ----2017-11-20- hejw end----
	------------add by lijb 2017年11月22日 end---------------  
    tmp1:=upper('BD_BILLING_DETAILS');
    tmp2:=upper('OPTIONE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' Integer';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否可选择服务项 0否 1是'''; 
    end if;
    ------------add by lijb 2017年11月22日 start-------------
    -------------add by zhaoy 2017年11月29日 start----------------
    -- 新增代理机构综合评价信息
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EVALUATE_AGENCY');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_EVALUATE_AGENCY  (
           PKID                 NUMBER                          not null,
           HYDM                 VARCHAR2(30),
           MBNAME               VARCHAR2(100),
           SCORE                NUMBER(5,0),
           SORT                 NUMBER,
           CDATE                DATE,
           COPTID               VARCHAR2(30),
           COPTNAME             VARCHAR2(100),
           TYPE               	VARCHAR2(30),
       
           constraint PK_BD_EVALUATE_AGENCY primary key (PKID)
        )';

        execute immediate 'comment on table BD_EVALUATE_AGENCY is ''代理机构综合评价''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.PKID is ''自增主键''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.HYDM is ''会员代码''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.MBNAME is ''单位名称''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.SCORE is ''评分''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.SORT is ''排序(用于相同分数使用)''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.CDATE is ''创建时间''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.COPTID is ''操作员代码''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.COPTNAME is ''操作员名称''';
        execute immediate 'comment on column BD_EVALUATE_AGENCY.TYPE is ''类型:1本年2累计''';
    end if;

    num:=0;
    tmp1:=upper('BD_EVALUATE_AGENCY_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_EVALUATE_AGENCY_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
    -------------add by zhaoy 2017年11月29日 end----------------
    --------------add by zhaoy 2017年11月30日 start-------------
    -- 标段包分类表加入会员分类代码
     tmp1:=upper('BD_BIDPACKAGE_TYPE');
     tmp2:=upper('hyfldm');
     num:=0; -- 注意：查询前必须初始化此变量
     select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员分类代码''';
     end if; 
     -- 标段包分类表加入会员分类代码
     tmp1:=upper('BD_BIDPACKAGE_TYPE');
     tmp2:=upper('hyflmc');
     num:=0; -- 注意：查询前必须初始化此变量
     select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
     if num = 0 then
        execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员分类名称''';
     end if;
     
    -- 新增会员分类表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_BIDPACKAGE_HYFL');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_BIDPACKAGE_HYFL  (
           PKID                 NUMBER                          not null,
           HYFLDM               VARCHAR2(10),
           HYFLMC               VARCHAR2(60),
       
           constraint PK_BD_BIDPACKAGE_HYFL primary key (PKID)
        )';

        execute immediate 'comment on table BD_BIDPACKAGE_HYFL is ''会员分类表''';
        execute immediate 'comment on column BD_BIDPACKAGE_HYFL.PKID is ''自增主键''';
        execute immediate 'comment on column BD_BIDPACKAGE_HYFL.HYFLDM is ''会员分类代码''';
        execute immediate 'comment on column BD_BIDPACKAGE_HYFL.HYFLMC is ''会员分类名称''';
    end if;

    num:=0;
    tmp1:=upper('BD_BIDPACKAGE_HYFL_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_BIDPACKAGE_HYFL_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;  
    -------------add by zhaoy 2017年11月30日 end----------------
	------------add by zhaoy 2017年12月05日 start-------------
   	-- 修改 CARD_NUM 字段长度	
    -- 增加 OLD_SCORE
    tmp1:=upper('BD_EVALUATE_AGENCY');
    tmp2:=upper('OLD_SCORE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(5,2))';
    end if;
    -- 赋值 OLD_SCORE
    tmp1:=upper('BD_EVALUATE_AGENCY');
    tmp2:=upper('OLD_SCORE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set OLD_SCORE = SCORE';
    end if;
    -- 删除 SCORE
    tmp1:=upper('BD_EVALUATE_AGENCY');
    tmp2:=upper('SCORE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
    -- 修改 OLD_SCORE 字段名为 SCORE
    tmp1:=upper('BD_EVALUATE_AGENCY');
    tmp2:=upper('OLD_SCORE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' rename COLUMN '||tmp2||' to SCORE';
    end if;
    ------------修改有数据字段长度结束---------------------------------------------------
    -------------add by zhaoy 2017年12月05日 end----------------    
    
    -------------add by hejw 2017年12月06日 start----------------
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('zfqtfs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(1000))';
    end if;
    -------------add by hejw 2017年12月06日 end----------------
    
  --------------add by hejw 2017年11月29日 start-------------
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZBWJPRICE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(22, 2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件售价'''; 
    end if;   
    
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('YCMS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
    end if;
    
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZBWJJGDW');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件价格单位'''; 
    end if; 
   --------------add by hejw 2017年11月29日 end-------------
    
      --------------add by zhaoy 2017年11月23日 start-------------
   -- 标段包表加入中标金额字段
   tmp1:=upper('BD_PACKAGE');
   tmp2:=upper('ZBJE');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
      execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(20,2)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更正中标金额''';
   end if; 
   --------------add by zhaoy 2017年8月28日 end-------------
	------------add by lijb 2017年11月29日 start--------------- 
    -- 新增支付登记信息表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_BILLHEAD');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_BILLHEAD  (
           ID                   NUMBER                          not null,
           PKID					VARCHAR2(200),
           DDHM                 VARCHAR2(100),
           TRANAMT              NUMBER(20,2),
           OPPACCNO             VARCHAR2(100),
           OPPACCNAME           VARCHAR(100),
           OPPBRANCHNAME        VARCHAR2(100),
           OPPBRANCHNO          VARCHAR2(100),
           PAYDATE              DATE,
           ENNAME               VARCHAR2(100),
           TYPE                 INTEGER,
           MODIFYUSER           VARCHAR2(100),
           STATUS               VARCHAR2(100),
           AUDITUSER            VARCHAR2(100),
           AUDITTIME			DATE,
           REMARKS              VARCHAR2(2000),
           MBCODE				VARCHAR2(100),
           MBNAME				VARCHAR2(100),
           ORDERING				VARCHAR2(100),
           APPID				VARCHAR2(100),
           CDATE				DATE,
           constraint PK_BD_BILLHEAD primary key (ID)
        )';

        execute immediate 'comment on table BD_BILLHEAD is ''支付登记信息''';
        execute immediate 'comment on column BD_BILLHEAD.ID is ''自增主键''';
        execute immediate 'comment on column BD_BILLHEAD.PKID is ''唯一''';
        execute immediate 'comment on column BD_BILLHEAD.DDHM is ''订单号码''';
        execute immediate 'comment on column BD_BILLHEAD.TRANAMT is ''支付金额''';
        execute immediate 'comment on column BD_BILLHEAD.OPPACCNO is ''支付账户''';
        execute immediate 'comment on column BD_BILLHEAD.OPPACCNAME is ''支付账户名称''';
        execute immediate 'comment on column BD_BILLHEAD.OPPBRANCHNAME is ''开户银行''';
        execute immediate 'comment on column BD_BILLHEAD.OPPBRANCHNO is ''支付联行号''';
        execute immediate 'comment on column BD_BILLHEAD.PAYDATE is ''支付时间''';
        execute immediate 'comment on column BD_BILLHEAD.ENNAME is ''支付银行标识''';
        execute immediate 'comment on column BD_BILLHEAD.TYPE is ''添加方式 0银行系统推送 1人工添加''';
        execute immediate 'comment on column BD_BILLHEAD.MODIFYUSER is ''操作人''';
        execute immediate 'comment on column BD_BILLHEAD.STATUS is ''审核状态:wait等待审核 audited已审核 refuse已拒绝''';
        execute immediate 'comment on column BD_BILLHEAD.AUDITUSER is ''审核人''';
        execute immediate 'comment on column BD_BILLHEAD.AUDITTIME is ''审核时间''';
        execute immediate 'comment on column BD_BILLHEAD.REMARKS is ''附记、描述''';
        execute immediate 'comment on column BD_BILLHEAD.MBCODE is ''会员代码''';
        execute immediate 'comment on column BD_BILLHEAD.MBNAME is ''会员名称''';
        execute immediate 'comment on column BD_BILLHEAD.ORDERING is ''订单类型:handle-订购 renew-续订 upgrade-升级''';
        execute immediate 'comment on column BD_BILLHEAD.APPID is ''服务分配ID''';
        execute immediate 'comment on column BD_BILLHEAD.CDATE is ''创建时间''';
    end if;

    num:=0;
    tmp1:=upper('BD_BILLHEAD_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_BILLHEAD_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
	------------add by lijb 2017年11月29日 end---------------

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
    -------------------------------------------------------------------------------------------------------
end;
