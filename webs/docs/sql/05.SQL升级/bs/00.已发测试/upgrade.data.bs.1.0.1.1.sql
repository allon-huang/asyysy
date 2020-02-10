DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.1.3'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	----------------- 2016-08-10 hanglong 是否启用后台会员信息审核功能 start------------------
	num:=0;
	select count(1) into num from bs_cssz where cskey='MENBER_INFO_AUDIT';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz) 
		values('MENBER_INFO_AUDIT','是否启用后台会员信息审核功能','0','0','系统管理员','若启用，前台会员信息修改需要平台审核','1',780,'1 - 启用 0 - 禁用；');
	end if; 
	
	num:=0;
    select count(1) into num from bs_cssz_ext where typ='MENBER_INFO_AUDIT' and cskey='0';
    if num = 0 then
		insert into bs_cssz_ext(typ,cskey,csvalue) 
		values('MENBER_INFO_AUDIT','0','禁用');
	end if; 
   
	num:=0;
    select count(1) into num from bs_cssz_ext where typ='MENBER_INFO_AUDIT' and cskey='1';
    if num = 0 then
		insert into bs_cssz_ext(typ,cskey,csvalue) 
		values('MENBER_INFO_AUDIT','1','启用');
	end if;
	----------------- 2016-08-10 hanglong 是否启用后台会员信息审核功能 end--------------------
    
    -----------------  huyq 首页中标候选人公示附件下载 start--------------------
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='downloadGs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','downloadGs',0,'首页中标候选人公示附件下载',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='downloadGg' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','downloadGg',0,'首页系统公告附件下载',1,'M00008');
	end if;
	-----------------  huyq 首页中标候选人公示附件下载 end--------------------

	num:=0;
    select count(1) into num from  bs_qxsz where mkid='B010008' and sid='B00000'; 
    if num = 1 then
	     update bs_qxsz set name='会员信息审核' where mkid='B010008' and sid='B00000'; 
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/supplier/regaudit' and METHOD ='info' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010008','/bsm/supplier/regaudit','info',2,'查看会员信息',2,'B00000');
	end if;
	
	-----zyy start-----
	----后台交易角色审核
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B010100' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B010100','B0100','会员管理','交易角色审核','/bsm/trading/regaudit/list.do','/bsm/trading/regaudit/list.do#/bsm/trading/regaudit/toAudit.do#/bsm/trading/regaudit/agree.do#/bsm/trading/regaudit/reject.do',1,620,2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/trading/regaudit' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010100','/bsm/trading/regaudit','list',2,'交易角色审核列表页',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/trading/regaudit' and METHOD ='toAudit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010100','/bsm/trading/regaudit','toAudit',2,'审核页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/trading/regaudit' and METHOD ='agree' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010100','/bsm/trading/regaudit','agree',2,'审核通过',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/trading/regaudit' and METHOD ='reject' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010100','/bsm/trading/regaudit','reject',2,'审核不通过',2,'B00000');
	end if;
	-----zyy end-------

	-----zyy start-----
	----银行信息管理
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050070' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050070','M0500','基本信息维护','银行信息管理','/bsm/menber/info/bank/list.do','/bsm/menber/info/bank/list.do#/bsm/menber/info/bank/toAdd.do',1,300,1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='list' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','list',2,'银行信息管理页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='toAdd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','toAdd',2,'新增页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='save' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','save',2,'保存',1,'M00000');
	end if;
	
	
	---资质信息管理 
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050090' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050090','M0500','基本信息维护','资质信息管理','/bsm/menber/info/gnvq/list.do','/bsm/menber/info/gnvq/list.do#/bsm/menber/info/gnvq/toAdd.do',1,200,1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='list' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','list',2,'资质信息管理页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='toAdd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','toAdd',2,'新增页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='save' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','save',2,'保存',1,'M00000');
	end if;
	-----zyy end-------

	-----zyy start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/common' and METHOD ='newXjggTop' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/querybusiness/common','newXjggTop',0,'统一化服务：询价公告',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/common' and METHOD ='newJjggTop' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/querybusiness/common','newJjggTop',0,'统一化服务：竞价公告',1,'M00004');
	end if;
	-----zyy end-------

	-----zyy start-----
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_GYS_SELL_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_GYS_SELL_GROUP_QX','军民一体化服务-供应商权限组','M00001','系统管理员','军民一体化服务-供应商权限组','1',1850,'军民一体化服务-供应商权限组');
	end if; 
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_SPBJ_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_SPBJ_GROUP_QX','军民一体化服务-商品报价权限组','M00001','系统管理员','军民一体化服务-商品报价权限组','1',1860,'军民一体化服务-商品报价权限组');
	end if; 
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_FWBJ_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_FWBJ_GROUP_QX','军民一体化服务-法务报价权限组','M00001','系统管理员','军民一体化服务-法务报价权限组','1',1870,'军民一体化服务-法务报价权限组');
	end if; 
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_FJWZ_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_FJWZ_GROUP_QX','军民一体化服务-废旧物资权限组','M00001','系统管理员','军民一体化服务-废旧物资权限组','1',1880,'军民一体化服务-废旧物资权限组');
	end if; 
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_WSCS_SELL_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_WSCS_SELL_GROUP_QX','军民一体化服务-网上超市卖家权限组','M00001','系统管理员','军民一体化服务-网上超市卖家权限组','1',1890,'军民一体化服务-网上超市卖家权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_DZZTB_SELL_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_DZZTB_SELL_GROUP_QX','军民一体化服务-电子招投标投标方权限组','M00001','系统管理员','军民一体化服务-电子招投标投标方权限组','1',1900,'军民一体化服务-电子招投标投标方权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_WSCS_BUY_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_WSCS_BUY_GROUP_QX','军民一体化服务-网上超市买家权限组','M00001','系统管理员','军民一体化服务-网上超市买家权限组','1',1910,'军民一体化服务-网上超市买家权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_SPXJ_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_SPXJ_GROUP_QX','军民一体化服务-商品询价权限组','M00001','系统管理员','军民一体化服务-商品询价权限组','1',1920,'军民一体化服务-商品询价权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_FWXJ_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_FWXJ_GROUP_QX','军民一体化服务-法务询价权限组','M00001','系统管理员','军民一体化服务-法务询价权限组','1',1930,'军民一体化服务-法务询价权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_FJWZJP_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_FJWZJP_GROUP_QX','军民一体化服务-废旧物资竞拍权限组','M00001','系统管理员','军民一体化服务-废旧物资竞拍权限组','1',1940,'军民一体化服务-废旧物资竞拍权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_DZZTB_BUY_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_DZZTB_BUY_GROUP_QX','军民一体化服务-电子招投标招标方权限组','M00001','系统管理员','军民一体化服务-电子招投标招标方权限组','1',1950,'军民一体化服务-电子招投标招标方权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_GYS_BUY_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_GYS_BUY_GROUP_QX','军民一体化服务-供应商采购权限组','M00001','系统管理员','军民一体化服务-供应商采购权限组','1',1960,'军民一体化服务-供应商采购权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_DZZTB_AGENT_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_DZZTB_AGENT_GROUP_QX','军民一体化服务-电子招投标代理机构权限组','M00001','系统管理员','军民一体化服务-电子招投标代理机构权限组','1',1970,'军民一体化服务-电子招投标代理机构权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_WSCS_LOGI_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_WSCS_LOGI_GROUP_QX','军民一体化服务-网上超市物流商权限组','M00001','系统管理员','军民一体化服务-网上超市物流商权限组','1',1980,'军民一体化服务-网上超市物流商权限组');
	end if;
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='YTH_WSCS_BUY_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('YTH_WSCS_BUY_GROUP_QX','军民一体化服务-网上超市买家权限组','M00001','系统管理员','军民一体化服务-网上超市买家权限组','1',1990,'军民一体化服务-网上超市买家权限组');
	end if;
	-----zyy end-------
    
    -----start by huyq 20161128 for 在投标管理里面增加已完成投标-------
    num:=0;
	select count(1) into num from bs_qxsz where mid='M0200' and mkid='M020030' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020030','M0200','投标管理','已完成投标','/exp/bidding/sell/completeBid/list.do','/exp/bidding/sell/completeBid/list.do',1,300,1,'M00008');
	end if;
        
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/completeBid' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020030','/exp/bidding/sell/completeBid','list',2,'投标管理-已完成投标',1,'M00008');
	end if;
    -----end by huyq 20161128 for 在投标管理里面增加已完成投标-------


  	-----huangxq start-----
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0170' and mkid='M017025' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017025','M0170','买方询价','正式专家库','/exp/query/formal/expert/list.do','/exp/query/formal/expert/list.do',1,500,1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/formal/expert' and METHOD ='list' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017025','/exp/query/formal/expert','list',2,'正式专家库查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0170' and mkid='M017030' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017030','M0170','买方询价','合格律师事务所','/exp/query/formal/expert/lawList.do','/exp/query/formal/expert/lawList.do',1,550,1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/formal/expert' and METHOD ='lawList' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017030','/exp/query/formal/expert','lawList',2,'合格律师事务所查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0170' and mkid='M017025' and sid='M04000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017025','M0170','买方询价','正式专家库','/exp/query/formal/expert/list.do','/exp/query/formal/expert/list.do',1,500,1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/formal/expert' and METHOD ='list' and STYP=1 and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017025','/exp/query/formal/expert','list',2,'正式专家库查看',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0170' and mkid='M017030' and sid='M04000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M017030','M0170','买方询价','合格律师事务所','/exp/query/formal/expert/lawList.do','/exp/query/formal/expert/lawList.do',1,550,1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/query/formal/expert' and METHOD ='lawList' and STYP=1 and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017030','/exp/query/formal/expert','lawList',2,'合格律师事务所查看',1,'M04000');
	end if;
    -----huangxq end-----


	-----------------------------我的平台权限改造 2016-09-20 hanglong start---------------------------------
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0105';
	if num = 1 then
		update bs_xtmk set qxrole='3' where sid='M00000' and mid ='M0105';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0105';
	if num = 1 then
		update bs_xtmk set qxrole='3' where sid='M01000' and mid ='M0105';
	end if;
	--------
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0500';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0500';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0500';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0500';
	end if;
	----
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0390';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0390';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0390';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0390';
	end if;
	----
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0400';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0400';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0400';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0400';
	end if;
	------
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0395';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0395';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0395';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0395';
	end if;
	------
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0396';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0396';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0396';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0396';
	end if;
	------
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00000' and mid ='M0100';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M00000' and mid ='M0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M01000' and mid ='M0100';
	if num = 1 then
		update bs_xtmk set qxrole='5' where sid='M01000' and mid ='M0100';
	end if;
	------

	num:=0;
	select count(1) into num from bs_xtmk where sid='M00201' and mid ='M0200';
	if num = 1 then
		update bs_xtmk set sid='M00000', qxrole='4' where sid='M00201' and mid ='M0200';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M02000' and mid ='M0200';
	if num = 1 then
		update bs_xtmk set sid='M01000', qxrole='4' where sid='M02000' and mid ='M0200';
	end if;
	-------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M02001020';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M02001020';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M02001020';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M02001020';
	end if;
	-------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M02001010';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M02001010';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M02001010';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M02001010';
	end if;
	-------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M02001030';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M02001030';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M02001030';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M02001030';
	end if;
	-------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M020005';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M020005';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M020005';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M020005';
	end if;
	-------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M020015';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M020015';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M020015';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M020015';
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M020020';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M020020';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M020020';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M020020';
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M020025';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M020025';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M020025';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M020025';
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M02001005';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M02001005';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M02001005';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M02001005';
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid ='M020010';
	if num = 1 then
		update bs_qxsz set sid='M00000' where sid='M00201' and mkid ='M020010';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M02000' and mkid ='M020010';
	if num = 1 then
		update bs_qxsz set sid='M01000' where sid='M02000' and mkid ='M020010';
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='index' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='index' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='index' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='index' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='listarjf' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='listarjf' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='listarjf' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='listarjf' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='view' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='view' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='view' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='view' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='info' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='info' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='info' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='info' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='confirmGift' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='confirmGift' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='confirmGift' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='confirmGift' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='viewFhd' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='viewFhd' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='viewFhd' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='viewFhd' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------


	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='bdlist' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='bdlist' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='bdlist' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='bdlist' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='listcjjl' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='listcjjl' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='listcjjl' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='listcjjl' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxmx where sid='M00201' and method ='rule' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M00000' where sid='M00201' and method ='rule' and action='/scp/scoreshop/order' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M02000' and method ='rule' and action='/scp/scoreshop/order' and styp=1;
	if num = 1 then
		update bs_qxmx set sid='M01000' where sid='M02000' and method ='rule' and action='/scp/scoreshop/order' and styp=1;
	end if;
	-------

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/userinfo' and METHOD ='mbOptLogo' and SID='M00000' and styp=1;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/userinfo','mbOptLogo',1,'查看操作员头像',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/userinfo' and METHOD ='mbOptLogo' and SID='M01000' and styp=1;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/userinfo','mbOptLogo',1,'查看操作员头像',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/userinfo' and METHOD ='saveOptLogo' and SID='M00000' and styp=1;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/userinfo','saveOptLogo',1,'设置操作员头像',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/userinfo' and METHOD ='saveOptLogo' and SID='M01000' and styp=1;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsp/menber/userinfo','saveOptLogo',1,'设置操作员头像',1,'M01000');
	end if;
	
	-----------------------------我的平台权限改造 2016-09-20 hanglong end-----------------------------------


	-----zyy start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='getAllCnvqInSm' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsm/menber/info/gnvq','getAllCnvqInSm',0,'职业资格序列选择',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='getAllCnvqInSm' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bsm/menber/info/gnvq','getAllCnvqInSm',0,'职业资格序列选择',1,'M01000');
	end if;
	-----zyy end-----

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin' and METHOD ='ywtxAjax' and SID='B00000' and STYP=2;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin','ywtxAjax',1,'业务提醒数据采用ajax方式请求',2,'B00000');
	end if;

	update bs_menber t set shrq=regdate where t.regdate is not null and t.shrq is null;
     
	-----zyy start-----
	---职业人员管理 
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050095' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050095','M0500','基本信息维护','职业人员管理','/bsm/menber/info/zyry/list.do','/bsm/menber/info/zyry/list.do#/bsm/menber/info/zyry/toAdd.do#/bsm/menber/info/zyry/view.do',1,500,1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='list' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','list',2,'职业人员管理页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='toAdd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','toAdd',2,'新增页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='save' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','save',2,'保存',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='view' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','view',2,'查看',1,'M00000');
	end if;
	
	--军民一体化平台，职业人员
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0500' and mkid='M050095' and sid='M01000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050095','M0500','基本信息维护','职业人员管理','/bsm/menber/info/zyry/list.do','/bsm/menber/info/zyry/list.do#/bsm/menber/info/zyry/toAdd.do#/bsm/menber/info/zyry/view.do',1,500,1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='list' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','list',2,'职业人员管理页面',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='toAdd' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','toAdd',2,'新增页面',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='save' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','save',2,'保存',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/zyry' and METHOD ='view' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050095','/bsm/menber/info/zyry','view',2,'查看',1,'M01000');
	end if;
	-----zyy end-------

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='headWebJM' and SID='M04000' and STYP=1;
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','headWebJM',0,'军民首页头部',1,'M04000');
	end if;
	
	-----zyy start-----
	------银行信息
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000150' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000150','B0100','会员管理','银行信息管理','','',2,116,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/mbbank/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/mbbank/list.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbbank' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000150','/bsm/menber/mbbank','list',2,'会员管理-银行信息列表',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbbank' and METHOD ='view' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000150','/bsm/menber/mbbank','view',2,'银行信息查看',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbbank' and METHOD ='editBang' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000150','/bsm/menber/mbbank','editBang',2,'跳转修改页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbbank' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000150','/bsm/menber/mbbank','update',2,'保存修改页面',2,'B00000');
	end if;
	
	
	------资质信息
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000155' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000155','B0100','会员管理','资质信息管理','','',2,165,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/mbgnvq/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/mbgnvq/list.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbgnvq' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000155','/bsm/menber/mbgnvq','list',2,'会员管理-资质信息列表',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbgnvq' and METHOD ='view' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000155','/bsm/menber/mbgnvq','view',2,'资质信息查看',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbgnvq' and METHOD ='editGnvq' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000155','/bsm/menber/mbgnvq','editGnvq',2,'跳转修改页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbgnvq' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000155','/bsm/menber/mbgnvq','update',2,'保存修改页面',2,'B00000');
	end if;

	------职业人员
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000160' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000160','B0100','会员管理','职业人员管理','','',2,165,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/mbzyry/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/mbzyry/list.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbzyry' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000160','/bsm/menber/mbzyry','list',2,'会员管理-职业人员列表',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbzyry' and METHOD ='view' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000160','/bsm/menber/mbzyry','view',2,'职业人员信息查看',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbzyry' and METHOD ='editZyry' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000160','/bsm/menber/mbzyry','editZyry',2,'跳转修改页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/mbzyry' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000160','/bsm/menber/mbzyry','update',2,'保存修改页面',2,'B00000');
	end if;
	
	-----备注信息
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000162' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000162','B0100','会员管理','备注信息','','',2,170,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/remark/toEdit.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/remark/toEdit.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/remark' and METHOD ='toEdit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000162','/bsm/menber/remark','toEdit',2,'修改会员备注信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/remark' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000162','/bsm/menber/remark','update',2,'修改备注信息s',2,'B00000');
	end if;
	
	---产品信息
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000164' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000164','B0100','会员管理','产品信息','','',2,175,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/product/toEdit.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/product/toEdit.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/product' and METHOD ='toEdit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000164','/bsm/menber/product','toEdit',2,'修改会员产品信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/product' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000164','/bsm/menber/product','update',2,'修改产品信息',2,'B00000');
	end if;
	
	----服务地区
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000165' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000165','B0100','会员管理','服务地区','','',2,180,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/region/toEdit.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/region/toEdit.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/region' and METHOD ='toEdit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000165','/bsm/menber/region','toEdit',2,'修改会员服务地区',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/region' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000165','/bsm/menber/region','update',2,'修改服务地区 ',2,'B00000');
	end if;
	
	--公司信息管理
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B01000167' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01000167','B0100','会员管理','公司信息管理','','',2,180,2,'B010001'，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/company/toEdit.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/company/toEdit.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/company' and METHOD ='toEdit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000167','/bsm/menber/company','toEdit',2,'修改会员公司信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/company' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01000167','/bsm/menber/company','update',2,'修改公司信息 ',2,'B00000');
	end if;
	-----zyy end-------
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='arAdd' and STYP=1 and SID='M00004';
	if num = 1 then
		update bs_qxmx set mkid='M01700505' where ACTION='/exp/querybusiness/buy' and METHOD ='arAdd' and STYP=1 and SID='M00004';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='arAdd' and STYP=1 and SID='M04000';
	if num = 1 then
		update bs_qxmx set mkid='M01700505' where ACTION='/exp/querybusiness/buy' and METHOD ='arAdd' and STYP=1 and SID='M04000';
	end if;
	
	-----zyy start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='edit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','edit',2,'编辑银行信息 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='delBank' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','delBank',2,'删除银行信息 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='setBank' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','setBank',2,'设置银行类型 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='update' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','update',2,'更新 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='submit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','submit',2,'提交 ',1,'M00000');
	end if;
	
	---军民一体化
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='edit' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','edit',2,'编辑银行信息 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='delBank' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','delBank',2,'删除银行信息 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='setBank' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','setBank',2,'设置银行类型 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='update' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','update',2,'更新 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/bank' and METHOD ='submit' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050070','/bsm/menber/info/bank','submit',2,'提交 ',1,'M01000');
	end if;
	-----zyy end-------

	-----zyy start-----
	-----后台银行信息审核
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B010093' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B010093','B0100','会员管理','银行信息审核','/bsm/bank/manager/list.do','/bsm/bank/manager/list.do#/bsm/bank/manager/toAudit.do',1,630,2,''，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/bank/manager' and METHOD ='toAudit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010093','/bsm/bank/manager','toAudit',2,'审核页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/bank/manager' and METHOD ='auditing' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010093','/bsm/bank/manager','auditing',2,'审核',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/bank/manager' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010093','/bsm/bank/manager','list',2,'银行信息审核列表',2,'B00000');
	end if;
	-----zyy end-------

	
	
	----CA证书管理添加菜单
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0100' and mkid='M010070' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M010070','M0100','基本设置','CA证书管理','/bsp/menber/cert/index.do','/bsp/menber/cert/index.do',1,700,1,'','M00000');
	end if;
	
	num:=0;
    select instr(inurl,'/bsp/cert/zfqd/index.do') into num from bs_qxsz where sid = 'M00000' and mkid='M010070';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bsp/cert/zfqd/index.do') where  sid = 'M00000' and mkid='M010070';
    end if;
    
    num:=0;
    select instr(inurl,'/bsp/cert/zfqd/toEdit.do') into num from bs_qxsz where sid = 'M00000' and mkid='M010070';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bsp/cert/zfqd/toEdit.do') where  sid = 'M00000' and mkid='M010070';
    end if;
    
    num:=0;
    select instr(inurl,'/bsp/cert/zfqd/toPay.do') into num from bs_qxsz where sid = 'M00000' and mkid='M010070';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bsp/cert/zfqd/toPay.do') where  sid = 'M00000' and mkid='M010070';
    end if;
    
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0100' and mkid='M01007005' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01007005','M0100','基本设置','申请证书','','', 2, 705, 1, 'M010070', 'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='index' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070','/bsp/menber/cert','index',2,'CA证书管理-列表查询',1,'M00000');
	end if;
	
	----------------- zhangzq CA证书新签、续签、补办 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='toEdit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','toEdit',2,'CA证书管理-新增编辑界面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='saveCert' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','saveCert',2,'CA证书管理-保存申请信息',1,'M00000');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='toAdd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','toAdd',2,'CA证书管理-续签信息页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='saveCertXq' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','saveCertXq',2,'CA证书管理-保存续签信息',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='toCertBb' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','toCertBb',2,'CA证书管理-补办信息页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='saveCertBb' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','saveCertBb',2,'CA证书管理-保存补办信息',1,'M00000');
	end if;
	----------------- zhangzq CA证书新签、续签、补办 end--------------------

	
	----------------- 2016-11-16 zhangzq CA证书吊销功能 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='toRevoke' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','toRevoke',2,'CA证书管理-吊销输入密码',1,'M00000');
	end if;
		
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='revoke' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','revoke',2,'CA证书管理-吊销CA证书',1,'M00000');
	end if;
	----------------- 2016-11-16 zhangzq CA证书吊销功能 end--------------------


	----------------- zhangzq CA证书查看、撤销 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='showCert' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','showCert',2,'CA证书管理-查看证书信息',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='delCert' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','delCert',2,'CA证书管理-删除CA证书(撤销申请)',1,'M00000');
	end if;
	----------------- zhangzq CA证书查看、撤销 end--------------------
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='index' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070','/bsp/cert/zfqd','index',2,'CA证书支付清单列表查询',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='toEdit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070','/bsp/cert/zfqd', 'toEdit', 2, 'CA证书生成支付清单界面', 1, 'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='saveZfqd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'saveZfqd',2,'CA证书生成支付清单',1,'M00000');
	end if;
	
	----------------- zhangzq CA证书支付清单删除、查看 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='delZfqd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'delZfqd',2,'删除CA证书支付清单',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='showZfqd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'showZfqd',2,'查看CA证书支付清单',1,'M00000');
	end if;
	----------------- zhangzq CA证书支付清单删除、查看 end--------------------
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='toPay' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'toPay',2,'证书支付清单-去支付',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='payZfqd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'payZfqd',2,'证书支付清单-支付',1,'M00000');
	end if;
	
	----------------- zhangzq CA证书确认收货 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='confirm' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010070', '/bsp/cert/zfqd', 'confirm',2,'证书支付清单-确认收货',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/cert/zfqd' and METHOD ='callback' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/bsp/cert/zfqd', 'callback',0,'中金在线支付回调请求',1,'M00000');
	end if;
	----------------- zhangzq CA证书确认收货 end--------------------
	
	num:=0;
	select count(1) into num from bs_value where key='BS_CA_CERT_ZFQD';   
	if num = 0 then
	   insert into bs_value (Gid, Key, Value, Remark, defaultvalue)
	   values('RunTime','BS_CA_CERT_ZFQD','1','0c56250615ac4f00aeb07e82c35ca249','161010');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0115' and mkid='B011560' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B011560','B0115','基本设置','CA证书订单','/bsm/cert/zfqd/index.do','/bsm/cert/zfqd/index.do',1,1600,2,'','B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0115' and mkid='B011565' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B011565','B0115','基本设置','CA证书管理','/bsm/menber/cert/index.do','/bsm/menber/cert/index.do',1,1650,2,'','B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='index' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','index',2,'CA证书订单-列表查询',2,'B00000');
	end if;
	
	----------------- zhangzq 后台CA证书支付清单查看、审核 start--------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='toEdit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','toEdit',2,'CA证书订单-订单查看',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='toAudit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','toAudit',2,'CA证书订单-审核证书界面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='agree' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','agree',2,'CA证书订单-证书审核通过',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='refuse' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','refuse',2,'CA证书订单-证书审核拒绝',2,'B00000');
	end if;
	----------------- zhangzq 后台CA证书支付清单查看、审核 end--------------------
	
	
	----------------- zhangzq 后台CA证书维护KEY编号 start-------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='toEditKeybh' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','toEditKeybh',2,'CA证书订单-跳转至维护KEY编号',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='editKeybh' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','editKeybh',2,'CA证书订单-维护KEY编号',2,'B00000');
	end if;
	----------------- zhangzq 后台CA证书维护KEY编号 end--------------------

	----------------- zhangzq 后台CA证书订单下载证书、单个退款、批量退款、发货 start-------------------	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='toCertDownload' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','toCertDownload',2,'CA证书订单-下载证书',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='refund' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','refund',2,'CA证书订单-单个退款操作',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='refundAll' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','refundAll',2,'CA证书订单-批量退款操作',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='sendOut' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','sendOut',2,'CA证书订单-发货操作',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='doSend' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','doSend',2,'CA证书订单-发货',2,'B00000');
	end if;
	----------------- zhangzq 后台CA证书订单下载证书、单个退款、批量退款、发货 end-------------------	
	
	num:=0;
    select instr(inurl,'/bsm/cert/zfqd/toEdit.do') into num from bs_qxsz where sid = 'B00000' and mkid='B011560';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bsm/cert/zfqd/toEdit.do') where  sid = 'B00000' and mkid='B011560';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/cert' and METHOD ='index' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011565','/bsm/menber/cert','index',2,'CA证书管理-列表查询',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/cert' and METHOD ='showCert' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011565','/bsm/menber/cert','showCert',2,'CA证书管理-查看证书',2,'B00000');
	end if;
	
	-----zyy start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='edit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','edit',2,'编辑资质信息 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='delGnvq' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','delGnvq',2,'删除资质信息 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='update' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','update',2,'更新 ',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='submit' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','submit',2,'提交 ',1,'M00000');
	end if;
	
	-----军民一体化
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='edit' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','edit',2,'编辑资质信息 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='delGnvq' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','delGnvq',2,'删除资质信息 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='update' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','update',2,'更新 ',1,'M01000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/info/gnvq' and METHOD ='submit' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M050090','/bsm/menber/info/gnvq','submit',2,'提交 ',1,'M01000');
	end if;
	
	-----后台资质信息审核
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B010094' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B010094','B0100','会员管理','资质信息审核','/bsm/gnvq/manager/list.do','/bsm/gnvq/manager/list.do#/bsm/gnvq/manager/toAudit.do',1,640,2,''，'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/gnvq/manager' and METHOD ='toAudit' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010094','/bsm/gnvq/manager','toAudit',2,'审核页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/gnvq/manager' and METHOD ='auditing' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010094','/bsm/gnvq/manager','auditing',2,'审核',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/gnvq/manager' and METHOD ='list' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B010094','/bsm/gnvq/manager','list',2,'资质信息审核列表',2,'B00000');
	end if;
	-----zyy end-------

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/jsxz' and METHOD ='perfect' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039610','/bsp/menber/jsxz','perfect',2,'完善角色',1,'M00000');
	end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M039610' and sid='M00000' and mid='M0396' and instr(inurl,'/bsp/menber/jsxz/perfect.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsp/menber/jsxz/perfect.do') where  mkid='M039610' and sid='M00000' and mid='M0396';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/jsxz' and METHOD ='perfect' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M039610','/bsp/menber/jsxz','perfect',2,'完善角色',1,'M01000');
	end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M039610' and sid='M01000' and mid='M0396' and instr(inurl,'/bsp/menber/jsxz/perfect.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsp/menber/jsxz/perfect.do') where  mkid='M039610' and sid='M01000' and mid='M0396';
	end if;

	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010001' and sid='B00000' and mid='B0100' and instr(inurl,'/bsm/menber/mbgnvq/editGnvq.do#/bsm/menber/mbzyry/editZyry.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/mbgnvq/editGnvq.do#/bsm/menber/mbzyry/editZyry.do') where  mkid='B010001' and sid='B00000' and mid='B0100';
	end if;

	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/cert/zfqd' and METHOD ='toMaking' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011560','/bsm/cert/zfqd','toMaking',2,'CA证书订单-证书制作',2,'B00000');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='loginok' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','loginok',0,'登录成功处理相关操作',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='loginok' and STYP=1 and SID='M01000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','loginok',0,'登录成功处理相关操作',1,'M01000');
	end if;
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014535' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014535','B0145','询价采购管理','时间区间统计表','/exm/querybusiness/sjqjtjb/list.do','/exm/querybusiness/sjqjtjb/list.do',1,500,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/sjqjtjb' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014535','/exm/querybusiness/sjqjtjb','list',2,'时间区间统计表',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin/publicfun' and METHOD ='selectGroupByHy' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/publicfun','selectGroupByHy',1,'复选集团',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/sjqjtjb' and METHOD ='export2Excel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014535','/exm/querybusiness/sjqjtjb','export2Excel',2,'时间区间统计表导出',2,'B00004');
	end if;
	
	-- add by wangch start ---
	--操作员管理员列表
	select count(1) into num from bs_qxsz where mkid='B011050' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011050','B0110','招标管理','操作员管理员列表','/bdm/czyglywh/whlist.do','/bdm/czyglywh/whlist.do',1,350,2,'B00008');
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/czyglywh' and  method='whlist' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011050','/bdm/czyglywh','whlist',2,'操作员管理员列表',2,'B00008'); 
	end if;
	
    select count(1) into num from bs_qxsz where mkid='B01105010' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,parent)
		values('B01105010','B0110','招标管理','删除一条操作员信息','/bdm/czyglywh/delMbopt.do','/bdm/czyglywh/whlist.do#/bdm/czyglywh/delMbopt.do#',2,100,2,'B00008','B011050');
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/czyglywh' and  method='delMbopt' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01105010','/bdm/czyglywh','delMbopt',2,'删除一条操作员信息',2,'B00008'); 
	end if;
	
	select count(1) into num from bs_qxsz where mkid='B01105050' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,parent)
		values('B01105050','B0110','招标管理','跳转到编辑页面','/bdm/czyglywh/toUpdate.do','/bdm/czyglywh/whlist.do#/bdm/czyglywh/toUpdate.do#',2,100,2,'B00008','B011050');
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/czyglywh' and  method='toUpdate' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01105050','/bdm/czyglywh','toUpdate',2,'跳转到编辑页面',2,'B00008'); 
	end if;
	
		select count(1) into num from bs_qxsz where mkid='B01105080' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,parent)
		values('B01105080','B0110','招标管理','保存修改信息','/bdm/czyglywh/update.do','/bdm/czyglywh/whlist.do#/bdm/czyglywh/update.do#',2,300,2,'B00008','B011050');
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/czyglywh' and  method='update' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01105080','/bdm/czyglywh','update',2,'保存修改信息',2,'B00008'); 
	end if;
	
	--by wangch end------

    -- add 20161122 by wangch start ---
	select count(1) into num from bs_qxmx where action='/psp/judge/jbropen' and  method='toDownZgyswj' and styp=1 and sid='M00009';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/jbropen','toDownZgyswj',1,'资格预审文件下载页面',1,'M00009'); 
	end if;
	--by wangch end------
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014540' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014540','B0145','询价采购管理','询价汇总统计表','/exm/querybusiness/hztjb/list.do','/exm/querybusiness/hztjb/list.do',1,600,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/hztjb' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014540','/exm/querybusiness/hztjb','list',2,'询价汇总统计表',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/querybusiness/hztjb' and METHOD ='export2Excel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014540','/exm/querybusiness/hztjb','export2Excel',2,'询价汇总统计表导出',2,'B00004');
	end if;
	
	
		num:=0;
	select count(1) into num from bs_qxsz where mid='B0125' and mkid='B012550' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B012550','B0125','废旧物资管理','时间区间统计表','/exm/auction/sjqjtjb/list.do','/exm/auction/sjqjtjb/list.do',1,500,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/sjqjtjb' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012550','/exm/auction/sjqjtjb','list',2,'时间区间统计表',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/sjqjtjb' and METHOD ='exportExcel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012550','/exm/auction/sjqjtjb','exportExcel',2,'时间区间统计表导出',2,'B00004');
	end if;
	
	
		num:=0;
	select count(1) into num from bs_qxsz where mid='B0125' and mkid='B012560' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B012560','B0125','废旧物资管理','汇总统计表','/exm/auction/hztjb/list.do','/exm/auction/hztjb/list.do',1,500,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/hztjb' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012560','/exm/auction/hztjb','list',2,'汇总统计表',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/hztjb' and METHOD ='exportExcel' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012560','/exm/auction/hztjb','exportExcel',2,'汇总统计表导出',2,'B00004');
	end if;
	---add by xuz end---

 num:=0;
  select count(1) into num from bs_qxmx where ACTION='/bdm/rewards' and METHOD ='list' and STYP=2 and SID='B00008';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/bdm/rewards','list',1,'奖惩记录列表',2,'B00008');
  end if;
  
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/rewards' and METHOD ='toAdd' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bdm/rewards','toAdd',1,'奖惩记录新增页面',2,'B00008');
	end if;
  
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/rewards' and METHOD ='save' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/bdm/rewards','save',1,'奖惩记录保存',2,'B00008');
	end if;  

	---add by xuz start--
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0180' and mkid='B018060' and sid='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B018060','B0180','交易统计报表','品类统计表','/exm/report/pltjb/list.do','/exm/report/pltjb/list.do',1,500,2,'','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/report/pltjb' and METHOD ='list' and STYP=2 and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B018060','/exm/report/pltjb','list',2,'品类统计表',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0180' and mkid='B01806005' and sid='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01806005','B0180','交易统计报表','导出','','',2,550,2,'B018060','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/report/pltjb' and METHOD ='export2Excel' and STYP=2 and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01806005','/exm/report/pltjb','export2Excel',2,'品类统计表导出',2,'B00201');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0180' and mkid='B018070' and sid='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B018070','B0180','交易统计报表','子集团统计表','/exm/report/zjttjb/list.do','/exm/report/zjttjb/list.do',1,600,2,'','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/report/zjttjb' and METHOD ='list' and STYP=2 and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B018070','/exm/report/zjttjb','list',2,'子集团统计表',2,'B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0180' and mkid='B01807005' and sid='B00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01807005','B0180','交易统计报表','导出','','',2,650,2,'B018070','B00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/report/zjttjb' and METHOD ='export2Excel' and STYP=2 and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01807005','/exm/report/zjttjb','export2Excel',2,'子集团统计表导出',2,'B00201');
	end if;
	---add by xuz end---

	-----2016-10-31 dongbin start-----
	----废旧物资   资质信息不同意 拒绝理由
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/tray' and METHOD ='reject' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023530','/exp/auction/sell/tray','reject',2,'卖家-不同意资质信息',1,'M00004');
	end if;
	-----dongbin end-------

	-----2016-10-31 dongbin start-----
	----废旧物资   资质信息不同意  跳转拒绝理由
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/tray' and METHOD ='toReject' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023530','/exp/auction/sell/tray','toReject',2,'拒绝理由',1,'M00004');
	end if;
	-----dongbin end-------

	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M023550' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='新增交易场次' where mkid='M023550' and sid='M00004'; 
    end if;

	---add by zyy start--
	---我的竞价（卖）
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0235' and mkid='M023560' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M023560','M0235','我 要 卖','我的竞价','/exp/auction/sell/bidding/list.do','/exp/auction/sell/bidding/list.do',1,500,1,'','M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='list' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','list',2,'我的竞价（卖）列表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='showInfo' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','showInfo',2,'查看',1,'M00004');
	end if;
	
	---我的竞价（买）
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0240' and mkid='M024040' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M024040','M0240','竞价出价','我的竞价','/exp/auction/buy/bid/list.do','/exp/auction/buy/bid/list.do',1,400,1,'','M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bid' and METHOD ='list' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024040','/exp/auction/buy/bid','list',2,'我的竞价（买）列表',1,'M00004');
	end if;
	---add by zyy end---
	-----add by dongbin start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='showContractYy' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','showContractYy',0,'跳转合同异议',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='download' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','download',0,'合同附件下载',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='showContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','showContract',0,'跳转上传合同页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='saveContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','saveContract',0,'提交合同',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='saveContractYy' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','saveContractYy',0,'提交合同异议',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='seeContractYy' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','seeContractYy',0,'查看异议结果',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='showSelljgmx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','showSelljgmx',0,'查看竞拍结果明细',1,'M00004');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M023540' and sid='M00004' and mid='M0235' and instr(inurl,'/exp/auction/sell/result/showSelljgmx.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/auction/sell/result/showSelljgmx.do') where  mkid='M023540' and sid='M00004' and mid='M0235';
	end if;
	
	-----add by dongbin end-----
    ---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bout' and METHOD ='toZfyebz' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/auction/buy/bout','toZfyebz',0,'保证金余额不足',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bout' and METHOD ='toZfbzj' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/auction/buy/bout','toZfbzj',0,'支付保证金',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from  bs_xtmk where sid='M00004' and mid='M00390'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M00390', '保证金管理', 1, 350, 'M00004','004-1-5');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M00390' and mkid='M0039010' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M0039010','M00390','保证金管理','保证金支付申请单','/exp/auction/buy/bzjgl/index.do','/exp/auction/buy/bzjgl/index.do#/exp/auction/buy/bzjgl/creatZfsqd.do#/exp/auction/buy/bzjgl/creatPlZfsqd',1,100,1,'','M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjgl' and METHOD ='index' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039010','/exp/auction/buy/bzjgl','index',2,'保证金管理列表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjgl' and METHOD ='creatZfsqd' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039010','/exp/auction/buy/bzjgl','creatZfsqd',2,'生成支付申请单',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjgl' and METHOD ='creatPlZfsqd' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039010','/exp/auction/buy/bzjgl','creatPlZfsqd',2,'多个场次生成支付申请单',1,'M00004');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M00390' and mkid='M0039020' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M0039020','M00390','保证金管理','查看支付申请单','/exp/auction/buy/bzjglck/index.do','/exp/auction/buy/bzjglck/index.do#/exp/auction/buy/bzjglck/printZfsqd.do',1,200,1,'','M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjglck' and METHOD ='index' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039020','/exp/auction/buy/bzjglck','index',2,'支付申请单列表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjglck' and METHOD ='printZfsqd' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039020','/exp/auction/buy/bzjglck','printZfsqd',2,'打印支付申请单',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M00390' and mkid='M0039030' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M0039030','M00390','保证金管理','保证金账户明细','/exp/auction/buy/bzjmx/index.do','/exp/auction/buy/bzjmx/index.do#/exp/auction/buy/bzjmx/djIndex.do#/exp/auction/buy/bzjmx/bzjTx.do#/exp/auction/buy/bzjmx/doBzjTx.do',1,300,1,'','M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='index' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','index',2,'保证金明细',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='djIndex' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','djIndex',2,'保证金冻结明细',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='bzjTx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','bzjTx',2,'保证金提现页面',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='doBzjTx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','doBzjTx',2,'保证金提现',1,'M00004');
	end if;
	---add by xuz end---
	--add by huangxq start ---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/result' and METHOD ='showContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024030','/exp/auction/buy/result','showContract',0,'保存合同',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/result' and METHOD ='saveContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024030','/exp/auction/buy/result','saveContract',0,'保存合同',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/result' and METHOD ='downLoad' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024030','/exp/auction/buy/result','downLoad',0,'下载合同',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/result' and METHOD ='showResult' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024030','/exp/auction/buy/result','showResult',0,'买家查看异议',1,'M00004');
	end if;
	
	--add by huangxq end---

	---add by zyy start--
	---废旧物资合同审核（后台）
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0125' and mkid='B012570' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B012570','B0125','废旧物资管理','废旧物资合同审核','/exm/auction/bout/pact/list.do','/exm/auction/bout/pact/list.do',1,350,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','list',2,'合同审核列表',2,'B00004');
	end if;
	
	---add by zyy end---

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showZzxx' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showZzxx',2,'拍卖管理：资质信息查看',2,'B00004');
	end if;
	
	---add by dongbin strat---
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='saveContractYy' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='saveContractYy' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='showContractYy' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='showContractYy' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='download' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='download' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='showContract' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='showContract' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='showSelljgmx' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='showSelljgmx' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='seeContractYy' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='seeContractYy' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where sid='M00004' and method ='saveContract' and action='/exp/auction/sell/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag='2' where sid='M00004' and method ='saveContract' and action='/exp/auction/sell/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='agreeContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','agreeContract',2,'确认买家合同(无异议)',1,'M00004');
	end if;
	
	---add by dongbin end---
	
	---add by xuz start---
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='bzjTxmx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','bzjTxmx',2,'保证金提现明细',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='delBzjmx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','delBzjmx',2,'删除保证金提现',1,'M00004');
	end if;
	---add by xuz end-----

	---add by huangxq end---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='auditContract' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','auditContract',2,'卖家合同审核',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='auditYY' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','auditYY',2,'异议处理',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='downLoad' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','downLoad',2,'合同下载',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='agree' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','agree',2,'合同审核通过',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='refuse' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','refuse',2,'合同审核拒绝',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M024030' and method ='downLoad' and action='/exp/auction/buy/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag=2 where mkid='M024030' and method ='downLoad' and action='/exp/auction/buy/result' and styp=1;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M024030' and method ='showResult' and action='/exp/auction/buy/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag=2 where mkid='M024030' and method ='showResult' and action='/exp/auction/buy/result' and styp=1;
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M024030' and method ='showContract' and action='/exp/auction/buy/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag=2 where mkid='M024030' and method ='showContract' and action='/exp/auction/buy/result' and styp=1;
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M024030' and method ='saveContract' and action='/exp/auction/buy/result' and styp=1;
	if num = 1 then
		update bs_qxmx set accesstag=2 where mkid='M024030' and method ='saveContract' and action='/exp/auction/buy/result' and styp=1;
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='treated' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','treated',2,'异议处理提交',2,'B00004');
	end if;
	
			num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bid' and METHOD ='auditZzxx' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024040','/exp/auction/buy/bid','auditZzxx',2,'资质审核信息',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/bout/pact' and METHOD ='refuseYY' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012570','/exm/auction/bout/pact','refuseYY',2,'异议审核拒绝',2,'B00004');
	end if;
	---add by huangxq end---

	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='downZzxx' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','downZzxx',2,'下载资质信息',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='downContract' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','downContract',2,'下载合同附件',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showContract' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showContract',2,'拍卖管理：合同协议查看',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showContractYy' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showContractYy',2,'拍卖管理：异议信息查看',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showResultContractYy' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showResultContractYy',2,'拍卖管理：异议信息结果查看',2,'B00004');
	end if;
	
	
	---add by dongbin end---
	---add by huangxq start---
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bout' and METHOD ='companyMsg' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024010','/exp/auction/buy/bout','companyMsg',2,'单位资质信息查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bout' and METHOD ='downimg' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024010','/exp/auction/buy/bout','downimg',2,'查看附件',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bid' and METHOD ='downLoad' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024040','/exp/auction/buy/bid','downLoad',2,'下载资质文件',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='auditZzxx' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','auditZzxx',2,'资质信息',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='joinMb' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','joinMb',2,'报名会员信息',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showPrice' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showPrice',2,'出价详情',2,'B00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='showNotice' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','showNotice',2,'出价详情',2,'B00004');
	end if;
	---add by huangxq end---
	
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/jupai/jpInterface' and METHOD ='syncUser' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/jupai/jpInterface','syncUser',0,'同步用户信息',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/jupai/jpInterface' and METHOD ='syncPrice' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/jupai/jpInterface','syncPrice',0,'同步报价信息',1,'M00004');
	end if;
	---add by xuz end-----
	
	num:=0;
	select count(1) into num from bs_cssz where cskey='CA_YUNFEE';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0, unit, orderno) 
		values('CA_YUNFEE','CA证书运费','0','0','系统管理员','','1','元',1120);
	end if; 
	
	---add by dongbin start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='showZzxx' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','showZzxx',2,'资质审核信息查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='showCjxq' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','showCjxq',2,'出价详情查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='showJjgg' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','showJjgg',2,'竞价公告查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='downLoad' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','downLoad',2,'资质信息文件下载',1,'M00004');
	end if;
	
	---add by dongbin end-----
	
	---add by xuz start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='loadDfbList' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01700505','/exp/querybusiness/buy','loadDfbList',2,'加载询价商品',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M01700505' and method ='loadDfbList' and action='/exp/querybusiness/buy' and styp=1 and sid='M00004';
	if num = 1 then
		update bs_qxmx set mkid='M017005' where mkid='M01700505' and method ='loadDfbList' and action='/exp/querybusiness/buy' and styp=1 and sid='M00004';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/buy' and METHOD ='loadDfbList' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/buy','loadDfbList',2,'加载询价商品',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='loadXjzList' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/process/buy','loadXjzList',2,'加载询价中报价详情',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/buy' and METHOD ='loadXjzList' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/process/buy','loadXjzList',2,'加载询价中报价详情',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/completed/buy' and METHOD ='loadXjjg' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/completed/buy','loadXjjg',2,'加载询价结果报价详情',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/completed/buy' and METHOD ='loadXjjg' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/completed/buy','loadXjjg',2,'加载询价结果报价详情',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='loadSellXjgl' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018005','/exp/querybusiness/process/sell','loadSellXjgl',2,'加载卖家询价管理商品',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='loadSellXjgl' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018005','/exp/querybusiness/process/sell','loadSellXjgl',2,'加载卖家询价管理商品',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='loadSellXjjg' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018005','/exp/querybusiness/process/sell','loadSellXjjg',2,'加载卖家询价结果',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='loadSellXjjg' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M018005','/exp/querybusiness/process/sell','loadSellXjjg',2,'加载卖家询价结果',1,'M00004');
	end if;
	
	
	---add by xuz end-----

	---add by zyy start-----
	---我的竞价（买）
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0240' and mkid='M024050' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M024050','M0240','竞价出价','竞价中','/exp/auction/buy/tray/bidding/list.do','/exp/auction/buy/tray/bidding/list.do',1,250,1,'','M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/tray/bidding' and METHOD ='list' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024050','/exp/auction/buy/tray/bidding','list',2,'竞价中（买）列表',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024010' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='参与竞价' where mkid='M024010' and sid='M00004'; 
    end if;
	---add by zyy end---

	
		num:=0;
	select count(1) into num from bs_value where key='CFCA-POSTURL' AND Gid='RunTime';   
	if num = 0 then
	   insert into bs_value (Gid, Key, Value, Remark)
	   values('RunTime','CFCA-POSTURL','http://192.168.1.107:8080/bsplatform/bsp/cert/zfqd/callback.do','CA-KEY中金在线支付回调地址');
	end if;


	---add by huangxq statrt--
		
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bid' and METHOD ='downPage' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024040','/exp/auction/buy/bid','downPage',2,'资质信息下载页面跳转',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/auction/tray' and METHOD ='downPage' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012530','/exm/auction/tray','downPage',2,'后台资质信息下载页面跳转',2,'B00004');
	end if;
	---add by huangxq end----


	---add by xuz start---
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='toBzjCz' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','toBzjCz',2,'保证金充值页面',1,'M00004');
	end if;
	---add by xuz end---
	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='downPage' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','downPage',2,'资质信息下载页面跳转',1,'M00004');
	end if;
	---add by dongbin end---

	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/result' and METHOD ='refuseContract' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023540','/exp/auction/sell/result','refuseContract',2,'拒绝买家合同',1,'M00004');
	end if;
	---add by dongbin end---

	---add by zyy start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/coding' and METHOD ='cpsave' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M040010','/bsm/menber/coding','cpsave',2,'单条产品赋码保存',1,'M00000');
	end if;
	---add by zyy end---


	---add by huangxq start--
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid ='M023530' and name='交易中';
	if num = 1 then
		update bs_qxsz set name='竞价中' where sid='M00004' and mkid ='M023530';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid ='M023540' and name='交易结果';
	if num = 1 then
		update bs_qxsz set name='竞价结果' where sid='M00004' and mkid ='M023540';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00004' and mkid ='M023560' and name='我的竞价';
	if num = 1 then
		update bs_qxsz set name='我提报的竞价' where sid='M00004' and mkid ='M023560';
	end if;
	---add by huangxq end ---


	---add by dongbin start-----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/contract/bill/manage' and METHOD ='exportExcel' and STYP=2 and SID='B00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/exm/contract/bill/manage','exportExcel',2,'货款结算单-导出',2,'B00201');
	end if;
	---add by dongbin end-----

	---add by xuz start---
	num:=0;
    select count(1) into num from  bs_xtmk where sid='B00004' and mid='B0155'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('B0155', '保证金管理', 2, 350, 'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0155' and mkid='B015505' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B015505','B0155','保证金管理','保证金账户明细','/exm/bzjgl/bzjls/list.do','/exm/bzjgl/bzjls/list.do',1,50,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/bzjls' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015505','/exm/bzjgl/bzjls','list',2,'保证金账户明细',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0155' and mkid='B015510' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B015510','B0155','保证金管理','保证金账户余额','/exm/bzjgl/bzjye/list.do','/exm/bzjgl/bzjye/list.do',1,100,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/bzjye' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015510','/exm/bzjgl/bzjye','list',2,'保证金账户余额',2,'B00004');
	end if;
	
	---add by xuz end---


	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0155' and mkid='B015515' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B015515','B0155','保证金管理','保证金审核','/exm/bzjgl/auditing/list.do','/exm/bzjgl/auditing/list.do',1,150,2,'','B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/auditing' and METHOD ='list' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015515','/exm/bzjgl/auditing','list',2,'保证金审核',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/auditing' and METHOD ='toAudit' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015515','/exm/bzjgl/auditing','toAudit',2,'进入审核页面',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/auditing' and METHOD ='doAudit' and STYP=2 and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015515','/exm/bzjgl/auditing','doAudit',2,'审核',2,'B00004');
	end if;
	
	---add by xuz start----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M0039010'and mid='M00390' and url='/exp/auction/buy/bzjgl/index.do' and sid='M00004';     
    if num = 1 then
	     update bs_qxsz set isuse=2 where mkid='M0039010'and mid='M00390' and url='/exp/auction/buy/bzjgl/index.do' and sid='M00004';     
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M0039020'and mid='M00390' and url='/exp/auction/buy/bzjglck/index.do' and sid='M00004' and name='查看支付申请单';     
    if num = 1 then
	     update bs_qxsz set name='保证金支付记录' where mkid='M0039020'and mid='M00390' and url='/exp/auction/buy/bzjglck/index.do' and sid='M00004' and name='查看支付申请单';     
    end if;
    ---add by xuz end---

	---add by zyy start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/menber/checkgroup' and METHOD ='update' and STYP=2 and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011550','/bsm/menber/checkgroup','update',2,'启用/关闭审批流',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bidding' and METHOD ='judge' and STYP=1 and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023560','/exp/auction/sell/bidding','judge',0,'判断买卖家',1,'M00004');
	end if;
	---add by zyy end---
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0108' and mkid='M010835' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M010835','M0108','采购订单','订单审核','/exp/contract/buy/auditContract/list.do','/exp/contract/buy/auditContract/list.do',1,700,1,'','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/buy/auditContract' and METHOD ='list' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010835','/exp/contract/buy/auditContract','list',2,'订单审核列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/buy/auditContract' and METHOD ='agreeContract' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010835','/exp/contract/buy/auditContract','agreeContract',2,'订单审核同意',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/contract/buy/auditContract' and METHOD ='refuseContract' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010835','/exp/contract/buy/auditContract','refuseContract',2,'订单审核拒绝',1,'M00201');
	end if;
	---add by xuz end---
	---add by dongbin start---
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024010' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='可参与场次' where mkid='M024010' and sid='M00004'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024050' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='已参与-竞价中' where mkid='M024050' and sid='M00004'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024030' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='已参与-竞价结束' where mkid='M024030' and sid='M00004'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024040' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set name='我参与的竞价' where mkid='M024040' and sid='M00004'; 
    end if;
    
    ---- 买家  已参与-未开始
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0240' and mkid='M024060' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M024060','M0240','竞价出价','已参与-未开始','/exp/auction/buy/tostart/list.do','/exp/auction/buy/tostart/list.do',1,500,1,'M00004');
	end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/tostart' and METHOD ='list' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M024060','/exp/auction/buy/tostart','list',2,'已参加-未开始（买）列表',1,'M00004');
	end if;
	---add by dongbin end---
	
	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/process/sell' and METHOD ='exportExcel' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01800505','/exp/querybusiness/process/sell','exportExcel',2,'商品询价-询价报价-产品明细导出',1,'M00004');
	end if;
	
	---add by dongbin end---
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0155' and mkid='B015520' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B015520','B0155','保证金管理','保证金退款','/exm/bzjgl/returnDeposit/list.do','/exm/bzjgl/returnDeposit/list.do#/exm/bzjgl/returnDeposit/returnDeposit.do',1,300,2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/returnDeposit' and METHOD ='list' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015520','/exm/bzjgl/returnDeposit','list',2,'保证金退款列表',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/returnDeposit' and METHOD ='returnDeposit' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015520','/exm/bzjgl/returnDeposit','returnDeposit',2,'保证金退款',2,'B00004');
	end if;
	---add by xuz end---

	---add by zyy start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/buy/bzjmx' and METHOD ='bzjSubmit' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M0039030','/exp/auction/buy/bzjmx','bzjSubmit',2,'保证金提交/取消提交',1,'M00004');
	end if;
	---add by zyy end---
	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/auction/sell/bout' and METHOD ='upLoadImage' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M023550','/exp/auction/sell/bout','upLoadImage',2,'上传图片',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M024060' and sid='M00004'; 
    if num = 1 then
	     update bs_qxsz set orderno=150 where mkid='M024060' and sid='M00004'; 
    end if;
	---add by dongbin end---

	---add by zyy start---
	--后台，手机登录情况
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0120' and mkid='B012025' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B012025','B0120','系统管理','手机登录情况','/bsm/phone/login/jump.do','/bsm/phone/login/todayList.do#/bsm/phone/login/allList.do',1,500,2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/phone/login' and METHOD ='jump' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012025','/bsm/phone/login','jump',2,'跳转',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/phone/login' and METHOD ='todayList' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012025','/bsm/phone/login','todayList',2,'当天情况',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/phone/login' and METHOD ='allList' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B012025','/bsm/phone/login','allList',2,'历史情况',2,'B00000');
	end if;
	---add by zyy end---
	
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='list' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','list',2,'询比价待交易页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='list' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','list',2,'询比价待交易页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='preview' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','preview',2,'订单填写页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='preview' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','preview',2,'订单填写页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='saveContract2Tmp' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','saveContract2Tmp',2,'数据到合同临时表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='saveContract2Tmp' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','saveContract2Tmp',2,'数据到合同临时表',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='createbill' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','createbill',2,'生成订单',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='createbill' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','createbill',2,'生成订单',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='createbill' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','createbill',2,'生成订单',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='toAddShd' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','toAddShd',2,'打开交货地新增页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='toAddShd' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','toAddShd',2,'打开交货地新增页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='saveShd' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','saveShd',2,'保存收货单',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='saveShd' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','saveShd',2,'保存收货单',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='refusePrice' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','refusePrice',2,'拒绝报价',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='refusePrice' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','refusePrice',2,'拒绝报价',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='loadXjzList' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','loadXjzList',2,'加载竞价中报价详情',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='loadXjzList' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','loadXjzList',2,'加载竞价中报价详情',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='downLoad' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','downLoad',2,'附件下载查看',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='downLoad' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','downLoad',2,'附件下载查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='review' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','review',2,'上传评审意见',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='review' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','review',2,'上传评审意见',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='downloadReview' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','downloadReview',2,'下载专家评审意见',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djy/buy' and METHOD ='downloadReview' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017005','/exp/querybusiness/djy/buy','downloadReview',2,'下载专家评审意见',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M017005' and sid='M00004' and mid='M0170' and instr(inurl,'/exp/querybusiness/djy/buy/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/querybusiness/djy/buy/list.do') where  mkid='M017005' and sid='M00004' and mid='M0170';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M017005' and sid='M04000' and mid='M0170' and instr(inurl,'/exp/querybusiness/djy/buy/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/querybusiness/djy/buy/list.do') where  mkid='M017005' and sid='M04000' and mid='M0170';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M017015' and sid='M00004' and mid='M0170' and instr(inurl,'/exp/querybusiness/djylaw/buy/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/querybusiness/djylaw/buy/list.do') where  mkid='M017015' and sid='M00004' and mid='M0170';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M017015' and sid='M04000' and mid='M0170' and instr(inurl,'/exp/querybusiness/djylaw/buy/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/querybusiness/djylaw/buy/list.do') where  mkid='M017015' and sid='M04000' and mid='M0170';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='list' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','list',2,'待交易列表',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='list' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','list',2,'待交易列表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='previewLaw' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','previewLaw',2,'订单填写页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='previewLaw' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','previewLaw',2,'订单填写页面',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='saveContract2TmpLaw' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','saveContract2TmpLaw',2,'数据到合同临时表',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='saveContract2TmpLaw' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','saveContract2TmpLaw',2,'数据到合同临时表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='createbillLaw' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','createbillLaw',2,'生成订单',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='createbillLaw' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','createbillLaw',2,'生成订单',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='refusePrice' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','refusePrice',2,'订单填写页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='refusePrice' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','refusePrice',2,'订单填写页面',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='downLoad' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','downLoad',2,'附件下载查看',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='downLoad' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','downLoad',2,'附件下载查看',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='review' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','review',2,'上传评审意见',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='review' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','review',2,'上传评审意见',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='downloadReview' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','downloadReview',2,'下载专家评审意见',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='downloadReview' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','downloadReview',2,'下载专家评审意见',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='toExpert' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','toExpert',2,'进入选择专家页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='toExpert' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','toExpert',2,'进入选择专家页面',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='expert' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','expert',2,'保存选择专家页面',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='expert' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','expert',2,'保存选择专家页面',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='showPriceType' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','showPriceType',2,'查看报价方案',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='showPriceType' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','showPriceType',2,'查看报价方案',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='export' and SID='M04000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','export',2,'导出报价信息',1,'M04000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/querybusiness/djylaw/buy' and METHOD ='export' and SID='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M017015','/exp/querybusiness/djylaw/buy','export',2,'导出报价信息',1,'M00004');
	end if;
	---add by xuz end---

	---2016-12-27 添加是否开启单点登录票据平台开关和权限	hanglong start---
	num :=0;
	select count(1) into num from bs_value where gid='SYSTEM' and key='IS_SIGN_LOGIN_WITH_BP';
	if num=0 then
		insert into bs_value(gid, key, VALUE, REMARK, DEFAULTVALUE, LASTUPT)
		values('SYSTEM','IS_SIGN_LOGIN_WITH_BP','0','是否开启单点登录票据平台开关(0-关闭,1-开启)','0','');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin/login' and METHOD ='bpIndex' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/login','bpIndex',0,'票据登录页面',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/admin/login' and METHOD ='doBpLogout' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/admin/login','doBpLogout',1,'票据退出登录',2,'B00000');
	end if;
	---2016-12-27 添加是否开启单点登录票据平台开关和权限	hanglong end---

	---add by dongbin start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exm/bzjgl/auditing' and METHOD ='bzjxq' and SID='B00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B015515','/exm/bzjgl/auditing','bzjxq',2,'保证金详情',2,'B00004');
	end if;
	---add by dongbin end---

	-----zyy start-----
	-----增加结算商默认权限组
	num:=0;
	select count(1) into num from bs_cssz where cskey='WSCS_JSS_GROUP_QX';
	if num = 0 then
		insert into bs_cssz(cskey,csmc,csvalue,opt,remark,flag0,orderno,csbz) 
		values('WSCS_JSS_GROUP_QX','网上超市结算商权限组','M00001','系统管理员','网上超市结算商权限组','1',1540,'网上超市结算商权限组');
	end if;
	-----zyy end-----

	-----zyy start-----
	------结算商管理
	num:=0;
    select count(1) into num from  bs_xtmk where sid='M00201' and mid='M0210'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0210', '结算商管理', 1, 1100, 'M00201','201-2');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0210' and mkid='M021005' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M021005','M0210','结算商管理','合格结算商','/exp/market/settle/list.do','/exp/market/settle/list.do',1,100,1,'','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='list' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','list',2,'合格结算商列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='view' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','view',2,'结算商信息',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='disEn' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','disEn',2,'启用、停用',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='search' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','search',2,'潜在结算商',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='toAdd' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','toAdd',2,'成为我的结算商',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/settle' and METHOD ='record' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021005','/exp/market/settle','record',2,'结算商管理记录',1,'M00201');
	end if;
	
	
	-------------  结算商审批  ------------------
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0210' and mkid='M021010' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M021010','M0210','结算商管理','结算商审批','/exp/market/check/settle/list.do','/exp/market/check/settle/list.do',1,200,1,'','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/check/settle' and METHOD ='list' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021010','/exp/market/check/settle','list',2,'结算商审批列表',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/check/settle' and METHOD ='view' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021010','/exp/market/check/settle','view',2,'结算商信息',1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/market/check/settle' and METHOD ='update' and STYP=1 and SID='M00201';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M021010','/exp/market/check/settle','update',2,'同意/拒绝',1,'M00201');
	end if;
	
	-----zyy end-----


	---add by dongbin start 设置询价出价需要业务模块权限才能访问---
	num:=0;
    select count(1) into num from  bs_qxmx where mkid='M01800505' and sid='M00004' and action='/exp/querybusiness/process/sell' and method='joinPrice'; 
    if num = 1 then
	     update bs_qxmx set accesstag=2 where mkid='M01800505' and sid='M00004' and action='/exp/querybusiness/process/sell' and method='joinPrice'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxmx where mkid='M01801505' and sid='M00004' and action='/exp/querybusiness/processlaw/sell' and method='joinPrice'; 
    if num = 1 then
	     update bs_qxmx set accesstag=2 where mkid='M01801505' and sid='M00004' and action='/exp/querybusiness/processlaw/sell' and method='joinPrice'; 
    end if;
    ---add by dongbin end---
	---add by dongbin start 基础设置 基础银行信息维护---
    num:=0;
	select count(1) into num from bs_qxsz where mid='B0115' and mkid='B011570' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011570','B0115','基本设置','基本银行信息维护','/bsm/basesetup/bank/list.do','/bsm/basesetup/bank/list.do',1,1700,2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='list' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','list',2,'基本银行信息维护',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='toAdd' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','toAdd',2,'新增基本银行信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='saveBaseBank' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','saveBaseBank',2,'新增保存基本银行信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='toEdit' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','toEdit',2,'修改基本银行信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='deleteBaseBank' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','deleteBaseBank',2,'删除基本银行信息',2,'B00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsm/basesetup/bank' and METHOD ='updateBaseBank' and SID='B00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011570','/bsm/basesetup/bank','updateBaseBank',2,'修改保存基本银行信息',2,'B00000');
	end if;
	---add by dongbin end---

	--add by huangxq start--
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0120' and mkid='B012030' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B012030','B0120','系统管理','系统站点维护','/bsm/system/site/list.do','',1,600,2,'B00000');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxsz where mid='B0120' and mkid='B012040' and sid='B00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B012040','B0120','系统管理','站点应用维护','/bsm/site/application/list.do','',1,700,2,'B00000');
	end if;
	
   num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='list' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','list','2','站点维护页面','2','B00000');
    end if;
    
      num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='list' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','list','2','站点应用维护页面','2','B00000');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='toAdd' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','toAdd','2','跳转到站点添加页面','2','B00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='toEdit' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','toEdit','2','跳转到站点编辑页面','2','B00000');
    end if;
    
        num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='toDel' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','toDel','2','删除站点信息','2','B00000');
    end if;
    
       num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='save' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','save','2','保存站点信息','2','B00000');
    end if;
    
        num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='update' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','update','2','修改站点信息','2','B00000');
    end if;
    
         num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='toAdd' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','toAdd','2','跳转到站点维护新增页面','2','B00000');
    end if;
    
            num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='toEdit' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','toEdit','2','跳转到站点维护修改页面','2','B00000');
    end if;
    
       num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='toDel' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','toDel','2','删除应用信息','2','B00000');
    end if;
    
          num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='save' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','save','2','保存应用信息','2','B00000');
    end if;
    
              num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='update' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','update','2','修改应用信息','2','B00000');
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='B012030' and sid='B00000'; 
    if num = 1 then
	     update bs_qxsz set inurl='/bsm/system/site/toDel.do#/bsm/system/site/toBuild.do' where mkid='B012030' and sid='B00000'; 
    end if;
    
        num:=0;
    select count(1) into num from  bs_qxsz where mkid='B012040' and sid='B00000'; 
    if num = 1 then
	     update bs_qxsz set inurl='/bsm/site/application/toDel.do#/bsm/site/application/toBuild.do' where mkid='B012040' and sid='B00000'; 
    end if;
    
      num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/system/site' and method='toBuild' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012030','/bsm/system/site','toBuild','2','生成密钥','2','B00000');
    end if;
    
        num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/site/application' and method='toBuild' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012040','/bsm/site/application','toBuild','2','生成密钥','2','B00000');
    end if;
    
       num:=0;
    select count(1) into num from bs_qxmx where  action='/admin/publicfun' and method='newMenber' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/admin/publicfun','newMenber','1','会员管理-查询会员列表(新)','2','B00000');
    end if;
	-- add by huangxq end--
	-- add by xuz start---
	 num:=0;
    select count(1) into num from bs_qxmx where  action='/market/publicfun' and method='settleNew' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/market/publicfun','settleNew','0','结算商选择','1','M00201');
    end if;
	-- add by xuz end---

	----hanglong  2017-1-7  票据平台前台登录  start---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/login' and method='bpIndex' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/login','bpIndex','0','票据平台前台登录页面','1','M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/login' and method='bpLogin' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/login','bpLogin','0','票据平台前台登录','1','M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/login' and method='bpLogout' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/login','bpLogout',1,'票据平台前台退出登录','1','M00000');
    end if;
	----hanglong  2017-1-7  票据平台前台登录  end---
	--- xuzhen  2017-1-7  承兑汇票管理中心 start---------
	num:=0;
    select count(1) into num from  bs_xtmk where sid='M00201' and mid='M0220'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0220', '承兑汇票管理中心', 1, 310, 'M00201', '201-1');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0220' and mkid='M022005' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M022005','M0220','承兑汇票管理中心','承兑汇票管理','/exp/accept/buy/acceptBill/list.do','',1,100,1,'M00201');
	end if;
	
	 num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='list' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005','/exp/accept/buy/acceptBill','list',2,'承兑汇票管理列表页','1','M00201');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='toAdd' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005','/exp/accept/buy/acceptBill','toAdd',2,'承兑汇票新增页面','1','M00201');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='addBusinessPj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M02200505','/exp/accept/buy/acceptBill','addBusinessPj',2,'新增商业承兑汇票','1','M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='addBankPj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M02200510','/exp/accept/buy/acceptBill','addBankPj',2,'新增银行承兑汇票','1','M00201');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M022005' and sid='M00201' and mid='M0220' and instr(inurl,'/exp/accept/buy/acceptBill/toAdd.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/accept/buy/acceptBill/toAdd.do') where  mkid='M022005' and sid='M00201' and mid='M0220';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0220' and mkid='M02200505' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02200505','M0220','承兑汇票管理中心','新增商业承兑汇票','','',2,200,1,'M022005','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0220' and mkid='M02200510' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02200510','M0220','承兑汇票管理中心','新增银行承兑汇票','','',2,300,1,'M022005','M00201');
	end if;
	--- xuzhen  2017-1-7  承兑汇票管理中心 end---------

	----------------------------------------- hanglong 2017-1-11 变更付款方式 start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='updatePayType' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005', '/exp/contract/buy/manage', 'updatePayType', 2, '变更承兑汇票订单的付款方式为现金支付', '1', 'M00201');
    end if;
	----------------------------------------- hanglong 2017-1-11 变更付款方式 end ------------------------------------------

	--- huangxq  2017-1-7  承兑汇票管理中心 start---------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='toSub' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005', '/exp/accept/buy/acceptBill', 'toSub', 2, '提交承兑汇票', '1', 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='seeReason' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005', '/exp/accept/buy/acceptBill', 'seeReason', 2, '查看拒绝理由', '1', 'M00201');
    end if;
	--- huangxq  2017-1-7  承兑汇票管理中心  end---------

	--- dongbin  2017-1-12  承兑汇票管理中心-选择结算单位 start---------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/market/publicfun' and method='settleJsNew' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/market/publicfun','settleJsNew',0,'结算单位选择','1','M00201');
    end if;
	--- dongbin  2017-1-12  承兑汇票管理中心 -选择结算单位  end---------
	--- dongbin  2017-1-13  承兑汇票管理中心start---------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='savePj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005','/exp/accept/buy/acceptBill','savePj',2,'保存承兑汇票','1','M00201');
    end if;
	--- dongbin  2017-1-13  承兑汇票管理中心 end---------
	--- zyy  2017-1-16  承兑汇票申请支付清单 start---------
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0108' and mkid='M01081060' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01081060','M0108','采购订单','新增承兑汇票支付申请','','',2,360,1,'M010810','M00201');
	end if;

	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='addZfsqd' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M01081060', '/exp/contract/buy/manage', 'addZfsqd', 2, '新增承兑汇票支付申请单', '1', 'M00201');
    end if;
	--- zyy  2017-1-16  承兑汇票申请支付清单 end---------
	--- dongbin  2017-1-13  承兑汇票管理中心start---------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/accept/buy/acceptBill' and method='toEdit' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005','/exp/accept/buy/acceptBill','toEdit',2,'修改新增信息','1','M00201');
    end if;
	--- dongbin  2017-1-13  承兑汇票管理中心 end---------

	----------------------------------------- hanglong 2017-1-11 汇票测算  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='measure' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M022005', '/exp/contract/buy/manage', 'measure', 1, '汇票测算', 1, 'M00201');
    end if;
	----------------------------------------- hanglong 2017-1-11 汇票测算 end -------------------------------------------

	----------------------------------------- hanglong 2017-1-11 票据公共action  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='getSettleBank' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'getSettleBank', 1, '获得结算单位支持的承兑银行和承兑单位', 1, 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='getSettleInfo' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'getSettleInfo', 1, '获得票据平台维护的结算相关信息', 1, 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='getSettleRate' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'getSettleRate', 1, '获得结算单位今日贴息率', 1, 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='billCalculate' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'billCalculate', 1, '票据测算', 1, 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='checkOpenBillBusiness' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'checkOpenBillBusiness', 1, '验证会员是否开通票据业务', 1, 'M00201');
    end if;
	----------------------------------------- hanglong 2017-1-11 票据公共action end -------------------------------------------

	----------------------------------------- hanglong 2017-1-11 待处理订单统计  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='countContract' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/contract/buy/manage', 'countContract', 1, '待处理订单统计', 1, 'M00201');
    end if;
	----------------------------------------- hanglong 2017-1-11 待处理订单统计 end -------------------------------------------

	----------------------------------------- hanglong 2017-1-19 申请开通票据业务  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/menber/jsxz' and method='openBpRq' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M039610', '/bsp/menber/jsxz', 'openBpRq', 2, '申请开通票据业务', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/menber/jsxz' and method='bscallback' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M039610', '/bsp/menber/jsxz', 'bscallback', 0, '申请开通票据业务回调接口', 1, 'M00000');
    end if;
	----------------------------------------- hanglong 2017-1-19 申请开通票据业务 end -------------------------------------------
    
    --- chenxp  2017-1-18  ca证书价格 start---------
    num:=0;
    select count(1) into num from bs_cssz where cskey='QYCA_ONE_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('QYCA_ONE_PRICE','企业一年有效期CA证书价格','350','350','系统管理员','企业一年有效期CA证书价格',1,'元',1110,'企业一年有效期CA证书价格');
    end if;
  
    num:=0;
    select count(1) into num from bs_cssz where cskey='QYCA_TWO_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('QYCA_TWO_PRICE','企业两年有效期CA证书价格','550','550','系统管理员','企业两年有效期CA证书价格',1,'元',1111,'企业两年有效期CA证书价格');
    end if;
    
    num:=0;
    select count(1) into num from bs_cssz where cskey='QYCA_HTREE_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('QYCA_HTREE_PRICE','企业三年有效期CA证书价格','750','750','系统管理员','企业三年有效期CA证书价格',1,'元',1112,'企业三年有效期CA证书价格');
    end if;
    
    num:=0;
    select count(1) into num from bs_cssz where cskey='GRCA_ONE_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('GRCA_ONE_PRICE','个人一年有效期CA证书价格','180','180','系统管理员','个人一年有效期CA证书价格',1,'元',1113,'个人一年有效期CA证书价格');
    end if;
    
    num:=0;
    select count(1) into num from bs_cssz where cskey='GRCA_TWO_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('GRCA_TWO_PRICE','个人两年有效期CA证书价格','280','280','系统管理员','个人两年有效期CA证书价格',1,'元',1114,'个人两年有效期CA证书价格');
    end if;
    
    num:=0;
    select count(1) into num from bs_cssz where cskey='GRCA_THREE_PRICE';   
    if num = 0 then
    insert into bs_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('GRCA_THREE_PRICE','个人三年有效期CA证书价格','380','380','系统管理员','个人三年有效期CA证书价格',1,'元',1115,'个人三年有效期CA证书价格');
    end if;
    --- chenxp  2017-1-18  ca证书价格 end-----------
    --- add by xuz 2017-1-19  票据业务回调 start-------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/ex/common/bill/callback' and method='index' and sid = 'B00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/ex/common/bill/callback', 'index', 0, '票据业务回调', 2, 'B00201');
    end if;
	--- add by xuz 2017-1-19  票据回调 end-------
 	-----add by huangxq on 2017-2-4 start------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/supplier/regaudit' and method='search' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010008', '/bsm/supplier/regaudit', 'search', 2, '产品范围查看', 2, 'B00000');
    end if;
     
    num:=0;
	select count(1) into num from bs_qxsz where mid='B0155' and mkid='B015525' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B015525','B0155','保证金管理','保证金审核查看','/exm/bzjgl/auditFind/list.do','/exm/bzjgl/auditFind/list.do',1,200,2,'B00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exm/bzjgl/auditFind' and method='list' and sid = 'B00004';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015525', '/exm/bzjgl/auditFind', 'list', 2, '保证金审核查看页面', 2, 'B00004');
    end if;
	-----add by huangxq on 2017-2-4 end  ------
 	---add by dongbin 2017-1-22 登记承兑汇票  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='regBill' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810', '/exp/contract/buy/manage', 'regBill', 2, '登记承兑汇票', 1, 'M00201');
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M010810' and sid='M00201'; 
    if num = 1 then
	     update bs_qxsz set inurl='/exp/contract/buy/manage/list.do#/exp/contract/buy/manage/toRefuse.do#/exp/contract/buy/manage/toConfirm.do#/exp/contract/buy/manage/addPayRequest.do#/exp/contract/buy/manage/toAddPayRequest.do#/exp/contract/buy/manage/toYszf.do#/exp/contract/buy/manage/regBill.do#' where mkid='M010810' and sid='M00201'; 
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='addBusinessPj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M01081065','/exp/contract/buy/manage','addBusinessPj',2,'新增商业承兑汇票','1','M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='addBankPj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M01081070','/exp/contract/buy/manage','addBankPj',2,'新增银行承兑汇票','1','M00201');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mid='M0108' and mkid='M01081065' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01081065','M0108','采购订单','新增商业承兑汇票','','',2,370,1,'M010810','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0108' and mkid='M01081070' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01081070','M0108','采购订单','新增银行承兑汇票','','',2,380,1,'M010810','M00201');
	end if;
	
	 num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='savePj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810','/exp/contract/buy/manage','savePj',2,'确认登记完毕','1','M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='toEdit' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810','/exp/contract/buy/manage','toEdit',2,'修改新增信息','1','M00201');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='regMatchPay' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810','/exp/contract/buy/manage','regMatchPay',2,'批量登记承兑汇票','1','M00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='savePlPj' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810','/exp/contract/buy/manage','savePlPj',2,'确认登记完毕-批量登记','1','M00201');
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M010810' and sid='M00201'; 
    if num = 1 then
	     update bs_qxsz set inurl='/exp/contract/buy/manage/list.do#/exp/contract/buy/manage/toRefuse.do#/exp/contract/buy/manage/toConfirm.do#/exp/contract/buy/manage/addPayRequest.do#/exp/contract/buy/manage/toAddPayRequest.do#/exp/contract/buy/manage/toYszf.do#/exp/contract/buy/manage/regBill.do#/exp/contract/buy/manage/regMatchPay.do#' where mkid='M010810' and sid='M00201'; 
    end if;
	-----dongbin 2017-1-22 登记承兑汇票  end -------------------------------------------

	----------------------------------------- hanglong 2017-2-5 根据供应商分组所有查询出的可购买商品  start -----------------------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/allthing' and method='ajaxSourceHz' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/allthing', 'ajaxSourceHz', 1, '根据供应商分组所有查询出的可购买商品', 1, 'M00201');
    end if;
	----------------------------------------- hanglong 2017-2-5 根据供应商分组所有查询出的可购买商品 end -------------------------------------------

	----------------------------------------- hanglong 2017-2-5 账户参数变更  start -----------------------------------------
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0105' and mkid='B01052505' and sid='B00301';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01052505', 'B0105', '账户签约查询', '账户参数变更', '', '', 2, 100, 2, 'B010525', 'B00301');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/ecim/account/info/manage' and method='toParamEdit' and sid = 'B00301';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01052505', '/ecim/account/info/manage', 'toParamEdit', 2, '打开账户参数变更页面', 2, 'B00301');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/ecim/account/info/manage' and method='doParamEdit' and sid = 'B00301';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01052505', '/ecim/account/info/manage', 'doParamEdit', 2, '账户参数变更提交', 2, 'B00301');
    end if;
	----------------------------------------- hanglong 2017-2-5 账户参数变更 end -------------------------------------------

 	---add by huangxq 2017-2-7 导出  start -----------------------------------------
	  num:=0;
    select count(1) into num from bs_qxmx where  action='/exm/bzjgl/bzjls' and method='export2Excel' and sid = 'B00004';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015505', '/exm/bzjgl/bzjls', 'export2Excel', 2, '导出', 2, 'B00004');
    end if;
	---add by huangxq 2017-2-7 导出  end -----------------------------------------

 	--- add by xuz 2017-1-22  票据匹配支付 start-------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='matchPay' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810', '/exp/contract/buy/manage', 'matchPay', 2, '票据匹配支付', 1, 'M00201');
    end if;


	--- add by xuz 2017-1-22  票据匹配支付 end-------
	--- add by xuz 2017-1-23  票据测算 start-------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/common/bill' and method='toBillCalculate' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/common/bill', 'toBillCalculate', 1, '跳转票据金额测算页面', 1, 'M00201');
    end if;
	--- add by xuz 2017-1-23  票据测算 end-------

	--- add by xuz 2017-2-7  票据确认支付页面 start-------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='toCheckPay' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810', '/exp/contract/buy/manage', 'toCheckPay', 2, '票据确认支付页面', 1, 'M00201');
    end if;
	--- add by xuz 2017-2-7  票据确认支付页面 end-------

	--- add by dongbin 2017-2-8 待支付承兑汇票-跳转生成支付申请单查看 start-------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/contract/buy/manage' and method='showPayZfsqd' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010810','/exp/contract/buy/manage','showPayZfsqd',2,'跳转生成支付申请单查看','1','M00201');
    end if;
    --- add by dongbin 2017-2-8 待支付承兑汇票-跳转生成支付申请单查看 end-------


	--- add by zyy 2017-2-7  店员票据权限管理 start-------
	-----前台
	num:=0;
    select count(1) into num from bs_qxmx where  action='/market/menber/mboptBpQx' and method='index' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M011505', '/market/menber/mboptBpQx', 'index', 2, '店员票据权限修改页面', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/market/menber/mboptBpQx' and method='save' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M011505', '/market/menber/mboptBpQx', 'save', 2, '店员票据权限更新', 1, 'M00000');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M011505' and sid='M00000' and mid='M0100' and instr(inurl,'/market/menber/mboptBpQx/index.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/market/menber/mboptBpQx/index.do') where  mkid='M011505' and sid='M00000' and mid='M0100';
	end if;
    
    -----后台
    num:=0;
    select count(1) into num from bs_qxmx where  action='/admin/menber/mbbpqxsz' and method='list' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01000110', '/admin/menber/mbbpqxsz', 'list', 2, '会员权限设置(票据)', 2, 'B00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/admin/menber/mbbpqxsz' and method='updateMenberQxsz' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01000110', '/admin/menber/mbbpqxsz', 'updateMenberQxsz', 2, '变更会员权限设置(票据)', 2, 'B00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/pages/auth/bpqxfp' and method='list' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012001', '/pages/auth/bpqxfp', 'list', 2, '权限分配页面(票据)', 2, 'B00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/pages/auth/bpqxfp' and method='doBpQxfp' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01200105', '/pages/auth/bpqxfp', 'doBpQxfp', 2, '更新用户模块权限方法(票据)', 2, 'B00000');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='B012001' and sid='B00000' and mid='B0120' and instr(inurl,'/pages/auth/bpqxfp/list.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'/pages/auth/bpqxfp/list.do#') where  mkid='B012001' and sid='B00000' and mid='B0120';
	end if;
	--- add by zyy 2017-2-7  店员票据权限管理 end-------

	---add by huangxq 2017-2-8 网超商品新增分类代码选择 start--
		num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/hangsource/sell/publish' and method='getSupplierType' and sid = 'M00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M01102005', '/exp/hangsource/sell/publish', 'getSupplierType', 2, '资源发布（卖）：分类选择', 1, 'M00201');
    end if;
	---add by huangxq 2017-2-8 网超商品新增分类代码选择 end--

	---add by huangxq 2017-2-8 网超商品新增分类代码选择(后台) start--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exm/hangsource/hangadmin' and method='getSupplierType' and sid = 'B00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01050505', '/exm/hangsource/hangadmin', 'getSupplierType', 2, '分类代码选择', 2, 'B00201');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exm/hangsource/hangadmin' and method='saveSupplierType' and sid = 'B00201';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01050505', '/exm/hangsource/hangadmin', 'saveSupplierType', 2, '分类代码选择保存', 2, 'B00201');
    end if;
	---add by huangxq 2017-2-8 网超商品新增分类代码选择(后台) end --
	
	------------------add by songw 2017年2月14日 start---------------------
    --add 增加后台CA证书管理修改CA证书权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/menber/cert' and method='toEdit' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011565', '/bsm/menber/cert', 'toEdit', 2, 'CA证书管理-跳转修改证书页面', 2, 'B00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/menber/cert' and method='updateCart' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011565', '/bsm/menber/cert', 'updateCart', 2, 'CA证书管理-修改保存证书', 2, 'B00000');
    end if;
    
    --add 增加后台对未支付的CA证书订单修改金额权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/cert/zfqd' and method='toEditCaCertZfqdMoney' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011560', '/bsm/cert/zfqd', 'toEditCaCertZfqdMoney', 2, 'CA证书订单-修改订单金额页面', 2, 'B00000');
    end if;  
      
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/cert/zfqd' and method='updateZfqdMoney' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011560', '/bsm/cert/zfqd', 'updateZfqdMoney', 2, 'CA证书订单-保存修改订单金额', 2, 'B00000');
    end if;    
    --add 增加后台对已支付的CA证书订单和已制作证书的CA证书增加打印发货单权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsm/cert/zfqd' and method='printSendOut' and sid = 'B00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011560', '/bsm/cert/zfqd', 'printSendOut', 2, 'CA证书订单-打印发货单', 2, 'B00000');
    end if;  
	------------------add by songw 2017年2月14日 end---------------------
	
	----add by huyq 20170215 start-------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/menber/cert' and METHOD ='doPrint' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01007005','/bsp/menber/cert','doPrint',2,'CA证书管理-打印证书信息',1,'M00000');
	end if;
	----add by huyq 20170215 end-------

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
