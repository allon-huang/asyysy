DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.83'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	-- 权限明细-下载专家评审意见
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/common' and METHOD ='downloadReview' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/querybusiness/common','downloadReview',0,'下载专家评审意见',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/manager' and METHOD ='downloadReview' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exm/querybusiness/manager','downloadReview',1,'下载专家评审意见',2,'B00004');
	end if;
	
	--ar 业务提醒
    num:=0;
    select count(1) into num from bs_qxmx where action='/admin' and  method='ywtxAjax' and mkid='0' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/admin','ywtxAjax',1,'业务提醒ajax',2,'B00201');
    end if;
	
    --发布方和报价方都可以上传
	update bs_qxmx set accesstag=1 where action='/exp/tdcontract/sell/trail' and mkid='M025010' and sid='M00004' and method='uploadWts';

    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='synTdMbInfo' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','synTdMbInfo',2,'同步会员维护的定向会员信息',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusinesslaw/buy' and METHOD ='synTdMbInfo' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01701505','/exp/querybusinesslaw/buy','synTdMbInfo',2,'同步会员维护的定向会员信息',1,'M00004');
	end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/chatlog' and  method='upRead' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/chatlog','upRead',1,'修改消息为已读',1,'M00201');
    end if;
    
    --判断APP版本是否需要更新
    num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/exp/chatlog' and method='appVersion' and mkid='0';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/chatlog', 'appVersion', '0', '获取手机版本号', '1', 'M00201');
    end if;
    
      --添加qxmx（废旧物资审核页面点击场次号码查看的方法showTd）
    num:=0;
    select count(1) into num from bs_qxmx where sid='B00004' and styp=2 and action='/exm/auction/bout/verify' and method='showTd' and mkid='B012510';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B012510', '/exm/auction/bout/verify', 'showTd', '2', '拍卖申请审核：查看', '2', 'B00004');
    end if;
    
    --手机支付完成跳转
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and  method='payback' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/contract/buy/manage','payback',0,'手机支付完成跳转',1,'M00201');
    end if;
    
    update bs_qxmx set accesstag=0 where action='/exp/contract/yeepay' and method='payCallback' and sid='M00201' ;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='dxOpt' and mkid='M017015' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M017015','/exp/querybusinesslaw/buy','dxOpt',1,'定向操作员',1,'M00004');
    end if;
    
    	--bs 法务询价 定向维护会员里面点击会员查看会员信息
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='showHy' and mkid='M01701505' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01701505','/exp/querybusinesslaw/buy','showHy',2,'会员维护页面会员信息',1,'M00004');
    end if;
    
    --后台维护商品属性权限
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00201' and mkid='B01400515' and mid='B0140' and name='维护商品属性';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('B01400515','B0140','基本设置','维护商品属性',2,110,2,'B014005','B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='list' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','list',2,'商品属性-列表',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='toAdd' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','toAdd',2,'商品属性-新增页面',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='save' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','save',2,'商品属性-新增',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='toEdit' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','toEdit',2,'商品属性-修改页面',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='update' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','update',2,'商品属性-修改',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/itemattr' and  method='delete' and mkid='B01400515' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400515','/exm/basesetup/itemattr','delete',2,'商品属性-删除',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/setpzChild' and  method='toEdit' and mkid='B01400510' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400510','/exm/basesetup/setpzChild','toEdit',2,'修改品种子类页面',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/basesetup/setpzChild' and  method='renew' and mkid='B01400510' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01400510','/exm/basesetup/setpzChild','renew',2,'更改品种子类',2,'B00201');
    end if;
    
    --网超后台权限更改
    num:=0;
    select count(1) into num from bs_xtmk where mid='B0150' and  mname='APP管理' and  sid='B00201';
    if num=0 then
        insert into bs_xtmk (mid,mname,styp,ordby,sid)
        values('B0150','APP管理',2,550,'B00201'); 
    end if;
    
    update bs_qxsz set mkid='B015005',mid='B0150' where mkid='B013530' and sid='B00201' and name='APP推送消息';
    update bs_qxsz set mkid='B015010',mid='B0150' where mkid='B013535' and sid='B00201' and name='APP广告位';
    update bs_qxsz set mkid='B015015',mid='B0150' where mkid='B013520' and sid='B00201' and name='信息发布';
    update bs_qxsz set mkid='B01501505',mid='B0150',parent='B015015' where mkid='B01352005' and sid='B00201' and name='编辑';
    
    update bs_qxmx set mkid='B01501505' where mkid='B01352005' and sid='B00201' and action='/exm/msg/publish';
    update bs_qxmx set mkid='B015015' where mkid='B013520' and sid='B00201' and action='/exm/msg/publish';
    update bs_qxmx set mkid='B015005' where mkid='B013530' and sid='B00201' and action='/exm/push/message';
    update bs_qxmx set mkid='B015010' where mkid='B013535' and sid='B00201' and action='/exm/push/advert';
    
    
  	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='showPriceType' and mkid='M018015' and  sid='M00004';
    if num=0 then
      insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
      values ('M018015', '/exp/querybusiness/processlaw/sell', 'showPriceType', 2, '查看报价方案', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='showPriceType' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusiness/processlaw/buy', 'showPriceType', 2, '查看报价方案', 1, 'M00004');
    end if;
    
    --会员信息完善
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/finish' and  method='info' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/bsp/menber/finish', 'info', 1, '进入会员完善信息页面', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/finish' and  method='save' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/bsp/menber/finish', 'save', 1, '保存会员完善信息', 1, 'M00000');
    end if;
    
    -- 平台管理员证明模板下载
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/finish' and  method='downloadTmp' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/bsp/menber/finish', 'downloadTmp', 0, '平台管理员证明模板下载', 1, 'M00000');
    end if;
    
    -- 会员相关附件下载
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/finish' and  method='downloadMenberFile' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/bsp/menber/finish', 'downloadMenberFile', 1, '会员相关附件下载', 1, 'M00000');
    end if;
    
    --	后台基础平台里面会员管理下面添加供应商审核
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00000' and mkid='B010008' and mid='B0100' and name='供应商审核';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B010008','B0100','基本设置','供应商审核','/bsm/supplier/regaudit/list.do','/bsm/supplier/regaudit/list.do#/bsm/supplier/regaudit/toAudit.do',1,600,2,'B00000');
    end if;
    
    -- 权限明细-供应商审核列表（待审核）
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/regaudit' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010008','/bsm/supplier/regaudit','list',2,'供应商审核初始页面',2,'B00000');
	end if;
	
	 -- 权限明细-供应商审核方法：通过或拒绝
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/regaudit' and METHOD ='toAudit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010008','/bsm/supplier/regaudit','toAudit',2,'供应商审核通过还是拒绝',2,'B00000');
	end if;
    

    -- 加载供应产品范围
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/finish' and  method='getSupplierType' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/bsp/menber/finish', 'getSupplierType', 0, '加载供应产品范围', 1, 'M00000');
    end if;
    

    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and  method='infoView' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/supplier/reg','infoView',0,'提交注册-预览',1,'M00000');
    end if;
    
    --后台的参数设置
  	--num:=0;
    --select count(1) into num from bs_cssz where cskey='WSCS_GROUP_QX';   
	--if num = 0 then
	--	insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
    --   	values('WSCS_GROUP_QX','网上超市权限组','','系统管理员','网上超市默认权限组',1,'',1500,'网上超市默认权限组');
	--end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='WSCS_BUY_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('WSCS_BUY_GROUP_QX','网上超市买家权限组','','系统管理员','网上超市买家权限组',1,'',1510,'网上超市买家权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='WSCS_LOGI_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('WSCS_LOGI_GROUP_QX','网上超市物流商权限组','','系统管理员','网上超市物流商权限组',1,'',1520,'网上超市物流商权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='WSCS_PERSON_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('WSCS_PERSON_GROUP_QX','网上超市个人权限组','','系统管理员','网上超市个人权限组',1,'',1530,'网上超市个人权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='WSCS_GROUP_QX';   
	if num = 1 then
		update bs_cssz set cskey='WSCS_SELL_GROUP_QX',csmc='网上超市卖家权限组',remark='网上超市卖家权限组',csbz='网上超市卖家权限组' where cskey='WSCS_GROUP_QX';
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='SPXJ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('SPXJ_GROUP_QX','商品询价权限组','','系统管理员','商品询价默认权限组',1,'',1550,'商品询价默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='SPBJ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('SPBJ_GROUP_QX','商品报价权限组','','系统管理员','商品报价默认权限组',1,'',1560,'商品报价默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='FWXJ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('FWXJ_GROUP_QX','法务询价权限组','','系统管理员','法务询价默认权限组',1,'',1600,'法务询价默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='FWBJ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('FWBJ_GROUP_QX','法务报价权限组','','系统管理员','法务报价默认权限组',1,'',1610,'法务报价默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='FJWZ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('FJWZ_GROUP_QX','废旧物资权限组','','系统管理员','废旧物资默认权限组',1,'',1650,'废旧物资默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='FJWZJP_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('FJWZJP_GROUP_QX','废旧物资竞拍权限组','','系统管理员','废旧物资竞拍默认权限组',1,'',1660,'废旧物资竞拍默认权限组');
	end if;
	
	--num:=0;
    --select count(1) into num from bs_cssz where cskey='ZBTB_GROUP_QX';   
	--if num = 0 then
	--	insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
    --    	values('ZBTB_GROUP_QX','招标投标权限组','','系统管理员','招标投标默认权限组',1,'',1700,'招标投标默认权限组');
	--end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='TB_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('TB_GROUP_QX','投标权限组','','系统管理员','投标默认权限组',1,'',1710,'投标默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='ZBTB_GROUP_QX';   
	if num = 1 then
		update bs_cssz set cskey='ZB_GROUP_QX',csmc='招标权限组',remark='招标权限组',csbz='招标权限组' where cskey='ZBTB_GROUP_QX';
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='JJCG_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('JJCG_GROUP_QX','竞价采购权限组','','系统管理员','竞价采购默认权限组',1,'',1750,'竞价采购默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_cssz where cskey='JJCJ_GROUP_QX';   
	if num = 0 then
		insert into bs_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
        	values('JJCJ_GROUP_QX','竞价出价权限组','','系统管理员','竞价出价默认权限组',1,'',1760,'竞价出价默认权限组');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and  method='checkMsgCode' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/supplier/reg','checkMsgCode',0,'注册-验证码是否失效',1,'M00000');
    end if;

	
    num:=0;
    select count(1) into num from bs_codes where typ='常用代码类别' and code='供应商类型';
    if num=0 then
        insert into bs_codes (typ,code,value,isuse,orderno,iscanset,flag0)
        values('常用代码类别','供应商类型','供应商类型', 1, 8, 1, 1);
    end if;
    
    num:=0;
    select count(1) into num from bs_codes where typ='常用代码类别' and code='企业性质';
    if num=0 then
        insert into bs_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','企业性质','企业性质', 1, 8, 1);
    end if;

    
    --系统模块里面添加一个供应商管理模块
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0390' and sid='M00000';
	if num=0 then
		insert into	bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0390','供应商管理',1,100,'M00000');
	end if;
	
    
    --供应商管理下我的供应商
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and mid='M0390';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M039005','M0390','供应商管理','我的供应商','/bsp/suplier/menber/list.do','/bsp/suplier/menber/list.do',1,100,1,'M00000');
    end if;
    

	
	--我的供应商：操作：启用还是停用
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M03900505' and mid='M0390';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M03900505','M0390','我的供应商','操作',2,200,1,'M039005','M00000');
    end if;
    	    --我的供应商：查找
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M03900510' and mid='M0390';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M03900510','M0390','我的供应商','查找',2,300,1,'M039005','M00000');
    end if;
    	    --我的供应商：新增
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M03900515' and mid='M0390';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M03900515','M0390','我的供应商','新增',2,400,1,'M039005','M00000');
    end if;
    
        -- 权限明细-供应商管理
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='list' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039005','/bsp/suplier/menber','list',2,'供应商管理初始化页面',1,'M00000');
	end if;
    

    --我的供应商：操作：启用还是停用
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='handle' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900505','/bsp/suplier/menber','handle',2,'供应商管理操作：启用还是停用',1,'M00000');
	end if;
	    --我的供应商：查找
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='search' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900510','/bsp/suplier/menber','search',2,'供应商管理操作：查找',1,'M00000');
	end if;
		--我的供应商：新增
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='add' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900515','/bsp/suplier/menber','add',2,'供应商管理操作：新增',1,'M00000');
	end if;

	--标亮
  	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and mid='M0390';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/menber/list.do#/bsp/suplier/menber/handle.do#/bsp/suplier/menber/search.do#/bsp/suplier/menber/add.do' where sid='M00000' and mkid='M039005' and mid='M0390';
  	end if;
		 
    
	--系统模块里面添加一个成员单位管理模块
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0395' and sid='M00000';
	if num=0 then
		insert into	bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0395','成员单位管理',1,110,'M00000');
	end if;
	
	--成员单位管理下服务企业
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039515' and mid='M0395' and name='服务企业';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M039515','M0395','成员单位管理','服务企业','/bsp/suplier/serve/list.do','/bsp/suplier/serve/list.do',1,100,1,'M00000');
    end if;
    
    -- 权限明细-服务企业
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/serve' and METHOD ='list' and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039515','/bsp/suplier/serve','list',2,'服务企业初始化页面',1,'M00000');
	end if;
	
	--前台：供应商管理：考核结果公示
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039010' and mid='M0390' and name='考核结果公示';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M039010','M0390','我的供应商','考核结果公示','/bsp/suplier/assess/list.do','/bsp/suplier/assess/list.do',1,200,1,'M00000');
    end if;
    
    --前台：供应商管理：考核结果公示
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/assess' and METHOD ='list' and SID='M00000' and mkid='M039010';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039010','/bsp/suplier/assess','list',2,'供应商管理：考核结果公示',1,'M00000');
	end if;

	
	--前台：成员单位管理：我的考核结果
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039520' and mid='M0395' and name='我的考核结果';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M039520','M0395','成员单位管理','我的考核结果','/bsp/suplier/result/list.do','/bsp/suplier/result/list.do',1,200,1,'M00000');
    end if;
    
    --前台：成员单位管理：我的考核结果
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/result' and METHOD ='list' and SID='M00000' and mkid='M039520';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039520','/bsp/suplier/result','list',2,'成员单位管理：我的考核结果',1,'M00000');
	end if;

	
	--	后台基础平台里面会员管理下面添加供应商评分
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00000' and mkid='B010110' and mid='B0100' and name='供应商评分';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B010110','B0100','基本设置','供应商评分','/bsm/supplier/score/list.do','/bsm/supplier/score/list.do',1,650,2,'B00000');
    end if;


	-- 权限明细-供应商评分列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/score' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010110','/bsm/supplier/score','list',0,'供应商评分初始页面',2,'B00000');
	end if;

	-- 权限明细-供应商评分导入
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/score' and METHOD ='importFile' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010110','/bsm/supplier/score','importFile',0,'供应商评分导入',2,'B00000');
	end if;
	
	-- 权限明细-供应商评分模板下载
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/score' and METHOD ='downLoadWeb' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010110','/bsm/supplier/score','downLoadWeb',0,'供应商评分模板下载',2,'B00000');
	end if;

	--标亮
  	num:=0;
  	select count(1) into num from bs_qxsz where sid='B00000' and mkid='B010110' and mid='B0100';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsm/supplier/score/list.do#/bsm/supplier/score/importFile.do#/bsm/supplier/score/downLoadWeb.do' where sid='B00000' and mkid='B010110' and mid='B0100';
  	end if;

  	--前台附件下载
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/supplier/reg' and METHOD ='downloadMenberFile' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/supplier/reg','downloadMenberFile',0,'前台注册 附件下载',1,'M00000');
	end if;
	

  	
  	-- 权限明细-合格供应商名录显示信息
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='showGys' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','showGys',0,'显示供应商信息',1,'M00004');
	end if;

  	--前台-我的供应商-查看供应商信息
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='showSpplier' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900520','/bsp/suplier/menber','showSpplier',1,'我的供应商查看供应商信息',1,'M00000');
	end if;
	
	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and mid='M0390';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/menber/list.do#/bsp/suplier/menber/handle.do#/bsp/suplier/menber/search.do#/bsp/suplier/menber/add.do#/bsp/suplier/menber/showSpplier.do' where sid='M00000' and mkid='M039005' and mid='M0390';
  	end if;
  	
  	
	-- 权限明细-查看会员集团树（前台）
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/market/publicfun' and METHOD ='showMbGroup' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/market/publicfun','showMbGroup',1,'查看会员集团树',1,'M00000');
	end if;
	
	-- 权限明细-查看会员集团树（后台）
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin/publicfun' and METHOD ='showMbGroup' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/publicfun','showMbGroup',1,'查看会员集团树',2,'B00000');
	end if;
	
	--前台-成员单位管理-服务企业-数据导出
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0395' and mkid='M03951505';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M03951505','M0395','服务企业','导出服务企业',2,100,1,'M039515','M00000');
	end if;
	
	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039515' and mid='M0395';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/serve/list.do#/bsp/suplier/serve/export.do' where sid='M00000' and mkid='M039515' and mid='M0395';
  	end if;
  	
  	--前台-成员单位管理-服务企业-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/serve' and METHOD ='export' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03951505','/bsp/suplier/serve','export',2,'导出服务企业',1,'M00000');
	end if;
  	
	--前台-供应商管理-我的供应商-数据导出
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid='M03900525';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M03900525','M0390','我的供应商','导出我的供应商',2,500,1,'M039005','M00000');
	end if;
	
  	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and mid='M0390';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/menber/list.do#/bsp/suplier/menber/handle.do#/bsp/suplier/menber/search.do#/bsp/suplier/menber/add.do#/bsp/suplier/menber/showSpplier.do#/bsp/suplier/menber/export.do' where sid='M00000' and mkid='M039005' and mid='M0390';
  	end if;
  	
  	--前台-供应商管理-我的供应商-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='export' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900525','/bsp/suplier/menber','export',2,'导出我的供应商',1,'M00000');
	end if;
	
	
	update bs_qxsz set name='会员注册审核' where sid='B00000' and mid='B0100' and mkid='B010007' and url='/bsp/supplier/regaudit/list.do';
	
	

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='indexMro' and mkid='M011020' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M011020','/exp/hangsource/sell/publish','indexMro',2,'资源发布（卖）：工业品多规格商品引导',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00201' and mkid='M011020' and url='/exp/hangsource/sell/publish/category.do' and inurl='/exp/hangsource/sell/publish/index.do#/exp/hangsource/sell/publish/category.do#/exp/hangsource/sell/publish/copy.do/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#';
    if num=1 then
        update bs_qxsz set inurl='/exp/hangsource/sell/publish/index.do#/exp/hangsource/sell/publish/category.do#/exp/hangsource/sell/publish/copy.do/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/copy.do#/exp/hangsource/sell/publish/indexMro.do#' where sid='M00201' and mkid='M011020' and url='/exp/hangsource/sell/publish/category.do';
    end if; 
    
    

	--前台-供应商管理-我的供应商-数据导出
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid='M03900530';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M03900530','M0390','我的供应商','移除我的供应商',2,600,1,'M039005','M00000');
	end if;
	
	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and mid='M0390';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/menber/list.do#/bsp/suplier/menber/handle.do#/bsp/suplier/menber/search.do#/bsp/suplier/menber/add.do#/bsp/suplier/menber/showSpplier.do#/bsp/suplier/menber/export.do#/bsp/suplier/menber/remove.do' where sid='M00000' and mkid='M039005' and mid='M0390';
  	end if;
  	
  	--前台-供应商管理-我的供应商-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='remove' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','remove',2,'移除我的供应商',1,'M00000');
	end if;
	
	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039010' and mid='M0390';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/assess/list.do#/bsp/suplier/assess/export.do' where sid='M00000' and mkid='M039010' and mid='M0390';
  	end if;
  	
  	--前台-供应商管理-考核结果公示-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/assess' and METHOD ='export' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039010','/bsp/suplier/assess','export',2,'导出考核结果公示',1,'M00000');
	end if;
	
	--标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00000' and mkid='M039520' and mid='M0395';
  	if num = 1 then
  		update bs_qxsz set inurl = '/bsp/suplier/result/list.do#/bsp/suplier/result/export.do' where sid='M00000' and mkid='M039520' and mid='M0395';
  	end if;
  	
  	--前台-成员单位管理-我的考核结果-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/result' and METHOD ='export' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039520','/bsp/suplier/result','export',2,'导出我的考核结果',1,'M00000');
	end if;
	
	--工业品多规格 导入数据
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='downPage' and mkid='M011020' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M011020','/exp/hangsource/sell/publish','downPage',2,'导入-显示导入页面',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='importFile' and mkid='M011020' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M011020','/exp/hangsource/sell/publish','importFile',2,'导入-导入数据',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/publish' and  method='downLoadModel' and mkid='M011020' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M011020','/exp/hangsource/sell/publish','downLoadModel',2,'导入-下载多规格属性模板',1,'M00201');
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/allthing' and  method='myAr' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/allthing','myAr',0,'判断用户是否有我的超市',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/picksource' and  method='mroJson' and mkid='M010505' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M010505','/exp/hangsource/buy/picksource','mroJson',1,'资源选购：json',1,'M00201');
    end if;

    --标亮
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M017015' and mid='M0170';
  	if num = 1 then
  		update bs_qxsz set inurl = '/exp/querybusinesslaw/buy/list.do#/exp/querybusiness/processlaw/buy/list.do#/exp/querybusiness/completedlaw/buy/list.do#/exp/querybusinesslaw/buy/toAdd.do#/exp/querybusinesslaw/buy/toEdit.do#/exp/querybusinesslaw/buy/arAdd.do#/exp/querybusinesslaw/buy/toConReqAdd.do#/exp/querybusinesslaw/buy/toAddLaw.do#/exp/querybusiness/processlaw/buy/export.do' where sid='M00004' and mkid='M017015' and mid='M0170';
  	end if;
  	
  	--法务询价-数据导出
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/buy' and METHOD ='export' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/processlaw/buy','export',2,'导出',1,'M00004');
	end if;

    --代理商
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and  method='dlsList' and mkid='M010035' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M010035','/bsp/menber/wldw','dlsList',2,'代理商-列表',1,'M00000');
    end if;

 	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and  method='toAddDls' and mkid='M010035' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M010035','/bsp/menber/wldw','toAddDls',2,'代理商-新增',1,'M00000');
    end if; 
    
    
    
	
	-----------------------------------------------------------------------------------------------------------------
	
    ---add by xuz 资格预审公告 end---
	--资格预审公告编制
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089005';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse,orderno, styp, sid ,qxrole) 
    	values('M089005', 'M0890', '资格预审', '资格预审公告编制','/exp/bidding/buy/prefic/index.do','/exp/bidding/buy/prefic/index.do', 1,50, 1, 'M00008','008-1-2-2');
  	end if;
	--资格预审公告编制
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='index' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','index',2,'预审公告编制',1,'M00008');
	end if;

	--资格预审公告编制保存
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='doSave' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','doSave',2,'预审公告编制保存',1,'M00008');
	end if;
	
	--资格预审公告编制修改
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='updateGgbz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','updateGgbz',2,'预审公告编制修改',1,'M00008');
	end if;
	
	--资格预审公告编制预览
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='view' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','view',2,'预审公告编制预览',1,'M00008');
	end if;
	
	--资格预审公告编发布
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toPublish' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','toPublish',2,'预审公告发布',1,'M00008');
	end if;
	
	--资格预审公告查看附件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','download',2,'查看预审公告附件',1,'M00008');
	end if;
	
	
	--投标邀请书编制
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M082070';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, styp,  sid) 
    	values('M082070', 'M0820', '约标', '投标邀请书编制','/exp/bidding/buy/prefic/index.do','/exp/bidding/buy/yqhs/toEdit.do#/exp/bidding/buy/yqhs/toRelease.do#/exp/bidding/buy/yqhs/toSave.do#/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toView.do#toDownload.do', 1, 1, 'M00008');
  	end if;
	--投标邀请书编制
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toEdit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toEdit',2,'投标邀请书编制',1,'M00008');
	end if;
	--投标邀请书修改
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toUpdate' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toUpdate',2,'投标邀请书修改',1,'M00008');
	end if;
	--投标邀请书附件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toDownload' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toDownload',2,'投标邀请书附件下载',1,'M00008');
	end if;
	--投标邀请书编制保存
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toSave' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toSave',2,'投标邀请书编制保存',1,'M00008');
	end if;
	--投标邀请书编制查看
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toView',2,'投标邀请书编制查看',1,'M00008');
	end if;
	--投标邀请书编制发布
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toRelease' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','toRelease',2,'投标邀请书编制发布',1,'M00008');
	end if;
	
	 --后台增加模块招标管理
    num:=0;
    select count(1) into num from bs_xtmk where mid='B0110' and  mname='招标管理' and  sid='B00008';
    if num=0 then
        insert into bs_xtmk (mid,mname,styp,ordby,sid)
        values('B0110','招标管理',2,550,'B00008'); 
    end if;
    
    --资格预审公告审核
    num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'B00008' and mkid='B011005';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse, styp, sid) 
    	values('B011005', 'B0110', '招标管理', '资格预审公告审核', '/bdm/prefic/list.do','/bdm/prefic/list.do',1, 2, 'B00008');
  	end if;
  	
  	--资格预审公告审核列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/prefic' and METHOD ='list' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011005','/bdm/prefic','list',2,'资格预审公告审核列表',2,'B00008');
	end if;
	
	--资格预审公告审核页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/prefic' and METHOD ='toAudit' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011005','/bdm/prefic','toAudit',2,'资格预审公告审核',2,'B00008');
	end if;
	
	--资格预审公告审核通过
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/prefic' and METHOD ='confirm' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011005','/bdm/prefic','confirm',2,'资格预审公告审核通过',2,'B00008');
	end if;
	--资格预审公告审核拒绝
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/prefic' and METHOD ='refuse' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011005','/bdm/prefic','refuse',2,'资格预审公告审核拒绝',2,'B00008');
	end if;
	---add by xuz 资格预审公告 end---
	
	--add by zhminfu 专家评审平台
	num:=0;
    select count (1) into num from  bs_system where sid='M00009' and sname ='评审平台';    
    if num = 0 then
      	insert into bs_system ( SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00 , URL01 , URL02 , URL03 , URL04)
 		values('M00009','评审平台','评审','1','/me/home/index.do','990','http://ps.td.steel56.com.cn/psplatform','/login/index.do','/auth/noAuth.do','/login/doLogout.do','_psSystem');
	end if;
	
	-- add by lvcy 2016/05/10  地区  start 
	UPDATE BS_DQ SET DQCODE = '220605', DQNAME = '江源区' WHERE DQCODE = '220625';
	UPDATE BS_DQ SET DQCODE = '230110' WHERE DQCODE = '230106';
	DELETE FROM BS_DQ WHERE DQCODE = '230107';
	UPDATE BS_DQ SET DQCODE = '230112' WHERE DQCODE = '230181';
	DELETE FROM BS_DQ WHERE DQCODE = '230802';

	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='340208';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('340208' , '三山区', '340200', '0000', '3');
	end if;
	
	UPDATE BS_DQ SET DQNAME = '弋江区' WHERE DQCODE = '340203';
	DELETE FROM BS_DQ WHERE DQCODE = '340204';
	UPDATE BS_DQ SET DQCODE = '370911' WHERE DQCODE = '370903';
	UPDATE BS_DQ SET DQCODE = '410311' WHERE DQCODE = '410307';
	DELETE FROM BS_DQ WHERE DQCODE = '410881';
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='419000';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('419000' , '省直辖县', '410000', '0000', '2');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='419001';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('419001' , '济源市', '419000', '0000', '3');
	end if;
	
	DELETE FROM BS_DQ WHERE DQCODE = '421400';
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='429000';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('429000' , '省直辖县', '420000', '0000', '2');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='429004';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('429004' , '仙桃市', '429000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='429005';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('429005' , '潜江市', '429000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='429006';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('429006' , '天门市', '429000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='429021';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('429021' , '神农架林区', '429000', '0000', '3');
	end if;
	
	DELETE FROM BS_DQ WHERE DQCODE = '433000';
	DELETE FROM BS_DQ WHERE DQCODE = '431700';

	DELETE FROM BS_DQ WHERE DQCODE = '440102';
	DELETE FROM BS_DQ WHERE DQCODE = '440107';
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='440115';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('440115' , '南沙区', '440100', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='440116';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('440116' , '萝岗区', '440100', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='469000';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('469000' , '省直辖县', '460000', '0000', '2');
	end if;
	
	UPDATE BS_DQ SET DQCODE = '469021' WHERE DQCODE = '469025' and DQNAME = '定安县';
	UPDATE BS_DQ SET DQCODE = '469022' WHERE DQCODE = '469026' and DQNAME = '屯昌县';
	UPDATE BS_DQ SET DQCODE = '469023' WHERE DQCODE = '469027' and DQNAME = '澄迈县';
	UPDATE BS_DQ SET DQCODE = '469024' WHERE DQCODE = '469028' and DQNAME = '临高县';
	UPDATE BS_DQ SET DQCODE = '469025' WHERE DQCODE = '469030' and DQNAME = '白沙县';
	UPDATE BS_DQ SET DQCODE = '469026' WHERE DQCODE = '469031' and DQNAME = '昌江县';
	UPDATE BS_DQ SET DQCODE = '469027' WHERE DQCODE = '469033' and DQNAME = '乐东县';
	UPDATE BS_DQ SET DQCODE = '469028' WHERE DQCODE = '469034' and DQNAME = '陵水县';
	UPDATE BS_DQ SET DQCODE = '469029' WHERE DQCODE = '469035' and DQNAME = '保亭县';
	UPDATE BS_DQ SET DQCODE = '469030' WHERE DQCODE = '469036' and DQNAME = '琼中县';
	DELETE FROM BS_DQ WHERE DQCODE = '469037';
	DELETE FROM BS_DQ WHERE DQCODE = '469038';
	DELETE FROM BS_DQ WHERE DQCODE = '469039';
	
	UPDATE BS_DQ SET DQCODE = '500116' WHERE DQCODE = '500381';
	UPDATE BS_DQ SET DQCODE = '500117' WHERE DQCODE = '500382';
	UPDATE BS_DQ SET DQCODE = '500118' WHERE DQCODE = '500383';
	UPDATE BS_DQ SET DQCODE = '500119' WHERE DQCODE = '500384';
	
	DELETE FROM BS_DQ WHERE DQCODE = '650108';
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='650109';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('650109' , '米东区', '650100', '0000', '3');
	end if;
	
	DELETE FROM BS_DQ WHERE DQCODE = '652303';
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='659000';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('659000' , '省直辖县', '650000', '0000', '2');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='659001';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('659001' , '石河子市', '659000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='659002';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('659002' , '阿拉尔市', '659000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='659003';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('659003' , '图木舒克市', '659000', '0000', '3');
	end if;
	
	num:=0;
    select count (1) into num from  BS_DQ where DQCODE='659004';    
    if num = 0 then
      	INSERT INTO BS_DQ(DQCODE, DQNAME, FATHER, CTYCODE, DQTYP) VALUES ('659004' , '五家渠市', '659000', '0000', '3');
	end if;
	-- add by lvcy 地区  end

	---add by hanglong 招投标平台前后台公共的一些权限 start---
	---前台start---
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0100' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0100','招标管理',1,100,'M00008','008-1',''); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0200' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole, icon)
		values('M0200','投标管理',1,200,'M00008','008-2',''); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/me/home' and  method='index' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/me/home', 'index', 1, '我的平台', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/me/home' and  method='showDiscuss' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/me/home', 'showDiscuss', 1, '业务提醒', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/me/home' and  method='countNum' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/me/home', 'countNum', 1, '业务提醒-信息数量', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/' and  method='index' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/', 'index', 0, '前台首页', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/ask' and  method='meIsOnline' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/ask', 'meIsOnline', 0, '客户端在线通知', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and  method='syscodelist' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/market/syscode/publicfun', 'syscodelist', 1, '获取常用代码设置AJAX', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and  method='removeFlash' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/market/syscode/publicfun', 'removeFlash', 0, '删除重复的消息提示', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/cache' and  method='reflashCache' and mkid='0' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/cache', 'reflashCache', 0, '刷新招标平台缓存', 1, 'M00008');
	end if;
	---前台end---
	
	---后台start---
	num:=0;
	select count(1) into num from bs_xtmk where mid='B0100' and  sid='B00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid)
		values('B0100','基本设置',2,100,'B00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010005' and mid='B0100';
	if num=0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010005','B0100','基本设置','交易参数设置','/admin/basesetup/cssz/index.do','/admin/basesetup/cssz/index.do#/admin/basesetup/cssz/update.do',1,1000,2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B01000505' and mid='B0100';
	if num=0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000505','B0100','交易参数设置','编辑','','',2,1000,2,'B010005','B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/cssz' and  method='index' and mkid='B010005' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010005', '/admin/basesetup/cssz', 'index', 2, '参数设置', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/cssz' and  method='update' and mkid='B01000505' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01000505', '/admin/basesetup/cssz', 'update', 2, '修改参数设置', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010010' and mid='B0100';
	if num=0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010010','B0100','基本设置','常用代码设置','/admin/basesetup/codes/list.do','',1,900,2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='batchDelete' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'batchDelete', 2, '删除常用代码', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='list' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'list', 2, '常用代码类别列表', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='save' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'save', 2, '新增常用代码', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='show' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'show', 2, '查看常用代码设置', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='toAdd' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'toAdd', 2, '跳转新增常用代码页面', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='toEdit' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'toEdit', 2, '跳转修改常用代码页面', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and  method='update' and mkid='B010010' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010010', '/admin/basesetup/codes', 'update', 2, '修改常用代码', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin' and  method='index' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin', 'index', 1, '后台管理界面首页', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin' and  method='menu' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin', 'menu', 1, '模块左侧', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin' and  method='navagation' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin', 'navagation', 1, '模块头部', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin' and  method='noAuth' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin', 'noAuth', 0, '无权限跳转', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin' and  method='ywtx' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin', 'ywtx', 1, '后台业务提醒页面', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/cache' and  method='reflashCache' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/cache', 'reflashCache', 0, '刷新招标平台缓存', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/ask' and  method='meIsOnline' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/ask', 'meIsOnline', 0, '客户端在线通知', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/syscode/publicfun' and  method='removeFlash' and mkid='0' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/admin/syscode/publicfun', 'removeFlash', 0, '删除重复的消息提示', 2, 'B00008');
	end if;
	---后台end---
	---add by hanglong 招投标平台前后台公共的一些权限 end---

	---add by hanglong 项目行业分类 start---
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010020' and mid='B0100';
	if num=0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010020','B0100','基本设置','项目行业分类','/bdm/basesetup/tradetype/list.do','/bdm/basesetup/tradetype/list.do#',1,500,2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='list' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'list', 2, '项目行业分类-目录层级列表', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='toAdd' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'toAdd', 2, '项目行业分类-进入新增分类页面', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='save' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'save', 2, '项目行业分类-新增项目行业分类保存', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='toEdit' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'toEdit', 2, '项目行业分类-进入编辑分类页面', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='update' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'update', 2, '项目行业分类-修改项目行业分类保存', 2, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/tradetype' and  method='delete' and mkid='B010020' and  sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B010020', '/bdm/basesetup/tradetype', 'delete', 2, '项目行业分类-删除项目行业分类', 2, 'B00008');
	end if;

	---add by hanglong 项目行业分类 end---

	---add by lvcyong 自定义属性 start---
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010025' and mid='B0100';
	if num=0 then
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B010025', 'B0100', '基本设置', '自定义属性', '/bdm/basesetup/property/index.do', '/bdm/basesetup/property/index.do#', '1', '1100', '2', NULL, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B01002505' and mid='B0100';
	if num=0 then
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B01002505', 'B0100', '自定义属性', '编辑', NULL, NULL, '2', '1100', '2', 'B010025', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='index' and mkid='B010025' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B010025', '/bdm/basesetup/property', 'index', '2', '自定义属性列表', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='toAdd' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'toAdd', '2', '添加自定义属性页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='save' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'save', '2', '添加自定义属性', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='toUpdate' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'toUpdate', '2', '修改自定义属性页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='update' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'update', '2', '修改自定义属性', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='delete' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'delete', '2', '删除自定义属性', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='list' and mkid='B010025' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B010025', '/bdm/basesetup/property', 'list', '2', '明细列表', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='toAddMx' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'toAddMx', '2', '添加明细页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='saveMx' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'saveMx', '2', '添加明细', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='toEdit' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'toEdit', '2', '修改明细页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='edit' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'edit', '2', '修改明细', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/property' and  method='batchDelete' and mkid='B01002505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01002505', '/bdm/basesetup/property', 'batchDelete', '2', '删除明细', '2', 'B00008');
	end if;
	
	---add by lvcyong 自定义属性 end---
	
	--增加邀请单位搜索--- hejw
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00000' and action='/market/publicfun' and method='menberByYQDW';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('0', '/market/publicfun', 'menberByYQDW', 1, '获取-邀请单位', 1, 'M00000'); 
    end if;

	---add by lvcyong 系统公告 start---
	num:=0;
	select count(1) into num from BS_XTMK where mid='B0200';
	if num=0 then
		INSERT INTO "BS_XTMK" ("MID", "MNAME", "STYP", "ORDBY", "SID") 
		VALUES ('B0200', '系统管理', '2', '200', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B020005' and mid='B0200';
	if num=0 then
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B020005', 'B0200', '基本设置', '系统公告', '/bdm/basesetup/notice/list.do', '/bdm/basesetup/notice/list.do#', '1', '100', '2', NULL, 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='B00008' and mkid='B02000505' and mid='B0200';
	if num=0 then
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B02000505', 'B0200', '系统公告', '编辑', NULL, NULL, '2', '100', '2', 'B020005', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='list' and mkid='B020005' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B020005', '/bdm/basesetup/notice', 'list', '2', '系统公告列表', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='toSave' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'toSave', '2', '添加系统公告页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='save' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'save', '2', '添加系统公告', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='toEdit' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'toEdit', '2', '修改系统公告页面', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='edit' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'edit', '2', '修改系统公告', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='delete' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'delete', '2', '删除系统公告', '2', 'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='look_content' and mkid='B02000505' and  sid='B00008';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B02000505', '/bdm/basesetup/notice', 'look_content', '2', '查看系统公告', '2', 'B00008');
	end if;
	 num:=0;
  	select count(1) into num from bs_qxmx where action='/bdm/basesetup/notice' and  method='download' and mkid='B02000505' and  sid='B00008';
 	if num=0 then
    INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
    VALUES ('B02000505', '/bdm/basesetup/notice', 'download', '2', '下载系统公告附件', '2', 'B00008');
  	end if;
	
	---add by lvcyong 系统公告 end---

  ---add by Linqingqing 标段包分类 start---
  num:=0;
  select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010030' and mid='B0100';
  if num=0 then
    insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
    values('B010030','B0100','基本设置','标段(包)分类','/bdm/basesetup/bidpackagetype/list.do','/bdm/basesetup/bidpackagetype/list.do#',1,1500,2,'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where sid='B00008' and mkid='B01003005' and mid='B0100';
  if num=0 then
    INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
    VALUES ('B01003005', 'B0100', '标段(包)分类', '编辑', NULL, NULL, '2', '1500', '2', 'B010030', 'B00008');
  end if;

  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='list' and mkid='B010030' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B010030', '/bdm/basesetup/bidpackagetype', 'list', 2, '标段(包)分类-目录层级列表', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='toAdd' and mkid='B01003005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01003005', '/bdm/basesetup/bidpackagetype', 'toAdd', 2, '标段(包)分类-进入新增分类页面', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='save' and mkid='B01003005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01003005', '/bdm/basesetup/bidpackagetype', 'save', 2, '标段(包)分类-新增标段(包)分类保存', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='toEdit' and mkid='B01003005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01003005', '/bdm/basesetup/bidpackagetype', 'toEdit', 2, '标段(包)分类-进入编辑分类页面', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='update' and mkid='B01003005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01003005', '/bdm/basesetup/bidpackagetype', 'update', 2, '标段(包)分类-修改标段(包)分类保存', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/bidpackagetype' and  method='delete' and mkid='B01003005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01003005', '/bdm/basesetup/bidpackagetype', 'delete', 2, '标段(包)分类-删除标段(包)分类', 2, 'B00008');
  end if;

  ---add by Linqingqing 标段(包)分类 end---

	---add by longf 专家管理 start---
	--系统模块-专家管理模块
	num:=0;
	select count(1) into num from bs_xtmk where mid='B0105' and sid='B00008';
	if num=0 then
		insert into	bs_xtmk(mid,mname,styp,ordby,sid)
		values('B0105','专家管理',2,500,'B00008');
	end if;

	--权限设置-专家管理
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0105' and mkid='B010505';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B010505','B0105','专家管理','专家管理','/bdm/expert/list.do','/bdm/expert/list.do#/bdm/expert/toAdd.do#/bdm/expert/toEdit.do',1,800,2,'','B00008');
	end if;
	
	--权限设置-专家管理编辑
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0105' and mkid='B01050505';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('B01050505','B0105','专家管理','编辑',2,800,2,'B010505','B00008');
	end if;
	
	--权限明细-专家管理-专家清单
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='list' and mkid='B010505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010505','/bdm/expert','list',2,'专家管理-专家清单',2,'B00008');
    end if;
    
	--权限明细-专家管理-跳转新增专家界面
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='toAdd' and mkid='B01050505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','toAdd',2,'专家管理-跳转新增专家界面',2,'B00008');
    end if;
    
	--权限明细-专家管理-保存专家
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='save' and mkid='B01050505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','save',2,'专家管理-保存专家',2,'B00008');
    end if;
    
	--权限明细-专家管理-跳转修改专家页面
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='toEdit' and mkid='B01050505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','toEdit',2,'专家管理-跳转修改专家页面',2,'B00008');
    end if;
    
	--权限明细-专家管理-更新专家信息
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='update' and mkid='B01050505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','update',2,'专家管理-更新专家信息',2,'B00008');
    end if;
    
	--权限明细-专家管理-删除专家
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='delete' and mkid='B01050505' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','delete',2,'专家管理-删除专家',2,'B00008');
    end if;
    
	---add by longf 专家管理 end---

   --增加代理商 搜索--- hejw
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00000' and action='/market/publicfun' and method='menberByDLS';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('0', '/market/publicfun', 'menberByDLS', 1, '获取-代理商', 1, 'M00000'); 
    end if;
    
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','index',0,'评审平台-登录界面',1,'M00009');
	end if;
	
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='doLogin' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','doLogin',0,'评审平台-评委登录',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='doLogout' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','doLogout',1,'评审平台-评委登出',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/auth' and METHOD ='noAuth' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/auth','noAuth',0,'评审平台-无权限',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/cache' and METHOD ='reflashCache' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/cache','reflashCache',0,'评审平台-刷新缓存',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/ask' and METHOD ='meIsOnline' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/ask','meIsOnline',0,'评审平台-在线通知',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/me/home' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/me/home','index',1,'评审平台-我的平台',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','index',1,'评委签到-评委签到列表',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='toSign' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','toSign',1,'评委签到-跳转到评委签到界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='firstSign' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','firstSign',1,'评委签到-确认回避承诺书',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='sencodSign' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','sencodSign',1,'评委签到-确认廉洁自律承诺书',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='saveSign' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','saveSign',1,'评委签到-签到',1,'M00009');
	end if;
	

