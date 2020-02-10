DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.82'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count (1) into num from  bs_qxmx where sid='M00004' and action='/swfupload' and method='upload';
	if num = 1 then
		update bs_qxmx set accesstag = 0 where sid='M00004' and action='/swfupload' and method='upload';
	END IF;
	
	--- 2015/06/17	hanglong	手机版查看分类	---
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/allthing' and  method='category';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/allthing','category',0,'手机版-查看大类',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/allthing' and  method='getCategory';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/allthing','getCategory',0,'手机版-获得大类下的子类',1,'M00201');
	end if;
	--- end ---
	
	-- 2015-06-18  lvcyong 手机发现  ---
	num:=0;
		select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0135'  and mkid='B013520';       
	if num = 0 then 
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B013520', 'B0135', '系统管理', '信息发布', '/exm/msg/publish/list.do', NULL, '1', '300', '2', NULL, 'B00201');
    end if;
	
	num:=0;
		select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0135'  and mkid='B01352005';       
	if num = 0 then 
		INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B01352005', 'B0135', '系统管理', '编辑', NULL, NULL, '2', '205', '2', 'B013520', 'B00201');
    end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B013520' and  sid='B00201' and action = '/exm/msg/publish' and  method='list';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B013520', '/exm/msg/publish', 'list', '2', '信息发布-查询', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='toAdd';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'toAdd', '2', '新增消息页面', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='save';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'save', '2', '新增消息', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='toEdit';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'toEdit', '2', '修改消息页面', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='update';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'update', '2', '修改消息', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='delete';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'delete', '2', '删除消息', '2', 'B00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/msg/publish' and  method='list';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/msg/publish', 'list', '0', '发现-消息列表', '1', 'M00201');
	end if;
    
    num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/msg/publish' and  method='info';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/msg/publish', 'info', '0', '发现-消息详情', '1', 'M00201');
	end if;
	-- end --

	--hejw --在增加手机 bs权限
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/reg' and  method='reg' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/reg','reg',0,'APP-个人会员-注册',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/reg' and  method='sendMobileCode' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/reg','sendMobileCode',0,'APP-个人会员-注册-发送短信',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='info' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','info',0,'APP-查看操作员信息',1,'M00201');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='updateInfo' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','updateInfo',0,'APP-修改操作员信息',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='updatePwd' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','updatePwd',0,'APP-修改操作员密码',1,'M00201');
    end if;    
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='upload' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','upload',0,'APP-上传操作员图片',1,'M00201');
    end if; 
    
    ------lvcy 2015-06-19----
    num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='B00201' and action = '/swfupload' and  method='upload';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/swfupload', 'upload', '0', '文件上传', '2', 'B00201');
	end if;
	
    num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='B00201' and action = '/swfupload' and  method='uploadKindEditor';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/swfupload', 'uploadKindEditor', '1', '编辑器图片上传', '2', 'B00201');
	end if;
	
    num:=0;
		select count(1) into num from bs_qxmx where mkid='B01352005' and  sid='B00201' and action = '/exm/msg/publish' and  method='show';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B01352005', '/exm/msg/publish', 'show', '2', '查看消息', '2', 'B00201');
	end if;
	
	UPDATE "BS_QXSZ" 
		SET  "INURL"='/exm/msg/publish/toEdit.do#/exm/msg/publish/toAdd.do#/exm/msg/publish/show.do' 
		WHERE "MKID" = 'B013520' and "SID" = 'B00201';
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='list';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'list', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='toSave';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'toSave', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='save';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'save', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='toUpdate';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'toUpdate', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='update';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'update', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
	num:=0;
		select count(1) into num from bs_qxmx where mkid='0' and  sid='M00201' and action = '/exp/entrust/shipper/manage' and  method='delete';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'delete', '1', '发货/收货人', '1', 'M00201');
	end if;	
	
    ----------
    --end--
    

	  -- hejw --交易app权限配置
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and sid='M00201' and method='getAccountSum';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/bk/subaccount/inout','getAccountSum',1,'APP-交易账户总余额',1,'M00201');
	  end if; 
	  
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and sid='M00201' and method='list';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/bk/subaccount/inout','list',1,'APP-交易账户流水',1,'M00201');
	  end if; 
	
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and sid='M00201' and method='getAccount';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/bk/subaccount/inout','getAccount',1,'APP-交易账户余额',1,'M00201');
	  end if;
	  
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and sid='M00201' and method='ddlist';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/bk/subaccount/inout','ddlist',1,'APP-交易订单计划明细',1,'M00201');
	  end if; 
		-- end--	

	-- 浏览记录
      num:=0;
	     select count(1) into num from bs_qxmx where action='/allthing' and sid='M00201' and method='browse';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/allthing','browse',1,'手机版-浏览记录',1,'M00201');
	  end if; 
	  
	--删除 浏览记录	  
      num:=0;
	     select count(1) into num from bs_qxmx where action='/allthing' and sid='M00201' and method='delBrowse';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/allthing','delBrowse',1,'手机版-删除浏览记录',1,'M00201');
	  end if;
	  
	--个人或企业信息
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and sid='M00201' and method='pinfo';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/bsp/menber/userinfo','pinfo',1,'APP-个人或企业信息',1,'M00201');
	  end if;
	  
	  --zhminfu --手机APP 会员登录
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/login' and  method='doLogin' and mkid='0' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/login','doLogin',0,'手机APP-会员登录',1,'M00201');
	  end if;
	  
	  --手机端找回密码
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/menber/getpassword' and  method='step1' and mkid='0' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/exp/menber/getpassword','step1',0,'手机端-找回密码第1步',1,'M00201');
	  end if;
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/menber/getpassword' and  method='step2' and mkid='0' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/exp/menber/getpassword','step2',0,'手机端-找回密码第2步',1,'M00201');
	  end if;
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/menber/getpassword' and  method='step3' and mkid='0' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/exp/menber/getpassword','step3',0,'手机端-找回密码第3步',1,'M00201');
	  end if;
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/menber/getpassword' and  method='sendRandomCode' and mkid='0' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/exp/menber/getpassword','sendRandomCode',0,'手机端-找回密码获得手机验证码',1,'M00201');
	  end if;
	  
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/shopping' and  method='uptQut' and  sid='M00201';
	  if num=0 then
	      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	      values('0','/exp/hangsource/buy/shopping','uptQut',1,'手机APP-购物车修改数量',1,'M00201');
	  end if;


	 --收货地址分页
	  num:=0;
	     select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and sid='M00201' and method='getConsignee';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/exp/hangsource/buy/createbill','getConsignee',1,'APP-收货地址分页',1,'M00201');
	  end if; 
	  --询价卖家 查看权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and  method='showTd' and mkid='M018005' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M018005','/exp/querybusiness/process/sell','showTd',2,'询价管理查看',1,'M00004');
    end if;

	  
	--废旧物资新增修改 inurl  
 	num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mkid='M023550' and mid='M0235' and url='/exp/auction/sell/bout/category.do';
    if num=1 then
        update bs_qxsz set inurl='/exp/auction/sell/bout/category.do#/exp/auction/sell/bout/toAdd.do#/exp/auction/sell/bout/toEdit.do' where sid='M00004' and mkid='M023550' and mid='M0235' and url='/exp/auction/sell/bout/category.do';
    end if;
	
	--hejw 手机端 待评分
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and  method='waitscore' and mkid='M010815' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M010815','/exp/contract/buy/manage','waitscore',2,'APP采购订单-待评分',1,'M00201');
    end if;
	
	--- 2015/06/29	hanglong	手机端查看订单物流信息
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='getAjaxPsInfo' and mkid='0' and sid='M00201';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/contract/buy/manage','getAjaxPsInfo',1,'手机端查看订单物流信息',1,'M00201');
	end if;
	--- end ---

	--支付登记 点亮  hejw
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mkid ='M015505' and mid='M0155' and url='/tdp/trail/pay/list.do';
    if num=1 then
       update bs_qxsz set inurl='/tdp/trail/pay/list.do#/tdp/trail/pay/payList.do#/tdp/trail/pay/getPayList.do#/tdp/trail/pay/showInfo.do#/tdp/trail/pay/toEditPay.do'  where sid='M00004' and mkid ='M015505' and mid='M0155' and url='/tdp/trail/pay/list.do';
    end if;
    
    --新增积压物资 左边选中修改  hejw
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and url='/tdp/overstock/manage/index.do' and mid='M0285' and mkid='M028535';
    if num=1 then
        update bs_qxsz set inurl='/tdp/overstock/manage/index.do#/tdp/overstock/manage/add.do#/tdp/overstock/manage/save.do#/tdp/overstock/manage/delete.do#/tdp/overstock/manage/deletemore.do' where sid='M00004' and url='/tdp/overstock/manage/index.do' and mid='M0285' and mkid='M028535';
    end if;
	
	-- 2015/07/03	hanglong	获得首页顶部页面
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/' and  method='headWeb' and mkid='0' and  sid='M00004';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','headWeb',0,'获得首页顶部页面',1,'M00004');
    end if;

	--wxd2015/07/04 卖家选择代理商-----------
 	num:=0;
		select count(1) into num from bs_qxmx where styp=1 and  sid='M00201' and action = '/exp/contract/sell/manage' and  method='chooseAgent';
	if num=0 then
		INSERT INTO BS_QXMX(MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
		VALUES ('0', '/exp/contract/sell/manage', 'chooseAgent', 0, '卖家选择代理商', 1, 'M00201');
	end if;
	
	-- lvcy 2015/07/06  反馈意见
	num:=0;
		select count(1) into num from BS_CODES where code='1' and  typ='意见反馈类型';
	if num=0 then
		INSERT INTO "BS_CODES" ("TYP", "CODE", "VALUE", "ISUSE", "ORDERNO") 
		VALUES ('意见反馈类型', '1', '功能意见', '1', '100');
	end if;
	
	num:=0;
		select count(1) into num from BS_CODES where code='2' and  typ='意见反馈类型';
	if num=0 then
		INSERT INTO "BS_CODES" ("TYP", "CODE", "VALUE", "ISUSE", "ORDERNO") 
		VALUES ('意见反馈类型', '2', '系统问题', '1', '200');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where sid='B00201' and url='/exm/feedback/manage/list.do' and mid='B0135' and mkid='B013525';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B013525', 'B0135', '系统管理', '意见反馈', '/exm/feedback/manage/list.do', NULL, '1', '100', '2', NULL, 'B00201');
    end if;
	
	num:=0;
		select count(1) into num from bs_qxmx where styp=2 and  sid='B00201' and action = '/exm/feedback/manage' and  method='list';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('B013525', '/exm/feedback/manage', 'list', '2', '意见反馈-查询', '2', 'B00201');
	end if;
	
	num:=0;
		select count(1) into num from bs_qxmx where styp=1 and  sid='M00201' and action = '/exp/feedback/manage' and  method='toSave';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/feedback/manage', 'toSave', '1', '意见反馈-页面', '1', 'M00201');
	end if;
	
	num:=0;
		select count(1) into num from bs_qxmx where styp=1 and  sid='M00201' and action = '/exp/feedback/manage' and  method='save';
	if num=0 then
		INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/feedback/manage', 'save', '1', '意见反馈-保存', '1', 'M00201');
	end if;
	
	
	update bs_qxsz set isuse=1 where parent is null and mid in('B0110','B0113') and sid='B00104';
	
	--hejw  增加我的平台权限
	num:=0;
    select count(1) into num from bs_qxmx where action='/me/home' and  method='home' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/me/home','home',1,'手机端-我的平台',1,'M00201');
    end if;
    
    --后台 商品推荐
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/hangsource/hangquery' and  method='sptj' and mkid='B01051005' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01051005','/exm/hangsource/hangquery','sptj',2,'商品推荐',2,'B00201');
    end if;
    
    --手机端  发票信息列表
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and  method='invoicelist' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/hangsource/buy/createbill','invoicelist',1,'APP-发票列表信息',1,'M00201');
    end if;
    
    --hjw
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/supplier/regaudit' and  method='checkEmail' and mkid='0' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/supplier/regaudit','checkEmail',0,'检查管理员电子邮箱',2,'B00000');
    end if;
    
    -- lvcy 2015-07-16 询价交易-成交结果导出
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/tdcontract/buy/manage' and  method='export2Excel' and mkid='M025020' and  sid='M00004';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('M025020', '/exp/tdcontract/buy/manage', 'export2Excel', '2', '成交结果-采购订单导出', '1', 'M00004');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/tdcontract/sell/manage' and  method='export2Excel' and mkid='M025010' and  sid='M00004';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('M025010', '/exp/tdcontract/sell/manage', 'export2Excel', '2', '成交结果-销售订单导出', '1', 'M00004');
    end if;
    
    UPDATE "BS_QXSZ" SET "INURL"='/exp/auction/sell/bout/category.do#/exp/auction/sell/bout/toAdd.do' WHERE MKID = 'M023550' AND "SID" = 'M00004';
	UPDATE "BS_QXSZ" SET "INURL"='/exp/auction/sell/bout/list.do#/exp/auction/sell/tray/toShowZzxx.do#/exp/auction/sell/bout/toEdit.do' WHERE MKID = 'M023520' AND "SID" = 'M00004';
    
    -- 2015-07-20 lvcy
    UPDATE "BS_QXSZ" SET "MNAME"='废旧物资管理', "NAME"='废旧物资申请审核' WHERE "SID" = 'B00004' and "MKID"='B012510';
	UPDATE "BS_QXSZ" SET "MNAME"='废旧物资管理', "NAME"='废旧物资交易管理' WHERE "SID" = 'B00004' and "MKID"='B012530';
	UPDATE "BS_QXSZ" SET "MNAME"='废旧物资管理' WHERE "SID" = 'B00004' and "MKID"='B012540';
	UPDATE "BS_QXSZ" SET "MNAME"='废旧物资管理' WHERE "SID"='B00004' AND "MKID"='B012520';
	UPDATE "BS_XTMK" SET "MNAME"='废旧物资管理' WHERE "MID"='B0125' and  "SID"='B00004';
    
     -- 2015-07-23 lvcy
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/sell/bout' and  method='showInfo' and mkid='0' and  sid='M00004';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/auction/sell/bout', 'showInfo', '1', '废旧物资场次详情', '1', 'M00004');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='showInfo' and mkid='0' and  sid='M00004';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/auction/buy/bout', 'showInfo', '1', '废旧物资场次详情', '1', 'M00004');
    end if;
	
	--hejw   2015-07-28
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and  method='importFileCpxx' and mkid='M01700505' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01700505','/exp/querybusiness/buy','importFileCpxx',1,'询比价新增-导入产品资源信息到页面',1,'M00004');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and  method='downLoadModel' and mkid='M01700505' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01700505','/exp/querybusiness/buy','downLoadModel',1,'询比价新增-下载模板',1,'M00004');
    end if;    
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and  method='downPage' and mkid='M01700505' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M01700505','/exp/querybusiness/buy','downPage',1,'询比价新增-导入产品页面',1,'M00004');
    end if; 
	
	
	--废旧物资ajax更新状态 wxd
 	num:=0;
    select count(1) into num from bs_qxmx where sid='M00004' and styp=1 and action='/exp/auction/autofreshstatus' and method='autoStartAuctionAjax';
    if num=0 then
         insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/auction/autofreshstatus','autoStartAuctionAjax',0,'废旧物资ajax更新状态',1,'M00004');
    end if;
    
    -- lvcy 2015/07/31
	num:=0;
    select count(1) into num from bs_qxmx where action='/login' and  method='isLogin' and mkid='0' and  sid='M00201';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/login', 'isLogin', '0', '手机APP-会员是否登录', '1', 'M00201');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/login' and  method='doLogout' and mkid='0' and  sid='M00201';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/login', 'doLogout', '1', '手机APP-会员退出登录', '1', 'M00201');
    end if;
    
    
    --采购中、采购结果修改为竞价中、竞价结果  hjw
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mid='M0205' and mkid='M020530' and url='/exp/tender/buy/evaluate/list.do';    
	if num = 1 then
		update bs_qxsz set name='竞价中' where sid='M00004' and mid='M0205' and mkid='M020530' and url='/exp/tender/buy/evaluate/list.do';
	end if;
  
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mid='M0205' and mkid='M020540' and url='/exp/tender/buy/result/list.do';    
	if num = 1 then
		update bs_qxsz set name='竞价结果' where sid='M00004' and mid='M0205' and mkid='M020540' and url='/exp/tender/buy/result/list.do';
	end if;
	
	--物资品种是否前端显示（后台）  wxd
 	num:=0;
    select count(1) into num from bs_qxmx where sid='B00004' and styp=2 and action='/exm/basesetup/setpz' and method='clientShowOrHide';
    if num=0 then
         insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01051005','/exm/basesetup/setpz','clientShowOrHide',2,'物资品种是否前端显示',2,'B00004');
    end if;
    
    -- 2015-08-10 lvcy app地区列表
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/market/publicfun' and method='getAllAreaInSm';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/market/publicfun', 'getAllAreaInSm', '0', '获取省或者市列表（App）', '1', 'M00201');
    end if;
    
    
    -----hejw--将【竞价采购】下面的 待发布、竞价中、竞价结果 合成 一个------------
	  --新增两个子权限
	  num:=0;
	  select count(1) into num from bs_qxsz where sid='M00004' and mid='M0205' and mkid='M02051015' and mname='竞价采购' and name='竞价中';
	  if num=0 then
	      insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
	      values('M02051015','M0205','竞价采购','竞价中',2,100,1,'M020510','M00004');
	  end if;
	
	  num:=0;
	  select count(1) into num from bs_qxsz where sid='M00004' and mid='M0205' and mkid='M02051020' and mname='竞价采购' and name='竞价结果';
	  if num=0 then
	      insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
	      values('M02051020','M0205','竞价采购','竞价结果',2,100,1,'M020510','M00004');
	  end if;
	  
	  --修改权限
	  num:=0;
	  select count(1) into num from bs_qxsz where sid='M00004' and mid='M0205' and mkid='M020510' and mname='竞价采购' and name='待发布' and url='/exp/tender/buy/bout/list.do';
	  if num=1 then
	      update bs_qxsz set name='竞价采购',inurl='/exp/tender/buy/bout/list.do#/exp/appoint/buy/dxhy/showAppointMemberList.do#/exp/tender/buy/evaluate/list.do#/exp/tender/buy/result/list.do' where
	      sid='M00004' and mid='M0205' and mkid='M020510' and mname='竞价采购' and name='待发布' and url='/exp/tender/buy/bout/list.do';
	  end if;
	  
	  --禁用
	  update bs_qxsz set isuse=0 where sid='M00004' and mid='M0205' and mkid='M020530' and mname='竞价采购' and name='竞价中';
	  update bs_qxsz set isuse=0 where sid='M00004' and mid='M0205' and mkid='M020540' and mname='竞价采购' and name='竞价结果';
	  
	  --修改权限明细
	  update bs_qxmx set mkid='M02051015' where sid='M00004' and mkid='M020530' and action='/exp/tender/buy/evaluate';
	  update bs_qxmx set mkid='M02051020' where sid='M00004' and mkid='M020540' and action='/exp/tender/buy/result';
    
     -- 2015-08-10 lvcy  默认设置
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/exp/entrust/shipper/manage' and method='setDefEcShipper';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/entrust/shipper/manage', 'setDefEcShipper', '1', '设置默认发货/收货人', '1', 'M00201');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/exp/hangsource/buy/createbill' and method='setDefConsignee';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('M01050505', '/exp/hangsource/buy/createbill', 'setDefConsignee', '2', '设置默认收货人信息', '1', 'M00201');
    end if;
    
    -- 2015-09-01 lvcy 聊天记录
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/exp/chatlog' and method='list' and mkid='0';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/chatlog', 'list', '1', '聊天记录列表', '1', 'M00201');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where sid='M00201' and styp=1 and action='/exp/chatlog' and method='save' and mkid='0';
    if num=0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/exp/chatlog', 'save', '1', '发送聊天记录', '1', 'M00201');
    end if;
    
    --hejw  2015-09-15

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/chatlog' and  method='dialogList' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/chatlog','dialogList',1,'聊天记录-消息提醒列表',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/allthing' and  method='home' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/allthing','home',0,'手机-首页我的',1,'M00201');
    end if;
    
    --hejw 后台团购审核
    num:=0;
    select count(1) into num from bs_xtmk  where sid='B00004' and mid='B0150';
    if num=0 then
        insert into bs_xtmk (mid, mname, styp, ordby, sid)
        values('B0150', '团购管理', 2, 200, 'B00004');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where sid='B00004' and mkid='B015005' and mid='B0150' ;
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B015005','B0150','团购管理','团购审核','/gdm/gbhangsource/admin/list.do','/gdm/gbhangsource/admin/list.do',1,100,2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/gdm/gbhangsource/admin' and  method='list' and mkid='B015005' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B015005','/gdm/gbhangsource/admin','list',2,'后台-团购审核分页列表',2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/gdm/gbhangsource/admin' and  method='view' and mkid='B015005' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B015005','/gdm/gbhangsource/admin','view',2,'后台-团购审核页面',2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/gdm/gbhangsource/admin' and  method='examine' and mkid='B015005' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B015005','/gdm/gbhangsource/admin','examine',2,'后台-团购-审核',2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/gdm/gbhangsource/admin' and  method='info' and mkid='B015005' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B015005','/gdm/gbhangsource/admin','info',2,'后台-团购详情',2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/stock/partsbj' and  method='showPartsBjTmp' and mkid='M026515' and  sid='M00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M026515','/exp/stock/partsbj','showPartsBjTmp',2,'查看二级零部件信息',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/checkgroup' and  method='update' and mkid='M011510' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M011510','/bsp/menber/checkgroup','update',2,'启用审批流',1,'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/tender/manage' and  method='doShowJjCjxx' and mkid='B013030' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013030','/exm/tender/manage','doShowJjCjxx',2,'竞标管理：查询出价数据',2,'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/auction/tray' and  method='showCjxx' and mkid='B012530' and  sid='B00004';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B012530','/exm/auction/tray','showCjxx',2,'拍卖管理：查看出价信息',2,'B00004');
    end if;
    -------------------

	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and  sid='M00000' and action = '/login' and  method='regedit';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/login','regedit',0,'未审核的用户修改注册信息',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and  sid='M00000' and action = '/bsp/supplier/reg' and  method='regUpdate';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/bsp/supplier/reg','regUpdate',0,'修改用户注册信息',1,'M00000');
	end if;
	
	
	--hejw  APP 消息推送
    num:=0;
    select count(1) into num from bs_qxsz where mkid='B013530' and sid='B00201';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('B013530','B0135','系统管理','APP推送消息','/exm/push/message/list.do',1,400,2,'B00201');
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='list' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','list',2,'APP推送消息-列表',2,'B00201');
    end if;  

    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='toAdd' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','toAdd',2,'APP推送消息-进入新增',2,'B00201');
    end if;  

    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='save' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','save',2,'APP推送消息-新增',2,'B00201');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='delete' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','delete',2,'APP推送消息-删除',2,'B00201');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='show' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','show',2,'APP推送消息-查看',2,'B00201');
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='toEdit' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','toEdit',2,'APP推送消息-进入修改页面',2,'B00201');
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/message' and  method='update' and mkid='B013530' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013530','/exm/push/message','update',2,'APP推送消息-修改',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='B013530' and sid='B00201';
    if num=1 then        
        update bs_qxsz set inurl='/exm/push/message/list.do#/exm/push/message/toEdit.do#/exm/push/message/toAdd.do#/exm/push/message/show.do' where mkid='B013530' and sid='B00201';
    end if;   
    
    
    --hejw 消息推送前台用户产看
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/push/message' and  method='list' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/push/message','list',1,'推送消息-用户查看列表',1,'M00201');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/push/message' and  method='info' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/push/message','info',1,'推送消息-用户查看详情',1,'M00201');
    end if;
    
	  num:=0;
	  	  select count(1) into num from bs_qxmx where sid='M00201' and action='/exp/entrust/aide/manage' and method='wlzslist';     
	  if num = 0 then 
		  insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
		  values ('0', '/exp/entrust/aide/manage', 'wlzslist', 1, 'APP物流助手-分页', 1, 'M00201'); 
	  end if;
	
	  num:=0;
	      select count(1) into num from bs_qxmx where sid='M00201' and action='/exp/entrust/aide/manage' and method='wlzsInfoUpdate';     
	  if num = 0 then 
		  insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
		  values ('0', '/exp/entrust/aide/manage', 'wlzsInfoUpdate', 1, 'APP物流助手-更新查看状态', 1, 'M00201'); 
	  end if;
    
	--	手机支付接口
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/yeepay' and  method='pay' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/contract/yeepay','pay',1,'向易宝发送支付请求',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/yeepay' and  method='payCallback' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/contract/yeepay','payCallback',1,'支付成功回调请求',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and  method='getZtreeJson' and mkid='0' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/supplier/reg','getZtreeJson',0,'Ajax获取集团树',1,'M00000');
    end if;
    
    ----易宝支付对账单Action
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00301' and mkid='B011560';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B011560','B0115','交易账户','易宝支付对账单','/manager/subaccount/ybdzd/list.do','/manager/subaccount/ybdzd/list.do#',1,60,2,'B00301');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/manager/subaccount/ybdzd' and  method='list' and mkid='B011560' and  sid='B00301';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B011560','/manager/subaccount/ybdzd','list',2,'对账单-列表',2,'B00301');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/contract/shop/manage' and  method='slzyList' and mkid='0' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exm/contract/shop/manage','slzyList',1,'查看某支付时间区域内的合同数据',2,'B00201');
    end if;
    
    --hejw   个人会员 后台
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsm/personal/manager' and  method='info' and mkid='B010085' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010085','/bsm/personal/manager','info',2,'个人用户管理-详情',2,'B00000');
    end if;
    
 	num:=0;
    select count(1) into num from bs_qxmx where action='/bsm/personal/manager' and  method='toEditYxq' and mkid='B010085' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010085','/bsm/personal/manager','toEditYxq',2,'个人用户管理-编辑',2,'B00000');
    end if;   

 	num:=0;
    select count(1) into num from bs_qxmx where action='/bsm/personal/manager' and  method='toUpdateYxq' and mkid='B010085' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B010085','/bsm/personal/manager','toUpdateYxq',2,'个人用户管理-编辑-保存',2,'B00000');
    end if;   
	
	--公告未查看信息
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/msg/publish' and  method='checkNum' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/msg/publish','checkNum',0,'发现-消息未看数量',1,'M00201');
    end if;
    
    -- 权限明细 买方询价 询比价新增页面-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='toAddLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','toAddLaw',2,'询比价新增页面-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 询比价新增保存-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='saveLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','saveLaw',2,'询比价新增保存-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 询比价编辑页面-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='toEditLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','toEditLaw',2,'询比价编辑页面-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 询比价修改保存-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='updateLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','updateLaw',2,'询比价修改保存-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 卖方报价 询价管理参与报价-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='joinPriceLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01800505','/exp/querybusiness/process/sell','joinPriceLaw',2,'询价管理参与报价-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 卖方报价 询价管理保存报价-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='savePriceLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01800505','/exp/querybusiness/process/sell','savePriceLaw',2,'询价管理保存报价-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 卖方报价 询价管理更新报价-法律事务
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='updatePriceLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01800505','/exp/querybusiness/process/sell','updatePriceLaw',2,'询价管理更新报价-法律事务',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 订单填写页面-法律事务询价
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='previewLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','previewLaw',2,'订单填写页面-法律事务询价',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 保存购物车数据到合同临时表-法律事务询价
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='saveContract2TmpLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','saveContract2TmpLaw',2,'保存购物车数据到合同临时表-法律事务询价',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 获取订单填写页面的商品明细-法律事务询价
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='getorderMxLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','getorderMxLaw',2,'获取订单填写页面的商品明细-法律事务询价',1,'M00004');
	end if;
	
	-- 权限明细 买方询价 生成订单-法律事务询价
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='createbillLaw' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','createbillLaw',2,'生成订单-法律事务询价',1,'M00004');
	end if;

	update bs_qxsz set name='上架商品' where sid='B00201' and mid='B0105' and mkid='B010505';
	
	
	
	
	--hejw  询价权限修改及新增
	--买方权限
  	update bs_qxsz set name='商品询价' where sid = 'M00004' and mkid='M017005' and mid='M0170';
  	update bs_qxsz set mname='商品询价' where sid = 'M00004' and mkid='M01700505' and mid='M0170';
	update bs_qxsz set mname='商品询价' where sid = 'M00004' and mkid='M01700510' and mid='M0170';

	--卖方权限
	update bs_qxsz set name='商品报价' where sid = 'M00004' and mkid='M018005' and mid='M0180';

  	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M017015' and mid='M0170';
	if num = 0 then
	    insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
	    values ('M017015', 'M0170', '买方询价', '法务询价', '/exp/querybusinesslaw/buy/list.do', '/exp/querybusinesslaw/buy/list.do#/exp/querybusiness/processlaw/buy/list.do#/exp/querybusiness/completedlaw/buy/list.do#/exp/querybusinesslaw/buy/toAdd.do#/exp/querybusinesslaw/buy/toEdit.do#/exp/querybusinesslaw/buy/arAdd.do#/exp/querybusinesslaw/buy/toConReqAdd.do#/exp/querybusinesslaw/buy/toAddLaw.do', 1, 250, 1, '', 'M00004');
	end if;


  	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M018015' and mid='M0180';
	if num = 0 then
	   insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
	   values ('M018015', 'M0180', '卖方报价', '法务报价', '/exp/querybusiness/processlaw/sell/list.do', '/exp/querybusiness/processlaw/sell/list.do#/exp/querybusiness/processlaw/sell/resultList.do', 1, 150, 1, '', 'M00004');
	end if;

	  num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M01701505' and mid='M0170';
	if num = 0 then
	  insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
    values ('M01701505', 'M0170', '商品询价', '法务-编辑', null, null, 2, 100, 1, 'M017015', 'M00004');
	end if;

    num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M01701510' and mid='M0170';
	if num = 0 then
	  insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
    values ('M01701510', 'M0170', '商品询价', '法务-发布', null, null, 2, 200, 1, 'M017015', 'M00004');
	end if;
  
  	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid='M01801505' and mid='M0180';
	if num = 0 then
		  insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
	    values ('M01801505', 'M0180', '法务询价', '法务-询价管理', null, null, 2, 100, 1, 'M018015', 'M00004');
	end if;

  	
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='release' and mkid='M01701510' and  sid='M00004';
    if num=0 then
       insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
       values ('M01701510', '/exp/querybusinesslaw/buy', 'release', 2, '法务-询比价发布', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='releases' and mkid='M01701510' and  sid='M00004';
    if num=0 then
       insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
       values ('M01701510', '/exp/querybusinesslaw/buy', 'releases', 2, '法务-询比价批量发布', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='donbsh' and mkid='M01701510' and  sid='M00004';
    if num=0 then
       insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
       values ('M01701510', '/exp/querybusinesslaw/buy', 'donbsh', 2, '法务-申请内部审核', 1, 'M00004');
    end if;
  	
  		  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='list' and mkid='M018015' and  sid='M00004';
    if num=0 then
      insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
      values ('M018015', '/exp/querybusiness/processlaw/sell', 'list', 2, '法务-询价管理分页列表', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='resultList' and mkid='M018015' and  sid='M00004';
    if num=0 then
       insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
       values ('M018015', '/exp/querybusiness/processlaw/sell', 'resultList', 2, '法务-询价管理结果页面', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='showTd' and mkid='M018015' and  sid='M00004';
    if num=0 then
       insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
       values ('M018015', '/exp/querybusiness/processlaw/sell', 'showTd', 2, '法务-询价管理查看', 1, 'M00004');
    end if;
  	
	 num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='list' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusiness/processlaw/buy', 'list', 2, '询比价询价中分页列表', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='list' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusinesslaw/buy', 'list', 2, '询比价分页列表', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/completedlaw/buy' and  method='list' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusiness/completedlaw/buy', 'list', 2, '询比价完成分页列表', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='getBrowseFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusinesslaw/buy', 'getBrowseFile', 2, '加密导入页面', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='importFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusinesslaw/buy', 'importFile', 2, '导入', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='export2AesFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusinesslaw/buy', 'export2AesFile', 2, '加密导出', 1, 'M00004');
    end if;
  

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/completedlaw/buy' and  method='getBrowseFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusiness/completedlaw/buy', 'getBrowseFile', 2, '加密导入页面', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/completedlaw/buy' and  method='importFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M017015', '/exp/querybusiness/completedlaw/buy', 'importFile', 2, '导入', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/completedlaw/buy' and  method='export2AesFile' and mkid='M017015' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M017015', '/exp/querybusiness/completedlaw/buy', 'export2AesFile', 2, '加密导出', 1, 'M00004');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toConReqAdd' and mkid='M017015' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M017015', '/exp/querybusinesslaw/buy', 'toConReqAdd', 1, '集中采购牵引到询价页面', 1, 'M00004');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='showTd' and mkid='M017015' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M017015', '/exp/querybusinesslaw/buy', 'showTd', 2, '显示询价单信息', 1, 'M00004');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/completedlaw/buy' and  method='dogg' and mkid='M017015' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M017015', '/exp/querybusiness/completedlaw/buy', 'dogg', 2, '询价结果发布公告', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='downLoad' and mkid='M017015' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M017015', '/exp/querybusiness/processlaw/buy', 'downLoad', 2, '附件下载', 1, 'M00004');
    end if;
    
    
