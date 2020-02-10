DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.90'; -- 本升级文件的版本，每个升级文件必须修改
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
	--add by xuz start--
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091060'  and mid='M0910'  and url='/exp/bidding/sell/preficClari/list.do' and sid='M00008' ;
    if num > 0 then
	    update bs_qxsz set url='/exp/bidding/sell/pre/dissent/preClariList.do',inurl='/exp/bidding/sell/pre/dissent/preClariList.do#/exp/bidding/sell/pre/dissent/toSlClari.do#/exp/bidding/sell/pre/dissent/toReplyZjwt.do'
	    where mkid='M091060'  and mid='M0910'  and url='/exp/bidding/sell/preficClari/list.do' and sid='M00008' ;
    end if;
    
    
     num:=0;
    select instr(inurl,'/exp/bidding/sell/pre/dissent/acceptScaling.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091060' and mid='M0910';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/pre/dissent/acceptScaling.do') where  sid = 'M00008' and mkid='M091060' and mid='M0910';
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/dissent' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091060','/exp/bidding/sell/pre/dissent','toView',2,'资格预审问题查看页面',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/dissent' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091060','/exp/bidding/sell/pre/dissent','packlist',2,'资格预审问题提问过渡页面',1,'M00008');
	end if;
	
	num:=0;
    select instr(inurl,'/exp/bidding/sell/pre/dissent/packlist.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091060' and mid='M0910';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/pre/dissent/packlist.do') where  sid = 'M00008' and mkid='M091060' and mid='M0910';
    end if;
    
     num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/dissent' and METHOD ='toAsk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091060','/exp/bidding/sell/pre/dissent','toAsk',2,'资格预审问题提问页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/dissent' and METHOD ='saveAsk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091060','/exp/bidding/sell/pre/dissent','saveAsk',2,'资格预审问题提问保存',1,'M00008');
	end if;
    --add by xuz end--

	----tanqinli-start----
	-- 权限设置 资格预审 澄清文件发布 澄清文件列表:过滤页面
	update bs_qxsz set url='/exp/bidding/buy/yscqnotice/yscqPackList.do' where mkid='M089060' and sid='M00008';
	-- 权限设置 菜单选中 澄清文件发布 澄清文件列表:过滤页面
	num:=0;
	select instr(inurl,'/exp/bidding/buy/yscqnotice/yscqPackList.do') into num from bs_qxsz where sid='M00008' and mkid='M089060';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yscqnotice/yscqPackList.do') where sid='M00008' and mkid='M089060';
	end if;
	-- 权限明细 澄清文件发布 澄清文件列表:过滤页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yscqnotice' and METHOD ='yscqPackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089060','/exp/bidding/buy/yscqnotice','yscqPackList',2,'澄清文件发布-澄清文件列表:过滤页面',1,'M00008');
	end if;
	
	-- 权限设置 发标 澄清文件发布 澄清文件列表:过滤页面
	update bs_qxsz set url='/exp/bidding/cqnotice/cqPackList.do' where mkid='M083055' and sid='M00008';
	-- 权限设置 菜单选中 澄清文件发布 澄清文件列表:过滤页面
	num:=0;
	select instr(inurl,'/exp/bidding/cqnotice/cqPackList.do') into num from bs_qxsz where sid='M00008' and mkid='M083055';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/cqnotice/cqPackList.do') where sid='M00008' and mkid='M083055';
	end if;
	-- 权限明细 澄清文件发布 澄清文件列表:过滤页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/cqnotice' and METHOD ='cqPackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083055','/exp/bidding/cqnotice','cqPackList',2,'澄清文件发布-澄清文件列表:过滤页面',1,'M00008');
	end if;
	----tanqinli-end----
     
    -------------cheny 2016/07/28 修改“资格预审申请文件开启记录”菜单名称 --start---------------------
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089092' and sid='M00008';
    if num = 1 then
        update bs_qxsz set name = '资格预审申请文件开启记录' where mkid='M089092' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089090' and sid='M00008';
    if num = 1 then
        update bs_qxsz set name = '资格预审申请文件开启列表' where mkid='M089090' and sid='M00008';
    end if;
	-------------cheny 2016/07/28  修改“资格预审申请文件开启记录”菜单名称--end--------------------- 
	-- 权限明细 首页查看公告
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/' and METHOD ='ggInfo' and STYP=1 and SID='M00008';
    if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/','ggInfo',0,'首页查看公告',1,'M00008');
	end if;
	
	--add by longf start--
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='getMajorList' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'getMajorList', 2, '组建资格预审委员会-获得专家专业列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='getMajorList' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'getMajorList', 2, '组建评标委员会-获得专家专业列表', 1, 'M00008');
	end if;
    --add by longf end--
	
	----chenxp start----
	-----撤回投标文件
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and sid = 'M00008' and method='revokeTbwj';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M092005','/exp/bidding/sell/bidding','revokeTbwj','2','撤回投标文件','1','M00008');
    end if;

    num:=0;
    select instr(inurl,'/exp/bidding/sell/bidding/revokeTbwj.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092005';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidding/revokeTbwj.do') where  sid = 'M00008' and mkid='M092005';
    end if;
	----chenxp end------

	---add by xuz start---
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M089098' and mid='M0890' and url='/exp/bidding/buy/dissent/preHfwtList.do' and  sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ,fixed ,qxrole) 
         values('M089098', 'M0890', '资格预审', '资格预审问题回复列表', '/exp/bidding/buy/dissent/preHfwtList.do', '/exp/bidding/buy/dissent/preHfwtList.do#/exp/bidding/buy/dissent/toSlClari.do#/exp/bidding/buy/dissent/acceptScaling.do#/exp/bidding/buy/dissent/toReplyZjwt.do#/exp/bidding/buy/dissent/saveReplyZjwt.do#/exp/bidding/buy/dissent/toView.do' , 1,150, 1, 'M00008',1,'1,5');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='preHfwtList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','preHfwtList',2,'资格预审问题回复列表',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='toSlClari' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','toSlClari',2,'资格预审问题回复受理页面',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='acceptScaling' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','acceptScaling',2,'资格预审问题回复受理',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='toReplyZjwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','toReplyZjwt',2,'资格预审问题回复页面',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='saveReplyZjwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','saveReplyZjwt',2,'资格预审问题回复',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','download',2,'资格预审问题附件下载',1,'M00008');
	end if;
	
		 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/dissent' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089098','/exp/bidding/buy/dissent','toView',2,'资格预审问题回复查看页面',1,'M00008');
	end if;
	---add by xuz end---


	-----chenxp start-----
  	-----撤回投标文件
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and sid = 'M00008' and method='revokeTbwj';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M092005','/exp/bidding/sell/bidding','revokeTbwj','2','撤回投标文件','1','M00008');
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/sell/bidding/revokeTbwj.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092005';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidding/revokeTbwj.do') where  sid = 'M00008' and mkid='M092005';
    end if;
    
   -----递交资格预审申请文件
   num:=0;
   select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and sid = 'M00008' and method='deliver';
   if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M091040','/exp/bidding/sell/signup','deliver','2','递交资格预审申请文件','1','M00008');
    end if;
    
   num:=0;
   select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and sid = 'M00008' and method='revokeYswj';
   if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M091040','/exp/bidding/sell/signup','revokeYswj','2','撤回资格预审申请文件','1','M00008');
    end if;
    
   num:=0;
   select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and sid = 'M00008' and method='ysReceipt';
   if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M091040','/exp/bidding/sell/signup','ysReceipt','2','下载资格预审申请文件回执','1','M00008');
    end if;
    
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/deliver.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/deliver.do') where  sid = 'M00008' and mkid='M091040';
    end if;
    
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/revokeYswj.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/revokeYswj.do') where  sid = 'M00008' and mkid='M091040';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/ysReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/ysReceipt.do') where  sid = 'M00008' and mkid='M091040';
    end if;
   
  	-----chenxp end-------

	-------------------------2016/08/03 投标保证金支付查看回执 hanglong start--------------------------
	num:=0;
	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='showReceipt' and sid = 'M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		values('M092020','/exp/bidding/sell/bidbond/pay','showReceipt','2','投标保证金支付查看回执','1','M00008');
	end if;
	-------------------------2016/08/03 投标保证金支付查看回执 hanglong end----------------------------
	
	--------add by xuz end------
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M091087' and mid='M0910' and url='/exp/bidding/sell/zbwj/dissent/zbClariList.do' and  sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ,fixed ,qxrole) 
         values('M091087', 'M0910', '报名', '招标文件问题', '/exp/bidding/sell/zbwj/dissent/zbClariList.do', '/exp/bidding/sell/zbwj/dissent/zbClariList.do#/exp/bidding/sell/zbwj/dissent/toSlClari.do#/exp/bidding/sell/zbwj/dissent/acceptScaling.do#/exp/bidding/sell/zbwj/dissent/toReplyZbwt.do#/exp/bidding/sell/zbwj/dissent/saveReplyZbwt.do#/exp/bidding/sell/zbwj/dissent/download.do#/exp/bidding/sell/zbwj/dissent/toView.do#/exp/bidding/sell/zbwj/dissent/packlist.do#/exp/bidding/sell/zbwj/dissent/toAsk.do#/exp/bidding/sell/zbwj/dissent/saveAsk.do' , 1,670, 1, 'M00008',1,'1,2,3');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='zbClariList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','zbClariList',2,'招标文件问题列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='toSlClari' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','toSlClari',2,'招标人受理页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='acceptScaling' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','acceptScaling',2,'招标人受理',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='toReplyZbwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','toReplyZbwt',2,'招标人回复页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='saveReplyZbwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','saveReplyZbwt',2,'招标人回复',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','download',2,'附件下载',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','toView',2,'招标文件问题查看',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','packlist',2,'招标文件问题过渡页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='toAsk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','toAsk',2,'招标文件提问页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/zbwj/dissent' and METHOD ='saveAsk' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091087','/exp/bidding/sell/zbwj/dissent','saveAsk',2,'招标文件提问',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M083080' and mid='M0830' and url='/exp/bidding/buy/zbwj/dissent/zbHfwtList.do' and  sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ,fixed ,qxrole) 
         values('M083080', 'M0830', '发标', '招标文件问题', '/exp/bidding/buy/zbwj/dissent/zbHfwtList.do', '/exp/bidding/buy/zbwj/dissent/zbHfwtList.do#/exp/bidding/buy/zbwj/dissent/toSlClari.do#/exp/bidding/buy/zbwj/dissent/acceptScaling.do#/exp/bidding/buy/zbwj/dissent/toReplyZbwt.do#/exp/bidding/buy/zbwj/dissent/saveReplyZjwt.do#/exp/bidding/buy/zbwj/dissent/download.do#/exp/bidding/buy/zbwj/dissent/toView.do' , 1,50, 1, 'M00008',1,'1,2,3,5,6,7');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='zbHfwtList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','zbHfwtList',2,'招标文件问题回复列表',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='toSlClari' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','toSlClari',2,'招标文件问题受理页面',1,'M00008');
	end if;
	
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='acceptScaling' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','acceptScaling',2,'招标文件问题受理',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='toReplyZbwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','toReplyZbwt',2,'招标文件问题回复页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='saveReplyZjwt' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','saveReplyZjwt',2,'招标文件问题回复',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','download',2,'附件下载',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwj/dissent' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083080','/exp/bidding/buy/zbwj/dissent','toView',2,'招标文件问题查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091087'  and mid='M0910'  and url='/exp/bidding/sell/zbwj/dissent/zbClariList.do' and sid='M00008' ;
    if num > 0 then
	    update bs_qxsz set qxrole='1,2,3'
	    where mkid='M091087'  and mid='M0910'  and url='/exp/bidding/sell/zbwj/dissent/zbClariList.do' and sid='M00008' ;
    end if;
	--------add by xuz end------


    num:=0;
	select count(1) into num from bs_qxmx where sid='M00008' and action='/exp/bidding/sell/signup' and method='toUpZgyssqwj';
    if num = 1 then
	    update bs_qxmx set mkid='M091026' where sid='M00008' and action='/exp/bidding/sell/signup' and method='toUpZgyssqwj';
    end if;
   
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00008' and action='/exp/bidding/sell/signup' and method='saveZgyssqwj';
    if num = 1 then
	    update bs_qxmx set mkid='M091026' where sid='M00008' and action='/exp/bidding/sell/signup' and method='saveZgyssqwj';
    end if;
    

	------add by xuz  费用支付  驳回 start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/payment' and METHOD ='doTurnDown' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060040','/exp/bidding/sell/payment','doTurnDown',2,'费用驳回',1,'M00008');
	end if;
	
	num:=0;
    select instr(inurl,'/exp/bidding/sell/payment/doTurnDown.do') into num from bs_qxsz where sid = 'M00008' and mkid='M060040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/payment/doTurnDown.do') where  sid = 'M00008' and mkid='M060040';
    end if;
	------add by xuz  费用支付  驳回 end----

	------add by xuz 编辑订单 start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toUpdateDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','toUpdateDd',2,'编辑订单页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='doUpdateDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','doUpdateDd',2,'编辑订单',1,'M00008');
	end if;
	------add by xuz 编辑订单 end----

	-------------------------2016/08/03 报名及文件购买 hanglong start--------------------------
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M089080' and sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid, fixed, qxrole) 
         values('M089080', 'M0890', '资格预审', '报名及文件购买', '/exp/bidding/buy/bmqr/checkBm.do', '/exp/bidding/buy/bmqr/checkBm.do#/exp/bidding/buy/bmqr/confirm.do#/exp/bidding/buy/bmqr/refuse.do#/exp/bidding/buy/bmqr/paylist.do' , 1, 10, 1, 'M00008', 1, '1,5');
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M01000565' and sid='M00008';
    if num = 1 then
    	delete bs_qxsz where mkid='M01000565' and sid='M00008';
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr' and METHOD ='paylist' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089080','/exp/bidding/buy/bmqr','paylist',2,'已购买招标人列表',1,'M00008');
	end if;
    
    num:=0;
    select count(1) into num from  bs_qxmx where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='checkBm' and sid='M00008';
    if num = 1 then
    	update bs_qxmx set mkid='M089080' where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='checkBm' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxmx where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='confirm' and sid='M00008';
    if num = 1 then
    	update bs_qxmx set mkid='M089080' where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='confirm' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxmx where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='refuse' and sid='M00008';
    if num = 1 then
    	update bs_qxmx set mkid='M089080' where mkid='M01000565' and action='/exp/bidding/buy/bmqr' and method='refuse' and sid='M00008';
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr' and METHOD ='expertSign' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089080','/exp/bidding/buy/bmqr','expertSign',2,'资格预审报名导出',1,'M00008');
	end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089080';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/bmqr/expertSign.do') into num from bs_qxsz where sid='M00008' and mkid='M089080';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/bmqr/expertSign.do') where sid='M00008' and mkid='M089080';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr' and METHOD ='expertPay' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089080','/exp/bidding/buy/bmqr','expertPay',2,'资格预审文件购买导出',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089080';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/bmqr/expertPay.do') into num from bs_qxsz where sid='M00008' and mkid='M089080';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/bmqr/expertPay.do') where sid='M00008' and mkid='M089080';
		end if;
	end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M083090' and sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid, fixed, qxrole) 
         values('M083090', 'M0830', '发标', '报名及文件购买', '/exp/bidding/buy/bmqr/send/sendCheckBm.do', '/exp/bidding/buy/bmqr/send/sendCheckBm.do#/exp/bidding/buy/bmqr/send/sendConfirm.do#/exp/bidding/buy/bmqr/send/sendRefuse.do#/exp/bidding/buy/bmqr/send/sendPaylist.do' , 1, 10, 1, 'M00008', 1, '1,2,3,5,6,7');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='sendCheckBm' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','sendCheckBm',2,'报名确认页面列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='sendConfirm' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','sendConfirm',2,'报名通过',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='sendRefuse' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','sendRefuse',2,'报名拒绝',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='sendPaylist' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','sendPaylist',2,'已购买招标人列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='expertSendSign' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','expertSendSign',2,'后审报名导出',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083090';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/bmqr/send/expertSendSign.do') into num from bs_qxsz where sid='M00008' and mkid='M083090';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/bmqr/send/expertSendSign.do') where sid='M00008' and mkid='M083090';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/bmqr/send' and METHOD ='expertSendPay' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083090','/exp/bidding/buy/bmqr/send','expertSendPay',2,'招标文件购买导出',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083090';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/bmqr/send/expertSendPay.do') into num from bs_qxsz where sid='M00008' and mkid='M083090';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/bmqr/send/expertSendPay.do') where sid='M00008' and mkid='M083090';
		end if;
	end if;
	
	-------------------------2016/08/03 报名及文件购买 hanglong end----------------------------

	------add by xuz start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','packlist',2,'标段包过渡页',1,'M00008');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='toEdit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','toEdit',2,'编辑页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='submits' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','submits',2,'提交',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','toView',2,'查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='applyStop' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','applyStop',2,'申请终止',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='toConfirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','toConfirm',2,'审核页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='confirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','confirm',2,'审核通过',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/abnormal' and METHOD ='refuse' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M084030','/exp/bidding/buy/abnormal','refuse',2,'审核不通过',1,'M00008');
	end if;
	
	 num:=0;
    select instr(inurl,'/exp/bidding/buy/abnormal/packlist.do') into num from bs_qxsz where sid = 'M00008' and mkid='M084030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/abnormal/packlist.do') where  sid = 'M00008' and mkid='M084030';
    end if;
    
     num:=0;
    select instr(inurl,'/exp/bidding/buy/abnormal/toEdit.do') into num from bs_qxsz where sid = 'M00008' and mkid='M084030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/abnormal/toEdit.do') where  sid = 'M00008' and mkid='M084030';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/abnormal/submits.do') into num from bs_qxsz where sid = 'M00008' and mkid='M084030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/abnormal/submits.do') where  sid = 'M00008' and mkid='M084030';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/abnormal/toView.do') into num from bs_qxsz where sid = 'M00008' and mkid='M084030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/abnormal/toView.do') where  sid = 'M00008' and mkid='M084030';
    end if;
    
    
	------add by xuz end----

	------add by zyy start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/preout/hitbid/dissent' and METHOD ='yypackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091085','/exp/bidding/sell/preout/hitbid/dissent','yypackList',2,'标段包过渡页',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0910'and mkid='M091085' and  sid='M00008';
    if num>0 then
      update bs_qxsz set url='/exp/bidding/sell/preout/hitbid/dissent/yypackList.do' where mid='M0910' and mkid='M091085' and sid='M00008';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091085' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/preout/hitbid/dissent/yypackList.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/preout/hitbid/dissent/yypackList.do') where  mkid='M091085' and sid='M00008' and mid='M0910';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/preout/hitbid/dissent' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091085','/exp/bidding/sell/preout/hitbid/dissent','edit',2,'编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091085' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/preout/hitbid/dissent/edit.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/preout/hitbid/dissent/edit.do') where  mkid='M091085' and sid='M00008' and mid='M0910';
	end if;
	
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/tender/hitbid/dissent' and METHOD ='yypackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091090','/exp/bidding/sell/tender/hitbid/dissent','yypackList',2,'标段包过渡页',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0910'and mkid='M091090' and  sid='M00008';
    if num>0 then
      update bs_qxsz set url='/exp/bidding/sell/tender/hitbid/dissent/yypackList.do' where mid='M0910' and mkid='M091090' and sid='M00008';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091090' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/tender/hitbid/dissent/yypackList.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/tender/hitbid/dissent/yypackList.do') where  mkid='M091090' and sid='M00008' and mid='M0910';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/tender/hitbid/dissent' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091090','/exp/bidding/sell/tender/hitbid/dissent','edit',2,'编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091090' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/tender/hitbid/dissent/edit.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/tender/hitbid/dissent/edit.do') where  mkid='M091090' and sid='M00008' and mid='M0910';
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/hitbid/dissent' and METHOD ='yypackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091080','/exp/bidding/sell/pre/hitbid/dissent','yypackList',2,'标段包过渡页',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0910'and mkid='M091080' and  sid='M00008';
    if num>0 then
      update bs_qxsz set url='/exp/bidding/sell/pre/hitbid/dissent/yypackList.do' where mid='M0910' and mkid='M091080' and sid='M00008';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091080' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/pre/hitbid/dissent/yypackList.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/pre/hitbid/dissent/yypackList.do') where  mkid='M091080' and sid='M00008' and mid='M0910';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/pre/hitbid/dissent' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091080','/exp/bidding/sell/pre/hitbid/dissent','edit',2,'编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091080' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/pre/hitbid/dissent/edit.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/pre/hitbid/dissent/edit.do') where  mkid='M091080' and sid='M00008' and mid='M0910';
	end if;
	
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bid/hitbid/dissent' and METHOD ='yypackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M093015','/exp/bidding/sell/bid/hitbid/dissent','yypackList',2,'标段包过渡页',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0930'and mkid='M093015' and  sid='M00008';
    if num>0 then
      update bs_qxsz set url='/exp/bidding/sell/bid/hitbid/dissent/yypackList.do' where mid='M0930' and mkid='M093015' and sid='M00008';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M093015' and sid='M00008' and mid='M0930' and instr(inurl,'/exp/bidding/sell/bid/hitbid/dissent/yypackList.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bid/hitbid/dissent/yypackList.do') where  mkid='M093015' and sid='M00008' and mid='M0930';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bid/hitbid/dissent' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M093015','/exp/bidding/sell/bid/hitbid/dissent','edit',2,'编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M093015' and sid='M00008' and mid='M0930' and instr(inurl,'/exp/bidding/sell/bid/hitbid/dissent/edit.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bid/hitbid/dissent/edit.do') where  mkid='M093015' and sid='M00008' and mid='M0930';
	end if;
	
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='yypackList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','yypackList',2,'标段包过渡页',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0950'and mkid='M095050' and  sid='M00008';
    if num>0 then
      update bs_qxsz set url='/exp/bidding/sell/hitbid/dissent/yypackList.do' where mid='M0950' and mkid='M095050' and sid='M00008';
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M095050' and sid='M00008' and mid='M0950' and instr(inurl,'/exp/bidding/sell/hitbid/dissent/yypackList.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/dissent/yypackList.do') where  mkid='M095050' and sid='M00008' and mid='M0950';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','edit',2,'编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M095050' and sid='M00008' and mid='M0950' and instr(inurl,'/exp/bidding/sell/hitbid/dissent/edit.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/dissent/edit.do') where  mkid='M095050' and sid='M00008' and mid='M0950';
	end if;
	------add by zyy end----


	------add by zyy start----
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/hitbid/dissent' and METHOD ='delete' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M095050','/exp/bidding/sell/hitbid/dissent','delete',2,'删除',1,'M00008');
	end if;
	------add by zyy end----

	

 	------add by  hejw  start---------

