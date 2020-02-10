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
  	
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('HYCODING');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
   execute immediate 'comment on column BS_MB_EXT.HYCODING is ''会员赋码''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('CODINGHYDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.CODINGHYDM is ''赋码会员代码''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('CODINGHYNAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(250))';
   execute immediate 'comment on column BS_MB_EXT.CODINGHYNAME is ''赋码会员名称''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('CODINGDATE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' date)';
   execute immediate 'comment on column BS_MB_EXT.CODINGDATE is ''赋码时间''';
  end if;

  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('LBMC');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
   execute immediate 'comment on column BS_MENBER_JYPZ.LBMC is ''产品范围名称''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('LBDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
   execute immediate 'comment on column BS_MENBER_JYPZ.LBDM is ''产品范围代码''';
  end if;   

  tmp1:=upper('BS_MENBER_JYPZ_TMP');
  tmp2:=upper('LBMC');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
   execute immediate 'comment on column BS_MENBER_JYPZ_TMP.LBMC is ''产品范围名称''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ_TMP');
  tmp2:=upper('LBDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
   execute immediate 'comment on column BS_MENBER_JYPZ_TMP.LBDM is ''产品范围代码''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('GYSSHZT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
   execute immediate 'comment on column BS_MB_EXT.GYSSHZT is ''供应商审核状态： 0 or null待审核  1-审核通过 2-审核不通过 ''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('SHYY');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300))';
   execute immediate 'comment on column BS_MB_EXT.SHYY is ''审核原因''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('SHDATE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
   execute immediate 'comment on column BS_MB_EXT.SHDATE is ''审核日期''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('VALIDDATE');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
   execute immediate 'comment on column BS_MB_EXT.VALIDDATE is ''有效期''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('SHRDM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
   execute immediate 'comment on column BS_MB_EXT.SHRDM is ''审核人代码''';
  end if;
    
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('BELONG');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
   execute immediate 'comment on column BS_MENBER.BELONG is ''隶属于''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('BELONG');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
   execute immediate 'comment on column BS_MENBER_TMP.BELONG is ''隶属于''';
  end if;
  
  tmp1:=upper('BS_SUPPLIER_MG');
  tmp2:=upper('OKCP');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
   execute immediate 'comment on column BS_SUPPLIER_MG.OKCP is ''合格供应商产品''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('isjt');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(8))';
   execute immediate 'comment on column BS_MENBER_JYPZ.isjt is ''是否集团级''';
  end if;
  
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('wzjc');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(150))';
   execute immediate 'comment on column BS_MENBER_JYPZ.wzjc is ''物资简称''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('wzbm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(150))';
   execute immediate 'comment on column BS_MENBER_JYPZ.wzbm is ''物资别名''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('ywpm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(150))';
   execute immediate 'comment on column BS_MENBER_JYPZ.ywpm is ''英文品名''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('cpbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.cpbzh is ''产品标准号''';
  end if; 
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('ggbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.ggbzh is ''规格标准号''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('jsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.jsbzh is ''技术标准号''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('brand');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.brand is ''品牌''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('grade');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.grade is ''牌号''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('material');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.material is ''材质''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('cpdj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.cpdj is ''产品等级''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('xndj');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.xndj is ''性能等级''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('zlzb');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.zlzb is ''质量指标''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('coating');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.coating is ''涂层''';
  end if;
  
   tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('length');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.length is ''长度''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('colour');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.colour is ''颜色''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('region');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.region is ''区域''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('wireway');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.wireway is ''导线''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('rclgy');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.rclgy is ''热处理工艺''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('code');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.code is ''代号''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('ggqzf');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.ggqzf is ''规格前制符''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('jggy');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.jggy is ''加工工艺''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('bmcl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.bmcl is ''表面处理''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('provenance');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
   execute immediate 'comment on column BS_MENBER_JYPZ.provenance is ''原产地''';
  end if; 
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('state');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ.state is ''状态''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('tsyq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
   execute immediate 'comment on column BS_MENBER_JYPZ.tsyq is ''特殊要求''';
  end if;
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('zcqk');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
   execute immediate 'comment on column BS_MENBER_JYPZ.zcqk is ''注册情况''';
  end if; 
  
  tmp1:=upper('BS_MENBER_JYPZ');
  tmp2:=upper('optdm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MENBER_JYPZ.optdm is ''操作代码''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('SHRNAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(250))';
   execute immediate 'comment on column BS_MB_EXT.SHRNAME is ''审核人名称''';
  end if;      
  
	-------2016/07/25 hanglong 供应商管理审批流相关字段 start ----------------------------     
	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('GROUPID');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核组id'''; 
  	end if; 
  	
  	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('LEVEL1');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核总级别'''; 
  	end if; 
  	
  	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('LEVEL2');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''当前级别'''; 
  	end if; 
  	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('LEVEL3');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''该字段暂时备用'''; 
  	end if; 
  	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('STATUS');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-待审核，2-已审核，3-已拒绝'''; 
  	end if; 
  	
  	tmp1:=upper('BS_MENBER_JYPZ');
  	tmp2:=upper('JJLY');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''拒绝理由'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('GROUPID');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核组id'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('LEVEL1');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''审核总级别'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('LEVEL2');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''当前级别'''; 
  	end if; 
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('LEVEL3');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''该字段暂时备用'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('STATUS');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1-待审核，2-已审核，3-已拒绝'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('JJLY');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''拒绝理由'''; 
  	end if; 
  	
  	tmp1:=upper('BS_SUPPLIER_MG');
  	tmp2:=upper('OKCP2');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
   		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(4000))';
   		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''待审核的合格供应商产品'''; 
  	end if; 
	-------2016/07/25 hanglong 供应商管理审批流相关字段 end ------------------------------   	
	---add by xuz start---
	  tmp1:=upper('BS_MENBER_JYPZ');
   tmp2:=upper('tjlx');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2))';
   execute immediate 'comment on column BS_MENBER_JYPZ.tjlx is ''产品添加类型 0ornull 供应商添加 1-采购方添加''';
   end if;   
	---add by xuz end---

	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_JYPZ_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_JYPZ_MX  (
		   PKID                 INTEGER          not null,
		   PID                  INTEGER          not null,
		   HYDM                 VARCHAR2(30)     not null,
		   GROUPID              INTEGER,
		   GROUPLEVEL           INTEGER,
		   LEVEL1               INTEGER,
		   LEVEL2               INTEGER,
		   LEVEL3               INTEGER,
		   STATUS               INTEGER,
		   JJLY                 VARCHAR2(1000),
		   constraint BS_MENBER_JYPZ_MX primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_MENBER_JYPZ_MX is''供应商产品引用明细-设置集团或者子集团''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.PKID is''自增主键''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.PID is''BS_MENBER_JYPZ主键''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.GROUPID is''审批流id''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.GROUPLEVEL is''集团级或者子集团级（1-集团，2-子集团）''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.LEVEL1 is''审核总级别''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.LEVEL2 is''当前审核级别''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.LEVEL3 is''预留字段''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.STATUS is''状态''';
		execute immediate 'comment on column BS_MENBER_JYPZ_MX.JJLY is''拒绝理由''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_MENBER_JYPZ_MX_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_MENBER_JYPZ_MX_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;  
     
     ---add by zyy start---   
   tmp1:=upper('BS_MENBER_JYPZ_TMP');
  tmp2:=upper('jsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column BS_MENBER_JYPZ_TMP.jsbzh is ''技术标准号''';
  end if;
	---add by zyy end---
  -------------------------------------------------------------
end;
