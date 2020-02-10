DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.81'; -- 本升级文件的版本，每个升级文件必须修改
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
	----20150204 huangjunyi  废旧物资竞拍 审核资质信息 导航栏调整 
	 num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M023530' and inurl ='/exp/auction/sell/tray/list.do#/exp/auction/sell/tray/toShowZzxx.do' ;   
     if num = 1 then
           update bs_qxsz t set inurl ='/exp/auction/sell/tray/list.do' where t.sid='M00004' and mkid='M023530' ;
     END IF;
     
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M023520' and inurl like '%/exp/auction/sell/tray/toShowZzxx.do%' ;   
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/exp/auction/sell/tray/toShowZzxx.do' where t.sid='M00004' and mkid='M023520' ;
     END IF;
     
     
     --20150205 songb 积分平台屏蔽抽奖记录菜单
	 update bs_qxsz t set isuse = 0 where t.sid = 'M00050' and t.mkid = 'M010025' ;

    ---- end

    --20150207  huangjunyi  竞价支付申请
	 num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M024010' and action ='/exp/auction/buy/bout' and method='toZfsq';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M024010' , '/exp/auction/buy/bout', 'toZfsq' , 2, '拍卖采购-支付申请页面', 1, 'M00004');
    END IF;
	 num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M024010' and action ='/exp/auction/buy/bout' and method='doZfsq';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M024010' , '/exp/auction/buy/bout', 'doZfsq' , 2, '拍卖采购-支付申请', 1, 'M00004');
    END IF;
	
	-- end

	-- 2015/02/04  wxd   更改保密协议权限
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and method='checkBmxy'  and mkid='M01050505' and  sid='M00201' ;      
		if num = 0 then
			update bs_qxmx set accesstag='1' where action='/exp/hangsource/buy/createbill' and method='checkBmxy'  and mkid='M01050505' and  sid='M00201' ;      
	  end if;
	    num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and method='viewBmxy'  and mkid='M01050505' and  sid='M00201' ;      
		if num = 0 then
			update bs_qxmx set accesstag='1' where action='/exp/hangsource/buy/createbill' and method='viewBmxy'  and mkid='M01050505' and  sid='M00201' ;      
	  end if;
	--- end ---

    --2015/02/09  huangjunyi 支付申请审核 
	 num:=0;
     select count(1) into num from bs_qxsz  where mkid='B012540' and sid='B00004' and mid='B0125';    
     if num = 0 then
        insert into bs_qxsz values ('B012540','B0125','竞价销售管理','支付申请审核','/exm/auction/bout/sfsq/list.do','/exm/auction/bout/sfsq/list.do',1,400,2,'','B00004');
   	 end if;
   	 
   	  num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B012540' and action ='/exm/auction/bout/sfsq' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B012540' , '/exm/auction/bout/sfsq', 'list' , 2, '支付申请审核：列表', 2, 'B00004');
       END IF;
       
      num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B012540' and action ='/exm/auction/bout/sfsq' and method='toVerifyPreview';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B012540' , '/exm/auction/bout/sfsq', 'toVerifyPreview' , 2, '支付申请审核页面', 2, 'B00004');
       END IF;
       
        num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B012540' and action ='/exm/auction/bout/sfsq' and method='doexamine';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B012540' , '/exm/auction/bout/sfsq', 'doexamine' , 2, '支付申请审核', 2, 'B00004');
       END IF;
    
    -- 2015/02/10	hanglong	更新菜单定位
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='B010505' and sid='B00201' and mid='B0105' and inurl is null;    
	if num = 1 then
		update bs_qxsz set inurl = '/exm/hangsource/hangadmin/doScjAndCkj.do#' where mkid='B010505' and sid='B00201' and mid='B0105' and inurl is null;
	end if;
	-- end
	
	-- 2015/02/12	hanglong	更新菜单定位
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/auction/sell/bout' and method='getSystemDateTime' and sid='M00004';
	if num = 1 then
		update bs_qxmx set mkid='0',accesstag=1 where action='/exp/auction/sell/bout' and method='getSystemDateTime' and sid='M00004';
	end if;
	-- end

	-- 2015/02/28	hanglong	更新菜单定位
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M011505' and sid='M00004' and mid='M0115' and inurl='/tdp/puc/req/index.do#/tdp/puc/req/toAdd.do#/tdp/puc/req/toEdit.do#/tdp/puc/req/toSubmit.do#/tdp/puc/req/view.do#/tdp/puc/req/getBrowseFile.do';    
	if num = 1 then
		update bs_qxsz set inurl = inurl || '#/tdp/puc/req/importFile.do' where mkid='M011505' and sid='M00004' and mid='M0115' and inurl='/tdp/puc/req/index.do#/tdp/puc/req/toAdd.do#/tdp/puc/req/toEdit.do#/tdp/puc/req/toSubmit.do#/tdp/puc/req/view.do#/tdp/puc/req/getBrowseFile.do';
	end if;
	-- end

	-- 2015/03/01	huangjunyi	初始库存维护菜单定位
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M037005' and sid='M00004' and mid='M0370' and inurl='/tdp/puc/pcrepertory/list.do#/tdp/puc/pcrepertory/toAdd.do';    
	if num = 1 then
		update bs_qxsz set inurl = inurl || '#/tdp/puc/pcrepertory/view.do' where mkid='M037005' and sid='M00004' and mid='M0370' and inurl='/tdp/puc/pcrepertory/list.do#/tdp/puc/pcrepertory/toAdd.do';
	end if;
	-- end
              
     --集团报表-新增合同汇总报表-左边列表--------suping start
      num:=0;
      select count(1) into num from bs_qxsz where mkid='M022595' and mid='M0225' and styp=1 and sid='M00004';
      if num=0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M022595','M0225','合同汇总报表','合同汇总报表','/tdp/trail/pccontract/listhz.do','/tdp/trail/pccontract/listhz.do',1,1200,1,'M00004');
      end if;

      --合同汇总报表
      num:=0;
       select count(1) into num from bs_qxmx where mkid='M022595' and  sid='M00004' and action = '/tdp/trail/pccontract' and  method='listhz';
      if num=0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M022595','/tdp/trail/pccontract','listhz',2,'合同汇总报表',1,'M00004');
      end if;
      
	  -----------suping end------------

	  ----------ajax 带出收款会员银行信息 wxd 2015/03/04---
	  num:=0;
	  select count(1) into num from bs_qxmx where mkid='0' and  sid='B00000' and action = '/admin/publicfun' and  method='menberBankInfo';
	  if num=0 then
	  	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
	  	values(bs_qxmx_0.nextval,'0','/admin/publicfun','menberBankInfo',1,'获取收款会员及银行信息',2,'B00000');
	  end if;
      --------end----

	---hejw start 2015/03/06-sc-
	--修改 权限模块名称 sc
	  num:=0;
	  select count(1) into num from bs_xtmk where sid='M00050' and mid='M0100' and mname='我的交易点' and styp=1;    
	  if num = 1 then
	    update bs_xtmk set mname='我的积分' where sid='M00050' and mid='M0100' and mname='我的交易点' and styp=1;
	  end if;
	
	
	--修改 权限设置 中，权限模块的名称  sc
      update bs_qxsz set mname='我的积分' where sid='M00050' and mid='M0100' and styp=1;
	
	  num:=0;
	  select count(1) into num from bs_qxsz where sid='M00050' and url='/scp/score/bdlist.do' and name='交易点管理';    
	  if num = 1 then
	    update bs_qxsz set name='积分明细' where sid='M00050' and url='/scp/score/bdlist.do' and name='交易点管理';
	  end if;

	---hejw--end-sc-

	--- 2015/03/10	hanglong	每日签到领取积分
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='doQd';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/scp/scoreshop','doQd',1,'每日签到领取积分',1,'M00050');
	end if;
	--- end ---

	--- 2015/03/10	hanglong	更新积分商城首页的访问权限
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='index' and accesstag = 0;
	if num=1 then
		update bs_qxmx set accesstag = 1 where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='index' and accesstag = 0;
	end if;
	--- end ---
	
	--- 2015/03/10	hanglong	更新积分商城列表页的访问权限
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='list' and accesstag = 0;
	if num=1 then
		update bs_qxmx set accesstag = 1 where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='list' and accesstag = 0;
	end if;
	--- end ---

	--- 2015/03/10	hanglong	更新积分商城礼品详情页的访问权限
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='info' and accesstag = 0;
	if num=1 then
		update bs_qxmx set accesstag = 1 where mkid='0' and sid='M00050' and action = '/scp/scoreshop' and  method='info' and accesstag = 0;
	end if;
	--- end ---

	--- 2015/03/10	hanglong	更新积分商城抽奖页面的访问权限
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/bonus' and  method='index' and accesstag = 0;
	if num=1 then
		update bs_qxmx set accesstag = 1 where mkid='0' and sid='M00050' and action = '/scp/bonus' and  method='index' and accesstag = 0;
	end if;
	--- end ---

	--- 2015/03/10	hanglong	更新积分商城抽奖方法的访问权限
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00050' and action = '/scp/bonus' and  method='roulette' and accesstag = 0;
	if num=1 then
		update bs_qxmx set accesstag = 1 where mkid='0' and sid='M00050' and action = '/scp/bonus' and  method='roulette' and accesstag = 0;
	end if;
	--- end ---

	--hejw 2015-3-10 积分规则信息 前台后台url访问权限 start
	  num:=0;
    select count(1) into num from bs_qxmx where action='/scp/scorerule' and  method='rule' and mkid='M010030' and  sid='M00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M010030','/scp/scorerule','rule',2,'积分规则',1,'M00050');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where sid='M00050' and mkid='M010030' and mid='M0100' and name='积分规则';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('M010030','M0100','我的积分','积分规则','/scp/scorerule/rule.do',1,500,1,'M00050');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00050' and mkid='B010040' and mid='B0100' and name='积分规则公告';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('B010040','B0100','积分管理','积分规则公告','/scm/basesetup/scrulemx/rule.do',1,101,2,'B00050');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where action='/scm/basesetup/scrulemx' and  method='rule' and mkid='B010040' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010040','/scm/basesetup/scrulemx','rule',2,'积分规则公告',2,'B00050');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/scm/basesetup/scrulemx' and  method='save' and mkid='B010040' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010040','/scm/basesetup/scrulemx','save',2,'积分规则公告-保存',2,'B00050');
    end if;
    
    ---end----

	 
          
      --积分平台-我的交易点改为积分查询--suping 2015-03-09  ---start
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M010005' and mid='M0100' and styp=1 and sid='M00050';
    if num=1 then
    update bs_qxsz set name='积分查询' where mkid='M010005' and mid='M0100' and styp=1 and sid='M00050';
    end if;
  
    --积分平台-兑换管理分开-兑换查询改为兑换记录
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M010010' and mid='M0100' and styp=1 and sid='M00050';
    if num=1 then
    update bs_qxsz set name='兑换记录' where mkid='M010010' and mid='M0100' and styp=1 and sid='M00050';
    end if;
    
    
    --积分平台-兑换管理分开-抽奖查询改为抽奖记录
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M010035' and mid='M0100' and styp=1 and sid='M00050';
    if num=0 then
      insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
      values('M010035','M0100','抽奖记录','抽奖记录','/scp/scoreshop/order/list.do','/scp/scoreshop/order/list.do',1,450,1,'M00050');
    end if;
    
   --抽奖记录列表--
     num:=0;
     select count(1) into num from bs_qxmx where mkid='M010035' and action='/scp/scoreshop/order'  and method='listcjjl' and  sid='M00050';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'M010035','/scp/scoreshop/order','listcjjl',0,'抽奖记录列表',1,'M00050');
    end if;
    ---end----------------------------------

	--- 2015/03/12	hanglong	获取会员下的所有操作员列表
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='B00050' and action = '/scm/scoreadd' and  method='getMbOpt';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/scm/scoreadd','getMbOpt',1,'获取会员下的所有操作员列表',2,'B00050');
	end if;
	--- end ---
	
	-- hejw 2012/3/12 
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and url='/exp/auction/buy/bout/list.do' and mid='M0240' and mkid='M024010' and inurl='/exp/auction/buy/bout/list.do';
    if num=1 then
        update bs_qxsz set inurl='/exp/auction/buy/bout/list.do#/exp/auction/buy/bout/toZzxx.do' where sid='M00004' and url='/exp/auction/buy/bout/list.do' and mid='M0240' and mkid='M024010' and inurl='/exp/auction/buy/bout/list.do';
    end if;
    -- end --

	--- 2015/03/13	hanglong	积分平台改为积分商城
	num:=0;
	select count(1) into num from bs_system where sid='M00050';
	if num=1 then
		update bs_system set sname = '积分商城' where sid='M00050';
	end if;
	
	num:=0;
	select count(1) into num from bs_system where sid='B00050';
	if num=1 then
		update bs_system set sname = '积分商城' where sid='B00050';
	end if;
	--- end ---

	--- 2015/03/17	hanglong	工业类商品列表
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/allthing' and  method='industryList';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/allthing','industryList',1,'工业类商品列表',1,'M00201');
	end if;
	--- end ---

	--- 2015/03/20	hanglong	查看客户对应的所有供应商的余额列表
	num:=0;
	select count(1) into num from bs_qxmx where mkid='B011505' and sid='B00301' and action = '/manager/subaccount/ye' and  method='supplierList';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'B011505','/manager/subaccount/ye','supplierList',2,'查看客户对应的所有供应商的余额列表',2,'B00301');
	end if;
	--- end ---

	--- 2015/03/20	hanglong	查看客户待支付订单列表
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='B00201' and action = '/exm/contract/shop/manage' and  method='noPayList';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/exm/contract/shop/manage','noPayList',1,'查看客户待支付订单列表',2,'B00201');
	end if;
	--- end ---

	----2015/03/23 wxd 商品自动入库功能（列表和操作以及菜单标亮）
	 num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='autoImportantList' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'autoImportantList' , 2, '自动入库列表', 1, 'M00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxsz where sid='M00201' and mkid='M019005' and inurl like '%#/exp/stock/goods/storage/delSplm.do#/exp/stock/goods/storage/delBat.do#/exp/stock/goods/storage/autoImportantList.do%' and styp='1';     
       if num = 0 then
             update bs_qxsz set inurl=inurl||'#/exp/stock/goods/storage/delSplm.do#/exp/stock/goods/storage/delBat.do#/exp/stock/goods/storage/autoImportantList.do'
             where  sid='M00201' and mkid='M019005' and styp='1';     
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='delBat' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'delBat' , 2, '批量删除自动入库的类目', 1, 'M00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='delSplm' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'delSplm' , 2, '删除自动入库的类目', 1, 'M00201');
    END IF;
    
    
    ---------end----
	
	--- 2015/03/24	hanglong	修改后台上架商品市场价和参考价维护的权限
	num:=0;
    select count(1) into num from bs_qxsz where mkid='B01050515' and mid='B0105' and styp=2 and sid='B00201';
    if num=0 then
      insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('B01050515','B0105','上架资源','市场价和参考价维护','','',2,200,2,'B010505','B00201');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where mkid='B010505' and sid='B00201' and action = '/exm/hangsource/hangadmin' and  method='doScjAndCkj';
	if num=1 then
		update bs_qxmx set mkid='B01050515' where mkid='B010505' and sid='B00201' and action = '/exm/hangsource/hangadmin' and  method='doScjAndCkj';
	end if;
    --- end ---
 --试用账号提交注册--suping 2015-03-19  ---start
     num:=0;
     select count(1) into num from bs_qxmx where mkid='0' and action='/bsp/supplier/reg'  and method='regsyzh' and  sid='M00000';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/bsp/supplier/reg','regsyzh',0,'试用账号提交注册',1,'M00000');
    end if;
     num:=0;
     select count(1) into num from bs_qxmx where mkid='B01000705' and action='/bsp/supplier/regaudit'  and method='agreesyzh' and  sid='B00000';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'B01000705','/bsp/supplier/regaudit','agreesyzh',1,'试用账号提交审核',2,'B00000');
    end if;
    --试用账号提交注册编辑--suping 2015-03-23  ---start
     num:=0;
     select count(1) into num from bs_qxmx where mkid='0' and action='/bsp/supplier/reg'  and method='regupdate' and  sid='M00000';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/bsp/supplier/reg','regupdate',0,'试用账号提交注册编辑',1,'M00000');
    end if;
    --end --------------------

	--- 2015/03/24	hanglong	我的超市功能的权限
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00201' and mid='M0120';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0120','我的超市',1,350,'M00201','201-1');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mid='M0120' and mkid='M012005';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('M012005','M0120','我的超市','商品管理','/exp/my/buy/manage/list.do','/exp/my/buy/manage/list.do#/exp/my/buy/manage/toAdd.do#/exp/my/buy/manage/category.do#/exp/my/buy/manage/doAdd.do#/exp/my/buy/manage/toDel.do#/exp/my/buy/manage/doDel.do',1,10,1,'','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='list';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','list',2,'商品管理-列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='toAdd';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','toAdd',2,'商品管理-进入添加选择列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='category';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','category',2,'商品管理-类目选择',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='getCategory';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','getCategory',2,'商品管理-类目选择',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='doAdd';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','doAdd',2,'商品管理-添加',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='toDel';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','toDel',2,'商品管理-进入删除页面',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012005' and sid='M00201' and action = '/exp/my/buy/manage' and  method='doDel';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012005','/exp/my/buy/manage','doDel',2,'商品管理-删除',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mid='M0120' and mkid='M012010';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('M012010','M0120','我的超市','超市设置','/exp/my/buy/set/toSet.do','/exp/my/buy/set/toSet.do#/exp/my/buy/set/doSet.do',1,20,1,'','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012010' and sid='M00201' and action = '/exp/my/buy/set' and  method='toSet';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012010','/exp/my/buy/set','toSet',2,'超市设置-设置页面',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M012010' and sid='M00201' and action = '/exp/my/buy/set' and  method='doSet';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'M012010','/exp/my/buy/set','doSet',2,'超市设置-设置',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='list';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/my/buy/index','list',1,'我的超市-消费类列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='industryList';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/my/buy/index','industryList',1,'我的超市-工业类列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='saveMy';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/my/buy/index','saveMy',1,'我的超市-商品加入我的超市',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='ajaxDlcode';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/my/buy/index','ajaxDlcode',1,'我的超市-获得我的超市商品大类代码',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/' and  method='personCenter';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/','personCenter',1,'网上超市首页-个人中心',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/' and  method='myAr';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/','myAr',1,'网上超市首页-我的超市',1,'M00201');
	end if;
	
	--- end ---

	-- 2015/04/09	hanglong	获得我的超市楼层列表的静态页面
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/' and  method='myShop' and mkid='0' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','myShop',1,'获得我的超市楼层列表的静态页面',1,'M00201');
    end if;
    --- end ---

	--积分平台-兑换管理分开-抽奖查询改为抽奖记录
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M010035' and mid='M0100' and styp=1 and sid='M00050';
    if num=1 then
    	update bs_qxsz set url='/scp/scoreshop/order/listcjjl.do',inurl='/scp/scoreshop/order/listcjjl.do' where mkid='M010035' and mid='M0100' and styp=1 and sid='M00050';
    end if;
    
	--抽奖记录列表--
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M010035' and action='/scp/scoreshop/order'  and method='listcjjl' and  sid='M00050';
    if num=1 then
    	update bs_qxmx set accesstag = 2 where mkid='M010035' and action='/scp/scoreshop/order'  and method='listcjjl' and  sid='M00050';
    end if;
	
	
	--- 2015/04/10	songb	积分平台-上架管理模块
	num:=0;
	select count(1) into num from bs_xtmk where sid='B00050' and mid='B0115';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid) values('B0115','上架管理',2,50,'B00050');
	end if;
	
	--上架管理-上架礼品--
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00050' and mid='B0115' and mkid='B011505';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B011505','B0115','上架管理','上架礼品','/scm/grounding/gift/list.do','/scm/grounding/gift/list.do',1,10,2,'','B00050');
	end if;
	
	--上架管理-上架查询--
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00050' and mid='B0115' and mkid='B011510';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid) 
		values('B011510','B0115','上架管理','上架查询','/scm/grounding/query/list.do','/scm/grounding/query/list.do',1,20,2,'','B00050');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='list' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','list',2,'上架礼品列表',2,'B00050');
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/query' and  method='list' and mkid='B011510' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011510','/scm/grounding/query','list',2,'上架礼品列表',2,'B00050');
    end if;
    --- end ---

	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='ajaxDlcode';
	if num=1 then
		update bs_qxmx set accesstag = 0 where mkid='0' and sid='M00201' and action = '/my/buy/index' and  method='ajaxDlcode';
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='doCpAll' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','doCpAll',2,'礼品下架',2,'B00050');
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='doAuditAll' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','doAuditAll',2,'礼品审核',2,'B00050');
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/query' and  method='export2Excel' and mkid='B011510' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011510','/scm/grounding/query','export2Excel',2,'导出上架礼品列表',2,'B00050');
    end if;
    
    
    	--hejw
	   num:=0;
    select count(1) into num from bs_xtmk where mid='M0195' and mname='礼品管理' and styp=1 and sid='M00201' and qxrole='201-2';
    if num=0 then
        insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole)
        values('M0195','礼品管理',1,'150','M00201','201-2');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where sid='M00201' and mkid='M019505' and mid='M0195' and name='新增礼品' and url='/exp/mygift/gift/toAdd.do';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('M019505','M0195','礼品管理','新增礼品','/exp/mygift/gift/toAdd.do',1,100,1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00201' and mkid='M019510' and mid='M0195' and name='礼品列表' and url='/exp/mygift/gift/list.do';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('M019510','M0195','礼品管理','礼品列表','/exp/mygift/gift/list.do',1,200,1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00201' and mkid='M019515' and mid='M0195' and name='兑换管理' and url='/exp/mygift/exchange/list.do';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('M019515','M0195','礼品管理','兑换管理','/exp/mygift/exchange/list.do',1,300,1,'M00201');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and  method='toAdd' and mkid='M019505' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019505','/exp/mygift/gift','toAdd',2,'新增礼品',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and  method='list' and mkid='M019510' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','list',2,'礼品列表',1,'M00201');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/exchange' and  method='list' and mkid='M019515' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019515','/exp/mygift/exchange','list',2,'兑换管理',1,'M00201');
    end if;  

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and  method='saveGift' and mkid='M019505' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019505','/exp/mygift/gift','saveGift',2,'新增礼品',1,'M00201');
    end if;
    
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='view' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','view',2,'礼品查看',2,'B00050');
    end if;
    
	--新增-在买家中心加我的积分--suping
	num:=0;
       select count(1) into num from bs_xtmk where mid='M0200' and sid='M00201';
    if num=0 then
       insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0200','我的积分',1,350,'M00201','201-1');
    end if;
  
  
     
   --新增-在买家中心-我的积分-积分查询
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M020005' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020005','M0200','积分查询','积分查询','/scp/scoreshop/order/index.do','/scp/scoreshop/order/index.do',1,100,1,'M00201');
	end if;

   --积分查询
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M020005' and  sid='M00201';
	if num=0 then
       insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M020005','/scp/scoreshop/order','index',2,'积分查询',1,'M00201');
    end if;
  
  
  
  --新增-在买家中心-我的积分-兑换记录
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M020010' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020010','M0200','兑换记录','兑换记录','/scp/scoreshop/order/listarjf.do','/scp/scoreshop/order/listarjf.do',1,150,1,'M00201');
	end if;

  --兑换记录
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M020010' and  sid='M00201';
	if num=0 then
       insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
       values(bs_qxmx_0.nextval,'M020010','/scp/scoreshop/order','listarjf',2,'兑换记录',1,'M00201');
    end if;
  
  --查看订单
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M02001005' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02001005','M0200','查看订单','查看订单','','',2,200,1,'M020010','M00201');
	end if;
  
  	num:=0;
    select count(1) into num from bs_qxmx where mkid='M02001005' and  sid='M00201';
	if num=0 then
       insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
       values(bs_qxmx_0.nextval,'M02001005','/scp/scoreshop/order','view',2,'查看订单',1,'M00201');
    end if;
  
    --查看礼品
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M02001010' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02001010','M0200','查看礼品','查看礼品','','',2,200,1,'M020010','M00201');
	end if;
  
  	num:=0;
    select count(1) into num from bs_qxmx where mkid='M02001010' and  sid='M00201';
	if num=0 then
         insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
         values(bs_qxmx_0.nextval,'M02001010','/scp/scoreshop/order','info',2,'查看礼品',1,'M00201');
    end if;
  
  
    --新增-在买家中心-我的积分-积分明细
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M020015' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020015','M0200','积分明细','积分明细','/scp/scoreshop/order/bdlist.do','/scp/scoreshop/order/bdlist.do',1,200,1,'M00201');
	end if;

  --积分明细
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M020015' and  sid='M00201';
	if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M020015','/scp/scoreshop/order','bdlist',2,'积分明细',1,'M00201');
    end if;
  
    --新增-在买家中心-我的积分-抽奖记录
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M020020' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020020','M0200','抽奖记录','抽奖记录','/scp/scoreshop/order/listcjjl.do','/scp/scoreshop/order/listcjjl.do',1,250,1,'M00201');
	end if;

  --抽奖记录
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M020020' and  sid='M00201';
	if num=0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'M020020','/scp/scoreshop/order','listcjjl',2,'抽奖记录',1,'M00201');
    end if;
  
  
      --新增-在买家中心-我的积分-积分规则
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M020025' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020025','M0200','积分规则','积分规则','/scp/scoreshop/order/rule.do','/scp/scoreshop/order/rule.do',1,300,1,'M00201');
	end if;

  --抽奖记录
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M020025' and  sid='M00201';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M020025','/scp/scoreshop/order','rule',2,'积分规则',1,'M00201');
    end if;
    
    -- 2015/04/15	songb	更新礼品管理菜单
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='B010505' and sid='B00050' and mid='B0105' and url = '/scm/scoreexchange/gift/list.do';    
	if num = 1 then
		update bs_qxsz set url = '/scm/scoreexchange/category/list.do',name = '礼品类目',inurl =inurl ||'#/scm/scoreexchange/category/list.do#/scm/scoreexchange/category/toAdd.do#/scm/scoreexchange/category/save.do#/scm/scoreexchange/category/toEdit.do#/scm/scoreexchange/category/update.do#/scm/scoreexchange/category/toDel.do' where mkid='B010505' and sid='B00050' and mid='B0105';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and method='save' and sid='B00050';
	if num = 1 then
		update bs_qxmx set mkid='B010505' where action='/scm/scoreexchange/category' and method='save' and sid='B00050';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and method='toAdd' and sid='B00050';
	if num = 1 then
		update bs_qxmx set mkid='B010505' where action='/scm/scoreexchange/category' and method='toAdd' and sid='B00050';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and method='toDel' and sid='B00050';
	if num = 1 then
		update bs_qxmx set mkid='B010505' where action='/scm/scoreexchange/category' and method='toDel' and sid='B00050';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and method='toEdit' and sid='B00050';
	if num = 1 then
		update bs_qxmx set mkid='B010505' where action='/scm/scoreexchange/category' and method='toEdit' and sid='B00050';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and method='update' and sid='B00050';
	if num = 1 then
		update bs_qxmx set mkid='B010505' where action='/scm/scoreexchange/category' and method='update' and sid='B00050';
	end if;
	-- end


   --hejw  doEdit   doSl   doDel  doCp    doGp  updateGift
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doEdit';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doEdit',2,'修改查看礼品',1,'M00201');
    end if;
    
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doSl';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doSl',2,'修改数量',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doDel';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doDel',2,'删除',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doCp';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doCp',2,'礼品下架',1,'M00201');
    end if;    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doGp';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doGp',2,'礼品上架',1,'M00201');
    end if;       
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='updateGift';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','updateGift',2,'修改礼品',1,'M00201');
    end if;     
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='info';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','info',2,'礼品-查看详情',1,'M00201');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='doDelAll';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','doDelAll',2,'礼品-批量删除',1,'M00201');
    end if;    
    
    num:=0;
    select count(1) into num from bs_qxsz where url='/exp/mygift/gift/list.do' and  sid='M00201' and mid='M0195' and mkid='M019510' and name='礼品列表' and inurl is null ;
    if num=1 then
        update bs_qxsz set inurl=concat(inurl,'/exp/mygift/gift/list.do#/exp/mygift/gift/info.do#/exp/mygift/gift/doEdit.do') where url='/exp/mygift/gift/list.do' and  sid='M00201' and mid='M0195' and mkid='M019510' and name='礼品列表' and inurl is null ;
    end if;  
	
    
    --兑换管理-发货 suping 2015/04/15 --start
 	num:=0;
  select count(1) into num from bs_qxsz where mkid='M01951505' and mid='M0195' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01951505','M0195','发货','发货','','',2,200,1,'M019515','M00201');
	end if;
  
  	num:=0;
   select count(1) into num from bs_qxmx where mkid='M01951505' and  sid='M00201';
	if num=0 then
  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01951505','/exp/mygift/exchange','doSend',2,'发货',1,'M00201');
  end if;
  
  --弹出发货详情
   	num:=0;
  select count(1) into num from bs_qxsz where mkid='M01951510' and mid='M0195' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01951510','M0195','弹出发货详情','弹出发货详情','','',2,200,1,'M019515','M00201');
	end if;
  
  num:=0;
   select count(1) into num  from bs_qxmx where mkid='M019515' and  sid='M00201' and method='toSend';
	if num=0 then
  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M019515','/exp/mygift/exchange','toSend',2,'弹出发货详情',1,'M00201');
  end if;
  ---------------------end
  
  --hejw 图片上传
     num:=0;
    select count(1) into num from bs_qxmx where action='/swfupload' and sid='M00201' and method='uploadGiftEditor';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/swfupload','uploadGiftEditor',1,'礼品-编辑器图片上传',1,'M00201');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/gift' and mkid='M019510' and  sid='M00201' and  method='showimg';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019510','/exp/mygift/gift','showimg',2,'查看礼品图片',1,'M00201');
    end if;  
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='doRecommendAll' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','doRecommendAll',2,'礼品推荐',2,'B00050');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/scm/grounding/gift' and  method='doUnRecommendAll' and mkid='B011505' and  sid='B00050';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011505','/scm/grounding/gift','doUnRecommendAll',2,'取消礼品推荐',2,'B00050');
    end if;
    
    
    num:=0;
	select count(1) into num from bs_qxsz  where mkid='B011505' and sid='B00050' and mid='B0115' and inurl='/scm/grounding/gift/list.do';    
	if num = 1 then
		update bs_qxsz set inurl = inurl || '#/scm/grounding/gift/doRecommendAll.do#/scm/grounding/gift/doUnRecommendAll.do' where mkid='B011505' and sid='B00050' and mid='B0115' and inurl='/scm/grounding/gift/list.do';
	end if;
  
  --收货确认
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M02001020' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02001020','M0200','收货确认','收货确认','','',2,200,1,'M020010','M00201');
	end if;
  
  	num:=0;
    select count(1) into num from bs_qxmx where mkid='M02001020' and  sid='M00201';
	if num=0 then
	    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'M02001020','/scp/scoreshop/order','confirmGift',2,'收货确认',1,'M00201');
    end if;
  
    --发货详情
 	num:=0;
    select count(1) into num from bs_qxsz where mkid='M02001030' and mid='M0200' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02001030','M0200','发货详情','发货详情','','',2,200,1,'M020010','M00201');
	end if;
  
  	num:=0;
    select count(1) into num from bs_qxmx where mkid='M02001030' and  sid='M00201';
	if num=0 then
         insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
         values(bs_qxmx_0.nextval,'M02001030','/scp/scoreshop/order','viewFhd',2,'发货详情',1,'M00201');
    end if;
    --end --------------------


   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and sid='M00004' and mkid='M03200505' and method='checkShno3';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M03200505','/exp/td/supplier/manager','checkShno3',2,'JSON组织代码检查',1,'M00004');
    end if;
    
    --hejw 权限 礼品兑换  查看
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/exchange' and method='toSend' and sid='M00201' and mkid='M01951510';
    if num=1 then
        update bs_qxmx set mkid='M019515' where action='/exp/mygift/exchange' and method='toSend' and sid='M00201' and mkid='M01951510';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M01951510' and mid='M0195' and styp=1 and sid='M00201';
    if num=1 then
        delete bs_qxsz where mkid='M01951510' and mid='M0195' and styp=1 and sid='M00201';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and action='/public/item' and method='getPzList'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/public/item','getPzList',1,' 获取品种列表',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and action='/public/item' and method='getDlList'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/public/item','getDlList',1,' 获取（大类）列表',1,'M00201');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and action='/public/item' and method='hasChild'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/public/item','hasChild',1,' 品种下是否有子类',1,'M00201');
    end if;
    
    ---	2015/04/27	再次购买功能	hanglong	---
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and mkid='0' and action='/exp/contract/buy/manage' and method='againBuy'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/contract/buy/manage','againBuy',1,'再次购买',1,'M00201');
    end if;
    --- end ---

   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/mygift/exchange' and  method='view' and mkid='M019515' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M019515','/exp/mygift/exchange','view',2,'查看详情',1,'M00201');
    end if;
    
    ---	2015/05/04	亿美短信注册服务	hanglong	---
	num:=0;
    select count(1) into num from bs_qxmx where sid='B00002' and mkid='0' and action='/smsm/sms/service/setup' and method='registEx'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/smsm/sms/service/setup','registEx',1,'亿美短信注册服务',2,'B00002');
    end if;
    --- end ---


	-- hejw  公共账户明细-编辑失败理由
	num:=0;
    select count(1) into num from bs_qxmx where action='/manager/common/account/mx' and  method='toReasons' and mkid='B01201005' and  sid='B00301';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01201005','/manager/common/account/mx','toReasons',2,'公共账户明细-编辑失败理由页面',2,'B00301');
    end if;
 
	num:=0; 
    select count(1) into num from bs_qxmx where action='/manager/common/account/mx' and  method='doReasons' and mkid='B01201005' and  sid='B00301';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01201005','/manager/common/account/mx','doReasons',2,'公共账户明细-保存失败理由',2,'B00301');
    end if;
    
    
    --hejw 积分后台   礼品类目 移到 基础设置下面
	num:=0;
    select count(1) into num from  bs_qxsz where sid='B00050' and url='/scm/scoreexchange/category/list.do' and mkid='B010505' and mid='B0105' and mname='积分兑换';
    if num=1 then
        update bs_qxsz set mkid='B019020',mid='B0190',mname='基础设置' where sid='B00050' and url='/scm/scoreexchange/category/list.do' and mkid='B010505' and mid='B0105' and mname='积分兑换';
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/scm/scoreexchange/category' and sid='B00050' and mkid='B010505' and method in('list','save','toAdd','toDel','toEdit','update');
    if num!=0 then
        update bs_qxmx set mkid='B019020' where action='/scm/scoreexchange/category' and sid='B00050' and mkid='B010505' and method in('list','save','toAdd','toDel','toEdit','update');
    end if; 
    --end
  --试用账号编辑 -后台    suping 2015-05-07  ---start
  
      num:=0;
       select count(1) into num from bs_qxmx where action='/bsm/menber/manager' and  method='updatesyzhht' and styp=2  and  sid='B00000';
      if num=0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'0','/bsm/menber/manager','updatesyzhht',1,'试用账号编辑',2,'B00000');
      end if;
  --end

	--hejw    广告位权限
	num:=0;
    select count(1) into num from bs_qxsz where sid='B00050' and mkid='B019025' and mid='B0190' and name='广告位设置';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('B019025','B0190','基础设置','广告位设置','/scm/advert/manager/list.do',1,150,2,'B00050');
    end if;

	  num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='list' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','list',2,'广告列表',2,'B00050');
    end if;

	  num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='toAdd' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','toAdd',2,'广告新增页面',2,'B00050');
    end if;

	  num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='save' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','save',2,'广告保存',2,'B00050');
    end if;
    
	  num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='toEdit' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','toEdit',2,'广告修改页面',2,'B00050');
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='update' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','update',2,'广告修改',2,'B00050');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='toDel' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','toDel',2,'广告删除',2,'B00050');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/scm/advert/manager' and  method='show' and mkid='B019025' and  sid='B00050';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B019025','/scm/advert/manager','show',2,'广告查看',2,'B00050');
    end if;
    -- end --

	---	2015/05/11	个人会员验证手机号和邮箱是否重复AJAX	hanglong	---
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00000' and mkid='0' and action='/bsp/menber/reg' and method='checkMbMobileByPerson'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/reg','checkMbMobileByPerson',0,'个人会员验证手机号是否重复AJAX',1,'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid='M00000' and mkid='0' and action='/bsp/menber/reg' and method='checkMbEmailByPerson'; 
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/reg','checkMbEmailByPerson',0,'个人会员验证邮箱是否重复AJAX',1,'M00000');
    end if;
    --- end ---
	
	--- 2015/05/12	是否需要显示我的超市按钮（不显示就显示历史浏览）	hanglong	---
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/' and  method='isShowMy';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,'0','/','isShowMy',1,'是否需要显示我的超市按钮（不显示就显示历史浏览）',1,'M00201');
	end if;
	
	---	end	---
	
	--- 2015/05/14	易宝支付回调处理EC业务地址	zhangzhimeng	---
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and sid='M00201' and action = '/exp/contract/buy/manage' and  method='payCallback';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/contract/buy/manage','payCallback',0,'合同管理-B2C网银支付回调',1,'M00201');
	end if;
	---	end	---

	--hejw 增加图片库
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='picture' and mkid='M01102005' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01102005','/exp/hangsource/sell/publish','picture',2,'资源发布（卖）：图片库',1,'M00201');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='dodel' and mkid='M01102005' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01102005','/exp/hangsource/sell/publish','dodel',2,'资源发布（卖）：图片删除',1,'M00201');
    end if;
    -- end --




    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