----资格预审终止公告--start-------
	 num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mkid='M08905005' and mid='M0890';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid, fixed, qxrole)
      values ('M08905005', 'M0890', '资格预审', '终止公告', '2', 720, 1, 'M089050', 'M00008', 1, '1,2,3,4,5,6,7'); 
	end if;
     
num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='throwShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'throwShow', 1, '编制招标异常报告-查看', 1, 'M00008'); 
	end if;

  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='throwSave';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'throwSave', 1, '编制招标-异常报告-保存及更新', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='toEdit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'toEdit', 1, '终止公告-编制页面', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='update';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'update', 1, '终止公告-编制保存', 1, 'M00008'); 
	end if;   
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='examineShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'examineShow', 1, '终止公告-审核查看', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='examine';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'examine', 1, '终止公告-审核', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='releaseShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'releaseShow', 1, '招标终止公告-发布查看', 1, 'M00008'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='release';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'release', 1, '招标终止公告-发布', 1, 'M00008'); 
	end if;
	
	 num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/zgys' and method='send';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08905005', '/exp/subp/stop/zgys', 'send', 1, '招标终止公告-发送', 1, 'M00008'); 
	end if; 
	
   num:=0;
 select instr(inurl,'/exp/subp/stop/zgys/throwShow.do#/exp/subp/stop/zgys/toEdit.do#/exp/subp/stop/zgys/examineShow.do#/exp/subp/stop/zgys/releaseShow.do') into num from bs_qxsz where sid='M00008' and mkid='M089050';
 if num = 0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/subp/stop/zgys/throwShow.do#/exp/subp/stop/zgys/toEdit.do#/exp/subp/stop/zgys/examineShow.do#/exp/subp/stop/zgys/releaseShow.do') where sid='M00008' and mkid='M089050';
 end if;
