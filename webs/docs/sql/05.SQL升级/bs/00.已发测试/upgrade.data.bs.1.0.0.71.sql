DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.71'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from  bs_qxsz where sid='B00004' and mid='B0145'  and mkid='B014510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B014510', 'B0145', '询货采购管理', '询货采购管理', '/exm/querybusiness/manager/list.do', '/exm/querybusiness/manager/list.do', 1, 200, 2, '', 'B00004');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014510' and action='/exm/querybusiness/manager' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'list', 2, '后台-询货采购管理', 2, 'B00004');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mname = '交易统计报表' and name = '会员交易统计表' and mkid = 'B018005';       
	if num = 1 then 
		update bs_qxsz set name = '会员交易总表' where sid='B00201' and mname = '交易统计报表' and name = '会员交易统计表' and mkid = 'B018005'; 
    END IF;
    
    -- 2014/07/28	hanglong	客户入金调账
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B011540';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011540', 'B0115', '交易账户', '客户入金调账', '/manager/subaccount/inoutAccountEdit/list.do', '/manager/subaccount/inoutAccountEdit/list.do#/manager/subaccount/inoutAccountEdit/toEdit.do#/manager/subaccount/inoutAccountEdit/doEdit.do#', 1, 500, 2, '', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011540' and action='/manager/subaccount/inoutAccountEdit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011540', '/manager/subaccount/inoutAccountEdit', 'list', 2, '客户入金调账-列表', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011540' and action='/manager/subaccount/inoutAccountEdit' and method='print';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011540', '/manager/subaccount/inoutAccountEdit', 'print', 2, '客户入金调账-打印', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B01154005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01154005', 'B0115', '交易账户', '编辑', '', '', 2, 510, 2, 'B011540', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01154005' and action='/manager/subaccount/inoutAccountEdit' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01154005', '/manager/subaccount/inoutAccountEdit', 'toEdit', 2, '客户入金调账-进入编辑页面', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01154005' and action='/manager/subaccount/inoutAccountEdit' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01154005', '/manager/subaccount/inoutAccountEdit', 'doEdit', 2, '客户入金调账-编辑保存', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B011545';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011545', 'B0115', '交易账户', '客户入金调账审核', '/manager/subaccount/inoutAccountEdit/audit/list.do', '/manager/subaccount/inoutAccountEdit/audit/list.do#/manager/subaccount/inoutAccountEdit/audit/toAudit.do#/manager/subaccount/inoutAccountEdit/audit/doAudit.do#', 1, 550, 2, '', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011545' and action='/manager/subaccount/inoutAccountEdit/audit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011545', '/manager/subaccount/inoutAccountEdit/audit', 'list', 2, '客户入金调账-审核', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B01154505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01154505', 'B0115', '交易账户', '审核', '', '', 2, 560, 2, 'B011545', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01154505' and action='/manager/subaccount/inoutAccountEdit/audit' and method='toAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01154505', '/manager/subaccount/inoutAccountEdit/audit', 'toAudit', 2, '客户入金调账-进入审核页面', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01154505' and action='/manager/subaccount/inoutAccountEdit/audit' and method='doAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01154505', '/manager/subaccount/inoutAccountEdit/audit', 'doAudit', 2, '客户入金调账-审核', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='0' and action='/admin/publicfun' and method='getAllQxGroup';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/admin/publicfun', 'getAllQxGroup', 1, '查询会员类型', 2, 'B00000');
    END IF;
    
	num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mname = '交易统计报表' and name = '交易情况统计表' and mkid = 'B018010';       
	if num = 1 then 
		update bs_qxsz set name = '会员交易统计表' where sid='B00201' and mname = '交易统计报表' and name = '交易情况统计表' and mkid = 'B018010'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mname = '统计分析报表' and name = '日成交统计表' and mkid = 'B018505';       
	if num = 1 then 
		update bs_qxsz set name = '订单成交统计表' where sid='B00201' and mname = '统计分析报表' and name = '日成交统计表' and mkid = 'B018505'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mname = '统计分析报表' and name = '成交统计表' and mkid = 'B018510';       
	if num = 1 then 
		update bs_qxsz set name = '品牌成交统计表' where sid='B00201' and mname = '统计分析报表' and name = '成交统计表' and mkid = 'B018510'; 
    END IF;
    
    -- 2014/07/29	hanglong	收款明细
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B011550';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011550', 'B0115', '交易账户', '收款明细', '/manager/subaccount/skmx/list.do', '/manager/subaccount/skmx/list.do#', 1, 40, 2, '', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011550' and action='/manager/subaccount/skmx' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011550', '/manager/subaccount/skmx', 'list', 2, '收款明细-列表', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011550' and action='/manager/subaccount/skmx' and method='export';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011550', '/manager/subaccount/skmx', 'export', 2, '收款明细-导出', 2, 'B00301');
    END IF;
    
    -- 2014/07/29	hanglong	收款通知单
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00301' and mid='B0115' and mkid = 'B011555';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011555', 'B0115', '交易账户', '收款通知单', '/manager/subaccount/sktzd/list.do', '/manager/subaccount/sktzd/list.do#', 1, 40, 2, '', 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011555' and action='/manager/subaccount/sktzd' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011555', '/manager/subaccount/sktzd', 'list', 2, '收款通知单-列表', 2, 'B00301');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B011555' and action='/manager/subaccount/sktzd' and method='print';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011555', '/manager/subaccount/sktzd', 'print', 2, '收款通知单-查看', 2, 'B00301');
    END IF;
	
	
	num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017515';       
	if num = 1 then 
		update bs_qxsz set isuse = 0 where sid='M00201' and mid='M0175' and mkid = 'M017515'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017540';       
	if num = 1 then 
		update bs_qxsz set name = '会员交易总表' where sid='M00201' and mid='M0175' and mkid = 'M017540'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017550';       
	if num = 1 then 
		update bs_qxsz set name = '会员交易统计表' where sid='M00201' and mid='M0175' and mkid = 'M017550'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017510';       
	if num = 1 then 
		update bs_qxsz set name = '订单执行报表' where sid='M00201' and mid='M0175' and mkid = 'M017510'; 
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017560';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M017560', 'M0175', '市场管理中心', '交易统计报表', '/exp/contract/jytj/report/list.do', '/exp/contract/jytj/report/list.do', 1, 40, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00000' and mkid='0' and action='/market/publicfun' and method='getAllQxGroup';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/market/publicfun', 'getAllQxGroup', 0, '查询会员类型', 1, 'M00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017560' and action='/exp/contract/jytj/report' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017560', '/exp/contract/jytj/report', 'list', 2, '交易统计报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0115' and mkid = 'B011555';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011555', 'B0115', '订单管理', '付款审核', '/exm/contract/bill/payaudit/list.do', '/exm/contract/bill/payaudit/list.do#', 1, 1100, 2, '', 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B011555' and action='/exm/contract/bill/payaudit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011555', '/exm/contract/bill/payaudit', 'list', 2, '付款审核-列表', 2, 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0115' and mkid = 'B01155505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01155505', 'B0115', '订单管理', '审核', '', '', 2, 1110, 2, 'B011555', 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B01155505' and action='/exm/contract/bill/payaudit' and method='toAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01155505', '/exm/contract/bill/payaudit', 'toAudit', 2, '付款审核-进入审核页面', 2, 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B01155505' and action='/exm/contract/bill/payaudit' and method='doAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01155505', '/exm/contract/bill/payaudit', 'doAudit', 2, '付款审核-审核或拒绝', 2, 'B00201');
    END IF;
    
        
	num:=0; 
	tmp1:=upper('bs_menber');
	tmp2:=upper('WORKTEL');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''业务电话'''; 
	end if;
	
	num:=0; 
	tmp1:=upper('bs_menber_tmp');
	tmp2:=upper('WORKTEL');
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 0 then
		execute immediate 'alter table '||tmp1||' add('||tmp2||' VARCHAR2(30))';
    	execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''业务电话'''; 
	end if;
    
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

