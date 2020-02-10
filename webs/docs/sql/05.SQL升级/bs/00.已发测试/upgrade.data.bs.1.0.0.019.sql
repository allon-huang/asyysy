DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.19'; -- 本升级文件的版本，每个升级文件必须修改
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
	

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD='jjsellggTop' and STYP='1' and SID='M00004';     
	if num = 0 then
	 insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'jjsellggTop', 0, '竞价销售公告tab', 1, 'M00004'); 
	end if;
 
 	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD='jjsellggList' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'jjsellggList', 0, '竞价销售公告列表', 1, 'M00004'); 
	end if;
	-------------------------------------------------------------
	-- add by zhangsiwei on 20140107
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M02051005' and mid='M0205' and sid='M00004';
	if num = 0 then 
	   insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid) 
	     values('M02051005','M0205','竞价采购','发布',2,100,1,'M020510','M00004');
	end if;
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M02051010' and mid='M0205' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid) 
		  values('M02051010','M0205','竞价采购','删除',2,100,1,'M020510','M00004');
	end if;
	update bs_qxmx set mkid='M02051010' where action='/exp/tender/buy/bout' and sid='M00004' and method='delete';
	update bs_qxmx set mkid='M02051005' where action='/exp/tender/buy/bout' and sid='M00004' and method='refer';
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  