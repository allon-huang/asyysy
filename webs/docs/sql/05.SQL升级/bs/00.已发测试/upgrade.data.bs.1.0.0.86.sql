DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.86'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	---2016-06-22 hanglong 中标流程权限添加 start ---
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M095010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M095010','M0950','中标','标段包列表','/exp/bidding/sell/hitbid/package/list.do','/exp/bidding/sell/hitbid/package/list.do#/exp/bidding/sell/hitbid/package/packageView.do',1,100,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/package' and METHOD ='list' and MKID='M095010' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095010','/exp/bidding/sell/hitbid/package','list',2,'标段包列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/package' and METHOD ='packageView' and MKID='M095010' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095010','/exp/bidding/sell/hitbid/package','packageView',2,'标段包查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/package' and METHOD ='dowloadBdwFile' and MKID='M095010' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095010','/exp/bidding/sell/hitbid/package','dowloadBdwFile',2,'标段包附件下载',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M095020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M095020','M0950','中标','中标候选人公示查看','/exp/bidding/sell/hitbid/publicity/view.do','/exp/bidding/sell/hitbid/publicity/view.do',1,200,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/publicity' and METHOD ='view' and MKID='M095020' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095020','/exp/bidding/sell/hitbid/publicity','view',2,'中标候选人公示查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M095030' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M095030','M0950','中标','中标通知书','/exp/bidding/sell/hitbid/notice/view.do','/exp/bidding/sell/hitbid/notice/view.do',1,300,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/notice' and METHOD ='view' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095030','/exp/bidding/sell/hitbid/notice','view',2,'中标通知书查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M095040' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M095040','M0950','中标','招标结果公告','/exp/bidding/sell/hitbid/result/view.do','/exp/bidding/sell/hitbid/result/view.do#/exp/bidding/sell/hitbid/result/confirm.do',1,400,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/result' and METHOD ='view' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095040','/exp/bidding/sell/hitbid/result','view',2,'招标结果公告查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/result' and METHOD ='confirm' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095040','/exp/bidding/sell/hitbid/result','confirm',2,'招标结果公告确认',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M095050' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
		values('M095050','M0950','中标','异议','/exp/bidding/sell/hitbid/dissent/list.do','/exp/bidding/sell/hitbid/dissent/list.do#/exp/bidding/sell/hitbid/dissent/view.do#/exp/bidding/sell/hitbid/dissent/toAdd.do#/exp/bidding/sell/hitbid/dissent/save.do',1,500,1,'M00008',1);
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='list' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','list',2,'异议列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='view' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','view',2,'异议查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='toAdd' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','toAdd',2,'异议新增',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='save' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','save',2,'异议保存签章提交',1,'M00008');
	end if;
	---2016-06-22 hanglong 中标流程权限添加 end ---

	--mazg start--
	--申请支付（不知道跳新页面，所以inurl不加）
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='apply' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','apply',2,'申请支付',1,'M00008');
	end if;
	--mazg end--

	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='addGbunit' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'addGbunit', 2, '组建资格预审委员会-添加规避单位', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='addGbunit' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'addGbunit', 2, '组建评标委员会-添加规避单位', 1, 'M00008');
	end if;
	--add by longf end ---

  num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/sell/hitbid/dissent' and  method='download' and  sid='M00008';
  if num=0 then
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
    values('M095050', '/exp/bidding/sell/hitbid/dissent', 'download', 2, '异议附件下载', 1, 'M00008');
	end if;
	
	--mazg start--
		--资格预审文件列表页面
		select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toDownPage' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','toDownPage',2,'资格预审文件列表页面',1,'M00008');
	end if;
	
	--将资格预审文件列表页面追加到购买资格预审文件的inurl后面（定位）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091020' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/signup/toDownPage.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toDownPage.do') where  mkid='M091020' and sid='M00008' and mid='M0910';
		end if;
		
		--资格预审文件下载
		select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='downLoad' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','downLoad',2,'资格预审文件下载',1,'M00008');
	end if;
	
	--将资格预审文件下载追加到购买资格预审文件的inurl后面（定位）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091020' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/signup/downLoad.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/downLoad.do') where  mkid='M091020' and sid='M00008' and mid='M0910';
		end if;
	--mazg end--

	-- add by zhaiyy start ---
	--澄清/变更公告审核
	select count(1) into num from bs_qxsz where mkid='B011010' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011010','B0110','招标管理','澄清/变更公告审核','/bdm/ccnotice/list.do','/bdm/ccnotice/list.do',1,200,2,'B00008');
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/ccnotice' and  method='list' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','list',2,'澄清/变更公告列表',2,'B00008'); 
	end if;

	select count(1) into num from bs_qxmx where action='/bdm/ccnotice' and  method='toAudit' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','toAudit',2,'澄清/变更公告审核',2,'B00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/ccnotice'  and method='agree' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','agree',2,'审核通过',2,'B00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/ccnotice'  and method='reject' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','reject',2,'审核拒绝',2,'B00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/ccnotice' and method='download' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','download',2,'下载附件',2,'B00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/bdm/ccnotice'  and method='toShow' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011010','/bdm/ccnotice','toShow',2,'查看',2,'B00008'); 
	end if;
	
	-- add by zhaiyy end ---


	-- add by zhaiyy start ---
	--投标人 澄清文件（预审）
	select count(1) into num from bs_qxsz where mkid='M091030' and mid='M0910' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
		values('M091030','M0910','报名','澄清文件领取','/exp/bidding/sell/yscqnotice/list.do','/exp/bidding/sell/yscqnotice/list.do#/exp/bidding/sell/yscqnotice/view.do#/exp/bidding/sell/yscqnotice/downLoad',1,200,1,'M00008',1);
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/yscqnotice'  and method='list' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M091030','/exp/bidding/sell/yscqnotice','list',2,'澄清文件领取列表',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/yscqnotice'  and method='view' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M091030','/exp/bidding/sell/yscqnotice','view',2,'澄清文件查看',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/yscqnotice'  and method='downLoad' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M091030','/exp/bidding/sell/yscqnotice','downLoad',2,'附件下载',1,'M00008'); 
	end if;
	-- add by zhaiyy end ---

	-- add by zhaiyy start ---
	-- 公告变更（预审）
	select count(1) into num from bs_qxsz where mkid='M089050' and mid='M0890' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed,qxrole)
		values('M089050','M0890','资格预审','变更公告','/exp/bidding/buy/ysbgnotice/list.do','/exp/bidding/buy/ysbgnotice/list.do#/exp/bidding/buy/ysbgnotice/toAdd.do#/exp/bidding/buy/ysbgnotice/save.do#/exp/bidding/buy/ysbgnotice/preview.do#/exp/bidding/buy/ysbgnotice/submit.do#/exp/bidding/buy/ysbgnotice/downLoad.do#/exp/bidding/buy/ysbgnotice/edit.do#/exp/bidding/buy/ysbgnotice/delete.do#/exp/bidding/buy/ysbgnotice/view.do',1,100,1,'M00008',1,'008-1-2-2');
	end if;

	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='list' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','list',2,'变更公告列表',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice' and method='toAdd' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','toAdd',2,'新增变更公告',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='save' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','save',2,'保存变更公告',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='preview' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','preview',2,'预览变更公告',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='submit' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','submit',2,'更新变更公告',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice' and method='downLoad' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','downLoad',2,'下载公告附件',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='edit' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','edit',2,'变更公告编辑',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='delete' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','delete',2,'变更公告删除',1,'M00008'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice'  and method='view' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089050','/exp/bidding/buy/ysbgnotice','view',2,'变更公告查看',1,'M00008'); 
	end if;
	-- add by zhaiyy end ---

	 --add by xuz start ---
	 ------删除老数据
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='view' and STYP=1 and SID='M00008';
	  if num>0 then	  
	  	DELETE FROM BS_QXMX WHERE  ACTION='/exp/bidding/buy/prefic' and METHOD ='view' and STYP=1 and SID='M00008';
	  end if;
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toPublish' and STYP=1 and SID='M00008';
	  if num>0 then	  
	  	DELETE FROM BS_QXMX WHERE  ACTION='/exp/bidding/buy/prefic' and METHOD ='toPublish' and STYP=1 and SID='M00008';
	  end if;
	  
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='download' and STYP=1 and SID='M00008';
	  if num>0 then	  
	  	DELETE FROM BS_QXMX WHERE  ACTION='/exp/bidding/buy/prefic' and METHOD ='download' and STYP=1 and SID='M00008';
	  end if;
	  
	  
	  --资格预审公告发布
 	  num:=0;
  	  select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089020';
 	  if num = 0 then
    	 insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse,orderno, styp, sid ,qxrole) 
    	 values('M089020', 'M0890', '资格预审', '资格预审公告发布','/exp/bidding/buy/prefic/view.do','/exp/bidding/buy/prefic/view.do#/exp/bidding/buy/prefic/toPublish.do', 1,200, 1, 'M00008','008-1-2-2');
  	  end if;
  	  
  	  --资格预审公告发布界面
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='view' and STYP=1 and SID='M00008';
	  if num = 0 then
		  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		  values('M089020','/exp/bidding/buy/prefic','view',2,'资格预审公告发布界面',1,'M00008');
	  end if; 
	  
	  --资格预审公告发布
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toPublish' and STYP=1 and SID='M00008';
	  if num = 0 then
		  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		  values('M089020','/exp/bidding/buy/prefic','toPublish',2,'资格预审公告发布',1,'M00008');
	  end if; 
	--add by xuz end ---
