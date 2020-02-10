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
	
    num:=0;
  	select instr(inurl,'/exp/bidding/sell/kbqd/show.do') into num from bs_qxsz where sid = 'M00008' and mkid='M093005' and mid='M0930';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/kbqd/show.do') where  sid = 'M00008' and mkid='M093005' and mid='M0930';
  	end if;	
  	
  	---add by zyy start---
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M095040' and sid='M00008' and mid='M0950' and instr(inurl,'/exp/bidding/sell/hitbid/notice/view.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/notice/view.do') where  mkid='M095040' and sid='M00008' and mid='M0950';
	end if;
	---add by zyy end---


	-----chenxp start-----
	-----招标项目计划
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008'  and mkid='M081030'  and method='editxmjh';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081030','/exp/bidding/buy/package','editxmjh','2','编辑招标项目计划','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008'  and mkid='M081030'  and method='savexmjh';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081030','/exp/bidding/buy/package','savexmjh','2','保存招标项目计划','1','M00008');
    end if;
    
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/package/editxmjh.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081030' and mid='M0810';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/package/editxmjh.do') where  sid = 'M00008' and mkid='M081030' and mid='M0810';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/package/savexmjh.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081030' and mid='M0810';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/package/savexmjh.do') where  sid = 'M00008' and mkid='M081030' and mid='M0810';
    end if;
    
    --招标项目
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and sid = 'M00008'  and mkid='M081025'  and method='getDljgInfoJson';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025','/exp/bidding/buy/subproject','getDljgInfoJson','2','招标代理机构信息','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/package/getDljgInfoJson.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081025' and mid='M0810';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/package/getDljgInfoJson.do') where  sid = 'M00008' and mkid='M081025' and mid='M0810';
    end if;
	-----chenxp end-------
