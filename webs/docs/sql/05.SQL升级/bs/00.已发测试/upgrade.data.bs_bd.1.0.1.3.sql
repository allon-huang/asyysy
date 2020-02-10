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

	num:=0;
    select count(1) into num from  bs_xtmk where mid='M0820' and sid='M00008' and mname='约标';
    if num = 1 then
	     update bs_xtmk set mname='标前准备' where mid='M0820' and sid='M00008' and mname='约标'; 
    end if;
    
		------by  songw  2016年10月16日   start -----------------
 	num:=0;
		select count(1) into num from bs_qxmx where mkid = '0' and sid = 'M00009' and action = '/psp/judge/jbropen/kb' and method = 'toPsbg';
	if num = 0 then
		insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
			values('0', '/psp/judge/jbropen/kb', 'toPsbg', '1', '查看评审报告', '1' , 'M00009');
	end if;

	------by  songw  2016年10月16日   end -----------------


	------by  wangch  2016年11月1日   start -----------------
 	num:=0;
		select count(1) into num from bs_qxmx where mkid = 'M085020' and sid = 'M00008' and action = '/bdp/mtcfee/expert' and method = 'pwxxWh';
	if num = 0 then
		insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
			values('M085020', '/bdp/mtcfee/expert', 'pwxxWh', '2', '下载评审信息维护', '1' , 'M00008');
	end if;

	------by  wangch  2016年11月1日   end -----------------

	------by  wangch  2016年11月8日   start -----------------
 	num:=0;
		select count(1) into num from bs_qxmx where mkid = 'M089090' and sid = 'M00008' and action = '/exp/bidding/buy/ysopen' and method = 'digital';
	if num = 0 then
		insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
			values('M089090', '/exp/bidding/buy/ysopen', 'digital', '2', '评委数字证书使用登记表', '1' , 'M00008');
	end if;

	------by  wangch  2016年11月8日   end -----------------

	-- 权限明细 资格预审公告审核 公告验证
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/prefic' and METHOD ='doVerify' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B011005','/bdm/prefic','doVerify',2,'资格预审公告审核-公告验证',2,'B00008');
	end if;

	-- 权限明细 资格预审公告审核 公告验证

	--add by xuz start---
	  num:=0;
    select count(1) into num from bs_xtmk where mid = 'B0130' and sid = 'B00008';
    if num = 0 then
       insert into bs_xtmk (mid, mname, styp, ordby, sid) values('B0130', '考评管理', '2', '450', 'B00008');     
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013005' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013005','B0130','考评管理','招标人考评','/bdm/zbrappraisal/list.do','/bdm/zbrappraisal/list.do', 1, 50, 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zbrappraisal' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013005','/bdm/zbrappraisal','list','2','招标人考评列表','2','B00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013010' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013010','B0130','考评管理','代理机构考评','/bdm/dljgappraisal/list.do','/bdm/dljgappraisal/list.do', 1, 100, 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgappraisal' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013010','/bdm/dljgappraisal','list','2','代理机构考评列表','2','B00008');
    end if;
    
       num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013015' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013015','B0130','考评管理','投标人考评','/bdm/tbrappraisal/list.do','/bdm/tbrappraisal/list.do', 1, 150, 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/tbrappraisal' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013015','/bdm/tbrappraisal','list','2','投标人考评列表','2','B00008');
    end if;

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/tbrappraisal' and METHOD ='exportExcel' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B013015','/bdm/tbrappraisal','exportExcel',2,'投标人考评导出',2,'B00008');
	end if;

     num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013020' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013020','B0130','考评管理','专家考评','/bdm/zjappraisal/list.do','/bdm/zjappraisal/list.do', 1, 200, 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zjappraisal' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013020','/bdm/zjappraisal','list','2','专家考评列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zjappraisal' and method='exportExcel' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013020','/bdm/zjappraisal','exportExcel','2','专家考评列表导出','2','B00008');
    end if; 
    ------cheny--报名-澄清公告---2016-10-26--start-----------------
    num:=0;
    select count(1) into num from  BS_QXSZ  WHERE MNAME = '报名' AND NAME = '澄清与修改' AND  MKID = 'M091030';
    if num = 1 then
      update BS_QXSZ  set qxrole = '1,2' WHERE MNAME = '报名' AND NAME = '澄清与修改' AND  MKID = 'M091030';
    end if; 
    ------cheny--报名-澄清公告---2016-10-26--end-----------------

   -- hejw start--
    num:=0;
    select count(1) into num from  bs_xtmk where mid='M0950' and sid='M00008' and mname='中标';
    if num = 1 then
	     update bs_xtmk set mname='定标' where mid='M0950' and sid='M00008' and mname='中标'; 
    end if;
   -- hejw end--

	-------------songw  投标方下载自己上传的资格预审申请文件或投标文件   2016年11月7日 --------start---------
    --资格预审文件
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/sell/ysopen' AND METHOD = 'downloadPreFile' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091092', '/exp/bidding/sell/ysopen','downloadPreFile',2,'投标方下载自己上传的资格预审申请文件',1,'M00008');
    end if;	

	--投标文件下载
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/kbqd' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
	  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('M093005','/exp/bidding/sell/kbqd','download',2,'投标方下载自己上传的投标文件',1,'M00008');
	end if;
	-------------songw  投标方下载自己上传的资格预审申请文件   2016年11月7日 --------end---------

	-----songw  增加招标人考评和代理机构考评的导出权限 2016年11月14日   start------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/zbrappraisal' AND METHOD = 'exportExcel' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013005', '/bdm/zbrappraisal','exportExcel','2','招标人考评导出','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/dljgappraisal' AND METHOD = 'exportExcel' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013010', '/bdm/dljgappraisal','exportExcel','2','代理机构考评导出','2','B00008');
    end if;

	-----songw  增加招标人考评和代理机构考评的导出权限 2016年11月14日   end------------


	------cheny-评审-查看评审汇总---2016-10-29--start-----------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/psp/judge/report' AND METHOD = 'overview' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/psp/judge/report','overview','1','查看评标汇总','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/psp/judge/report' AND METHOD = 'viewDetails' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/psp/judge/report','viewDetails','1','查看评委评标明细','1','M00009');
    end if; 
    ------cheny-评审-查看评审汇总---2016-10-29--end-----------------

	----hejw  start-------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/' AND METHOD = 'headWeb' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/','headWeb','0','招投标门户头部','1','M00008');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz WHERE sid='B00008' and mkid='B011050' and name='操作员管理员列表';
    if num = 1 then
      update BS_QXSZ  set name='印章管理' WHERE sid='B00008' and mkid='B011050' and name='操作员管理员列表';
    end if; 
	----hejw  end-------

	-- 权限明细 切换用户招投标角色 新增页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/me/home' and METHOD ='switchMenberJs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/me/home','switchMenberJs',1,'切换用户招投标角色',1,'M00008');
	end if;
	
	--add by chenxp start 投标方签章管理--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='cqhzList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','cqhzList','2','澄清回执签章列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signature/cqhzList.do') into num from bs_qxsz where sid = 'M00008' and mkid='M020020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signature/cqhzList.do') where  sid = 'M00008' and mkid='M020020';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='cqSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','cqSeal','2','澄清回执签章','1','M00008');
    end if;
	--add by chenxp end  --

	--add by chenxp start 变更--
	 --投标方
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/ysbgnotice' and method='confirm' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091070','/exp/bidding/sell/ysbgnotice','confirm','2','回执确认','1','M00008');
    end if;
    
    --招标方
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysbgnotice' and method='ysReceipt' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089050','/exp/bidding/buy/ysbgnotice','ysReceipt','2','回执查看','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/bgnotice' and method='hsReceipt' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083050','/exp/bidding/bgnotice','hsReceipt','2','回执查看','1','M00008');
    end if;
    
    --签章管理
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='bgSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','bgSeal','2','变更回执签章','1','M00008');
    end if;
	--add by chenxp end   变更--
	
	-----machuanhai-我的招投标---2016-1-28--start-----------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/home' AND METHOD = 'tbyqsbzMore' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/home','tbyqsbzMore','1','查看更多邀请书页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/home' AND METHOD = 'ccNoticeMore' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/home','ccNoticeMore','1','查看更多答疑澄清页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/home' AND METHOD = 'objectionMore' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/home','objectionMore','1','查看更多异议回复页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/home' AND METHOD = 'entrustSubpMore' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/home','entrustSubpMore','1','查看更多委托确认页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/home' AND METHOD = 'signupMore' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/home','signupMore','1','查看更多结果通知页面','1','M00008');
    end if;
	--add by machuanhai end  --
    
	--add by chenxp start 投标邀请书--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/gkys' and method='downloadReceipt' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089096','/exp/bidding/buy/gkys','downloadReceipt','2','下载回执','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='tbyqsSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','tbyqsSeal','2','投标邀请书签章','1','M00008');
    end if;
    

    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='tbyqsList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','tbyqsList','2','投标邀请书列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signature/tbyqsList.do') into num from bs_qxsz where sid = 'M00008' and mkid='M020020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signature/tbyqsList.do') where  sid = 'M00008' and mkid='M020020';
    end if;
	--add by chenxp end   投标邀请书--
	-----machuanhai-终止公告附件下载---2016-11-10--start-----------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/subp/stop/zgys' AND METHOD = 'download' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M08905005', '/exp/subp/stop/zgys','download','1','终止公告-附件下载','1','M00008');
    end if;
	--add by machuanhai end  --
	------cheny - 2016-11-10 --- 中标通知书--代理服务费------start--------------
  	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and method='toPayProxy' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M09504005','/exp/bidding/sell/hitbid/notice','toPayProxy','2','支付代理服务费','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and method='doPayProxy' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M09504005','/exp/bidding/sell/hitbid/notice','doPayProxy','2','申请支付代理费用','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and method='showContract' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M09504005','/exp/bidding/sell/hitbid/notice','showContract','2','订单查看','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/hitbid/notice/showContract.do') into num from bs_qxsz where mkid = 'M095040' and sid = 'M00008';
    if num = 0 then
         update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/notice/showContract.do') where mkid = 'M095040' and sid = 'M00008';
    end if;
    
  	------cheny - 2016-11-10 --- 中标通知书--代理服务费------end--------------
    num:=0;
    select instr(inurl,'/exp/bidding/sell/evaluate/saveEvalTend.do') into num from bs_qxsz where sid = 'M00008' and mkid='M097020';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/evaluate/saveEvalTend.do') where  sid = 'M00008' and mkid='M097020';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/evaluate/saveEvalAgency.do') into num from bs_qxsz where sid = 'M00008' and mkid='M097010';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/evaluate/saveEvalAgency.do') where  sid = 'M00008' and mkid='M097010';
    end if;
    
    
	-----machuanhai-终止公告附件下载---2016-11-14--start-----------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/subp/stop/open' AND METHOD = 'download' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084050', '/exp/subp/stop/open','download','1','终止公告-附件下载','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/subp/stop/comment' AND METHOD = 'download' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M085030', '/exp/subp/stop/comment','download','1','终止公告-附件下载','1','M00008');
    end if;
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/subp/stop/scaling' AND METHOD = 'download' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086080', '/exp/subp/stop/scaling','download','1','终止公告-附件下载','1','M00008');
    end if;
	--add by machuanhai end  --

	--add by chenxp start --
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='savekpxx' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040','/exp/bidding/sell/payment','savekpxx','2','保存开票信息','1','M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/bmqr/send' and method='ckkpInfo' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083090','/exp/bidding/buy/bmqr/send','ckkpInfo','2','查看开票信息','1','M00008');
    end if;
	--add by chenxp end   --

	--add by hejunwei start   --
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdp/build/jury' AND METHOD = 'roundDrawExpert' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040', '/bdp/build/jury','roundDrawExpert','2','组建评标委员会-专家抽取-循环抽','1','M00008');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdp/build/pre/jury' AND METHOD = 'roundDrawExpert' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040', '/bdp/build/pre/jury','roundDrawExpert','2','组建评标委员会-专家抽取-循环抽','1','M00008');
    end if; 
	--add by hejunwei end   --

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'M091070' and sid='M00008';
    if num = 1 then
         update bs_qxsz set qxrole = '1,2,3' where mkid = 'M091070' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'M091030' and sid='M00008';
    if num = 1 then
         update bs_qxsz set qxrole = '1,2,3' where mkid = 'M091030' and sid='M00008';
    end if;
    --add by chenxp end  --

    --add by hejw start  --
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and name='费用确认' and mkid='M060050';
    if num = 1 then
         update bs_qxsz set isuse=0 where sid='M00008' and name='费用确认' and mkid='M060050';
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/sell/payment' AND METHOD = 'createPrint' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040', '/exp/bidding/sell/payment','createPrint','2','费用支付-生成打印码','1','M00008');
    end if; 
    --add by hejw end  --
	--------add by songw 2016年12月3日 start------------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/payment' and METHOD ='createZfhz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060040','/exp/bidding/sell/payment','createZfhz',2,'生成支付回执',1,'M00008');
	end if;	
	--------add by songw 2016年12月3日 end------------------
	--------add by songw 2016年12月6日 start------------------
	--增加评标报告页面查看发票信息
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='ckkpInfo' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','ckkpInfo',1,'查看发票信息',1,'M00009');
	end if;	
	
	--增加评标报告评审详情查看
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/review/result' and METHOD ='showInfo' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M085010','/bdp/review/result','showInfo',2,'查看评审详情',1,'M00008');
	end if;	
	--------add by songw 2016年12月6日 end------------------
    --------add by chenyi 2016年12月6日 start----------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/client/template' and METHOD ='getVersion' and STYP=1 and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/client/template','getVersion',0,'客户端-版本获取',1,'M00008');
    end if; 
    --------add by chenyi 2016年12月6日 end------------------
	--------add by zhangzq 2016年12月7日 start----------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='switchMenberJs' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','switchMenberJs',2,'切换用户招投标角色',1,'M00008');
	end if;
	--------add by zhangzq 2016年12月7日 end------------------

    --------add by hejw 2016年12月7日 start------------------
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/market/publicfun' AND METHOD = 'getAllAreaInSm' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/market/publicfun','getAllAreaInSm','0','获取省或者市列表（前台）','1','M00008');
    end if; 
    --------add by hejw 2016年12月7日 end------------------
    
    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='ckkpInfo' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040','/exp/bidding/sell/payment','ckkpInfo','2','查看开票信息','1','M00008');
    end if;
    --add by chenxp end --

    --add by hejw start --
   num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'message' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','message','1','消息分页页面','1','M00008');
    end if;  
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'msgsl' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','msgsl','1','ajax调用-获取没有提示过的数据','1','M00008');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'msglist' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','msglist','1','ajax-调用-获取2条数据','1','M00008');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'upmsg' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','upmsg','1','ajax调用-更新单个数据为已查看','1','M00008');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'upmsgall' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','upmsgall','1','更新所有未读消息为已读','1','M00008');
    end if; 
    --add by hejw end --

    ---修改权限明细编号---------
    num:=0;
    select count(1) into num from bs_qxsz WHERE sid='M00008' and parent='M010005' and name='制作资格预审文件' and mkid='M01000530';
    if num = 1 then
      update bs_qxsz set mkid='M08901005',mid='M0890',parent='M089010' where sid='M00008' and parent='M010005' and name='制作资格预审文件' and mkid='M01000530';
    end if;  
  
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND SID = 'M00008' and mkid='M01000530' AND METHOD in ('toPsbf','savePsbf','toCkzl','saveCkzl','toSqwjgs','saveSqwjgs','toSqrxz','saveSqrxz');
    if num > 0 then
      update BS_QXMX set mkid='M08901005' where  ACTION = '/bdp/bidding/buy/preficfile' AND SID = 'M00008' and mkid='M01000530' AND METHOD in ('toPsbf','savePsbf','toCkzl','saveCkzl','toSqwjgs','saveSqwjgs','toSqrxz','saveSqrxz');
    end if;  
    ---修改权限明细编号---------

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='savekbjl' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040','/exp/bidding/buy/kb','savekbjl','2','保存开标记录','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='saveyskqjl' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040','/exp/bidding/buy/ysopen','saveyskqjl','2','保存预审开启记录','1','M00008');
    end if;
    --add by chenxp end --

	----------------- 2016-12-28 zhangzq start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='savekbjl' and sid = 'M00008';
    if num = 1 then
      update bs_qxmx  set mkid='M084010' where  action='/exp/bidding/buy/kb' and method='savekbjl' and sid = 'M00008';
    end if; 
    ----------------- 2016-12-28 zhangzq end--------------------

	---add by songw 2016年12月26日 start---------------
	--增加专家查看澄清变更公告页面
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/psp/judge/censor' AND METHOD = 'checkCqbggg' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/psp/judge/censor','checkCqbggg','1','增加专家查看澄清变更公告页面','1','M00009');
    end if; 
	---add by songw 2016年12月26日 end---------------

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='savekbjl' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='M084010' where action='/exp/bidding/buy/kb' and method='savekbjl' and sid = 'M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='saveyskqjl' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='M089090' where action='/exp/bidding/buy/ysopen' and method='saveyskqjl' and sid = 'M00008';
    end if;
    --add by chenxp end --

 --add by hejw start --
   num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'message' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','message','1','消息分页页面','1','M00009');
    end if;  
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'msgsl' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','msgsl','1','ajax调用-获取没有提示过的数据','1','M00009');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'msglist' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','msglist','1','ajax-调用-获取2条数据','1','M00009');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'upmsg' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','upmsg','1','ajax调用-更新单个数据为已查看','1','M00009');
    end if; 
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/me/msg' AND METHOD = 'upmsgall' AND SID = 'M00009';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/me/msg','upmsgall','1','更新所有未读消息为已读','1','M00009');
    end if; 
    --add by hejw end --
		
	----------------add by songw 2017年1月4日 start--------------------
	--add 增加后台评审/评标信息表
	--qxsz
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013515' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013515','B0135','平台运维报表','资格预审评审信息','/bdm/report/bidevaluation/listZgyspsxx.do'
		 ,'/bdm/report/bidevaluation/listZgyspsxx.do#/bdm/report/bidevaluation/showPsxq.do#/bdm/report/bidevaluation/showPfxq.do', 1, 300, 2, 'B00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013520' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013520','B0135','平台运维报表','评标信息','/bdm/report/bidevaluation/listPbxx.do'
		 ,'/bdm/report/bidevaluation/listPbxx.do#/bdm/report/bidevaluation/showPsxq.do#/bdm/report/bidevaluation/showPfxq.do', 1, 400, 2, 'B00008');
    end if;
	
	--qxmx
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'listZgyspsxx' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013515', '/bdm/report/bidevaluation','listZgyspsxx','2','资格预审评审信息列表','2','B00008');
    end if;
	
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'listPbxx' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013520', '/bdm/report/bidevaluation','listPbxx','2','评标信息列表','2','B00008');
    end if;
	
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'showPsxq' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013515', '/bdm/report/bidevaluation','showPsxq','2','评审详情','2','B00008');
    end if;
	
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'showPfxq' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013515', '/bdm/report/bidevaluation','showPfxq','2','评分详情','2','B00008');
    end if;
	----------------add by songw 2017年1月4日 end--------------------
	
	------------------add by songw 2017年1月9日 start----------------
	---add 增加评审/评标信息页面的评审/评标结果查看
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'showPsjg' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013515', '/bdm/report/bidevaluation','showPsjg','2','评审/评分结果','2','B00008');
    end if;
    
    --add 增加评审/评标信息页面的导出excel
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/bidevaluation' AND METHOD = 'export' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013515', '/bdm/report/bidevaluation','export','2','评审/评标信息导出excel','2','B00008');
    end if;
    
	------------------add by songw 2017年1月9日 end----------------

    --add by hejw start --
    num:=0;
    select count(1) into num from bs_qxsz WHERE SID = 'B00008' and mkid='B013525';
    if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid) 
         values('B013525', 'B0135', '平台运维报表', '招标项目开展明细', '/bdm/report/subp/list.do', '/bdm/report/subp/list.do#/bdm/report/subp/show.do', 1, 50, 2, 'B00008');
    end if;
  
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/subp' AND METHOD = 'list' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013525', '/bdm/report/subp','list','2','报表-招标项目-page分页','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/subp' AND METHOD = 'show' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013525', '/bdm/report/subp','show','2','显示招标项目详情','2','B00008');
    end if;  
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/subp' AND METHOD = 'download' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013525', '/bdm/report/subp','download','2','文件下载','2','B00008');
    end if; 
    --add by hejw end --

	---------------------add by songw 2017年1月10日 start--------
	--add 增加开标列表查看评委数字证书登记表权限
	num:=0;
    select count(1) into num from  BS_QXSZ  WHERE MNAME = '开标' AND NAME = '开标列表' AND  MKID = 'M084010';
    if num = 1 then
      update BS_QXSZ  set inurl = '/exp/bidding/buy/kb/kbPackList.do#/exp/bidding/buy/kb/packageOpen.do#/exp/bidding/buy/kb/closePack.do
	  #/exp/bidding/buy/kb/saveClosePack.do#/exp/bidding/buy/kb/addZbStopGg.do#/exp/bidding/buy/kb/saveZbStopGg.do#/exp/bidding/buy/kb/ggqz.do
	  #/exp/bidding/buy/kb/dowload.do#/exp/bidding/buy/kb/toRepair.do#/exp/bidding/buy/kb/digital.do' WHERE MNAME = '开标' AND NAME = '开标列表' AND  MKID = 'M084010';
    end if; 
    
    --add 增加资格预审文件确认下的下载资格预审文件权限
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND METHOD = 'downloadQr' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015', '/bdp/bidding/buy/preficfile','downloadQr','2','下载资格预审文件','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND METHOD = 'toDownZgyswjQr' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015', '/bdp/bidding/buy/preficfile','toDownZgyswjQr','2','跳转资格预审文件下载页面','1','M00008');
    end if;
    
    --add 增加招标文件确认页面的相关下载权限
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/buy/zbwjone' AND METHOD = 'toDownZbwjOfQr' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020', '/exp/bidding/buy/zbwjone','toDownZbwjOfQr','2','跳转招标文件下载页面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/buy/zbwjone' AND METHOD = 'downloadQr' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020', '/exp/bidding/buy/zbwjone','downloadQr','2','招标文件下载(招标文件确认页面)','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/buy/zbwjone' AND METHOD = 'download' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083015', '/exp/bidding/buy/zbwjone','download','2','招标文件下载','1','M00008');
    end if;
    
	---------------------add by songw 2017年1月10日 end--------
	
	--add by chenxp start--
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/build/jury' and method = 'doComplete' and sid= 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='M083040' where action='/bdp/build/jury' and method = 'doComplete' and sid= 'M00008';
    end if;
	--add by chenxp end  --
	
	--add by huyq 2017-01-04 start----
	--qxsz
	--项目开展明细表 权限设置
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013510' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013510','B0135','平台运维报表','项目开展明细表','/bdm/report/projectMx/listProject.do','/bdm/report/projectMx/listProject.do', 1, 10, 2, 'B00008');
    end if;
    
    --委员会信息表 权限设置
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013530' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013530','B0135','平台运维报表','委员会信息表','/bdm/report/juryInfo/listJuryInfo.do','/bdm/report/juryInfo/listJuryInfo.do', 1, 200, 2, 'B00008');
    end if;
    
    --qxmx
	--项目开展明细表 权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/projectMx' AND METHOD = 'listProject' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013510', '/bdm/report/projectMx','listProject','2','项目开展明细表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/projectMx' AND METHOD = 'listProjectItem' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013510', '/bdm/report/projectMx','listProjectItem','2','项目标的物详情','2','B00008');
    end if;
    
    --委员会信息表 权限明细
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/juryInfo' AND METHOD = 'listJuryInfo' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530', '/bdm/report/juryInfo','listJuryInfo','2','委员会信息表','2','B00008');
    end if;
    
    --委员会抽取条件详情 权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/juryInfo' AND METHOD = 'listJuryRequire' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530', '/bdm/report/juryInfo','listJuryRequire','2','委员会抽取条件详情','2','B00008');
    end if;
		
	--委员会抽取记录详情  权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/juryInfo' AND METHOD = 'listJuryRecord' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530', '/bdm/report/juryInfo','listJuryRecord','2','委员会抽取记录详情','2','B00008');
    end if;
    
    --委员会抽取结果详情  权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/juryInfo' AND METHOD = 'listJuryResult' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530', '/bdm/report/juryInfo','listJuryResult','2','委员会抽取结果详情','2','B00008');
    end if;
    
    --评委签到和评审详情  权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/juryInfo' AND METHOD = 'listJuryCensor' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530', '/bdm/report/juryInfo','listJuryCensor','2','评委签到和评审详情','2','B00008');
    end if;
    
    --end by huyq 2017-01-04 end----
    ------add by songw 2017年1月12日  start------------
    --修改权限名称用以区分预审和后审的招标文件购买
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'M091025' and sid='M00008';
    if num = 1 then
         update bs_qxsz set name = '招标文件购买' where mkid = 'M091025' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'M091035' and sid='M00008';
    if num = 1 then
         update bs_qxsz set name = '招标文件购买' where mkid = 'M091035' and sid='M00008';
    end if;
    
    --增加会员账户页面查看开票详情权限
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/account' AND METHOD = 'ckkpInfo' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020', '/exp/bidding/account','ckkpInfo','2','查看开票详情','1','M00008');
    end if;
    ------add by songw 2017年1月12日  end------------

    --add by chenxp start 标段包明细--
    num:=0;
    select count(1) into num from bs_xtmk where  mid='B0135' and sid = 'B00008';
    if num = 0 then
         insert into bs_xtmk(mid,mname,styp,ordby,sid) 
         values('B0135','平台运维报表','2',380,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B013505' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B013505','B0135','平台运维报表','标段（包）执行明细','/bdm/report/bdpack/list.do','/bdm/report/bdpack/list.do','1',100,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'list' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','list','2','标段包明细列表','2','B00008');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'yswjinfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','yswjinfo','2','查看预审文件详情','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/yswjinfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/yswjinfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'ysbminfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','ysbminfo','2','查看预审文件报名及购买情况','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/ysbminfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/ysbminfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'yskqinfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','yskqinfo','2','申请人开启记录确认情况','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/yskqinfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/yskqinfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'ysjginfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','ysjginfo','2','资格预审结果','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/ysjginfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/ysjginfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'zbwjinfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','zbwjinfo','2','查看招标文件','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/zbwjinfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/zbwjinfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'zbbminfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','zbbminfo','2','投标人报名及文件购买情况','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/zbbminfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/zbbminfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'bzjinfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','bzjinfo','2','投标保证金缴纳情况','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/bzjinfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/bzjinfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'kbjlinfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','kbjlinfo','2','投标人签到及开标记录确认情况','2','B00008');
    end if; 
    
    num:=0;
    select instr(inurl,'/bdm/report/bdpack/kbjlinfo.do') into num from bs_qxsz where sid = 'B00008' and mkid='B013505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/report/bdpack/kbjlinfo.do') where  sid = 'B00008' and mkid='B013505';
    end if;
    --add by chenxp end 标段包明细----

    --add by chenxp start 邀请单位--
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'hsPackList' and sid= 'M00008';
    if num = 0 then
         update bs_qxmx set mkid='M082025' where action='/exp/bidding/buy/yqhs' and method = 'hsPackList';
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'invitationUnit' and sid= 'M00008';
    if num = 0 then
         update bs_qxmx set mkid='M082025' where action='/exp/bidding/buy/yqhs' and method = 'invitationUnit';
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'saveInvitation' and sid= 'M00008';
    if num = 0 then
         update bs_qxmx set mkid='M082025' where action='/exp/bidding/buy/yqhs' and method = 'saveInvitation';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'invitationInfor' and sid= 'M00008';
    if num = 0 then
         update bs_qxmx set mkid='M082025' where action='/exp/bidding/buy/yqhs' and method = 'invitationInfor';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'delInvitation' and sid= 'M00008';
    if num = 0 then
         update bs_qxmx set mkid='M082025' where action='/exp/bidding/buy/yqhs' and method = 'delInvitation';
    end if;
    
   num:=0;
   select count(1) into num from bs_qxsz where mkid='M081050'and sid= 'M00008';
   if num = 1 then
         update bs_qxsz set name='招标项目' where mkid='M081050'and sid= 'M00008';
   end if;
   
   num:=0;
   select count(1) into num from bs_qxsz where mkid='M081025'and sid= 'M00008';
   if num = 1 then
         update bs_qxsz set name='招标项目' where mkid='M081025'and sid= 'M00008';
   end if;
    --add by chenxp end   邀请单位--

    --add by chenxp start 保证金提现--
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B010045' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B010045','B0100','基本设置','保证金提现设置','/admin/basesetup/bond/list.do','/admin/basesetup/bond/list.do','1',3000,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/admin/basesetup/bond' and method = 'list' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010045','/admin/basesetup/bond','list','2','会员列表','2','B00008');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/admin/basesetup/bond' and method = 'saveBond' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010045','/admin/basesetup/bond','saveBond','2','保存保证金提现设置','2','B00008');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/admin/basesetup/bond' and method = 'editbond' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010045','/admin/basesetup/bond','editbond','2','修改保证金提现设置','2','B00008');
    end if;
    
    
    num:=0;
    select instr(inurl,'/admin/basesetup/bond/editbond.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010045';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/admin/basesetup/bond/editbond.do') where  sid = 'B00008' and mkid='B010045';
    end if;
    --add by chenxp end 保证金提现--

    ---add by songw 2017年1月13日 start------------
    --add 增加后审流程招标文件购买页面，招标文件下载权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and method = 'toDownPageZbHs' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091035','/exp/bidding/sell/signup','toDownPageZbHs','2','后审流程-招标文件购买页面跳转招标文件下载列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and method = 'downloadHs' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091035','/exp/bidding/sell/signup','downloadHs','2','后审流程-招标文件购买页面招标文件下载','1','M00008');
    end if;
    
    ---add by songw 2017年1月13日 end------------

    --------------add by songw 2017年1月16日 start----------------
    --调整中标通知书和招标结果通知书的编辑权限从定标改为结果发布
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/scaling' and method='toGcTzs' and sid = 'M00008';
    if num = 1 then
      update bs_qxmx  set mkid='M086050' where  action='/exp/bidding/buy/scaling' and method='toGcTzs' and sid = 'M00008';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/scaling' and method='toHwTzs' and sid = 'M00008';
    if num = 1 then
      update bs_qxmx  set mkid='M086050' where  action='/exp/bidding/buy/scaling' and method='toHwTzs' and sid = 'M00008';
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/scaling' and method='toJgTzs' and sid = 'M00008';
    if num = 1 then
      update bs_qxmx  set mkid='M086050' where  action='/exp/bidding/buy/scaling' and method='toJgTzs' and sid = 'M00008';
    end if; 
    
    --------------add by songw 2017年1月16日 end----------------

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/kb' and method = 'gettbfsl' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010','/exp/bidding/buy/kb','gettbfsl','2','获取投标方数量','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/kb' and method = 'decode' and sid= 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='M084010', accesstag ='2' where  action='/exp/bidding/buy/kb' and method = 'decode' and sid= 'M00008';
    end if;
    --add by chenxp end----

   --add by hejw start----
    num:=0;
        select count(1) into num from bs_qxmx where mkid = 'B013530' and sid = 'B00008' and action = '/bdm/report/juryInfo' and method = 'isAttendList';
    if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
            values('B013530', '/bdm/report/juryInfo', 'isAttendList', '2', '回复出席的专家数据 list', '2' , 'B00008');
    end if;
 
    num:=0;
        select count(1) into num from bs_qxmx where mkid = 'B013530' and sid = 'B00008' and action = '/bdm/report/juryInfo' and method = 'upAttend';
    if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
            values('B013530', '/bdm/report/juryInfo', 'upAttend', '2', '修改数据为临时不出席', '2' , 'B00008');
    end if;  
    --add by hejw end----

    ------------------add by songw 2017年1月18日 start------------
    --add 增加评审平台委员会主任终止评标权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'index' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','index','1','查看终止评审/评标报告页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'toEdit' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','toEdit','1','终止评审/评标报告编辑页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'submit' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','submit','1','委员会主任提交终止评审/评标报告','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'withdraw' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','withdraw','1','委员会主任撤回终止评审/评标报告','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'confirmInvalid' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','confirmInvalid','1','其他专家确认终止评审/评标报告页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'save' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','save','1','保存终止评审/评标报告信息','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'download' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','download','1','下载终止报告附件','1','M00009');
    end if;
    
    ------------------add by songw 2017年1月18日 end--------------
	
	--add by huyq 20170120 start-----
	--项目开展明细表 权限明细 附件下载
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/report/projectMx' AND METHOD = 'dowloadBdwFile' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013510', '/bdm/report/projectMx','dowloadBdwFile','2','附件下载','2','B00008');
    end if;
    --add by huyq 20170120 end-----

    -----------------add by songw 2017年1月20日 start----------------
    --增加我的招投标页面-招标管理-资料归档功能
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='M030050' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('M030050','M0300','招标管理','资料归档','/exp/bidding/buy/archiving/list.do','/exp/bidding/buy/archiving/list.do#/exp/bidding/buy/archiving/check.do#/exp/bidding/buy/archiving/viewChangeNotice.do','1',500,1,'M00008');
    end if;
    
    --增加资料归档莫款相关权限明细
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/archiving' and method = 'list' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/archiving','list','2','资料归档标段包列表','1','M00008');
    end if;
      
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/archiving' and method = 'check' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/archiving','check','2','查看该标段包资料归档信息','1','M00008');
    end if;
      
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/archiving' and method = 'download' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/archiving','download','2','资料归档模块相关下载权限','1','M00008');
    end if;
      
    -----------------add by songw 2017年1月20日 end----------------
    
    -------------------add by hejw 2017年2月5日 start---------------
    num:=0;
        select count(1) into num from bs_qxmx where mkid = 'M030050' and sid = 'M00008' and action = '/exp/bidding/buy/archiving' and method = 'createpdf';
    if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
            values('M030050', '/exp/bidding/buy/archiving', 'createpdf', '2', '生成一个pdf', '1' , 'M00008');
    end if;
    
    num:=0;
        select count(1) into num from bs_qxsz where sid='B00008' and mkid='B013505' and name!='标段(包)执行明细' ;
    if num = 1 then
        update bs_qxsz set name='标段(包)执行明细' where sid='B00008' and mkid='B013505' and name!='标段(包)执行明细' ;
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/' and method = 'showZbggToTd' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','showZbggToTd','0','采购cms显示招标公告','1','M00008');
    end if;
    
	-------------------add by hejw 2017年2月5日 end---------------

    
    -------------------add by songw 2017年2月4日 start---------------
    --add 增加资金流水导出excel权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bondaccount' and method = 'export' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060030','/exp/bidding/bondaccount','export','2','资金流水导出到excel文件权限','1','M00008');
    end if;
    -------------------add by songw 2017年2月4日 end---------------

    -------------------add by songw 2017年2月5日 start----------------
    --add 增加资料归档 更改通知tab页面的相关权限明细
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/archiving' and method = 'viewChangeNotice' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/archiving','viewChangeNotice','2','查看更改通知公告页面','1','M00008');
    end if;
    -------------------add by songw 2017年2月5日 end----------------
    
    ------------------add by songw 2017年2月8日 start-----------------
    --add 增加会员账户流水页面，代理机构查看入金流水备注权限
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/account' AND METHOD = 'ckrjlsbz' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020', '/exp/bidding/account','ckrjlsbz','2','查看入金流水备注信息','1','M00008');
    end if;
    
    --add 增加代理机构保存入金流水备注信息权限
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/exp/bidding/account' AND METHOD = 'saverjlsbz' AND SID = 'M00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020', '/exp/bidding/account','saverjlsbz','2','修改保存入金流水备注信息','1','M00008');
    end if;
    ------------------add by songw 2017年2月8日 end-----------------

    --add by chenxp start--
    num:=0;
    select instr(inurl,'/exp/bidding/buy/aftfic/doSave.do') into num from bs_qxsz where sid = 'M00008' and mkid='M082010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/aftfic/doSave.do') where  sid = 'M00008' and mkid='M082010';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/aftfic/updateGgbz.do') into num from bs_qxsz where sid = 'M00008' and mkid='M082010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/aftfic/updateGgbz.do') where  sid = 'M00008' and mkid='M082010';
    end if;
    --add by chenxp end  --

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and method = 'saveImportFile' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081020','/exp/bidding/buy/project','saveImportFile','2','保存导入的采购清单','1','M00008');
    end if;
    --add by chenxp end----

    --add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/zbwjone' and method = 'toConfirmShyj' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020','/exp/bidding/buy/zbwjone','toConfirmShyj','2','招标方文件确认-审核意见页面','1','M00008');
    end if; 
    --add by chenxp end ---

    --add by chenxp start 20170216--
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method = 'downloadtzs' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086050','/exp/bidding/buy/scaling','downloadtzs','2','通知书下载','1','M00008');
    end if; 
    --add by chenxp end  20170216--
    
    --------------add by songw 2017年2月20日 start----------------
    --调整评委信息维护页面若报错仍停留在本页面而不是标段包页面
    num:=0;
    select instr(inurl,'/bdp/mtcfee/expert/update.do') into num from bs_qxsz where sid = 'M00008' and mkid='M085020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdp/mtcfee/expert/update.do') where  sid = 'M00008' and mkid='M085020';
    end if;
    
    --------------add by songw 2017年2月20日 end----------------

	--add by huyq 2017-02-21 start----
	--代理机构后台管理，进行排序
	--qxsz
	--代理机构管理  权限设置
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B010050' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B010050','B0100','基本设置','代理机构管理','/bdm/basesetup/agent/listAgent.do','/bdm/basesetup/agent/listAgent.do#/bdm/basesetup/agent/adjustOrder.do', 1, 3500, 2, 'B00008');
    end if;       
    
    --qxmx
	--代理机构信息列表  权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/basesetup/agent' AND METHOD = 'listAgent' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent','listAgent','2','代理机构信息列表','2','B00008');
    end if;  
    
    --qxmx
	--代理机构排序调节  权限明细
	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/basesetup/agent' AND METHOD = 'adjustOrder' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent','adjustOrder','2','代理机构排序调节','2','B00008');
    end if;  
    
    --end by huyq 2017-02-21 end----
    
    ------------add by songw 2017年2月22日 start----------------
    --调整终止公告访问级别问需要业务模块权限才能访问
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/subp/stop/send' and mkid='M08305005' and sid = 'M00008' and accesstag = 1;
    if num > 0 then
      update bs_qxmx  set accesstag=2 where  action='/exp/subp/stop/send' and mkid='M08305005' and sid = 'M00008' and accesstag = 1;
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/subp/stop/zgys' and mkid='M08905005' and sid = 'M00008' and accesstag = 1;
    if num > 0 then
      update bs_qxmx  set accesstag=2 where  action='/exp/subp/stop/zgys' and mkid='M08905005' and sid = 'M00008' and accesstag = 1;
    end if; 
    
    --将投标方资格预审申请文件的递交、撤回和下载回执的权限从费用支付（业务）移至 资格预审申请文件上传中
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='deliver' and sid = 'M00008' and mkid='M091040';
    if num = 1 then
         update bs_qxmx set mkid='M091026' where action='/exp/bidding/sell/signup' and method='deliver' and sid = 'M00008' and mkid='M091040';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='revokeYswj' and sid = 'M00008' and mkid='M091040';
    if num = 1 then
         update bs_qxmx set mkid='M091026' where action='/exp/bidding/sell/signup' and method='revokeYswj' and sid = 'M00008' and mkid='M091040';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='ysReceipt' and sid = 'M00008' and mkid='M091040';
    if num = 1 then
         update bs_qxmx set mkid='M091026' where action='/exp/bidding/sell/signup' and method='ysReceipt' and sid = 'M00008' and mkid='M091040';
    end if;
    
    ------------add by songw 2017年2月22日 end----------------

    --add by chenxp start  群发短信--
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='B010315' and sid = 'B00002';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B010315','B0103','短信队列','群发短信','/smsm/sms/mass/list.do','/smsm/sms/mass/list.do','1',300,2,'B00002');
    end if;
       
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'list' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','list','2','群发短信列表','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'toAddSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','toAddSms','2','新增群发短信','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'saveSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','saveSms','2','保存群发短信','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'toEditSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','toEditSms','2','编辑群发短信','2','B00002');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'updateSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','updateSms','2','修改群发短信','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'sendSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','sendSms','2','发送短信','2','B00002');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'importAddSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','importAddSms','2','导入表格新增短信','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'delSms' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','delSms','2','删除短信','2','B00002');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/smsm/sms/mass' and method = 'searchQxInfo' and sid= 'B00002';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/smsm/sms/mass','searchQxInfo','2','查询权限组信息','2','B00002');
    end if;
    --add by chenxp end    群发短信--
	
	---add by huyq 2017-03-07 for 公告预览-----
	--增加资格预审公告预览  权限明细
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/prefic' and method = 'ggYulan' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089005','/exp/bidding/buy/prefic','ggYulan','2','资格预审公告预览','1','M00008');
    end if;
    
    --预审权限明细增加到inurl里面去
    num:=0;
    select instr(inurl,'/exp/bidding/buy/prefic/ggYulan.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089005';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/prefic/ggYulan.do') where  sid = 'M00008' and mkid='M089005';
    end if;
    
    --增加后审公告预览  权限明细
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/aftfic' and method = 'hsGgYulan' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M082010','/exp/bidding/buy/aftfic','hsGgYulan','2','后审公告预览','1','M00008');
    end if;
    
    --后审权限明细增加到inurl里面去
    num:=0;
    select instr(inurl,'/exp/bidding/buy/aftfic/hsGgYulan.do') into num from bs_qxsz where sid = 'M00008' and mkid='M082010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/aftfic/hsGgYulan.do') where  sid = 'M00008' and mkid='M082010';
    end if;
    
    --增加邀请书编制预览  权限明细
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and method = 'yqsYulan' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M082035','/exp/bidding/buy/yqhs','yqsYulan','2','邀请书预览','1','M00008');
    end if;
    
    --邀请书权限明细增加到inurl里面去
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/yqsYulan.do') into num from bs_qxsz where sid = 'M00008' and mkid='M082035';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/yqsYulan.do') where  sid = 'M00008' and mkid='M082035';
    end if;
    
    ---end by huyq 2017-03-07 for 公告预览-----

    ---------add by songw 2017年3月7日 start--------------
    --增加评委数字证书使用登记报pdf导出权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/kb' and method = 'createPdf' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010315','/exp/bidding/buy/kb','createPdf','2','评委数字证书使用登记表-pdf导出','1','M00008');
    end if;
    ---------add by songw 2017年3月7日 end--------------
    
    ----------------add by songw 2017年3月15日 start--------------------------
    ---增加会员账户资金流水导出
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/account' and method = 'export' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020','/exp/bidding/account','export','2','资金流水导出到excel文件权限','1','M00008');
    end if;
    ----------------add by songw 2017年3月15日 end--------------------------
    
    -----------------add by songw 2017年3月16日 start---------------------------
    --修改评委数字证书使用登记表-pdf导出的mkid
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='createPdf' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='M084010' where action='/exp/bidding/buy/kb' and method='createPdf' and sid = 'M00008';
    end if;
    
    --增加资格预审开启列表节点查看导出评委数字证书使用登记表
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and method = 'pwszzssydjb' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090','/exp/bidding/buy/ysopen','pwszzssydjb','2','评委数字证书使用登记表查看页面','1','M00008');
    end if;
    
    --评委数字证书使用登记表查看权限明细增加到inurl里面去
    num:=0;
    select instr(inurl,'/exp/bidding/buy/ysopen/pwszzssydjb.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089090';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/ysopen/pwszzssydjb.do') where  sid = 'M00008' and mkid='M089090';
    end if;
    
    --增加评委数字证书使用登记表pdf导出权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and method = 'createPdf' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090','/exp/bidding/buy/ysopen','createPdf','2','评委数字证书使用登记表-PDF导出','1','M00008');
    end if;
    
    --开标列表-评委数字证书使用登记表excel导出权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/kb' and method = 'exportExcel' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010','/exp/bidding/buy/kb','exportExcel','2','评委数字证书使用登记表-Excel导出','1','M00008');
    end if;
    -----------------add by songw 2017年3月16日 end---------------------------
	
	--add by chenxp start--
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'zbhxrInfo' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','zbhxrInfo','2','中标候选人情况','2','B00008');
    end if; 
	--add by chenxp end  --

    ------------------add by songw 2017年3月22日 start---------------------------
    --add 增加招标方评标结果页面查看专家与投标人提问与回复权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/review/result' and method = 'checkQuestionAndReply' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M085010','/bdp/review/result','checkQuestionAndReply','2','查看专家与投标方提问与回复','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/bdp/review/result/checkQuestionAndReply.do') into num from bs_qxsz where sid = 'M00008' and mkid='M085010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdp/review/result/checkQuestionAndReply.do') where  sid = 'M00008' and mkid='M085010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/review/result' and method = 'exportPdf' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M085010','/bdp/review/result','exportPdf','2','导出pdf','1','M00008');
    end if;   
    ------------------add by songw 2017年3月22日 end-----------------------------

    ------------------add by songw 2017年3月23日 start---------------------------
    --add 投标方查看投标保证金回执权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bidbond/pay' and method = 'checkBidBondReceipt' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020','/exp/bidding/sell/bidbond/pay','checkBidBondReceipt','2','查看投标保证金回执（保证金流水回执）','1','M00008');
    end if;     
      
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bidbond/pay' and method = 'createReceipt' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020','/exp/bidding/sell/bidbond/pay','createReceipt','2','生成投标保证金回执（保证金流水回执）','1','M00008');
    end if;     
      
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bidbond/pay' and method = 'download' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020','/exp/bidding/sell/bidbond/pay','download','2','下载方法','1','M00008');
    end if;     
      
    ------------------add by songw 2017年3月23日 end---------------------------
	
	--add by chenxp start--
	num:=0;
    select instr(inurl,'/exp/bidding/buy/project/addMatter.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/project/addMatter.do') where  sid = 'M00008' and mkid='M081020';
    end if;
	--add by chenxp end ---
    
    ---------------add by songw 2017年3月29日 start--------------
    --add 增加生成终止评审、评标报告权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'stopBiddingReport' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','stopBiddingReport','1','生成终止报告','1','M00009');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'sealConfirm' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','sealConfirm','1','专家确认提交终止报告','1','M00009');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'sendReport' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','sendReport','1','主任发送终止报告给其他专家','1','M00009');
    end if;  
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/invalid' and method = 'createPdf' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/invalid','createPdf','1','生成终止报告pdf','1','M00009');
    end if;  
    
    ---------------add by songw 2017年3月29日 end--------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='ceshi' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01050505','/bdm/expert','ceshi',2,'专家管理-初始化使用','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/evaluation' and method='toExport' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B012005','/bdm/evaluation','toExport',2,'评价管理-导出','2','B00008');
    end if;

	--add by chenxp start--
	num:=0;
    select count(1) into num from bs_qxmx where action='/psp/judge/jbropen/kb' and method = 'psIndex' and sid= 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','psIndex','1','查看评标报告列表','1','M00009');
    end if; 
    --add by chenxp end ---

    --add by hejw start -----
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/build/jury' and method = 'gbunit' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','gbunit','2','组建评标委员会-验证规避单位','1','M00008');
    end if; 

    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and method = 'gbunit' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040','/bdp/build/pre/jury','gbunit','2','组建资格预审委员会-验证规避单位','1','M00008');
    end if; 
    --add by hejw end -----

	--add by chenxp start--
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and method = 'checkExtbillno' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M087010','/exp/bidding/buy/contract','checkExtbillno','2','ajax验证外部合同号是否唯一','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and method = 'checkExtbillno' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096010','/exp/bidding/sell/contract','checkExtbillno','2','ajax验证外部合同号是否唯一','1','M00008');
    end if;
	--add by chenxp end ---

    -------------add by songw 2017年4月12日 start-------------
    --监管系统回调通知
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/lug/fund' and method = 'callback' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/lug/fund','callback','0','监管系统回调通知','1','M00008');
    end if;
    -------------add by songw 2017年4月12日 end-------------

    ---------------add by songw 2017年4月12日 start---------------
    --add 增加招标项目停用相关权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/disablePro' and method = 'addBlockProReason' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','addBlockProReason','2','编辑招标项目停用理由','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/disablePro' and method = 'checkBlockProReason' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','checkBlockProReason','2','查看招标项目停用理由','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/disablePro' and method = 'download' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','download','2','下载招标项目停用理由附件','1','M00008');
    end if;
    ---------------add by songw 2017年4月12日 end---------------
    
    -----------------add by songw 2017年4月13日 start---------
    --add 后台平台运维报表导出excel相关权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/projectMx' and method = 'export' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013510','/bdm/report/projectMx','export','2','项目开展明细表导出excel','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/subp' and method = 'export' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013525','/bdm/report/subp','export','2','招标项目开展明细表导出excel','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/bdpack' and method = 'export' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','export','2','标段（包）执行明细表导出excel','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/report/juryInfo' and method = 'export' and sid= 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530','/bdm/report/juryInfo','export','2','委员会信息表导出excel','2','B00008');
    end if;
    
    -----------------add by songw 2017年4月13日 end---------

    --------------add by songw 2017年4月18日 start------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/payment' and method = 'continueTask' and sid= 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040','/exp/bidding/sell/payment','continueTask','2','费用支付-对购买招标文件费用已完成的订单可继续任务跳转值文件下载页面','1','M00008');
    end if;
    --------------add by songw 2017年4月18日 end------------


    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