----资格预审终止公告--end-------

---发标终止公告权限  ----start--------
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mkid='M08305005' and mid='M0830';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, isuse, orderno, styp, parent, sid)
      values ('M08305005', 'M0830', '发标', '终止公告', '2', 720, 1, 'M083050', 'M00008'); 
	end if;
     
num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='throwShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'throwShow', 1, '编制招标异常报告-查看', 1, 'M00008'); 
	end if;

  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='throwSave';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'throwSave', 1, '编制招标-异常报告-保存及更新', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='toEdit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'toEdit', 1, '终止公告-编制页面', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='update';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'update', 1, '终止公告-编制保存', 1, 'M00008'); 
	end if;   
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='examineShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'examineShow', 1, '终止公告-审核查看', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='examine';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'examine', 1, '终止公告-审核', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='releaseShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'releaseShow', 1, '招标终止公告-发布查看', 1, 'M00008'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='release';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'release', 1, '招标终止公告-发布', 1, 'M00008'); 
	end if;
	
	 num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/send' and method='send';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M08305005', '/exp/subp/stop/send', 'send', 1, '招标终止公告-发送', 1, 'M00008'); 
	end if; 
	
   num:=0;
 select instr(inurl,'/exp/subp/stop/send/throwShow.do#/exp/subp/stop/send/toEdit.do#/exp/subp/stop/send/examineShow.do#/exp/subp/stop/send/releaseShow.do') into num from bs_qxsz where sid='M00008' and mkid='M083050';
 if num = 0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/subp/stop/send/throwShow.do#/exp/subp/stop/send/toEdit.do#/exp/subp/stop/send/examineShow.do#/exp/subp/stop/send/releaseShow.do') where sid='M00008' and mkid='M083050';
 end if;
