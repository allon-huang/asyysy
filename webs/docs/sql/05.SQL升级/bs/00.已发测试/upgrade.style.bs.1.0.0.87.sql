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
  	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_MENBER_JSXZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		  create table BS_MENBER_JSXZ  (
		   PKID                 INTEGER                          not null,
		   HYDM                 VARCHAR2(30)                    not null,
		   GROUPQX              VARCHAR2(300),
		   STR05                VARCHAR2(300),
		   STATUS               INTEGER,
		   JJLY                 VARCHAR2(1000),
		   constraint PK_BS_MENBER_JSXZ primary key (PKID)
		)
		';

		execute immediate 'comment on table BS_MENBER_JSXZ is''会员角色选择''';
		execute immediate 'comment on column BS_MENBER_JSXZ.PKID is''序号''';
		execute immediate 'comment on column BS_MENBER_JSXZ.HYDM is''会员代码''';
		execute immediate 'comment on column BS_MENBER_JSXZ.GROUPQX is''权限平台''';
		execute immediate 'comment on column BS_MENBER_JSXZ.STR05 is''角色类型''';
		execute immediate 'comment on column BS_MENBER_JSXZ.STATUS is''状态''';
		execute immediate 'comment on column BS_MENBER_JSXZ.JJLY is''拒绝理由''';
	end if;
	
	num:=0; 
    tmp1:=upper('BS_MENBER_JSXZ_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
	      execute immediate 'create sequence BS_MENBER_JSXZ_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
	  ';
     end if;  	
  -------------------------------------------------------------
end;