---add by Linqingqing 职业资格序列 start---
  num:=0;
  select count(1) into num from bs_qxsz where sid='B00008' and mkid='B010040' and mid='B0100';
  if num=0 then
    insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
    values('B010040','B0100','基本设置','职业资格序列','/bdm/basesetup/jobtype/list.do','/bdm/basesetup/jobtype/list.do#',1,2500,2,'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where sid='B00008' and mkid='B01004005' and mid='B0100';
  if num=0 then
    INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
    VALUES ('B01004005', 'B0100', '职业资格序列', '编辑', NULL, NULL, '2', '2500', '2', 'B010040', 'B00008');
  end if;

  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='list' and mkid='B010040' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B010040', '/bdm/basesetup/jobtype', 'list', 2, '职业资格序列-目录层级列表', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='toAdd' and mkid='B01004005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01004005', '/bdm/basesetup/jobtype', 'toAdd', 2, '职业资格序列-进入新增分类页面', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='save' and mkid='B01004005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01004005', '/bdm/basesetup/jobtype', 'save', 2, '职业资格序列-新增职业资格序列保存', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='toEdit' and mkid='B01004005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01004005', '/bdm/basesetup/jobtype', 'toEdit', 2, '职业资格序列-进入编辑分类页面', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='update' and mkid='B01004005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01004005', '/bdm/basesetup/jobtype', 'update', 2, '职业资格序列-修改职业资格序列保存', 2, 'B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/basesetup/jobtype' and  method='delete' and mkid='B01004005' and  sid='B00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('B01004005', '/bdm/basesetup/jobtype', 'delete', 2, '职业资格序列-删除职业资格序列', 2, 'B00008');
  end if;
  
  -------------------------------------------组建资格预审委员会BY。zhminfu--------------------------------------------------
  ------删除老数据
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M01000535' and  sid='M00008' and mid='M0100' and name='组建委员会';
  if num>0 then
  	DELETE FROM BS_QXSZ WHERE MKID='M01000535' AND SID='M00008' AND MID='M0100';
  	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/expert/jury' AND MKID='M01000535' AND SID='M00008';
  	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/build/jury' AND MKID='M01000535' AND SID='M00008';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M082025' and  sid='M00008' and mid='M0820' and name='组建资格预审委员会';
  if num>0 then
  	DELETE FROM BS_QXSZ WHERE MKID='M082025' AND SID='M00008' AND MID='M0820' and name='组建资格预审委员会';
  	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/build/jury' AND MKID='M082025' AND SID='M00008';
  end if;
  
  
  ------重新插入数据
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089040' and mid='M0890';
  if num=0 then
    insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('M089040','M0890','资格预审','组建资格预审委员会','/bdp/build/pre/jury/index.do','/bdp/build/pre/jury/index.do',1,'400',1,'','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089040' and mid='M0890';
  if num=1 then
    update bs_qxsz set qxrole='008-1-2-2' where sid='M00008' and mkid='M089040' and mid='M0890';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='index' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'index', 2, '组建资格预审委员会-委员会列表', 1, 'M00008');
  end if;
  
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='toEdit' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'toEdit', 2, '组建资格预审委员会-新增编辑界面', 1, 'M00008');
  end if;
  
  num:=0;
  select instr(inurl,'/bdp/build/pre/jury/toEdit.do') into num from bs_qxsz where sid='M00008' and mkid='M089040';
  if num = 0 then
      update bs_qxsz set inurl=concat(inurl,'#/bdp/build/pre/jury/toEdit.do') where sid='M00008' and mkid='M089040';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='saveBasic' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'saveBasic', 2, '组建资格预审委员会-保存基础信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='choicePack' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'choicePack', 2, '组建资格预审委员会-选择标段包', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='choiceExpert' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'choiceExpert', 2, '组建资格预审委员会-选择专家界面', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='saveExpert' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'saveExpert', 2, '组建资格预审委员会-选择保存专家信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='extractExpert' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'extractExpert', 2, '组建资格预审委员会-抽取专家信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='saveOwner' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'saveOwner', 2, '组建资格预审委员会-保存业主代表', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='toRequire' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'toRequire', 2, '组建资格预审委员会-添加抽取条件界面', 1, 'M00008');
  end if;
  
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='saveRequire' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'saveRequire', 2, '组建资格预审委员会-保存抽取条件', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='delRequire' and mkid='M089040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M089040', '/bdp/build/pre/jury', 'delRequire', 2, '组建资格预审委员会-移除抽取条件', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='loadRequire' and mkid='M089040' and  sid='M00008';
  if num=0 then
	  insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	  values('M089040', '/bdp/build/pre/jury', 'loadRequire', 2, '组建资格预审委员会-AJAX调用抽取条件列表', 1, 'M00008');
  end if;
  
  
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083040' and mid='M0830';
  if num=0 then
    insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('M083040','M0830','发标','组建评标委员会','/bdp/build/jury/index.do','/bdp/build/jury/index.do',1,'400',1,'','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='index' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'index', 2, '组建评标委员会-委员会列表', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='toEdit' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'toEdit', 2, '组建评标委员会-新增编辑界面', 1, 'M00008');
  end if;
  
  num:=0;
  select instr(inurl,'/bdp/build/jury/toEdit.do') into num from bs_qxsz where sid='M00008' and mkid='M083040';
  if num = 0 then
      update bs_qxsz set inurl=concat(inurl,'#/bdp/build/jury/toEdit.do') where sid='M00008' and mkid='M083040';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='saveBasic' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'saveBasic', 2, '组建评标委员会-保存基础信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='choicePack' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'choicePack', 2, '组建评标委员会-选择标段（包）', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='choiceExpert' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'choiceExpert', 2, '组建评标委员会-选择专家界面', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='saveExpert' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'saveExpert', 2, '组建评标委员会-选择保存专家信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='extractExpert' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'extractExpert', 2, '组建评标委员会-抽取专家信息', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='saveOwner' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'saveOwner', 2, '组建评标委员会-保存业主代表', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='toRequire' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'toRequire', 2, '组建评标委员会-添加抽取条件界面', 1, 'M00008');
  end if;
  
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='saveRequire' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'saveRequire', 2, '组建评标委员会-保存抽取条件', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='delRequire' and mkid='M083040' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M083040', '/bdp/build/jury', 'delRequire', 2, '组建评标委员会-移除抽取条件', 1, 'M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='loadRequire' and mkid='M083040' and  sid='M00008';
  if num=0 then
	  insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	  values('M083040', '/bdp/build/jury', 'loadRequire', 2, '组建评标委员会-AJAX调用抽取条件列表', 1, 'M00008');
  end if;
	
	
  ---------------------END----------------------组建资格预审委员会BY。zhminfu--------------------END------------------------------
  

  ---add by Linqingqing 职业资格序列 end---
  --- bd 招标后审
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='index' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','index',2,'后审公告编制',1,'M00008');
	end if;
	
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='doSave' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','doSave',2,'后审公告保存',1,'M00008');
	end if;
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='updateGgbz' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','updateGgbz',2,'后审公告更新',1,'M00008');
	end if;  
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='view' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','view',2,'资格后审公告查看',1,'M00008');
	end if;  

    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='toPublish' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','toPublish',2,'资格后审公告发布',1,'M00008');
	end if;   
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='download' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000540','/exp/bidding/buy/aftfic','download',2,'资格后审附件下载',1,'M00008');
	end if;	
	
	
    
  
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='chooseDean' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','chooseDean',1,'评委签到-选择评审委员会主任',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='loadMember' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','loadMember',1,'评委签到-AJAX调用评委列表',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='saveDean' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','saveDean',1,'评委签到-保存评审委员会主任',1,'M00009');
	end if;
	
		
	
		
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='bdLogin' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','bdLogin',0,'招标平台登录方法',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='bdClientLogin' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','bdClientLogin',0,'招标平台客户端登录方法',1,'M00000');
	end if;
	
	  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/kbqd' and METHOD ='index' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M093005','/exp/bidding/sell/kbqd','index',2,'投标方标段包列表',1,'M00008');
  end if;
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/kbqd' and METHOD ='sign' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M093005','/exp/bidding/sell/kbqd','sign',2,'投标方签到',1,'M00008');
  end if;
  
    --邀请后审 公开预审 公开预审招标文件制作  权限一起放在M01000525里
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M01000540' and mid='M0100' and name='公告编制';
    if num=1 then
        delete from BS_QXSZ where sid='M00008' and mkid='M01000540' and mid='M0100' and name='公告编制';
    end if;
    
    update bs_Qxmx set mkid='M01000525' where mkid='M01000540' and action='/exp/bidding/buy/aftfic' and sid='M00008';
    -- end

    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toTbzl' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','toTbzl',2,'发标流程 投标资料',1,'M00008');
  end if;
  
      num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveTbzl' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','saveTbzl',2,'发标流程 投标资料',1,'M00008');
  end if;
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toHttstk' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','toHttstk',2,'发标流程 合同特殊条款',1,'M00008');
  end if;
  
      num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveHttstk' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','saveHttstk',2,'发标流程 合同特殊条款',1,'M00008');
  end if;
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toGhxqjsgg' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','toGhxqjsgg',2,'发标流程 供货需求及技术规格',1,'M00008');
  end if;
  
      num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveGhxqjsgg' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','saveGhxqjsgg',2,'发标流程 供货需求及技术规格',1,'M00008');
  end if; 
  
    num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toPbbzxz' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','toPbbzxz',2,'发标流程 评标标准及细则',1,'M00008');
  end if;
  
      num:=0;
  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='savePbbzxz' and STYP=1 and SID='M00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01000505','/exp/bidding/buy/zbwjone','savePbbzxz',2,'发标流程 评标标准及细则',1,'M00008');
  end if; 
  
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='toPsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','toPsbf',2,'发标流程 评标办法页面',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='savePsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','savePsbf',2,'发标流程 保存评标办法',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='toTbxz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','toTbxz',2,'发标流程 投标须知页面',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='saveTbxz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','saveTbxz',2,'发标流程 保存投标须知',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='toHtybtk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','toHtybtk',2,'发标流程 合同一般条款页面',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='saveHtybtk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','saveHtybtk',2,'发标流程 保存合同一般条款',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='toHtgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','toHtgs',2,'发标流程 合同格式页面',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='toTbwjgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','toTbwjgs',2,'发标流程 投标文件格式页面',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjtwo' and METHOD ='saveTbwjgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/zbwjtwo','saveTbwjgs',2,'发标流程 保存投标文件格式',1,'M00008');
	end if;  
	

	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bidview' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/bidview','download',2,'评审办法附件下载',1,'M00008');
	end if; 
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bidview' and METHOD ='downloadFj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000505','/exp/bidding/buy/bidview','downloadFj',2,'评标规则附件下载',1,'M00008');
	end if; 
	
	----tanqinli-start----
	-- 权限设置 发标 制作招标文件
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M083010','M0830','发标','制作招标文件','/exp/bidding/buy/zbwjone/toTbzl.do','/exp/bidding/buy/zbwjone/toTbzl.do',1,100,1,'M00008');
	end if;
	update bs_Qxmx set mkid='M083010' where mkid='M01000505' and action='/exp/bidding/buy/zbwjone' and sid='M00008';
	update bs_Qxmx set mkid='M083010' where mkid='M01000505' and action='/exp/bidding/buy/zbwjtwo' and sid='M00008';
	
	-- 权限明细 发标流程 投标人须知页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toTbrxz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toTbrxz',2,'发标流程-投标人须知页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 保存投标人须知
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='saveTbrxz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','saveTbrxz',2,'发标流程-保存投标人须知',1,'M00008');
	end if;
	-- 权限明细 发标流程 合同条款及格式页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toHttkgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toHttkgs',2,'发标流程-合同条款及格式页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 保存合同条款及格式
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='saveHttkgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','saveHttkgs',2,'发标流程-保存合同条款及格式',1,'M00008');
	end if;
	-- 权限明细 发标流程 工程量清单页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toGclqd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toGclqd',2,'发标流程-工程量清单页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 图纸页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toTz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toTz',2,'发标流程-图纸页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 技术标准和要求页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toJsbzyq' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toJsbzyq',2,'发标流程-技术标准和要求页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 投标文件格式页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='toTbwjgs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','toTbwjgs',2,'发标流程-投标文件格式页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 保存投标文件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjgc' and METHOD ='saveTbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjgc','saveTbwj',2,'发标流程-保存投标文件',1,'M00008');
	end if;
	
	-- 权限设置 菜单选中 发标流程-工程量清单页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toGclqd.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toGclqd.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程-合同条款及格式页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toHttkgs.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toHttkgs.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程-技术标准和要求页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toJsbzyq.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toJsbzyq.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程-投标人须知页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toTbrxz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toTbrxz.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程-投标文件格式页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toTbwjgs.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toTbwjgs.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程-图纸页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjgc/toTz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjgc/toTz.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 供货需求及技术规格
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/toGhxqjsgg.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toGhxqjsgg.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 合同特殊条款
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/toHttstk.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toHttstk.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 评标标准及细则
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/toPbbzxz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toPbbzxz.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 投标资料
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/toTbzl.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toTbzl.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 合同格式页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjtwo/toHtgs.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjtwo/toHtgs.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 合同一般条款页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjtwo/toHtybtk.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjtwo/toHtybtk.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 评标办法页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjtwo/toPsbf.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjtwo/toPsbf.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 投标文件格式页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjtwo/toTbwjgs.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjtwo/toTbwjgs.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标流程 发标流程 投标须知页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjtwo/toTbxz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjtwo/toTbxz.do') where sid='M00008' and mkid='M083010';
	end if;		
	
	-- 权限明细 客户端 获取制作招标文件标段包列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/project' and METHOD ='getZbwjPackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/project','getZbwjPackList',0,'客户端-获取制作招标文件标段包列表',1,'M00008');
	end if;
	
	-- 权限设置 发标 上传标书模板文件
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083015' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M083015','M0830','发标','上传标书模板文件','/exp/bidding/buy/zbwjone/toUpBsmbWj.do','/exp/bidding/buy/zbwjone/toUpBsmbWj.do',1,150,1,'M00008');
	end if;	
	-- 权限明细 发标流程 上传标书模板文件页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toUpBsmbWj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083015','/exp/bidding/buy/zbwjone','toUpBsmbWj',2,'发标流程-上传标书模板文件页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 保存标书模板文件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveBsmbWj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083015','/exp/bidding/buy/zbwjone','saveBsmbWj',2,'发标流程-保存标书模板文件',1,'M00008');
	end if;
	
	----tanqinli-end----
	 

	
