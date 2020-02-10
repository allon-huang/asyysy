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
  tmp2:=upper('mobileLastTime');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' Date)';
   execute immediate 'comment on column Bs_Mbopt.mobileLastTime is ''手机端 最后缓存时间''';
  end if; 
  
  tmp1:=upper('Bs_Mbopt');
  tmp2:=upper('mobileMd5');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
   execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
   execute immediate 'comment on column Bs_Mbopt.mobileMd5 is ''手机端 防止重复登录''';
  end if; 
  
  
  --------------------------------
  tmp1:=upper('bs_mbopt');
  tmp2:=upper('grzfmm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
         execute immediate 'alter table BS_MBOPT drop column grzfmm'; 
  end if; 

  tmp1:=upper('bs_mbopt');
  tmp2:=upper('grzfmm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(32))';
  execute immediate 'comment on column bs_mbopt.grzfmm is ''个人手机支付密码''';
  end if; 
  --------------------------------
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('KHBANK');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(100)';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('KHNAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(250)';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('KHZH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify '||tmp2||' varchar2(50)';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('creditCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
  execute immediate 'comment on column BS_MENBER.creditCode is ''社会信用代码''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('serviceCompany');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
  execute immediate 'comment on column BS_MENBER.serviceCompany is ''所服务系统内企业''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('lxraddr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER.lxraddr is ''联系人地址''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('FINISH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
  execute immediate 'comment on column BS_MENBER.FINISH is ''资料完善程度(0-刚导入的数据，1-完成第一步，2-完成第二步，3-完成第三步，4-完成第四步，5-资料全部完善)''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('GROUPQX');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER.GROUPQX is ''用户注册选择的功能权限组（1-网上超市，2-商品询价交易，3-法务询价交易，4-废旧物资竞拍，5-电子招标投标交易，6-竞价采购交易）''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('GROUPQX');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER_TMP.GROUPQX is ''用户注册选择的功能权限组（1-网上超市，2-商品询价交易，3-法务询价交易，4-废旧物资竞拍，5-电子招标投标交易，6-竞价采购交易）''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('crediturl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER.crediturl is ''社会信用代码证扫描件''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('licenseType');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
  execute immediate 'comment on column BS_MENBER.licenseType is ''执照类型（1-三证，2-一证）''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('proveManagerOpt');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER.proveManagerOpt is ''平台管理员证明''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('companyYear');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER.companyYear is ''公司成立时间-年''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('companyMonth');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER.companyMonth is ''公司成立时间-月''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('crediturl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER_TMP.crediturl is ''社会信用代码证扫描件''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('licenseType');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
  execute immediate 'comment on column BS_MENBER_TMP.licenseType is ''执照类型（1-三证，2-一证）''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('creditCode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
  execute immediate 'comment on column BS_MENBER_TMP.creditCode is ''社会信用代码''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('serviceCompany');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
  execute immediate 'comment on column BS_MENBER_TMP.serviceCompany is ''所服务系统内企业''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('lxraddr');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER_TMP.lxraddr is ''联系人地址''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('proveManagerOpt');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(300))';
  execute immediate 'comment on column BS_MENBER_TMP.proveManagerOpt is ''平台管理员证明''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('companyYear');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER_TMP.companyYear is ''公司成立时间-年''';
  end if; 
  
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('companyMonth');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER_TMP.companyMonth is ''公司成立时间-月''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('supStatus');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER)';
  execute immediate 'comment on column BS_MENBER.supStatus is ''0-未提交审核，1-提交待审核，2或者空（旧数据）-已审核通过，3-审核拒绝''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('jjly');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(500))';
  execute immediate 'comment on column BS_MENBER.jjly is ''供应商审核拒绝理由''';
  end if; 
  
   tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('PHONENO');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
  execute immediate 'comment on column BS_MENBER_TMP.PHONENO is ''固定电话''';
  end if; 
  
   tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('gyslx');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
  execute immediate 'comment on column BS_MENBER_TMP.gyslx is ''供应商类型''';
  end if; 
  
   tmp1:=upper('BS_MENBER');
  tmp2:=upper('gyslx');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(100))';
  execute immediate 'comment on column BS_MENBER.gyslx is ''供应商类型''';
  end if; 
  
    tmp1:=upper('bs_menber');
	tmp2:=upper('servicecompany');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
	end if;

	tmp1:=upper('bs_menber_tmp');
	tmp2:=upper('servicecompany');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(2000))';
	end if;

	
		-- SQL升级实例-CREATE TABLE
	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_SUPPLIER_MG');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BS_SUPPLIER_MG  (
		   HYDM                 VARCHAR(30)                     not null,
		   HYNAME               VARCHAR2(250)                   not null,
		   HZDM                 VARCHAR2(30)                    not null,
		   HZNAME               VARCHAR2(250)                   not null,
		   STATUE               INT,
		   OPT                  VARCHAR2(30),
		   TYYY                 VARCHAR2(200),
		   TYRQ                 TIMESTAMP,
		   TYPE                 INT,
		   LBDM                 VARCHAR(4000),
		   LBMC                 VARCHAR2(4000),
		   COTE                 TIMESTAMP,
		   constraint PK_BS_SUPPLIER_MG primary key (HYDM, HZDM)
		)
		';		
		-- 注释			
		execute immediate ' 	comment on table BS_SUPPLIER_MG is ''供应商管理'' ';		
		execute immediate '	comment on column BS_SUPPLIER_MG.HYDM is ''成员单位代码'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.HYNAME is ''成交单位名称'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.HZDM is ''供应商代码'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.HZNAME is ''供应商名称'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.STATUE is ''状态：0 - 停用 1 - 启用'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.OPT is ''启用人/停用人'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.TYYY is ''停用原因'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.TYRQ is ''停用日期'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.TYPE is ''是否是集团供应商：0 - 是 2 - 不是'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.LBDM is ''供应商类别代码'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.LBMC is ''供应商类别名称'' ';
		execute immediate '	comment on column BS_SUPPLIER_MG.COTE is ''创建日期'' ';

	end if;

	
	  tmp1:=upper('bs_menber');
  tmp2:=upper('twoEdit');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(3))';
  execute immediate 'comment on column bs_menber.twoEdit is ''第1次审核后，再次维护会员信息标识''';
  end if; 

  
    tmp1:=upper('bs_menber');
  tmp2:=upper('twoEditJson');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
  execute immediate 'comment on column bs_menber.twoEditJson is ''第1次审核后，再次维护会员信息 json''';
  end if; 
  
	  --在BS_SUPPLIER_MG中新增字段refstr03供应商赋码
	  tmp1:=upper('BS_SUPPLIER_MG');
	  tmp2:=upper('refstr03');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
	  execute immediate 'comment on column BS_SUPPLIER_MG.refstr03 is ''供应商赋码''';
	  end if; 
	  
	  
	  
	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BS_SUPPLIER_PF');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BS_SUPPLIER_PF  (
		   PKID                 NUMBER                    not null,
		   HZDM                 VARCHAR2(30)                    not null,
		   HZNAME               VARCHAR2(250)                   not null,
		   HZFM                 VARCHAR2(60),                   
		   HYDM                 VARCHAR2(30),
		   HYNAME               VARCHAR2(250),
		   HYFM                 VARCHAR2(60),
		   PJDATE               DATE,
		   CDATE                DATE,
		   OPT                  VARCHAR2(30),
		   RESULT               VARCHAR2(4000),
		   REMARKS              VARCHAR2(4000),
		   TUPE                 INT,
		   constraint PK_BS_SUPPLIER_PF primary key (PKID)
		)
		';		
		-- 注释			
		execute immediate ' comment on column BS_SUPPLIER_PF.HZDM is ''供应商代码'' ';		
		execute immediate '	comment on column BS_SUPPLIER_PF.HZNAME is ''供应商名称'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.HZFM is ''供应商赋码'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.HYDM is ''成员单位代码'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.HYNAME is ''成员单位名称'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.HYFM is ''成员单位赋码'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.PJDATE is ''评价时间'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.CDATE is ''导入时间'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.OPT is ''操作员'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.RESULT is ''评价结果'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.REMARKS is ''备注'' ';
		execute immediate '	comment on column BS_SUPPLIER_PF.TUPE is ''增加方式：1-导入  2-新增'' ';

	end if; 
	
	num:=0; 
    tmp1:=upper('BS_SUPPLIER_PF_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      execute immediate 'create sequence BS_SUPPLIER_PF_0 
  minvalue 1
  maxvalue 9999999999999999999999999999
  start with 1
  increment by 1
  nocache
  order
  ';
     end if;    
	  
	    
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('FINISH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(8))';
  execute immediate 'comment on column BS_MENBER_TMP.FINISH is ''保存当前步骤''';
  end if; 
	    
  tmp1:=upper('BS_MENBER_TMP');
  tmp2:=upper('fatherdwName');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
  execute immediate 'comment on column BS_MENBER_TMP.fatherdwName is ''隶属制造厂家''';
  end if; 
  
  tmp1:=upper('BS_MENBER');
  tmp2:=upper('fatherdwName');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(2000))';
  execute immediate 'comment on column BS_MENBER.fatherdwName is ''隶属制造厂家''';
  end if;
  
  tmp1:=upper('BS_XTMK');
  tmp2:=upper('icon');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(50))';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''保存招标平台菜单个性化图标''';
  end if; 
  
  tmp1:=upper('BS_XTMK');
  tmp2:=upper('ISCHILD');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中兵招投标项目-是否有子菜单（1-没有子菜单，other-有子菜单）''';
  end if;
  
  tmp1:=upper('BS_QXSZ');
  tmp2:=upper('fixed');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' INT)';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中兵招投标项目-固定菜单（1-是，other-否）''';
  end if; 
  
  tmp1:=upper('BS_QXSZ');
  tmp2:=upper('qxrole');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
	  execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(30))';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''权限角色菜单-中兵招投标项目使用，用于菜单分组''';
  end if;   
  	     
   -- 修改BS_CHECKGROUP表中GROUPNAME字段的长度
   -- 增加 GROUPNAME_TMP
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME_TMP');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(60))';
	end if;
    -- 赋值 GROUPNAME_TMP
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME_TMP');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set GROUPNAME_TMP = GROUPNAME';
	end if;
    -- 清空 GROUPNAME
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set GROUPNAME=null';
	end if;
    -- 修改 GROUPNAME
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(60))';
	end if;
    -- 赋值 GROUPNAME
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set GROUPNAME = GROUPNAME_TMP';
	end if;
    -- 删除 GROUPNAME_TMP
	tmp1:=upper('BS_CHECKGROUP');
	tmp2:=upper('GROUPNAME_TMP');
	num:=0; 
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	
	--手机端登录标识
  tmp1:=upper('Bs_Loginsession');
  tmp2:=upper('ismobile');
  num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(3))';
    execute immediate 'comment on column Bs_Loginsession.ismobile is ''手机端登录标识  1-手机端 （0ornull）pc ''';
  end if; 
	
	
  -------------------------------------------------------------
end;
