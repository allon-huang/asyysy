DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.00'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BD',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
    IF (NVL(MSG,'-')<>'success') THEN
        RAISE_APPLICATION_ERROR(-20000,MSG);
    END IF;
    -- 获取当前数据用户
    -- SELECT MAX(USERNAME) INTO CURDB FROM USER_USERS; -- BSDB、FDDB、ECDB
    -------------------------------------------------------------
    -- 日期 人员 功能简单说明，不要写COMMIT，统一由模块提交
    -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
    -- 范围的SQL出现。
    -- 模版见：UPGRADE.TEMPLATE.SQL
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- 请注意：不要在本文件中填写对数据库表结构或者存储过程、视图等非数据类操作的脚本
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    ------------------------------------------------------------- 
	
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='币种';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','币种','币种', 1, 10, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='价格单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','价格单位','价格单位', 1, 20, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='证件类型';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','证件类型','证件类型', 1, 30, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='职业资格人员最高学历';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','职业资格人员最高学历','职业资格人员最高学历', 1, 40, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='职业资格人员职称';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','职业资格人员职称','职业资格人员职称', 1, 50, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='职业资格等级';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','职业资格等级','职业资格等级', 1, 60, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='企业资信等级';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','企业资信等级','企业资信等级', 1, 70, 1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_EXPERT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_EXPERT',2);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JURY';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JURY',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JURY_MEMBER';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JURY_MEMBER',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JURY_SIGN';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JURY_SIGN',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JURY_REQUIRE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JURY_REQUIRE',1);
    end if;
    
    --新增数据sys_init
	num:=0;
    select count(1) into num from sys_init where tname='BD_PROJECT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PROJECT',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PROJECT_ITEM';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PROJECT_ITEM',1);
    end if;
      num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT_YQDW';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT_YQDW',1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT_ITEM';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT_ITEM',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT_EXT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT_EXT',1);
    end if;
  
    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT',1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE_ITEM';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE_ITEM',1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE',1);
    end if;
    
	--新增资格预审文件媒介的参数设置
	num:=0;
    select count(1) into num from bd_cssz where cskey='ZZT_ZGYSWJMJ';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('ZZT_ZGYSWJMJ','发布资格预审的媒介','中兵电商平台','系统管理员','发布资格预审的媒介',1,'',2000,'发布资格预审的媒介');
	end if;
	
	num:=0;
	select count(1) into num from bd_value where key='BD_JURY';   
	if num = 0 then
	   insert into bd_value (Gid, Key, Value, Remark, defaultvalue)
	   values('RunTime','BD_JURY','1','0c56250615ac4f00aeb07e82c35ca249','160523');
	end if;
	
	--新增资格预审申请文件递交截止时间参数设置
	num:=0;
    select count(1) into num from bd_cssz where cskey='SQWJDJJZSJ';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('SQWJDJJZSJ','资格预审申请文件递交截止时间','5','系统管理员','相对于发布资格预审公告时间的工作日',1,'天',2500,'相对于发布资格预审公告时间的工作日');
	end if;
	
	--新增资格预审申请文件发售期参数设置
	num:=0;
    select count(1) into num from bd_cssz where cskey='ZGYSWJFSQ';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('ZGYSWJFSQ','资格预审申请文件发售期','5','系统管理员','资格预审申请文件发售截止日期和开售日期的间隔',1,'天',2700,'资格预审申请文件发售截止日期和开售日期的间隔');
	end if;
	
	--新增提交资格预审申请文件的时间参数设置
	num:=0;
    select count(1) into num from bd_cssz where cskey='TJZGYSWJSJ';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('TJZGYSWJSJ','提交资格预审申请文件的时间','5','系统管理员','资格预审文件发售截止日期至递交资格预审申请文件截止时间',1,'天',2800,'资格预审文件发售截止日期至递交资格预审申请文件截止时间');
	end if;
	
	--add by xuz 常用代码设置字段类型 start
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='字段类型';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','字段类型','字段类型', 1, 100, 1);
    end if;
    --add by xuz 常用代码设置字段类型 end

	--交易参数（交易平台标识代码）
	num:=0;
    select count(1) into num from bd_cssz where cskey='JYPTBZDM';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('JYPTBZDM','交易平台标识代码','ZBG00000000','系统管理员','交易平台标识代码',1,'',1000,'默认交易平台标识代码');
	end if;
	--mazg 计量单位
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='计量单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','计量单位','计量单位', 1, 90, 1);
    end if;
    
    --hejw 标段包邀请单位表--start-----
    num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE_YQDW';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE_YQDW',1);
    end if;
    --hejw 标段包邀请单位表--end-----
    
    
    
    
    
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  