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
  
  tmp1:=upper('Bs_Mbopt');
  tmp2:=upper('imgurl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column Bs_Mbopt.imgurl is ''操作员头像图片''';
  end if; 
  
  tmp1:=upper('bs_menber_tmp');
  tmp2:=upper('imgurl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column bs_menber_tmp.imgurl is ''操作员头像图片''';
  end if;  	
  	
  tmp1:=upper('Bs_Checkgroup');
  tmp2:=upper('zt');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
   execute immediate 'comment on column bs_menber_tmp.imgurl is ''审批流启用状态''';
  end if; 
  
  --hjw
  tmp1:=upper('bs_mbopt');
  tmp2:=upper('grzfmm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(32))';
  execute immediate 'comment on column bs_mbopt.grzfmm is ''个人手机支付密码''';
  end if;
  

  --hjw 
  tmp1:=upper('Bs_Mb_Ext');
  tmp2:=upper('lbdmwsh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
  execute immediate 'comment on column Bs_Mb_Ext.lbdmwsh is ''供应商类别未审核代码''';
  end if;
  
   tmp1:=upper('Bs_Mb_Ext');
  tmp2:=upper('lbmcwsh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
  execute immediate 'comment on column Bs_Mb_Ext.lbmcwsh is ''供应商类别未审核名称''';
  end if;
  
   tmp1:=upper('Bs_Mb_Ext');
  tmp2:=upper('lbdmwtg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
  execute immediate 'comment on column Bs_Mb_Ext.lbdmwtg is ''供应商类别未通过代码''';
  end if;
  
   tmp1:=upper('Bs_Mb_Ext');
  tmp2:=upper('lbmcwtg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
  execute immediate 'comment on column Bs_Mb_Ext.lbmcwtg is ''供应商类别未通过名称''';
  end if;
  

  	-- bs_menber_tmp 增加 服务地区 字段
	tmp1:=upper('bs_menber_tmp');
	tmp2:=upper('servicearea');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地区''';
	end if;
	
	-- bs_menber 增加 服务地区 字段
	tmp1:=upper('bs_menber');
	tmp2:=upper('servicearea');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000) null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地区''';
	end if;
	
	
  tmp1:=upper('bs_menber_tmp');
  tmp2:=upper('gbname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
  execute immediate 'comment on column bs_menber_tmp.gbname is ''国别名称''';
  end if;
  
  tmp1:=upper('bs_menber_tmp');
  tmp2:=upper('gbcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(10))';
  execute immediate 'comment on column bs_menber_tmp.gbcode is ''国别代码''';
  end if;
  
  tmp1:=upper('bs_menber');
  tmp2:=upper('gbname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
  execute immediate 'comment on column bs_menber_tmp.gbname is ''国别名称''';
  end if;
  
  
  -------------------------------------------------------------
end;