--------权限明细增加

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M091061' and action='/exp/bidding/sell/result' and method='toAdopt' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M091061','/exp/bidding/sell/result','toAdopt',2,'结果通知书查看(通过)',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M091061' and action='/exp/bidding/sell/result' and method='toQueren' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M091061','/exp/bidding/sell/result','toQueren',2,'确认参加',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M091061' and action='/exp/bidding/sell/result' and method='toNotQueren' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M091061','/exp/bidding/sell/result','toNotQueren',2,'确认不参加',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M091061' and action='/exp/bidding/sell/result' and method='toQztj' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M091061','/exp/bidding/sell/result','toQztj',2,'签章提交(参加)',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M091061' and action='/exp/bidding/sell/result' and method='toNqztj' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M091061','/exp/bidding/sell/result','toNqztj',2,'签章提交(不参加)',1,'M00008');
	end if;


	-----zyy start-----
	----维护专家咨询维护费
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0850' and mkid='M085020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M085020','M0850','评标','维护专家咨询维护费','/bdp/mtcfee/expert/packlist.do','/bdp/mtcfee/expert/packlist.do#/bdp/mtcfee/expert/list.do',1,200,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/mtcfee/expert' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M085020','/bdp/mtcfee/expert','packlist',2,'标段包列表  过渡页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/mtcfee/expert' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M085020','/bdp/mtcfee/expert','list',2,'维护专家列表',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/mtcfee/expert' and METHOD ='update' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M085020','/bdp/mtcfee/expert','update',2,'保存维护费',1,'M00008');
	end if;
	-----zyy end-------


    ----权限设置修改
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M091061' and mid='M0910' and url='/exp/bidding/sell/result/list.do' and inurl='/exp/bidding/sell/result/list.do#/exp/bidding/sell/result/view.do' and  sid='M00008'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/sell/result/list.do#/exp/bidding/sell/result/view.do#/exp/bidding/sell/result/toAdopt.do#/exp/bidding/sell/result/toQueren.do#/exp/bidding/sell/result/toNotQueren.do#/exp/bidding/sell/result/toQztj.do#/exp/bidding/sell/result/toNqztj.do'
	    where mkid='M091061' and mid='M0910' and url='/exp/bidding/sell/result/list.do' and inurl='/exp/bidding/sell/result/list.do#/exp/bidding/sell/result/view.do' and sid='M00008'; 
    end if;
	
	
	--add by xuz start--
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M060040' and mid='M0600' and url='/exp/bidding/sell/payment/paylist.do' and  sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ) 
         values('M060040', 'M0600', '资金管理', '费用支付', '/exp/bidding/sell/payment/paylist.do', '/exp/bidding/sell/payment/paylist.do#/exp/bidding/sell/payment/view.do#/exp/bidding/sell/payment/topay.do#/exp/bidding/sell/payment/pay.do' , 1,400, 1, 'M00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M060040' and action='/exp/bidding/sell/payment' and method='paylist' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060040','/exp/bidding/sell/payment','paylist',2,'费用支付列表页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060040' and action='/exp/bidding/sell/payment' and method='view' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060040','/exp/bidding/sell/payment','view',2,'费用支付查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060040' and action='/exp/bidding/sell/payment' and method='topay' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060040','/exp/bidding/sell/payment','topay',2,'费用支付页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060040' and action='/exp/bidding/sell/payment' and method='pay' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060040','/exp/bidding/sell/payment','pay',2,'费用支付',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where mkid='M060050' and mid='M0600' and url='/exp/bidding/buy/checkpay/checklist.do' and  sid='M00008'; 
    if num = 0 then
	     insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ) 
         values('M060050', 'M0600', '资金管理', '费用确认', '/exp/bidding/buy/checkpay/checklist.do', '/exp/bidding/buy/checkpay/checklist.do#/exp/bidding/buy/checkpay/view.do#/exp/bidding/buy/checkpay/toCheck.do#/exp/bidding/buy/checkpay/doCheck.do' , 1,500, 1, 'M00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M060050' and action='/exp/bidding/buy/checkpay' and method='checklist' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060050','/exp/bidding/buy/checkpay','checklist',2,'费用确认列表页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060050' and action='/exp/bidding/buy/checkpay' and method='view' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060050','/exp/bidding/buy/checkpay','view',2,'订单查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060050' and action='/exp/bidding/buy/checkpay' and method='toCheck' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060050','/exp/bidding/buy/checkpay','toCheck',2,'费用确认页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060050' and action='/exp/bidding/buy/checkpay' and method='doCheck' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060050','/exp/bidding/buy/checkpay','doCheck',2,'费用确认',1,'M00008');
	end if;
	--add by xuz end--

	--------------------------------mazg start-------------------------------------------
	--招标方确认线下支付的履约保证金 权限明细
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M087040' and action='/exp/bidding/buy/contract/bidbond' and method='confirm' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M087040','/exp/bidding/buy/contract/bidbond','confirm',2,'履约保证金确认',1,'M00008');
	end if;
	--------------------------------mazg end-------------------------------------------

	----------------------2016/07/11	hanglong 合同履约登记权限明细 start-----------------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='toExecuteInfo' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'toExecuteInfo', 2, '进入合同履约登记页面', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='doExecuteInfo' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'doExecuteInfo', 2, '修改保存合同履约登记信息', 1, 'M00008');
	end if;
	----------------------2016/07/11	hanglong 合同履约登记权限明细 end-----------------------

	-------------lvcy 2016/07/12 客户端模板管理 --start---------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/client/template' and sid = 'M00008'  and mkid='0'  and method='uploadTemp';
    if num = 0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/client/template', 'uploadTemp', '0', '客户端-模板管理-上传模板', '1', 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/client/template' and sid = 'M00008'  and mkid='0'  and method='downloadTemp';
    if num = 0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/client/template', 'downloadTemp', '0', '客户端-模板管理-下载模板', '1', 'M00008');
    end if;

	-------------lvcy 2016/07/12 客户端模板管理 --end---------------------

	-- add by longf start ---
	
	-----------踏勘现场通知审核(招投标后台)
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B011015' and mid='B0110' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('B011015','B0110','招标管理','踏勘现场通知审核','/bdm/survey/notice/list.do','/bdm/survey/notice/list.do',1,300,2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='list' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','list',2,'踏勘现场通知列表',2,'B00008'); 
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='toAudit' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','toAudit',2,'踏勘现场通知-跳转审核界面',2,'B00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='approve' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','approve',2,'踏勘现场通知-审核通过',2,'B00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='reject' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','reject',2,'踏勘现场通知-审核拒绝',2,'B00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='download' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','download',2,'踏勘现场通知-下载附件',2,'B00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdm/survey/notice' and mkid='B011015' and method='show' and styp=2 and sid='B00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B011015','/bdm/survey/notice','show',2,'踏勘现场通知-查看',2,'B00008'); 
	end if;
	
	----------发标 踏勘现场 踏勘现场通知（招标方）
	
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083070' and mid='M0830';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M083070','M0830','发标','踏勘现场','/bdp/buy/survey/notice/list.do','/bdp/buy/survey/notice/list.do#/bdp/buy/survey/notice/toAdd.do#/bdp/buy/survey/notice/toEdit.do#/bdp/buy/survey/notice/toShow.do',1,'350',1,'','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='list' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'list', 2, '踏勘现场通知-列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='toAdd' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'toAdd', 2, '踏勘现场通知-新增通知', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='save' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'save', 2, '踏勘现场通知-保存通知', 1, 'M00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='sealsubmit' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'sealsubmit', 2, '踏勘现场通知-签章提交', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='toEdit' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'toEdit', 2, '踏勘现场通知-编辑通知', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='delete' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'delete', 2, '踏勘现场通知-删除通知', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='toShow' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'toShow', 2, '踏勘现场通知-查看通知', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='upload' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'upload', 2, '踏勘现场通知-上传附件', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='download' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/notice', 'download', 2, '踏勘现场通知-下载附件', 1, 'M00008');
    end if;
	
	----------发标 踏勘现场 踏勘现场记录（招标方）
	
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0830' and mkid ='M083070';
    if num=1 then
		update bs_qxsz set inurl='/bdp/buy/survey/notice/list.do#/bdp/buy/survey/notice/toAdd.do#/bdp/buy/survey/notice/toEdit.do#/bdp/buy/survey/notice/toShow.do' where sid = 'M00008' and mid = 'M0830' and mkid ='M083070';
    end if;
    
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0830' and mkid ='M083070' and instr(inurl,'#/bdp/buy/survey/notice/toShow.do')>0;
    if num=1 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/buy/survey/note/toEdit.do#/bdp/buy/survey/note/toShow.do') where sid = 'M00008' and mid = 'M0830' and mkid ='M083070';
    end if;
    
 	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='toEdit' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'toEdit', 2, '踏勘现场记录-编辑记录', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='save' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'save', 2, '踏勘现场记录-保存/更新记录', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='submit' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'submit', 2, '踏勘现场记录-提交', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='toShow' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'toShow', 2, '踏勘现场记录-查看记录', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='upload' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'upload', 2, '踏勘现场记录-上传附件', 1, 'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/note' and  method='download' and mkid='M083070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083070', '/bdp/buy/survey/note', 'download', 2, '踏勘现场记录-下载附件', 1, 'M00008');
    end if;
	
	
	----------踏勘现场通知确认（投标方）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M020015' and mid='M0200' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020015','M0200','投标管理','踏勘现场','/exp/bidding/sell/survey/list.do','/exp/bidding/sell/survey/list.do#/exp/bidding/sell/survey/toNotice.do',1,150,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='list' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','list',2,'踏勘现场-通知列表',1,'M00008'); 
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='toNotice' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','toNotice',2,'踏勘现场-通知确认页面',1,'M00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='confirm' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','confirm',2,'踏勘现场-确认参加',1,'M00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='refuse' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','refuse',2,'踏勘现场-确认不参加',1,'M00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='download' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','download',2,'踏勘现场-下载附件',1,'M00008'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/survey' and mkid='M020015' and method='toShow' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M020015','/exp/bidding/sell/survey','toShow',2,'踏勘现场-查看',1,'M00008'); 
	end if;
	
	---------踏勘现场--过渡页面
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083070' and url='/bdp/buy/survey/notice/list.do';    
    if num = 1 then
      update bs_qxsz set url='/bdp/buy/survey/notice/packlist.do' where sid='M00008' and mkid='M083070' and url='/bdp/buy/survey/notice/list.do' ;
    end if;
    
    num:=0;
	select instr(inurl,'/bdp/buy/survey/notice/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M083070' ; 
	if num = 0 then
	  update bs_qxsz set inurl=concat(inurl,'#/bdp/buy/survey/notice/packlist.do') where  sid='M00008' and mkid='M083070' ; 
	end if;
	 
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/buy/survey/notice' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M083070','/bdp/buy/survey/notice','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
	
	-- add by longf end ---

	num:=0;
	select count(1) into num from bs_qxmx where action='/cfca/b2b/payment' and mkid='0' and method='index' and styp=1 and sid='M00301';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/cfca/b2b/payment', 'index', 0,'中金支付B2B接入',1,'M00301'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/cfca/b2b/payment' and mkid='0' and method='callback' and styp=1 and sid='M00301';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/cfca/b2b/payment', 'callback', 0,'中金支付回调通知',1,'M00301'); 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/cfca/b2b/payment' and mkid='0' and method='success' and styp=1 and sid='M00301';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0', '/cfca/b2b/payment', 'success', 0,'中金支付界面回调通知',1,'M00301'); 
	end if;

	-- add by hejw start ---
    --修改 招标公告发布 --投标邀请书发送 
    --num:=0;
    --select count(1) into num from bs_qxsz where sid='M00008' and mkid='M082015' and mname='约标' and name='公告发布' and url='/exp/bidding/buy/aftfic/toPublish.do';    
    --if num = 1 then
      --update bs_qxsz set mkid='M083030',mid='M0830',mname='发标',name='招标公告发布',orderno=200 where sid='M00008' and mkid='M082015' and mname='约标' and name='公告发布' and url='/exp/bidding/buy/aftfic/toPublish.do';
    --end if;
    
    --num:=0;
    --select count(1) into num from bs_qxsz where sid='M00008' and mkid='M082030' and mname='约标' and name='投标邀请书发布' and url='/exp/bidding/buy/yqhs/toUpdate.do';    
    --if num = 1 then
      --update bs_qxsz set mkid='M083035',mid='M0830',mname='发标',orderno=250 where sid='M00008' and mkid='M082030' and mname='约标' and name='投标邀请书发布' and url='/exp/bidding/buy/yqhs/toUpdate.do';
    --end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where sid='M00008' and mkid='M082015' and action='/exp/bidding/buy/aftfic' and method in ('doPublish','view','toPublish');
    if num > 0 then
      update bs_qxmx set mkid='M083030' where sid='M00008' and mkid='M082015' and action='/exp/bidding/buy/aftfic' and method ='doPublish';
      update bs_qxmx set mkid='M083030' where sid='M00008' and mkid='M082015' and action='/exp/bidding/buy/aftfic' and method ='view';
      update bs_qxmx set mkid='M083030' where sid='M00008' and mkid='M082015' and action='/exp/bidding/buy/aftfic' and method ='toPublish';
    end if;
	-- add by hejw end ---

	-----chenxp start-----
  	-----预审文件开启列表
    num:=0;
  	select count(1) into num from bs_qxsz where sid = 'M00008' and mid='M0890' and mkid='M089090';
  	if num = 1 then
       update bs_qxsz set name='资格预审文件开启列表' ,inurl='/exp/bidding/buy/ysopen/ysPackList.do#/exp/bidding/buy/ysopen/packageYsOpen.do'  where sid = 'M00008' and mid='M0890' and mkid='M089090';
  	end if;
    
    ----预审文件开启记录
    num:=0;
  	select count(1) into num from bs_qxsz where sid = 'M00008' and mid='M0890' and mkid='M089092';
    if num = 0 then
       insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno,styp,  sid ,qxrole) 
       values('M089092','M0890','资格预审','资格预审文件开启记录','/exp/bidding/buy/ysopen/ysjlPackList.do','/exp/bidding/buy/ysopen/ysjlPackList.do#/exp/bidding/buy/ysopen/ysRecord.do#/exp/bidding/buy/ysopen/ysjlqz.do',1,550,1,'M00008','008-1-2-2');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090'  and method='ysRecord';
  	if num = 1 then
       update bs_qxmx set mkid='M089092' where action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090'  and method='ysRecord';
  	end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090'  and method='ysjlqz';
  	if num = 1 then
       update bs_qxmx set mkid='M089092' where action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090'  and method='ysjlqz';
  	end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089092'  and method='ysjlPackList';
  	if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	 values('M089092','/exp/bidding/buy/ysopen','ysjlPackList','2','预审开启记录列表','1','M00008');
  	end if;
 	-----chenxp end-------
 	-----linqingqing start-------


    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082040'and mid='M0820' and url='/exp/bidding/buy/yqhs/tocomnext.do' and inurl='/exp/bidding/buy/yqhs/tocomnext.do' and sid='M00008';     
    if num = 1 then
      delete from bs_qxsz where mkid='M082040'and mid='M0820' and url='/exp/bidding/buy/yqhs/tocomnext.do' and inurl='/exp/bidding/buy/yqhs/tocomnext.do' and sid='M00008'; 
    end if;
 	-----linqingqing end-------

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082020'and mid='M0820' and name='投标邀请书状态' and url='/exp/bidding/buy/yqhs/toRelease.do'  and sid='M00008';     
    if num = 1 then
      delete from bs_qxsz where mkid='M082020'and mid='M0820' and name='投标邀请书状态' and url='/exp/bidding/buy/yqhs/toRelease.do'  and sid='M00008'; 
    end if;
    
    --权限设置 定标 qxrole=1
	update bs_qxsz set qxrole='1' where mkid='M086010' and sid='M00008';
	update bs_qxsz set qxrole='1' where mkid='M086020' and sid='M00008';
	update bs_qxsz set qxrole='1' where mkid='M086040' and sid='M00008';
	update bs_qxsz set qxrole='1' where mkid='M086050' and sid='M00008';
	update bs_qxsz set qxrole='1' where mkid='M086090' and sid='M00008';
	
	-- 权限设置 定标 中标通知书确认
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0860' and mkid='M086055' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
		values('M086055','M0860','定标','中标通知书确认','/exp/bidding/buy/scaling/confirmList.do','/exp/bidding/buy/scaling/confirmList.do#/exp/bidding/buy/scaling/toConfirmZbTzs.do#/exp/bidding/buy/scaling/doConfirmZbTzs.do',1,160,1,'M00008','2');
	end if;
	-- 权限明细 中标通知书确认 标段包列表 过渡页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='confirmList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086055','/exp/bidding/buy/scaling','confirmList',2,'上传投标文件-标段包列表 过渡页面',1,'M00008');
	end if;
	-- 权限明细 中标通知书确认 中标通知书确认页面 招标人
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='toConfirmZbTzs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086055','/exp/bidding/buy/scaling','toConfirmZbTzs',2,'上传投标文件-中标通知书确认页面 招标人',1,'M00008');
	end if;
	-- 权限明细 中标通知书确认 中标通知书确认 招标人
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='doConfirmZbTzs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086055','/exp/bidding/buy/scaling','doConfirmZbTzs',2,'上传投标文件-中标通知书确认 招标人',1,'M00008');
	end if;	
	
	------hejw--start---------

 --招标项目---start--
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M081010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081020';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M081020';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081040';
    if num = 1 then
       update bs_qxsz set qxrole='5,6,7' where sid = 'M00008' and mkid='M081040';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081045';
    if num = 1 then
       update bs_qxsz set qxrole='5,6,7' where sid = 'M00008' and mkid='M081045';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081025';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M081025';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081030';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M081030';
    end if;
    --招标项目---end--
    
    --资格预审---start--
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089005';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089005';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089007';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089007';
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089010';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089010';
    end if;    
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089015';
    if num = 1 then
       update bs_qxsz set qxrole='4' where sid = 'M00008' and mkid='M089015';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089020';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089020';
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089040';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089040';
    end if;      
     
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089090';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089090';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089092';
    if num = 1 then
       update bs_qxsz set qxrole='1,4,5' where sid = 'M00008' and mkid='M089092';
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089045';
    if num = 1 then
       update bs_qxsz set qxrole='1,4,5' where sid = 'M00008' and mkid='M089045';
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M089096';
    if num = 1 then
       update bs_qxsz set qxrole='1,5' where sid = 'M00008' and mkid='M089096';
    end if; 
    --资格预审---end--
    --约标---start-- 
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M082010';
    if num = 1 then
       update bs_qxsz set qxrole='2,6' where sid = 'M00008' and mkid='M082010';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M082025';
    if num = 1 then
       update bs_qxsz set qxrole='3,7' where sid = 'M00008' and mkid='M082025';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M082035';
    if num = 1 then
       update bs_qxsz set qxrole='3,7' where sid = 'M00008' and mkid='M082035';
    end if; 
    --约标---end-- 
    --发标---start-- 
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M083010';
    end if; 

    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083015';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M083015';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083020';
    if num = 1 then
       update bs_qxsz set qxrole='4' where sid = 'M00008' and mkid='M083020';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083030';
    if num = 1 then
       update bs_qxsz set qxrole='2,6' where sid = 'M00008' and mkid='M083030';
    end if; 
     
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083035';
    if num = 1 then
       update bs_qxsz set qxrole='3,7' where sid = 'M00008' and mkid='M083035';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083070';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M083070';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M083040';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M083040';
    end if; 
    --发标---end--   
    --开标---start-
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M084010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M084010';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M084020';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M084020';
    end if; 
    --开标---end-
    --评标---start-
      num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M085010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M085010';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M085020';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M085020';
    end if; 
    
    --评标---end-
    --定标---start-
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M086010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M086010';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M086020';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M086020';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M086050';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M086050';
    end if;   
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M086055';
    if num = 1 then
       update bs_qxsz set qxrole='4' where sid = 'M00008' and mkid='M086055';
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M086040';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,5,6,7' where sid = 'M00008' and mkid='M086040';
    end if;   
    --定标---end-    
    --合同执行---Start- 
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M087040';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M087040';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M087010';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M087010';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M087030';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M087030';
    end if; 
    
        num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M087020';
    if num = 1 then
       update bs_qxsz set qxrole='1,2,3,4' where sid = 'M00008' and mkid='M087020';
    end if; 
    
    --合同执行---end- 
	------hejw--end---------
	---固定菜单 权限修改-start--
