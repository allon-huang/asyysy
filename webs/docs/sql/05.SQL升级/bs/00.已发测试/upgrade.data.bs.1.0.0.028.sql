DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.28'; -- 本升级文件的版本，每个升级文件必须修改
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
    
  -- dl 2014-03-24 增加退货权限 start

  num := 0; 
  select count(1) into num from bs_xtmk where mid='M0165' and styp=1 and sid='M00201';
     if num=0 then
     insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
     values('M0165','采购客户服务','1','400','M00201','201-1');
  end if;


  num := 0; 
  select count(1) into num from bs_qxsz where mkid='M016505' and mid='M0165' and sid='M00201';
     if num=0 then
     insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
     values('M016505','M0165','客户服务','换货/退货','/exp/contract/buy/manage/return/list.do','/exp/contract/buy/manage/return/list.do#/exp/contract/buy/manage/return/listContract.do#/exp/contract/buy/manage/return/toApplication.do#/exp/contract/buy/manage/return/toInfo.do',1,100,1,'','M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='list' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','list',2,'退货列表',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='toApplication' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','toApplication',2,'退货申请',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='toInfo' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','toInfo',2,'退货详情',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='toConfirm' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','toConfirm',2,'退货确认',1,'M00201');
  end if;

   num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='doInvalid' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','doInvalid',2,'退货作废',1,'M00201');
  end if;
 num := 0;
  select count(1) into num from bs_qxmx where mkid='M016505' and action='/exp/contract/buy/manage/return' and method='listContract' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M016505','/exp/contract/buy/manage/return','listContract',2,'待退货合同列表',1,'M00201');
  end if;


  num := 0; 
  select count(1) into num from bs_xtmk where mid='M0170' and styp=1 and sid='M00201';
     if num=0 then
     insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
     values('M0170','销售客户服务','1','500','M00201','201-2');
  end if;

  num := 0; 
  select count(1) into num from bs_qxsz where mkid='M017005' and mid='M0170' and sid='M00201';
     if num=0 then
     insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
     values('M017005','M0170','客户服务','换货/退货','/exp/contract/sell/manage/return/list.do','/exp/contract/sell/manage/return/list.do#/exp/contract/sell/manage/return/toInfo.do#',1,100,1,'','M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M017005' and action='/exp/contract/sell/manage/return' and method='list' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M017005','/exp/contract/sell/manage/return','list',2,'退货管理列表',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M017005' and action='/exp/contract/sell/manage/return' and method='toInfo' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M017005','/exp/contract/sell/manage/return','toInfo',2,'退货详情',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M017005' and action='/exp/contract/sell/manage/return' and method='toConfirm' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M017005','/exp/contract/sell/manage/return','toConfirm',2,'退货确认',1,'M00201');
  end if;

  -- 增加退货权限 end

	-- 2014/03/26 hangl 增加购物清单权限
	num := 0; 
	select count(1) into num from bs_qxmx where mkid='M011220' and action='/exp/contract/sell/manage' and method='shoppingList' and sid='M00201';
	    if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('M011220','/exp/contract/sell/manage','shoppingList', 2,'购物清单',1,'M00201');
	end if;

  -- zhminfu 2014-03-26 增加加价幅度加载权限 start
  num := 0;
  select count(1) into num from bs_qxmx where mkid='0' and action='/exp/hangsource/buy/shopping' and method='showMargin' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/exp/hangsource/buy/shopping','showMargin',1,'修改加价幅度弹出框',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where mkid='0' and action='/exp/hangsource/buy/shopping' and method='updateMargin' and sid='M00201';
    if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/exp/hangsource/buy/shopping','updateMargin',1,'修改套餐类型加价幅度',1,'M00201');
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where action='/tonyong' and method='execute' and sid='M00201';
  if num = 1 then
	update bs_qxmx set accesstag = 1 where action='/tonyong' and method='execute' and sid='M00201';
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where action='/dingzhi' and method='execute' and sid='M00201';
  if num = 1 then
	update bs_qxmx set accesstag = 1 where action='/dingzhi' and method='execute' and sid='M00201';
  end if;
  
  num := 0;
  select count(1) into num from bs_qxmx where action='/' and method='index' and sid='M00201';
  if num = 1 then
	update bs_qxmx set accesstag = 1 where action='/' and method='index' and sid='M00201';
  end if;
  
  -- zhminfu 2014-03-26 增加加价幅度加载权限 end
  
  -- add by xue on 2014-03-27 for 增加中信银行管理平台
	num :=0;
	select count(1) into num from bs_system where sid='M00301' ;
	if num=0 then
		insert into bs_system(sid, sname, shortname, styp, homepage, orderno, url00, url01, url02, url03, url04)
		values('M00301','中信银行平台','中信',1,'/me/home/index.do',200,'http://eci.td.dev.steel56.com.cn/ecibkplatform','/login/index.do','/auth/noAuth.do','/login/doLogout.do','_eciBkSystem');
	end if;
	
	num :=0;
	select count(1) into num from bs_system where sid='B00301' ;
	if num=0 then
		insert into bs_system(sid, sname, shortname, styp, homepage, orderno, url00, url01, url02, url03, url04)
		values('B00301','中信银行平台','中信',2,'/admin/index.do',200,'http://eci.td.dev.steel56.com.cn/ecibkmanager','/admin/login/index.do','/admin/noAuth.do','/admin/login/doLogout.do','_eciBkSystem');
	end if;
   --end
   
   -- add by xue on 2014-03-27 for 增加中信银行平台默认权限
  	num :=0;
	select count(1) into num from bs_qxmx where sid='B00301' and action='/admin' and method='index' ;
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('0','/admin','index',1,'后台管理界面',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where sid='B00301' and action='/admin' and method='menu' ;
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('0','/admin','menu',1,'模块左侧',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where sid='B00301' and action='/admin' and method='menu' ;
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('0','/admin','menu',1,'模块左侧',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where sid='B00301' and action='/admin' and method='navagation' ;
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('0','/admin','navagation',1,'后台抬头',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where sid='B00301' and action='/admin' and method='ywtx' ;
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('0','/admin','ywtx',1,'后台业务提醒页面',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_xtmk where mid='B0140' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_xtmk(mid, mname, styp, ordby, sid)
		values('B0140','基本设置', 2, 500, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B014015' and mid='B0140' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, isuse, orderno, styp, sid)
		values('B014015','B0140','基本设置','交易参数设置', '/admin/basesetup/cssz/index.do', 1, 500, 2, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401505' and mid='B0140' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('B01401505','B0140','基本设置','编辑', 2, 500, 2, 'B014015','B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/cssz' and method='index' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B014015','/admin/basesetup/cssz','index',2,'参数设置',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/cssz' and method='update' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01401505','/admin/basesetup/cssz','update',2,'修改参数设置',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_xtmk where mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_xtmk(mid, mname, styp, ordby, sid)
		values('B0105','账户管理', 2, 100, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B010505' and mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, isuse, orderno, styp, sid)
		values('B010505','B0105','账户管理','账户签约', '/ecim/account/info/manage/list.do', 1, 100, 2, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01050505' and mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('B01050505','B0105','账户管理','编辑', 2, 500, 2, 'B010505','B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='list' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B010505','/ecim/account/info/manage','list',2,'中信银行账户签约信息查询',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='toAdd' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01050505','/ecim/account/info/manage','toAdd',2,'跳转到账户签约新增界面',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='toEdit' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01050505','/ecim/account/info/manage','toEdit',2,'跳转到账户签约编辑界面',2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='save' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B01050505','/ecim/account/info/manage','save',2,'保存账户签约信息',2,'B00301');
	end if;
	
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B010515' and mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, isuse, orderno, styp, sid)
		values('B010515','B0105','账户管理','账户签约审核', '/ecim/account/audit/manage/list.do', 1, 150, 2, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01051505' and mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('B01051505','B0105','账户管理','审核', 2, 600, 2, 'B010515','B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B010525' and mid='B0105' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, isuse, orderno, styp, sid)
		values('B010525','B0105','账户管理','账户签约查询', '', 1, 200, 2, 'B00301');
	end if;
   -- end
   
	
	-- 2014/03/27 hangl 增加支付申请权限 start
	update bs_qxsz set inurl='/exp/contract/buy/manage/list.do#/exp/contract/buy/manage/toRefuse.do#/exp/contract/buy/manage/toConfirm.do#/exp/contract/buy/manage/addPayRequest.do#/exp/contract/buy/manage/toAddPayRequest.do#' where sid='M00201' and mkid='M010810';
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01081030' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01081030','M0108','采购订单','新增支付申请', 2, 340, 1, 'M010810','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='toAddPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01081030','/exp/contract/buy/manage','toAddPayRequest',2,'进入新增支付申请页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='addPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01081030','/exp/contract/buy/manage','addPayRequest',2,'新增支付申请',1,'M00201');
	end if;
	
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M010825' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url,inurl, isuse, orderno, styp, sid)
		values('M010825','M0108','采购订单','支付申请单', '/exp/contract/buy/payRequest/payRequestList.do', '/exp/contract/buy/payRequest/payRequestList.do#/exp/contract/buy/payRequest/editPayRequest.do#/exp/contract/buy/payRequest/toEditPayRequest.do#', 1, 500, 1,'M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='payRequestList' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M010825','/exp/contract/buy/payRequest','payRequestList',2,'支付申请列表',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='preview' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M010825','/exp/contract/buy/payRequest','preview',2,'查看支付申请单',1,'M00201');
	end if;
	
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01082505' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01082505','M0108','采购订单','编辑', 2, 510, 1, 'M010825','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='toEditPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01082505','/exp/contract/buy/payRequest','toEditPayRequest',2,'进入编辑支付申请页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='editPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01082505','/exp/contract/buy/payRequest','editPayRequest',2,'编辑支付申请',1,'M00201');
	end if;
	
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01082510' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01082510','M0108','采购订单','作废', 2, 510, 1, 'M010825','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='invalidPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01082510','/exp/contract/buy/payRequest','invalidPayRequest',2,'作废支付申请',1,'M00201');
	end if;
	
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01082515' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01082515','M0108','采购订单','打印', 2, 510, 1, 'M010825','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='printPayRequest' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01082515','/exp/contract/buy/payRequest','printPayRequest',2,'打印支付申请',1,'M00201');
	end if;
	
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01082520' and mid='M0108' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01082520','M0108','采购订单','付款', 2, 515, 1, 'M010825','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/payRequest' and method='payEcZfsqd' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01082520','/exp/contract/buy/payRequest','payEcZfsqd',2,'付款支付申请',1,'M00201');
	end if;
	
	-- end
	

         
	 num := 0;
	select count(1) into num from bs_qxsz where mkid='B01000135' and mid='B0100' and styp=2 and sid='B00000';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('B01000135','B0100','会员管理','导入', 2, 110, 2, 'B010001','B00000');
	end if; 

	 num := 0;
	  select count(1) into num from bs_qxmx where mkid='B01000135' and action='/bsm/menber/query' and method='importFile' and sid='B00000';
	    if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B01000135','/bsm/menber/query','importFile',2,'导入',2,'B00000');
	  end if;



	   num := 0;
	select count(1) into num from bs_qxsz where mkid='B01051010' and mid='B0105' and styp=2 and sid='B00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('B01051010','B0105','上架管理','导入', 2, 110, 2, 'B010510','B00201');
	end if; 

	 num := 0;
	  select count(1) into num from bs_qxmx where mkid='B01051010' and action='/exm/hangsource/hangquery' and method='importFile' and sid='B00201';
	    if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B01051010','/exm/hangsource/hangquery','importFile',2,'导入',2,'B00201');
	  end if;

	 update bs_xtmk set sid='B00201' where mid='B0145';
	 update bs_qxsz set sid='B00201' where sid='B00101' and mname='结算管理' and mkid like 'B014505%';
	 update bs_qxsz set isuse='0' where mkid='B01450510' and mname='结算管理' and sid='B00201';
	 update bs_qxmx set sid='B00201' where action='/exm/settle/contract/manage';
	  num := 0;
	  select count(1) into num from bs_qxmx where mkid='B01450505' and action='/exm/settle/contract/manage' and method='doEciticbank' and sid='B00201';
	    if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B01450505','/exm/settle/contract/manage','doEciticbank',2,'银行回调处理',2,'B00201');
	  end if;
	  
	  --自营配送权限
	update bs_qxsz set inurl='/exp/entrust/sell/manage/list.do#/exp/entrust/sell/manage/toEntrustSave.do#/exp/entrust/sell/manage/doEntrustSave.do#/exp/entrust/sell/manage/doDelete.do#' where sid='M00201' and mkid='M011225';
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01122510' and mid='M0112' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
		values('M01122510','M0112','销售订单','物流跟踪维护', 2, 410, 1, 'M011225','M00201');
	end if; 
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/entrust/sell/manage' and method='toEntrustSave' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01122510','/exp/entrust/sell/manage','toEntrustSave',2,'进入物流跟踪维护页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/entrust/sell/manage' and method='doEntrustSave' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01122510','/exp/entrust/sell/manage','doEntrustSave',2,'保存物流跟踪维护',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/entrust/sell/manage' and method='doDelete' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('M01122510','/exp/entrust/sell/manage','doDelete',2,'删除物流跟踪维护',1,'M00201');
	end if;
	-- end
	
	--add by xue on 20140402 for 增加资金账户查询
	
	num :=0;
	select count(1) into num from bs_xtmk where mid='B0115' and sid='B00301';
	if num=0 then
		insert into bs_xtmk(mid, mname, styp, ordby, sid)
		values('B0115','资金账户','2',150, 'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B011505' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid)
		values('B011505','B0115','资金账户','资金账户余额','','',1,100,2,'B00301');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B011515' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid)
		values('B011515','B0115','资金账户','资金账户明细','','',1,150,2,'B00301');
	end if;
	 
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  