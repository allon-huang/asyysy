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
    tmp1:=upper('bd_package');
    tmp2:=upper('zbAmt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,2))';
     execute immediate 'comment on column BD_PACKAGE.zbAmt is ''中标价格''';
    end if;
  
   tmp1:=upper('bd_subproject');
    tmp2:=upper('fbDate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE )';
     execute immediate 'comment on column BD_SUBPROJECT.fbDate is ''公告发布时间''';
    end if;

  tmp1:=upper('bd_fb_tb_file');
  tmp2:=upper('wjhm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(26))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件编号''';
  end if;
  
  tmp1:=upper('bd_zb_file');
  tmp2:=upper('wjhm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(26))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件编号''';
  end if; 
	
	
	tmp1:=upper('BD_PACKAGE');
  	tmp2:=upper('RETURNTZYJ');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(2))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否退还图纸押金 0 or null 否 1-是''';
  	end if; 
  	
  	tmp1:=upper('BD_PAY_REQUEST');
  	tmp2:=upper('SDATE');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' DATE)';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''成功时间''';
  	end if; 
  	
  	-----------------by  songw  2016年10月14日 11:52:21 start------------------
    --万元金额小数掉后的长度没有问题 hejw
	--修改万元金额的类型为number
    --tmp1:=upper('BD_TD_DD');
	--tmp2:=upper('WYMONEY');
	--num:=0; -- 注意：查询前必须初始化此变量
    --select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	--if num = 1 then
	--   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(20,2))';
	--end if;
  	-----------------by  wangch   end------------------

	----------add by songw 2016年11月10日   start-----------------
	--调整货物类合同明细技术标准
    tmp1:=upper('bd_contract_mx');
	tmp2:=upper('JSBZH');
	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(125))';
	end if;
	----------add by songw 2016年11月10日  end-----------------

    ----add by wangch start 2016-10-16  ----
    --修改资质的长度
    tmp1:=upper('bd_tbyqsbz');
    tmp2:=upper('quation');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(2000))';
	end if;
	
  	-------------------by  wangch   end------------------
    ----add by wangch start 2016-10-19  ----
    --修改专家代码的长度
    tmp1:=upper('bd_expert');
    tmp2:=upper('zjmc');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(50))';
	end if;

  	-----------------by  wangch   end------------------
 ----add by wangch start 2016-10-19  ----
    --添加专家编号字段
    tmp1:=upper('bd_expert');
    tmp2:=upper('zjbh');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(18))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家编号，编码长度为18''';
	end if;

  	-----------------by  wangch   end------------------
  
   ----add by wangch start 2016-10-19  ----
    --添加工程建设地点字段
    tmp1:=upper('Bd_Zbgg');
    tmp2:=upper('jsdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
	end if;
	
	--添加计划工期字段
    tmp1:=upper('Bd_Zbgg');
    tmp2:=upper('jhgq');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''计划工期''';
	end if;

  	-----------------by  wangch   end------------------
  
  
   ----add by wangch start 2016-11-15  ----
    --添加专家编号字段
    tmp1:=upper('Bd_Notice');
    tmp2:=upper('xtgg');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''系统公告''';
	end if;

  	-----------------by  wangch   end------------------

   ----add by wangch start 2016-11-16  ----
    --添加专家编号字段
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('bgcqgg');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更（澄清）公告所有内容''';
	end if;

  	-----------------by  wangch   end------------------

 ----add by wangch start 2016-11-16  ----
    --添加专家编号字段
    tmp1:=upper('bd_ccnotice');
    tmp2:=upper('bgcqgg');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''变更（澄清）公告所有内容''';
	end if;

  	-----------------by  wangch   end------------------

 ----add by wangch start 2016-12-15  ----
    --添加专家编号字段
    tmp1:=upper('BD_FB_ZBCSSZ');
    tmp2:=upper('tbbzjpercent_Min');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(5))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金支付比例上限''';
	end if;

  	-----------------by  wangch   end------------------
