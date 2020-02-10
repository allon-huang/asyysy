DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.41'; -- 本升级文件的版本，每个升级文件必须修改
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

	
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getTdYsjgGl' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getTdYsjgGl',0,'ajax公路价格查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getTdYsjgTl' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getTdYsjgTl',0,'ajax铁路价格查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getTdYsjgSl' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getTdYsjgSl',0,'ajax水路价格查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgQscs' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgQscs',0,'运输价格起始城市查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgDdcs' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgDdcs',0,'运输价格到达城市查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getTdCcfySz' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getTdCcfySz',0,'仓储价格查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getFphmByTr' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getFphmByTr',0,'物流平台查询运输委托单据号',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getFphmByCc' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getFphmByCc',0,'查询仓储平台单据号',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgGlQscs' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgGlQscs',0,'公路运输起始城市',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgGlDdcs' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgGlDdcs',0,'公路运输到达城市',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgSlCfd' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgSlCfd',0,'水路运输出发地',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgSlMdd' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgSlMdd',0,'水路运输目的地',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgTlQscz' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgTlQscz',0,'铁路运输起始城市',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgTlDdcz' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgTlDdcz',0,'铁路运输到达城市',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getYsjgTlCx' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getYsjgTlCx',0,'铁路运输车型',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getVTdYsjgQscz' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getVTdYsjgQscz',0,'运输价格起始车站',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getVTdYsjgDdcz' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getVTdYsjgDdcz',0,'运输价格到达车站',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getCcszArea' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getCcszArea',0,'区域查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/tdp/logistics/ajax' and method='getCcszCs' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/tdp/logistics/ajax','getCcszCs',0,'仓储设置城市查询',1,'M00004');
	end if;
	
	update bs_qxsz set inurl='/bsm/menber/manager/toAdd.do#/bsm/menber/manager/toEdit.do#/bsm/menber/mbopt/list.do#/bsm/menber/manager/save.do#/bsm/menber/query/importFile.do#/bsm/menber/manager/toEditSupplier.do'
	where mkid='B010001' and name='会员管理' and sid='B00000';
	
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  