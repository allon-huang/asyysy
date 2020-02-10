DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.23'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
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
  
  	update bs_qxmx set mkid='0' where action='/me/home' and method='showDiscuss';
  	
  	update bs_qxmx set mkid='M025505',accesstag=1 where action='/tuangou' and styp=1 and sid='M00004' and method in ('execute','index') and mkid<>'M025505';
  	
	update bs_qxmx set mkid='M017005',accesstag=1 where action='/xunhuo' and styp=1 and sid='M00004' and method ='execute' and mkid <> 'M017005';
	
	update bs_qxmx set mkid='M010505',accesstag=1 where action='/zhaobiao' and styp=1 and sid='M00004' and method ='execute' and mkid <> 'M010505';
	
	update bs_qxmx set mkid='M020510',accesstag=1 where action='/jjcaigou' and styp=1 and sid='M00004' and method ='execute' and mkid <> 'M020510';
	
	update bs_qxmx set mkid='M023510',accesstag=1 where action='/jjxiaoshou' and styp=1 and sid='M00004' and method ='execute' and mkid <> 'M023510';
  
  	
  	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00201' and mkid='B014005' and inurl like '%#/exm/basesetup/setpzChild/secondList.do%';
  	if num = 0 then
  		update bs_qxsz set inurl = concat(inurl,'#/exm/basesetup/setpzChild/secondList.do') where sid='M00201' and mkid='B014005';
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxsz where sid='B00004' and mkid='B010510' and inurl like '%#/exm/basesetup/setpzChild/secondList.do%';
  	if num = 0 then
  		update bs_qxsz set inurl = concat(inurl,'#/exm/basesetup/setpzChild/secondList.do') where sid='B00004' and mkid='B010510';
  	end if;
  
    
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  