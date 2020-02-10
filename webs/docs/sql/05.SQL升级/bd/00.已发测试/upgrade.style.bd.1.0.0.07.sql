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
   
    tmp1:=upper('BD_HZJL');
  tmp2:=upper('FNAME02');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(1000))';
  end if;
  
  tmp1:=upper('BD_HZJL');
  tmp2:=upper('FNAME03');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(1000))';
  end if;
  
  
  tmp1:=upper('BD_PACKAGE_YQDW');
  tmp2:=upper('YQTYPE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3))';
  execute immediate 'comment on column BD_PACKAGE_YQDW.YQTYPE is ''类型  1-邀请-邀请单位  2-公开预审邀请单位''';
  end if;
  
  -- BD_MB_PBMB_BAK 增加 评审办法分类 字段
  tmp1:=upper('BD_MB_PBMB_BAK');
  tmp2:=upper('PSBFFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审办法分类 1-合格制 2-有限数量制''';
  end if;
  -- BD_MB_PBMB_BAK 增加 评审办法分步 字段
  tmp1:=upper('BD_MB_PBMB_BAK');
  tmp2:=upper('PSBFFB');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审办法分步 1-两步法 2-三步法''';
  end if;
  
  -- BD_MB_PBMB 增加 评审办法分类 字段
  tmp1:=upper('BD_MB_PBMB');
  tmp2:=upper('PSBFFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审办法分类 1-合格制 2-有限数量制''';
  end if;
  -- BD_MB_PBMB 增加 评审办法分步 字段
  tmp1:=upper('BD_MB_PBMB');
  tmp2:=upper('PSBFFB');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审办法分步 1-两步法 2-三步法''';
  end if;
  
  -- BD_MB_PBMB_XZ_MX_BAK 增加 是否符合原因 字段
  tmp1:=upper('BD_MB_PBMB_XZ_MX_BAK');
  tmp2:=upper('ISACCORDYY');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否符合原因 1-两步法 2-三步法''';
  end if;
  
  -- BD_MB_PBMB_BAK 增加 招标项目分类 字段
  tmp1:=upper('BD_MB_PBMB_BAK');
  tmp2:=upper('ZBFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目分类 1-货物 2-工程 3-服务''';
  end if;
  -- BD_MB_PBMB_BAK 增加 评标办法分类 字段
  tmp1:=upper('BD_MB_PBMB_BAK');
  tmp2:=upper('PBBFFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标办法分类 1-综合评估法 2-经评审的最低投标价法(货物/工程)''';
  end if;
  
  -- BD_MB_PBMB 增加 招标项目分类 字段
  tmp1:=upper('BD_MB_PBMB');
  tmp2:=upper('ZBFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目分类 1-货物 2-工程 3-服务''';
  end if;
  -- BD_MB_PBMB 增加 评标办法分类 字段
  tmp1:=upper('BD_MB_PBMB');
  tmp2:=upper('PBBFFL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标办法分类 1-综合评估法 2-经评审的最低投标价法(货物/工程)''';
  end if;
  
  -- BD_MB_PBMB_XZ_BAK 增加 总分值 字段
  tmp1:=upper('BD_MB_PBMB_XZ_BAK');
  tmp2:=upper('TOTALFZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(10,6) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''总分值''';
  end if;
  -- BD_MB_PBMB_XZ 增加 总分值 字段
  tmp1:=upper('BD_MB_PBMB_XZ');
  tmp2:=upper('TOTALFZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(10,6) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''总分值''';
  end if;
  
  -- BD_MB_PBMB_XZ_MX_BAK 增加 评标基准价 字段
  tmp1:=upper('BD_MB_PBMB_XZ_MX_BAK');
  tmp2:=upper('PBJZJ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标基准价''';
  end if;
  -- BD_MB_PBMB_XZ_MX_BAK 增加 投标报价偏差率 字段
  tmp1:=upper('BD_MB_PBMB_XZ_MX_BAK');
  tmp2:=upper('TBBJPCL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标报价偏差率''';
  end if;
  
  -- BD_MB_PBMB_XZ_BAK 修改 审查类型 字段备注
  tmp1:=upper('BD_MB_PBMB_XZ_BAK');
  tmp2:=upper('SCLX');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查类型 1-初审(评审办法) 2-祥审(评审办法) 3-评分(评审办法) 
     11-初审:形式评审(评标办法) 12-初审:资格评审(评标办法) 13-初审:响应性评审(评标办法) 
     21-详审:分值构成(评标办法) 22-详审:评标基准价(评标办法) 23-详审:投标报价偏差率(评标办法)
     24-详审:施工组织设计(评标办法) 25-详审:项目管理机构(评标办法) 26-详审:投标报价(评标办法) 27-详审:其他评分因素(评标办法)''';
  end if;  
  -- BD_MB_PBMB_XZ 修改 审查类型 字段备注
  tmp1:=upper('BD_MB_PBMB_XZ');
  tmp2:=upper('SCLX');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查类型 1-初审(评审办法) 2-祥审(评审办法) 3-评分(评审办法) 
     11-初审:形式评审(评标办法) 12-初审:资格评审(评标办法) 13-初审:响应性评审(评标办法) 
     21-详审:分值构成(评标办法) 22-详审:评标基准价(评标办法) 23-详审:投标报价偏差率(评标办法)
     24-详审:施工组织设计(评标办法) 25-详审:项目管理机构(评标办法) 26-详审:投标报价(评标办法) 27-详审:其他评分因素(评标办法)''';
  end if;  
  
  ---add by chenxp 变更公告 start--
  tmp1:=upper('bd_ccnotice');
    tmp2:=upper('jyptyzDate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
         execute immediate 'comment on column bd_ccnotice.jyptyzDate is ''交易平台验证时间'' ';
    end if;
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('jyptyzrName');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column bd_ccnotice.jyptyzrName is ''交易平台验证人名称'' ';
    end if;
  ---add by chenxp 变更公告 end---

  
  --add  by  chenxp 专家信息 start---
  ---专家信息
    tmp1:=upper('bd_expert');
    tmp2:=upper('qyflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家是否启用标志  0-暂停 1-启用''';
    end if;
    
    tmp1:=upper('bd_expert');
    tmp2:=upper('xlzsbh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''学历证书编号''';
    end if;
    
    tmp1:=upper('bd_expert');
    tmp2:=upper('zczsbh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''职称证书编号''';
    end if;
    
    tmp1:=upper('bd_expert');
    tmp2:=upper('zcdjzsbh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''注册登记证书编号''';
    end if;
  --add  by  chenxp 专家信息 end-----
  ----add by xuz start-------
  tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('tbxjdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标限价单位''';
    end if;
    ----add by xuz end--------
    
    ----审查表添加审查阶段字段---BY。zhminfu-----------
    tmp1:=upper('BD_JURY_CENSOR');
    tmp2:=upper('STAGE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审查阶段 1-初审 2-详审 3-评分''';
    end if;
  
  ------------------cheny 2016/08/15 项目采购清单--start-----------------------------
    tmp1:=upper('bd_package_item');
    tmp2:=upper('issuccess');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
     execute immediate 'comment on column BD_PACKAGE_ITEM.ISSUCCESS is ''是否中标1是，0 or other 否''';
    end if;
  
    tmp1:=upper('bd_package_item');
    tmp2:=upper('bidprice');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,6))';
     execute immediate 'comment on column BD_PACKAGE_ITEM.BIDPRICE is ''中标价格''';
    end if;
  
    tmp1:=upper('bd_package_item');
    tmp2:=upper('remark');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(128))';
     execute immediate 'comment on column BD_PACKAGE_ITEM.REMARK is ''备注''';
    end if;
    ------------------cheny 2016/08/15项目采购清单--start-----------------------------
    ---add by xuz start--------
   tmp1:=upper('BD_TD_DD');
  tmp2:=upper('BZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(500))';
  end if;
  ---add by xuz end----------

  ---add by chenxp start 合同金额单位和币种--
  tmp1:=upper('bd_contract');
    tmp2:=upper('sumamtbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''总金额币种''';
    end if;
    
    tmp1:=upper('bd_contract');
    tmp2:=upper('sumamtdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''总金额单位''';
    end if;
  ---add by chenxp end   合同金额单位和币种--
  ---add by xuz  start---------
  tmp1:=upper('BD_CSSZ');
  tmp2:=upper('CSVALUE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(1000))';
  end if;
  
  tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('tbxjbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最高投标限价币种''';
    end if;
    
    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('tbbzjbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金币种''';
    end if;
    
     tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('lydbbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''履约担保币种''';
    end if;
  ---add by xuz  end-----------


  ---add by chenxp start 投诉----
  -- 判断投诉表是否存在
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_TSSL');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
    -- 建表
    execute immediate '
    create table BD_TSSL  (
    PKID        NUMBER  not null, 
    bdid        VARCHAR2(23),
    packname    VARCHAR2(200),
    probid      VARCHAR2(20),
    probname    VARCHAR2(100),
    hydm        VARCHAR2(30),
    hyname      VARCHAR2(200),
    tsrtel      VARCHAR2(20),
    tsremail    VARCHAR2(30),
    coptid      VARCHAR2(30),
    cdate       DATE,    
    tjoptid     VARCHAR2(30),
    tjdate      DATE,
    tscontent   CLOB,
    tsly        CLOB,
    tsfj        VARCHAR2(300),
    slr         VARCHAR2(32),
    slrname     VARCHAR2(200),
    sloptid     VARCHAR2(30),
    sldate      DATE,
    fkresult    CLOB,
    fkdate      DATE,
    fkoptid     VARCHAR2(30),
    fkfj        VARCHAR2(300),
    tsstate     VARCHAR2(10),
    constraint PK_BD_TSSL primary key (PKID)
    )
    ';    
    -- 注释      
    execute immediate ' comment on column BD_TSSL.pkid is ''唯一主键'' '; 
    execute immediate ' comment on column BD_TSSL.bdid is ''标段包编号'' ';
    execute immediate ' comment on column BD_TSSL.packname is ''标段（包）名称'' ';
    execute immediate ' comment on column BD_TSSL.probid is ''招标项目编号'' ';
    execute immediate ' comment on column BD_TSSL.probname is ''招标项目名称'' ';
    execute immediate ' comment on column BD_TSSL.hydm is ''投诉hydm'' ';
    execute immediate ' comment on column BD_TSSL.hyname is ''投诉人名称'' ';
    execute immediate ' comment on column BD_TSSL.tsrtel is ''投诉人电话'' ';
    execute immediate ' comment on column BD_TSSL.tsremail is ''投诉人电子邮箱'' ';
    execute immediate ' comment on column BD_TSSL.coptid is ''添加投诉操作员id'' ';
    execute immediate ' comment on column BD_TSSL.cdate is ''添加投诉时间'' ';
    execute immediate ' comment on column BD_TSSL.tjoptid is ''提交投诉操作员id'' ';
    execute immediate ' comment on column BD_TSSL.tjdate is ''提交投诉时间'' ';
    execute immediate ' comment on column BD_TSSL.tscontent is ''投诉内容'' ';
    execute immediate ' comment on column BD_TSSL.tsly is ''投诉依据和理由'' ';
    execute immediate ' comment on column BD_TSSL.tsfj is ''投诉附件'' ';
    execute immediate ' comment on column BD_TSSL.slr is ''受理人'' ';
    execute immediate ' comment on column BD_TSSL.slrname is ''受理人名称'' ';
    execute immediate ' comment on column BD_TSSL.sloptid is ''受理人操作员id'' ';
    execute immediate ' comment on column BD_TSSL.sldate is ''受理时间'' ';
    execute immediate ' comment on column BD_TSSL.fkresult is ''反馈结果'' ';
    execute immediate ' comment on column BD_TSSL.fkdate is ''反馈时间'' ';
    execute immediate ' comment on column BD_TSSL.fkoptid is ''反馈操作员id'' ';
    execute immediate ' comment on column BD_TSSL.fkfj is ''反馈附件'' ';
    execute immediate ' comment on column BD_TSSL.tsstate is ''投诉状态 0ornull-未提交 , 1-已提交  , 2- 已受理 , 3-已反馈'' ';
    end if; 
  
    num:=0; 
    tmp1:=upper('BD_TSSL_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_TSSL_0 
        minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order
        ';
     end if; 


    tmp1:=upper('bd_tssl');
    tmp2:=upper('tsfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投诉附件名称''';
    end if;
    
    tmp1:=upper('bd_tssl');
    tmp2:=upper('fkfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''反馈附件名称''';
    end if;
  ---add by chenxp end   投诉----
  
  --2016年8月18日20:11:49 zhangdl 招标公告表添加平台验证责任人和时间 start--
    tmp1:=upper('bd_Zbgg');
    tmp2:=upper('ptzrrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证责任人''';
    end if;
    
    tmp1:=upper('bd_Zbgg');
    tmp2:=upper('ptdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证时间''';
    end if;
    --2016年8月18日20:11:49 zhangdl 招标公告表添加平台验证责任人和时间 end--

  ---add by chenxp start---
  tmp1:=upper('bd_tssl');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(100))';
    end if;
    
    tmp1:=upper('bd_tssl');
    tmp2:=upper('probid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(100))';
    end if;
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('state');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''状态    1-待提交   2-待审核  3-已审核 4-审核未通过  5-待平台验证  6-验证通过待发布  7-平台验证未通过  8-已发布''';
    end if;
  ---add by chenxp end  ---

  ---add by hejw start  ---
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_SEAL');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
     execute immediate '
    create table BD_SEAL  (
       PKID                 INT                             not null,
       UUID                 VARCHAR2(50)                    not null,
       TYPE                 VARCHAR2(2),
       PROBID               VARCHAR2(20),
       BDID                 VARCHAR2(23),
       HYTYP                VARCHAR2(2),
       SEALDATA             CLOB,
       SEALPATH             VARCHAR2(500),
       OPT                  VARCHAR2(30),
       hydm                 VARCHAR2(10),
       cdate                DATE,
       url                  VARCHAR(500),
       remark               VARCHAR(200),                            
       constraint PK_BD_SEAL primary key (PKID)
    )
  ';

  execute immediate ' comment on table BD_SEAL is ''签章签名数据表''';
  execute immediate ' comment on column BD_SEAL.PKID is ''主键''';
  execute immediate ' comment on column BD_SEAL.UUID is ''数据关联标识''';
  execute immediate ' comment on column BD_SEAL.TYPE is ''1-签章记录   2-签名记录''';
  execute immediate ' comment on column BD_SEAL.PROBID is ''招标项目编号''';
  execute immediate ' comment on column BD_SEAL.BDID is ''标段包id''';
  execute immediate ' comment on column BD_SEAL.HYTYP is ''会员类型  1-招标方  2代理机构  3-投标人  4-专家''';
  execute immediate ' comment on column BD_SEAL.SEALDATA is ''签名数据''';
  execute immediate ' comment on column BD_SEAL.SEALPATH is ''文件服务器路径''';
  execute immediate ' comment on column BD_SEAL.opt is ''操作人''';
  execute immediate ' comment on column BD_SEAL.hydm is ''会员代码''';
  execute immediate ' comment on column BD_SEAL.cdate is ''创建时间''';
  execute immediate ' comment on column BD_SEAL.url is ''操作方法''';
  execute immediate ' comment on column BD_SEAL.remark is ''描述''';

  end if; 
  
    num:=0; 
    tmp1:=upper('BD_SEAL_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_SEAL_0 
        minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order
        ';
     end if;  
     
 tmp1:=upper('BD_SUBPROJECT'); 
  tmp2:=upper('SECTION');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(2,0))';
  execute immediate 'comment on column BD_SUBPROJECT.SECTION is ''招标项目终止，哪一步终止的   1-资格预审   2-发标  3-开标   4-评标   5-定标''';
  end if;
  
  tmp1:=upper('Bd_Seal'); 
  tmp2:=upper('cdate2');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
  execute immediate 'comment on column Bd_Seal.cdate2 is ''时间戳''';
  end if;
  
---add by hejw end  --- 

  tmp1:=upper('BD_JURY_CENSOR');
  tmp2:=upper('NODEXH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''环节序号''';
  end if; 
  
  tmp1:=upper('BD_JURY_CENSOR');
  tmp2:=upper('TKXH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''条款序号''';
  end if; 
  
  tmp1:=upper('BD_JURY_CENSOR');
  tmp2:=upper('NODELX');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10) )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''环节类型 10-评审环节 20-评分环节''';
  end if; 
  
    
  ---add by xuz start---
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('filename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
    end if;
  ---add by xuz end---

   tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人 报名''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人 确认开标记录''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('sealdata03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人 确认开标记录''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('sealdata04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构 确认开标记录''';
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审公告发布 签名关联标识''';
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''后审公告发布 签名关联标识''';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发送资格预审结果通知书 通知书发布''';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邀请-投标邀请书发布''';
    end if;
    
    tmp1:=upper('BD_FB_SURVEY');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发标-踏勘现场提交''';
    end if;
    
  tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邀请-投标邀请书发布''';
    end if;
    
    tmp1:=upper('BD_FB_SURVEY');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发标-踏勘现场提交''';
    end if;

    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提问人签名标识UUID''';
    end if;
    
    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回复人签名标识UUID''';
    end if;
    
    --投诉
    tmp1:=upper('bd_tssl');
  tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交投诉签名uuid''';
    end if;
    
    --异议
    tmp1:=upper('bd_objection');
  tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人提出异议uuid''';
    end if;
    
    --异议
    tmp1:=upper('bd_objection');
  tmp2:=upper('sealdata02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人回复异议uuid''';
    end if;
    
    --澄清文件
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发布文件签名uuid''';
    end if;
    
    tmp1:=upper('bd_cc_receipt');
  tmp2:=upper('sealpath01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人确认签章uuid''';
    end if;
    
    --报名表
    tmp1:=upper('bd_tb_signup');
  tmp2:=upper('sealdata05');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人代资格审核通过通知书确认签名uuid''';
    end if;

    
    tmp1:=upper('BD_DB_HXRGS');
  tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示 保存''';
    end if;
    
    tmp1:=upper('BD_DB_ZBJGGG');
  tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标结果公告 保存''';
    end if;
  -------------------------------------------------------------

  ------------2016/08/25 cheny 评价信息记录表 start--------------
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_EVALUATION');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_EVALUATION  (
        PKID number not null,
        hydm varchar2(30),
        userid varchar2(20),
        username varchar2(80),
        hyname varchar2(100),
        hytype varchar2(2),
        proid varchar2(17),
        probid varchar2(20),
        probname varchar2(100),
        bdid varchar2(23),
        bdname varchar2(200),
        zbfs varchar2(1),
        zbzzfs varchar2(1),
        signcontract varchar2(1),
        tohydm varchar2(20),
        tohyname varchar2(100),
        tohytype varchar2(1),
        status varchar2(1),
        relateCompliance varchar2(1),
        node varchar2(1),
        evaluation varchar2(1),
        remark varchar2(256),
        evalTime date,
       constraint PK_BD_EVALUATION primary key (PKID)
      )';
  
      execute immediate 'comment on table BD_EVALUATION is ''评价信息记录表''';
      execute immediate 'comment on column BD_EVALUATION.PKID is ''主键自增长''';
      execute immediate 'comment on column BD_EVALUATION.hydm is ''用户会员代码''';
      execute immediate 'comment on column BD_EVALUATION.userid is ''用户编号''';
      execute immediate 'comment on column BD_EVALUATION.username is ''用户名称''';
      execute immediate 'comment on column BD_EVALUATION.hyname is ''''';
      execute immediate 'comment on column BD_EVALUATION.hytype is ''1是中标人，0否''';
      execute immediate 'comment on column BD_EVALUATION.proid is ''''';
      execute immediate 'comment on column BD_EVALUATION.probid is ''''';
      execute immediate 'comment on column BD_EVALUATION.probname is ''''';
      execute immediate 'comment on column BD_EVALUATION.bdid is ''''';
      execute immediate 'comment on column BD_EVALUATION.bdname is ''''';
      execute immediate 'comment on column BD_EVALUATION.zbfs is ''招标方式1-公开招标 2-邀请招标 9-其它''';
      execute immediate 'comment on column BD_EVALUATION.zbzzfs is ''招标组织方式 1-自行招标 2-委托招标 9-其它''';
      execute immediate 'comment on column BD_EVALUATION.signcontract is ''有合同则评价（1有， 0无）''';
      execute immediate 'comment on column BD_EVALUATION.tohydm is ''''';
      execute immediate 'comment on column BD_EVALUATION.tohyname is ''中文汉字25个字''';
      execute immediate 'comment on column BD_EVALUATION.tohytype is ''1是中标人 2投标人3 代理机构4专家''';
      execute immediate 'comment on column BD_EVALUATION.status is ''1已评，0 未评''';
      execute immediate 'comment on column BD_EVALUATION.relateCompliance is ''是否涉及履约情况（1是，0否）''';
      execute immediate 'comment on column BD_EVALUATION.node is ''1合同履约登记后，2定标完成后，3合同执行完成后''';
      execute immediate 'comment on column BD_EVALUATION.evaluation is ''非常满意（5分） 满意（4分） 一般（3分）  不满意（2分） 非常不满意（1分）''';
      execute immediate 'comment on column BD_EVALUATION.remark is ''不满意（2分）、非常不满意（1分）时必填''';
      execute immediate 'comment on column BD_EVALUATION.evalTime is ''评价时间''';

    end if;
    ------------2016/08/20 cheny 评价信息记录表 end--------------

   tmp1:=upper('BD_JURY');
   tmp2:=upper('SAMPLE_TIME');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''抽取次数 1-第一轮 2-第二轮''';
  end if;
  
   tmp1:=upper('BD_JURY_MEMBER');
   tmp2:=upper('REASON');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''不出席理由''';
  end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('FLAG01');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审环节个数''';
  end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('FLAG02');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评分环节个数''';
  end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('FLAG03');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已评审环节''';
  end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('FLAG04');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已评分环节''';
  end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('FLAG05');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已汇总环节''';
   end if;
  
   tmp1:=upper('BD_JURY_SIGN');
   tmp2:=upper('REASON');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''不出席理由''';
  end if;
  
  tmp1:=upper('BD_TB_SIGNUP');
   tmp2:=upper('NODEXH');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''被淘汰的环节数''';
  end if;
  
    ------------2016/08/25 hejw  start--------------
  tmp1:=upper('BD_SEAL');
  tmp2:=upper('OPT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(80))';
  end if;
  
  tmp1:=upper('BD_SEAL');
  tmp2:=upper('HYDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(80))';
  end if;
    ------------2016/08/25 hejw  end--------------
  -------------------------2016年8月30日 14:39:13 songw start--------------------
  --增加踏勘记录的踏勘代表联系方式
  tmp1:=upper('bd_tb_signup');
  tmp2:=upper('TKTEL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘代表联系方式''';
    end if;
  --add by songw end---
  --add  2016年9月27日 11:55:34  songw   start--------------------
  -- 判断附件基本信息表是否存在
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_FJJBXX');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
    -- 建表
    execute immediate '
      create table BD_FJJBXX  (
      PKID         NUMBER NOT NULL,
      SJJBZF       VARCHAR2(3),
      FJNUM        NUMBER,
      GUID         VARCHAR2(50),
      FJNAME       VARCHAR2(100),   
      FJTYPE       VARCHAR2(2),
      MD5          VARCHAR2(36), 
      FILENAME     VARCHAR2(128),
      URL          VARCHAR2(32),
      constraint PK_BD_FJJBXX primary key (PKID)
    )
    ';
    --注释
    execute immediate ' comment on table BD_FJJBXX is ''附件基本信息表''';
    execute immediate ' comment on column BD_FJJBXX.PKID is ''主键''';
    execute immediate ' comment on column BD_FJJBXX.SJJBZF is ''附件关联数据集标识符''';
    execute immediate ' comment on column BD_FJJBXX.FJNUM is ''关联附件数量''';
    execute immediate ' comment on column BD_FJJBXX.GUID is ''附件关联标识符''';
    execute immediate ' comment on column BD_FJJBXX.FJNAME is ''附件名称,十六进制数表示''';
    execute immediate ' comment on column BD_FJJBXX.FJTYPE is ''附件类型:01-gif,02-jpg,03-png,04-bmp,05-jpeg,06-doc,07-pdf,08-xlsx,09-招标文件,10-投标文件,11-zip,12-rar,13-其他文件,14-docx,15-xls''';
    execute immediate ' comment on column BD_FJJBXX.MD5 is ''MD5校验码''';
    execute immediate ' comment on column BD_FJJBXX.FILENAME is ''附件文件名''';
    execute immediate ' comment on column BD_FJJBXX.URL is ''附件URL地址''';
    
    
    end if;
    
    num:=0; 
    tmp1:=upper('BD_FJJBXX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_FJJBXX_0 
        minvalue 1
        maxvalue 99999999999999999999
        start with 1
        increment by 1
        nocache
        order
        ';
    end if;
    
    --add增加字段属性为clob的附件url地址
    tmp1:=upper('BD_FJJBXX');
  	tmp2:=upper('FILEURL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB NULL)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件url地址''';
    end if;
    
    -- 删除 url
    tmp1:=upper('BD_FJJBXX');
    tmp2:=upper('URL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
    end if;
  --add  2016年9月27日 11:55:34  songw    end--------------------
  -------------------------2016年9月18日 19:34:50 songw start--------------------
  --增加投标注册记录表的资格预审通过通知书的pdf文件路径
  tmp1:=upper('bd_tb_signup');
  tmp2:=upper('SEALPATH01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审通过通知书的pdf文件路径''';
    end if;
  --add by songw end---
  -------------------------2016年9月21日 16:34:48 songw start--------------------
  --增加标段包表的资格评审报告pdf文件路径和评标报告pdf文件路径
  tmp1:=upper('bd_package');
  tmp2:=upper('FILEPATH02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格评审报告pdf文件路径''';
    end if;
    
   tmp1:=upper('bd_package');
   tmp2:=upper('FILEPATH03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告pdf文件路径''';
    end if;
  --add by songw end---
  ------------2016年9月10日 09:54:02  songw  start--------------------
  --增加招标公告是否发送中国采购与招标网（http://www.chinabidding.com.cn）
  tmp1:=upper('bd_zbgg');
  tmp2:=upper('ISFCBD');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(80))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否发送中国采购与招标网（http://www.chinabidding.com.cn），若是则有值，若否则为空''';
    end if;

  --add by songw end---
	--add by songw by 2016年10月8日 14:24:02  start -------------------------
	--增加标段包表中评审报告附件文件类型和评标报告附件文件类型
	tmp1:=upper('bd_package');
  	tmp2:=upper('PSBGFJTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审报告附件类型''';
    end if;

	tmp1:=upper('bd_package');
  	tmp2:=upper('PBBGFJTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告附件类型''';
    end if;	

	--增加数字证书登记表附件类型
	tmp1:=upper('bd_package');
  	tmp2:=upper('CERTTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''数字证书附件类型''';
    end if;	

	--增加招标公告附件类型
	tmp1:=upper('bd_zbgg');
  	tmp2:=upper('FILETYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标公告附件类型''';
    end if;	
    
    --增加标的物附件类型
 	tmp1:=upper('bd_project_item');
  	tmp2:=upper('ACCESSORYTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标的物附件类型''';
    end if;	   
    
    --增加委托合同附件类型
  	tmp1:=upper('bd_subproject_ext');
  	tmp2:=upper('filetype');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托合同附件类型''';
    end if;   
    
    --增加候选人公示附件类型
  	tmp1:=upper('BD_DB_HXRGS');
  	tmp2:=upper('filetype');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''候选人公示附件类型''';
    end if;     
    
    --增加中标结果公告附件类型
  	tmp1:=upper('BD_DB_ZBJGGG');
  	tmp2:=upper('filetype');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标结果公告附件类型''';
    end if; 
    
    --增加投标邀请书附件类型
  	tmp1:=upper('BD_TBYQSBZ');
  	tmp2:=upper('filetype');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标邀请书附件类型''';
    end if; 
        
        
    --增加订单价格单位和币种字段
  	tmp1:=upper('bd_td_dd_mx');
  	tmp2:=upper('jgdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''价格单位''';
    end if; 

  	tmp1:=upper('bd_td_dd_mx');
  	tmp2:=upper('biz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''币种''';
    end if; 
    
  	tmp1:=upper('bd_td_dd');
  	tmp2:=upper('jgdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''价格单位''';
    end if;     

  	tmp1:=upper('bd_td_dd');
  	tmp2:=upper('biz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''币种''';
    end if; 
	--add by songw by 2016年10月8日 14:24:02  end -------------------------
	

  --add by chenxp start---
  --澄清文件 招标方审核签章
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpath01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方审核签章uuid''';
    end if;
    
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpathfile01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方审核签章pdf路径''';
    end if;
    
    --澄清文件 招标方发布签章
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpath02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方发布签章uuid''';
    end if;
    
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpathfile02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方发布签章pdf路径''';
    end if;
    
    
    --澄清文件 代理方提交审核签章
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpath03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理方提交审核签章uuid''';
    end if;
    
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpathfile03');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理方提交审核签章pdf路径''';
    end if;
    
    --澄清文件 提交平台验证签章
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpath04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交平台验证签章uuid''';
    end if;
    
    tmp1:=upper('bd_ccnotice');
  tmp2:=upper('sealpathfile04');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''提交平台验证签章pdf路径''';
    end if;
    
  --add by chenxp end  ---

  -- bd_jury_member 增加 评标委员会唯一编号 字段
  tmp1:=upper('bd_jury_member');
  tmp2:=upper('WYHNUM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标委员会唯一编号 每个委员会，每个专家对应一个编号''';
  end if;
  
  -- bd_jury_member 增加 接收短信时间 字段
  tmp1:=upper('bd_jury_member');
  tmp2:=upper('RECEIVEDATE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' date null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''接收短信时间 专家接收到短信的时间''';
  end if;
  
  tmp1:=upper('BD_TD_DD_MX');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 ;
  if num > 0 then
    execute immediate 'alter table '||tmp1||' drop constraint PK_BD_TD_DD_MX';
    execute immediate 'alter table '||tmp1||' add constraint PK_BD_TD_DD_MX primary key(DDHM,XH)';
  end if;
  
  tmp1:=upper('Bd_Td_Dd');
    tmp2:=upper('PAYDATE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付成功时间''';
    end if;
    
    tmp1:=upper('Bd_Td_Dd');
    tmp2:=upper('PAYPDFURL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付成功生成的PDF回执文件路径''';
    end if;
    
    num:=0; 
    tmp1:=upper('BD_EVALUATE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_EVALUATE_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 19
    increment by 1
    nocache
    order
    ';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_EXT');
  tmp2:=upper('WTDEAL');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议''';
  end if;

    
     tmp1:=upper('BD_HGZJTZS');
  tmp2:=upper('sealurl01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标结果通知书pdf存放路径''';
    end if;
    
    tmp1:=upper('BD_HGZJTZS');
  tmp2:=upper('sealpath01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''关联标识  招标结果通知书提交''';
    end if;
    
  tmp1:=upper('BD_LOG');
  tmp2:=upper('OPFPHM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
  end if;
  
   tmp1:=upper('BD_SUBPROJECT_EXT');
  tmp2:=upper('SEALPATH01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理机构''';
    end if;
  

    tmp1:=upper('BD_SUBPROJECT_EXT');
  tmp2:=upper('SEALURL01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 回执路径''';
    end if;
    
    tmp1:=upper('BD_STEPURL');
  tmp2:=upper('remark');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(40))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
    end if;
    
    --投标邀请书编制 字段长度修改
  tmp1:=upper('BD_TBYQSBZ');
  tmp2:=upper('QUATION');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
  end if;
  
  tmp1:=upper('BD_EXPERT');
  tmp2:=upper('MAJOR');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(600))';
  end if;
  
  tmp1:=upper('BD_JURY_MEMBER');
  tmp2:=upper('MAJOR');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(600))';
  end if;
  
  tmp1:=upper('BD_EXPERT');
  tmp2:=upper('CARD_NUM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(30))';
  end if;
  
  tmp1:=upper('BD_PACKAGE_YQDW');
  tmp2:=upper('TBFLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(40))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-邀请-拒绝参加''';
    end if;
 
    tmp1:=upper('BD_PACKAGE_YQDW');
    tmp2:=upper('SEALDATA01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''邀请-拒绝参加签名关联标识''';
    end if; 
  
  tmp1:=upper('Bd_Fb_Zbcssz');
  tmp2:=upper('lydbfs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''履约担保方式 1 为百分比 2为固定金额''';
    end if;
    
  tmp1:=upper('Bd_Fb_Zbcssz');
  tmp2:=upper('lydbpercent');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''履约担保百分比''';
    end if;
    
   --add by chenxp start 招标项目扩展表--
   tmp1:=upper('bd_subproject_ext');
   tmp2:=upper('jjzyzcy');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解决争议仲裁院''';
  end if;
 

   tmp1:=upper('bd_subproject_ext');
   tmp2:=upper('jjzyfy');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''解决争议法院''';
  end if;
    --add by chenxp end   招标项目扩展表--
  
  ------------2016/09/10 cheny webservice接口上传记录表 start--------------
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_WS_TASK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_WS_TASK  (
        PKID number not null,
        IFPHM varchar2(23),
        ITYPE varchar2(5),
        IDATE date,
        ICOUNT number,
        ISTATUS number,
       constraint PK_BD_WS_TASK primary key (PKID)
      )';
  
      execute immediate 'comment on table BD_WS_TASK is ''webservice接口上传记录表''';
      execute immediate 'comment on column BD_WS_TASK.PKID is ''主键自增长''';
      execute immediate 'comment on column BD_WS_TASK.IFPHM is ''表格主键编号''';
      execute immediate 'comment on column BD_WS_TASK.ITYPE is ''表格类型''';
      execute immediate 'comment on column BD_WS_TASK.IDATE is ''上传日期''';
      execute immediate 'comment on column BD_WS_TASK.ICOUNT is ''上传失败次数''';
      execute immediate 'comment on column BD_WS_TASK.ISTATUS is ''上传状态（备用）1是成功，0否''';

  end if;
  --------------------webservice接口上传记录备份表-------------------------
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_WS_TASK_BAK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
    create table BD_WS_TASK_BAK  (
        PKID number not null,
        IFPHM varchar2(23),
        ITYPE varchar2(5),
        IDATE date,
        ICOUNT number,
        ISTATUS number,
      constraint PK_BD_WS_TASK_BAK primary key (PKID)
      )';
  
      execute immediate 'comment on table BD_WS_TASK_BAK is ''webservice接口上传记录表''';
      execute immediate 'comment on column BD_WS_TASK_BAK.PKID is ''主键自增长''';
      execute immediate 'comment on column BD_WS_TASK_BAK.IFPHM is ''表格主键编号''';
      execute immediate 'comment on column BD_WS_TASK_BAK.ITYPE is ''表格类型''';
      execute immediate 'comment on column BD_WS_TASK_BAK.IDATE is ''上传日期''';

  end if;
    -- Create sequence 
    num:=0; 
    tmp1:=upper('BD_WS_TASK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_WS_TASK_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;

    -- Create sequence 
    num:=0; 
    tmp1:=upper('BD_WS_TASK_BAK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_WS_TASK_BAK_0
    minvalue 1
    maxvalue 9999999999999999999999999999
    start with 1
    increment by 1
    nocache
    order
    ';
    end if;
    ------------2016/09/10 cheny webservice接口上传记录表 end--------------

---hejw---start-----------
   tmp1:=upper('BD_TBYQSBZ');
   tmp2:=upper('SEALPATH01');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审未通过通知书-签章关联标识''';
  end if;

   tmp1:=upper('BD_TBYQSBZ');
   tmp2:=upper('SEALPATH02');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审未通过通知书-PDF路径''';
  end if;
  
   tmp1:=upper('Bd_Package');
   tmp2:=upper('bdzt');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(22))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段包流程状态''';
  end if;
---hejw---end-----------

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('DAY1');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column BD_FB_ZBCSSZ.DAY1 is ''申请人要求澄清资格预审文件的截止时间''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('DAY2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column BD_FB_ZBCSSZ.DAY2 is ''招标人澄清资格预审文件的截止时间''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('DAY3');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column BD_FB_ZBCSSZ.DAY3 is ''申请人确认收到资格预审文件澄清的时间''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('DAY4');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column BD_FB_ZBCSSZ.DAY4 is ''招标人修改资格预审文件的截止时间''';
    end if;

    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('DAY5');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column BD_FB_ZBCSSZ.DAY5 is ''申请人确认收到资格预审文件修改的时间''';
    end if;
    
    ---add by chenxp start 标段包---
    tmp1:=upper('Bd_Package');
    tmp2:=upper('pbbgqsr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告签收人''';
    end if;
    
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('pbbgqsdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告签收时间''';
    end if;
    
    
    tmp1:=upper('Bd_Package');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告签收签名uuid''';
    end if;
    ---add by chenxp end   标段包---

  ---add by lvcyong start 文件断点续传----
  -- 判断投诉表是否存在
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_FILES_HTTP');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
      -- 建表
      execute immediate '
        create table BD_FILES_HTTP  (
         PKID                 INT,
         LOC_PATH             CLOB,
         SVR_PATH             VARCHAR2(500),
         LOC_LEN              INT,
         SVR_LEN              INT,
         SVR_PER              NUMBER(3,1),
         LOC_MD5              VARCHAR2(100),
         UPD_COMPLETE         VARCHAR2(2),
         HYDM                 VARCHAR2(30),
         USERID               VARCHAR2(80),
         FPHM                 VARCHAR2(100),
         START_DATE           DATE,
         UPD_DATE             DATE,
         SVR_EXT              VARCHAR2(100)
      )
      ';    
      -- 注释      
    execute immediate ' comment on table BD_FILES_HTTP is ''文件断点续传''';
      execute immediate ' comment on column BD_FILES_HTTP.pkid is ''自增主键'''; 
      execute immediate ' comment on column BD_FILES_HTTP.LOC_PATH is ''客户端文件路径（绝对路径，包含文件名）''';
    execute immediate ' comment on column BD_FILES_HTTP.SVR_PATH is ''服务端文件路径（相对路径，包含文件名）''';
    execute immediate ' comment on column BD_FILES_HTTP.LOC_LEN is ''客户端文件大小（数字化的长度，以字节为单位）''';
    execute immediate ' comment on column BD_FILES_HTTP.SVR_LEN is ''已上传文件大小（数字化的长度，以字节为单位）''';
    execute immediate ' comment on column BD_FILES_HTTP.SVR_PER is ''上传百分比（%）''';
    execute immediate ' comment on column BD_FILES_HTTP.LOC_MD5 is ''客户端文件MD5''';
    execute immediate ' comment on column BD_FILES_HTTP.UPD_COMPLETE is ''上传完成 0 -- 否，1 -- 是''';
    execute immediate ' comment on column BD_FILES_HTTP.HYDM is ''会员代码''';
    execute immediate ' comment on column BD_FILES_HTTP.USERID is ''操作员编号''';
    execute immediate ' comment on column BD_FILES_HTTP.FPHM is ''业务号码''';
    execute immediate ' comment on column BD_FILES_HTTP.START_DATE is ''上传时间''';
    execute immediate ' comment on column BD_FILES_HTTP.UPD_DATE is ''续传时间''';
    execute immediate ' comment on column BD_FILES_HTTP.SVR_EXT is ''已上传的文件后缀名''';
    end if; 
  
    num:=0; 
    tmp1:=upper('BD_FILES_HTTP_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_FILES_HTTP_0 
        minvalue 1
        maxvalue 9999999999999999999999999999
        start with 1
        increment by 1
        nocache
        order
        ';
     end if; 
  
    --add by chenxp start 招标文件参数设置--
    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('tbbzjzffs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
          execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付方式 1-按比例 2-固定金额''';
    end if;
    

    --add by hejw start   标段包--
      tmp1:=upper('Bd_Jury_Sign');
    tmp2:=upper('keydm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
          execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''公共KEY序列号''';
    end if;
    
      tmp1:=upper('BD_PACKAGE');
    tmp2:=upper('CERTPATH');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
          execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''数字证书登记表-上传路径''';
    end if;
    --add by hejw end   标段包--
  
    tmp1:=upper('bd_fb_zbcssz');
    tmp2:=upper('tbbzjpercent');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
          execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(5) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付比例''';
    end if;
    --add by chenxp end   招标文件参数设置--
    
    --------投标邀请书编制 新增 代理商投标申请 字段 zhangdl start-------------
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('AGENT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
    execute immediate 'comment on column BD_TBYQSBZ.AGENT is ''代理商投标申请:接受或者不接受''';
    end if;
    --------投标邀请书编制 新增 代理商投标申请 字段 zhangdl end-------------
    
    --------后台异常招标审核人 字段 zhangdl start------------------------
    tmp1:=upper('Bd_Zb_Yc');
    tmp2:=upper('MANAGERSHR');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
    execute immediate 'comment on column Bd_Zb_Yc.MANAGERSHR is ''后台异常招标审核人''';
    end if;        
    --------后台异常招标审核人 字段 zhangdl end--------------------------  
    
    --------后台异常招标审核人代码 字段 zhangdl start------------------------
    tmp1:=upper('Bd_Zb_Yc');
    tmp2:=upper('MANAGERSHRDM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
    execute immediate 'comment on column Bd_Zb_Yc.MANAGERSHRDM is ''后台异常招标审核人''';
    end if;        
    --------后台异常招标审核人代码 字段 zhangdl end--------------------------  

  --add by chenxp start 变更公告--
  tmp1:=upper('Bd_Package');
    tmp2:=upper('kbdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标地点''';
    end if;
    
    
    --修改标段包名称
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
         execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
    end if;
    
    -- 赋值 tknr_tmp
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set tknr_tmp = packname';
    end if;
    
    -- 删除 packname
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
    end if;
    
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）名称''';
    end if;
    
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set packname = tknr_tmp';
    end if;
    
    --修改标段包编号
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set tknr_tmp=null';
    end if;
    
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set tknr_tmp = bdid';
    end if;
    
    -- 删除 bdid
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
    end if;
    
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段（包）编号''';
    end if;
    
    
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'update '||tmp1||' set bdid = tknr_tmp';
    end if;
    
    -- 删除 tknr_tmp
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('tknr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
    end if;
    
  --add by chenxp end   变更公告--

  --add by hejw start--
      tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('GQ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
    end if;
    
      tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('XMJL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''项目经理''';
    end if;
    
      tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('ZLBZ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(400))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''质量标准''';
    end if;
    
      tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('MARKET');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(600))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('GQ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
    end if;
    
      tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('XMJL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''项目经理''';
    end if;
    
      tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('ZLBZ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(400))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''质量标准''';
    end if;
  --add by hejw end--

  --add by chenxp start 合同签订--
    tmp1:=upper('bd_contract');
    tmp2:=upper('httjropt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同提交人操作员id''';
    end if;
    
    tmp1:=upper('bd_contract');
    tmp2:=upper('sealpath01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同提交签章UUID''';
    end if;
   
  
    tmp1:=upper('bd_contract');
    tmp2:=upper('htqropt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同确认操作员id''';
    end if;
    
    tmp1:=upper('bd_contract');
    tmp2:=upper('sealpath02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同确认签章UUID''';
    end if;
    
    tmp1:=upper('bd_contract');
    tmp2:=upper('htqzfj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同签章附件''';
    end if;
  --add by chenxp end 合同签订--


   tmp1:=upper('bd_package');
    tmp2:=upper('ptzrrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证责任人''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('ptdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证时间''';
    end if;

   tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('ptzrrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证责任人''';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('ptdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证时间''';
    end if;
    
   tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('ptzrrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证责任人''';
    end if;
    
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('HAND_ORDER01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审得分手动排序''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('HAND_ORDER02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INT )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标得分手动排序''';
    end if;
    
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('ptdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证时间''';
    end if;
    
   tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('ptzrrname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证责任人''';
    end if;
    
    tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('ptdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证时间''';
    end if;
    
    
    
    -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_NODE--评标模板环节
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_NODE');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_NODE  (
        PKID                 INT                             not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        NODEMC               VARCHAR2(60),
        NODELX               VARCHAR2(2),
        TOTALFZ              NUMBER(10,6),
        ORDERNO              INT,
        constraint PK_BD_MB_PBMB_NODE primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_NODE is ''评标模板环节'' ';    
    execute immediate '  comment on column BD_MB_PBMB_NODE.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.NODEMC is ''环节名称'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.NODELX is ''环节类型 1-资格预审环节(评审办法) 10-评审环节(评标办法) 20-评分环节(评标办法)'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.TOTALFZ is ''总分值'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE.ORDERNO is ''排序'' ';
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_NODE_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_NODE_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
  
  -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_NODE_BAK--评标模板环节-标段（包）
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_NODE_BAK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_NODE_BAK  (
        PKID                 INT                             not null,
        PACKID               VARCHAR2(23)                    not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        MBLX                 VARCHAR2(50)                    not null,
        NODEMC               VARCHAR2(60),
        NODELX               VARCHAR2(2),
        TOTALFZ              NUMBER(10,6),
        ORDERNO              INT,
        constraint PK_BD_MB_PBMB_NODE_BAK primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_NODE_BAK is ''评标模板环节-标段（包）'' ';    
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.PACKID is ''标段（包）编号'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.NODEMC is ''环节名称'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.NODELX is ''环节类型 1-资格预审环节(评审办法) 10-评审环节(评标办法) 20-评分环节(评标办法)'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.TOTALFZ is ''总分值'' ';
    execute immediate '  comment on column BD_MB_PBMB_NODE_BAK.ORDERNO is ''排序'' ';    
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_NODE_BAK_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_NODE_BAK_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
  
  -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_TK--评标模板条款
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_TK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_TK  (
        PKID                 INT                             not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        NODEXH               INT                             not null,
        TKMC                 VARCHAR2(60),
        SCLX                 VARCHAR2(2),
        TKFZ                 NUMBER(10,6),
        ORDERNO              INT,
        constraint PK_BD_MB_PBMB_TK primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_TK is ''评标模板条款'' ';    
    execute immediate '  comment on column BD_MB_PBMB_TK.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.NODEXH is ''环节序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.TKMC is ''条款名称'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.SCLX is ''审查类型 1-初审(评审办法) 2-祥审(评审办法) 3-评分(评审办法) 10-评审(评标办法) 20-评分(评标办法)'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.TKFZ is ''条款分值'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK.ORDERNO is ''排序'' ';
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_TK_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_TK_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
  
  -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_TK_BAK--评标模板条款-标段（包）
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_TK_BAK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_TK_BAK  (
        PKID                 INT                             not null,
        PACKID               VARCHAR2(23)                    not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        MBLX                 VARCHAR2(50)                    not null,
        NODEXH               INT                             not null,
        TKMC                 VARCHAR2(60),
        SCLX                 VARCHAR2(2),
        TKFZ                 NUMBER(10,6),
        ORDERNO              INT,
        constraint PK_BD_MB_PBMB_TK_BAK primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_TK_BAK is ''评标模板条款-标段（包）'' ';    
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.PACKID is ''标段（包）编号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.NODEXH is ''环节序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.TKMC is ''条款名称'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.SCLX is ''审查类型 1-初审(评审办法) 2-祥审(评审办法) 3-评分(评审办法) 10-评审(评标办法) 20-评分(评标办法)'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.TKFZ is ''条款分值'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_BAK.ORDERNO is ''排序'' ';
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_TK_BAK_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_TK_BAK_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
  
  -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_TK_MX--评标模板条款明细
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_TK_MX');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_TK_MX  (
        PKID                 INT                             not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        NODEXH               INT                             not null,
        TKXH                 INT                             not null,
        TKYS                 VARCHAR2(100),
        TKBZ                 VARCHAR2(100),
        ISACCORD             VARCHAR2(100),
        MINFZ                NUMBER(10,6),
        MAXFZ                NUMBER(10,6),
        constraint PK_BD_MB_PBMB_TK_MX primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_TK_MX is ''评标模板条款明细'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.NODEXH is ''环节序号'' ';    
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.TKXH is ''条款序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.TKYS is ''条款因素'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.TKBZ is ''条款标准'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.ISACCORD is ''是否符合'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.MINFZ is ''最小分'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX.MAXFZ is ''最大分'' ';
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_TK_MX_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_TK_MX_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
    
  -- SQL升级实例-CREATE TABLE    BD_MB_PBMB_TK_MX_BAK--评标模板条款明细-标段（包）
  -- 判断表是否存在
  num:=0; -- 注意：查询前必须初始化此变量
  tmp1:=upper('BD_MB_PBMB_TK_MX_BAK');
  select count(1) into num from user_tables where table_name=tmp1;       
  if num = 0 then
    -- 建表
    execute immediate '
      create table BD_MB_PBMB_TK_MX_BAK  (
        PKID                 INT                             not null,
        PACKID               VARCHAR2(23)                    not null,
        MBDM                 VARCHAR2(32)                    not null,
        MBXH                 INT                             not null,
        MBLX                 VARCHAR2(50)                    not null,
        NODEXH               INT                             not null,
        TKXH                 INT                             not null,
        TKYS                 VARCHAR2(100),
        TKBZ                 VARCHAR2(100),
        ISACCORD             VARCHAR2(100),
        MINFZ                NUMBER(10,6),
        MAXFZ                NUMBER(10,6),
        ISACCORDYY           VARCHAR2(200),
        constraint PK_BD_MB_PBMB_TK_MX_BAK primary key (PKID)
      )
    ';  
    -- 注释      
    execute immediate ' comment on table BD_MB_PBMB_TK_MX_BAK is ''评标模板条款明细-标段（包）'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.PKID is ''主键，自增'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.PACKID is ''标段（包）编号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.MBDM is ''模板代码'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.MBXH is ''模板序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.MBLX is ''模板类型 1-资审模板 2-评标模板'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.NODEXH is ''环节序号'' ';    
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.TKXH is ''条款序号'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.TKYS is ''条款因素'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.TKBZ is ''条款标准'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.ISACCORD is ''是否符合'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.MINFZ is ''最小分'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.MAXFZ is ''最大分'' ';
    execute immediate '  comment on column BD_MB_PBMB_TK_MX_BAK.ISACCORDYY is ''是否符合原因'' ';
  end if;
  -- SQL升级实例-CREATE SEQUENCE
  num:=0;
  tmp1 :=upper('BD_MB_PBMB_TK_MX_BAK_0');
  select count(1) into num from user_sequences where sequence_name=tmp1;
  if num = 0 then
  execute immediate 'CREATE SEQUENCE BD_MB_PBMB_TK_MX_BAK_0
    MINVALUE 1
    MAXVALUE 9999999999999999999999999999
    START WITH 1
    INCREMENT BY 1
    NOCACHE
    ORDER
  ';
  end if;
  ----tanqinli-end----

  --chenxp start--
  tmp1:=upper('bd_tb_signup');
    tmp2:=upper('tbwjjmzt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件解密状态 0 or null -未递交 2-已递交 4-未解密 6-解密中 8-解密成功 10-解密失败''';
    end if;
  --chenxp end  --

    tmp1:=upper('BD_FILES_HTTP');
    tmp2:=upper('FTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10) null)';
    end if;

    tmp1:=upper('BD_FILES_HTTP');
    tmp2:=upper('CTYPE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10) null)';
    end if;

    tmp1:=upper('BD_PACKAGE_ITEM');
    tmp2:=upper('STATUS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
    end if;

    tmp1:=upper('BD_SUBPROJECT_ITEM');
    tmp2:=upper('FHSL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,3))';
    end if;

    tmp1:=upper('BD_PROJECT_ITEM');
    tmp2:=upper('FHSL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,3))';
    end if;
    
    --add by chenxp start--
    tmp1:=upper('bd_subproject');
    tmp2:=upper('revokeflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目撤回标志 1-已撤回''';
    end if;
    
    
    tmp1:=upper('bd_subproject');
    tmp2:=upper('disableflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目停用标志 1-已停用  2-停用中''';
    end if;
    
    tmp1:=upper('bd_subproject');
    tmp2:=upper('wtacceptflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托接受状态 0-拒绝  1-接受''';
    end if;
    --add by chenxp end  --

  --add by xuz start---
    tmp1:=upper('bd_tbyqsbz');
    tmp2:=upper('PREULT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
      execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(400))';
    end if;
  --add by xuz end ---

  --add by hejw start ---
    tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('price2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(30,2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''分部分项费''';
    end if;
    
    tmp1:=upper('BD_OFFER_MX');
    tmp2:=upper('price3');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(30,2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''捐施项目费''';
    end if;
  --add by hejw end ---


    tmp1:=upper('bd_jury');
    tmp2:=upper('isjdr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否监督人 1-是 2-否''';
    end if;
    
    --add by chenxp start 扎表项目扩展表--
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('timemd5');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('wthzdeal');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托回执UUID''';
    end if;
    --add by chenxp end   扎表项目扩展表--

	  tmp1:=upper('bd_jury');
	  tmp2:=upper('isjdr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	      execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
	      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否监督人 1-是 2-否''';
	  end if;
	  
	  --add by chenxp start 招标项目扩展表--
	  tmp1:=upper('bd_subproject_ext');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	  
	  tmp1:=upper('bd_subproject_ext');
	  tmp2:=upper('wthzdeal');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托回执UUID''';
	  end if;
	  --add by chenxp end   招标项目扩展表--

    tmp1:=upper('bd_package');
    tmp2:=upper('yspbbgjbr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审评审报告监督人签名''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('kbpbbgjbr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标评审报告监督人签名''';
    end if;

    tmp1:=upper('bd_package_ext');
    tmp2:=upper('ysjdropt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审监督人签名''';
    end if;
    
    tmp1:=upper('bd_package_ext');
    tmp2:=upper('ysjdrseal');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审监督人签名数据''';
    end if;
    
    tmp1:=upper('bd_package_ext');
    tmp2:=upper('kbjdropt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标监督人签名''';
    end if;
    
    tmp1:=upper('bd_package_ext');
    tmp2:=upper('kbjdrseal');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标监督人签名数据''';
    end if;    

	---add by xuz start-----
 	tmp1:=upper('bd_tb_signup');
	  tmp2:=upper('isCanEditBzjdd');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否可修改保证金原订单 1-是 0 or null 否''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('pzpath2');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('pzpath3');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('pzpath4');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('pzpath5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''凭证''';
	  end if;
	---add by xuz end-------

	--add by chenxp start 澄清文件--
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	--add by chenxp end   --

	--add by chenxp start 投标邀请书--
	  tmp1:=upper('bd_tbyqsbz');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	  
	  tmp1:=upper('bd_tbyqsbz');
	  tmp2:=upper('tstate');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已发布  0-否(已编辑),1-是(已发布),2-已签章待发布''';
	  end if;
  	--add by chenxp end  --
	  tmp1:=upper('bd_package');
	  tmp2:=upper('certname');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''上传文件名''';
	  end if;
	  
	-- 修改 tkys 字段长度
	tmp1:=upper('bd_mb_pbmb_tk_mx');
	tmp2:=upper('tkys');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(500))';
	end if;
	
	-- 修改 tkys 字段长度
	tmp1:=upper('bd_mb_pbmb_tk_mx_bak');
	tmp2:=upper('tkys');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(500))';
	end if;
	
	tmp1:=upper('BD_FILES_HTTP');
	  tmp2:=upper('CHUNKS');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	  end if;
	
	tmp1:=upper('BD_FILES_HTTP');
	  tmp2:=upper('CHUNK');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	  end if;
	
	tmp1:=upper('BD_FILES_HTTP');
	  tmp2:=upper('PARTDIR');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
	  end if;
	  
	-- bd_mb_pbmb 增加 模板类别 字段
	tmp1:=upper('bd_mb_pbmb');
	tmp2:=upper('mbtype');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''模板类别 0 or null-会员模板 1-系统模板''';
	end if;
	
	--add by chenxp start--
	 tmp1:=upper('bd_subproject_item');
	 tmp2:=upper('status');
	 num:=0; -- 注意：查询前必须初始化此变量
	 select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	 if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
	     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-停用''';
	 end if;
	--add by chenxp end  --
	-- chenyi-- 2016-10-09- 附件信息表增加字段--start---
    tmp1:=upper('bd_fjjbxx');
    tmp2:=upper('upstatus');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已上传操作''';
    end if;
    
    tmp1:=upper('bd_fjjbxx');
    tmp2:=upper('bak1');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备用字段1''';
    end if;
    -- chenyi-- 2016-10-09- 附件信息表增加字段--end---
	
	tmp1:=upper('BD_FILES_HTTP');
	  tmp2:=upper('SUCCESS_CHUNKS');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
	  end if;
	
	tmp1:=upper('BD_FILES_HTTP');
	  tmp2:=upper('CHUNK_SIZE');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
	  end if;
	
	--add by chenxp start--
	  tmp1:=upper('bd_tb_signup');
	  tmp2:=upper('sealPath00');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格审核通过通知书签章UUID''';
	  end if;
	  
	  tmp1:=upper('bd_tb_signup');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	--add by chenxp end  --

    tmp1:=upper('Bd_Jury_Sign');
	  tmp2:=upper('sealdata');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认报告关联标识''';
	  end if;

	--add by chenxp start --
	  tmp1:=upper('bd_hgzjtzs');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	  
	  
	  tmp1:=upper('bd_hgzjtzs');
	  tmp2:=upper('tzzt');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书状态 o or null-未保存 1-已保存 2-已发送待招标人确认 3-招标人已确认 4-招标人已拒绝 5-已发布 6-已签章待发布 ''';
	  end if;
	  
	  tmp1:=upper('bd_package');
	  tmp2:=upper('zbtzszt');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书状态 o or null-未保存 1-已保存 2-已发送待招标人确认 3-招标人已确认 4-招标人已拒绝 5-已发布 6-已签章待发布 ''';
	  end if;
	--add by chenxp end   --
	
	-- bd_fb_zbcssz 增加 投标人提出问题的截止时间 字段
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('day11');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人提出问题的截止时间''';
	end if;
	-- bd_fb_zbcssz 增加 招标人书面澄清的时间 字段
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('day12');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人书面澄清的时间''';
	end if;
	-- bd_fb_zbcssz 增加 投标人要求澄清招标文件的截止时间 字段
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('day13');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人要求澄清招标文件的截止时间''';
	end if;	
	-- bd_fb_zbcssz 增加 投标人确认收到招标文件澄清的时间 字段
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('day14');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人确认收到招标文件澄清的时间''';
	end if;
	-- bd_fb_zbcssz 增加 投标人确认收到招标文件修改的时间 字段
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('day15');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人确认收到招标文件修改的时间''';
	end if;	
	
	tmp1:=upper('bd_tbyqsbz');
	tmp2:=upper('cdate');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建时间''';  
	end if;

	------------2016/10/10 cheny webservice接口 start--------------
	-- Create sequence webservice接口流水号-------------------------
    num:=0; 
    tmp1:=upper('BD_CEBPUBSERVICE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_CEBPUBSERVICE_0
	  minvalue 1
	  maxvalue 9999999
	  start with 1
	  increment by 1
	  nocache
	  cycle
    ';
    end if;
    
    ------------2016/10/10 cheny webservice接口 end--------------

	--add by chenxp start 招标文件确认签章--
	  tmp1:=upper('bd_package');
	  tmp2:=upper('zbwjzt');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件状态 0 or null-未上传 1-已上传 2-已发送待招标人审核 3-招标人审核通过 4-已发布 5-招标人审核未通过  6-招标人已签章待审核 ''';
	  end if;
	  
	  
	  tmp1:=upper('bd_package');
	  tmp2:=upper('yswjzt');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件状态 0 or null-未上传 1-已上传 2-已发送待招标人审核 3-招标人审核通过 4-已发布 5-招标人审核未通过  6-招标人已签章待审核 ''';
	  end if;
	  
	  
	  tmp1:=upper('bd_fb_tb_file');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	  
	  tmp1:=upper('bd_fb_tb_file');
	  tmp2:=upper('sealpath01');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件确认签章UUID''';
	  end if;
	--add by chenxp end  --

	--add by chenxp start 资格预审文件确认签章--
	  tmp1:=upper('bd_zb_file');
	  tmp2:=upper('timemd5');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
	  end if;
	  
	  tmp1:=upper('bd_zb_file');
	  tmp2:=upper('sealpath01');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件确认签章UUID''';
	  end if;
	--add by chenxp end  --

	  tmp1:=upper('Bd_Tbyqsbz');
	  tmp2:=upper('getmethod');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件获取方法''';
	  end if;
	  
	  ----hejw  start---
  tmp1:=upper('BD_OFFER_MX');
  tmp2:=upper('JHRQ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货期 ''';
  end if;
  
  tmp1:=upper('BD_OFFER_MX');
  tmp2:=upper('JLDW');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(20))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''计量单位 ''';
  end if;
  
  tmp1:=upper('BD_OFFER_MX');
  tmp2:=upper('JSBZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准 ''';
  end if;
  
  tmp1:=upper('BD_OFFER_MX');
  tmp2:=upper('XH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''型号 ''';
  end if;
	  ----hejw  end---
	 
	 ---xuz start---
 tmp1:=upper('BD_TD_DD');
  tmp2:=upper('WYMONEY');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''金额(万元) ''';
  end if;
	---xuz end--- 

	--add by chenxp start  澄清文件--
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('teststate');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num =0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
	  end if;
	 
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('teststate');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num =1 then
	     execute immediate 'update '||tmp1||' set teststate = state';
	  end if;
	 
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('state');
	  num:=1; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num =1 then
	    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
	  end if;
	 
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('state');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is '' 1-待提交 2-待审核  3-已审核 4-审核未通过 5-待平台验证 6-验证通过待发布 7-平台验证未通过  8-已发布 9-已签章待提交 10-已签章待审核 11-已签章待提交平台验证 12-已签章待发布 ''';
	  end if;
	  
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('state');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num =1 then
	     execute immediate 'update '||tmp1||' set state = teststate';
	  end if;
	
	  tmp1:=upper('bd_ccnotice');
	  tmp2:=upper('teststate');
	  num:=1; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num =1 then
	   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
	  end if;
	--add by chenxp end  --

	  tmp1:=upper('BD_JURY');
	  tmp2:=upper('tzfs');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知方式（默认短信通知）''';
	  end if;
	------------------cheny 2016/10/13 webservice上传信息记录表--start-----------------------------
	  tmp1:=upper('BD_WS_TASK');
	  tmp2:=upper('ERRORMSG');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''错误信息''';
	  end if;
	  
	  tmp1:=upper('BD_WS_TASK_BAK');
	  tmp2:=upper('ERRORMSG');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''错误信息''';
	  end if;
	------------------cheny 2016/10/13 webservice上传信息记录表--end-----------------------------

	tmp1:=upper('BD_TD_DD');
	tmp2:=upper('FPHM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''BdPayRequest表fphm，用于退保证金查询状态使用''';
	end if;
	  
  ---------------------------------------------------------------------------------------
end;