num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toEdit' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( 'M01701505', '/exp/querybusinesslaw/buy', 'toEdit', 2, '询比价编辑页面', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toInfo' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toInfo', 2, '询比价详情页面', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='save' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'save', 2, '询比价新增保存', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='update' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'update', 2, '询比价修改保存', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='export2Excel' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'export2Excel', 2, '导出询比价单据', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='dodel' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'dodel', 2, '询比价删除', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='preview' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusiness/processlaw/buy', 'preview', 2, '订单填写页面', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toAdd' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toAdd', 2, '询比价新增页面', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='tenderChooseAppointMember' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'tenderChooseAppointMember', 2, '询比价定向会员', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='saveContract2Tmp' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusiness/processlaw/buy', 'saveContract2Tmp', 2, '保存购物车数据到合同临时表', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='showAppointMemberList' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'showAppointMemberList', 2, '询比价定向会员', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='delete' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'delete', 2, '询比价定向会员：删除', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='getMemberList' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'getMemberList', 2, '询比价定向会员:列表', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toAddQuery' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toAddQuery', 2, '询比价定向会员:新增', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='saveQuery' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'saveQuery', 2, '询比价定向会员:保存', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toUpdate' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toUpdate', 2, '询比价定向会员:编辑', 1, 'M00004');
    end if;
    
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='batchEnable' and mkid='M01701505' and  sid='M00004';
    if num=0 then  
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'batchEnable', 2, '询比价定向会员:批量启用', 1, 'M00004');
    end if;
    
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='batchDisable' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'batchDisable', 2, '询比价定向会员:批量禁用', 1, 'M00004');
    end if;
    
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='batchDelete' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'batchDelete', 2, '询比价定向会员:批量删除', 1, 'M00004');
    end if;
    
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='batchDelete' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'batchDelete', 2, '询比价定向会员:批量删除', 1, 'M00004');
    end if;
    
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='category' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'category', 2, '类目选择', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='getCategory' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'getCategory', 2, '新增场次（卖）：(AJAX)获取类目', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='previewBj' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'previewBj', 2, '买家申请报价', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='savaPrice' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'savaPrice', 2, '买家申请报价-保存', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toPrice' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toPrice', 2, '买家申请报价-新增-编辑', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='downLoad' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'downLoad', 1, '附件查看', 1, 'M00004');
    end if;  
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='downPage' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'downPage', 1, '询比价新增-导入产品页面', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='categoryCountfl' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'categoryCountfl', 0, '类目选择-统计分类', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='importFileCpxx' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'importFileCpxx', 1, '询比价新增-导入产品资源信息到页面', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='downLoadModel' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'downLoadModel', 1, '询比价新增-下载模板', 1, 'M00004');
    end if;  
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toEditLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toEditLaw', 2, '询比价编辑页面-法律事务', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='toAddLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'toAddLaw', 2, '询比价新增页面-法律事务', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='saveLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'saveLaw', 2, '询比价新增保存-法律事务', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusinesslaw/buy' and  method='updateLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusinesslaw/buy', 'updateLaw', 2, '询比价修改保存-法律事务', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='getorderMx' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( 'M01701505', '/exp/querybusiness/processlaw/buy', 'getorderMx', 2, '获取订单填写页面的商品明细', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='createbillLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusiness/processlaw/buy', 'createbillLaw', 2, '生成订单-法律事务询价', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='getorderMxLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusiness/processlaw/buy', 'getorderMxLaw', 2, '获取订单填写页面的商品明细-法律事务询价', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='saveContract2TmpLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01701505', '/exp/querybusiness/processlaw/buy', 'saveContract2TmpLaw', 2, '保存购物车数据到合同临时表-法律事务询价', 1, 'M00004');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='refusePrice' and mkid='M01701505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01701505', '/exp/querybusiness/processlaw/buy', 'refusePrice', 2, '拒绝交易', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='previewLaw' and mkid='M01701505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01701505', '/exp/querybusiness/processlaw/buy', 'previewLaw', 2, '订单填写页面-法律事务询价', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='saveShd' and mkid='M01701505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01701505', '/exp/querybusiness/processlaw/buy', 'saveShd', 0, '保存新增收货地址界面', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='toAddShd' and mkid='M01701505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01701505', '/exp/querybusiness/processlaw/buy', 'toAddShd', 0, '跳转新增收货地址界面', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/buy' and  method='createbill' and mkid='M01701505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01701505', '/exp/querybusiness/processlaw/buy', 'createbill', 2, '生成订单', 1, 'M00004');
    end if;
    
      num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='joinPrice' and mkid='M01801505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01801505', '/exp/querybusiness/processlaw/sell', 'joinPrice', 1, '询价管理参与报价', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='savePrice' and mkid='M01801505' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ('M01801505', '/exp/querybusiness/processlaw/sell', 'savePrice', 2, '询价管理保存报价', 1, 'M00004');
    end if;

  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='updatePrice' and mkid='M01801505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01801505', '/exp/querybusiness/processlaw/sell', 'updatePrice', 2, '询价管理更新报价', 1, 'M00004');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='downLoad' and mkid='M01801505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01801505', '/exp/querybusiness/processlaw/sell', 'downLoad', 1, '附件查看', 1, 'M00004');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='joinPriceLaw' and mkid='M01801505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01801505', '/exp/querybusiness/processlaw/sell', 'joinPriceLaw', 2, '询价管理参与报价-法律事务', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='savePriceLaw' and mkid='M01801505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01801505', '/exp/querybusiness/processlaw/sell', 'savePriceLaw', 2, '询价管理保存报价-法律事务', 1, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/processlaw/sell' and  method='updatePriceLaw' and mkid='M01801505' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M01801505', '/exp/querybusiness/processlaw/sell', 'updatePriceLaw', 2, '询价管理更新报价-法律事务', 1, 'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/tdcontract/sell/trail' and  method='uploadWts' and mkid='M025010' and  sid='M00004';
    if num=0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M025010', '/exp/tdcontract/sell/trail', 'uploadWts', 2, '销售订单-报价方上传委托书', 1, 'M00004');
    end if;    
    
    --统计未查看数量
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/chatlog' and  method='countXxtj' and sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/chatlog','countXxtj',1,'统计聊天数量',1,'M00201');
    end if;
    
    
    --广告位
   num:=0;
    select count(1) into num from bs_qxsz where sid='B00201' and mkid='B013535' and mid='B0135' and name='APP广告位';
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
        values('B013535','B0135','系统管理','APP广告位','/exm/push/advert/list.do',1,500,2,'B00201');
    end if;


	  num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='list' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','list',2,'广告位列表',2,'B00201');
    end if;

	  num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='add' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','add',2,'广告位新增',2,'B00201');
    end if;

	  num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='edit' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','edit',2,'广告位编辑',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='save' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','save',2,'广告位保存',2,'B00201');
    end if;
    
	  num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='update' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','update',2,'广告位修改',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/push/advert' and  method='delete' and mkid='B013535' and  sid='B00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B013535','/exm/push/advert','delete',2,'广告位删除',2,'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/push/advert' and  method='gzlist' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/exp/push/advert','gzlist',0,'广告位信息',1,'M00201');
    end if;
    
    --hjw 个人支付
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='checkZfPwd' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','checkZfPwd',0,'个人会员 检查支付密码是否为空',1,'M00201');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='upGrZfPwd' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','upGrZfPwd',0,'个人会员 手机支付密码修改',1,'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/userinfo' and  method='zfPwd' and mkid='0' and  sid='M00201';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bsp/menber/userinfo','zfPwd',0,'个人会员-支付密码验证',1,'M00201');
    end if;
    
    -- 权限明细 询价采购查询 询价采购导出列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/manager' and METHOD ='export2Excel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014510','/exm/querybusiness/manager','export2Excel',2,'询价采购查询-询价采购导出列表',2,'B00004');
	end if;
	
	-- 权限设置 询价采购管理 支付申请审核
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014525' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B014525','B0145','询价采购管理','支付申请审核','/exm/querybusiness/sfsq/list.do','/exm/querybusiness/sfsq/list.do',1,400,2,'B00004');
	end if;
	
	-- 权限明细 询价采购管理 支付申请审核列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/sfsq' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014525','/exm/querybusiness/sfsq','list',2,'询价采购管理-支付申请审核列表',2,'B00004');
	end if;
	
	-- 权限明细 询价采购管理 支付申请审核页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/sfsq' and METHOD ='toVerifyPreview' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014525','/exm/querybusiness/sfsq','toVerifyPreview',2,'询价采购管理-支付申请审核页面',2,'B00004');
	end if;
	
	-- 权限明细 询价采购管理 支付申请审核
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/sfsq' and METHOD ='doVerify' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014525','/exm/querybusiness/sfsq','doVerify',2,'询价采购管理-支付申请审核',2,'B00004');
	end if;
	
	-- 权限明细 法务报价 支付申请页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/sell' and METHOD ='toZfsq' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018015','/exp/querybusiness/processlaw/sell','toZfsq',2,'法务报价-支付申请页面',1,'M00004');
	end if;
	
	-- 权限明细 法务报价 支付申请
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/sell' and METHOD ='doZfsq' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018015','/exp/querybusiness/processlaw/sell','doZfsq',2,'法务报价-支付申请',1,'M00004');
	end if;
	
	-- 权限明细 询价采购查询 延迟发布公告
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/manager' and METHOD ='delay' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014510','/exm/querybusiness/manager','delay',2,'询价采购查询-延迟发布公告',2,'B00004');
	end if;
	
	--  新增法务专家管理菜单
	num:=0;
    select count(1) into num from bs_qxsz where sid='B00004' and url='/exm/query/law/expert/list.do' and mid='B0145' and mkid='B014530';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B014530', 'B0145', '询价采购管理', '法务专家管理', '/exm/query/law/expert/list.do', '/exm/query/law/expert/list.do', '1', '450', '2', NULL, 'B00004');
    end if;
    
    update bs_qxsz set inurl='/exm/query/law/expert/list.do#/exm/query/law/expert/toImport.do' 
	where mkid='B014530' and mid='B0145' and sid='B00004' and name='法务专家管理';
	
	num:=0;
    select count(1) into num from bs_qxsz where sid='B00004' and mid='B0145' and mkid='B01453005';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B01453005', 'B0145', '询价采购管理', '编辑', NULL, NULL, '2', '460', '2', 'B014530', 'B00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00004' and mid='B0145' and mkid='B01453010';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('B01453010', 'B0145', '询价采购管理', '升级', NULL, NULL, '2', '470', '2', 'B014530', 'B00004');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','list',2,'法务专家列表查询',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='showLawExpert' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','showLawExpert',2,'法务专家查看详情',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='export2Excel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','export2Excel',2,'法务专家导出',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='toImport' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','toImport',2,'导入界面',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='downLoadWeb' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','downLoadWeb',2,'模版下载',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='doImport' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/exm/query/law/expert','doImport',2,'导入专家',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='toEdit' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453005','/exm/query/law/expert','toEdit',2,'法务专家新增编辑界面',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='saveLawExpert' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453005','/exm/query/law/expert','saveLawExpert',2,'法务专家新增保存',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='updateLawExpert' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453005','/exm/query/law/expert','updateLawExpert',2,'法务专家编辑修改',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='delLawExpert' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453005','/exm/query/law/expert','delLawExpert',2,'删除法务专家',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='startUsing' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453005','/exm/query/law/expert','startUsing',2,'法务专家启用OR停用',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/query/law/expert' and METHOD ='goUpLawExpert' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01453010','/exm/query/law/expert','goUpLawExpert',2,'法务专家升级为正式',2,'B00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and url='/exp/query/law/expert/list.do' and mid='M0170' and mkid='M017020';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('M017020', 'M0170', '买方询价', '专家管理', '/exp/query/law/expert/list.do', '/exp/query/law/expert/list.do', '1', '450', '1', NULL, 'M00004');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mid='M0170' and mkid='M01702005';
    if num=0 then
    	INSERT INTO "BS_QXSZ" ("MKID", "MID", "MNAME", "NAME", "URL", "INURL", "ISUSE", "ORDERNO", "STYP", "PARENT", "SID") 
		VALUES ('M01702005', 'M0170', '买方询价', '编辑', NULL, NULL, '2', '460', '1', 'M017020', 'M00004');
    end if;
    
    update bs_qxsz set inurl='/exp/query/law/expert/list.do#/exp/query/law/expert/toEdit.do' 
	where mkid='M017020' and mid='M0170' and sid='M00004' and name='专家管理';
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/law/expert' and METHOD ='list' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017020','/exp/query/law/expert','list',2,'法务专家列表查询',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/law/expert' and METHOD ='toEdit' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01702005','/exp/query/law/expert','toEdit',2,'法务专家新增编辑界面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/law/expert' and METHOD ='saveLawExpert' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01702005','/exp/query/law/expert','saveLawExpert',2,'法务专家新增保存',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/law/expert' and METHOD ='updateLawExpert' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01702005','/exp/query/law/expert','updateLawExpert',2,'法务专家编辑修改',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/law/expert' and METHOD ='delLawExpert' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01702005','/exp/query/law/expert','delLawExpert',2,'法务专家删除操作',1,'M00004');
	end if;
	
	-- 权限明细-买家询价-上传专家评审意见
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='review' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','review',2,'买家询价-上传专家评审意见',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/buy' and METHOD ='review' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01701505','/exp/querybusiness/processlaw/buy','review',2,'买家询价-上传专家评审意见',1,'M00004');
	end if;
	
	
	--供应商类别审核
	  num:=0;
    select count(1) into num from bs_qxmx where action='/bsm/supplier/manager' and  method='toAudit' and mkid='B01009005' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01009005','/bsm/supplier/manager','toAudit',2,'供应商类别-查看',2,'B00000');
    end if;

	
	-- 权限明细-买家询价-下载专家评审意见
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='downloadReview' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/process/buy','downloadReview',2,'买家询价-下载专家评审意见',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/buy' and METHOD ='downloadReview' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01701505','/exp/querybusiness/processlaw/buy','downloadReview',2,'买家询价-下载专家评审意见',1,'M00004');
	end if;

    
 	num:=0;
    select count(1) into num from bs_qxmx where action='/bsm/supplier/manager' and  method='editAudit' and mkid='B01009005' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('B01009005','/bsm/supplier/manager','editAudit',2,'供应商类别-审核保存',2,'B00000');
    end if;   
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/buy' and METHOD ='toExpert' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01701505','/exp/querybusiness/processlaw/buy','toExpert',2,'买家询价-专家维护页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/processlaw/buy' and METHOD ='expert' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01701505','/exp/querybusiness/processlaw/buy','expert',2,'买家询价-保存维护的专家',1,'M00004');
	end if;
	
	
	--常用代码 这两条数据不要更改
    num:=0;
    select count(1) into num from bs_codes where typ='常用代码类别' and  code='国别类型' ;
    if num=0 then
        insert into bs_codes (typ,code,value,isuse,orderno,iscanset,flag0)
        values('常用代码类别','国别类型','国别类型',1,10,1,1);
    end if;
    
    num:=0;
    select count(1) into num from bs_codes where typ='国别类型' and  code='1' ;
    if num=0 then
        insert into bs_codes (typ,code,value,isuse,orderno,disflag0)
        values('国别类型','1','中国',1,1,1);
    end if;
    
    --常用代码下拉通用
    num:=0;
    select count(1) into num from bs_qxmx where action='/market/public/item' and  method='getCodesPage' and  sid='M00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/market/public/item','getCodesPage',0,'下拉选择通用',1,'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/manager/public/item' and  method='getCodesPage' and  sid='B00000';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/manager/public/item','getCodesPage',0,'下拉选择通用',2,'B00000');
    end if;
    
    
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
