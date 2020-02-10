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

   -- hejw start -------------------------
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('STATUS02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退投标保证金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('STATUS03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退图纸押金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('STATUS04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退履约保证金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('STATUS02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退投标保证金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('STATUS03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退图纸押金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('STATUS04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退履约保证金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('STATUSBACK');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退保证金-(0ornull-未处理  2-审核失败 4-待平台审核  6-平台审核成功 8-处理成功(已退过)  )''';
    end if;

   	-----add by zhangzq 2017-04-27  采招网消息队列表增加字段保存报文 start-----
	tmp1:=upper('BD_CZ_TASK_BAK');
	tmp2:=upper('XMLCONTENT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报文内容''';
	end if;
	-----add by zhangzq 2017-04-27  end-----

    -----add by songw 2017年5月4日  start---------------
    --增加财务对订单是否开票的标记
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('SFKP');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''财务标记订单是否开票 1-是 0-否''';
    end if;
    -----add by songw 2017年5月4日  end---------------

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('KAUDITWHY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退投标保证金-(0ornull-待处理 2-已部分处理 4-已全部处理)''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('KFILE01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(300)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-扣款上传附件''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('KREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-扣款理由''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('KAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(26,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-扣款金额''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('payamtout');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(26,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''超时已支付金额''';
    end if;
    -- hejw end -------------------------


   ---------hejw 增加退款表  start------------------
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_REFUND_APPLY');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_REFUND_APPLY  (
           PKID                 NUMBER,
           TYP                  VARCHAR2(10),
           AMT                  NUMBER(30,2),
           BACKAMT              NUMBER(30,2),
           STATUS               NUMBER,
           SKTYP                VARCHAR2(100),
           SKACCNO              VARCHAR2(100),
           SKACCNM              VARCHAR2(200),
           SKBANKNM             VARCHAR2(200),
           SKBANKHM             VARCHAR2(50),
           SHDATE               DATE,
           SHOPT                VARCHAR2(160),
           CDATE                DATE,
           COPT                 VARCHAR2(160),
           constraint PK_BD_REFUND_APPLY primary key (PKID)
        )';

        execute immediate 'comment on table BD_REFUND_APPLY is ''退款申请''';
        execute immediate 'comment on column BD_REFUND_APPLY.PKID is ''主键''';
        execute immediate 'comment on column BD_REFUND_APPLY.TYP is ''1-保证金退款 2-CA退款''';
        execute immediate 'comment on column BD_REFUND_APPLY.AMT is ''退款金额''';
        execute immediate 'comment on column BD_REFUND_APPLY.BACKAMT is ''实际退款金额''';
        execute immediate 'comment on column BD_REFUND_APPLY.STATUS is ''状态 0ornull-待提交   2-审核不通过  4-待审核 6-审核通过 8-退款成功''';
        execute immediate 'comment on column BD_REFUND_APPLY.SKTYP is ''收款银行''';
        execute immediate 'comment on column BD_REFUND_APPLY.SKACCNO is ''收款账户账号''';
        execute immediate 'comment on column BD_REFUND_APPLY.SKACCNM is ''收款账户开户名''';
        execute immediate 'comment on column BD_REFUND_APPLY.SKBANKNM is ''收款账户开户行''';
        execute immediate 'comment on column BD_REFUND_APPLY.SKBANKHM is  ''开户行支付联行号''';
        execute immediate 'comment on column BD_REFUND_APPLY.SHDATE is ''审核时间''';
        execute immediate 'comment on column BD_REFUND_APPLY.SHOPT is ''审核人''';
        execute immediate 'comment on column BD_REFUND_APPLY.CDATE is  ''创建时间''';
        execute immediate 'comment on column BD_REFUND_APPLY.COPT is  ''创建人''';
    end if;

    num:=0;
    tmp1:=upper('BD_REFUND_APPLY_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_REFUND_APPLY_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('whymsg');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核不通过原因''';
    end if;

      tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('hydm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方会员代码''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('HYMC');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方会员名称''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('BKID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''银行代码''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('BCUSTACCT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''银行子账户户''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('ACC_FLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(3,0)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''临时账户类型：0 - 固定（会员永久附属账户） 1 - 资格预审文件费用临时附属账户 2 - 标书文件费用临时附属账户 3 - 投标保证金费用临时附属账户 4 - 图纸押金费用临时附属账户 5 - 履约保证金费用临时附属账户''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('TB_MB_NAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人会员名称''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('TB_MB_CODE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人代码''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('BD_BILL_NO');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(40)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）编号''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('BD_BILL_MC');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段包名称''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('REMARK');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请备注''';
    end if;

    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('BACKDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''成功时间''';
    end if;
   ---------hejw 增加退款表  end------------------

   ----hejw 流水表增加字段 start-------
    tmp1:=upper('BD_IN_OUT_AMT');
    tmp2:=upper('TRAN_DATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''流水生成时间''';
    end if;
   ----hejw 流水表增加字段 end-------
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('CURRENTRS2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''当按单位抽取时 此字段存 已抽取过的人数''';
    end if;


    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_AUDIT_RECORDS');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
    -- 建表
    execute immediate '
    create table BD_AUDIT_RECORDS  (
        pkid               NUMBER,
        cdate             DATE,
        flag01             VARCHAR2(20),
        remark             VARCHAR2(2000),
        kamt               NUMBER(30,2),
        remark02           VARCHAR2(2000),
        file02             VARCHAR2(200),
        copt               VARCHAR2(200),
        typ                NUMBER,
        constraint PK_BD_AUDIT_RECORDS primary key (PKID)
    )';

    execute immediate 'comment on table BD_AUDIT_RECORDS is ''审核记录''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.pkid is ''主键''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.cdate is ''创建时间''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.flag01 is ''0ornull-审核未通过 1-审核通过''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.remark is ''审核备注''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.kamt is ''扣款金额''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.copt is ''操作员''';
    execute immediate 'comment on column BD_AUDIT_RECORDS.typ is ''1.保证金扣款审核记录''';
 end if;

    num:=0;
    tmp1:=upper('BD_AUDIT_RECORDS_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_AUDIT_RECORDS_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;

    tmp1:=upper('BD_AUDIT_RECORDS');
    tmp2:=upper('CONTEXTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关联标识''';
    end if;


    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('status02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(3)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核代理机构 状态  0ornull-待处理   2-审核不通过  4-已提交待审核  6-审核通过''';
    end if;


    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('remark02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核代理机构-审核备注''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('date02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核代理机构-审核时间''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('OPT02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核代理机构-操作员''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('SQOPT02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-操作员''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('REASON02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-申请理由''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('FILE02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-申请附件''';
    end if;

    tmp1:=upper('Bd_Subproject_Ext');
    tmp2:=upper('OLDNAME02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-申请附件 中文名称''';
    end if;

    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_FINALIST');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
    -- 建表
    execute immediate '
        create table BD_FINALIST  (
           PKID                 NUMBER,
           FATHER               VARCHAR2(60),
           HYDM                 VARCHAR2(60),
           MBNAME               VARCHAR2(200),
           CDATE                DATE,
           COPT                 VARCHAR2(100),
           RANK                 NUMBER,
           FLAG02               VARCHAR2(2),
           constraint PK_BD_FINALIST primary key (PKID)
        )';

        execute immediate 'comment on table BD_FINALIST is ''入围代理机构信息''';
        execute immediate 'comment on column BD_FINALIST.PKID is ''主键''';
        execute immediate 'comment on column BD_FINALIST.FATHER is ''当前集团''';
        execute immediate 'comment on column BD_FINALIST.HYDM is ''入围会员代码''';
        execute immediate 'comment on column BD_FINALIST.MBNAME is ''入围会员名称''';
        execute immediate 'comment on column BD_FINALIST.CDATE is ''创建时间''';
        execute immediate 'comment on column BD_FINALIST.COPT is ''创建人''';
        execute immediate 'comment on column BD_FINALIST.RANK is ''排序''';
        execute immediate 'comment on column BD_FINALIST.FLAG02 is ''是否前台显示 1-不显示  0orNull-前台显示''';
    end if;

    num:=0;
    tmp1:=upper('BD_FINALIST_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_FINALIST_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;

  ----zhangjian 评价表加字段 start-------
    tmp1:=upper('BD_EVALUATION');
    tmp2:=upper('WYHDM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委员会编号''';
    end if;
  ----zhangjian 评价表加字段 end-------
    ----------------add by songw 2017年5月16日 start-----------------
    --add 增加资格预审评委信息维护相关字段
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('prezjwhnote');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审评委信息维护-是否维护 1-已维护''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('precertpath');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审评委信息维护-数字证书登记表上传路径''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('precertname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审评委信息维护-数字证书登记表名称''';
    end if;

    ----------------add by songw 2017年5月16日 end-----------------

    ----------------add by hejw 2017年5月25日 start-----------------
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SQCDATE02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-申请时间''';
    end if;
    ----------------add by hejw 2017年5月25日 end-----------------

	------add zhangjian 2017-5-26 start-----
	tmp1:=upper('bd_td_dd');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退款-扣款上传附件文件名''';
    end if;
	------add zhangjian 2017-5-26 end-----

    ----------------add by songw 2017年5月25日 start------------------
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('province');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-省代码''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('provincename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-省名称''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('city');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-市代码''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('cityname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-市名称''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('county');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-区代码''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('countyname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-区名称''';
    end if;

    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('address');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-详细地址''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('province');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-省代码''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('provincename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-省名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('city');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-市代码''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('cityname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-市名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('county');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-区代码''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('countyname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-区名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('address');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点-详细地址''';
    end if;

    --增加变更公告是否延迟文件购买截止时间相关字段和变更地点省市区
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('isdelaybuyfile');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否延迟文件购买截止时间 1-是 0-否''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('wjgmjzsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件购买截止时间''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('province');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-省代码''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('provincename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-省名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('city');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-市代码''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('cityname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-市名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('county');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-区代码''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('countyname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-区名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('address');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更地点-详细地点''';
    end if;

    ----------------add by songw 2017年5月25日 end------------------

    --------------add by songw 2017年6月1日 start---------------------
    --调整组建委员会的报到地点和评审/评标地点调整为省市区
    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdprovince');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-省代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdprovincename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-省名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdcity');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-市代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdcityname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-市名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdcounty');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-区代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdcountyname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-区名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('bdaddress');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''报到地点-详细地点''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('province');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-省代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('provincename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-省名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('city');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-市代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('cityname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-市名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('county');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(6)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-区代码''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('countyname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-区名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('address');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审/评标地点-详细地点''';
    end if;

    --------------add by songw 2017年6月1日 end---------------------

    --------------add by songw 2017年6月2日 start--------------------
    --add 增加公告/邀请发布时间字段
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ggfbsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''公告/邀请发布时间（预审取预审公告发布时间，公开后审取招标公告发布时间，邀请流程取邀请书发布时间）''';
    end if;

    --------------add by songw 2017年6月2日 end--------------------

    ------add by hejw 2017.6.6 start ----------------
    tmp1:=upper('BD_JURY');
    tmp2:=upper('AUTOERROR2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''补抽-自动抽取不符合条件错误信息''';
    end if;

    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('ISFLAG01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(3)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''0ornull-组建时增加的 1-补抽增加的专家''';
    end if;

    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('ISFLAG01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(3)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''0ornull-组建时增加的 1-补抽增加的抽取条件''';
    end if;
    ------add by hejw 2017.6.6 end ----------------

    ----------add by songw 2017年6月12日 start---------------
    --增加标识是否过滤此数据 1-招投标前台过滤此数据
    tmp1:=upper('BD_SUBPROJECT');
    tmp2:=upper('MARKETFILTER');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标识是否过滤此数据 1-招投标前台过滤此数据''';
    end if;
    ----------add by songw 2017年6月12日 end---------------

    ------------add by songw 2017年6月13日 start--------------
    --增加中标候选人公示状态 1-已保存  5-已发布
    tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('STATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示状态 1-已保存  5-已发布''';
    end if;
    ------------add by songw 2017年6月13日 end--------------

 	------------add by zhangjian 2017年6月19日 start--------------
	tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('ZBROPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录确认  招标方签章确认人姓名''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('DLJGOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录确认  代理机构确认人姓名''';
    end if;

    ---------add by songw 2017年6月28日 start----------
    -- 增加退投标保证金、退图纸押金、退履约保证金的备注信息
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('TTBBZJBZ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(400)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退投标保证金-备注''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('TTZYJBZ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(400)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退图纸押金-备注''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('TLVBZJBZ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(400)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退履约保证金-备注''';
    end if;

    ---------add by songw 2017年6月28日 end----------

    -------------add by songw 2017年6月29日 start-------------
    tmp1:=upper('bd_tbyqsbz');
    tmp2:=upper('inviteunitid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(4000))';
    end if;
    -------------add by songw 2017年6月29日 end-------------
    -------------add by songw 2017年6月30日 start---------------
    -- add 增加参数设置专家确认方式包含指定时需上传证明材料
    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('APPOINTFILEPATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认方式包含指定时上传的证明材料路径''';
    end if;

    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('APPOINTFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认方式包含指定时上传的证明材料文件名称''';
    end if;

    -------------add by songw 2017年6月30日 end---------------

	-------------add by zhangjian 2017年6月30日 start---------------

	num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_PROJECT_EXT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_PROJECT_EXT  (
           PROID                 VARCHAR2(17),
           OPTID001              VARCHAR2(30),
           OPTNAME001            VARCHAR2(80),
           OPTDATE001            DATE
        )';
        execute immediate 'comment on table BD_PROJECT_EXT is ''项目扩展表''';
		execute immediate 'comment on column BD_PROJECT_EXT.PROID is ''项目编号''';
		execute immediate 'comment on column BD_PROJECT_EXT.OPTID001 is ''更新操作员编号''';
		execute immediate 'comment on column BD_PROJECT_EXT.OPTNAME001 is ''更新操作员名称''';
		execute immediate 'comment on column BD_PROJECT_EXT.OPTDATE001 is ''更新操作时间''';
	end if;


	tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托回执操作员编号''';
    end if;

    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托回执操作员名称''';
    end if;

    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托回执操作员部门编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托回执操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托回执操作时间''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''编制委托协议操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''编制委托协议操作员名称''';
    end if;
	tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''编制委托协议操作员部门编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''编制委托协议操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''编制委托协议操作时间''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新编码操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新编码操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''DATE''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目更新时间''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('SQOPTID02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请未入围代理机构-操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托信息操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托信息操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTID005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托信息操作员部门编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTNAME005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托信息操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存委托信息操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送委托信息向代理机构操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送委托信息向代理机构操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTID006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送委托信息向代理机构操作员部门编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTNAME006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送委托信息向代理机构操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送委托信息向代理机构操作员部门名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新选择未入围代理机构理由操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新选择未入围代理机构理由操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTID007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新选择未入围代理机构理由操作员部门编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DEPTNAME007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新选择未入围代理机构理由操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新选择未入围代理机构理由操作时间''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('ZBFXYQZRNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标协议确认人名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTID008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存招标项目计划操作员编号''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存招标项目计划操作员名称''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTDATE008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存招标项目计划操作时间''';
    end if;
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('DLFQZRNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(80)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构编制委托协议操作员名称''';
    end if;

		-------------add by zhangjian 2017年6月30日 end---------------

    ------------add by songw 2017年7月4日 start--------------
    --增加招标项目终止公告后台审核相关字段
    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('EXAMINEDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台审核时间''';
    end if;

    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('EXAMINEUSERID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台审核人userid''';
    end if;

    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('EXAMINEUSERNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(60)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台审核人名称''';
    end if;

    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('EXAMINEOPINION');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(400)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台审核意见''';
    end if;

    ------------add by songw 2017年7月4日 end--------------


-----add by hejw start-------------------------------------------------------
tmp1:=upper('BD_CCNOTICE');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_CC_RECEIPT');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_CONTRACT');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_DB_HXRGS');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_DB_ZBJGGG');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_DISSENT');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_EVALUATION');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_FB_SURVEY');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_HGZJTZS');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_JURY');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_JURY_MEMBER');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_MB_PBMB');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_NOTICE');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_OBJECTION');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_OFFER_MX');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_PACKAGE');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_PROJECT');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_SUBPROJECT');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_TBYQSBZ');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_TB_SIGNUP');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_TD_DD');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_TSSL');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZBGG');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZBSTOPGG');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZB_FILE');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZB_YC');--
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZFQD_QUENUE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_IN_OUT_AMT');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_TD_DD_MX');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_ZFQD_QUENUE_BAK');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_MESSAGE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_SOFTWARE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_CZ_TASK');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_CZ_TASK_BAK');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_SJDZ');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_CZ_SJDZ');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_DP_DYNAMIC');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_DP_QUEUE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_EXPERT');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_PACKAGE_ITEM');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_SMS_QUEUE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_JURY_CENSOR');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_FB_TB_FILE');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_FB_ZBCSSZ');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

tmp1:=upper('BD_PAY_REQUEST');
tmp2:=upper('SUBSYSTEM');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''子平台标识-表示是哪个子平台的数据''';
end if;

-----add by hejw 系统区别字段-------end---------------------------------

  -------------add by songw 2017年7月4日 start-------------
  --增加修改项目标的物操作时间
    tmp1:=upper('bd_project_item');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作时间''';
    end if;
  -------------add by songw 2017年7月4日 end-------------

    ------------add by songw 2017年7月11日 start----------------
    -- 订单表增加发票接收常用地址关联标识 关联bs_common_address的pkid
    tmp1:=upper('bd_td_dd');
    tmp2:=upper('ADDRESSPKID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发票接收常用地址关联标识关联bs_common_address的pkid''';
    end if;
    ------------add by songw 2017年7月11日 end----------------
    ------------add by zhangjian 2017年7月10日 start--------------
	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('optid001');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新标段包操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME001');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新标段包操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE001');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''更新标段包时间''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('optid002');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回预审文件操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME002');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回预审文件操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE002');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回预审文件操作时间''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTID003');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人确认预审文件操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME003');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人确认预审文件操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE003');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人确认预审文件操作时间''';
	end if;



	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTID004');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人取消确认预审文件操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME004');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人取消确认预审文件操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE004');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人取消确认预审文件操作时间''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTID005');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人撤销预审文件操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME005');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人撤销预审文件操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE005');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人撤销预审文件操作时间''';
	end if;


	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTID006');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布预审文件操作员编号''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTNAME006');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布预审文件操作员名称''';
	end if;

	tmp1:=upper('BD_PACKAGE_EXT');
	tmp2:=upper('OPTDATE006');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布预审文件操作时间''';
	end if;

	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('OPTID001');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员编号''';
	end if;

	tmp1:=upper('BD_FB_ZBCSSZ');
	tmp2:=upper('OPTNAME001');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;



	tmp1:=upper('BD_MB_PBMB_BAK');
	tmp2:=upper('OPTNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;

	tmp1:=upper('BD_MB_PBMB');
	tmp2:=upper('OPTNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;

	tmp1:=upper('BD_MB_PSBF');
	tmp2:=upper('OPTNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;

	tmp1:=upper('BD_ZB_FILE');
	tmp2:=upper('OPTNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
	end if;

  ------------add by zhangjian 2017年7月10日 end--------------

    -----------add by songw 2017年7月13日 start-------------
    -- 增加招标公告扩展表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_ZBGG_EXT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_ZBGG_EXT
        (
          PKID        VARCHAR2(100),
          OPTID001    VARCHAR2(50),
          OPTNAME001  VARCHAR2(50),
          DEPTID001   VARCHAR2(50),
          DEPTNAME001 VARCHAR2(50),
          OPTDATE001  DATE,
          OPTID002    VARCHAR2(50),
          OPTNAME002  VARCHAR2(50),
          DEPTID002   VARCHAR2(50),
          DEPTNAME002 VARCHAR2(50),
          OPTDATE002  DATE
        )';
        execute immediate 'comment on table BD_ZBGG_EXT is ''招标公告扩展表''';
        execute immediate 'comment on column BD_ZBGG_EXT.PKID is ''主键''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTID001 is ''新增公告操作员编号''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTNAME001 is ''新增公告操作员名称''';
        execute immediate 'comment on column BD_ZBGG_EXT.DEPTID001 is ''新增公告操作员部门编号''';
        execute immediate 'comment on column BD_ZBGG_EXT.DEPTNAME001 is ''新增公告操作员部门名称''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTDATE001 is ''新增公告操作时间''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTID002 is ''修改公告操作员编号''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTNAME002 is ''修改公告操作员名称''';
        execute immediate 'comment on column BD_ZBGG_EXT.DEPTID002 is ''修改公告操作员部门编号''';
        execute immediate 'comment on column BD_ZBGG_EXT.DEPTNAME002 is ''修改公告操作员部门名称''';
        execute immediate 'comment on column BD_ZBGG_EXT.OPTDATE002 is ''修改公告操作时间''';
    end if;



    --增加放弃投标的说明内容、附件路径、附件名称、弃标函pdf路径
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('GIVEUPREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''放弃投标说明内容''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('GIVEUPFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''放弃投标附件路径''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('GIVEUPFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''放弃投标附件名称''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('GIVEUPPDF');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''弃标函pdf路径''';
    end if;

    -----------add by songw 2017年7月13日 end-------------

    -----------add by hejw 2017年7月18日 start-------------
tmp1:=upper('BD_JURY_MEMBER');
tmp2:=upper('CARDNO');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(40)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证号''';
end if;

tmp1:=upper('BD_JURY_MEMBER');
tmp2:=upper('MAJORMC');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(4000)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专业-名称''';
end if;

tmp1:=upper('BD_JURY_MEMBER');
tmp2:=upper('SOURCESREMARK');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(4000)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''来源''';
end if;

tmp1:=upper('BD_JURY');
tmp2:=upper('MEMBERFILE');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家信息表上传-附件''';
end if;

tmp1:=upper('BD_JURY');
tmp2:=upper('MEMBERFILENAME');
num:=0; -- 注意：查询前必须初始化此变量
select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
if num = 0 then
   execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家信息表上传-附件名称''';
end if;

    -----------add by hejw 2017年7月18日 end-------------

    ------------add by songw 2017年7月18日 start-------------
    --招标参数设置的专家确定方式增加线下选取专家，增加原因，附件等字段
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('OSEREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确定方式为线下选取专家的原因''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('OSEFILEPATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确定方式为线下选取专家的原因附件路径''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('OSEFILENAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确定方式为线下选取专家的原因附件名称''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('CSSZSTATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''参数设置状态（当专家确定方式为线下选取专家需要平台审核） 1-已保存  3-平台审核不通过 5-待平台审核 7-平台审核通过''';
    end if;

    ------------add by songw 2017年7月18日 end-------------

    ------------add by hejw 2017年7月25日 start-------------
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('REFUNDAMOUNT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(26,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理服务费实际已退款金额 ''';
    end if;

    tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('KAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(26,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''扣款金额''';
    end if;

    tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('REFUNDAMOUNT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' NUMBER(26,2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理服务费实际已退款金额 ''';
    end if;
    ------------add by hejw 2017年7月25日 end-------------

    ------------add by songw 2017年7月27日 start---------------
    --澄清公告发布最高限价相关字段
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('INFLUENCEFLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''澄清公告-是否影响文件编制 1-是（必须在资格预审申请截止时间3日前或投标截止时间15日前发布公告）0 or null-否(可以在截止时间前任意时间发出)''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('MAXBIDPRICEFLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否设定最高投标限价 1-是 0 or null-否''';
    end if;
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('MAXBIDPRICE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高投标限价''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('MAXBIDPRICE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高投标限价''';
    end if;

    ------------add by songw 2017年7月27日 end---------------

    ------------add by lijb 2017年7月31日 start--------------
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('AUDITREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台审核理由''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('AUDITREASON');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台审核理由''';
    end if;

    tmp1:=upper('BD_PROJECT');
    tmp2:=upper('NEWDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''新建时间''';
    end if;

    tmp1:=upper('BD_PROJECT_EXT');
    tmp2:=upper('OPERATIONTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作类型(1:新增,2:修改,3,删除)''';
    end if;
    ------------add by lijb 2017年7月31日 end--------------

    -----------add by songw 2017年8月2日 start-----------------
    --增加参数设置提交后台审核时间字段
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('SUBMITAUDITDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交后台审核时间''';
    end if;
    -----------add by songw 2017年8月2日 end-----------------

    ------------add by lijb 2017年8月1日 start-------------
    -- 增加委员会扩展表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_JURY_EXT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_JURY_EXT
        (
          WYHDM        VARCHAR2(100),
          OPTID        VARCHAR2(50),
          OPTID001    VARCHAR2(50),
          OPTNAME001  VARCHAR2(50),
          OPTDATE001  DATE,
          OPTID002    VARCHAR2(50),
          OPTNAME002  VARCHAR2(50),
          OPTDATE002  DATE,
          OPTNAME003  VARCHAR2(50),
          OPTNAME004  VARCHAR2(50),
          OPTID005    VARCHAR2(50),
          OPTNAME005  VARCHAR2(50),
          OPTDATE005  DATE
        )';
        execute immediate 'comment on table BD_JURY_EXT is ''委员会扩展表''';
        execute immediate 'comment on column BD_JURY_EXT.WYHDM is ''委员会编号''';
        execute immediate 'comment on column BD_JURY_EXT.OPTID is ''保存基本信息操作员编号''';
        execute immediate 'comment on column BD_JURY_EXT.OPTID001 is ''选择标段包操作员编号''';
        execute immediate 'comment on column BD_JURY_EXT.OPTNAME001 is ''选择标段包操作员名称''';
        execute immediate 'comment on column BD_JURY_EXT.OPTDATE001 is ''选择标段包操作时间''';
        execute immediate 'comment on column BD_JURY_EXT.OPTID002 is ''指定专家操作员编号''';
        execute immediate 'comment on column BD_JURY_EXT.OPTNAME002 is ''指定专家操作员名称''';
        execute immediate 'comment on column BD_JURY_EXT.OPTDATE002 is ''指定专家操作时间''';
        execute immediate 'comment on column BD_JURY_EXT.OPTNAME003 is ''专家抽取 循环抽操作员名称''';
        execute immediate 'comment on column BD_JURY_EXT.OPTNAME004 is ''确定指定专家操作员名称''';
        execute immediate 'comment on column BD_JURY_EXT.OPTID005 is ''增加规避单位操作员编号''';
        execute immediate 'comment on column BD_JURY_EXT.OPTNAME005 is ''增加规避单位操作员名称''';
        execute immediate 'comment on column BD_JURY_EXT.OPTDATE005 is ''增加规避单位操作时间''';
    end if;

    -- 抽取专家条件相关字段
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存抽取条件操作员编号''';
    end if;

    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存抽取条件操作员名称''';
    end if;

    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存抽取条件操作时间''';
    end if;

    -- 委员会相关字段
    tmp1:=upper('BD_JURY');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''完成并短信发送操作员编号''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''完成并短信发送操作员名称''';
    end if;

    tmp1:=upper('BD_JURY');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''完成并短信发送操作时间''';
    end if;

    -- 专家相关字段
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''补抽专家操作员编号''';
    end if;

    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''补抽专家操作员名称''';
    end if;

    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''补抽专家操作时间''';
    end if;

    -- 评委相关字段
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存评委维护信息操作员编号''';
    end if;

    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存评委维护信息操作员名称''';
    end if;

    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存评委维护信息操作时间''';
    end if;

    -- 投标报名相关字段
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送投标邀请书清除签章操作员编号''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送投标邀请书清除签章操作员名称''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送投标邀请书清除签章操作时间''';
    end if;

     -- 投标邀请书编制相关字段

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('FBAUTHORNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邀请书发布人名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存新增编制操作员编号''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存新增编制操作员名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存修改后的代资格审核通过通知书操作员编号''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存修改后的代资格审核通过通知书操作员名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTDATE002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存修改后的代资格审核通过通知书操作时间''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTID003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存及修改投标邀请书操作员编号''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTNAME003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存及修改投标邀请书操作员名称''';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('OPTDATE003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存及修改投标邀请书操作时间''';
    end if;

    -- 招标公告/资格预审公告扩展相关字段
    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTID003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存后审公告编制操作员编号''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTNAME003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存后审公告编制操作员名称''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('DEPTID003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存后审公告编制操作员部门编号''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('DEPTNAME003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存后审公告编制操作员部门名称''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTDATE003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存后审公告编制操作时间''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTID004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告编制更新制操作员编号''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTNAME004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告编制更新操作员名称''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('DEPTID004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告编制更新操作员部门编号''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('DEPTNAME004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告编制更新操作员部门名称''';
    end if;

    tmp1:=upper('BD_ZBGG_EXT');
    tmp2:=upper('OPTDATE004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告编制更新操作时间''';
    end if;

    -- 招标项目- 邀请后审- 标段（包）邀请单位相关字段
    tmp1:=upper('BD_PACKAGE_YQDW');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称''';
    end if;

     -- 投标资料表相关字段
    tmp1:=upper('BD_FB_TBZLB');
    tmp2:=upper('CZYDMNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建操作员名称''';
    end if;

    -- 标段（包）扩展表相关字段
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回招标文件操作员编号''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回招标文件操作员名称''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE007');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构撤回招标文件操作时间''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方取消确认招标文件操作员编号''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方取消确认招标文件操作员名称''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE008');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方取消确认招标文件操作时间''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID009');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方签章确认后撤销招标文件操作员编号''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME009');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方签章确认后撤销招标文件操作员名称''';
    end if;

    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE009');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方签章确认后撤销招标文件操作时间''';
    end if;

    -- 确认的招标文件相关字段
    tmp1:=upper('BD_FB_TB_FILE');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件确认操作员编号''';
    end if;

    tmp1:=upper('BD_FB_TB_FILE');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件确认操作员名称''';
    end if;

    -- 标段（包）相关字段
    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZJWHFID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家维护费操作员编号''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZJWHFNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家维护费操作员名称''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('ZJWHFDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家维护费操作时间''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('DBRQID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标操作员编号''';
    end if;

    tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('DBRQNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标操作员名称''';
    end if;

    -- 招标公告/资格预审公告扩展相关字段
    tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布中标候选人公示操作员编号''';
    end if;

    tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布中标候选人公示操作员名称''';
    end if;

    -- 增加招标候选人公示扩展表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_DB_HXRGS_EXT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_DB_HXRGS_EXT
        (
          PACKID      VARCHAR2(22),
          OPTID001    VARCHAR2(50),
          OPTNAME001  VARCHAR2(100),
          OPTDATE001  DATE,
          OPTID002    VARCHAR2(50),
          OPTNAME002  VARCHAR2(100),
          OPTDATE002  DATE
        )';
        execute immediate 'comment on table BD_DB_HXRGS_EXT is ''招标候选人公示扩展表''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.PACKID is ''标段包编号''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTID001 is ''保存中标候选人公示操作员编号''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTNAME001 is ''保存中标候选人公示操作员名称''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTDATE001 is ''保存中标候选人公示操作时间''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTID002 is ''修改中标候选人公示信息操作员编号''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTNAME002 is ''修改中标候选人公示信息操作员名称''';
        execute immediate 'comment on column BD_DB_HXRGS_EXT.OPTDATE002 is ''修改中标候选人公示信息操作时间''';
    end if;

    -- （货物中标和工程中标和招标结果）通知书相关字段
    tmp1:=upper('BD_HGZJTZS');
    tmp2:=upper('FCID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送人编号''';
    end if;

    tmp1:=upper('BD_HGZJTZS');
    tmp2:=upper('FCNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送人名称''';
    end if;

    -- 增加（货物中标和工程中标和招标结果）通知书扩展表
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_HGZJTZS_EXT');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_HGZJTZS_EXT
        (
          PROBID      VARCHAR2(200),
          OPTID001    VARCHAR2(50),
          OPTNAME001  VARCHAR2(100),
          OPTDATE001  DATE,
          OPTID002    VARCHAR2(50),
          OPTNAME002  VARCHAR2(100),
          OPTDATE002  DATE,
          OPTID003    VARCHAR2(50),
          OPTNAME003  VARCHAR2(100),
          OPTDATE003  DATE,
          OPTID004    VARCHAR2(50),
          OPTNAME004  VARCHAR2(100),
          OPTDATE004  DATE,
          OPTID005    VARCHAR2(50),
          OPTNAME005  VARCHAR2(100),
          OPTDATE005  DATE
        )';
        execute immediate 'comment on table BD_HGZJTZS_EXT is ''（货物中标和工程中标和招标结果）通知书扩展表''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.PROBID is ''招标项目编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTID001 is ''招标结果通知书保存操作员编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTNAME001 is ''招标结果通知书保存操作员名称''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTDATE001 is ''招标结果通知书保存操作时间''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTID002 is ''招标结果通知书修改操作员编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTNAME002 is ''招标结果通知书修改操作员名称''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTDATE002 is ''招标结果通知书修改操作时间''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTID003 is ''中标通知书保存操作员编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTNAME003 is ''中标通知书保存操作员名称''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTDATE003 is ''中标通知书保存操作时间''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTID004 is ''中标通知书修改操作员编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTNAME004 is ''中标通知书修改操作员名称''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTDATE004 is ''中标通知书修改操作时间''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTID005 is ''发送中标通知书操作员编号''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTNAME005 is ''发送中标通知书操作员名称''';
        execute immediate 'comment on column BD_HGZJTZS_EXT.OPTDATE005 is ''发送中标通知书操作时间''';
    end if;

    -- 中标结果公告相关字段
    tmp1:=upper('BD_DB_ZBJGGG');
    tmp2:=upper('GGID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标结果公告操作员编号''';
    end if;

    tmp1:=upper('BD_DB_ZBJGGG');
    tmp2:=upper('GGNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标结果公告操作员名称''';
    end if;

    -- 购买文件的订单相关字段
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方确认投标方线下的履约保证金支付操作员编号''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方确认投标方线下的履约保证金支付操作员名称''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方确认投标方线下的履约保证金支付操作时间''';
    end if;

    -- 合同主表相关字段
    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTTJROPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同提交人操作员名称''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTTJROPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同提交人操作时间''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTQROPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同确认人操作员名称''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTQROPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同确认人操作时间''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTBHOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同驳回操作员编号''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTBHOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同驳回操作员名称''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('HTBHOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同驳回操作时间''';
    end if;

    -- 合同主表合同条款相关字段
    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改保存合同履约登记信息操作员编号''';
    end if;

    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改保存合同履约登记信息操作员名称''';
    end if;

    tmp1:=upper('BD_CONTRACT_ITEM');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改保存合同履约登记信息操作时间''';
    end if;

    ------------add by lijb 2017年8月4日 end---------------

    ------------add by lijb 2017年8月7日 start-------------

    -- 购买文件的订单相关字段
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请资格预审文件-申请付款-操作员编号''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请资格预审文件-申请付款-操作员名称''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''申请资格预审文件-申请付款-操作时间''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''财务付钱-操作员编号''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''财务付钱-操作员名称''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTID003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付保证金-操作员编号''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTNAME003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付保证金-操作员名称''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTID004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改订单信息-操作员编号''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTNAME004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改订单信息-操作员名称''';
    end if;

    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('OPTDATE004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''修改订单信息-操作时间''';
    end if;

    -- 购买文件的订单相关字段
    tmp1:=upper('BD_HZJL');
    tmp2:=upper('OPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回资格预审申请文件-操作员编号''';
    end if;

    tmp1:=upper('BD_HZJL');
    tmp2:=upper('OPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回资格预审申请文件-操作员名称''';
    end if;

    tmp1:=upper('BD_HZJL');
    tmp2:=upper('OPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回资格预审申请文件-操作时间''';
    end if;

    -- 投标报名相关字段
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审通过通知书-签章提交-操作员编号''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审通过通知书-签章提交-操作员名称''';
    end if;

    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('OPTDATE002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审通过通知书-签章提交-操作时间''';
    end if;

    -- 合同主表相关字段
    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('BCHTOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存合同-操作员编号''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('BCHTOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存合同-操作员名称''';
    end if;

    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('BCHTOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存合同-操作时间''';
    end if;

    -- 招标结束公告相关字段
    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ZBFSIGNERNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方签章人名称''';
    end if;

    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('YCOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异常创建操作员名称''';
    end if;

    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ZZGGOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止公告-编制保存-操作员编号''';
    end if;

    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ZZGGOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止公告-编制保存-操作员名称''';
    end if;

    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ZZGGOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''终止公告-编制保存-操作时间''';
    end if;

    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('DLJGSIGNERNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构签章人名称''';
    end if;

    -- 投标方澄清文件相关字段
    tmp1:=upper('BD_CC_RECEIPT');
    tmp2:=upper('HZOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回执确认操作员编号''';
    end if;

    tmp1:=upper('BD_CC_RECEIPT');
    tmp2:=upper('HZOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回执确认操作员名称''';
    end if;

    tmp1:=upper('BD_CC_RECEIPT');
    tmp2:=upper('HZOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回执确认操作时间''';
    end if;

    -- 澄清/变更公告相关字段
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('SHRNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''公告发布责任人名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJSHOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告-提交审核-操作员编号''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJSHOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告-提交审核-操作员名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJSHOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告-提交审核-操作时间''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJPTYZOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告提交-平台验证-操作员编号''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJPTYZOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告提交-平台验证-操作员名称''';
    end if;

    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('TJPTYZOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审变更公告提交-平台验证-操作时间''';
    end if;

    -- 异议相关字段
    tmp1:=upper('BD_OBJECTION');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议受理-操作员编号''';
    end if;

    tmp1:=upper('BD_OBJECTION');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议受理-操作员名称''';
    end if;

    tmp1:=upper('BD_OBJECTION');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存异议回复-操作员编号''';
    end if;

    tmp1:=upper('BD_OBJECTION');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存异议回复-操作员名称''';
    end if;

    -- 异议受理提问相关字段
    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('SLTWOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''受理提问信息-操作员编号''';
    end if;

    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('SLTWOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''受理提问信息-操作员名称''';
    end if;

    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('SLTWOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''受理提问信息-操作时间''';
    end if;

    -- 评委审查表相关字段
    tmp1:=upper('BD_JURY_CENSOR');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存审查结果-操作员编号''';
    end if;

    tmp1:=upper('BD_JURY_CENSOR');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存审查结果-操作员名称''';
    end if;

    ------------add by lijb 2017年8月8日 end---------------
    ------------add by hejw 2017年8月8日 Start---------------
    tmp1:=upper('BD_JURY');
    tmp2:=upper('PAUSEEXTRACTION');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''暂停抽取 1-停止  0orNull-正常''';
    end if; 
    ------------add by hejw 2017年8月8日 end---------------
    ------------add by lijb 2017年8月9日 start-------------
    -- 标段包扩展表相关字段
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID010');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存终止评审/评标报告信息操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME010');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存终止评审/评标报告信息操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE010');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存终止评审/评标报告信息操作时间'''; 
    end if;
    
    -- 委员会签名表相关字段
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('ZZBGOPT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交评审/评标终止报告操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('ZZBGOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交评审/评标终止报告操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('ZZBGOPTDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交评审/评标终止报告操作时间'''; 
    end if;
    
    -- 审核记录表相关字段
    tmp1:=upper('BD_AUDIT_RECORDS');
    tmp2:=upper('COPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''操作员名称'''; 
    end if;
    
    -- 招标项目扩展表相关字段
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('OPTNAME02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核代理机构-操作员名称'''; 
    end if;
    
    -- 招标公告/资格预审公告表相关字段
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('OPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台-资格预审公告审核-操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('OPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台-资格预审公告审核-操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('OPTDATE001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台-资格预审公告审核-操作时间'''; 
    end if;
    
    -- 委员会专家表相关字段
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTID002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台修改出席专家临时不出席-操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTNAME002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台修改出席专家临时不出席-操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('OPTDATE002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后台修改出席专家临时不出席-操作时间'''; 
    end if;
    
    -- 退款申请表相关字段
    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('COPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建人名称'''; 
    end if;
    tmp1:=upper('BD_REFUND_APPLY');
    tmp2:=upper('SHOPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核人名称'''; 
    end if;
    
    ------------add by lijb 2017年8月9日 end---------------

    -----------add by songw 2017年8月8日 start------------------
    -- 订单信息表中增加线下支付-附属帐号信息
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('BCUSTACCT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''线下支付-附属帐号信息'''; 
    end if;
    -----------add by songw 2017年8月8日 end------------------

    ------------add by lijb 2017年8月10日 start-------------
    -- 标段包扩展表相关字段
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID011');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回终止评标报告操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME011');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回终止评标报告操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE011');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''撤回终止评标报告操作时间'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID012');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''主任发送报告给其他专家操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME012');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''主任发送报告给其他专家操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE012');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''主任发送报告给其他专家操作时间'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTID013');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(50)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评审报告操作员编号'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTNAME013');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评审报告操作员名称'''; 
    end if;
    
    tmp1:=upper('BD_PACKAGE_EXT');
    tmp2:=upper('OPTDATE013');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评审报告操作时间'''; 
    end if;
    
    -- 委员会签名表相关字段
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('DATE05');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交评审汇总时间'''; 
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('DATE06');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''复议/重新评审（主任操作）时间'''; 
    end if;
    
    tmp1:=upper('BD_JURY_SIGN');
    tmp2:=upper('PUSHDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''推荐时间'''; 
    end if;
    
    -- 合同主表相关字段
    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('BCHTDEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存合同部门编号'''; 
    end if;
    
    tmp1:=upper('BD_CONTRACT');
    tmp2:=upper('BCHTDEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存合同部门名称'''; 
    end if;
    
    -- 投标文件表相关字段
    tmp1:=upper('BD_FB_TB_FILE');
    tmp2:=upper('CDEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门编号'''; 
    end if;
    
    tmp1:=upper('BD_FB_TB_FILE');
    tmp2:=upper('CDEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门名称'''; 
    end if;
    
    -- 中标结果公告表相关字段
    tmp1:=upper('BD_DB_ZBJGGG');
    tmp2:=upper('DEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标结果公告部门编号'''; 
    end if;
    
    tmp1:=upper('BD_DB_ZBJGGG');
    tmp2:=upper('DEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标结果公告部门名称'''; 
    end if;
    
    -- 招标候选人公示扩展表相关字段
    tmp1:=upper('BD_DB_HXRGS_EXT');
    tmp2:=upper('DEPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标候选人公示部门编号'''; 
    end if;
    
    tmp1:=upper('BD_DB_HXRGS_EXT');
    tmp2:=upper('DEPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存中标候选人公示部门名称'''; 
    end if;
    
    -- 评标模板-标段（包）表相关字段
    tmp1:=upper('BD_MB_PBMB_BAK');
    tmp2:=upper('DEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门编号'''; 
    end if;
    
    tmp1:=upper('BD_MB_PBMB_BAK');
    tmp2:=upper('DEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门名称'''; 
    end if;
    
    -- 投标资料表相关字段
    tmp1:=upper('BD_FB_TBZLB');
    tmp2:=upper('DEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门编号'''; 
    end if;
    
    tmp1:=upper('BD_FB_TBZLB');
    tmp2:=upper('DEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建部门名称'''; 
    end if;
    
    -- 投标邀请书编制表相关字段
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('DEPTID001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存新增编制部门编号'''; 
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('DEPTNAME001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存新增编制部门名称'''; 
    end if;
    
    -- 委员会扩展表(操作记录)相关字段
    tmp1:=upper('BD_JURY_EXT');
    tmp2:=upper('DEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存基本信息部门编号'''; 
    end if;
    
    tmp1:=upper('BD_JURY_EXT');
    tmp2:=upper('DEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存基本信息部门名称'''; 
    end if;
    
    -- 评审办法模板相关字段
    tmp1:=upper('BD_MB_PSBF');
    tmp2:=upper('DEPTID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门编号'''; 
    end if;
    
    tmp1:=upper('BD_MB_PSBF');
    tmp2:=upper('DEPTNAME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''部门名称'''; 
    end if;
    
    --修改
    tmp1:=upper('BD_DB_HXRGS_EXT');
    tmp2:=upper('PACKID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(100))';
    end if;
    ------------add by lijb 2017年8月10日 end---------------

    -------------add by songw 2017年8月14日 start--------------------
    -- 增加专家信息相关字段
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('IDCARDFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''身份证件上传'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('CREDITCODE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''纳税人识别号（统一社会信用代码）'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('TITLECERTFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职称证书上传'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('GRADUATIONDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''毕业时间'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('DIPLOMAFILE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学历证书上传'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('MAJORINSTUDY');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''所学专业'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('NOWMAJOR');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''现从事专业'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('WORKTEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''单位电话'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('HOMETEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''家庭电话'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('FAX');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''传真'''; 
    end if;
    
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('NVQ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职业资格证书编号'''; 
    end if;
    
    -- 增加专家信息临时表，用于导出批量导入专家中不符合的专家信息
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_EXPERT_TEMP');
    select count(1) into num from user_tables where table_name=tmp1;
    if num = 0 then
    -- 建表
        execute immediate '
        create table BD_EXPERT_TEMP  (
              PKID           NUMBER,
              ZJDM           VARCHAR2(17),
              ZJMC           VARCHAR2(50),
              CDATE          DATE,
              BIRTH_DATE     DATE,
              AGE            NUMBER(6),
              SEX            CHAR(1),
              CARD_TYPE      CHAR(2),
              CARD_NUM       VARCHAR2(30),
              DQ_CODE1       VARCHAR2(6),
              DQ_NAME1       VARCHAR2(30),
              DQ_CODE2       VARCHAR2(6),
              DQ_NAME2       VARCHAR2(30),
              DQ_CODE3       VARCHAR2(6),
              DQ_NAME3       VARCHAR2(30),
              ADDRESS        VARCHAR2(100),
              POSTCODE       VARCHAR2(6),
              LXTEL          VARCHAR2(100),
              EMAIL          VARCHAR2(100),
              IS_JOB         VARCHAR2(1),
              UNIT_NAME      VARCHAR2(100),
              POSITION       VARCHAR2(50),
              LASTSCHOOL     VARCHAR2(100),
              DEGREE         VARCHAR2(30),
              MAJOR          VARCHAR2(1000),
              WORK_YEARS     NUMBER(2),
              JSZC           VARCHAR2(50),
              ZYZGXL         VARCHAR2(50),
              HYDM           VARCHAR2(50),
              CZYDM          VARCHAR2(30),
              ZYZGDJ         VARCHAR2(50),
              ZJLY           NUMBER(10),
              RESUME         CLOB,
              BONUS_MALUS    CLOB,
              QYFLAG         VARCHAR2(10),
              XLZSBH         VARCHAR2(200),
              ZCZSBH         VARCHAR2(200),
              ZCDJZSBH       VARCHAR2(200),
              ZJBH           VARCHAR2(18),
              CARD_NUM_TMP   VARCHAR2(18),
              ORIGIN         VARCHAR2(200),
              SUBSYSTEM      VARCHAR2(30),
              IDCARDFILE     VARCHAR2(200),
              CREDITCODE     VARCHAR2(20),
              TITLECERTFILE  VARCHAR2(200),
              GRADUATIONDATE DATE,
              DIPLOMAFILE    VARCHAR2(200),
              MAJORINSTUDY   VARCHAR2(100),
              NOWMAJOR       VARCHAR2(100),
              WORKTEL        VARCHAR2(20),
              HOMETEL        VARCHAR2(20),
              FAX            VARCHAR2(20),
              NVQ            VARCHAR2(100),
              ERRORINFO      VARCHAR2(4000),
              constraint PK_BD_EXPERT_TEMP primary key (PKID)
        )';
            execute immediate 'comment on column BD_EXPERT_TEMP.PKID  is ''自增主键''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZJDM  is ''专家代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZJMC  is ''专家名称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.CDATE  is ''创建日期''';
            execute immediate 'comment on column BD_EXPERT_TEMP.BIRTH_DATE  is ''出生年月日YYYYMMDD''';
            execute immediate 'comment on column BD_EXPERT_TEMP.AGE  is ''年龄''';
            execute immediate 'comment on column BD_EXPERT_TEMP.SEX  is ''性别 1-男性 2-女性''';
            execute immediate 'comment on column BD_EXPERT_TEMP.CARD_TYPE  is ''证件类型 01-身份证''';
            execute immediate 'comment on column BD_EXPERT_TEMP.CARD_NUM  is ''证件号码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_CODE1  is ''省代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_NAME1  is ''省名称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_CODE2  is ''市代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_NAME2  is ''市名称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_CODE3  is ''县代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DQ_NAME3  is ''县名称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ADDRESS  is ''详细地址''';
            execute immediate 'comment on column BD_EXPERT_TEMP.POSTCODE  is ''邮政编码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.LXTEL  is ''联系电话''';
            execute immediate 'comment on column BD_EXPERT_TEMP.EMAIL  is ''邮箱地址''';
            execute immediate 'comment on column BD_EXPERT_TEMP.IS_JOB  is ''是否在职 1-是 0-否''';
            execute immediate 'comment on column BD_EXPERT_TEMP.UNIT_NAME  is ''所在单位名称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.POSITION  is ''职务''';
            execute immediate 'comment on column BD_EXPERT_TEMP.LASTSCHOOL  is ''毕业院校''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DEGREE  is ''学历''';
            execute immediate 'comment on column BD_EXPERT_TEMP.MAJOR  is ''专业''';
            execute immediate 'comment on column BD_EXPERT_TEMP.WORK_YEARS  is ''从业年限（工龄）''';
            execute immediate 'comment on column BD_EXPERT_TEMP.JSZC  is ''技术职称''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZYZGXL  is ''职业资格序列''';
            execute immediate 'comment on column BD_EXPERT_TEMP.HYDM  is ''会员代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.CZYDM  is ''操作员代码 操作员代码''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZYZGDJ  is ''职业资格等级''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZJLY  is ''专家来源  平台库/公共库''';
            execute immediate 'comment on column BD_EXPERT_TEMP.RESUME  is ''工作简历''';
            execute immediate 'comment on column BD_EXPERT_TEMP.BONUS_MALUS  is ''奖惩记录''';
            execute immediate 'comment on column BD_EXPERT_TEMP.QYFLAG  is ''专家是否启用标志  0-暂停 1-启用''';
            execute immediate 'comment on column BD_EXPERT_TEMP.XLZSBH  is ''学历证书编号''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZCZSBH  is ''职称证书编号''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZCDJZSBH  is ''注册登记证书编号''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ZJBH  is ''专家编号，编码长度为18''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ORIGIN  is ''专家来源''';
            execute immediate 'comment on column BD_EXPERT_TEMP.SUBSYSTEM  is ''子平台标识-表示是哪个子平台的数据''';
            execute immediate 'comment on column BD_EXPERT_TEMP.IDCARDFILE  is ''身份证件上传''';
            execute immediate 'comment on column BD_EXPERT_TEMP.CREDITCODE  is ''纳税人识别号（统一社会信用代码）''';
            execute immediate 'comment on column BD_EXPERT_TEMP.TITLECERTFILE  is ''职称证书上传''';
            execute immediate 'comment on column BD_EXPERT_TEMP.GRADUATIONDATE  is ''毕业时间''';
            execute immediate 'comment on column BD_EXPERT_TEMP.DIPLOMAFILE  is ''学历证书上传''';
            execute immediate 'comment on column BD_EXPERT_TEMP.MAJORINSTUDY  is ''所学专业''';
            execute immediate 'comment on column BD_EXPERT_TEMP.NOWMAJOR  is ''现从事专业''';
            execute immediate 'comment on column BD_EXPERT_TEMP.WORKTEL  is ''单位电话''';
            execute immediate 'comment on column BD_EXPERT_TEMP.HOMETEL  is ''家庭电话''';
            execute immediate 'comment on column BD_EXPERT_TEMP.FAX  is ''传真''';
            execute immediate 'comment on column BD_EXPERT_TEMP.NVQ  is ''职业资格证书编号''';
            execute immediate 'comment on column BD_EXPERT_TEMP.ERRORINFO  is ''错误信息''';
     end if;
     
    num:=0;
    tmp1:=upper('BD_EXPERT_TEMP_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
        execute immediate 'create sequence BD_EXPERT_TEMP_0
            minvalue 1
            maxvalue 9999999999999999999999999999
            start with 1
            increment by 1
            nocache
            order
      ';
    end if;
     
    -------------add by songw 2017年8月14日 end--------------------
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

  -------------------------------------------------------------
end;
