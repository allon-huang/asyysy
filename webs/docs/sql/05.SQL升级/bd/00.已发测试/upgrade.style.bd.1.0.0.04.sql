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
  
  ----chenxp start-----
  --招标项目扩展表 存代理机构
  	tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('acceptflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构接收委托标志:0 or null-否 , 1-是'''; 
    end if; 
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('fufeif');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''付费方 : 1-招标方 , 2-中标方'''; 
    end if; 
  
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zfjefs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付金额的方式:1-按比例,2-固定金额'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zfpercent');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(10)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付的百分比'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zfgdje');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付的固定金额'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('fffs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''付费方式'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfxyqzr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订  招标方  签章操作人'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfxyqzdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订  招标方  签章时间'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfqzflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 招标方 签章标志:0 or null 否  , 1-是'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfaddres');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订  招标方  住所'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfkhyh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订  招标方  开户银行'''; 
    end if;      
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zbfyb');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订  招标方 邮编'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('sqdlr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方 授权代理人'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('sqdlrTel');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方 授权代理人电话'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfqzr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 签章操作人'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfqzdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 签章时间'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfqzflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 签章标志:0 or null 否  , 1-是'''; 
    end if;
    
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfaddres');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 住所'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfkhyh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(200)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 开户银行'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfyb');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(30)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议签订 代理方 邮编'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfxmjlr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理方 项目经理'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('dlfxmjlTel');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(20)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理方 项目经理电话'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('xyqddate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' DATE';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''协议签订日期'''; 
    end if;
    
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('jjzyfs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方和委托方解决争议的方式 : 1-仲裁,2-法院  '''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('refusewtly');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' CLOB';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''拒绝接受委托原因'''; 
    end if;
    
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('wthzczr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(100)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''处理委托回执的操作人'''; 
    end if;
  

    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('qttj1');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他条件1'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('qttj2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他条件2'''; 
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('qttj3');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(2000)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他条件3'''; 
    end if;
	
  ----chenxp end----------
  -----xuz  start--------
	tmp1:=upper('bd_dissent');
    tmp2:=upper('yyjd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''异议阶段 0 or null 预审 1-评标'''; 
    end if;
    
    tmp1:=upper('bd_dissent');
    tmp2:=upper('status');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then 
       execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1)';
       execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''状态 0 or null 未受理 1- 已受理待处理 2-已处理'''; 
    end if;
  -----xuz  end----------
  -----hejw  start----------
 tmp1:=upper('Bd_Package');
  tmp2:=upper('psjlzbr');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
    execute immediate 'comment on column Bd_Package.psjlzbr is ''评审记录签章-招标方''';
  end if; 

  tmp1:=upper('Bd_Package');
  tmp2:=upper('psjldlr');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
    execute immediate 'comment on column Bd_Package.psjldlr is ''评审记录签章-代理机构''';
  end if; 
  
  tmp1:=upper('Bd_Package');
  tmp2:=upper('psjljbr');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
    execute immediate 'comment on column Bd_Package.psjljbr is ''评审记录签章-监标人''';
  end if; 
  


  tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjlzbrdate');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjlzbrdate is ''评审记录签章 招标方 时间''';
  end if;   
  
    tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjldlrdate');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjldlrdate is ''评审记录签章 代理机构 时间''';
  end if;   
  
  
    tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjljbrdate');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjljbrdate is ''评审记录签章   监标人 时间''';
  end if; 


  tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjlzbrseal');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjlzbrseal is ''评审记录签章 招标方  印章''';
  end if;   
  
    tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjldlrseal');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjldlrseal is ''评审记录签章 代理机构 印章''';
  end if;   
  
  
    tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('psjljbrseal');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
    execute immediate 'comment on column BD_PACKAGE_EXT.psjljbrseal is ''评审记录签章   监标人 印章''';
  end if; 
  
  
    tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('ysjlqrr');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
    execute immediate 'comment on column BD_TB_SIGNUP.ysjlqrr is ''预审记录   确认人''';
  end if; 

    tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('ysjlqrsj');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
    execute immediate 'comment on column BD_TB_SIGNUP.ysjlqrsj is ''预审记录   确认时间''';
  end if; 
  -----hejw  end----------

  -----zhaiyy  start----------
	--澄清文件回执添加自增
	num:=0; 
    tmp1:=upper('BD_CC_RECEIPT_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_CC_RECEIPT_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
    
    --添加数据类型字段
	tmp1:=upper('BD_CC_RECEIPT');
	tmp2:=upper('TYP');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''数据类型''';
	end if;	
  -----zhaiyy  end----------
 ----add by xuz start----
	  --添加评审方式字段
	tmp1:=upper('BD_MB_PBMB');
	tmp2:=upper('PSFS');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评审方式 1-合格制 2-有限数量制''';
	end if;	


 ----add by xuz end -----

	-----zhaiyy  start----------
	----给标段包添加通知书类型，通知书状态字段
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('TZSLX');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书类型：1-通过 2-不通过''';
	end if;
	
	tmp1:=upper('BD_PACKAGE');
	tmp2:=upper('TZSZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书状态：0-未保存 1-未发布 2-已发布''';
	end if;
	-----zhaiyy  start----------

   tmp1:=upper('Bd_Subproject_Ext');
  tmp2:=upper('wtseal');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
  execute immediate 'comment on column Bd_Subproject_Ext.wtseal is ''委托回执 签章数据''';
  end if;


	-- 修改 packid
	tmp1:=upper('bd_db_hxrgs');
	tmp2:=upper('packid');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(23))';
	end if;	
	
	tmp1:=upper('bd_fb_zbcssz');
  	tmp2:=upper('tbyxqts');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
  	execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
 	 execute immediate 'comment on column Bd_Subproject_Ext.wtseal is ''投标有效期天数''';
 	 end if;
	
	tmp1:=upper('bd_fb_zbcssz');
  	tmp2:=upper('lydbjedw');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
  	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
  	execute immediate 'comment on column bd_fb_zbcssz.lydbjedw is ''履约担保金额单位''';
  	end if;
  	
  	-----zhaiyy  start----------
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJHZZT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件回执状态  0 or null-未回执  1-已回执''';
	end if;
	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJHZSJ');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件回执时间''';
	end if;
	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJHZCZYDM');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件回执操作员''';
	end if;
	
	tmp1:=upper('BD_TB_SIGNUP');
	tmp2:=upper('TBWJHZCZYNAME');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件回执操作员姓名''';
	end if;
	-----zhaiyy  start----------

	--add by longf start ---
	tmp1:=upper('BD_TB_SIGNUP');
  	tmp2:=upper('pre_status00');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审提示状态 1-初审已评（已保存） 2-详审已评（已保存）''';
    end if;
    
	tmp1:=upper('BD_TB_SIGNUP');
  	tmp2:=upper('status00');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标提示状态 1-初审已评（已保存） 2-详审已评（已保存）''';
    end if;
    --add by longf end ---
	--add by xuz start--
   	tmp1:=upper('bd_fb_zbcssz');
  	tmp2:=upper('probid');
  	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(20))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目编号''';
    end if;
    --add by xuz end---

  -------------------------------------------------------------
end;