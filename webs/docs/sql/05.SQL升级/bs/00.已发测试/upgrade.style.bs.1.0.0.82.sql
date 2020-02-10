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
  
  	-- 2015/03/30 hanglong	会员是否开通了我的超市(1-开通，0或者null-没开通)
	num:=0;
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('MYFLAG');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num=0 then
		execute immediate 'alter table '||tmp1||' add '||tmp2||' INTEGER';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员是否开通了我的超市(1-开通，0或者null-没开通)'''; 
	end if;
	--- end ---
	
	-- 2015/03/31 hanglong	会员-我的超市的logo图标
	num:=0;
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('LOGOIMAGE');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num=0 then
		execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员-我的超市的logo图标'''; 
	end if;
	--- end ---
	
	-- 2015/04/1 hanglong	会员消费类我的超市首页地址
	num:=0;
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('XFCMSURL');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num=0 then
		execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员消费类我的超市首页地址'''; 
	end if;
	--- end ---

	-- 2015/04/1 hanglong	会员工业类我的超市首页地址
	num:=0;
	tmp1:=upper('BS_MENBER');
	tmp2:=upper('GYCMSURL');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num=0 then
		execute immediate 'alter table '||tmp1||' add '||tmp2||' VARCHAR2(1000)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''会员工业类我的超市首页地址'''; 
	end if;
	--- end ---
	
  -------------------------------------------------------------
end;