---发标终止公告权限  ----end--------
 
-----开标 终止项目  start------
  num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mkid='M084050' and mid='M0840';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid, fixed, qxrole)
      values ('M084050', 'M0840', '开标', '变更（终止）公告', '/exp/subp/stop/open/throwShow.do', '/exp/subp/stop/open/throwShow.do', 1, 350, 1, 'M00008', 1, '1,2,3,4,5,6,7'); 
	end if;
     
  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='throwShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'throwShow', 1, '编制招标异常报告-查看', 1, 'M00008'); 
	end if;

  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='throwSave';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'throwSave', 1, '编制招标-异常报告-保存及更新', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='toEdit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'toEdit', 1, '终止公告-编制页面', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='update';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'update', 1, '终止公告-编制保存', 1, 'M00008'); 
	end if;   
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='examineShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'examineShow', 1, '终止公告-审核查看', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='examine';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'examine', 1, '终止公告-审核', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='releaseShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'releaseShow', 1, '招标终止公告-发布查看', 1, 'M00008'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='release';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'release', 1, '招标终止公告-发布', 1, 'M00008'); 
	end if;
	
	 num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/open' and method='send';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M084050', '/exp/subp/stop/open', 'send', 1, '招标终止公告-发送', 1, 'M00008'); 
	end if; 
	
   num:=0;
 select instr(inurl,'/exp/subp/stop/open/toEdit.do#/exp/subp/stop/open/examineShow.do#/exp/subp/stop/open/releaseShow.do') into num from bs_qxsz where sid='M00008' and mkid='M084050';
 if num = 0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/subp/stop/open/toEdit.do#/exp/subp/stop/open/examineShow.do#/exp/subp/stop/open/releaseShow.do') where sid='M00008' and mkid='M084050';
 end if;
 -----开标 终止项目  end------


