DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.68'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxsz where mkid='B011525' and sid='B00301';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011525','B0115','资金账户','客户账户明细','/manager/subaccount/report/wldwreport.do','/manager/subaccount/report/wldwreport.do#',1,200,2,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B011530' and sid='B00301';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011530','B0115','资金账户','供应商账户明细','/manager/subaccount/report/gysreport.do','/manager/subaccount/report/gysreport.do#',1,300,2,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B011535' and sid='B00301';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011535','B0115','资金账户','归集账户明细','/manager/subaccount/report/bzjreport.do','/manager/subaccount/report/bzjreport.do#',1,400,2,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/manager/subaccount/report' and METHOD ='wldwreport' and STYP='2' and SID='B00301';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011525','/manager/subaccount/report','wldwreport',2,'客户交易账户往来单位明细',2,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/manager/subaccount/report' and METHOD ='gysreport' and STYP='2' and SID='B00301';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011530','/manager/subaccount/report','gysreport',2,'供应商交易账户往来单位明细',2,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/manager/subaccount/report' and METHOD ='bzjreport' and STYP='2' and SID='B00301';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011535','/manager/subaccount/report','bzjreport',2,'交易保证金归集账户明细',2,'B00301');
	end if;


	update bs_qxsz set name='客户账户明细' where mkid='M010010' and sid='M00301';
	
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M010025'  and SID='M00301';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
		values('M010025','M0100','交易账户','资金账户余额','/bk/subaccount/inout/getAccount.do','/bk/subaccount/inout/getAccount.do',1,300,1,'M00301');
	end if;


	update bs_qxmx set mkid='M010025' where ACTION='/bk/subaccount/inout' and METHOD ='getAccount' and STYP='1' and SID='M00301';
	
	update bs_system set sname='交易账户' where sid='M00301';
	update bs_system set sname='交易账户' where sid='B00301';
	
	update bs_xtmk set mname='交易账户' where mid='B0115' and sid='B00301';
	update bs_qxsz set name='交易账户余额' where  mid='B0115' and mkid='B011505' and sid='B00301';
	update bs_qxsz set name='交易账户流水' where  mid='B0115' and mkid='B011520' and sid='B00301';
	

	num :=0;
	select count(1) into num from bs_xtmk where mid='M0175'  and sid='M00201';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0175','市场管理中心',1,'600','M00201','201-5');
    end if;
    
    num :=0;
	select count(1) into num from bs_qxsz where mkid='M017510'  and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017510','M0175','市场管理中心','订单报表','/exp/contract/order/report/list.do','/exp/contract/order/report/list.do',1,'100',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M017515'  and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017515','M0175','市场管理中心','物流报表','/exp/contract/logistics/report/list.do','/exp/contract/logistics/report/list.do',1,'200',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M017530'  and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017530','M0175','市场管理中心','换货报表','/exp/contract/exchangegoods/report/list.do','/exp/contract/exchangegoods/report/list.do',1,'300',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M017540'  and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017540','M0175','市场管理中心','成交统计报表','/exp/contract/cjtj/report/list.do','/exp/contract/cjtj/report/list.do',1,'400',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M017550'  and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017550','M0175','市场管理中心','交易成交统计报表','/exp/contract/jycjtj/report/list.do','/exp/contract/jycjtj/report/list.do',1,'500',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/order/report' and METHOD ='list' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017510','/exp/contract/order/report','list',2,'订单报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/logistics/report' and METHOD ='list' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017515','/exp/contract/logistics/report','list',2,'物流报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/exchangegoods/report' and METHOD ='list' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017530','/exp/contract/exchangegoods/report','list',2,'换货报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/cjtj/report' and METHOD ='list' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017540','/exp/contract/cjtj/report','list',2,'成交统计报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/jycjtj/report' and METHOD ='list' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017550','/exp/contract/jycjtj/report','list',2,'交易成交统计报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/me/report/home' and METHOD ='index' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/me/report/home','index',1,'我的平台',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/logistics/report' and METHOD ='info' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017515','/exp/contract/logistics/report','info',2,'物流报表-查看物流配送详情',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/logistics/report' and METHOD ='showInfo' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017515','/exp/contract/logistics/report','showInfo',1,'物流报表-查看订单详情',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/exchangegoods/report' and METHOD ='toInfo' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017530','/exp/contract/exchangegoods/report','toInfo',2,'换货报表-查看换货详情',1,'M00201');
	end if;
	
	update bs_qxsz set inurl='/exp/contract/exchangegoods/report/list.do#/exp/contract/exchangegoods/report/toInfo.do' where  mid='M0175' and mkid='M017530' and sid='M00201'; 
	

	-- 2014/07/01 hanglong 更新会员管理按钮权限
	--  start
	update bs_qxsz set isuse=0 where  mid='B0100' and mkid='B01000125' and sid='B00000'; 
	update bs_qxsz set isuse=0 where  mid='B0100' and mkid='B01000130' and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000115' where  action='/bsm/menber/mbopt' and method='list' and styp=2 and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000110' where  action='/admin/menber/mbqxsz' and method='list' and styp=2 and sid='B00000'; 
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01000140' and mid='B0100' and SID='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B01000140','B0100','会员管理','代理商','','',2,150,2,'B010001','B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01000145'  and mid='B0100' and SID='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B01000145','B0100','会员管理','导出','','',2,160,2,'B010001','B00000');
	end if;
	
	update bs_qxmx set mkid='B01000140',accesstag=2 where  action='/bsm/menber/manager' and method='getDls' and styp=2 and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000120',accesstag=2 where  action='/bsm/menber/manager' and method='toUsersysqx' and styp=2 and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000145',accesstag=2 where  action='/bsm/menber/query' and method='export' and styp=2 and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000115',accesstag=2 where  action='/bsm/menber/mbopt' and method='doResetPwd' and styp=2 and sid='B00000'; 
	
	update bs_qxmx set mkid='B01000115',accesstag=2 where  action='/bsm/menber/mbopt' and method='toResetPwd' and styp=2 and sid='B00000'; 
	--  end
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/buy/payRequest' and METHOD ='setPrintInfo' and STYP='1' and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01082515','/exp/contract/buy/payRequest','setPrintInfo',2,'保存支付申请单打印签名信息',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/manager' and METHOD ='tofm' and STYP='2' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000105','/bsm/menber/manager','tofm',2,'会员管理-供应商附码',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/manager' and METHOD ='doFm' and STYP='2' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000105','/bsm/menber/manager','doFm',2,'会员管理-供应商附码',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01402510' and mid='B0140' and SID='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B01402510','B0140','基本设置','导入','','',2,150,2,'B014025','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/basesetup/setwzdm' and METHOD ='toImport' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402510','/exm/basesetup/setwzdm','toImport',2,'进入导入页面',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/basesetup/setwzdm' and METHOD ='doImport' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402510','/exm/basesetup/setwzdm','doImport',2,'导入',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01402520' and mid='B0140' and SID='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B01402520','B0140','基本设置','导出','','',2,200,2,'B014025','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/basesetup/setwzdm' and METHOD ='export' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402520','/exm/basesetup/setwzdm','export',2,'导出',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01402530' and mid='B0140' and SID='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B01402530','B0140','基本设置','物资附码','','',2,200,2,'B014025','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/basesetup/setwzdm' and METHOD ='toWzfm' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402530','/exm/basesetup/setwzdm','toWzfm',2,'进入物资附码编辑页面',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/basesetup/setwzdm' and METHOD ='doWzfm' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402530','/exm/basesetup/setwzdm','doWzfm',2,'物资附码编辑',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin/public/item' and METHOD ='getPpList' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/public/item','getPpList',1,'获得品牌列表AJAX',2,'B00201');
	end if;

	update bs_qxsz set inurl='/exm/basesetup/setwzdm/list.do#/exm/basesetup/setwzdm/toImport.do#/exm/basesetup/setwzdm/doImport.do' where mkid='B014025' and sid='B00201';

    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/contract/bill/manage' and METHOD ='toPay' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','toPay',2,'待付款页面',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/contract/bill/manage' and METHOD ='doPay' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','doPay',2,'付款',2,'B00201');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/contract/bill/manage' and METHOD ='toEdit' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','toEdit',2,'编辑银行账户信息页面',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/contract/bill/manage' and METHOD ='doEdit' and STYP='2' and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','doEdit',2,'编辑银行账户信息',2,'B00201');
	end if;
	
	update bs_qxsz set isuse=0 where mkid='B01051010' and mid='B0105' and  sid='B00201';
	
	update bs_xtmk set mname='售后服务' where mid='M0170' and sid='M00201';
	update bs_xtmk set mname='售后服务' where mid='M0165' and sid='M00201';

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/market/publicfun' and METHOD ='selectGroupByHy' and STYP='1' and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/market/publicfun','selectGroupByHy',1,'选择集团-过滤掉部门',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='B0104' and sid='B00002';
	if num=0 then
	    insert into bs_xtmk(mid,mname,styp,ordby,sid) values('B0104','邮件队列',2,110,'B00002');
	end if;
	
	select count(1) into num from bs_qxsz where mkid='B010405' and mid='B0104' and styp=2 and sid='B00002';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010405','B0104','邮件队列','邮件历史查询','/smsm/sms/mail/history/list.do','/smsm/sms/mail/history/list.do',1,100,2,'B00002');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/smsm/sms/mail/history' and METHOD ='list' and STYP='2' and SID='B00002';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010405','/smsm/sms/mail/history','list',2,'列表',2,'B00002');
	end if;
	
	select count(1) into num from bs_qxsz where mkid='B010410' and mid='B0104' and styp=2 and sid='B00002';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010410','B0104','邮件队列','邮件队列查询','/smsm/sms/mail/queue/list.do','/smsm/sms/mail/queue/list.do',1,50,2,'B00002');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/smsm/sms/mail/queue' and METHOD ='list' and STYP='2' and SID='B00002';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010410','/smsm/sms/mail/queue','list',2,'邮件队列列表',2,'B00002');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/smsm/sms/mail/queue' and METHOD ='start' and STYP='2' and SID='B00002';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010410','/smsm/sms/mail/queue','start',2,'邮件队列-启动/暂停服务',2,'B00002');
	end if;
	
	--	2014/07/09 hanglong 结算管理
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0180' and sid='M00201';
	if num=0 then
	    insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0180','结算管理',1,700,'M00201','201-2');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M018010' and mid='M0180' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M018010','M0180','结算管理','结算统计报表','/exp/contract/settle/gys/report/list.do','/exp/contract/settle/gys/report/list.do',1,100,1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M018010' and action='/exp/contract/settle/gys/report' and method ='list' and sid='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018010','/exp/contract/settle/gys/report','list',2,'供应商结算统计报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M018010' and action='/exp/contract/settle/gys/report' and method ='export' and sid='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018010','/exp/contract/settle/gys/report','export',2,'供应商结算统计报表导出',1,'M00201');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='M018020' and mid='M0180' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M018020','M0180','结算管理','订单结算明细报表','/exp/contract/settle/dd/report/list.do','/exp/contract/settle/dd/report/list.do',1,200,1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M018020' and action='/exp/contract/settle/dd/report' and method ='list' and sid='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018020','/exp/contract/settle/dd/report','list',2,'订单结算明细报表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M018020' and action='/exp/contract/settle/dd/report' and method ='export' and sid='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018020','/exp/contract/settle/dd/report','export',2,'订单结算明细报表导出',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='B011520' and action='/manager/subaccount/inout' and method ='matchInamt' and sid='B00301';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011520','/manager/subaccount/inout','matchInamt',2,'银行错误数据重新匹配',2,'B00301');
	end if;
    
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

