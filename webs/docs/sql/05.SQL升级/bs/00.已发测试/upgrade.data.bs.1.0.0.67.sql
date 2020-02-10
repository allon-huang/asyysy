DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.67'; -- 本升级文件的版本，每个升级文件必须修改
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
	update bs_xtmk set mname='采购计划管理' where  mname='采购管理' and mid='M0275' and sid='M00004';


	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/syscode/publicfun' and method='removeFlash' and styp=2 and sid='B00301';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/admin/syscode/publicfun', 'removeFlash', 0, '删除重复的消息提示', 2, 'B00301');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and method='removeFlash' and styp=1 and sid='M00301';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/market/syscode/publicfun', 'removeFlash', 0, '删除重复的消息提示', 1, 'M00301');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/ask' and method='meIsOnline' and styp=2 and sid='B00301';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/ask', 'meIsOnline', 0, '客户端在线通知', 2, 'B00301');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/ask' and method='meIsOnline' and styp=1 and sid='M00301';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/ask', 'meIsOnline', 0, '客户端在线通知', 1, 'M00301');
	end if;

	-- 2014/06/23 hanglong 员工数据权限
	update bs_qxsz set name='员工功能权限' where mkid='M01150520' and mid='M0100' and styp=1 and sid='M00000';
	update bs_qxsz set inurl='/bsp/menber/mbopt/list.do#/market/menber/mboptQx/index.do#/bsp/menber/busGroup/list.do#/market/menber/mbDepoptQx/getMbDepTree.do#/market/menber/mbDepoptQx/saveMbDepOpt.do#' where mkid='M011505' and mid='M0100' and styp=1 and sid='M00000';
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M01150525' and mid='M0100' and styp=1 and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) values('M01150525','M0100','基本管理','员工数据权限','','',2,150,1,'M011505','M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/menber/mbDepoptQx' and method='getMbDepTree' and styp=1 and sid='M00000';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01150525', '/market/menber/mbDepoptQx', 'getMbDepTree', 2, '获得员工数据权限树', 1, 'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/menber/mbDepoptQx' and method='saveMbDepOpt' and styp=1 and sid='M00000';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01150525', '/market/menber/mbDepoptQx', 'saveMbDepOpt', 2, '保存员工数据权限', 1, 'M00000');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/manager/subaccount/inout' and method='sendInamt' and styp=2 and sid='B00301';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011520','/manager/subaccount/inout','sendInamt',2,'银行交易明细重新发送',2,'B00301');
	end if;
	
	
	-- 2014/06/24 hanglong
	num:=0;
	select count(1) into num from bs_value where gid='RunTime' and key='BS_ALL_DEP_OPT' ;
	if num = 0 then
		insert into bs_value (gid, key, value, remark)
		values ('RunTime', 'BS_ALL_DEP_OPT', '1', '是否启用操作员对所有下级部门可访问权限,1-启用，0-不启用');
	end if;
	
	
	update bs_qxsz set name='批量上架' where mkid='M01101005' and mid='M0110' and sid='M00201';
	update bs_qxsz set name='商品发布和上架' where mkid='M01102005' and mid='M0110' and sid='M00201';
	
	
	update bs_qxsz set inurl='/bsp/menber/wldw/list.do#/bsp/menber/wldw/auditList.do#/bsp/menber/wldw/toAdd.do' where mkid='M010035' and mid='M0100' and styp=1 and sid='M00000';


	num:=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='info' and styp=1 and sid='M00000';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M010035', '/bsp/menber/wldw', 'info', 2, '查看代理商信息', 1, 'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='auditInfo' and styp=1 and sid='M00000';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M010035', '/bsp/menber/wldw', 'auditInfo', 2, '查看未审核代理商信息', 1, 'M00000');
	end if;
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