----add by wangch start 2016-12-26  ----
    --修改邀请书 其他要求的长度
    tmp1:=upper('Bd_Tbyqsbz');
    tmp2:=upper('preult');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(2000))';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''其他要求''';
	end if;

  	-----------------by  wangch   end------------------
	
	----------------- 2016-12-14 zhangzq 澄清/变更公告增加判断是否已读的标记 start--------------------
	tmp1:=upper('BD_CCNOTICE');
	tmp2:=upper('isread');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已读 1已读 0orNull未读''';
	end if;
    ----------------- 2016-12-14 zhangzq 澄清/变更公告增加判断是否已读的标记 end--------------------

  	----------------- 2016-12-19 zhangzq 修改isread的类型 start------------------
    tmp1:=upper('BD_CCNOTICE');
	tmp2:=upper('isread');
	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(500))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已读标记，存入已读的会员代码''';
	end if;
  	----------------- 2016-12-19 zhangzq 修改isread的类型 end------------------
	
   ----add by wangch start 2016-11-29  ----
    --添加计划工期字段
    tmp1:=upper('Bd_Tbyqsbz');
    tmp2:=upper('jhgq');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''计划工期''';
	end if;
	
	--添加工程建设地点字段
    tmp1:=upper('Bd_Tbyqsbz');
    tmp2:=upper('jsdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 0 then
	     execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''工程建设地点''';
	end if;
	
  	-----------------by  wangch   end------------------


	----add  by  songw  2016年10月19日  start --------------
	--增加合同表bd_contract的合同编号字段
  	tmp1:=upper('bd_contract');
  	tmp2:=upper('HTBH');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(20))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''按一定规则生成的用于标识合同的编号，一般写在合同的封面''';
  	end if; 


	----add  by  songw  2016年10月19日  end --------------

	-----add by songw 2016年10月27日 start---------------------
	--增加招标公告bd_zbgg的图纸类别字段
  	tmp1:=upper('bd_zbgg');
  	tmp2:=upper('TZFL');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(5))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''图纸分类 1-纸质版   2-电子版  0-无''';
  	end if; 
  	
  	--增加招标公告图纸领取地址字段
  	tmp1:=upper('bd_zbgg');
  	tmp2:=upper('TZLQDZ');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(200))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''图纸领取地址''';
  	end if;
	-----add by songw 2016年10月27日 end---------------------

	---add  by  songw 2016年11月9日   start-----------------
  	--增加委托协议支付方式按照暂行管理办法
  	tmp1:=upper('bd_subproject_ext');
  	tmp2:=upper('ZFGLBF');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(10))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''按招标代理业务收费管理暂行办法计价格的百分比收费''';
  	end if;	
	---add  by  songw 2016年11月9日   end-----------------

	--------add by songw 2016年10月31日  start------------------------
	--增加图纸类别字段
  	tmp1:=upper('bd_tbyqsbz');
  	tmp2:=upper('TZFL');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(5))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''图纸分类 1-纸质版   2-电子版  0-无''';
  	end if; 
  	
  	--增加图纸领取地址字段
  	tmp1:=upper('bd_tbyqsbz');
  	tmp2:=upper('TZLQDZ');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(200))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''图纸领取地址''';
  	end if;	
  	
  	--增加图纸押金字段
  	tmp1:=upper('bd_tbyqsbz');
  	tmp2:=upper('TZYJ');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(30))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''图纸押金''';
  	end if;	
	--------add by songw 2016年10月31日  end------------------------

	----------add by songw 2016年11月16日 start-----------------------
	--增加预审或招标公告页面内容字段
	tmp1:=upper('bd_zbgg');
	tmp2:=upper('ggnr');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审或招标公告页面内容''';
	end if;	
	
	--增加中标结果公告内容字段
	tmp1:=upper('bd_db_zbjggg');
	tmp2:=upper('ggnr');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	  execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
	  execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标结果公告页面内容''';
	end if;	
	----------add by songw 2016年11月16日 end-----------------------

	--------modify by songw 2016年11月18日 start------------------
	  tmp1:=upper('bd_fjjbxx');
	  tmp2:=upper('GUID');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify  ('||tmp2||' VARCHAR2(60))';
	  end if;	
	--------modify by songw 2016年11月18日 end------------------


    ----add by huyq start 2016-10-14  ----
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('wjjmksdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件解密开始时间''';
    end if;
    
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('wjjmjsdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件解密结束时间''';
    end if;
    
    ----add by huyq end   2016-10-14  ----

  tmp1:=upper('bd_subproject_ext');
  tmp2:=upper('qualificode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(6))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标代理资格分类代码''';
  end if;
  
  tmp1:=upper('bd_subproject_ext');
  tmp2:=upper('gradecode');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(2))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标代理资格分级代码''';
  end if;  

  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('kbfs');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标方式(默认在线开标)''';
  end if; 
  
  tmp1:=upper('BD_JURY');
  tmp2:=upper('GUID');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''GUID全球唯一标识符''';
  end if; 
  
  tmp1:=upper('BD_JURY');
  tmp2:=upper('ORIGIN');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' INT)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家来源 1平台库 2公共库''';
  end if; 

  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 and DATA_PRECISION IS NULL;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(2,0))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标有效期天数''';
  end if; 	  
  
  -----hanglong 2016-10-15 标段包添加代理服务费相关字段------
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('ISAGENTAMT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' INT)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否交了代理服务费(1-支付过了，0或者null-未支付)''';
  end if; 
  
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('ISDLFWF');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' INT)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否需要在退保证金时同时扣除代理服务费（1-需要扣除，0或者null-不需要扣除）''';
  end if; 
  
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('DLFWF');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(20,2))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''支付的代理服务费''';
  end if;
  
  -----jinyanhui 2016-10-15 投标文件表新增上传排序字段------
  tmp1:=upper('Bd_Fb_Tb_File');
  tmp2:=upper('XH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(5,0))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''上传投标文件排序''';
  end if;  
   ----- end  jinyanhui 2016-10-15 投标文件表新增上传排序字段------

  -----jinyanhui 2016-10-15 中标结果表新增交易平台验证责任人字段------
  tmp1:=upper('BD_HGZJTZS');
  tmp2:=upper('PTZRRNAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交易平台验证责任人''';
  end if;  
   ----- end  jinyanhui 2016-10-15 中标结果表新增交易平台验证责任人字段------

  -----jinyanhui 2016-10-15 候选人公示表新增公示类型字段------
  tmp1:=upper('BD_DB_HXRGS');
  tmp2:=upper('TYP');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(1))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''公示类型1 正常 2 更正 9 其他''';
  end if;  
   ----- end  jinyanhui 2016-10-15 候选人公示表新增交易平台验证责任人字段------
   
  -----jinyanhui 2016-10-15 候选人公示表新增交易平台验证责任人字段------
  tmp1:=upper('BD_DB_HXRGS');
  tmp2:=upper('CONTENT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''候选人公示内容''';
  end if;  
   ----- end  jinyanhui 2016-10-15 候选人公示表新增候选人公示内容字段------   

  -----jinyanhui 2016-10-15 结果通知书表新增文件编号字段------
  tmp1:=upper('BD_HGZJTZS');
  tmp2:=upper('WJHM');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件编号''';
  end if;  
   ----- end  jinyanhui 2016-10-15 结果通知书表新增文件编号字段------   

  -----jinyanhui 2016-10-16 标段包表新增评标报告内容字段------
  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('CONTENT1');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审评审报告内容''';
  end if;  

  tmp1:=upper('BD_PACKAGE');
  tmp2:=upper('CONTENT2');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告内容''';
  end if;  
   ----- end  jinyanhui 2016-10-16 标段包表新增评标报告内容字段------   

  -----jinyanhui 2016-10-16 标段包表新增字段------
  tmp1:=upper('BD_DB_HXRGS');
  tmp2:=upper('XH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(10,0))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人排名''';
  end if;  

  tmp1:=upper('BD_DB_HXRGS');
  tmp2:=upper('CONTENTS');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告内容''';
  end if;  
   ----- end  jinyanhui 2016-10-16 标段包表新增字段------   

  -----jinyanhui 2016-10-16 合同表新增字段------
  tmp1:=upper('BD_CONTRACT');
  tmp2:=upper('CONTENT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同内容''';
  end if; 
  
  -----jinyanhui 2016-10-16 通知书文本字段------
  tmp1:=upper('BD_TBYQSBZ');
  tmp2:=upper('CONTENT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''通知书文本''';
  end if;  
  
  --add by chenxp start--
  tmp1:=upper('bd_cc_receipt');
  tmp2:=upper('timemd5');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''时间戳，用于防止同步修改冲突''';
  end if;
  --add by chenxp end  --

  --add by cheny start--
  tmp1:=upper('BD_MB_PBMB_TK_MX');
  tmp2:=upper('TKBZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify  ('||tmp2||' VARCHAR2(500))';
  end if;
  --add by cheny end  --
  
  --add by jinyanhui start--
  tmp1:=upper('bd_dissent');
  tmp2:=upper('wjhm');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(26) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件编号''';
  end if;
  
  tmp1:=upper('bd_tb_signup');
  tmp2:=upper('price');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20，2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标报价''';
  end if;  
  
  tmp1:=upper('BD_JURY');
  tmp2:=upper('ORINAME');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(500))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家库来源''';
  end if;   
  
	--修改万元金额的类型为number
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('pbprice');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(20,2))';
	end if; 
	
  tmp1:=upper('BD_CONTRACT_ITEM');
  tmp2:=upper('AMTBZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(3))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''金额币种代码''';
  end if; 
  
  tmp1:=upper('BD_CONTRACT_ITEM');
  tmp2:=upper('AMTDW');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(1))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''金额币种单位 1元 2 万元''';
  end if; 
    	 
  --add by jinyanhui end  --  

  ------------------cheny 2016/10/19 --start-----------------------------
  tmp1:=upper('BD_MB_PBMB_TK_MX_BAK');
  tmp2:=upper('TKBZ');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify  ('||tmp2||' VARCHAR2(500))';
  end if;
  
  tmp1:=upper('bd_ws_task');
  tmp2:=upper('operTyp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' number)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''此次交易数据操作类型:1-新增,2-修改,3-删除''';
  end if;
  
  	 -- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_PBBG_ZSJG');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_PBBG_ZSJG  (
		   PKID                 INT  not null,
		   BDID                 varchar2(23),
		   TYP               	varchar2(1),
		   CONTENT				CLOB,
		   GUID					varchar2(50),
		   CDATE				DATE,
		   OPTS					CLOB,
		   PTYZOPT				varchar2(50),
		   constraint PK_BD_PBBG_ZSJG primary key (PKID)
	)
		';
	-- 注释	
		execute immediate 'comment on table BD_PBBG_ZSJG is ''--评标报告、资审结果表'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.PKID is ''主键'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.BDID is ''标段包编号'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.TYP is ''1 资审结果，2评审报告'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.CONTENT is ''评标报告正文'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.GUID is ''附件关联标识符'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.CDATE is ''提交时间'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.OPTS is ''资审通过人名单'' ';
		execute immediate 'comment on column BD_PBBG_ZSJG.PTYZOPT is ''平台验证人'' ';
		
	end if; 

	num:=0; 
	    tmp1:=upper('BD_PBBG_ZSJG_0');
	    select count(1) into num from user_sequences where sequence_name=tmp1;
	    if num = 0 then
	      execute immediate 'create sequence BD_PBBG_ZSJG_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
		  ';  
  end if; 
  ------------------cheny 2016/10/19 --end-----------------------------
 ------------------wangch 2016/10/19 --start-----------------------------
 	 -- 判断平台基本信息表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_PTJBXX');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_PTJBXX  (
		   PKID                 INT  not null,
		   PTDM                 varchar2(11),
		   PTLX               	varchar2(1),
		   PTMC                 varchar2(100),
		   YYJGDM               varchar2(18),
		   YYJGMC               varchar2(100),
		   ZSBH				    varchar2(50),
		   FWDZ					varchar2(200),
		   constraint PK_BD_PTJBXX primary key (PKID)
	)
		';
	-- 注释	
		execute immediate 'comment on table BD_PTJBXX is ''--平台基本信息表'' ';
		execute immediate 'comment on column BD_PTJBXX.PKID is ''主键'' ';
		execute immediate 'comment on column BD_PTJBXX.PTDM is ''平台代码'' ';
		execute immediate 'comment on column BD_PTJBXX.PTLX is ''平台类型(《电子招投标系统技术规范第1部分》附录B.3.24 平台类型代码)'' ';
		execute immediate 'comment on column BD_PTJBXX.PTMC is ''平台名称'' ';
		execute immediate 'comment on column BD_PTJBXX.YYJGDM is ''运营机构代码（采用GB11714-1997中的代码编制规则）'' ';
		execute immediate 'comment on column BD_PTJBXX.YYJGMC is ''运营机构名称'' ';
		execute immediate 'comment on column BD_PTJBXX.ZSBH is ''CA证书编号'' ';
		execute immediate 'comment on column BD_PTJBXX.FWDZ is ''系统访问地址'' ';
		
	end if; 

	num:=0; 
	    tmp1:=upper('BD_PTJBXX_0');
	    select count(1) into num from user_sequences where sequence_name=tmp1;
	    if num = 0 then
	      execute immediate 'create sequence BD_PTJBXX_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
		  ';  
  end if; 
  ------------------wangch 2016/10/19 --end-----------------------------


  --add by machuanhai 2016/10/19 start--
	--为bd_package_ext表增加"开标参与人"列
	tmp1:=upper('bd_package_ext');
  	tmp2:=upper('kbcyr');
  	num:=0; -- 注意：查询前必须初始化此变量
 	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
 	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标参与人''';
  	end if;
  	
  	--为bd_package_ext表增加"开标记录内容"列
	tmp1:=upper('bd_package_ext');
  	tmp2:=upper('kbjlcontent');
  	num:=0; -- 注意：查询前必须初始化此变量
 	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
 	if num = 0 then
	   execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
	   execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''开标记录内容''';
  	end if;
  --add by machuanhai end--