----mazg---start---
		--招标管理
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M010005' and mid='M0100';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M010005', 'M0100', '招标管理', '招标管理', '/exp/bidding/buy/project/projectList.do', '/exp/bidding/buy/project/projectList.do#/exp/bidding/buy/project/toAddProject.do#/exp/bidding/buy/project/editProject.do#/exp/bidding/buy/project/update.do#/exp/bidding/buy/project/matterList.do#/exp/bidding/buy/project/addMatter.do#/exp/bidding/buy/project/deleteMatter.do', '1', '100', '1',  'M00008');
	end if;
	--项目列表
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='projectList' and mkid='M010005' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M010005', '/exp/bidding/buy/project', 'projectList', 2, '项目列表', 1, 'M00008');
	end if;
	--新增项目模块
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M01000515' and mid='M0100';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME,  ISUSE, ORDERNO, STYP, PARENT, SID)
		VALUES ('M01000515', 'M0100', '招标管理', '项目建档',  '2', '100',  '1', 'M010005','M00008');
	end if;
	--新增项目标的物
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M01000520' and mid='M0100';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME,  ISUSE, ORDERNO, STYP, PARENT, SID) 
		VALUES ('M01000520', 'M0100', '招标管理', '新增项目标的物',  '2', '200',  '1', 'M010005','M00008');
	end if;
	--跳转项目新增
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='toAddProject' and mkid='M081010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M081010', '/exp/bidding/buy/project', 'toAddProject', '2', '跳转项目新增', '1', 'M00008');
	end if;
	--项目建档（保存）
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='addProject' and mkid='M081010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081010', '/exp/bidding/buy/project', 'addProject', '2', '项目建档（保存）', '1', 'M00008');
	end if;
	--跳转项目编辑
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='editProject' and mkid='M081010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081010', '/exp/bidding/buy/project', 'editProject', '2', '跳转项目编辑', '1', 'M00008');
	end if;
	--编辑保存
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='update' and mkid='M081010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081010', '/exp/bidding/buy/project', 'update', '2', '项目编辑保存', '1', 'M00008');
	end if;

	--获取项目行业分类树
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='getHyfltree' and mkid='0' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('0', '/exp/bidding/buy/project', 'getHyfltree', '0', '获取项目行业分类树', '1', 'M00008');
	end if;
	
	--跳转新增项目标的物页面
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='matterList' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081020', '/exp/bidding/buy/project', 'matterList', '2', '跳转新增项目标的物页面', '1', 'M00008');
	end if;
	--新增项目标的物
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='addMatter' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M081020', '/exp/bidding/buy/project', 'addMatter', '2', '新增项目标的物', '1', 'M00008');
	end if;
	--删除项目标的物
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='deleteMatter' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M081020', '/exp/bidding/buy/project', 'deleteMatter', '2', '删除项目标的物', '1', 'M00008');
	end if;
	--导出采购清单
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='exportExcel' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081020', '/exp/bidding/buy/project', 'exportExcel', '2', '导出采购清单', '1', 'M00008');
	end if;
	--下载模板
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='downLoad' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081020', '/exp/bidding/buy/project', 'downLoad', '2', '下载模板与下载技术附件', '1', 'M00008');
	end if;
	--导入采购清单
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='importFile' and mkid='M081020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M081020', '/exp/bidding/buy/project', 'importFile', '2', '导入采购清单', '1', 'M00008');
	end if;
	--修改招标管理为已有项目
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M010005' and mid='M0100';
	if num=1 then
		update bs_qxsz set name='已有项目',orderno='200' where sid='M00008' and mkid='M010005' and mid='M0100';
	end if;
	--修改项目建档为新建项目
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M01000515' and mid='M0100';
	if num=1 then
	DELETE FROM bs_qxsz  where sid='M00008' and mkid='M01000515' and mid='M0100';
	end if;
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M010010' and mid='M0100';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, url,inurl, ISUSE, ORDERNO, STYP, SID)
		VALUES ('M010010', 'M0100', '招标管理', '新建项目', '/exp/bidding/buy/project/toAddProject.do','/exp/bidding/buy/project/toAddProject.do', '1', '100',  '1','M00008');
	end if;
	--增加项目采购清单
	num:=0;
	select count(1) into num from bs_qxsz where sid = 'M00008'  and mid = 'M0810'  and mkid='M081020';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, url,inurl, ISUSE, ORDERNO, STYP, SID)
		VALUES ('M081020', 'M0810', '招标方案', '项目采购清单', '/exp/bidding/buy/project/matterList.do','/exp/bidding/buy/project/matterList.do', '1', '200',  '1','M00008');
	end if;
	--项目编辑
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M081010' and mid='M0810';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, url,inurl,ISUSE, ORDERNO, STYP, SID)
		VALUES ('M081010', 'M0810', '招标方案', '项目建档', '/exp/bidding/buy/project/toAddProject.do','/exp/bidding/buy/project/toAddProject.do#/exp/bidding/buy/project/editProject.do', '1','200',  '1','M00008');
	end if;
	--项目编辑的inurl
	num:=0;
	select instr(inurl,'/exp/bidding/buy/project/editProject.do') into num from bs_qxsz where sid='M00008' and mkid='M081010' and mid='M0810';
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/project/editProject.do') where sid='M00008' and mkid='M081010' and mid='M0810';
	end if;
	----mazg---end---

	
	
	----xz---start---
	 --资格预审公告inurl 增加 
	 num:=0;
     select instr(inurl,'/exp/bidding/buy/prefic/index.do') into num from bs_qxsz where sid='M00008' and mkid='M089005';
     if num = 0 then   
     	update bs_qxsz set inurl='/exp/bidding/buy/prefic/index.do#/exp/bidding/buy/prefic/doSave.do#/exp/bidding/buy/prefic/toPublish.do#/exp/bidding/buy/prefic/download.do#/exp/bidding/buy/prefic/updateGgbz.do#/exp/bidding/buy/prefic/view.do' where sid='M00008' and mkid='M089005' and inurl='/exp/bidding/buy/prefic/index.do';
     end if;
     
     --资格预审申请人须知inurl 增加
	 num:=0;
     select instr(inurl,'/bdp/bidding/buy/preficfile/toSqrxz.do') into num from bs_qxsz where sid='M00008' and mkid='M010005';
     if num = 0 then
      update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/toSqrxz.do') where sid='M00008' and mkid='M010005';
     end if;
	
	 num:=0;
     select instr(inurl,'/bdp/bidding/buy/preficfile/saveSqrxz.do') into num from bs_qxsz where sid='M00008' and mkid='M010005';
     if num = 0 then
      update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/saveSqrxz.do') where sid='M00008' and mkid='M010005';
     end if;
	-----xz-end--------
	
	----tanqinli-start----
	-- 权限明细 临时 资格预审文件 评审办法页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toPsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000530','/bdp/bidding/buy/preficfile','toPsbf',2,'资格预审文件-评审办法页面',1,'M00008');
	end if;
	-- 权限明细 临时 资格预审文件 保存评审办法
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='savePsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01000530','/bdp/bidding/buy/preficfile','savePsbf',2,'资格预审文件-保存评审办法',1,'M00008');
	end if;	
	-- 权限设置 菜单选中 评审办法页面
	num:=0;
	select instr(inurl,'/bdp/bidding/buy/preficfile/toPsbf.do') into num from bs_qxsz where sid='M00008' and mkid='M010005';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/toPsbf.do') where sid='M00008' and mkid='M010005';
	end if;	
	
	-- 权限明细 竞价销售公告详情打印预览
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='print' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','print',0,'竞价销售公告详情打印预览',1,'M00004');
	end if;
	
	
	----tanqinli-end----
	----xuzhen-start----
    -- 资格预审参考资料，申请文件，申请人须知权限
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M01000530' and mid='M0100' and name='制作资格预审文件';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M01000530', 'M0100', '招标管理', '制作资格预审文件', '2', '', '1', 'M010005', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='toCkzl' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'toCkzl', '2', '参考资料页面', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/swfupload' and  method='uploadFile' and mkid='0' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/common/swfupload', 'uploadFile', '0', 'Swf文件上传', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='saveCkzl' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'saveCkzl', '2', '保存参考资料', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/property' and  method='getList' and mkid='0' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/common/property', 'getList', '0', '获取可用自定义属性', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/property' and  method='getPropValues' and mkid='0' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/common/property', 'getPropValues', '0', '获取属性值', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='toSqwjgs' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'toSqwjgs', '2', '申请文件格式页面', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='saveSqwjgs' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'saveSqwjgs', '2', '保存申请文件格式', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='toSqrxz' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'toSqrxz', '2', '申请人须知页面', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='saveSqrxz' and mkid='M01000530' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01000530', '/bdp/bidding/buy/preficfile', 'saveSqrxz', '2', '保存申请人须知', '1', 'M00008');
    end if;
    ----xuzhen-end----

	---add by longf 评委评分 start---

	------删除老数据
  	num:=0;
  	select count(1) into num from bs_qxmx where ACTION='/psp/judge/score' and STYP=1 and SID='M00009';
  	if num>0 then
  		DELETE FROM bs_qxmx WHERE ACTION='/psp/judge/score' and STYP=1 and SID='M00009';
  		DELETE FROM bs_qxmx WHERE ACTION='/psp/judge/censor' and STYP=1 and SID='M00009' and METHOD ='firstCensor';
  		DELETE FROM bs_qxmx WHERE ACTION='/psp/judge/censor' and STYP=1 and SID='M00009' and METHOD ='firstSave';
  		DELETE FROM bs_qxmx WHERE ACTION='/psp/judge/censor' and STYP=1 and SID='M00009' and METHOD ='firstConfirm';
  	end if;
  
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','index',1,'评委审查-初审界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='loadCensorMb' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','loadCensorMb',1,'评委审查-加载评审办法模版（AJAX调用）',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='save' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','save',1,'评委审查-初审保存（AJAX调用）',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='sealConfirm' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','sealConfirm',1,'评委审查-初审确认提交',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','index',1,'初审汇总界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='sealConfirm' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','sealConfirm',1,'提交初审汇总',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','index',1,'评审报告界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='save' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','save',1,'评审报告界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='sealConfirm' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','sealConfirm',1,'提交评审报告',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/market/syscode/publicfun' and METHOD ='removeFlash' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/market/syscode/publicfun','removeFlash',0,'删除重复的消息提示',1,'M00009');
	end if;
	

	---add by longf 评委评分 end---

	---add by hanglong 招标方流程 start---
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0810' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0810','招标方案',1,100,'M00008','008-1-1','icona'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0820' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0820','约标',1,200,'M00008','008-1-2-1','iconb'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0830' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0830','发标',1,300,'M00008','008-1-3','iconc'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0840' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0840','开标',1,400,'M00008','008-1-4','icond'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0850' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0850','评标',1,500,'M00008','008-1-5','icone'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0860' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0860','定标',1,600,'M00008','008-1-6','iconf'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0870' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0870','合同执行',1,700,'M00008','008-1-7','icong'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0880' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0880','评价',1,800,'M00008','008-1-8','icona'); 
	end if;
	num:=0;
	
	select count(1) into num from bs_xtmk where mid='M0890' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0890','资格预审',1,250,'M00008','008-1-2-2','iconb'); 
	end if;
	---add by hanglong 招标方流程 end---

	---add by hanglong 投标方流程 start---
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0910' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0910','报名',1,100,'M00008','008-2-1','icona'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0920' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0920','投标',1,200,'M00008','008-2-2','iconb'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0930' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0930','开标',1,300,'M00008','008-2-3','iconc'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0940' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0940','评标',1,400,'M00008','008-2-4','icond'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0950' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0950','中标',1,500,'M00008','008-2-5','icone'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0960' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0960','签订合同',1,600,'M00008','008-2-6','iconf'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0970' and  sid='M00008';
	if num=0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole,icon)
		values('M0970','评价',1,700,'M00008','008-2-7','icong'); 
	end if;
	---add by hanglong 投标方流程 end---
	--add by xuzhen 报名确认start ---
	------删除老数据
	num:=0;
    select count(1) into num from bs_qxmx where mkid='M01000505' and  sid='M00008'  and method='checkBm';
    if num>0 then
  	  DELETE FROM BS_QXMX WHERE mkid='M01000505' and  sid='M00008'  and method='checkBm'; 
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M01000505' and  sid='M00008'  and method='confirm';
    if num>0 then
  	  DELETE FROM BS_QXMX WHERE mkid='M01000505' and  sid='M00008'  and method='confirm'; 
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M01000505' and  sid='M00008'  and method='refuse';
    if num>0 then
  	  DELETE FROM BS_QXMX WHERE mkid='M01000505' and  sid='M00008'  and method='refuse'; 
    end if;
	------重新插入数据
	num:=0;
    select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M01000565';
    if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, isuse, styp, parent, sid) 
      values('M01000565', 'M0100', '招标管理', '报名确认', 2, 1, 'M010005', 'M00008');
    end if;
    
	num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/bmqr' and method='checkBm';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M01000565', '/exp/bidding/buy/bmqr', 'checkBm', 2, '报名确认页面', 1, 'M00008'); 
 	 end if; 
  
	 num:=0;
	    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/bmqr' and method='confirm';     
	    if num = 0 then 
	      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
	      values ('M01000565', '/exp/bidding/buy/bmqr', 'confirm', 2, '报名通过', 1, 'M00008'); 
	  end if; 
	  
	 num:=0;
	    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/bmqr' and method='refuse';     
	    if num = 0 then 
	      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
	      values ('M01000565', '/exp/bidding/buy/bmqr', 'refuse', 2, '报名拒绝', 1, 'M00008'); 
	  end if; 
	--add by xuzhen 报名确认 end ---

    num:=0;
    select count(1) into num from bs_qxmx where action='/common/project' and  method='getPackList' and mkid='0' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/common/project','getPackList',0,'客户端-标段包列表',1,'M00008');
    end if;


	
	--add by xuzhen 客户端 预审公告 start ---
	 num:=0;
	    select count(1) into num from  bs_qxmx where sid='M00008' and action='/common/prefic' and method='savePrefic';     
	    if num = 0 then 
	      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
	      values ('0', '/common/prefic', 'savePrefic', 1, '保存预审资格公告', 1, 'M00008');
	 end if; 
    --add by xuzhen 客户端 预审公告 end ---
    --add by jinyanhui 投标方 开标 start ---
  num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M093005' and mid='M0930';
    if num = 0 then
      insert into bs_qxsz (mkid, mid, mname, name ,url ,inurl, isuse, orderno, styp,  sid) 
      values('M093005', 'M0930', '开标', '开标签到解密','/exp/bidding/sell/kbqd/index.do','/exp/bidding/sell/kbqd/index.do', 1,100, 1,  'M00008');
    end if; 
    
  num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M093010' and mid='M0930';
    if num = 0 then
      insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp,  sid) 
      values('M093010', 'M0930', '开标', '开标情况','/exp/bidding/sell/kbqd/show.do','/exp/bidding/sell/kbqd/show.do', 1,200, 1,  'M00008');
    end if; 
        --add by jinyanhui 投标方 开标 end ---

	--add by zhaiyy 澄清文件start ---
 	
    ------删除老数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082050' and  sid='M00008' and mid='M0820';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE MKID='M082050' AND SID='M00008' AND MID='M0820';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/buy/notice' AND MKID='M082050' AND SID='M00008';
    end if;
  	
  	------重新插入数据 澄清文件
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M082050' and mid='M0820';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M082050','M0820','约标','澄清文件','/exp/bidding/cqnotice/list.do','/exp/bidding/cqnotice/list.do#/exp/bidding/cqnotice/toAdd.do#/exp/bidding/cqnotice/save.do#/exp/bidding/cqnotice/preview.do#/exp/bidding/cqnotice/submit.do#/exp/bidding/cqnotice/downLoad.do#/exp/bidding/cqnotice/edit.do#/exp/bidding/cqnotice/delete.do',1,'100',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='list' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'list', 2, '澄清文件列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='toAdd' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'toAdd', 2, '新增澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='save' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'save', 2, '保存澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='preview' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'preview', 2, '预览澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='submit'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'submit', 2, '提交澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='downLoad' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'downLoad', 2, '下载公告附件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='edit' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'edit', 2, '澄清文件编辑', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='delete' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082050', '/exp/bidding/cqnotice', 'delete', 2, '澄清文件删除', 1, 'M00008');
    end if;
	
	--add by zhaiyy 澄清文件end ---

	--add by zhaiyy 变更公告 start ---

	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M082085' and mid='M0820';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M082085','M0820','约标','变更公告','/exp/bidding/bgnotice/list.do','/exp/bidding/bgnotice/list.do#/exp/bidding/bgnotice/toAdd.do#/exp/bidding/bgnotice/save.do#/exp/bidding/bgnotice/preview.do#/exp/bidding/bgnotice/submit.do#/exp/bidding/bgnotice/downLoad.do#/exp/bidding/bgnotice/edit.do#/exp/bidding/bgnotice/delete.do',1,'200',1,'','M00008',1);
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='list'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'list', 2, '变更公告列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='toAdd' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'toAdd', 2, '新增变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='save'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'save', 2, '保存变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='preview' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'preview', 2, '预览变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='submit' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'submit', 2, '更新变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='downLoad' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'downLoad', 2, '下载公告附件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='edit'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'edit', 2, '变更公告编辑', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='delete' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M082085', '/exp/bidding/bgnotice', 'delete', 2, '变更公告删除', 1, 'M00008');
    end if;
    
	--add by zhaiyy 变更公告 end ---

	--add by longf start ---
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='info' and sid='B00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01050505','/bdm/expert','info',2,'专家管理-专家详情页',2,'B00008');
    end if;
  
    update bs_xtmk set ordby='100' where mid='B0105' and sid='B00008' and mname='专家管理';
    update bs_xtmk set ordby='200' where mid='B0110' and sid='B00008' and mname='招标管理';
    update bs_xtmk set ordby='500' where mid='B0100' and sid='B00008' and mname='基本设置';
    update bs_xtmk set ordby='600' where mid='B0200' and sid='B00008' and mname='系统管理';
	--add by longf end ---

	----tanqinli-start----
  	-- 权限设置 报名 资格预审公告及报名
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M091005','M0910','报名','资格预审公告及报名','/exp/bidding/sell/signup/toZgysSignup.do','/exp/bidding/sell/signup/toZgysSignup.do',1,100,1,'M00008');
	end if;
	-- 权限明细 报名 报名(资格预审公告)页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toZgysSignup' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091005','/exp/bidding/sell/signup','toZgysSignup',2,'报名-报名(资格预审公告)页面',1,'M00008');
	end if;	
	
	-- 权限设置 报名 招标公告查看及报名
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M091010','M0910','报名','招标公告查看及报名','/exp/bidding/sell/signup/toZbSignup.do','/exp/bidding/sell/signup/toZbSignup.do',1,150,1,'M00008');
	end if;
	-- 权限明细 报名 报名(招标公告)页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toZbSignup' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091010','/exp/bidding/sell/signup','toZbSignup',2,'报名-报名(招标公告)页面',1,'M00008');
	end if;
	-- 权限明细 报名 报名
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='doSignup' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091010','/exp/bidding/sell/signup','doSignup',2,'报名-报名',1,'M00008');
	end if;
	
	-- 权限明细 报名 投标公告列表页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='index' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/signup','index',0,'报名-投标公告列表页面',1,'M00008');
	end if;
	-- 权限明细 报名 公告详情页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toZbggInfo' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/signup','toZbggInfo',0,'报名-公告详情页面',1,'M00008');
	end if;
	-- 权限明细 报名 公告附件下载
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/signup','download',0,'报名-公告附件下载',1,'M00008');
	end if;
	----tanqinli-end----
	
	----tanqinli-start----
	-- 系统模块 模板管理
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0500' and sid='M00008';
	if num = 0 then
	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole,icon)
	 values('M0500','模板管理',1,150,'M00008','008-1','');
	end if;
	-- 权限设置 模板管理 资审模板
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050005','M0500','模板管理','资审模板','/exp/bidding/buy/pbmb/zsmblist.do','/exp/bidding/buy/pbmb/zsmblist.do#/exp/bidding/buy/pbmb/toAddZsmb.do#/exp/bidding/buy/pbmb/toEditZsmb.do',1,100,1,'M00008');
	end if;
	-- 权限明细 模板管理 资审模板列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='zsmblist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','zsmblist',2,'模板管理-资审模板列表',1,'M00008');
	end if;
	-- 权限明细 模板管理 新增资审模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='toAddZsmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','toAddZsmb',2,'模板管理-新增资审模板页面',1,'M00008');
	end if;
	-- 权限明细 模板管理 编辑资审模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='toEditZsmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','toEditZsmb',2,'模板管理-编辑资审模板页面',1,'M00008');
	end if;
	-- 权限明细 模板管理 保存评标模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='save' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','save',1,'模板管理-保存评标模板',1,'M00008');
	end if;
	-- 权限明细 模板管理 删除评标模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='delete' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','delete',1,'模板管理-删除评标模板',1,'M00008');
	end if;
	-- 权限设置 模板管理 评标模板
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050010','M0500','模板管理','评标模板','/exp/bidding/buy/pbmb/pbmblist.do','/exp/bidding/buy/pbmb/pbmblist.do#/exp/bidding/buy/pbmb/toAddPbmb.do#/exp/bidding/buy/pbmb/toEditPbmb.do',1,200,1,'M00008');
	end if;
	-- 权限明细 模板管理 评标模板列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='pbmblist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050010','/exp/bidding/buy/pbmb','pbmblist',2,'模板管理-评标模板列表',1,'M00008');
	end if;
	-- 权限明细 模板管理 新增评标模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='toAddPbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050010','/exp/bidding/buy/pbmb','toAddPbmb',2,'模板管理-新增评标模板页面',1,'M00008');
	end if;
	-- 权限明细 模板管理 编辑评标模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='toEditPbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050010','/exp/bidding/buy/pbmb','toEditPbmb',2,'模板管理-编辑评标模板页面',1,'M00008');
	end if;
	-- 权限明细 模板管理 查看资审模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='zsmbInfo' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050005','/exp/bidding/buy/pbmb','zsmbInfo',2,'模板管理-查看资审模板页面',1,'M00008');
	end if;
	-- 权限明细 模板管理 查看评标模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='pbmbInfo' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050010','/exp/bidding/buy/pbmb','pbmbInfo',2,'模板管理-查看评标模板页面',1,'M00008');
	end if;
	
	-- 权限设置 菜单选中 查看资审模板页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/pbmb/zsmbInfo.do') into num from bs_qxsz where sid='M00008' and mkid='M050005';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/pbmb/zsmbInfo.do') where sid='M00008' and mkid='M050005';
	end if;
	-- 权限设置 菜单选中 查看评标模板页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/pbmb/pbmbInfo.do') into num from bs_qxsz where sid='M00008' and mkid='M050010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/pbmb/pbmbInfo.do') where sid='M00008' and mkid='M050010';
	end if;
	
	
	-- 权限明细 客户端 评标模板 获取评标模板列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/pbmb' and METHOD ='getPbmbList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/pbmb','getPbmbList',0,'客户端-评标模板-获取评标模板列表',1,'M00008');
	end if;
	
	-- 权限设置 约标 后审公告编制
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0820' and mkid='M082010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M082010','M0820','约标','后审公告编制','/exp/bidding/buy/aftfic/index.do','/exp/bidding/buy/aftfic/index.do#/exp/bidding/buy/aftfic/view.do',1,60,1,'M00008');
	end if;
	update bs_Qxmx set mkid='M082010' where mkid='M01000525' and action='/exp/bidding/buy/aftfic' and sid='M00008';
		
	----tanqinli-end----

	
	--add by mazg start ---
	--qxsz购买资格预审文件
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M091020','M0910','报名','购买资格预审文件','/exp/bidding/sell/signup/list.do','/exp/bidding/sell/signup/list.do#/exp/bidding/sell/signup/buy.do',1,200,1,'M00008');
	end if;
	--qxmx
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','list',2,'资格预审文件标段包',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='buy' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','buy',2,'资格预审文件购买',1,'M00008');
	end if;
	--add by mazg end ---

	--add by longf start ---
 	------删除老数据
  	num:=0;
	select count(1) into num from bs_qxmx where action='/psp/judge/censor' and styp=1 and sid='M00009' and method ='secondCensor';
	if num>0 then
		delete from bs_qxmx where action='/psp/judge/censor' and method ='secondCensor' and sid='M00009';
		delete from bs_qxmx where action='/psp/judge/censor' and method ='secondSave' and sid='M00009';
		delete from bs_qxmx where action='/psp/judge/censor' and method ='secondConfirm' and sid='M00009';
	end if;
	num:=0;
  	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sift' and STYP=1 and SID='M00009';
  	if num>0 then
  		DELETE FROM bs_qxmx WHERE ACTION='/psp/judge/sift' and STYP=1 and SID='M00009';
  	end if;
  	
	------更新数据

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','index',1,'评委审查-详审界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='save' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','save',1,'评委审查-详审保存（AJAX调用）',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='sealConfirm' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','sealConfirm',1,'评委审查-详审确认提交',1,'M00009');
	end if;
	--add by longf end ---

	--add by xuz start ---
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='clariFication' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','clariFication',1,'问题澄清界面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='saveClari' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','saveClari',1,'保存问题澄清提问',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='clariList' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','clariList',1,'问题澄清提问列表页面',1,'M00009');
	end if;
	--add by xuz end ---