---xuz start--
	 ------删除老数据
	  num:=0;
	  select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089015' and inurl='/bdp/bidding/buy/preficfile/download.do';
	  if num>0 then	  
	  	DELETE FROM BS_QXSZ WHERE  sid = 'M00008' and mkid='M089015' and inurl='/bdp/bidding/buy/preficfile/download.do';
	  end if;
	 ------重新插入数据
	--资格预审文件预览
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M089015';
 	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name,url,inurl, isuse,orderno, styp, sid ,qxrole) 
    	values('M089015', 'M0890', '资格预审', '资格预审文件预览','/bdp/bidding/buy/preficfile/viewZgyswj.do','/bdp/bidding/buy/preficfile/viewZgyswj.do#/bdp/bidding/buy/preficfile/download.do', 1,150, 1, 'M00008','008-1-2-2');
  	end if; 
  	--资格预审文件发布
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='publishWj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','publishWj',2,'资格预审文件发布',1,'M00008');
	end if;
	---xuz end--

	----tanqinli-start----
	-- 权限明细 客户端 评标模板 保存标段（包）评标模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/pbmb' and METHOD ='savePackPbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/pbmb','savePackPbmb',0,'客户端-评标模板-保存标段（包）评标模板',1,'M00008');
	end if;
	-- 权限明细 客户端 是否制作招标文件选择模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/project' and METHOD ='editWhetherZbwjTemp' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/project','editWhetherZbwjTemp',0,'客户端-是否制作招标文件选择模板',1,'M00008');
	end if;	

	
	-- 权限设置 发标 招标文件参数设置
	update bs_qxsz set url='/exp/bidding/buy/zbwjone/toZbwjCssz.do' where mkid='M083010' and sid='M00008';
	-- 权限设置 菜单选中 发标 招标文件参数设置
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/toZbwjCssz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toZbwjCssz.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限明细 发标流程 招标文件参数设置页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toZbwjCssz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjone','toZbwjCssz',2,'发标流程-招标文件参数设置页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 保存招标文件参数设置
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveZbwjCssz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083010','/exp/bidding/buy/zbwjone','saveZbwjCssz',2,'发标流程-保存招标文件参数设置',1,'M00008');
	end if;
	
	-- 权限设置 发标 标书文件预览
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M083020','M0830','发标','标书文件预览','/exp/bidding/buy/zbwjone/toBswjView.do','/exp/bidding/buy/zbwjone/toBswjView.do',1,200,1,'M00008');
	end if;
	-- 权限明细 发标流程 标书文件预览页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toBswjView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083020','/exp/bidding/buy/zbwjone','toBswjView',2,'发标流程-标书文件预览页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 标书文件预览提交
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='doBswjView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083020','/exp/bidding/buy/zbwjone','doBswjView',2,'发标流程-标书文件预览提交',1,'M00008');
	end if;
	
	-- 权限设置 发标 发布标书文件
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083030' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M083030','M0830','发标','发布标书文件','/exp/bidding/buy/zbwjone/toBswjPublish.do','/exp/bidding/buy/zbwjone/toBswjPublish.do',1,300,1,'M00008');
	end if;
	-- 权限明细 发标流程 标书文件发布页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toBswjPublish' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083030','/exp/bidding/buy/zbwjone','toBswjPublish',2,'发标流程-标书文件发布页面',1,'M00008');
	end if;
	-- 权限明细 发标流程 标书文件发布
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='doBswjPublish' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083030','/exp/bidding/buy/zbwjone','doBswjPublish',2,'发标流程-标书文件发布',1,'M00008');
	end if;
	
	----tanqinli-end----

	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='juryInfo' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'juryInfo', 2, '组建资格预审委员会-查看委员会信息', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='juryInfo'  and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'juryInfo', 2, '组建评标委员会-查看委员会信息', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M089040' and sid='M00008' and mid='M0910' and instr(inurl,'/bdp/build/pre/jury/juryInfo.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/build/pre/jury/juryInfo.do') where  mkid='M089040' and sid='M00008' and mid='M0890';
	end if;
		
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M083040' and sid='M00008' and mid='M0910' and instr(inurl,'/bdp/build/jury/juryInfo.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/build/jury/juryInfo.do') where  mkid='M083040' and sid='M00008' and mid='M0830';
	end if;
	--add by longf end ---

	---2016/06/23	hanglong 招标登录页面 start---
	num:=0;
	select count(1) into num from bs_qxmx where action='/login' and  method='bdIndex' and mkid='0' and  sid='M00000';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/login', 'bdIndex', 0, '招标登录页面', 1, 'M00000');
	end if;
	---2016/06/23	hanglong 招标登录页面 end---

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