-- 增加 fjnum_tmp
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(3,0))';
  end if;
  -- 赋值 fjnum_tmp
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set fjnum_tmp = fjnum';
  end if;
  -- 清空 fjnum
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set fjnum=null';
  end if;
  -- 修改 fjnum
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(3,0))';
  end if;  
  -- 赋值 fjnum
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set fjnum = fjnum_tmp';
  end if;
  -- 删除 fjnum_tmp
  tmp1:=upper('BD_FJJBXX');
  tmp2:=upper('fjnum_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
  end if;  
  ------------修改有数据字段长度结束----------------------------------------------------

	-- bd_zbgg 增加 平台验证标识 字段
	tmp1:=upper('bd_zbgg');
	tmp2:=upper('isverify');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' INTEGER null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''平台验证标识 0 or null-未验证 1-已验证''';
	end if;
	
  tmp1:=upper('BD_TBYQSBZ');
  tmp2:=upper('INVITEUNIT');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' modify  ('||tmp2||' VARCHAR2(2000))';
  end if;

  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('xmjl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 and DATA_LENGTH <> 50;
  if num = 1 then
    execute immediate 'alter table '||tmp1||' drop column '||tmp2||' ';
  end if;
  
  tmp1:=upper('bd_offer_mx');
  tmp2:=upper('xmjl');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''项目经理''';
  end if; 
 
  tmp1:=upper('bd_jury');
  tmp2:=upper('zjsqbh');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(32))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''组建申请编号''';
  end if;  
  
  tmp1:=upper('bd_contract_item');
  tmp2:=upper('djdate');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||' DATE)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同履约递交时间''';
  end if; 
  
   	 -- 判断奖惩信息表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_REWARD');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		-- 建表
		execute immediate '
		create table BD_REWARD  (
		   PKID                 INT  not null,
		   HYDM                 varchar2(30),
		   SJQX				    varchar2(100),
		   CONTENT				clob,
		   CDATE				DATE,
		   COPT					varchar2(100),
		   constraint PK_BD_REWARD primary key (PKID)
	)
		';
	-- 注释	
		execute immediate 'comment on table BD_REWARD is ''--奖惩信息表'' ';
		execute immediate 'comment on column BD_REWARD.PKID is ''主键'' ';
		execute immediate 'comment on column BD_REWARD.HYDM is ''奖惩会员代码'' ';
		execute immediate 'comment on column BD_REWARD.SJQX is ''奖惩期限'' ';
		execute immediate 'comment on column BD_REWARD.CONTENT is ''奖惩内容'' ';
		execute immediate 'comment on column BD_REWARD.CDATE is ''登记时间'' ';
		execute immediate 'comment on column BD_REWARD.COPT is ''登记人'' ';
		
	end if; 

	num:=0; 
	    tmp1:=upper('BD_REWARD_0');
	    select count(1) into num from user_sequences where sequence_name=tmp1;
	    if num = 0 then
	      execute immediate 'create sequence BD_REWARD_0 
		  minvalue 1
		  maxvalue 9999999999999999999999999999
		  start with 1
		  increment by 1
		  nocache
		  order
		  ';  
  end if; 
  -------cheny--报名信息表-start---------------------------
  tmp1:=upper('BD_TB_SIGNUP');
  tmp2:=upper('viewStatus');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||'  number)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标结果查看状态1-已读，0 or null-为未读''';
  end if; 
  -------cheny--报名信息表-end---------------------------
  -------cheny--招标文件参数设置-start---------------------------
  tmp1:=upper('BD_FB_ZBCSSZ');
  tmp2:=upper('tbbzjpercentMax');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||'  VARCHAR2(5))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标保证金上限''';
  end if; 
  -------cheny--招标文件参数设置-end---------------------------

  ----add by huyq start 2016-10-28  ----
  --修改评标模板条款明细的条款标准的长度
    tmp1:=upper('bd_mb_pbmb_tk_mx');
    tmp2:=upper('tkbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(2000))';
	end if;
	
	tmp1:=upper('bd_mb_pbmb_tk_mx_bak');
    tmp2:=upper('tkbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2 ;
	if num = 1 then
	    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(2000))';
	end if;
    
  ----add  by  huyq  2016年10月28日  end --------------

  ----add  by  huyq  2016年10月29日  start --------------
  --增加评标委员会评标耗时单位字段
  	tmp1:=upper('bd_jury');
  	tmp2:=upper('timesdw');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(10,1))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标耗时单位：0 or null-天，1-小时''';
  	end if;
  ----add  by  huyq  2016年10月29日  end --------------

  tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('REASON');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||'  CLOB)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标选择非第一名时理由''';
  end if;
  
  tmp1:=upper('BD_PACKAGE_EXT');
  tmp2:=upper('REASONPATH');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add ('||tmp2||'  VARCHAR2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标选择非第一名时附件''';
  end if; 
  
  tmp1:=upper('bd_cc_receipt');
  tmp2:=upper('hztyp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''回执类型 1-澄清 2-变更''';
  end if;
  
  tmp1:=upper('Bd_Jury_Sign');
  tmp2:=upper('cardnum');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''监标人证件号码''';
  end if;
  
  ---------------------------------------------------------------------------------------
  ----add  by  Mach  2016年11月04日  start --------------
  --增加招标项目招标人招标编号
  	tmp1:=upper('bd_subproject');
  	tmp2:=upper('zbrzbdm');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
    	execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(30))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人招标编号''';
  	end if;
  ----add  by  Mach  2016年11月04日  end --------------

	--add by chenxp start --
	tmp1:=upper('bd_tb_signup');
	tmp2:=upper('flag05');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''签章前确认预审通过通知书 0-确认不参加 1-确认参加''';
	end if;
	
	tmp1:=upper('bd_tb_signup');
  	tmp2:=upper('res');
  	num:=0; -- 注意：查询前必须初始化此变量
  	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  	if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2000) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审通过通知书不参加原因''';
  	end if;
	
	--add by chenxp end   --
	
	--add by chenxp start --
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('kpflag');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(2) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否开票0-否,1-是''';
	  end if;
	  
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('fptype');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(3) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发票类型 1-增值税普通发票''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('dwmc');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(250) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''单位名称''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('nsrsbh');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''纳税人识别号''';
	  end if;
	  
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('fpjsr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(250) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发票接收联系人''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('jsrtel');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(20) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发票接收联系人联系方式''';
	  end if;
	  
	  tmp1:=upper('bd_td_dd');
	  tmp2:=upper('jsraddr');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''发票接收联系人地址''';
	  end if;
	
	--add by chenxp end   --

	--add by hejunwei start   --
	  tmp1:=upper('BD_JURY');
	  tmp2:=upper('autoerror');
	  num:=0; -- 注意：查询前必须初始化此变量
	  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	  if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(400) null)';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''自动抽取不符合条件错误信息''';
	  end if;
	--add by hejunwei end   --

    ---------add by songw 2016年11月19日 start--------------
    tmp1:=upper('bd_tbyqsbz');
    tmp2:=upper('QTMJ');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
       execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(400))';
    end if;

    ---------add by songw 2016年11月19日 end--------------

--add by hejunwei start   --

-- 增加 tknr_tmp
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
	end if;
-- 赋值 tknr_tmp
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set qtmj_tmp = qtmj';
	end if;
-- 清空 tknr
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set qtmj=null';
	end if;
-- 修改 qtmj
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(800))';
	end if;
-- 赋值 qtmj
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set qtmj = qtmj_tmp';
	end if;
-- 删除 qtmj_tmp
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('qtmj_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
------------修改有数据字段长度结束----------------------------------------------------
	tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('SAMPLE_TIME');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' number)';
    end if;
    
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('PKREQUIRE');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' number)';
    end if;
    
    tmp1:=upper('BD_VALUE');
    tmp2:=upper('csflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''0ornull-禁止清除  1-清除   2-上线清除''';
    end if;
    
    tmp1:=upper('BD_JURY');
    tmp2:=upper('rsnum2');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''当前轮次，专家可指定数量''';
    end if;
	--add by hejunwei end   --


    --add by chenxp start --
    tmp1:=upper('bd_package');
    tmp2:=upper('cjkbjlsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成开标记录时间''';
    end if;
  
    tmp1:=upper('bd_package');
    tmp2:=upper('yskqjlcjsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审开启记录创建时间''';
    end if;
    --add by chenxp end   --

    --add by hejw start   --
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('startRecord');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''起始记录号，用于中信同步打印''';
    end if;
    --add by hejw end   --
   
    tmp1:=upper('bd_package');
    tmp2:=upper('pbqtsm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标报告其它说明''';
    end if;
    
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('ysyqdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''收到预审投标邀请书时间''';
    end if;   
    
    --add by chenxp start--
    tmp1:=upper('bd_tb_signup');
    tmp2:=upper('SEALDATA05');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人代资格审核通过通知书确认签章uuid''';
    end if;
  
    tmp1:=upper('bd_subproject');
    tmp2:=upper('sealdata01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方发送委托邀请签名UUID''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('yswjzt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''预审文件状态 0 or null-未上传 1-已发布 2-已上传 3-已发送待招标人审核 4-招标人审核通过(已签章) 5-招标人审核未通过  6-招标人已同意待签章''';
    end if;
  
    tmp1:=upper('bd_package');
    tmp2:=upper('zbwjzt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件状态 0 or null-未上传 1-已上传 2-已发送待招标人审核 3-招标人审核通过(已签章) 4-已发布 5-招标人审核未通过  6-招标人已同意待签章   ''';
    end if;
    
    tmp1:=upper('bd_contract');
    tmp2:=upper('SEALPATH01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
         execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同提交签名UUID''';
    end if;
  
    tmp1:=upper('bd_contract');
    tmp2:=upper('SEALPATH02');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''合同确认签名UUID''';
    end if;
    --add by chenxp end  --
    
	------add  by songw 2016年11月30日16:37:01  start--------------
	--增加标段（包）标的物交货地点字段
    tmp1:=upper('bd_package_item');
    tmp2:=upper('jhdd');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货地点''';
    end if;
    
	--增加标段（包）标的物交货期字段
    tmp1:=upper('bd_package_item');
    tmp2:=upper('jhq');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''交货期''';
    end if;
	------add  by songw 2016年11月30日16:37:01  end--------------

 
	--新增中金支付银行列表表---BY。zhminfu
	num :=0;
    tmp1:=upper('BD_BK_BANK');
    select count(1) into num from user_tables where table_name=tmp1;
    if num =0 then
	    execute immediate 'create table BD_BK_BANK  (
		   PKID                 NUMBER                          not null,
		   BKNAME               VARCHAR2(100),
		   BKCODE               VARCHAR2(32),
		   BKLOGO               VARCHAR2(32),
		   BKTYPE               INT,
		   ORDERNO              INT,
		   STATUS               INT,
		   constraint PK_BD_BK_BANK primary key (PKID)
		)';
	    execute immediate 'comment on column BD_BK_BANK.PKID is ''PKID主键'''; 
		execute immediate 'comment on column BD_BK_BANK.BKNAME is ''银行名称'''; 
		execute immediate 'comment on column BD_BK_BANK.BKCODE is ''银行编号'''; 
		execute immediate 'comment on column BD_BK_BANK.BKLOGO is ''银行LOGO图片'''; 
		execute immediate 'comment on column BD_BK_BANK.BKTYPE is ''1个人在线支付  2企业在线支付'''; 
		execute immediate 'comment on column BD_BK_BANK.ORDERNO is ''排序'''; 
		execute immediate 'comment on column BD_BK_BANK.STATUS is ''1使用0OrNull停用'''; 
   end if;
   
   num:=0; 
    tmp1:=upper('BD_BK_BANK_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
		execute immediate '
			create sequence BD_BK_BANK_0
			minvalue 1
		    maxvalue 9999999999999999999999999999
		    start with 1
		    increment by 1
		    nocache
		    order
	    ';
    end if;
    
    ------add  by chenyi 2016-12-06 增加客户端更新表 start ---------
     -- 判断表是否存在
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_SOFTWARE');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        -- 建表
        execute immediate '
        create table BD_SOFTWARE  (
           PKID                 NUMBER  not null,
           TYPE                 NUMBER,
           NAME                 VARCHAR2(100),
           VERSIONNO            VARCHAR2(20),
           VERSION              NUMBER,
           UP_DATE                 DATE,
           USERID               DATE,
           DESCRIPTION                 VARCHAR2(200),
           BAK1                 VARCHAR2(20),
           BAK2                 VARCHAR2(20),
           BAK3                 VARCHAR2(20),
           constraint PK_BD_SOFTWARE primary key (PKID)
        )
        ';
    -- 注释   
        execute immediate 'comment on table BD_SOFTWARE is ''客户端软件更新表'' ';
        execute immediate 'comment on column BD_SOFTWARE.PKID is ''主键'' ';
        execute immediate 'comment on column BD_SOFTWARE.TYPE is ''程序安装包名称'' ';
        execute immediate 'comment on column BD_SOFTWARE.NAME is ''1 资审结果，2评审报告'' ';
        execute immediate 'comment on column BD_SOFTWARE.VERSIONNO is ''版本号（例：0.0.1）'' ';
        execute immediate 'comment on column BD_SOFTWARE.VERSION is ''版本（用于更新比较使用，为增长数字）'' ';
        execute immediate 'comment on column BD_SOFTWARE.UP_DATE is ''上传日期'' ';
        execute immediate 'comment on column BD_SOFTWARE.USERID is ''上传用户'' ';
        execute immediate 'comment on column BD_SOFTWARE.DESCRIPTION is ''描述'' ';
        execute immediate 'comment on column BD_SOFTWARE.BAK1 is ''备用字段1'' ';
        execute immediate 'comment on column BD_SOFTWARE.BAK2 is ''备用字段2'' ';
        execute immediate 'comment on column BD_SOFTWARE.BAK3 is ''备用字段3'' ';
        
    end if; 
    ------add  by chenyi 2016-12-06 增加客户端更新表 end -----------

 -------招投标站内信息表---------
    num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_MESSAGE');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        -- 建表
        execute immediate '
            create table BD_MESSAGE  (
               PKID                 INT  not null,
               PROBID                VARCHAR2(40),
               PRONAME               VARCHAR2(200),
               BDID                  VARCHAR2(40),
               BDNAME                VARCHAR2(200),
               MARK                  VARCHAR2(40),
               URL                   VARCHAR2(200),
               MSG                   VARCHAR2(800),
               NODE                  NUMBER,
               FSHYDM                VARCHAR2(20),
               FSUSERID              VARCHAR2(20),
               FSMBNAME              VARCHAR2(200),
               FSDATE                DATE,
               JSHYDM                VARCHAR2(20),
               JSUSERID              VARCHAR2(20),
               JSMBNAME              VARCHAR2(200),
               ISSHOW                VARCHAR2(2),
               constraint PK_BD_MESSAGE primary key (PKID)
        )
        ';
    -- 注释   
        execute immediate 'comment on table BD_MESSAGE is ''招投标站内信'' ';
        execute immediate 'comment on column BD_MESSAGE.PKID is ''主键'' ';
        execute immediate 'comment on column BD_MESSAGE.PROBID is ''招标项目id'' ';
        execute immediate 'comment on column BD_MESSAGE.PRONAME is ''招标项目名称'' ';
        execute immediate 'comment on column BD_MESSAGE.BDID is ''标段包编号'' ';
        execute immediate 'comment on column BD_MESSAGE.BDNAME is ''标段包名称'' ';
        execute immediate 'comment on column BD_MESSAGE.MARK is ''查询标识'' ';
        execute immediate 'comment on column BD_MESSAGE.url is ''跳转链接'' ';
        execute immediate 'comment on column BD_MESSAGE.msg is ''提示消息'' ';
        execute immediate 'comment on column BD_MESSAGE.node is ''业务节点'' ';
        execute immediate 'comment on column BD_MESSAGE.fshydm is ''发送方会员代码'' ';
        execute immediate 'comment on column BD_MESSAGE.fsuserid is ''发送方操作员'' ';
        execute immediate 'comment on column BD_MESSAGE.fsmbname is ''发送方会员名称'' ';
        execute immediate 'comment on column BD_MESSAGE.fsdate is ''发送时间'' ';
        execute immediate 'comment on column BD_MESSAGE.jshydm is ''接受方会员代码'' ';
        execute immediate 'comment on column BD_MESSAGE.jsuserid is ''接受方操作员'' ';
        execute immediate 'comment on column BD_MESSAGE.jsmbname is ''接受方会员名称'' ';
        execute immediate 'comment on column BD_MESSAGE.isshow is ''是否已查看过 1-已查看过'' ';
    end if; 
    

    num:=0; 
        tmp1:=upper('BD_MESSAGE_0');
        select count(1) into num from user_sequences where sequence_name=tmp1;
        if num = 0 then
          execute immediate 'create sequence BD_MESSAGE_0 
          minvalue 1
          maxvalue 9999999999999999999999999999
          start with 1
          increment by 1
          nocache
          order
          ';  
    end if; 
        -------招投标站内信息表---------
 num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_TB_SIGNUP_RECORD');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        -- 建表
        execute immediate '
            create table BD_TB_SIGNUP_RECORD  (
               PKID                 INT  not null,
               bdid                 VARCHAR2(40),
               hydm                 VARCHAR2(10),
               opt001               VARCHAR2(60),
               date001              DATE,
               opt002               VARCHAR2(60),
               date002              DATE,
               constraint PK_BD_TB_SIGNUP_RECORD primary key (PKID)
        )
        ';
    -- 注释   
        execute immediate 'comment on table BD_TB_SIGNUP_RECORD is ''投标方操作记录表'' ';
        execute immediate 'comment on column BD_TB_SIGNUP_RECORD.PKID is ''主键'' ';
        execute immediate 'comment on column BD_TB_SIGNUP_RECORD.BDID is ''标段包编号'' ';
        execute immediate 'comment on column BD_TB_SIGNUP_RECORD.HYDM is ''会员代码'' ';
    end if; 
    

    num:=0; 
        tmp1:=upper('BD_TB_SIGNUP_RECORD_0');
        select count(1) into num from user_sequences where sequence_name=tmp1;
        if num = 0 then
          execute immediate 'create sequence BD_TB_SIGNUP_RECORD_0 
          minvalue 1
          maxvalue 9999999999999999999999999999
          start with 1
          increment by 1
          nocache
          order
          ';  
    end if; 
    
    
       num:=0; -- 注意：查询前必须初始化此变量
    tmp1:=upper('BD_PACKAGE_RECORD');
    select count(1) into num from user_tables where table_name=tmp1;       
    if num = 0 then
        -- 建表
        execute immediate '
            create table BD_PACKAGE_RECORD  (
               PKID                 INT  not null,
               bdid                 VARCHAR2(40),
               hydm                 VARCHAR2(10),
               opt001               VARCHAR2(60),
               date001              DATE,
               opt002               VARCHAR2(60),
               date002              DATE,
               constraint PK_BD_PACKAGE_RECORD primary key (PKID)
        )
        ';
    -- 注释   
        execute immediate 'comment on table BD_PACKAGE_RECORD is ''招标方操作记录表'' ';
        execute immediate 'comment on column BD_PACKAGE_RECORD.PKID is ''主键'' ';
        execute immediate 'comment on column BD_PACKAGE_RECORD.BDID is ''标段包编号'' ';
        execute immediate 'comment on column BD_PACKAGE_RECORD.HYDM is ''会员代码'' ';
    end if; 
    

    num:=0; 
        tmp1:=upper('BD_PACKAGE_RECORD_0');
        select count(1) into num from user_sequences where sequence_name=tmp1;
        if num = 0 then
          execute immediate 'create sequence BD_PACKAGE_RECORD_0 
          minvalue 1
          maxvalue 9999999999999999999999999999
          start with 1
          increment by 1
          nocache
          order
          ';  
    end if; 
    
    -------add by machuanhai 2016年12月7日  start----------------------
    --add 招标人点击开启预审的操作员
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('opt002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人点击开启预审的操作员''';
    end if;
    --add  招标人点击开启预审的时间
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('date002');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人点击开启预审的时间''';
    end if;
      --add 代理机构点击开启预审的操作员
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('opt003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构点击开启预审的操作员''';
    end if;
    --add 代理机构点击开启预审的时间
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('date003');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构点击开启预审的时间''';
    end if;
    -------add by machuanhai 2016年12月7日  end------------------------


    -------add by songw 2016年12月7日  start----------------------
	--add 招标方或代理机构上传招标文件的操作员
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('opt004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方或代理机构上传招标文件的操作员''';
    end if;
    --add 
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('date004');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方或代理机构上传招标文件的时间''';
    end if;
	-------add by songw 2016年12月7日  end------------------------

    -------add by huyq 2016年12月7日  start----------------------
	--add 招标方 签章 代理机构发送的资格预审文件  的操作员
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('opt005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方 签章 代理机构发送的资格预审文件  的操作员''';
    end if;
    --add 
    tmp1:=upper('Bd_Package_Record');
    tmp2:=upper('date005');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标方 签章 代理机构发送的资格预审文件  的时间''';
    end if;
	-------add by huyq 2016年12月7日  end------------------------

   -----------------------------------------------------------------------------------------------
   ---文件上次保存文件原名称字段
   tmp1:=upper('Bd_Project_Item');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   tmp1:=upper('Bd_Subproject_Item');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;  
   
   tmp1:=upper('Bd_Subproject_Ext');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   -----add by huyq ----
   tmp1:=upper('bd_ccnotice');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(100))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   -----end by huyq------
   
   tmp1:=upper('Bd_Package_Item');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   tmp1:=upper('Bd_Zbgg');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   tmp1:=upper('Bd_Dissent');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   tmp1:=upper('Bd_Dissent');
   tmp2:=upper('aoldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(50))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   tmp1:=upper('BD_CC_RECEIPT');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(100))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''文件原名称''';
   end if;
   
   
    
    --add by chenxp start--
    tmp1:=upper('bd_subproject');
    tmp2:=upper('optid1');
    num:=0; -- 注意：查询前必须初始化此变量
     select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(80) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''创建招标项目的操作员id''';
    end if;


    tmp1:=upper('bd_subproject');
    tmp2:=upper('optid1');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        update bd_subproject set optid1 = optid where nvl(optid1, '')='';
    end if;
  
    tmp1:=upper('bd_package_record');
    tmp2:=upper('opt001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构发送资格预审文件给招标人确认的操作员''';
    end if;
  
    tmp1:=upper('bd_package_record');
    tmp2:=upper('date001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构发送资格预审文件给招标人确认的时间''';
    end if;
    --add by chenxp end--
    
    
    --add by chenxp start--
    tmp1:=upper('bd_package_record');
    tmp2:=upper('opt006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构发送招标文件给招标人确认的操作员''';
    end if;
  
    tmp1:=upper('bd_package_record');
    tmp2:=upper('date006');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理机构发送招标文件给招标人确认的时间''';
    end if;
    --add by chenxp end  --

	--------------------add by songw 2016年12月9日  start---------------------------
	----add 增加招标公告是否允许代理商投标
    tmp1:=upper('bd_zbgg');
    tmp2:=upper('isdlstb');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否允许代理商投标  1-是  0-否''';
    end if;
    
	----add 增加招标公告代理商投标要求
    tmp1:=upper('bd_zbgg');
    tmp2:=upper('dlstbyq');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理商投标要求''';
    end if;
    
    ----add 增加投标邀请书代理商要求
    tmp1:=upper('bd_tbyqsbz');
    tmp2:=upper('dlstbyq');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' CLOB)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理商投标要求''';
    end if;
	--------------------add by songw 2016年12月9日  end-----------------------------
    
    --add by chenxp start--
    tmp1:=upper('bd_tb_signup_record');
    tmp2:=upper('opt001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方递交资格预审文件的操作员''';
    end if;
  
    tmp1:=upper('bd_tb_signup_record');
    tmp2:=upper('date001');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方递交资格预审文件的时间''';
    end if;
    --add by chenxp end  --

   --add by hejw start  --
-------------------修改字段长度---------------------------------
-- 增加 kbaddr_tmp
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(1000))';
    end if;
-- 赋值 kbaddr_tmp
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set kbaddr_tmp = kbaddr';
    end if;
-- 清空 kbaddr
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set kbaddr=null';
    end if;
-- 修改 kbaddr
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(400))';
    end if;
-- 赋值 kbaddr
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'update '||tmp1||' set kbaddr = kbaddr_tmp';
    end if;
-- 删除 kbaddr_tmp
    tmp1:=upper('BD_JURY');
    tmp2:=upper('kbaddr_tmp');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;
------------修改有数据字段长度结束----------------------------------------------------
    --add by hejw end  --
    
	--------add by songw 2016年12月13日 start----------------------
	--modify  bd_ws_task 和bd_ws_task_bak的ifphm字段长度设为50
    tmp1:=upper('bd_ws_task');
	tmp2:=upper('IFPHM');
	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(50))';
	end if;	
	
    tmp1:=upper('BD_WS_TASK_BAK');
	tmp2:=upper('IFPHM');
	num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	   execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(50))';
	end if;	

	--------add by songw 2016年12月13日 end----------------------


    tmp1:=upper('Bd_Zbgg');
    tmp2:=upper('autosms');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定时-发送短信  1-预审开启前24小时已发送过短信''';
    end if;
    
	-- bd_objection 增加 3日内未回复的资格预审文件异议提醒标识 字段
	tmp1:=upper('bd_objection');
	tmp2:=upper('isRemindUnReplyZgyswj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''3日内未回复的资格预审文件异议提醒标识 0 or null-未提醒 1-已提醒''';
	end if;
	
	-- bd_objection 增加 3日内未回复的招标文件异议提醒标识 字段
	tmp1:=upper('bd_objection');
	tmp2:=upper('isRemindUnReplyZbwj');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''3日内未回复的招标文件异议提醒标识 0 or null-未提醒 1-已提醒''';
	end if;
	
	-- bd_objection 增加 3日内未回复的中标候选人公示异议提醒标识 字段
	tmp1:=upper('bd_objection');
	tmp2:=upper('isRemindUnReplyHxrgs');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''3日内未回复的中标候选人公示异议提醒标识 0 or null-未提醒 1-已提醒''';
	end if;
	
	-- bd_db_hxrgs 增加 中标候选人公示结束后的第一天提醒标识 字段
	tmp1:=upper('bd_db_hxrgs');
	tmp2:=upper('isRemindCompleted');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示结束后的第一天提醒标识 0 or null-未提醒 1-已提醒''';
	end if;

    --------add by chenyi 2016年12月13日 start--公告增加招标公告网址字段------------------
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('NOTICE_URL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标公告发布网址''';
    end if;
    
    tmp1:=upper('BD_TBYQSBZ');
    -------------投标邀请书增加一个投标邀请书发布网址字段--------------------------------------
    tmp2:=upper('NOTICE_URL');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标邀请书发布网址''';
    end if;
    
    tmp1:=upper('BD_SOFTWARE');
    tmp2:=upper('USERID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
       execute immediate 'alter table '||tmp1||' modify ('||tmp2||' VARCHAR2(50))';
       execute immediate 'comment on column BD_SOFTWARE.TYPE is '''' ';
       execute immediate 'comment on column BD_SOFTWARE.TYPE is ''软件类型1-招标客户端，2-投标客户端'' ';
       execute immediate 'comment on column BD_SOFTWARE.NAME is '''' ';
       execute immediate 'comment on column BD_SOFTWARE.NAME is ''客户端安装包名称不带后缀'' ';
    end if; 
    --------add by chenyi 2016年12月13日 start--公告和投标邀请书分别增加一个招标公告网址字段--------------------

	----------------- 2016-12-22 zhangzq 标记投标人是否查看邀请书 start--------------------
	tmp1:=upper('BD_TBYQSBZ');
	tmp2:=upper('ISREAD');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500))';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标人是否已读标记，存入已读的会员代码''';
	end if;
    ----------------- 2016-12-22 zhangzq 标记投标人是否查看邀请书 end--------------------

    --------add by hejw 2016年12月14日 start--调整字段--------------------
---删除字段
    tmp1:=upper('BD_ZBGG');
    tmp2:=upper('AUTOSMS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
    end if;

--增加字段
     tmp1:=upper('BD_ZBGG');
    tmp2:=upper('SMSFLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200))';
    end if; 
    --------add by hejw 2016年12月14日 end--调整字段--------------------

	---------------------add by hanglong 2016-12-14 支付申请添加代理服务费字段 start------------------------
	tmp1:=upper('BD_PAY_REQUEST');
	tmp2:=upper('FYAMT');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
	    execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(20,6))';
	    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''代理服务费（swlx为5时用到）''';
    end if;
    ---------------------add by hanglong 2016-12-14	支付申请添加代理服务费字段 end--------------------------
    ---------------------add by machuanhai 2016年12月14日 添加踏勘现场通知拒绝或确认参加字段  start------------------------
    tmp1:=upper('BD_FB_SURVEY');
    tmp2:=upper('ISPASS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''1：投标人确认勘查现场 ，0或null：投标人拒绝勘查现场''';
    end if;
    ---------------------add by machuanhai 2016年12月14日 添加踏勘现场通知拒绝或确认参加字段 end--------------------------

----hejw---autoflag 长度修改-------
    tmp1:=upper('Bd_Package');
    tmp2:=upper('autoflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 1 then
    execute immediate 'alter table '||tmp1||' modify ('||tmp2||' varchar2(300))';
    end if;
----hejw---autoflag 长度修改-------
---增加字段 hejw start--------------------------
  tmp1:=upper('BD_MESSAGE');
    tmp2:=upper('nodestr');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(20))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''业务节点 str-接收方业务节点''';
    end if;
    
    tmp1:=upper('BD_MESSAGE');
    tmp2:=upper('showopt');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(60))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''查看操作员''';
    end if;

    tmp1:=upper('BD_MESSAGE');
    tmp2:=upper('showdate');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''查看时间''';
    end if;
---增加字段 hejw end--------------------------



    
    --add by chenxp start--
    tmp1:=upper('bd_hgzjtzs');
    tmp2:=upper('autosms');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' varchar2(200) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定时任务发送短信标识10-合同签订提醒已发送''';
    end if;
    --add by chenxp end  --
	
	-- bd_package 增加 3日内未进行中标候选人公示提醒标识 字段
	tmp1:=upper('bd_package');
	tmp2:=upper('isRemindUnScaling');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' Integer null)';
		execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''3日内未进行中标候选人公示提醒标识 0 or null-未提醒 1-已提醒''';
	end if;

    ----add by hejw start-----
    tmp1:=upper('BD_JURY_REQUIRE');
    tmp2:=upper('CURRENTRS');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
     execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
     execute immediate 'comment on column BD_SUBPROJECT.fbDate is ''当前轮次 此条件 抽取和指定过的人数''';
    end if;
    ----add by hejw end-----
	
	------接口对接报文记录表---BY.zhminfu------------------------------------
  	num:=0; -- 注意：查询前必须初始化此变量
  	tmp1:=upper('BD_INTERFACE_LOG');
  	select count(1) into num from user_tables where table_name=tmp1;       
  	if num = 0 then
	    execute immediate 'create table BD_INTERFACE_LOG(
	       	PKID                 NUMBER         not null,
			RQ                   DATE,
			PTYP                 INT,
			FPHM                 VARCHAR2(100),
			REMARK               VARCHAR2(200),
			MESSAGE              CLOB,
			constraint PK_BD_INTERFACE_LOG primary key (PKID)
	     )';
	     execute immediate 'comment on table BD_INTERFACE_LOG is ''接口对接报文记录表''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.PKID is ''主键自增长''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.RQ is ''日期''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.PTYP is ''接口类型: 内详1 公告服务平台数据同步2 公告服务平台文件上传3 中金在线支付''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.FPHM is ''相关单号''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.REMARK is ''接口描述''';
	     execute immediate 'comment on column BD_INTERFACE_LOG.MESSAGE is ''报文信息''';
     end if;
    -- Create sequence 
    num:=0; 
    tmp1:=upper('BD_INTERFACE_LOG_0');
    select count(1) into num from user_sequences where sequence_name=tmp1;
    if num = 0 then
      	execute immediate 'create sequence BD_INTERFACE_LOG_0
	    minvalue 1
	    maxvalue 9999999999999999999999999999
	    start with 1
	    increment by 1
	    nocache
	    order';
    end if;
   ----------- add by machuanhai 2016122 start ---------------
   --添加投标邀请书附件原名称字段
   tmp1:=upper('BD_TBYQSBZ');
   tmp2:=upper('oldname');
   num:=0; -- 注意：查询前必须初始化此变量
   select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   if num = 0 then
     execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(100))';
     execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标邀请书附件原名称''';
   end if;
   ----------- add by machuanhai 2016122 end ---------------

   --add by chenxp start--
    --异议
    tmp1:=upper('bd_objection');
    tmp2:=upper('filename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(90) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
    end if;
    
    tmp1:=upper('bd_objection');
    tmp2:=upper('filename1');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(90) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''反馈附件名称''';
    end if;
   --add by chenxp end  --

    --add by chenxp start--
    tmp1:=upper('bd_package');
    tmp2:=upper('filename01');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''生成评标报告-附件名称''';
    end if;
    --add by chenxp end--

	--add by huyq start--
    tmp1:=upper('bd_package');
    tmp2:=upper('tkfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''踏勘现场记录附件名称''';
    end if;
    
    tmp1:=upper('bd_db_hxrgs');
    tmp2:=upper('file1name');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示附件名称''';
    end if;
    
    tmp1:=upper('bd_package_ext');
    tmp2:=upper('reasonFilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''定标非第一名时附件名称''';
    end if;
    
    tmp1:=upper('bd_objection');
    tmp2:=upper('isread');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(500) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''已读标记''';
    end if;
    --add by huyq end--

	----------------- 2016-12-26 zhangzq 增加xmlContent字段 start--------------------
	tmp1:=upper('BD_WS_TASK_BAK');
	tmp2:=upper('XMLCONTENT');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
	execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''xml未base64编码的报文内容''';
	end if;
	----------------- 2016-12-26 zhangzq 增加xmlContent字段 end--------------------

	----------------- 2016-12-26 zhangzq start--------------------
	tmp1:=upper('bd_package');
    tmp2:=upper('version');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标人基本信息的版本号''';
    end if;
    
    tmp1:=upper('bd_subproject');
    tmp2:=upper('version');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标代理机构的基本信息的版本号''';
    end if;
    
    tmp1:=upper('BD_TB_SIGNUP');
    tmp2:=upper('version');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''投标方基本信息的版本号''';
    end if;
	----------------- 2016-12-26 zhangzq end--------------------

    -------2016-12-27 hejw 增加 标识字段 start--------------
    tmp1:=upper('BD_JURY');
    tmp2:=upper('autoflag');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
    execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
    execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否已删除过抽取条件 0-未删除  1-删除过''';
    end if;
    -------2016-12-27 hejw 增加 标识字段 end--------------

	-- 修改 wymoney 精度
	tmp1:=upper('bd_td_dd');
	tmp2:=upper('wymoney');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(26,8) )';
	end if;
	
	--add by chenxp start--
    tmp1:=upper('bd_zbstopgg');
    tmp2:=upper('accessoryname');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''附件名称''';
    end if;
    --add by chenxp edn--


	-- 判断表是否存在
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_JURY_CENTER');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
		execute immediate '
		create table BD_JURY_CENTER  (
		   PBCID                VARCHAR2(17)                    not null,
		   PBCNAME              VARCHAR2(100),
		   CDATE                DATE,
		   DQ_CODE1             VARCHAR2(6),
		   DQ_NAME1             VARCHAR2(30),
		   DQ_CODE2             VARCHAR2(6),
		   DQ_NAME2             VARCHAR2(30),
		   DQ_CODE3             VARCHAR2(6),
		   DQ_NAME3             VARCHAR2(30),
		   ADDRESS              VARCHAR2(100),
		   POSTCODE             VARCHAR2(6),
		   CZYDM                VARCHAR2(30),
		   PBSNUM               NUMBER(10),
		   constraint PK_BD_JURY_CENTER primary key (PBCID)
		)
		';
		-- 注释	
		execute immediate 'comment on table BD_JURY_CENTER is ''--评标中心表'' ';
		execute immediate 'comment on column BD_JURY_CENTER.PBCID is ''主键'' ';
		execute immediate 'comment on column BD_JURY_CENTER.PBCNAME is ''评标中心名称'' ';
		execute immediate 'comment on column BD_JURY_CENTER.CDATE is ''创建时间'' ';
		execute immediate 'comment on column BD_JURY_CENTER.DQ_CODE1 is ''省代码'' ';
		execute immediate 'comment on column BD_JURY_CENTER.DQ_NAME1 is ''省'' ';
		execute immediate 'comment on column BD_JURY_CENTER.PBSNUM is ''评标室个数'' ';
	end if; 
	
	tmp1:=upper('bd_jury');
    tmp2:=upper('PBCID');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(17) null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''评标中心编号''';
    end if;
    
    --add by chenxp start--
    --预审文件
    tmp1:=upper('bd_zb_file');
    tmp2:=upper('yswjqrsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''资格预审文件确认时间''';
    end if;
    
    ------------2017/01/09 zhangzq 采招网消息队列表 start--------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CZ_TASK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CZ_TASK  (
		PKID number not null,
		IFPHM varchar2(50),
		ITYPE varchar2(5),
		IDATE date,
		ICOUNT number,
		ISTATUS number,
		ERRORMSG varchar2(500),
	   constraint PK_BD_CZ_TASK primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_CZ_TASK is ''采招网消息队列表''';
	  execute immediate 'comment on column BD_CZ_TASK.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_CZ_TASK.IFPHM is ''表格主键编号''';
	  execute immediate 'comment on column BD_CZ_TASK.ITYPE is ''表格类型''';
	  execute immediate 'comment on column BD_CZ_TASK.IDATE is ''上传日期''';
	  execute immediate 'comment on column BD_CZ_TASK.ICOUNT is ''上传失败次数''';
	  execute immediate 'comment on column BD_CZ_TASK.ISTATUS is ''上传状态（备用）1是成功，0否''';
	  execute immediate 'comment on column BD_CZ_TASK.ERRORMSG is ''错误信息''';
	
	end if;
	
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_CZ_TASK_BAK');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_CZ_TASK_BAK  (
		PKID number not null,
		IFPHM varchar2(50),
		ITYPE varchar2(5),
		IDATE date,
		ICOUNT number,
		ISTATUS number,
		ERRORMSG varchar2(500),
	   constraint PK_BD_CZ_TASK_BAK primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_CZ_TASK_BAK is ''采招网消息队列表备份表''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.IFPHM is ''表格主键编号''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.ITYPE is ''表格类型''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.IDATE is ''上传日期''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.ICOUNT is ''上传失败次数''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.ISTATUS is ''上传状态（备用）1是成功，0否''';
	  execute immediate 'comment on column BD_CZ_TASK_BAK.ERRORMSG is ''错误信息''';
	
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_CZ_TASK_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_CZ_TASK_0
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
	tmp1:=upper('BD_CZ_TASK_BAK_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_CZ_TASK_BAK_0
	minvalue 1
	maxvalue 9999999999999999999999999999
	start with 1
	increment by 1
	nocache
	order
	';
	end if;
    ----------------- 2017/01/09 zhangzq end--------------------

	------------2017/01/11 zhangzq 数据对照表 start--------------
	num:=0; -- 注意：查询前必须初始化此变量
	tmp1:=upper('BD_SJDZ');
	select count(1) into num from user_tables where table_name=tmp1;       
	if num = 0 then
    -- 建表
	execute immediate '
	create table BD_SJDZ  (
		PKID number not null,
		TYP varchar2(50),
		CODE varchar2(10),
		MC varchar2(50),
	   constraint PK_BD_SJDZ primary key (PKID)
	  )';
	  -- 注释
	  execute immediate 'comment on table BD_SJDZ is ''数据对照表''';
	  execute immediate 'comment on column BD_SJDZ.PKID is ''主键自增长''';
	  execute immediate 'comment on column BD_SJDZ.TYP is ''表格类型名称''';
	  execute immediate 'comment on column BD_SJDZ.CODE is ''表格主键编号''';
	  execute immediate 'comment on column BD_SJDZ.MC is ''内容''';
	
	end if;
	-- Create sequence 
	num:=0; 
	tmp1:=upper('BD_SJDZ_0');
	select count(1) into num from user_sequences where sequence_name=tmp1;
	if num = 0 then
	  execute immediate 'create sequence BD_SJDZ_0
	minvalue 1
	maxvalue 9999999999999999999999999999
	start with 1
	increment by 1
	nocache
	order
	';
	end if;
	----------------- 2017/01/11 zhangzq end--------------------

    --招标文件
    tmp1:=upper('bd_fb_tb_file');
    tmp2:=upper('zbwjqrsj');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' DATE null)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标文件确认时间''';
    end if;
    --add by chenxp end----

    ------add by songw 2017年1月12日 start---------------------
    --add 增加专家表字段-来源(origin)
    tmp1:=upper('bd_expert');
    tmp2:=upper('origin');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家来源''';
    end if;
    ------add by songw 2017年1月12日 end---------------------

    ----add by songw 2017年1月13日 start--------------------
    --add增加标段包退还投标保证金、履约保证金、图纸押金的签名数据字段
    tmp1:=upper('bd_package');
    tmp2:=upper('thtbbzjqm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退还投标保证金签名数据''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('thlybzjqm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退还履约保证金签名数据''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('thtzyjqm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''退还图纸押金签名数据''';
    end if;
    
    ----add by songw 2017年1月13日 end----------------------

    --add by chenxp start--
    tmp1:=upper('bd_contract');
    tmp2:=upper('htjsdw');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100) null)';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''建设单位''';
    end if;
    --add by chenxp end  --
	
	----add by huyq 2017.01.16 start----------------
	--1.招标/预审公告浏览次数
   	tmp1:=upper('bd_zbgg');
   	tmp2:=upper('browsenum');
   	num:=0; -- 注意：查询前必须初始化此变量
   	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   	if num = 0 then
     	execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(12,0))';
     	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标/预审公告浏览次数''';
   	end if;
   	
   	--2.中标候选人公示浏览次数
	tmp1:=upper('bd_db_hxrgs');
   	tmp2:=upper('browsenum');
   	num:=0; -- 注意：查询前必须初始化此变量
   	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   	if num = 0 then
     	execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(12,0))';
     	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''中标候选人公示浏览次数''';
   	end if;
   	
   	--3.招标结果公告浏览次数
	tmp1:=upper('bd_db_zbjggg');
   	tmp2:=upper('browsenum');
   	num:=0; -- 注意：查询前必须初始化此变量
   	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   	if num = 0 then
     	execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(12,0))';
     	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''招标结果公告浏览次数''';
   	end if;
   	
   	--4.澄清/变更公告浏览次数
	tmp1:=upper('bd_ccnotice');
   	tmp2:=upper('browsenum');
   	num:=0; -- 注意：查询前必须初始化此变量
   	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   	if num = 0 then
     	execute immediate 'alter table '||tmp1||' add ('||tmp2||' NUMBER(12,0))';
     	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''澄清/变更公告浏览次数''';
   	end if; 	
   	----add by huyq 2017.01.16 end----------------


	------add by zhangzq 2017年1月16日 数据对照表增加项目省代码 start---------------------
    tmp1:=upper('bd_sjdz');
    tmp2:=upper('provincedm');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(6))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''项目省代码''';
    end if;
    
    tmp1:=upper('bd_sjdz');
    tmp2:=upper('hyfl');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''项目行业分类''';
    end if;
    ------add by songw 2017年1月16日 end---------------------

    ----add by hejw 2017-01-18 start-------------------
    tmp1:=upper('BD_JURY_MEMBER');
    tmp2:=upper('SMSFLAG');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''是否回复临时不参加 2-手机回复不参加  3-后台操作不参加''';
    end if;
    ----add by hejw 2017-01-18 end-------------------
    ------add by songw 2017年1月18日 start--------------------
    --add 增加标段包在评审平台终止评标的终止评标原因、终止评标附件、终止评标节点
    tmp1:=upper('bd_package');
    tmp2:=upper('invalidreason');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(1000))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-终止评标原因''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('invalidfile');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(200))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-终止评标附件''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('invalidfilename');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(100))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-终止评标附件名称''';
    end if;
    
    tmp1:=upper('bd_package');
    tmp2:=upper('invalidnode');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(50))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-终止评标节点''';
    end if;
    
    --增加专家终止评标确认状态
    tmp1:=upper('bd_jury_sign');
    tmp2:=upper('isinvalid');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(10))';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家-是否确认终止评标 1-是， 0 or null-否''';
    end if;
    
    --增加专家终止评标确认签名数据
    tmp1:=upper('bd_jury_sign');
    tmp2:=upper('invalidseal');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
      execute immediate 'alter table '||tmp1||' add('||tmp2||' clob)';
      execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''专家确认终止签名数据''';
    end if;
    
    ------add by songw 2017年1月18日 end--------------------


end;