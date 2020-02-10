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
   
   --add by chenxp start--
   --项目
    --1名称  itemname
  
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemnamete = itemname';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemname');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标的物/服务/工程名称''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemname = itemnamete';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('itemnamete');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --2型号 xh
  
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testxh = xh';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('xh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''型号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set xh = testxh';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testxh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --3规格 gg
  
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgg = gg';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规格''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gg = testgg';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --4技术标准 jsbz
  
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsbz = jsbz';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsbz = testjsbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --5备注  bz
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testbz = bz';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('bz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set bz = testbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --6工程规模 gcgm
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgcgm = gcgm';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程规模''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gcgm = testgcgm';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --7 工期 gq
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgq = gq';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gq = testgq';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --8 工程质量标准 gczlbz
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgczlbz = gczlbz';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程质量标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gczlbz = testgczlbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testgczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --9 工程建设地点 jsdd 
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsdd = jsdd';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsdd = testjsdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testjsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --10 服务内容 fwnr
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwnr = fwnr';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务内容''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwnr = testfwnr';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --11 服务期 fwq
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwq = fwq';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwq = testfwq';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --12 服务地点 fwdd 
  --新增test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwdd = fwdd';
  end if;
  
  --删除
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_project_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwdd = testfwdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_project_item');
  tmp2:=upper('testfwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --招标项目
--1名称  itemname
  
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemnamete = itemname';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemname');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标的物/服务/工程名称''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemname = itemnamete';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('itemnamete');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --2型号 xh
  
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testxh = xh';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('xh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''型号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set xh = testxh';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testxh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --3规格 gg
  
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgg = gg';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规格''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gg = testgg';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --4技术标准 jsbz
  
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsbz = jsbz';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsbz = testjsbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --5备注  bz
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testbz = bz';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('bz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set bz = testbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --6工程规模 gcgm
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgcgm = gcgm';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程规模''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gcgm = testgcgm';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --7 工期 gq
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgq = gq';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gq = testgq';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --8 工程质量标准 gczlbz
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgczlbz = gczlbz';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程质量标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gczlbz = testgczlbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testgczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --9 工程建设地点 jsdd 
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsdd = jsdd';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsdd = testjsdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testjsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --10 服务内容 fwnr
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwnr = fwnr';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务内容''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwnr = testfwnr';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --11 服务期 fwq
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwq = fwq';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwq = testfwq';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --12 服务地点 fwdd 
  --新增test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwdd = fwdd';
  end if;
  
  --删除
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwdd = testfwdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_subproject_item');
  tmp2:=upper('testfwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --标段包
   --1名称  itemname
  
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemnamete');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemnamete = itemname';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemname');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标的物/服务/工程名称''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set itemname = itemnamete';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('itemnamete');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --2型号 xh
  
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testxh = xh';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('xh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''型号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set xh = testxh';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testxh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --3规格 gg
  
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgg = gg';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规格''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gg = testgg';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --4技术标准 jsbz
  
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsbz = jsbz';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsbz = testjsbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --5备注  bz
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testbz = bz';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('bz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('bz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set bz = testbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --6工程规模 gcgm
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgcgm = gcgm';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程规模''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gcgm = testgcgm';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --7 工期 gq
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgq = gq';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gq = testgq';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --8 工程质量标准 gczlbz
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgczlbz = gczlbz';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程质量标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gczlbz = testgczlbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testgczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --9 工程建设地点 jsdd 
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsdd = jsdd';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsdd = testjsdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testjsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --10 服务内容 fwnr
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwnr = fwnr';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务内容''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwnr = testfwnr';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  
  --11 服务期 fwq
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwq = fwq';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwq = testfwq';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --12 服务地点 fwdd 
  --新增test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwdd = fwdd';
  end if;
  
  --删除
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_package_item');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwdd = testfwdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_package_item');
  tmp2:=upper('testfwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;

   --add by chenxp end --
   
   ----add by hejw start-------------------
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('jsdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(500))';
    end if;
   ----add by hejw end-------------------
   
   -- add by chenxp start--
    --标段包报价明细
    --1名称  bdwmc
  
  --新增test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmcte');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmcte');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set bdwmcte = bdwmc';
  end if;
  
  --删除
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmc');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmc');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标的物/服务/工程名称''';
  end if;
  
  --赋值
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmc');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set bdwmc = bdwmcte';
  end if;
  
  --删除test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('bdwmcte');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --2型号 xh
  
  --新增test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testxh = xh';
  end if;
  
  --删除
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('xh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''型号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('xh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set xh = testxh';
  end if;
  
  --删除test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testxh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --3规格 gg
  
  --新增test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgg = gg';
  end if;
  
  --删除
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''规格''';
  end if;
  
  --赋值
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gg');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gg = testgg';
  end if;
  
  --删除test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgg');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --4技术标准 jsbz
  
  --新增test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testjsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsbz = jsbz';
  end if;
  
  --删除
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('jsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('jsbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsbz = testjsbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testjsbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  
  --7 工期 gq
  --新增test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgq = gq';
  end if;
  
  --删除
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gq = testgq';
  end if;
  
  --删除test
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('testgq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --合同明细
--1名称  wzmc_ch
  
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_chte');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_chte');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set wzmc_chte = wzmc_ch';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_ch');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_ch');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''物资名称(中文)''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_ch');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set wzmc_ch = wzmc_chte';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzmc_chte');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --2型号 wzstr1
  
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testwzstr1 = wzstr1';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr1');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''产品型号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set wzstr1 = testwzstr1';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr1');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --3规格 wzstr3
  
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr3');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr3');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testwzstr3 = wzstr3';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr3');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr3');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''产品规格''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('wzstr3');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set wzstr3 = testwzstr3';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testwzstr3');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --4技术标准 jsbzh
  
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsbzh = jsbzh';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsbzh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''技术标准号''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsbzh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsbzh = testjsbzh';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsbzh');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --5备注  remark
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testremark');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testremark');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testremark = remark';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('remark');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('remark');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''备注''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('remark');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set remark = testremark';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testremark');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
   --6工程规模 gcgm
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgcgm = gcgm';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程规模''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gcgm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gcgm = testgcgm';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgcgm');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --7 工期 gq
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgq = gq';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gq = testgq';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
   --8 工程质量标准 gczlbz
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testgczlbz = gczlbz';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程质量标准''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('gczlbz');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set gczlbz = testgczlbz';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testgczlbz');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --9 工程建设地点 jsdd 
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testjsdd = jsdd';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('jsdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set jsdd = testjsdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testjsdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --10 服务内容 fwnr
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwnr = fwnr';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务内容''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwnr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwnr = testfwnr';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwnr');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --11 服务期 fwq
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwq = fwq';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务期''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwq');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwq = testfwq';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwq');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  
  --12 服务地点 fwdd 
  --新增test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
  end if;
  
  --赋值test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set testfwdd = fwdd';
  end if;
  
  --删除
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  --新增
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''服务地点''';
  end if;
  
  --赋值
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('fwdd');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
     execute immediate 'update '||tmp1||' set fwdd = testfwdd';
  end if;
  
  --删除test
  tmp1:=upper('bd_contract_mx');
  tmp2:=upper('testfwdd');
  num:=1; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num =1 then
   execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;

   -- add by chenxp end ---

	----add by zhangzq 2017-02-10  采招网数据对照表创建 start------------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CZ_SJDZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
	-- 建表
	execute immediate '
	create table BD_CZ_SJDZ  (
		PKID number not null,
		TYP varchar2(50),
		CODE varchar2(10),
		MC varchar2(50),
		DZCODE varchar2(10),
		DZMC varchar2(100),
	   constraint PK_BD_CZ_SJDZ primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_CZ_SJDZ is ''数据对照表''';
	  execute immediate 'comment on column BD_CZ_SJDZ.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_CZ_SJDZ.TYP is ''表格类型名称''';
	  execute immediate 'comment on column BD_CZ_SJDZ.CODE is ''表格主键编号''';
	  execute immediate 'comment on column BD_CZ_SJDZ.MC is ''内容''';
	  execute immediate 'comment on column BD_CZ_SJDZ.DZCODE is ''对应的编号''';
	  execute immediate 'comment on column BD_CZ_SJDZ.DZMC is ''对应的内容''';
	
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_CZ_SJDZ_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_CZ_SJDZ_0
	minvalue 1
	maxvalue 9999999999999999999999999999
	start with 1
	increment by 1
	nocache
	order
	';
	end if;
	----add by zhangzq 2017-02-10  采招网数据对照表创建  end-------------------

	----add by hejw 2017-02-13  组建评委会增加字段  start-------------------
  --新增
  tmp1:=upper('BD_JURY_MEMBER');
  tmp2:=upper('sample_Time2');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自动抽取次数 1-第一轮 2-第二轮''';
  end if;
  
  --增加  自动抽取次数 1-第一轮 2-第二轮
  tmp1:=upper('BD_JURY_REQUIRE');
  tmp2:=upper('sample_Time2');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自动抽取次数 1-第一轮 2-第二轮''';
  end if;
  
  --增加  是否在超时失效中抽取 0ornull-不包括失效数据  1-包括失效数据
  tmp1:=upper('BD_JURY_REQUIRE');
  tmp2:=upper('iftimeout');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否在超时失效中抽取 0ornull-不包括失效数据  1-包括失效数据''';
  end if;
  
   --增加  自动抽取次数 1-第一轮 2-第二轮
  tmp1:=upper('BD_JURY');
  tmp2:=upper('sample_Time2');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自动抽取次数 1-第一轮 2-第二轮''';
  end if;
  
	----add by hejw 2017-02-13  组建评委会增加字段  end-------------------
   
    --add by chenxp start--
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('sealdata06');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交签名UUID''';
    end if;
  
  
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('sealdata07');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件撤回签名UUID''';
    end if;
    --add by chenxp end----
	
	--add by huyq 20170213 for 给招标项目扩展表新增一个字段----
	tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('sfxf');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付金额上浮或者下浮 0-上浮，1-下浮''';
    end if;
	--add by huyq 20170213 for 给招标项目扩展表新增一个字段----
	
	----add by huyq 2017-02-13  大屏显示动态信息 start------------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_DP_DYNAMIC');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
	-- 建表
	execute immediate '
	create table BD_DP_DYNAMIC  (
		PKID number not null,
		HYDM varchar2(30),
		HYNAME varchar2(250),
		CZYDM varchar2(30),
		CDATE date,
		CTYPE integer,
		STATUS integer,
		JSTYPE integer,
	   constraint BD_TBFKB_RECORD_0 primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_DP_DYNAMIC is ''大屏显示动态信息''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.HYDM is ''会员代码''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.HYNAME is ''会员名称''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.CZYDM is ''操作员代码''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.CDATE is ''创建时间''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.CTYPE is ''操作类型：1-签到 2-解密  3-确认''';
	  execute immediate 'comment on column BD_DP_DYNAMIC.STATUS is ''解密状态：1-成功  2失败''';	
	  execute immediate 'comment on column BD_DP_DYNAMIC.JSTYPE is ''角色类型：1-招标方，2-代理机构，3-投标方，4-监督人''';	
		
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_DP_DYNAMIC_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_DP_DYNAMIC_0
	minvalue 1
	maxvalue 9999999999999999999999999999
	start with 1
	increment by 1
	nocache
	order
	';
	end if;
	----add by huyq 2017-02-13  投标方开标流程记录表（大屏显示）  end-------------------

	tmp1:=upper('bd_jury');
    tmp2:=upper('PBCADDR');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标中心市名称''';
    end if;
    
    tmp1:=upper('BD_DP_DYNAMIC');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(23) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''标段包编号''';
    end if;
    
   ----add by hejw start-------------------
    tmp1:=upper('BD_ZBSTOPGG');
    tmp2:=upper('ycopt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(60))';
    end if;
    
    tmp1:=upper('BD_ZB_YC');
    tmp2:=upper('czydm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(60))';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('jsdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(400))';
    end if;
   ----add by hejw end-------------------

   ----add by zhangzq 2017-02-18  大屏消息队列表 start-------------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_DP_QUEUE');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_DP_QUEUE  (
		PKID number not null,
		TYP integer,
		BDID varchar2(23),
		PROBID varchar2(20),
		HYDM varchar2(30),
		CDATE date,
		FLAG integer，
	   constraint PK_BD_DP_QUEUE primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_DP_QUEUE is ''大屏消息队列表''';
	  execute immediate 'comment on column BD_DP_QUEUE.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_DP_QUEUE.TYP is ''类型''';
	  execute immediate 'comment on column BD_DP_QUEUE.BDID is ''标段（包）编号''';
	  execute immediate 'comment on column BD_DP_QUEUE.PROBID is ''招标项目编号''';
	  execute immediate 'comment on column BD_DP_QUEUE.HYDM is ''操作人的会员代码''';
	  execute immediate 'comment on column BD_DP_QUEUE.CDATE is ''操作时间''';
	  execute immediate 'comment on column BD_DP_QUEUE.FLAG is ''数据传输方向，1-评审平台''';
	
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_DP_QUEUE_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_DP_QUEUE_0
	minvalue 1
	maxvalue 9999999999999999999999999999
	start with 1
	increment by 1
	nocache
	order
	';
	end if;
	----add by zhangzq 2017-02-18  大屏消息队列表  end-------------------
	tmp1:=upper('BD_DP_DYNAMIC');
    tmp2:=upper('remark');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''描述''';
    end if;
    
    tmp1:=upper('BD_DP_QUEUE');
    tmp2:=upper('extbillno');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''相关单号''';
    end if;
    
    ----modify hejw 修改长度 start----------
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('majormc');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
    end if;
    ----modify hejw 修改长度 end----------

    --add by chenxp start 修改备注--
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('zgyswjdjzt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件递交状态 null-未上传,0-已撤销 1-已上传未提交 2-已提交''';
    end if;
  
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('tbwjdjzt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标文件递交状态  null-未上传 ,0-已撤销,1-已上传未提交 ,2-已提交''';
    end if;
    --add by chenxp end 修改备注---
    
    --------------add by songw 2017年2月27日 start-----------------------
    --add扩大专家专业字段大小
    tmp1:=upper('BD_EXPERT');
    tmp2:=upper('major');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(1000))';
    end if;
    --------------add by songw 2017年2月27日 end-----------------------

	tmp1:=upper('BD_PAY_REQUEST');
    tmp2:=upper('mfphm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(32))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''主单号-申请退款有效''';
    end if;
    
    tmp1:=upper('BD_ZFQD_QUENUE');
    tmp2:=upper('status');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''状态：0 - 待发送 1 - 发送错误 2 - 已送达''';
    end if;
    
    tmp1:=upper('BD_ZFQD_QUENUE');
    tmp2:=upper('errtimes');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER )';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''错误次数''';
    end if;
    
    tmp1:=upper('BD_ZFQD_QUENUE');
    tmp2:=upper('errmsg');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(300))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''最后一次错误原因''';
    end if;
    
    ------------监管资金出入金流水建表------BY.zhminfu----------------------
    num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_IN_OUT_AMT');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_IN_OUT_AMT  (
	   PKID                 NUMBER  not null,
	   BKID                 VARCHAR2(30),
	   HYDM                 VARCHAR2(30),
	   CDATE                DATE,
	   ACC_TYPE             INT,
	   ACC_FLAG             INT,
	   TB_MB_CODE           VARCHAR2(30),
	   TB_MB_NAME           VARCHAR2(250),
	   BD_BILL_NO           VARCHAR2(32),
	   BD_NAME              VARCHAR2(500),
	   BCUSTACCT            VARCHAR2(30),
	   OPP_ACC_NO           VARCHAR2(30),
	   OPP_ACC_NAME         VARCHAR2(80),
	   OPP_BRANCH_NAME      VARCHAR2(80),
	   OPP_BRANCH_NO        VARCHAR2(10),
	   IN_OUT_FLAG          INT,
	   BAO_FLAG             INT,
	   AMT                  NUMBER(15,2),
	   BPKID                NUMBER,
	   constraint PK_BD_IN_OUT_AMT primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_IN_OUT_AMT is ''监管资金出入金流水''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.PKID is ''主键ID''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BKID is ''银行编号''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.HYDM is ''会员代码''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.CDATE is ''日期''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.ACC_TYPE is ''签约类型：1 - 固定（招标方自有资金充值） 2 - 临时''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.ACC_FLAG is ''临时账户类型：0 - 固定 1-资格预审文件 -标书文件费用 3-投标保证金 4 -图纸押金 5-履约保证金''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.TB_MB_CODE is ''投标方会员代码''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.TB_MB_NAME is ''投标方会员名称''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BD_BILL_NO is ''标段编号''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BD_NAME is ''标段名称''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BCUSTACCT is ''银行子账户号''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.OPP_ACC_NO is ''对方账号''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.OPP_ACC_NAME is ''对方开户名''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.OPP_BRANCH_NAME is ''对方开户行名称''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.OPP_BRANCH_NO is ''对方开户行号''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.IN_OUT_FLAG is ''1-入金 2-出金''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BAO_FLAG is ''1-保证金 0-其他''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.AMT is ''发生金额''';
	  execute immediate 'comment on column BD_IN_OUT_AMT.BPKID is ''监管系统流水编号''';
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_IN_OUT_AMT_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_IN_OUT_AMT_0
	  minvalue 1
	  maxvalue 9999999999999999999999999999
	  start with 1
	  increment by 1
	  nocache
	  order
	  ';
	end if;
	
	-----add hejw 增加是否限制一个单位只能抽取一个专家    start ---------------
    tmp1:=upper('BD_JURY');
    tmp2:=upper('limit');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否1个单位只能抽取1个专家 nullor0-不限制  1-限制(1个单位只能抽取1个)''';
    end if;
	-----add hejw 增加是否限制一个单位只能抽取一个专家    end ---------------

    --修改字段长度--hejw----------
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('major');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
    end if;
	
	------------CFCA中金支付------BY.zhminfu----------------------
    num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CFCA_ZFQD');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CFCA_ZFQD  (
		  FPHM     VARCHAR2(32) not null,
		  BFPHM    VARCHAR2(32),
		  STATUS   INTEGER,
		  TYP      INTEGER,
		  HYDM     VARCHAR2(30),
		  HYNAME   VARCHAR2(80),
		  CARDNO   VARCHAR2(30),
		  CARDNAME VARCHAR2(80),
		  DEPID    VARCHAR2(30),
		  BANKID   VARCHAR2(30),
		  ACCTYP   VARCHAR2(30),
		  CARDTYP  VARCHAR2(30),
		  AMT0     NUMBER(20,2),
		  AMT1     NUMBER(20,2),
		  AMT2     NUMBER(20,2),
		  AMT3     NUMBER(20,2),
		  AMT4     NUMBER(20,2),
		  URL1     VARCHAR2(300),
		  URL2     VARCHAR2(300),
		  TITLE    VARCHAR2(100),
		  TIMEMD5  VARCHAR2(32),
		  POSTURL  VARCHAR2(300),
		  OPT1     VARCHAR2(80),
		  OPT2     VARCHAR2(80),
		  OPT3     VARCHAR2(80),
		  OPT4     VARCHAR2(80),
		  OPT5     VARCHAR2(80),
		  OPT1CODE VARCHAR2(80),
		  OPT2CODE VARCHAR2(80),
		  OPT3CODE VARCHAR2(80),
		  OPT4CODE VARCHAR2(80),
		  OPT5CODE VARCHAR2(80),
		  DATE0    DATE,
		  DATE1    DATE,
		  DATE2    DATE,
		  DATE3    DATE,
		  DATE4    DATE,
		  DATE5    DATE,
		  MD5SIGN  VARCHAR2(32),
		  FLAG0    INTEGER,
		  FLAG1    INTEGER,
		  FLAG2    INTEGER,
		  PAYNO    VARCHAR2(32),
		  ZFTIME   VARCHAR2(32),
		  SETTLENO VARCHAR2(32),
	   	constraint PK_BD_CFCA_ZFQD primary key (FPHM)
	  )';
	  -- 注释
	  execute immediate 'comment on column BD_CFCA_ZFQD.FPHM is ''支付单号''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.BFPHM is ''招投标平台支付单号''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.STATUS is ''状态： 0 - 作废 9 - 超时作废 1 - 创建 2 - 已提交银行 8 - 已付款 10-已结算''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.TYP is ''支付类型（用途）：内详1- 支付预审文件  2--支付投标书 ''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.HYDM is ''付款方会员代码''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.HYNAME is ''付款方会员名称''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.CARDNO is ''付款方资金账号''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.CARDNAME is ''付款方开户名称''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DEPID is ''付款方操作员部门''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.BANKID is ''付款银行ID''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.ACCTYP is ''账户类型:11个人账户 12企业账户''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.CARDTYP is ''银行卡类型:01借记卡02 贷记卡''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.AMT0 is ''总付款金额（付款方需要支付的金额）''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.AMT1 is ''总货款金额''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.AMT2 is ''总手续费金额''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.AMT3 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.AMT4 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.URL1 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.URL2 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.TITLE is ''标题''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.TIMEMD5 is ''时间戳，防止并发操作''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.POSTURL is ''回调通知URL''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT1 is ''申请人''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT2 is ''录入人''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT3 is ''复核人（支付人）''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT4 is ''支付类型0 、支付货款 1、结算单''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT1CODE is ''申请人ID''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT2CODE is ''录入人ID''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.OPT3CODE is ''复核人ID''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE0 is ''支付截止日''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE1 is ''创建日期''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE2 is ''录入日期''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE3 is ''复核人，支付日期''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE4 is ''关闭日期（超时未支付日期）''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.DATE5 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.MD5SIGN is ''数据校验码''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.FLAG0 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.FLAG1 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.FLAG2 is ''备用''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.PAYNO is ''支付流水号''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.ZFTIME is ''银行端支付时间''';
	  execute immediate 'comment on column BD_CFCA_ZFQD.SETTLENO is ''结算流水单号''';
	end if;
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CFCA_ZFQD_MX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CFCA_ZFQD_MX  (
		  FPHM    VARCHAR2(32) not null,
		  XH      INTEGER not null,
		  AMT     NUMBER(20,2) not null,
		  ERRMSG  VARCHAR2(300),
		  STATUS  INTEGER,
		  OPT     INTEGER,
		  BDID    VARCHAR2(32),
		  EXTBILL VARCHAR2(32),
		  HYDM1   VARCHAR2(30),
		  MBNAME1 VARCHAR2(250),
		  CARDNO1 VARCHAR2(30),
		  REMARK1 VARCHAR2(300),
		  DEPID1  VARCHAR2(30),
		  HYDM2   VARCHAR2(30),
		  MBNAME2 VARCHAR2(250),
		  CARDNO2 VARCHAR2(30),
		  REMARK2 VARCHAR2(300),
		  DEPID2  VARCHAR2(30),
	   	constraint PK_BD_CFCA_ZFQD_MX primary key (FPHM, XH)
	  )';
	  -- 注释
	    execute immediate 'comment on column BD_CFCA_ZFQD_MX.FPHM is ''支付单号''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.XH is ''序号''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.AMT is ''金额''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.ERRMSG is ''失败原因''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.STATUS is ''支付状态：1 - 成功 0 - 失败''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.OPT is ''操作类型： 2 - 支付 1 - 冻结 0 - 解冻''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.BDID is ''标段包编号(没有就不填)''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.EXTBILL is ''相关单号''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.HYDM1 is ''付款方代码（商户系统）''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.MBNAME1 is ''付款方名称''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.CARDNO1 is ''付款方卡号''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.REMARK1 is ''付款方备注''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.DEPID1 is ''部门编码（每个级别2位） 00 - 默认部门编码（每个会员都有）''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.HYDM2 is ''收款方代码（商户系统）''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.MBNAME2 is ''收款方名称''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.CARDNO2 is ''收款方卡号''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.REMARK2 is ''收款方备注''';
		execute immediate 'comment on column BD_CFCA_ZFQD_MX.DEPID2 is ''部门编码（每个级别2位） 00 - 默认部门编码（每个会员都有）''';
	end if;
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CFCA_SEND');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CFCA_SEND  (
		  ID        VARCHAR2(32) not null,
		  BKID      VARCHAR2(10),
		  SHOPNO    VARCHAR2(30),
		  ENNAME    VARCHAR2(10),
		  MBCODE    VARCHAR2(30),
		  EXTBILLNO VARCHAR2(32),
		  STATUS    INTEGER,
		  ERRMSG    VARCHAR2(300),
		  BKSEQNO   VARCHAR2(30),
		  AMT       NUMBER(20,2),
		  OTP       INTEGER,
		  TYP       VARCHAR2(10),
		  OPT       VARCHAR2(30),
		  DATE0     DATE,
		  DATE1     DATE,
		  DATE3     DATE,
		  DATE4     DATE,
		  DATE5     DATE,
		  DATE6     DATE,
		  DATE7     DATE,
		  DATE8     DATE,
		  DATE9     DATE,
		  DATE2     DATE,
		  ACCTYP    INTEGER,
		  MTPCODE   VARCHAR2(5),
		  BKREF0    VARCHAR2(30),
		  BKREF1    VARCHAR2(30),
		  BKREF3    VARCHAR2(30),
		  BKREF4    VARCHAR2(30),
		  BKREF5    VARCHAR2(30),
		  BKREF2    VARCHAR2(30),
		  REFSTR3   VARCHAR2(30),
		  REFSTR1   VARCHAR2(30),
		  REFSTR4   VARCHAR2(30),
		  REFSTR5   VARCHAR2(80),
		  REFSTR6   VARCHAR2(80),
		  REFSTR7   VARCHAR2(100),
		  REFSTR8   VARCHAR2(100),
		  REFSTR9   VARCHAR2(300),
		  REFSTR2   VARCHAR2(30),
		  REFSTR0   VARCHAR2(30),
		  FLAG0     INTEGER,
		  FLAG2     INTEGER,
		  FLAG3     INTEGER,
		  FLAG4     INTEGER,
		  FLAG5     INTEGER,
		  FLAG6     INTEGER,
		  FLAG7     INTEGER,
		  FLAG8     INTEGER,
		  FLAG9     INTEGER,
		  HTAMT     NUMBER(20,2),
		  SETTLENO  VARCHAR2(32),
	   	constraint PK_BD_CFCA_SEND primary key (ID)
	  )';
	  -- 注释
	    execute immediate 'comment on column BD_CFCA_SEND.ID is ''付款流水编号''';
		execute immediate 'comment on column BD_CFCA_SEND.BKID is ''银行代码''';
		execute immediate 'comment on column BD_CFCA_SEND.SHOPNO
		  is ''商户号
		  000000 - 默认商户
		  001000 - XXXXXX
		  所有其他第三方商户从1000号开始往后''';
		execute immediate 'comment on column BD_CFCA_SEND.ENNAME is ''银行名称，英文缩写（必须唯一，银行接口写死）''';
		execute immediate 'comment on column BD_CFCA_SEND.MBCODE is ''资金会员代码''';
		execute immediate 'comment on column BD_CFCA_SEND.EXTBILLNO is ''业务单据号''';
		execute immediate 'comment on column BD_CFCA_SEND.STATUS
		  is ''状态：
		   0 - 作废（无效）
		  1 - 生成
		  2 - 已提交到银行（银行答复订单接收，本功能暂不支持）
		  3 - 银行已答复，正在资金账务处理（防止并发，过度状态）（无效）
		  4 - 已记账成功
		  5 - 银行答复支付失败（无效）
		  6 - 银行答复支付成功，但是交易资金处理失败（无效）''';
		execute immediate 'comment on column BD_CFCA_SEND.ERRMSG is ''错误消息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKSEQNO is ''银行流水码''';
		execute immediate 'comment on column BD_CFCA_SEND.AMT is ''支付金额''';
		execute immediate 'comment on column BD_CFCA_SEND.OTP is ''操作类型： 1 - 账户充值''';
		execute immediate 'comment on column BD_CFCA_SEND.TYP is ''类型：B2B、B2C''';
		execute immediate 'comment on column BD_CFCA_SEND.OPT is ''创建人''';
		execute immediate 'comment on column BD_CFCA_SEND.DATE0 is ''创建日期''';
		execute immediate 'comment on column BD_CFCA_SEND.DATE1 is ''提交日期''';
		execute immediate 'comment on column BD_CFCA_SEND.DATE2 is ''银行答复日期''';
		execute immediate 'comment on column BD_CFCA_SEND.ACCTYP is ''账户类型：（内详）0 - 现金账户（含支票）1 - 承兑账户''';
		execute immediate 'comment on column BD_CFCA_SEND.MTPCODE is ''币种代码，人民币为：001''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF0 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF1 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF3 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF4 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF5 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.BKREF2 is ''银行备注信息''';
		execute immediate 'comment on column BD_CFCA_SEND.HTAMT is ''贷款金额''';
		execute immediate 'comment on column BD_CFCA_SEND.SETTLENO is ''结算流水单号''';
	end if;
	
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CFCA_CONF');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CFCA_CONF  (
		  BKID   VARCHAR2(15) not null,
		  ITYP   VARCHAR2(15) not null,
		  KEY    VARCHAR2(30) not null,
		  VALUE  VARCHAR2(200),
		  REMARK VARCHAR2(200),
	   	constraint PK_BD_CFCA_CONF primary key (BKID, ITYP, KEY)
	  )';
	  -- 注释
	    execute immediate 'comment on column BD_CFCA_CONF.BKID is ''银行简称缩写''';
		execute immediate 'comment on column BD_CFCA_CONF.ITYP is ''银行接口标志''';
		execute immediate 'comment on column BD_CFCA_CONF.KEY is ''关键字''';
		execute immediate 'comment on column BD_CFCA_CONF.VALUE is ''值''';
		execute immediate 'comment on column BD_CFCA_CONF.REMARK is ''备注''';
	end if;
	
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('quation');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(3800))';
    end if;

    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('preult');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(3800))';
    end if;
    
    
    tmp1:=upper('BD_ZFQD_QUENUE');
    tmp2:=upper('FPHM');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(50))';
    end if;
	
    
    
  -----------------------------------------------------------------
    ----------add by songw 2017年3月10日 start--------------
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('dtype11');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人提出问题的截止时间类型 1-日历 2-天数''';
    end if;
    
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('dtype12');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人书面澄清的时间类型 1-日历 2-天数''';
    end if;
    
    
    ----------add by songw 2017年3月10日 end--------------

    ----modify 修改字段长 hejw start----------------
    tmp1:=upper('BD_SUBPROJECT_EXT');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_DISSENT');
    tmp2:=upper('aoldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_CC_RECEIPT');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_PACKAGE_ITEM');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_PROJECT_ITEM');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_SUBPROJECT_ITEM');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    tmp2:=upper('oldname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(200))';
    end if;
    ----modify 修改字段长 hejw end----------------

    --修改字段类型
    -- 增加 bdid_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    end if;
