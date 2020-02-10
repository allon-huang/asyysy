DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.20'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD='getBrowseFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/buy', 'getBrowseFile', 2, '加密导入页面', 1, 'M00004'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD='importFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/buy', 'importFile', 2, '导入', 1, 'M00004'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD='export2AesFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/buy', 'export2AesFile', 2, '加密导出', 1, 'M00004'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/completed/buy' and METHOD='getBrowseFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/completed/buy', 'getBrowseFile', 2, '加密导入页面', 1, 'M00004'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/completed/buy' and METHOD='importFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/completed/buy', 'importFile', 2, '导入', 1, 'M00004'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/completed/buy' and METHOD='export2AesFile' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M017005', '/exp/querybusiness/completed/buy', 'export2AesFile', 2, '加密导出', 1, 'M00004'); 
	end if;

	--合同登记审批流权限 add by zhuchunhong 2014-01-08
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M013030' and mid='M0130' and sid='M00004' and url='/tdp/audit/pccontract/list.do';     
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013030', 'M0130', '合同登记', '合同审核', '/tdp/audit/pccontract/list.do', '/tdp/audit/pccontract/list.do#/tdp/audit/pccontract/showInfo.do', 1, 200, 1, '', 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M01303030' and mid='M0130' and sid='M00004';     
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01303030', 'M0130', '合同登记', '编辑', '', '', 2, 200, 1, 'M013030', 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M013030' and sid='M00004' and action='/tdp/audit/pccontract' and method='list';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/tdp/audit/pccontract', 'list', 2, '合同登记-合同审核列表', 1, 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M013030' and sid='M00004' and action='/tdp/audit/pccontract' and method='showInfo';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/tdp/audit/pccontract', 'showInfo', 2, '合同登记-合同审核-查看详情', 1, 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M01303030' and sid='M00004' and action='/tdp/audit/pccontract' and method='doAudit';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/tdp/audit/pccontract', 'doAudit', 2, '合同登记-合同审核', 1, 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M01303030' and sid='M00004' and action='/tdp/audit/pccontract' and method='doReject';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/tdp/audit/pccontract', 'doReject', 2, '合同登记-合同审核拒绝', 1, 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M01303030' and sid='M00004' and action='/tdp/audit/pccontract' and method='cancel';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/tdp/audit/pccontract', 'cancel', 2, '取消审核', 1, 'M00004');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M01300110' and sid='M00004' and action='/tdp/trail/pccontract' and method='doSubmit';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300110', '/tdp/trail/pccontract', 'doSubmit', 2, '提交合同或取消合同', 1, 'M00004');
	end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M013001' and sid='M00004' and name='合同查询';     
	if num = 1 then
		update bs_qxsz set inurl='/tdp/trail/pccontract/list.do#/tdp/trail/pccontract/showInfo.do#/tdp/trail/pccontract/toAdd.do#/tdp/trail/pccontract/getExtraContractList.do#/tdp/trail/pccontract/getBrowseFile.do#/tdp/trail/pccontract/getExtraContract4Edit.do' where mkid='M013001' and sid='M00004' and name='合同查询';
	end if;
	update bs_xtmk set mname = '我 要 卖'  where mid = 'M0235' and sid = 'M00004' and mname = '竞价销售';
	update bs_qxsz set mname = '我 要 卖',name = '新增交易品种' where mkid = 'M023550' and sid = 'M00004';
    update bs_qxsz set mname = '我 要 卖' where mkid = 'M023520' and sid = 'M00004';
    update bs_qxsz set mname = '我 要 卖',name = '编辑' where mkid = 'M02352005' and sid = 'M00004';
    update bs_qxsz set mname = '我 要 卖',name = '交易中' where mkid = 'M023530' and sid = 'M00004';
    update bs_qxsz set mname = '我 要 卖',name = '交易结果' where mkid = 'M023540' and sid = 'M00004';
    num := 0;
  	select count(1) into num from bs_qxsz where mkid='M02352010' and mid='M0235' and sid='M00004';
  	if num = 0 then
    insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid) 
      values('M02352010','M0235','我 要 卖','发布',2,300,1,'M023520','M00004');
  	end if;
  	update bs_qxmx set mkid='M02352010' where action='/exp/auction/sell/bout' and sid='M00004' and method='refer';

    
	
		delete from bs_qxmx where action='/bsp/supplier/manage' and method='showimg' and styp=1 and sid='M00000';
    
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/suplier/manage' and method='showimg' and styp=1 and sid='M00000';
  if num = 0 then
	  
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values(bs_qxmx_0.nextval,'0','/bsp/suplier/manage','showimg',0,'供应商审核-查看附件',1,'M00000');
  end if;
  	
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M025010' and sid='M00004' and action='/exp/tdcontract/sell/trail' and method='index';     
	if num = 0 then
  		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M025010','/exp/tdcontract/sell/trail','index',2,'订单维护',1,'M00004');
	end if;

	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M025010' and sid='M00004' and action='/exp/tdcontract/sell/trail' and method='save';     
  if num = 0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M025010','/exp/tdcontract/sell/trail','save',2,'新增维护信息',1,'M00004');
  end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where mkid='M025010' and sid='M00004' and action='/exp/tdcontract/sell/trail' and method='update';     
  if num = 0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M025010','/exp/tdcontract/sell/trail','update',2,'修改维护信息',1,'M00004');
  end if;

  num:=0;
    select count(1) into num from bs_qxmx where mkid='M025010' and sid='M00004' and action='/exp/tdcontract/sell/trail' and method='delete';     
  if num = 0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M025010','/exp/tdcontract/sell/trail','delete',2,'删除维护信息',1,'M00004');
  end if;
    
    
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  