----hejw------start-------------
--招标项目 权限-------------------
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M081025' and SID='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M081025','M0810','招标方案','招标项目','/exp/bidding/buy/subproject/list.do','/exp/bidding/buy/subproject/list.do',1,300,1,'M00008');
	end if;
  
  --增加inurl
  update bs_qxsz set inurl='/exp/bidding/buy/subproject/list.do#/exp/bidding/buy/subproject/saveSubproject.do#/exp/bidding/buy/subproject/toSubproject.do#/exp/bidding/buy/subproject/toSubpType.do#/exp/bidding/buy/subproject/updateSubproject.do#/exp/bidding/buy/subproject/editSubproject.do#/exp/bidding/buy/subproject/subpInfo.do#/exp/bidding/buy/subproject/download.do#/exp/bidding/buy/subproject/wtxybz.do#/exp/bidding/buy/subproject/wtxybzUp.do#/exp/bidding/buy/subproject/getproItemJson.do#/exp/bidding/buy/subproject/listBom.do#/exp/bidding/buy/subproject/delSubproject.do#' where  mkid='M081025' and SID='M00008' and inurl='/exp/bidding/buy/subproject/list.do';
  
 --招标项目列表
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='list';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'list', 2, '招标项目-列表', 1, 'M00008'); 
  end if;
  
  --招标项目-新增页面
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='toSubproject';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'toSubproject', 2, '招标项目-新增页面', 1, 'M00008'); 
  end if;

 --招标项目-保存
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='saveSubproject';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'saveSubproject', 2, '招标项目-保存方法', 1, 'M00008'); 
  end if;
  
  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='editSubproject';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'editSubproject', 2, '招标项目-修改页面', 1, 'M00008'); 
  end if;