-- 赋值 bdid_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set bdid_tmp = bdid';
    end if;
-- 删除 bdid
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
-- 创建 bdid
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    end if;
-- 赋值 bdid
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set bdid = bdid_tmp';
    end if;
-- 删除 bdid_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('bdid_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
------------修改有数据字段长度结束----------------------------------------------------
-- 增加 packname_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    end if;
-- 赋值 packname_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set packname_tmp = packname';
    end if;
-- 删除 packname
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
-- 创建 packname
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(4000))';
    end if;
-- 赋值 packname
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set packname = packname_tmp';
    end if;
-- 删除 packname_tmp
    tmp1:=upper('BD_CCNOTICE');
    tmp2:=upper('packname_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
------------修改有数据字段类型结束----------------------------------------------------

    ------------add by songw 2017年3月27日 start----------------------
    tmp1:=upper('BD_DB_HXRGS');
    tmp2:=upper('hxrgsrs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示人数''';
    end if;
    ------------add by songw 2017年3月27日 end----------------------

	--add by chenxp start--
	tmp1:=upper('bd_jury');
  	tmp2:=upper('gbunit');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 1 then
    	execute immediate 'alter table '||tmp1||' modify('||tmp2||' varchar2(4000) )';
  	end if;
	--add by chenxp end ---

	--add by hejw start ---
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('buylxr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''购买联系人''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('buylxtel');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''购买联系方式''';
    end if;
    
    tmp1:=upper('Bd_Jury');
    tmp2:=upper('fristDate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''指定抽取专家，第一次保存时间''';
    end if;
	--add by hejw end ---
 
    ------------add by songw 2017年4月10日 start----------------------
    --add 在招标项目拓展表中增加招标项目停用理由，附件，附件名字段
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('blockreason');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目停用理由''';
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('blockfile');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目停用附件''';
    end if;
    
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('blockfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标项目停用附件名称''';
    end if;
    
    ------------add by songw 2017年4月10日 end----------------------

    ------------add by hejw 2017年4月19日 start----------------------
    --短信队列
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_SMS_QUEUE');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
    -- 建表
    execute immediate '
    create table BD_SMS_QUEUE  (
       PKID                 NUMBER  not null,
       mobile               VARCHAR2(30),
       bid                  VARCHAR2(30),
       zid                  VARCHAR2(30),
       json                 VARCHAR2(2000),
       founder              VARCHAR2(80),
       cdate                DATE,
       status               NUMBER,
       fsdate               DATE,
       constraint PK_BD_SMS_QUEUE primary key (PKID)
      )';
      -- 注释
      execute immediate 'comment on table BD_SMS_QUEUE is ''短信队列''';
      execute immediate 'comment on column BD_SMS_QUEUE.PKID is ''主键ID''';
      execute immediate 'comment on column BD_SMS_QUEUE.mobile is ''手机号码''';
      execute immediate 'comment on column BD_SMS_QUEUE.bid is ''编号''';
      execute immediate 'comment on column BD_SMS_QUEUE.zid is ''小编号''';
      execute immediate 'comment on column BD_SMS_QUEUE.json is ''短信模板待替换数据''';
    execute immediate 'comment on column BD_SMS_QUEUE.cdate is ''创建时间''';
    execute immediate 'comment on column BD_SMS_QUEUE.founder is ''创建人''';    
      execute immediate 'comment on column BD_SMS_QUEUE.status is ''是否已发送 0ornull-未发送  1-已发送''';
      execute immediate 'comment on column BD_SMS_QUEUE.fsdate is ''发送时间''';
    end if;
    -- Create sequence 
    num:=0; 
    tmp1:=upper('BD_SMS_QUEUE_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BD_SMS_QUEUE_0
      minvalue 1
      maxvalue 9999999999999999999999999999
      start with 1
      increment by 1
      nocache
      order
      ';
    end if;
    ------------add by hejw 2017年4月19日 end----------------------

    ------------add by songw 2017年4月17日 start-------------------
    --增加委托协议中，招标代理服务费的支付金额方式增加其他方式支付
    tmp1:=upper('bd_subproject_ext');
    tmp2:=upper('zfqtfs');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''委托协议-招标代理服务费-支付金额-其他方式计算''';
    end if;
    ------------add by songw 2017年4月17日 end-------------------

	----add by zhangj 2017年4月20日 start-------------------
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('DLJGZBID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(30))';
    end if;
   ----add by zhangj 2017年4月20日 end-------------------

    ------ update by hejw start -----
    tmp1:=upper('BD_IN_OUT_AMT');
    tmp2:=upper('OPP_BRANCH_NO');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(20))';
    end if;
    ------ update by hejw end -----


end;