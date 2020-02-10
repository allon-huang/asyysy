DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.61'; -- 本升级文件的版本，每个升级文件必须修改
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

	update bs_xtmk set mname='产品管理' where  mname='采购定额管理' and mid='M0265' and sid='M00004';
	update bs_xtmk set mname='排产计划管理' where  mname='产量管理' and mid='M0270' and sid='M00004';
	
	update bs_qxsz set mname='产品管理',name='产品' where mkid='M026505' and mid='M0265' and sid='M00004';
	update bs_qxsz set mname='产品管理',name='一级零部件' where mkid='M026510' and mid='M0265' and sid='M00004';
	update bs_qxsz set mname='产品管理',name='二级零部件' where mkid='M026515' and mid='M0265' and sid='M00004';
	
	
	update bs_qxsz set mname='排产计划管理',name='排产计划' where mkid='M027005' and mid='M0270' and sid='M00004';
	update bs_qxsz set mname='排产计划管理',orderno='600' where mkid='M027010' and mid='M0270' and sid='M00004';
	update bs_qxsz set mname='排产计划管理',name='排产计划需求',isuse=1,url='/exp/output/planmx/list.do',inurl='/exp/output/planmx/list.do' where mkid='M027015' and mid='M0270' and sid='M00004';
	update bs_qxsz set mname='排产计划管理',orderno='700' where mkid='M027020' and mid='M0270' and sid='M00004';
	
	update bs_qxsz set isuse=0 where mkid='M027510' and mid='M0275' and name='生产进度查询' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M027515' and mid='M0275' and name='理论订货模型' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M027505' and mid='M0275' and name='订货卡' and sid='M00004';
	update bs_qxsz set isuse=0 where mkid='M027520' and mid='M0275' and name='订货台账' and sid='M00004';
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/planmx' and method='list' and styp=1 and mkid='M027015' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027015','/exp/output/planmx','list',2,'排产计划需求明细列表',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='updateMxStatus' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027005','/exp/output/mplan','updateMxStatus',2,'修改排产计划明细状态',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/mplan' and method='checkPcbh' and styp=1 and mkid='M027005' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027005','/exp/output/mplan','checkPcbh',2,'检查排产编号是否重复',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/planmx' and method='seeProductTree' and styp=1 and mkid='M027015' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027015','/exp/output/planmx','seeProductTree',1,'产品信息树显示',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/fixed' and method='cpList' and styp=1 and mkid='0' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0','/exp/stock/fixed','cpList',1,'产品列表选择窗口',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/public/item' and method='queryLjCodeList' and styp=1 and mkid='0' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0','/public/item','queryLjCodeList',1,'获取一级零部件列表AJAX',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/publicfun' and method='menberByNoSign' and styp=2 and mkid='0' and sid='B00000';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0','/admin/publicfun','menberByNoSign',1,'会员管理-查询会员列表(未签约)',2,'B00000');
	end if;

	
	update bs_xtmk set mname='结算账户' where mid='B0115' and mname='交易账户' and sid='B00301';
	update bs_qxsz set name='结算账户' where  mid='B0115' and mkid='B011515' and sid='B00301';
	update bs_qxsz set name='结算账户余额' where  mid='B0115' and mkid='B011505' and sid='B00301';
	update bs_qxsz set name='结算账户流水' where  mid='B0115' and mkid='B011520' and sid='B00301';

	num :=0;
	select count(1) into num from bs_qxsz where mname = '排产计划管理' and name = '采购需求明细' and isuse = 1 and styp = 1 and sid = 'M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) values('M027025','M0270','排产计划管理','采购需求明细','/exp/output/purchase/list.do','/exp/output/purchase/list.do',1,550,1,'','M00004');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/output/purchase' and method='list' and styp=1 and mkid='M027025' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027025','/exp/output/purchase','list',2,'采购需求明细列表',1,'M00004');
	end if;
	
	-- 2014/06/12 hanglong	取消订单 
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='refuseRequest' and mkid='M01081020' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M01081020','/exp/contract/buy/manage','refuseRequest',1,'取消订单申请',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='previewRefuse' and mkid='M01081020' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M01081020','/exp/contract/buy/manage','previewRefuse',1,'查看拒绝取消订单理由',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='toRefuse' and mkid='M01122050' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M01122050','/exp/contract/sell/manage','toRefuse',2,'进入确认是否取消订单页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='refuse' and mkid='M01122050' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M01122050','/exp/contract/sell/manage','refuse',2,'同意取消订单申请',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/sell/manage' and method='noRefuse' and mkid='M01122050' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M01122050','/exp/contract/sell/manage','noRefuse',2,'拒绝取消订单申请',1,'M00201');
	end if;

	update bs_xtmk set mname='采购管理' where  mname='订货分析管理' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购管理' where mkid='M027510' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购管理' where mkid='M027515' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购管理' where mkid='M027505' and mid='M0275' and sid='M00004';
	update bs_qxsz set mname='采购管理' where mkid='M027520' and mid='M0275' and sid='M00004';

	num :=0;
	select count(1) into num from bs_qxsz where mname = '采购管理' and name = '采购计划' and isuse = 1 and styp = 1 and sid = 'M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) values('M027525','M0275','采购计划','采购计划','/exp/orders/procurement/list.do','/exp/orders/procurement/list.do',1,500,1,'','M00004');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='list' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','list',2,'采购计划列表',1,'M00004');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/public/item' and method='getMarkRate' and styp=1 and mkid='0' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/public/item','getMarkRate',1,'评分查看',1,'M00201');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='toEditChild' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','toEditChild',1,'编辑采购计划',1,'M00004');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/orders/procurement' and method='toDelChild' and styp=1 and mkid='M027525' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M027525','/exp/orders/procurement','toDelChild',1,'删除采购计划',1,'M00004');
	end if;
	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