---评标终止公告权限  ----start--------
num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mkid='M085030' and mid='M0850';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid, fixed, qxrole)
      values ('M085030', 'M0850', '评标', '变更（终止）公告', '/exp/subp/stop/comment/throwShow.do', '/exp/subp/stop/comment/throwShow.do', 1, 300, 1, 'M00008', 1, '1,2,3,4,5,6,7'); 
	end if;
     
  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='throwShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'throwShow', 1, '编制招标异常报告-查看', 1, 'M00008'); 
	end if;

  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='throwSave';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'throwSave', 1, '编制招标-异常报告-保存及更新', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='toEdit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'toEdit', 1, '终止公告-编制页面', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='update';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'update', 1, '终止公告-编制保存', 1, 'M00008'); 
	end if;   
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='examineShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'examineShow', 1, '终止公告-审核查看', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='examine';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'examine', 1, '终止公告-审核', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='releaseShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'releaseShow', 1, '招标终止公告-发布查看', 1, 'M00008'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='release';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'release', 1, '招标终止公告-发布', 1, 'M00008'); 
	end if;
	
	 num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/comment' and method='send';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M085030', '/exp/subp/stop/comment', 'send', 1, '招标终止公告-发送', 1, 'M00008'); 
	end if; 
	
   num:=0;
 select instr(inurl,'/exp/subp/stop/comment/toEdit.do#/exp/subp/stop/comment/examineShow.do#/exp/subp/stop/comment/releaseShow.do') into num from bs_qxsz where sid='M00008' and mkid='M085030';
 if num = 0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/subp/stop/comment/toEdit.do#/exp/subp/stop/comment/examineShow.do#/exp/subp/stop/comment/releaseShow.do') where sid='M00008' and mkid='M085030';
 end if;
