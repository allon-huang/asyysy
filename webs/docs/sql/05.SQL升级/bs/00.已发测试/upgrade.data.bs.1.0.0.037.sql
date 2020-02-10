DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.37'; -- 本升级文件的版本，每个升级文件必须修改
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

	-- 2014/04/14 hangl 供应商选择列表
	num :=0;
	select count(1) into num from bs_qxmx where action='/market/publicfun' and method='menberByGYS' and styp=1 and mkid='0' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/market/publicfun','menberByGYS',0,'供应商选择列表',1,'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='menberByGYS' and styp=2 and mkid='0' and sid='B00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/publicfun','menberByGYS',0,'供应商选择列表',2,'B00000');
	end if;
	
	-- 2014/04/15 hangl	资金账户明细订单查询
	update bs_qxmx set accesstag = 1 where action='/exm/contract/shop/manage' and method='showInfo' and styp=2 and sid='B00201';
	
	
	num :=0;
	select count(1) into num from bs_codes where typ='公司介绍审核状态' and code='0';
	if num=0 then
		insert into bs_codes(typ,code,value,isuse,orderno) values('公司介绍审核状态',0,'已作废',1,10);
	end if;
	
	num :=0;
	select count(1) into num from bs_codes where typ='公司介绍审核状态' and code='1';
	if num=0 then
		insert into bs_codes(typ,code,value,isuse,orderno) values('公司介绍审核状态',1,'待审核',1,20);
	end if;
	
	num :=0;
	select count(1) into num from bs_codes where typ='公司介绍审核状态' and code='2';
	if num=0 then
		insert into bs_codes(typ,code,value,isuse,orderno) values('公司介绍审核状态',2,'已审核',1,30);
	end if;
	
	num :=0;
	select count(1) into num from bs_codes where typ='公司介绍审核状态' and code='3';
	if num=0 then
		insert into bs_codes(typ,code,value,isuse,orderno) values('公司介绍审核状态',3,'已拒绝',1,40);
	end if;

	num :=0;
	select count(1) into num from bs_qxsz where mkid='M010050' and mid='M0100';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M010050','M0100','基本管理','公司介绍','/bsp/menber/manager/intro.do','/bsp/menber/manager/intro',1,'10',1,'','M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/manager' and method='intro' and styp=1 and mkid='M010050' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010050','/bsp/menber/manager','intro',2,'公司介绍查看',1,'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/manager' and method='saveIntro' and styp=1 and mkid='M010050' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010050','/bsp/menber/manager','saveIntro',2,'提交公司介绍',1,'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/manager' and method='showIntro' and styp=1 and mkid='M010050' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010050','/bsp/menber/manager','showIntro',2,'公司介绍',1,'M00000');
	end if;
	

    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  