num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='updateSubproject';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'updateSubproject', 2, '招标项目-修改', 1, 'M00008'); 
  end if;
  
  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='listBom';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'listBom', 2, '项目-标的物-列表', 1, 'M00008'); 
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and sid = 'M00008' and method='getproItemJson';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081025','/exp/bidding/buy/subproject','getproItemJson','2','项目-标的物json','1','M00008');
  end if;
  
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/subproject' and  method='download' and mkid='M081025' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M081025','/exp/bidding/buy/subproject','download',1,'招标项目-文件下载',1,'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/subproject' and  method='wtxybz' and mkid='M081025' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M081025','/exp/bidding/buy/subproject','wtxybz',2,'招标项目-委托协议编制显示',1,'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/subproject' and  method='wtxybzUp' and mkid='M081025' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M081025','/exp/bidding/buy/subproject','wtxybzUp',2,'招标项目-委托协议编制更新',1,'M00008');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/subproject' and METHOD ='delSubproject' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M081025','/exp/bidding/buy/subproject','delSubproject',2,'招标项目-删除',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/subproject' and METHOD ='toSubpType' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M081025','/exp/bidding/buy/subproject','toSubpType',2,'招标项目-分类选择',1,'M00008');
	end if;
	--招标项目 权限-----------------
	
	--标段包 权限-hejw --start---------
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M081030' and SID='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M081030','M0810','招标方案','标段（包）','/exp/bidding/buy/package/list.do','/exp/bidding/buy/package/list.do',1,400,1,'M00008');
	end if;
  
  --增加inurl
  update bs_qxsz set inurl='/exp/bidding/buy/package/list.do#/exp/bidding/buy/package/getPackgeFldmJson.do#/exp/bidding/buy/package/listBom.do#/exp/bidding/buy/package/dowloadBdwFile.do#/exp/bidding/buy/package/edit.do#/exp/bidding/buy/package/update.do#/exp/bidding/buy/package/info.do#/exp/bidding/buy/package/getSubproItemJson.do#/exp/bidding/buy/package/delete.do#/exp/bidding/buy/package/add.do#/exp/bidding/buy/package/save.do#' where  mkid='M081030' and SID='M00008' and inurl='/exp/bidding/buy/package/list.do';
  
  
   --标的物列表
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/package' and method='list';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081030', '/exp/bidding/buy/package', 'list', 2, '标的物-列表', 1, 'M00008'); 
  end if;
  
    num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='delete';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','delete','2','标段包-删除','1','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='add';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','add','2','标段包-增加','1','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='save';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','save','2','标段包-保存','1','M00008');
  end if;
  
 num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='edit';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','edit','2','标段包-编辑','1','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='update';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','update','2','标段包-更新','1','M00008');
  end if;
	
  num:=0;
  select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='listBom';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M081030','/exp/bidding/buy/package','listBom','2','招标项目-标的物-列表','1','M00008');
  end if;
