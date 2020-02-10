DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.60'; -- 本升级文件的版本，每个升级文件必须修改
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

	update bs_qxsz set inurl='/exp/contract/buy/manage/list.do#/exp/contract/buy/manage/toRefuse.do#/exp/contract/buy/manage/toConfirm.do#/exp/contract/buy/manage/addPayRequest.do#/exp/contract/buy/manage/toAddPayRequest.do#/exp/contract/buy/manage/toYszf.do#' where mid='M0108' and sid='M00201' and mkid ='M010810';
	update bs_qxsz set inurl='/exp/contract/sell/manage/list.do#/exp/delivery/sell/manage/toCreateDelivery.do#/exp/delivery/sell/manage/toNextStep.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toView.do#/exp/contract/sell/tk/toAdd.do#/exp/contract/sell/manage/paymentConfirmPage.do#/exp/dissent/sell/manage/toEdit.do#/exp/entrust/sell/manage/toCreate.do#/exp/entrust/sell/manage/preview.do#/exp/entrust/sell/manage/toUpdate.do#/exp/contract/sell/manage/toConfirmOrder.do#/exp/contract/sell/manage/toDhqr.do#' where mid='M0112' and sid='M00201' and mkid ='M011220';
	
	update bs_qxsz set isuse=0 where mkid='M026015' and name='断点清单' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M026020' and name='配送看板' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M026005' and name='断点日历' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M026010' and name='库龄分析' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M026030' and name='捆包出入库查询' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M026025' and name='在库台账' and sid='M00004';
	
	update bs_qxsz set url='/exp/orders/pattern/list.do',inurl='/exp/orders/pattern/list.do' where mkid='M027515' and name='理论订货模型' and sid='M00004';
	update bs_qxsz set url='/exp/orders/schedule/list.do',inurl='/exp/orders/schedule/list.do' where mkid='M027510' and name='生产进度查询' and sid='M00004';
	update bs_qxsz set url='/exp/orders/card/list.do',inurl='/exp/orders/card/list.do#/exp/orders/card/toAdd.do#/exp/orders/card/toEdit.do#/exp/orders/card/toAddChild.do#/exp/orders/card/toEditChild.do' where mkid='M027505' and name='订货卡' and sid='M00004';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/pattern' and method='list' and styp=1 and mkid='M027515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027515','/exp/orders/pattern','list',2,'理论订货模型列表',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/schedule' and method='list' and styp=1 and mkid='M027510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027510','/exp/orders/schedule','list',2,'生产进度查询',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='list' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','list',2,'订货卡',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='toAdd' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','toAdd',2,'订货卡-跳转新增界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='toEdit' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','toEdit',2,'订货卡-跳转编辑界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='save' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','save',2,'保存订货卡',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='delete' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','delete',2,'删除订货卡',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='toAddChild' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','toAddChild',2,'订货卡子项-跳转新增界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='toEditChild' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','toEditChild',2,'订货卡子项-跳转编辑界面',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='saveChild' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','saveChild',2,'保存订货卡子项',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/card' and method='deleteChild' and styp=1 and mkid='M027505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027505','/exp/orders/card','deleteChild',2,'删除订货卡子项',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M027520' and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M027520','M0275','订货分析管理','订货台账','/exp/orders/ledger/list.do','/exp/orders/ledger/list.do',1,'400',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/ledger' and method='list' and styp=1 and mkid='M027520' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M027520','/exp/orders/ledger','list',2,'订货台账',1,'M00004');
	end if;
	
	-- 2014/05/28	hanglong	发送操作员验证短信邮件
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsm/menber/mbopt' and method='checkMailAndMsg' and styp=2 and mkid='B01000115' and sid='B00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000115','/bsm/menber/mbopt','checkMailAndMsg',1,'验证操作员是否修改了手机和邮箱',2,'B00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsm/menber/mbopt' and method='sendMailAndMsg' and styp=2 and mkid='B01000115' and sid='B00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000115','/bsm/menber/mbopt','sendMailAndMsg',1,'重新发送短信和邮件',2,'B00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/menber/mbopt' and method='sendMailAndMsg' and styp=1 and mkid='M011505' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011505','/bsp/menber/mbopt','sendMailAndMsg',2,'重新发送短信和邮件',1,'M00000');
	end if;
	
	-- 2014/05/29	hanglong	验证短信和邮件验证码
	num :=0;
	select count(1) into num from bs_qxmx where action='/login' and method='checkCode' and styp=1 and mkid='0' and sid='M00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','checkCode',1,'验证短信和邮件验证码',1,'M00000');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/market/menber/mboptQx' and method='opts' and styp=1 and mkid='M011505' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011505','/market/menber/mboptQx','opts',1,'权限复制',1,'M00000');
	end if;
	
	update bs_xtmk set mname='结算账户' where mid='B0115' and mname='交易账户' and sid='B00301';
	update bs_qxsz set name='结算账户' where  mid='B0115' and mkid='B011515' and sid='B00301';
	update bs_qxsz set name='结算账户余额' where  mid='B0115' and mkid='B011505' and sid='B00301';
	update bs_qxsz set name='结算账户流水' where  mid='B0115' and mkid='B011520' and sid='B00301';
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