--发标
   num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M083050','M083055','M083060','M083065');
    if num > 0 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M083050';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M083055';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M083060';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M083065';
    end if; 
    
    --资格预审
   num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M089050','M089070','M089075','M089060');
    if num > 0 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M089050';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M089070';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M089075';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M089060';
    end if;
    
    --开标
       num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M084040','M084030');
    if num > 0 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M084040';
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M084030';
    end if;
    
     --定标
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M086090');
    if num > 0 then
       update bs_qxsz set qxrole='1,2,3,4,5,6,7' where sid = 'M00008' and mkid='M086090';
    end if;
	---固定菜单 权限修改-end--

	--投标方-start---
	 --报名
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M091040','M091072','M091050','M091071');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M091040';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M091072';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M091050';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M091071';
	    end if;  
	  
	   --投标
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M092005','M092020','M092050','M092060');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M092005';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M092020';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M092050';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M092060';
	    end if; 
	    
	      --开标
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M093005','M093015');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M093005';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M093015';
	    end if;  
	 
	      --中标
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M095020','M095040','M095050');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M093005';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M095040';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M095050';
	    end if;  
	    
	    
	      --签订合同
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M096030','M096010','M096050','M096020','M096040');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M096030';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M096010';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M096050';
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M096020';
	        update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M096040';
	    end if;  
	    
	    --评标
	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M094005');
	    if num > 0 then
	       update bs_qxsz set qxrole='1,2' where sid = 'M00008' and mkid='M094005';
	    end if;  
	--投标方-end---

	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid in ('M091092');
	    if num > 0 then
	       update bs_qxsz set orderno=250 where sid = 'M00008' and mkid='M091092';
	    end if;  

	   num:=0;
	    select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M085020' and name='维护专家咨询维护费';
	    if num > 0 then
	       update bs_qxsz set name='专家咨询维护费' where sid = 'M00008' and mkid='M085020' and name='维护专家咨询维护费';
	    end if; 

  	------删除老数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091093' and  sid='M00008' and mid='M0910' and name='邀请确认';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE MKID='M091093' AND SID='M00008' AND MID='M0910';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/sell/invitation' AND MKID='M091093' AND SID='M00008';
    end if;

	-- 权限设置 投标管理 投标邀请
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0200' and mkid='M020005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020005','M0200','投标管理','投标邀请','/exp/bidding/sell/invitation/list.do','/exp/bidding/sell/invitation/list.do',1,100,1,'M00008');
	end if;
	-- 权限明细 投标邀请 投标邀请列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/invitation' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020005','/exp/bidding/sell/invitation','list',2,'投标邀请-投标邀请列表',1,'M00008');
	end if;
	-- 权限明细 投标邀请 邀请书确认页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/invitation' and METHOD ='toConfirmYqs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020005','/exp/bidding/sell/invitation','toConfirmYqs',2,'投标邀请-邀请书确认页面',1,'M00008');
	end if;
	-- 权限明细 投标邀请 邀请书确认
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/invitation' and METHOD ='doConfirmYqs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020005','/exp/bidding/sell/invitation','doConfirmYqs',2,'投标邀请-邀请书确认',1,'M00008');
	end if;
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M020030'  and SID='M00008' ;
	if num = 0 then
	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	values('M020030','M0200','投标管理','邀请确认','/exp/bidding/sell/invitation/doConfirmYqs.do','/exp/bidding/sell/invitation/doConfirmYqs.do',1,150,1,'','M00008');
	end if;	

  	num:=0;
	 select count(1) into num from bs_qxmx where mkid='M020005'  and SID='M00008' and remark='投标邀请-邀请书确认' and action='/exp/bidding/sell/invitation'  ;
	if num > 0 then
	 update bs_qxmx set mkid='M020030' where mkid='M020005'  and SID='M00008' and remark='投标邀请-邀请书确认' and action='/exp/bidding/sell/invitation' ;
	 end if;    

    select count(1) into num from bs_qxmx where mkid='M020030' and action='/exp/bidding/sell/invitation' and method='doConfirmYqs' and sid='M00008' and styp=1;
    if num > 0 then
		update bs_qxmx set mkid='M020005' where mkid='M020030' and action='/exp/bidding/sell/invitation' and method='doConfirmYqs' and sid='M00008' and styp=1;
    end if; 
    
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M020030' and mid='M0200' and url='/exp/bidding/sell/invitation/doConfirmYqs.do' and inurl='/exp/bidding/sell/invitation/doConfirmYqs.do' and isuse=1 and orderno=150 and styp=1 and sid='M00008';
	if num=1 then
		delete from bs_qxsz where mkid='M020030' and mid='M0200' and url='/exp/bidding/sell/invitation/doConfirmYqs.do' and inurl='/exp/bidding/sell/invitation/doConfirmYqs.do' and isuse=1 and orderno=150 and styp=1 and sid='M00008';
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'
	    where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do'; 
	end if;
	
	    ----权限明细
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/invitation' and mkid='M020005' and sid = 'M00008'   and method='doQztj';
  	if num = 0 then
	insert into bs_qxmx(mkid, action, method, accesstag,remark,styp,sid) 
        values('M020005', '/exp/bidding/sell/invitation', 'doQztj', 2, '投标邀请-签章提交', 1,'M00008');
 
  	end if;

    ----权限设置修改
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do#/exp/bidding/sell/invitation/doQztj.do'
    where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'; 
 end if;
 
 	    ----权限明细
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/invitation' and mkid='M020005' and sid = 'M00008'   and method='doGm';
  	if num = 0 then
	insert into bs_qxmx(mkid, action, method, accesstag,remark,styp,sid) 
        values('M020005', '/exp/bidding/sell/invitation', 'doGm', 2, '投标邀请-购买招标文件', 1,'M00008');
 
  	end if;

    ----权限设置修改
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do#/exp/bidding/sell/invitation/doQztj.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do#/exp/bidding/sell/invitation/doQztj.do#/exp/bidding/sell/invitation/doGm.do'
    where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do#/exp/bidding/sell/invitation/doQztj.do'; 
 	end if;	       
        num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008'  and mkid='M082010' and inurl='/exp/bidding/buy/aftfic/index.do#/exp/bidding/buy/aftfic/view.do';
  	if num = 1 then
       update bs_qxsz set inurl='/exp/bidding/buy/aftfic/index.do' where sid = 'M00008'  and mkid='M082010' and inurl='/exp/bidding/buy/aftfic/index.do#/exp/bidding/buy/aftfic/view.do';
  	end if;
  	
  	 --删除购买资格预审文件列表里面的inurl
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0820' and mkid ='M082035' and instr(inurl,'#/exp/bidding/buy/yqhs/toUpdate.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/buy/yqhs/toUpdate.do','') where  sid = 'M00008' and mid = 'M0820' and mkid ='M082035';
	 end if;
	 
	 -----hejw--start---------
   select count(1) into num from bs_qxmx where mkid='M082035' and action='/exp/bidding/buy/yqhs' and method in ('toUpdate','toRelease') and sid='M00008' ;
    if num > 0 then
		   DELETE FROM bs_qxmx WHERE mkid='M082035' and action='/exp/bidding/buy/yqhs' and method='toUpdate' and sid='M00008';
		   DELETE FROM bs_qxmx WHERE mkid='M082035' and action='/exp/bidding/buy/yqhs' and method='toRelease' and sid='M00008';
    end if; 

  num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toUpdate' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083035','/exp/bidding/buy/yqhs','toUpdate',2,'投标邀请书发布页面',1,'M00008');
	end if;
  
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='toRelease' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083035','/exp/bidding/buy/yqhs','toRelease',2,'投标邀请书编制发布',1,'M00008');
	end if;
  
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M083035' and url='/exp/bidding/buy/yqhs/toUpdate.do' and sid='M00008';
    if num > 0 then
		update bs_qxsz set inurl='/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toRelease.do' where mkid='M083035' and url='/exp/bidding/buy/yqhs/toUpdate.do' and sid='M00008';
    end if; 

   num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0820' and mkid ='M082035' and instr(inurl,'#/exp/bidding/buy/yqhs/toRelease.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/buy/yqhs/toRelease.do','') where  sid = 'M00008' and mid = 'M0820' and mkid ='M082035';
	 end if;
	 -----hejw--end---------

	-------------cheny 2016/07/18 客户端模板管理 --start---------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/client/template' and sid = 'M00008'  and mkid='0'  and method='getTempList';
    if num = 0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/client/template', 'getTempList', '0', '客户端-模板管理-获取模板列表', '1', 'M00008');
    end if;
	-------------cheny 2016/07/18 客户端模板管理 --end---------------------

  num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0910' and  mkid in ('M091010','M091035') and qxrole='2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='2,3' where mkid='M091010'  and SID='M00008' and mid='M0910'  and qxrole='2';
   update bs_qxsz set qxrole='2,3' where mkid='M091035'  and SID='M00008' and mid='M0910'  and qxrole='2';
	end if;   
  
    num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0910' and  mkid in ('M091050','M091040','M091071','M091072') and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M091050'  and SID='M00008' and mid='M0910'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M091040'  and SID='M00008' and mid='M0910'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M091071'  and SID='M00008' and mid='M0910'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M091072'  and SID='M00008' and mid='M0910'  and qxrole='1,2';
	end if;  
  
  num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0920' and  mkid in ('M092005','M092020','M092050','M092060') ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M092005'  and SID='M00008' and mid='M0920'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M092020'  and SID='M00008' and mid='M0920'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M092050'  and SID='M00008' and mid='M0920'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M092060'  and SID='M00008' and mid='M0920'  and qxrole='1,2';
	end if; 
 
  num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0930' and  mkid in ('M093015','M093005')  and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M093005'  and SID='M00008' and mid='M0930'  and qxrole='1,2';
   update bs_qxsz set qxrole='1,2,3' where mkid='M093015'  and SID='M00008' and mid='M0930'  and qxrole='1,2';
	end if;  
  
  num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0940' and  mkid in ('M094005')  and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M094005'  and SID='M00008' and mid='M0940'  and qxrole='1,2';
	end if;
  
  num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0950' and  mkid in ('M095050','M095040')  and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M095050'  and SID='M00008' and mid='M0950'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M095040'  and SID='M00008' and mid='M0950'  and qxrole='1,2';
	end if;
  
    num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0950' and  mkid in ('M095050','M095040')  and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M095050'  and SID='M00008' and mid='M0950'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M095040'  and SID='M00008' and mid='M0950'  and qxrole='1,2';
	end if;
  
    num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0960' and  mkid in ('M096010','M096040','M096030','M096050','M096020')  and qxrole='1,2' ;
	if num > 0 then
	 update bs_qxsz set qxrole='1,2,3' where mkid='M096010'  and SID='M00008' and mid='M0960'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M096040'  and SID='M00008' and mid='M0960'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M096030'  and SID='M00008' and mid='M0960'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M096050'  and SID='M00008' and mid='M0960'  and qxrole='1,2';
	 update bs_qxsz set qxrole='1,2,3' where mkid='M096020'  and SID='M00008' and mid='M0960'  and qxrole='1,2';
	end if;

    num:=0;
    select instr(inurl,'/exp/bidding/sell/bidbond/pay/packageView.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092020' and mid='M0920';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidbond/pay/packageView.do') where  sid = 'M00008' and mkid='M092020' and mid='M0920';
    end if;

	-----zyy--start---------
	num:=0;
    select count(1) into num from  bs_xtmk where sid='M00000' and mid='M0400'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0400', '标准化管理', 1, 105, 'M00000');
	end if;
			
	-----zyy--end---------

    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/bidbond/pay/showContract.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092020' and mid='M0920';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidbond/pay/showContract.do') where  sid = 'M00008' and mkid='M092020' and mid='M0920';
    end if;
    
    
      num:=0;
	 select count(1) into num from bs_qxsz where SID='M00008' and mid='M0910' and  mkid in ('M091010')  and qxrole='2,3' ;
	if num > 0 then
	 update bs_qxsz set qxrole='2' where mkid='M091010'  and SID='M00008' and mid='M0910'  and qxrole='2,3';
	end if;

	
	--add by xuz start----
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='toEnchashment' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','toEnchashment',2,'转出提现页面',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='doEnchashment' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','doEnchashment',2,'转出提现',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='toOverdraw' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','toOverdraw',2,'透支页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='doOverdraw' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','doOverdraw',2,'透支',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='toReturn' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','toReturn',2,'退保证金页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M060020' and action='/exp/bidding/account' and method='doReturn' and accesstag=2 and styp=1 and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060020','/exp/bidding/account','doReturn',2,'退保证金',1,'M00008');
	end if;
    --add by xuz end------

	--add by zyy start----
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0400' and mkid='M040010' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M040010','M0400','标准化管理','会员赋码','/bsm/menber/coding/mblist.do','/bsm/menber/coding/mblist.do#/bsm/menber/coding/mbedit.do',1,100,1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='mblist' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','mblist',2,'会员赋码页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='mbedit' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','mbedit',2,'会员赋码编辑页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='codingExport' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','codingExport',2,'会员赋码导出',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='importFile' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','importFile',2,'会员赋码导入',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='save' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','save',2,'会员赋码保存',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='showSupplier' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','showSupplier',2,'查看供应商信息',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='export' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','export',2,'会员详细信息导出',1,'M00000');
	end if;
	
	------供应商审核
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0400' and mkid='M040015' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M040015','M0400','标准化管理','供应商审核','/bsm/supplier/audit/staylist.do','/bsm/supplier/audit/staylist.do#/bsm/supplier/audit/audit.do#/bsm/supplier/audit/endlist.do',1,200,1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='staylist' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','staylist',2,'待审核页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='audit' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','audit',2,'审核页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='update' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','update',2,'保存审核信息',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='endlist' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','endlist',2,'已审核页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='view' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','view',2,'供应商信息查看',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040015' and action='/bsm/supplier/audit' and method='export' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040015','/bsm/supplier/audit','export',2,'导出',1,'M00000');
	end if;
	
	----产品赋码	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='cplist' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','cplist',2,'产品赋码页面',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='productExport' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','productExport',2,'产品赋码导出',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='importProdFile' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','importProdFile',2,'产品赋码带入',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='prodxq' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','prodxq',2,'产品详情页',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M040010' and action='/bsm/menber/coding' and method='updateProd' and styp=1 and sid='M00000';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M040010','/bsm/menber/coding','updateProd',2,'保存产品详情',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M040010' and sid='M00000' and mid='M0400' and instr(inurl,'/bsm/menber/coding/cplist.do')>0;
	if num=0 then
	update bs_qxsz set inurl=concat(inurl,'#/bsm/menber/coding/cplist.do') where  mkid='M040010' and sid='M00000' and mid='M0400';
	end if;
	--add by zyy end------
  	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='gysgl' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','gysgl',2,'供应产品管理',1,'M00000');
	end if; 
	
	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='setOk' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','setOk',2,'设置合格供应商产品',1,'M00000');
	end if; 
	
	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='showFw' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','showFw',2,'查看服务兵器企业',1,'M00000');
	end if;
	
  num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid ='M039005' and instr(inurl,'#/bsp/suplier/menber/gysgl.do')>0;
    if num=0 then
    update bs_qxsz set inurl=concat(inurl,'#/bsp/suplier/menber/gysgl.do') where sid = 'M00000' and mid = 'M0390' and mkid ='M039005';
    end if;	   
    
    ---chenxp start---
    select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M081030' and mid='M0810';
    if num = 1 then
       update bs_qxsz set  name='标段(包)' where sid = 'M00008' and mkid='M081030' and mid='M0810';
  	end if; 
  	---chenxp end-----

	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='setJt' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','setJt',2,'查看服务兵器企业',1,'M00000');
	end if;
	
	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='toAddMx' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','toAddMx',2,'添加产品明细',1,'M00000');
	end if;
	
	-------------------2016/07/23 hanglong 会员基本信息维护 start----------------------
	num:=0;
    select count(1) into num from bs_xtmk where sid = 'M00000' and mid = 'M0500';
    if num=0 then
    	insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0500','基本信息维护',1,50,'M00000');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0500' and mkid ='M050010';
    if num=0 then
    	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050010','M0500','基本信息维护','会员基本信息','/bsm/menber/info/basic/info.do','/bsm/menber/info/basic/info.do#/bsm/menber/info/basic/doSave.do',1,100,1,'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0500' and mkid ='M050040';
    if num=0 then
    	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M050040','M0500','基本信息维护','其他信息管理','/bsm/menber/info/other/info.do','/bsm/menber/info/other/info.do#/bsm/menber/info/other/doSave.do',1,400,1,'M00000');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where mkid='M050010' and action='/bsm/menber/info/basic' and method='info' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M050010','/bsm/menber/info/basic','info',2,'进入会员基本信息页面',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M050010' and action='/bsm/menber/info/basic' and method='doSave' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M050010','/bsm/menber/info/basic','doSave',2,'保存会员基本信息',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M050040' and action='/bsm/menber/info/other' and method='info' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M050040','/bsm/menber/info/other','info',2,'进入其他信息页面',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M050040' and action='/bsm/menber/info/other' and method='doSave' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M050040','/bsm/menber/info/other','doSave',2,'保存其他信息',1,'M00000');
	end if;
	-------------------2016/07/23 hanglong 会员基本信息维护 end------------------------

	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='downLoad' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','downLoad',2,'下载模板',1,'M00000');
	end if;
	
	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='importProdFile' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','importProdFile',2,'导入',1,'M00000');
	end if;

	
	num:=0;
     select count (1) into num from bs_xtmk where sid='M00000' and mid='M0390' and mname='供应商管理';
     if num > 0 then
      update bs_xtmk set mname='合格供应商' where sid='M00000' and mid='M0390';
      update bs_qxsz set mname='合格供应商' where sid='M00000' and mid='M0390';
     end if;

	
	num:=0;
  		select count(1) into num from bs_qxmx where mkid='M03900530' and action='/bsp/suplier/menber' and method='doSave' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M03900530','/bsp/suplier/menber','doSave',2,'保存产品明细',1,'M00000');
	end if;
	
	  num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid ='M039005' and instr(inurl,'#/bsp/suplier/menber/toAddMx.do')>0;
    if num=0 then
    update bs_qxsz set inurl=concat(inurl,'#/bsp/suplier/menber/toAddMx.do') where sid = 'M00000' and mid = 'M0390' and mkid ='M039005';
    end if;	 

	 num:=0;
     select count (1) into num from bs_qxsz where sid='M00000' and mkid='M040010' and name='会员赋码';
     if num > 0 then
      update bs_qxsz set name='赋码管理' where sid='M00000' and mkid='M040010';
      update bs_qxsz set orderno='200' where sid='M00000' and mkid='M040010';
      update bs_qxsz set orderno='100' where sid='M00000' and mkid='M040015';
     end if;
     
     num:=0;
     select count (1) into num from bs_qxsz where sid='M00000' and mkid='M039005' and name='我的供应商';
     if num > 0 then
      update bs_qxsz set name='合格供应商' where sid='M00000' and mkid='M039005';
     end if;
     
	-----章跳转链接-hejw--start-------  
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0810' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/subproject/list.do' where sid='M00008' and mid='M0810' and url00 is null;
   end if;
   
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0820' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/aftfic/index.do' where sid='M00008' and mid='M0820' and url00 is null;
   end if;
   
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0830' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/zbwjone/toZbwjCssz.do' where sid='M00008' and mid='M0830' and url00 is null;
   end if;
   
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0890' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/prefic/index.do' where sid='M00008' and mid='M0890' and url00 is null;
   end if; 
   
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0840' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/kb/kbPackList.do' where sid='M00008' and mid='M0840' and url00 is null;
   end if; 
   
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0850' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/bdp/review/result/packlist.do' where sid='M00008' and mid='M0850' and url00 is null;
   end if; 
 
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0860' and url00 is null;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/scaling/listzb.do' where sid='M00008' and mid='M0860' and url00 is null;
   end if; 

   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0870' ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/buy/contract/bidbond/list.do' where sid='M00008' and mid='M0870' ;
   end if; 
	----招标方-章跳转链接-hejw--end-------  
	----投标人-章跳转链接-hejw--start-------  
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0910' and url00 is null ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/signup/toZgysSignup.do' where sid='M00008' and mid='M0910' and url00 is null ;
   end if; 
   
      num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0920' and url00 is null ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/bidding/toUploadTbwj.do' where sid='M00008' and mid='M0920' and url00 is null ;
   end if; 
   
      num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0930' and url00 is null ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/kbqd/index.do' where sid='M00008' and mid='M0930' and url00 is null ;
   end if; 

      num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0950' and url00 is null ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/hitbid/package/list.do' where sid='M00008' and mid='M0950' and url00 is null ;
   end if;
   
      num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0960' and url00='/exp/bidding/sell/contract/packageList.do' ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/contract/bidbond/list.do' where sid='M00008' and mid='M0960' and url00='/exp/bidding/sell/contract/packageList.do' ;
   end if;
	----投标人-章跳转链接-hejw--end-------  

	-------------------2016/07/25 hanglong 供应商管理审批 start----------------------
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid ='M039020';
    if num=0 then
    	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M039020','M0390','合格供应商','合格产品审批','/bsp/suplier/audit/product/list.do','/bsp/suplier/audit/product/list.do#/bsp/suplier/audit/product/doAudit.do',1,400,1,'M00000');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039020' and action='/bsp/suplier/audit/product' and method='list' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039020','/bsp/suplier/audit/product','list',2,'待审批列表',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039020' and action='/bsp/suplier/audit/product' and method='doAudit' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039020','/bsp/suplier/audit/product','doAudit',2,'审批操作',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039020' and action='/bsp/suplier/audit/product' and method='showSpplier' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039020','/bsp/suplier/audit/product','showSpplier',2,'查看供应商信息',1,'M00000');
	end if;
	
	------------------
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid ='M039030';
    if num=0 then
    	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M039030','M0390','合格供应商','集团级审批','/bsp/suplier/audit/group/list.do','/bsp/suplier/audit/group/list.do#/bsp/suplier/audit/group/doAudit.do',1,500,1,'M00000');
    end if;
    
    num:=0;	
  	select count(1) into num from bs_qxmx where mkid='M039030' and action='/bsp/suplier/audit/group' and method='list' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039030','/bsp/suplier/audit/group','list',2,'待审批列表',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039030' and action='/bsp/suplier/audit/group' and method='doAudit' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039030','/bsp/suplier/audit/group','doAudit',2,'审批操作',1,'M00000');
	end if;
	
	--------------------
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00000' and mid = 'M0390' and mkid ='M039040';
    if num=0 then
    	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M039040','M0390','合格供应商','子集团级审批','/bsp/suplier/audit/groupchild/list.do','/bsp/suplier/audit/groupchild/list.do#/bsp/suplier/audit/groupchild/doAudit.do',1,600,1,'M00000');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039040' and action='/bsp/suplier/audit/groupchild' and method='list' and styp=1 and sid='M00000';      
  	if num = 0 then 
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039040','/bsp/suplier/audit/groupchild','list',2,'待审批列表',1,'M00000');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where mkid='M039040' and action='/bsp/suplier/audit/groupchild' and method='doAudit' and styp=1 and sid='M00000';
  	if num = 0 then
    	insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    	values('M039040','/bsp/suplier/audit/groupchild','doAudit',2,'审批操作',1,'M00000');
	end if;
	
	-------------------2016/07/25 hanglong 供应商管理审批 end------------------------

	--投标方	评审
   num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0940' and url00 is null ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/qureply/list.do' where sid='M00008' and mid='M0940' and url00 is null ;
   end if; 
   
      num:=0;
   select count (1) into num from bs_xtmk where sid='M00008' and mid='M0950' and url00='/exp/bidding/sell/hitbid/package/list.do' ;
   if num > 0 then
    update bs_xtmk set url00='/exp/bidding/sell/hitbid/publicity/packlist.do' where sid='M00008' and mid='M0950' and url00='/exp/bidding/sell/hitbid/package/list.do' ;
   end if; 

    --add by longf start------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='upload' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','upload',1,'评审报告-上传附件',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='download' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','download',1,'评审报告-下载附件',1,'M00009');
	end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/review/result' and  method='download' and mkid='M085010' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M085010', '/bdp/review/result', 'download', 2, '评标-评标结果-下载附件', 1, 'M00008');
    end if;
    
  	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/pre/result' and  method='download' and mkid='M089045' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089045', '/bdp/pre/result', 'download', 2, '资格预审-资格预审评审报告-下载附件', 1, 'M00008');
    end if;
      
    --add by longf end------

	-- 权限明细 资格预审文件上传 保存资格预审文件new
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='saveZgyswjNew' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','saveZgyswjNew',2,'资格预审文件上传-保存资格预审文件new',1,'M00008');
	end if;	
	-- 权限明细 资格预审文件上传 资格预审文件下载页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toDownZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','toDownZgyswj',2,'资格预审文件上传-资格预审文件下载页面',1,'M00008');
	end if;	
	
	-- 权限明细 资格预审文件上传 发布资格预审文件new
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='doPublishYswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','doPublishYswj',2,'资格预审文件上传-发布资格预审文件new',1,'M00008');
	end if;
	
	-- 权限明细 资格预审文件上传 招标方审核意见页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toConfirmShyj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089010','/bdp/bidding/buy/preficfile','toConfirmShyj',2,'资格预审文件上传-招标方审核意见页面',1,'M00008');
	end if;	
	
	-- 权限明细 招标文件上传 招标文件上传new
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='saveBsmbWjNew' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083015','/exp/bidding/buy/zbwjone','saveBsmbWjNew',2,'发标流程-招标文件上传new',1,'M00008');
	end if;
	-- 权限明细 招标文件上传 招标文件下载页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toDownZbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083015','/exp/bidding/buy/zbwjone','toDownZbwj',2,'发标流程-招标文件下载页面',1,'M00008');
	end if;
	-- 权限明细 招标文件上传 标书文件发布new
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='doBswjPublishNew' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083015','/exp/bidding/buy/zbwjone','doBswjPublishNew',2,'发标流程-标书文件发布new',1,'M00008');
	end if;
	
	-----chenxp start-----
    ----招标文件开启
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid='M0930' and mkid='M093005' and name='招标文件开启';
    if num = 1 then
       update bs_qxsz set name='投标文件开启' where sid = 'M00008' and mid='M0930' and mkid='M093005' and name='招标文件开启';
    end if;
    -----chenxp end-------
    
    -----zyy start-----
    ----导出供应产品管理
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='prodExport' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','prodExport',2,'供应产品管理-导出',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='prodxq' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','prodxq',2,'供应产品管理-详情',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='updateProd' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','updateProd',2,'供应产品管理-详情保存',1,'M00000');
	end if;
    -----zyy end-------

	--------------------2016/07/28 hanglong 添加招投标平台自己的登出方法start---------------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/login' and METHOD ='doBdLogout' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','doBdLogout',0,'招标平台登出方法',1,'M00000');
	end if;
	--------------------2016/07/28 hanglong 添加招投标平台自己的登出方法end-----------------------------
     
  	-----zyy start-----
    ----供应产品管理--删除产品明细
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='delete' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','delete',2,'供应产品管理-删除产品明细',1,'M00000');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bsp/suplier/menber' and METHOD ='cancelJt' and STYP=1 and SID='M00000';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M03900530','/bsp/suplier/menber','cancelJt',2,'供应产品管理-取消管理等级',1,'M00000');
	end if;
    -----zyy end-------
     
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