----hejw------end------------

--客户端AJAX---hejw---start----
  num:=0;
  select count(1) into num from bs_qxmx where  action='/common/project' and sid = 'M00008' and method='getPackList';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('0','/common/project','getPackList','0','客户端-标段包列表','1','M00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/common/project' and sid = 'M00008' and method='editWhetherTemp';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('0','/common/project','editWhetherTemp','0','客户端-标段包选择模板','1','M00008');
  end if;
--客户端AJAX---hejw---end----

 ---add by xuz 资格预审文件上传 start---
	--资格预审文件上传
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089010';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse,orderno, styp, sid ,qxrole) 
    	values('M089010', 'M0890', '资格预审', '资格预审文件上传','/bdp/bidding/buy/preficfile/toScZgyswj.do','/bdp/bidding/buy/preficfile/toScZgyswj.do', 1,100, 1, 'M00008','008-1-2-2');
  	end if;
  	
  	--资格预审文件预览
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089015';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse,orderno, styp, sid ,qxrole) 
    	values('M089015', 'M0890', '资格预审', '资格预审文件预览','/bdp/bidding/buy/preficfile/viewZgyswj.do','/bdp/bidding/buy/preficfile/download.do', 1,100, 1, 'M00008','008-1-2-2');
  	end if; 
  	
	--资格预审文件上传
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toScZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','toScZgyswj',2,'资格预审文件上传',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='saveZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','saveZgyswj',2,'保存资格预审文件',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='viewZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','viewZgyswj',2,'预览资格预审文件',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','download',2,'下载资格预审文件',1,'M00008');
	end if;