---评标终止公告权限  ----end--------


---定标终止公告权限  ----start--------
 num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mkid='M086080' and mid='M0860';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid, fixed, qxrole)
      values ('M086080', 'M0860', '定标', '变更（终止）公告', '/exp/subp/stop/scaling/throwShow.do', '/exp/subp/stop/scaling/throwShow.do', 1, 910, 1, 'M00008', 1, '1,2,3,4,5,6,7'); 
	end if;
     
  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='throwShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'throwShow', 1, '编制招标异常报告-查看', 1, 'M00008'); 
	end if;

  num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='throwSave';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'throwSave', 1, '编制招标-异常报告-保存及更新', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='toEdit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'toEdit', 1, '终止公告-编制页面', 1, 'M00008'); 
	end if; 
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='update';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'update', 1, '终止公告-编制保存', 1, 'M00008'); 
	end if;   
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='examineShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'examineShow', 1, '终止公告-审核查看', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='examine';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'examine', 1, '终止公告-审核', 1, 'M00008'); 
	end if;
  
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='releaseShow';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'releaseShow', 1, '招标终止公告-发布查看', 1, 'M00008'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='release';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'release', 1, '招标终止公告-发布', 1, 'M00008'); 
	end if;
	
	 num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/subp/stop/scaling' and method='send';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M086080', '/exp/subp/stop/scaling', 'send', 1, '招标终止公告-发送', 1, 'M00008'); 
	end if; 
	
   num:=0;
 select instr(inurl,'/exp/subp/stop/scaling/toEdit.do#/exp/subp/stop/scaling/examineShow.do#/exp/subp/stop/scaling/releaseShow.do') into num from bs_qxsz where sid='M00008' and mkid='M086080';
 if num = 0 then
	update bs_qxsz set inurl=concat(inurl,'#/exp/subp/stop/scaling/toEdit.do#/exp/subp/stop/scaling/examineShow.do#/exp/subp/stop/scaling/releaseShow.do') where sid='M00008' and mkid='M086080';
 end if;
