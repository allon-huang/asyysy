DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.57'; -- 本升级文件的版本，每个升级文件必须修改
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
  	select count(1) into num from bs_dq where dqtyp=1 and dqname='北京';
  	if num=1 then
       update bs_dq set orderno='1'where dqtyp=1 and dqname='北京';
	end if;
  
    num :=0;
  	select count(1) into num from bs_dq where dqtyp=1 and dqname='浙江省';
  	if num=1 then
       update bs_dq set orderno=''where dqtyp=1 and dqname='浙江省';
	end if;
	
	
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='B011550' and sid='B00000';
	  if num=0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011550', 'B0115', '基本设置', '审批流设置', '/bsm/menber/checkgroup/list.do', '/bsm/menber/checkgroup/list.do#/bsm/menber/checkgroupopt/list.do#/bsm/menber/checkgroupopt/viewMap.do', 1, 1000, 2, '', 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='list' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'list', 2, '审核组', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='doAdd' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'doAdd', 2, '审核组新增', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='doAddSave' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'doAddSave', 2, '审核组新增保存', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='doDelete' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'doDelete', 2, '审核组删除', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='list' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'list', 2, '审核操作员', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doAdd' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doAdd', 2, '审核操作员新增', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doAddSave' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doAddSave', 2, '审核操作员新增保存', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doDelete' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doDelete', 2, '审核操作员删除', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='doEdit' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'doEdit', 2, '审核组修改', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='doEditSave' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'doEditSave', 2, '审核组修改保存', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doEdit' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doEdit', 2, '审核操作员修改', 2, 'B00000');
	end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doEdit' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doEdit', 2, '审核操作员修改', 2, 'B00000');
	end if;

	  
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroupopt' and method='doEditSave' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroupopt', 'doEditSave', 2, '审核操作员修改保存', 2, 'B00000');
	end if;


	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bsm/menber/checkgroup' and method='viewMap' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011550', '/bsm/menber/checkgroup', 'viewMap', 2, '审批流关系图', 2, 'B00000');
	end if;




	  num :=0;
	  select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='getAllOptusersByDep' and styp='2' and sid='B00000';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values(0,'/admin/publicfun','getAllOptusersByDep',1,'根据部门选择操作员',2,'B00000');
	end if;


	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/contract/bill/manage' and method='doAudit' and styp='2' and sid='B00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','doAudit',2,'出金结算审批流审核',2,'B00201');
	end if;
	

	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exm/contract/bill/manage' and method='doCancel' and styp='2' and sid='B00201';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','doCancel',2,'出金结算撤销',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/compare' and method='createZstXml' and styp=1 and mkid='M027020' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027020','/exp/output/compare','createZstXml',2,'月度计划版本比较-AJAX生成XML数据文件',1,'M00004');
	end if;
	
	update bs_qxsz set inurl='/exp/hangsource/sell/hangadmin/index.do#/exp/hangsource/sell/publish/info.do#/exp/hangsource/sell/hangadmin/doFile.do#/exp/hangsource/sell/hangadmin/doFilePreview.do#' where sid='M00201' and mkid='M011005';

	
update bs_qxsz set name='资金账户流水'  where sid='B00301' and mkid='B011520';
update bs_qxsz set name='交易账户余额' where sid='B00301' and mkid='B011505';
update bs_qxsz set name='订单划款明细'  where sid='B00301' and mkid='B011515';
	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

