DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.29'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxmx where action='/ecim/account/audit/manage' and method='list' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B010515','/ecim/account/audit/manage','list',2,'中信银行账户签约审核查询',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/audit/manage' and method='toAudit' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01051505','/ecim/account/audit/manage','toAudit',2,'跳转到账户签约审核界面',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/audit/manage' and method='agree' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01051505','/ecim/account/audit/manage','agree',2,'账户签约审核通过',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/audit/manage' and method='refuse' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01051505','/ecim/account/audit/manage','refuse',2,'账户签约审核不通过',2,'B00301');
	end if;
	
	update bs_qxsz set url='/ecim/account/info/manage/list2Status.do' where mkid='B010525' and name='账户签约查询' and sid='B00301';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='list2Status' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B010525','/ecim/account/info/manage','list2Status',2,'查询已成功的签约信息列表',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='sendPay' and styp=1 and sid='M00101';
	if num=0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010515','/exp/contract/buy/manage','sendPay',2,'合同管理-支付请求',1,'M00101');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='sendPay' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010810','/exp/contract/buy/manage','sendPay',2,'合同管理-支付请求',1,'M00201');
	end if;
	-- 2014/4/3 hangl 资金账户余额 start
	update bs_qxsz set url='/manager/subaccount/ye/list.do', inurl='/manager/subaccount/ye/list.do#' where sid='B00301' and mkid='B011505';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/manager/subaccount/ye' and method='list' and styp=2 and mkid='B011505' and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/manager/subaccount/ye','list',2,'资金账户余额查询',2,'B00301');
	end if;

	-- 资金账户余额 end 

	-- 2014/4/3 hangl 资金账户明细 start
	update bs_qxsz set url='/manager/subaccount/mx/list.do', inurl='/manager/subaccount/mx/list.do#' where sid='B00301' and mkid='B011515';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/manager/subaccount/mx' and method='list' and styp=2 and mkid='B011515' and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011515','/manager/subaccount/mx','list',2,'资金账户明细查询',2,'B00301');
	end if;

	-- 资金账户明细 end 
	 
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='doPayQuery' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010810','/exp/contract/buy/manage','doPayQuery',2,'合同管理-支付请求',1,'M00201');
	end if;
	
	-- 2014/4/3 hangl 通用弹出信息选择窗口权限 start
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='mblicense' and styp=2 and mkid='0' and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/publicfun','mblicense',1,'附属账户选择窗口',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='menber' and styp=2 and mkid='0' and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/publicfun','menber',1,'会员选择窗口',2,'B00301');
	end if;
		
	-- 通用弹出信息选择窗口权限 end
	
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  