---add by xuz 资格预审文件上传 end---
	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='delExpert' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'delExpert', 2, '组建资格预审委员会-删除指定专家/业主代表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='toOwner' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'toOwner', 2, '组建资格预审委员会-增加业主代表界面', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='delExpert' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'delExpert', 2, '组建评标委员会-删除指定专家/业主代表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='toOwner' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'toOwner', 2, '组建评标委员会-增加业主代表界面', 1, 'M00008');
	end if;
	--add by longf end ---

	--add by chenxp start ---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and sid = 'M00008' and method='hsPackList';
    if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M082070','/exp/bidding/buy/yqhs','hsPackList','2','标段包列表','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and sid = 'M00008' and method='invitationUnit';
       if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M082070','/exp/bidding/buy/yqhs','invitationUnit','2','邀请单位列表','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and sid = 'M00008' and method='saveInvitation';
    if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M082070','/exp/bidding/buy/yqhs','saveInvitation','2','添加邀请单位','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and sid = 'M00008' and method='invitationInfor';
       if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    values('M082070','/exp/bidding/buy/yqhs','invitationInfor','2','查看标段（包）邀请单位','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and sid = 'M00008' and method='delInvitation' ;
    if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M082070','/exp/bidding/buy/yqhs','delInvitation','2','删除标段（包）邀请单位','1','M00008');
    end if;
  

    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/hsPackList.do') into num from bs_qxsz where sid='M00008' and mkid='M082070';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/hsPackList.do') where sid='M00008' and mkid='M082070';
    end if;

    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/invitationUnit.do') into num from bs_qxsz where sid='M00008' and mkid='M082070';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/invitationUnit.do') where sid='M00008' and mkid='M082070';
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/saveInvitation.do') into num from bs_qxsz where sid='M00008' and mkid='M082070';
    if num = 0 then
    update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/saveInvitation.do') where sid='M00008' and mkid='M082070';
    end if;
   
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/invitationInfor.do') into num from bs_qxsz where sid='M00008' and mkid='M082070';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/invitationInfor.do') where sid='M00008' and mkid='M082070';
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/delInvitation.do') into num from bs_qxsz where sid='M00008' and mkid='M082070';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/delInvitation.do') where sid='M00008' and mkid='M082070';
    end if;
	
	--add by chenxp end ---

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
