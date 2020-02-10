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
  	
  tmp1:=upper('BS_MENBER_JSXZ');
  tmp2:=upper('jsname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MENBER_JSXZ.jsname is ''角色名称''';
  end if;     
  	
   tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('zxlevel');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.zxlevel is ''资信等级''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professcode is ''职业人员代码''';
  end if;

  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professxb');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
   execute immediate 'comment on column BS_MB_EXT.professxb is ''性别''';
  end if;
 
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professyear');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.professyear is ''出生年份''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professmonth');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.professmonth is ''出生月份''';
  end if;   
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('admindq1name');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.admindq1name is ''省级名称''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('admindqname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.admindqname is ''市级名称''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('adminxjname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.adminxjname is ''县级名称''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('admindq1code');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.admindq1code is ''省级代码''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('admindqcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.admindqcode is ''市级名代码''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('adminxjcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.adminxjcode is ''县级代码''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('education');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.education is ''学历''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('prefesstel');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.prefesstel is ''联系电话''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('maildq1name');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.maildq1name is ''通信省级名称''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('maildqname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.maildqname is ''通信市级名称''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('mailxjname');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.mailxjname is ''通信县级名称''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('maildq1code');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.maildq1code is ''通信省级代码''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('maildqcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.maildqcode is ''通信市级名代码''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('mailxjcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.mailxjcode is ''通信县级代码''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('mailaddr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.mailaddr is ''通信详细地址''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professpostcode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
   execute immediate 'comment on column BS_MB_EXT.professpostcode is ''邮编''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professdw');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professdw is ''单位''';
  end if;   
 
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('isworking');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1))';
   execute immediate 'comment on column BS_MB_EXT.isworking is ''是否在职''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professduty');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professduty is ''职务''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professtitle');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professtitle is ''所在职称''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professexper');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(3000))';
   execute immediate 'comment on column BS_MB_EXT.professexper is ''经历''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professtime');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(8))';
   execute immediate 'comment on column BS_MB_EXT.professtime is ''从业年限''';
  end if;  
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professxh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professxh is ''职业资格序列''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professlevel');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professlevel is ''职业资格等级''';
  end if; 
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professhm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professhm is ''资格证书编号''';
  end if;
  
  tmp1:=upper('BS_MB_EXT');
  tmp2:=upper('professlevelhm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
   execute immediate 'comment on column BS_MB_EXT.professlevelhm is ''注册等级证书编号''';
  end if;                  	
  -------------------------------------------------------------
end;