---定标终止公告权限  ----end--------
 	------add by  hejw  end---------

	------------------cheny 2016/08/08服务端模板管理--start-----------------------------
    --添加"客户端管理"菜单项
    num:=0;
    select count(1) into num from bs_xtmk where mid = 'B0115' and sid = 'B00008';
    if num = 0 then
	     insert into bs_xtmk (mid, mname, styp, ordby, sid) values('B0115', '客户端管理', '2', '400', 'B00008');	   
    end if;
    --添加"模板管理"子菜单
    num:=0;
    select count(1) into num from bs_qxsz where mkid = 'B011505' and sid = 'B00008' and mid = 'B0115';
    if num = 0 then
	     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
       values('B011505', 'B0115', '客户端管理', '模板管理', '', '', '1', '100', '2', null, 'B00008');   
    end if;
  
    --添加访问权限
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'index';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'index', '2', '客户端管理-模板列表', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'list';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'list', '2', '客户端管理-模板明细列表', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'toAdd';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'toAdd', '2', '客户端管理-跳转新增模板页面', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'toUpdate';
    if num = 0 then
    insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'toUpdate', '2', '客户端管理-跳转修改模板页面', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'delete'; 
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'delete', '2', '客户端管理-删除模板', '2' , 'B00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'save';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'save', '2', '客户端管理-保存模板', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'update';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'update', '2', '客户端管理-更新模板', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'toAddMx';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'toAddMx', '2', '客户端管理-跳转新增模板明细页面', '2' , 'B00008'); 
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'saveMx';
    
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'saveMx', '2', '客户端管理-保存模板明细', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'toEdit';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'toEdit', '2', '客户端管理-跳转编辑模板明细页面', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'editMx';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'editMx', '2', '客户端管理-编辑模板明细', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'batchDelete';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'batchDelete', '2', '客户端管理-批量删除模板明细', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B011505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'download';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B011505', '/bdm/client/template', 'download', '2', '客户端管理-下载模板明细文件', '2' , 'B00008');
    end if;
    ------------------cheny 2016/08/08服务端模板管理--end-----------------------------
	----add by xuz start 招标异常后台审核----
	num:=0;
    select count(1) into num from  bs_qxsz where sid='B00008' and mkid='B011025' and mid='B0110';     
    if num = 0 then 
      insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid)
      values ('B011025', 'B0110', '招标管理', '招标异常审核', '/bdm/zbyc/list.do', '/bdm/zbyc/list.do#/bdm/zbyc/toAudit.do#/bdm/zbyc/refuse.do#/bdm/zbyc/confirm.do', 1, 400, 2, 'B00008'); 
	end if;
     
  num:=0;
    select count(1) into num from  bs_qxmx where sid='B00008' and action='/bdm/zbyc' and method='list';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('B011025', '/bdm/zbyc', 'list', 2, '招标异常审核列表页', 2, 'B00008'); 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxmx where sid='B00008' and action='/bdm/zbyc' and method='toAudit';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('B011025', '/bdm/zbyc', 'toAudit', 2, '招标异常审核页面', 2, 'B00008'); 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxmx where sid='B00008' and action='/bdm/zbyc' and method='refuse';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('B011025', '/bdm/zbyc', 'refuse', 2, '招标异常审核拒绝', 2, 'B00008'); 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxmx where sid='B00008' and action='/bdm/zbyc' and method='confirm';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('B011025', '/bdm/zbyc', 'confirm', 2, '招标异常审核通过', 2, 'B00008'); 
	end if;
	----add by xuz end 招标异常后台审核----
	
	---add by chenxp start 投标方澄清文件---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/yscqnotice' and sid = 'M00008' and method='tkNoticeView';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M091030','/exp/bidding/sell/yscqnotice','tkNoticeView','2','弹框查看澄清文件','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008' and method='tkNoticeView';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M091072','/exp/bidding/sell/zbcqnotice','tkNoticeView','2','弹框查看澄清文件','1','M00008');
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/sell/yscqnotice/tkNoticeView.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/yscqnotice/tkNoticeView.do') where  sid = 'M00008' and mkid='M091030';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/zbcqnotice/tkNoticeView.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091072';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/zbcqnotice/tkNoticeView.do') where  sid = 'M00008' and mkid='M091072';
    end if;
	---add by chenxp end-----
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
