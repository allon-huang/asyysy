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
	------------add by lijb 2017年12月11日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toInvoiceEdit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toInvoiceEdit','2','跳转到发票维护页面','2','B00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='saveInvoice' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','saveInvoice','2','保存发票信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toPlkp' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toPlkp','2','批量开票','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toExport' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toExport','2','导出发票信息','2','B00008');
    end if;
    ------------add by lijb 2017年12月11日end-----------------

    ------------add by hejw 2017年12月13日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='specialAudit' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025','/exp/bidding/buy/subproject','specialAudit','2','小额招标-提交申请','1','M00008');
    end if;
    ------------add by hejw 2017年12月13日end-----------------
	
	------------add by lijb 2017年12月11日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='printSendOut' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','printSendOut','2','打印快递单','2','B00008');
    end if;
	
	------------add by lijb 2017年12月11日end-----------------
	------------add by zhaoy 2017年12月12日start-----------------
	num:=0;
	select count(1) into num from bs_qxsz where mid='B0110' and mkid='B011080' and sid='B00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,subsystem)
		values('B011080','B0110','招标管理','小额/特殊招标审核','/bdm/xetszb/list.do','/bdm/xetszb/list.do',1,800,2,''，'B00008','S00000');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/xetszb' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011080','/bdm/xetszb','list','2','小额特殊招标列表','2','B00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/xetszb' and method='auditXetszbgg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011080','/bdm/xetszb','auditXetszbgg','2','小额特殊招标审核页面','2','B00008');
    end if;
    
    	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/xetszb' and method='examineXetszbgg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011080','/bdm/xetszb','examineXetszbgg','2','小额特殊招标审核','2','B00008');
    end if;
    
    	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/xetszb' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011080','/bdm/xetszb','download','2','小额特殊招标附件下载','2','B00008');
    end if;
	------------add by zhaoy 2017年12月12日end-----------------
	------------add by zhaoy 2017年12月13日start-----------------
	--修改资格预审审核排序字段
    num:=0;
    select count(1) into num from bs_qxsz where  url='/bdm/prefic/list.do' and mid='B0110' and sid = 'B00008';
    if num = 1 then
         update bs_qxsz set orderno=770 where url='/bdm/prefic/list.do' and mid='B0110' and sid = 'B00008';
    end if;
	------------add by zhaoy 2017年12月13日end-----------------
	
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='M087020' and mid='M0870' and sid = 'M00008' and isuse = '1';
    if num = 1 then
         update bs_qxsz set isuse='0' where mkid='M087020' and mid='M0870' and sid = 'M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='M096020' and mid='M0960' and sid = 'M00008' and isuse = '1';
    if num = 1 then
         update bs_qxsz set isuse='0' where mkid='M096020' and mid='M0960' and sid = 'M00008';
    end if;
    
	------------add by zhaoy 2017年12月14日start-----------------
	--非依法必招权限
	
 	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/basesetup/csszstandard' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010005','/bdm/basesetup/csszstandard','list','2','非依法必招参数设置列表','2','B00008');
    end if;
    
 	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/basesetup/csszstandard' and method='update' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010005','/bdm/basesetup/csszstandard','update','2','非依法必招参数设置修改','2','B00008');
    end if;
	------------add by zhaoy 2017年12月14日end-----------------	
	
		----------add by zhangzq on 2017.12.19 start----------------
	 --------------标段（包）统计报表
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B015015' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,subSystem) 
         values('B015015','B0150','平台统计报表','标段（包）统计报表','/bdm/count/package/list.do','/bdm/count/package/list.do', 1, 10, 2, 'B00008', 'S00000');
    end if;

	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/package' AND METHOD = 'list' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015015', '/bdm/count/package','list','2','标段（包）统计报表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/package' AND METHOD = 'export' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015015', '/bdm/count/package','export','2','标段（包）统计报表-导出','2','B00008');
    end if;
	
	--------------招标单位统计报表
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B015020' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,subSystem) 
         values('B015020','B0150','平台统计报表','招标单位统计报表','/bdm/count/tenderee/list.do','/bdm/count/tenderee/list.do', 1, 20, 2, 'B00008', 'S00000');
    end if;

	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/tenderee' AND METHOD = 'list' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015020', '/bdm/count/tenderee','list','2','招标单位统计报表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/tenderee' AND METHOD = 'export' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015020', '/bdm/count/tenderee','export','2','招标单位统计报表-导出','2','B00008');
    end if;
	----------add by zhangzq on 2017.12.19 end------------------
	
    ------------add by hejw 2017-12-18 start---------
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/httpback' and method='decode' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/httpback','decode','1','测试解密入口','1','M00008');
    end if;
    ------------add by hejw 2017-12-18 end---------
	------------add by jinyanhui 2017-12-22 start---------
  num:=0;
  select count(1) into num from bs_qxsz where mkid='B010005' and sid='B00008' and mid='B0100' and instr(inurl,'/bdm/basesetup/csszstandard/list.do')>0;
  if num=0 then
    update bs_qxsz set inurl=concat(inurl,'#/bdm/basesetup/csszstandard/list.do') where  mkid='B010005' and sid='B00008' and mid='B0100';
  end if;
	 ------------add by jinyanhui 2017-12-22 end---------
	------------add by lijb 2017年12月25日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='toVideoLearn' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','toVideoLearn','1','跳转到在线视频学习','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='videoLearn' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','videoLearn','1','在线视频学习','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='videoComplete' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','videoComplete','1','视频学习完成','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='videoSubmit' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','videoSubmit','1','视频页面提交资料','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='toLeaveExpert' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','toLeaveExpert','1','跳转到请假页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='leave' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','leave','1','提交请假信息','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='revokeLeave' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','revokeLeave','1','撤销请假','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/reg/expert' and method='toCondition' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/reg/expert','toCondition','0','专家入库条件弹窗','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zlogin' and method='expertCondition' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zlogin','expertCondition','0','是否同意专家入库条件','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zlogin' and method='regLogin' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zlogin','regLogin','0','注册后直接登陆','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0105' and mkid='B010515' and sid='B00008';
    if num = 0 then
      insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,subsystem)
      values('B010515','B0105','专家管理','待启用专家管理','/bdm/expertZj/dqyList.do','/bdm/expertZj/dqyList.do#/bdm/expert/toImportExpert.do#',1,1200,2,''，'B00008','S00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0105' and mkid='B010520' and sid='B00008';
    if num = 0 then
      insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,subsystem)
      values('B010520','B0105','专家管理','备选/黑名单管理','/bdm/expertZj/blacklist.do','/bdm/expertZj/blacklist.do#',1,1400,2,''，'B00008','S00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='dqyList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010515','/bdm/expertZj','dqyList','2','待启用专家管理列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='enable' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010515','/bdm/expertZj','enable','2','待启用专家管理-启用','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='blacklist' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010520','/bdm/expertZj','blacklist','2','跳转到专家黑名单列表','2','B00008');
    end if;
  
    num:=0;
        select  count(1) into num from bs_qxsz where sid = 'B00008' and mkid='B010505' and mid='B0105';
    if num = 1 then
       update bs_qxsz set inurl='/bdm/expert/list.do#/bdm/expert/toAdd.do#/bdm/expert/toEdit.do#/bdm/expert/qyzj.do#/bdm/expert/doImportExpert.do#/bdm/expert/exportError.do' where  sid = 'B00008' and mkid='B010505' and mid='B0105';
    end if;
  ------------add by lijb 2017年12月25日end-----------------
	-----------add by lijb 2017年12月26日start-----------------
	num:=0;
    select count(1) into num from bs_qxsz where mkid='B010505' and sid = 'B00008';
    if num = 1 then
         update bs_qxsz set name='专家库管理' where mkid='B010505' and sid = 'B00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='B010510' and sid = 'B00008';
    if num = 1 then
         update bs_qxsz set name='待审核专家管理' where mkid='B010510' and sid = 'B00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='pullBlack' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdm/expertZj','pullBlack','1','将专家拉入黑名单','2','B00008');
    end if;
    -----------add by lijb 2017年12月26日end-----------------
	------------add by zhangzq 2017-12-27 start---------
	  num:=0;
	  select count(1) into num from bs_qxsz where mkid='B015015' and sid='B00008' and name='标段（包）统计报表';
	  if num=1 then
	    update bs_qxsz set name='标段(包)统计报表' where  mkid='B015015' and sid='B00008' and name='标段（包）统计报表';
	  end if;
	 ------------add by zhangzq 2017-12-27 end---------
	-----------add by jinyanhui 2017年12月28日start-----------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZbgg' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZbgg','1','批量生成招标公告pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createDzgtzs' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createDzgtzs','1','批量生成代资格通知书pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createTbyqs' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createTbyqs','1','批量生成投标邀请书pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createHxrgs' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createHxrgs','1','批量生成候选人公示pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZbjggg' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZbjggg','1','批量生成中标结果公告pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createRecord' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createRecord','1','批量生成开标记录pdf','1','M00008');
	end if;
	-----------add by jinyanhui 2017年12月28日end-----------------
	-----------add by lijb 2017年12月28日start-----------------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='relieveBlack' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010520','/bdm/expertZj','relieveBlack','2','解除黑名单','2','B00008');
    end if;
	-----------add by lijb 2017年12月28日end-----------------
	-----------add by zhaoy 2017年01月08日start-----------------
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createYsjl' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createYsjl','1','批量生成预审开启记录pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZbwjgm' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZbwjgm','1','批量生成招标文件购买pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZbyc' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZbyc','1','批量生成招标异常pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createTktz' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createTktz','1','批量生成踏勘通知pdf','1','M00008');
	end if;
		
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createTkjl' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createTkjl','1','批量生成踏勘记录pdf','1','M00008');
	end if;
		
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createTbbzjjs' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createTbbzjjs','1','批量生成投标保证金接收pdf','1','M00008');
	end if;
		
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createTbwjjs' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createTbwjjs','1','批量生成投标文件接收pdf','1','M00008');
	end if;
		
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createKqjl' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createKqjl','1','批量生成开启记录pdf','1','M00008');
	end if;
	-----------add by zhaoy 2017年01月08日end-----------------
	-----------add by lijb 2018年01月08日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='showimg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010510','/bdm/expertZj','showimg','2','自荐专家管理-查看附件','2','B00008');
    end if;
	-----------add by lijb 2018年01月08日end-----------------
	-----------add by lijb 2018年01月10日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='reset' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','reset','1','重置','1','M00009');
    end if;
	-----------add by lijb 2018年01月10日end-----------------
	-----------add by zhaoy 2017年01月11日start-----------------
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0890' and mkid='M089080' and sid='M00008' and mname='资格预审' and url='/exp/bidding/buy/bmqr/packageList.do';
	if num = 0 then
		update bs_qxsz set url='/exp/bidding/buy/bmqr/packageList.do',inurl='/exp/bidding/buy/bmqr/paylist.do#/exp/bidding/buy/bmqr/checkBm.do#/exp/bidding/buy/bmqr/confirm.do#/exp/bidding/buy/bmqr/refuse.do#/exp/bidding/buy/bmqr/paylist.do#/exp/bidding/buy/bmqr/expertSign.do#/exp/bidding/buy/bmqr/expertPay.do'  
		where mname='资格预审' and mid='M0890' and sid = 'M00008' and mkid = 'M089080';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bmqr' and method='packageList' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('M089080','/exp/bidding/buy/bmqr','packageList','2','预审文件购买过渡','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083090' and sid='M00008' and mname='发标' and url='/exp/bidding/buy/bmqr/send/zbpackageList.do';
	if num = 0 then
		update bs_qxsz set url='/exp/bidding/buy/bmqr/send/zbpackageList.do',inurl='/exp/bidding/buy/bmqr/send/sendPaylist.do#/exp/bidding/buy/bmqr/send/sendCheckBm.do#/exp/bidding/buy/bmqr/send/sendConfirm.do#/exp/bidding/buy/bmqr/send/sendRefuse.do#/exp/bidding/buy/bmqr/send/sendPaylist.do#/exp/bidding/buy/bmqr/send/expertSendSign.do#/exp/bidding/buy/bmqr/send/expertSendPay.do'  
		where mname='发标' and mid='M0830' and sid = 'M00008' and mkid = 'M083090';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bmqr/send' and method='zbpackageList' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('M083090','/exp/bidding/buy/bmqr/send','zbpackageList','2','招标文件购买过渡','1','M00008');
	end if;
	-----------add by zhaoy 2017年01月11日end-----------------
	-----------add by lijb 2018年01月11日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='toPause' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505','/bdm/expert','toPause','2','专家管理-暂停弹窗','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expert' and method='pause' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505','/bdm/expert','pause','2','专家管理-暂停专家','2','B00008');
    end if;
	-----------add by lijb 2018年01月11日end-----------------

------------add by nieche 2018年01月11日 start-------------
    num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZgysgg' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZgysgg','1','批量生成资格预审公告pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createYswjgmdjb' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createYswjgmdjb','1','预审文件购买登记表pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createPredissent' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createPredissent','1','批量生成提问与回复(资格预审或发标阶段的提问回复，招标方或代理机构与投标人之间的提问回复)pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createDissent' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createDissent','1','批量生成提问与回复(资格预审开启或评标的提问回复，专家与投标人之间的提问回复)pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createChangeNotice' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createChangeNotice','1','批量生成澄清与修改、变更、终止公告pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createObjection' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createObjection','1','批量生成异议pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZgyssqwjjsdjb' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZgyssqwjjsdjb','1','批量生成资格预审申请文件接收登记表pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createExpertRecord' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createExpertRecord','1','批量生成专家抽取记录表PDF（评审、评标）pdf','1','M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createExpertResult' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createExpertResult','1','批量生成专家抽取结果表PDF（评审、评标）pdf','1','M00008');
	end if;
------------add by nieche 2018年01月11日 end-------------
	-----------add by lijb 2018年01月12日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='toAddBlack' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010520','/bdm/expertZj','toAddBlack','2','跳转到新增黑名单页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/expertZj' and method='addBlack' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010520','/bdm/expertZj','addBlack','2','新增黑名单','2','B00008');
    end if;
	-----------add by lijb 2018年01月12日end-----------------
	----------add by lijb 2018年01月17日start----------
	num:=0;
    select count(1) into num from bs_xtmk where mid='B0160' and sid='B00008';
    if num = 0 then
        insert into bs_xtmk(mid,mname,styp,ordby,sid) values('B0160','培训管理',2,280,'B00008');
    end if;

	num:=0;
    select count(1) into num from bs_qxsz where mid='B0160' and mkid='B016005' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B016005','B0160','培训管理','培训订单管理','/bdm/training/orderList.do','/bdm/training/orderList.do#',1,100,2,'B00008');
    end if;
    
  	num:=0;
    select count(1) into num from bs_qxsz where mid='B0160' and mkid='B016010' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B016010','B0160','培训管理','培训学员管理','/bdm/training/studentList.do','/bdm/training/studentList.do#',1,100,2,'B00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='orderList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','orderList','2','订单分页列表','2','B00008');
    end if;
    
  	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='toEditInvoice' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','toEditInvoice','2','修改发票信息页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='updateInvoice' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','updateInvoice','2','修改发票信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='toShowOrder' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','toShowOrder','2','订单详情页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='studentList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','studentList','2','培训人员列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='toEditStudent' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','toEditStudent','2','修改学员信息页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='editStudent' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','editStudent','2','修改学员信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='publishCertificate' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','publishCertificate','2','发放证书','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','download','2','下载','2','B00008');
    end if;
    -------------- add by lijb 2018年01月17日end---------------
	-------------- add by lijb 2018年01月18日start---------------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='toCertificate' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016010','/bdm/training','toCertificate','2','发放结业证书页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='toEditOrder' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','toEditOrder','2','修改订单页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='updateOrderMx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','updateOrderMx','2','维护订单信息','2','B00008');
    end if;
    -------------- add by lijb 2018年01月18日end---------------
	----------add by lijb 2018年01月20日start----------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0160' and mkid='B016015' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B016015','B0160','培训管理','培训课程管理','/bdm/trainingCourse/periodList.do','/bdm/trainingCourse/periodList.do#/bdm/trainingCourse/courseList.do#/bdm/trainingCourse/scheduleList.do#',1,300,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='courseList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','courseList','2','培训课程列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditCourse' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditCourse','2','编辑培训课程页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editCourse' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editCourse','2','编辑培训课程','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='scheduleList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','scheduleList','2','培训课程内容列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditSchedule' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditSchedule','2','编辑培训课程内容页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editSchedule' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editSchedule','2','编辑培训课程内容','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='enableState' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','enableState','2','是否启用期次','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='deleteCourse' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','deleteCourse','2','删除课程','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='deleteSchedule' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','deleteSchedule','2','删除课程内容','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='periodList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','periodList','2','培训期次分页列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditPeriod' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditPeriod','2','编辑课程期次页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editPeriod' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editPeriod','2','编辑课程期次','2','B00008');
    end if;
	-----------add by lijb 2018年01月20日end-----------------

	----培训费支付-------add by hejw 2018年01月25日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/order' and method='doPayment' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','doPayment','2','去支付，请求监管平台','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/order' and method='paycallback' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/order','paycallback','0','培训费支付成功回掉','1','M00008');
    end if;
	-----------add by hejw 2018年01月25日end-----------------

    ------------add by nieche 2018年01月25日 start---------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='training' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','training','0','首页-培训','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/course' and method='toSignUp' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/course','toSignUp','1','首页-培训-报名','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/course' and method='toAddStudent' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/course','toAddStudent','1','首页-培训-报名-添加参会人','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/course' and method='toAddInvoice' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/course','toAddInvoice','1','首页-培训-报名-添加发票信息','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/order' and method='saveOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/order','saveOrder','1','首页-培训-报名-保存订单','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/order' and method='calculateOrderAmount' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/order','calculateOrderAmount','1','首页-培训-报名-计算培训课程订单金额','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_xtmk where mid='M0980' and sid='M00008';
    if num = 0 then
        insert into bs_xtmk(mid,mname,styp,ordby,sid,icon) values('M0980','培训管理',1,700,'M00008','&#xe98b;');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where mid='M0980' and mkid='M098010' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M098010','M0980','培训管理','培训订单管理','/exp/bidding/training/order/orderList.do','/exp/bidding/training/order/orderList.do#/exp/bidding/training/order/toShowOrder.do#/exp/bidding/training/order/topay.do#',1,100,1,'M00008');
    end if;
    
  	num:=0;
    select count(1) into num from bs_qxsz where mid='M0980' and mkid='M098020' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M098020','M0980','培训管理','培训人员管理','/exp/bidding/training/order/studentList.do','/exp/bidding/training/order/studentList.do#',1,200,1,'M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='orderList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','orderList','2','订单分页列表','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='toShowOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','toShowOrder','2','查看订单详情页面','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='topay' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','topay','2','培训订单支付页面','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='pay' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','pay','2','支付培训订单','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='delOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','delOrder','2','删除培训订单','1','M00008');
    end if;
	
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='studentList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098020','/exp/bidding/training/order','studentList','2','培训人员管理分页列表','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='toEditStudent' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098020','/exp/bidding/training/order','toEditStudent','2','修改学员信息页面','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='editStudent' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098020','/exp/bidding/training/order','editStudent','2','修改学员信息','1','M00008');
    end if;
	------------add by nieche 2018年01月25日 end---------------
	
	------------add by nieche 2018年01月26日 start---------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/course' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/course','download','0','文件下载','1','M00008');
    end if;
	------------add by nieche 2018年01月26日 end---------------

    ----------add by hejw 2018年1月27日 start -------
     num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='totalBatchGround' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/build/jury','totalBatchGround','0','抽取条件总人数批量落地','1','M00008');
    end if;
    ----------add by hejw 2018年1月27日 end -------
	----------add by lijb 2018年1月30日 start -------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0160' and mkid='B016020' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B016020','B0160','培训管理','培训优惠活动管理','/bdm/trainingActivity/activityList.do','/bdm/trainingActivity/activityList.do#',1,400,2,'B00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingActivity' and method='activityList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016020','/bdm/trainingActivity','activityList','2','优惠活动分页列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingActivity' and method='toEditActivity' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016020','/bdm/trainingActivity','toEditActivity','2','编辑优惠活动页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingActivity' and method='editActivity' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016020','/bdm/trainingActivity','editActivity','2','保存优惠活动','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingActivity' and method='toShowOrderActivity' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016020','/bdm/trainingActivity','toShowOrderActivity','2','查看优惠活动详情','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/training/order' and method='toRemit' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M098010','/exp/bidding/training/order','toRemit','2','确认线下汇款','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='topay' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','topay','2','线下汇款审核页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='remit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','remit','2','确认汇款','2','B00008');
    end if;
	----------add by lijb 2018年1月30日 end -------
	----------add by lijb 2018年1月31日 start -------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingActivity' and method='deleteActivity' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016020','/bdm/trainingActivity','deleteActivity','2','删除优惠活动','2','B00008');
    end if;
	----------add by lijb 2018年1月31日 end -------

	----------add by hejw 2018年2月01日 end -------
     num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='isLogin' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','isLogin',0,'判断是否登录','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='isUserLogin' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','isUserLogin',0,'判断用户是否登录','1','M00008');
    end if;
	----------add by hejw 2018年1月01日 start -------

    ------------add by nieche 2018年02月02日 start-------------
    num:=0;
    select count(1) into num from bs_xtmk where mid='M0980' and sid='M00008';
    if num = 1 then
         update bs_xtmk set icon='&'||'#xe98b;' where mid='M0980' and sid='M00008';
    end if;
    ------------add by nieche 2018年02月02日 start-------------


    ------------add by nieche 2018年02月06日 start---------------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditCourseLimited' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditCourseLimited','2','维护名额信息（是否显示名额紧张）页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editCourseLimited' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editCourseLimited','2','维护名额信息（是否显示名额紧张）','2','B00008');
    end if;
	------------add by nieche 2018年02月06日 end---------------
	------------add by zhaoy 2018年02月23日 start---------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='toCreatePdfAndHtml' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','toCreatePdfAndHtml','1','跳转批量生成页面','1','M00008');
	end if;
	------------add by zhaoy 2018年02月23日 end---------------
	----------add by lijb 2018年2月25日 start -------
	num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='toSystem' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','toSystem','1','查看制度页面','1','M00009');
    end if;
	----------add by lijb 2018年2月25日 end -------

	
	------------add by zhaoy 2018年03月02日 start---------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createZbhxr' and sid = 'M00008';
	if num = 0 then
	     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
	     values('0','/exp/bidding/create/pdf','createZbhxr','1','平移候选人数据','1','M00008');
	end if;
	------------add by zhaoy 2018年03月02日 end---------------

    ------------add by nieche 2018年03月07日 start---------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='toEditContinueReason' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','toEditContinueReason',1,'进入继续评标理由页面',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='editContinueReason' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','editContinueReason',1,'主任保存继续评标理由',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='confirmContinueReason' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','confirmContinueReason',1,'评委确认继续评标理由',1,'M00009');
	end if;
	------------add by nieche 2018年03月07日 end---------------

	------------add by lijb 2018年03月15日 start---------------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014525' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014525','B0145','会员权益管理','会员权益记录管理','/bdm/hyjl/list.do','/bdm/hyjl/list.do',1,275,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014530' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014530','B0145','会员权益管理','会员优惠券管理','/bdm/yhj/list.do','/bdm/yhj/list.do',1,350,2,'B00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/hyjl' and METHOD ='list' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014525','/bdm/hyjl','list',2,'会员权益记录分页',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/hyjl' and METHOD ='read' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014525','/bdm/hyjl','read',2,'查看会员权益记录',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/yhj' and METHOD ='list' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/bdm/yhj','list',2,'会员优惠卷分页',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/yhj' and METHOD ='export' and STYP=2 and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014530','/bdm/yhj','export',2,'会员优惠卷数据导出',2,'B00008');
	end if;
	------------add by lijb 2018年03月15日 end---------------
    
    ------------add by zhaoy 2018年03月15日 end---------------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0200' and mkid='B020020' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B020020','B0200','系统管理','紧急公告','/bdm/basesetup/urgentnotice/list.do','/bdm/basesetup/urgentnotice/list.do',1,150,2,'B00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='list' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','list',2,'紧急公告列表',2,'B00008');
	end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='toAdd' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','toAdd',2,'新增紧急公告',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='save' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','save',2,'保存紧急公告',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='download' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','download',2,'下载附件',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='edit' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','edit',2,'编辑紧急公告',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='delete' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','delete',2,'删除紧急公告',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='fbUrgent' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','fbUrgent',2,'发布紧急公告',2,'B00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdm/basesetup/urgentnotice' and METHOD ='stopUrgent' and SID='B00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B020020','/bdm/basesetup/urgentnotice','stopUrgent',2,'停用紧急公告',2,'B00008');
	end if;
    ------------add by zhaoy 2018年03月15日 end---------------

    ------------add by hejw 2018年03月16日 start---------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/httpback' and method='testtime' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/httpback','testtime',1,'纯时间戳测试方法','1','M00008');
    end if;
    ------------add by hejw 2018年03月16日 end---------------

    ------------add by hejw 2018年03月19日 start---监察调用列表------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='jcxmlist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','jcxmlist',1,'监察项目列表','1','M00008');
    end if;
    ------------add by hejw 2018年03月19日 end---------------


	------------add by lijb 2018年03月19日 start---------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/training' and method='toPlkp' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','toPlkp',2,'批量开票','2','B00008');
    end if;
    ------------add by lijb 2018年03月19日 end---------------
    
    ------------add by zhaoy 2018年03月19日 start---------------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='againFile' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M092005','/exp/bidding/sell/bidding','againFile',2,'清空上传文件',1,'M00008');
	end if;
    ------------add by zhaoy 2018年03月19日 end---------------

    ------------add by nieche 2018年03月20日 start---------------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditPeriodLocation' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditPeriodLocation','2','维护培训期次地点页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editPeriodLocation' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editPeriodLocation','2','维护培训期次地点','2','B00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='toEditCourseSortNum' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','toEditCourseSortNum','2','维护课程排序页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/trainingCourse' and method='editCourseSortNum' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016015','/bdm/trainingCourse','editCourseSortNum','2','维护课程排序','2','B00008');
    end if;
	------------add by nieche 2018年03月20日 end---------------

	------------add by hejw 2018年03月24日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/common' and method='getHyfltree' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/common','getHyfltree',1,'项目行业分类','1','M00008');
    end if;
	------------add by hejw 2018年03月24日 end---------------

	------------add by zhaoy 2018年03月20日 start---------------
 	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='subgroupPage' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','subgroupPage',1,'监察集团列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='export' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','export',1,'子集团导出','1','M00008');
    end if;
	------------add by zhaoy 2018年03月20日 end---------------

	------------add by zhaoy 2018年03月21日 start---------------
 	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='zSubgroup' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','zSubgroup',1,'根据会员代码子集团列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='zSubgroupDrop' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','zSubgroupDrop',1,'根据会员代码子集团下拉列表','1','M00008');
    end if;
	------------add by zhaoy 2018年03月21日 end---------------
	------------add by lijb 2018年03月22日 start---监察项目详情------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='jcxmDetails' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','jcxmDetails',1,'监察项目详情','1','M00008');
    end if;
    ------------add by lijb 2018年03月22日 end---------------

    ------------add by hejw 2018年03月26日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='getTurnover' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','getTurnover',0,'获取成交额','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='getPackageDetails' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','getPackageDetails',1,'获取标段包 对应中标人及中标金额','1','M00008');
    end if;
    ------------add by hejw 2018年03月26日 end---------------

    ------------add by nieche 2018年03月26日 start--------------- 
    --add 增加评审平台委员会主任、专家退回评标列表权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='index' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','index',1,'评审平台委员会主任、专家退回评标列表页面权限',1,'M00009');
	end if;
	
	--add 增加评审平台评委退回评标新增（委员会主任）、编辑（委员会主任）、查看(主任、评委)页面权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='toEdit' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','toEdit',1,'评审平台评委退回评标新增（委员会主任）、编辑（委员会主任）、查看(主任、评委)页面权限',1,'M00009');
	end if;
	
	--add 增加评审平台委员会主任保存评委退回评标信息权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='save' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','save',1,'评审平台委员会主任保存评委退回评标信息权限',1,'M00009');
	end if;
	
	--add 增加评审平台主任发送退回评标给其他评委权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='sendToJurys' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','sendToJurys',1,'评审平台主任发送退回评标给其他评委权限',1,'M00009');
	end if;
	
	
	--add 增加评审平台除了主任之外的评委确认退回评标信息权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='confirmRevert' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','confirmRevert',1,'评审平台除了主任之外的评委确认退回评标信息权限',1,'M00009');
	end if;
    ------------add by nieche 2018年03月26日 end--------------- 
      
	------------add by zhaoy 2018年03月26日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/common' and method='getPackFltree' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/common','getPackFltree',1,'标段包分类','1','M00008');
    end if;
	------------add by zhaoy 2018年03月26日 end---------------

	------------add by lijb 2018年03月28日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/httpback' and method='totime' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/httpback','totime',0,'页面按钮测试时间戳','1','M00008');
    end if;
	------------add by lijb 2018年03月28日 end---------------

------------add by nieche 2018年03月29日 start--------------- 
	--add 增加下载重新评标附件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='download' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','download',1,'下载重新评标附件权限',1,'M00009');
	end if;
------------add by nieche 2018年03月29日 end--------------- 

------------add by nieche 2018年03月30日 start--------------- 
    --add 增加评审平台委员会主任撤回评标报告权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='withdraw' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','withdraw',1,'评审平台委员会主任撤回评标报告权限',1,'M00009');
	end if;
------------add by nieche 2018年03月30日 end--------------- 

    ------------add by zhaoy 2018年04月04日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='getTbDbje' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','getTbDbje',0,'获取投标人定标金额数据','1','M00008');
    end if;
    ------------add by zhaoy 2018年04月04日 end---------------

    ------------add by nieche 2018年04月09日 start--------------- 
	--add 增加评审平台退回评标生效时自动跳转到对应评审或评标环节权限
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/revert' and METHOD ='revertMbxh' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/revert','revertMbxh',1,'评审平台退回评标生效时自动跳转到对应评审或评标环节权限',1,'M00009');
	end if;
    ------------add by nieche 2018年04月09日 end--------------- 
	
	------------add by zhaoy 2018年04月10日 start---------------
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/training' and method='exportExcel' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B016005','/bdm/training','exportExcel','2','导出订单分页excel','2','B00008');
    end if;
	------------add by zhaoy 2018年04月10日 end---------------

	------------add by zhaoy 2018年04月04日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='getZbjeSum' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','getZbjeSum',0,'获取平台总中标金额','1','M00008');
    end if;
    ------------add by zhaoy 2018年04月04日 end---------------
	
	------------add by lijb 2018年04月23日 start---------------
	num:=0;
    select count(1) into num from bs_xtmk where mid='M0990' and sid='M00008';
    if num = 0 then
        insert into bs_xtmk(mid,mname,styp,ordby,sid) values('M0990','会员权益管理',1,650,'M00008');
    end if;

	num:=0;
    select count(1) into num from bs_qxsz where mid='M0990' and mkid='M099010' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M099010','M0990','会员权益管理','我的权益','/bdp/hyqy/me/index.do','/bdp/hyqy/me/index.do#',1,100,1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='M0990' and mkid='M099020' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M099020','M0990','会员权益管理','权益记录','/bdp/hyqy/record/list.do','/bdp/hyqy/record/list.do#/bdp/hyqy/me/toDealWith.do#',1,200,1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='M0990' and mkid='M099030' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('M099030','M0990','会员权益管理','优惠券','/bdp/hyqy/coupon/list.do','/bdp/hyqy/coupon/list.do#/bdp/hyqy/coupon/useRecord.do#',1,300,1,'M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='deleteOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','deleteOrder',2,'删除订单记录','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='list' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','list',2,'权益记录分页','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='invoice' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','invoice',2,'查看开票信息','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='mbInterests' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','mbInterests',2,'查看会员权益','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='orderDetails' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','orderDetails',2,'查看订单详情','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/record' and method='export' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099020','/bdp/hyqy/record','export',2,'权益记录导出','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/coupon' and method='list' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099030','/bdp/hyqy/coupon','list',2,'优惠卷分页','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/coupon' and method='useRecord' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099030','/bdp/hyqy/coupon','useRecord',2,'优惠卷使用记录','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/coupon' and method='export' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M099030','/bdp/hyqy/coupon','export',2,'优惠券导出','1','M00008');
    end if;
    ------------add by lijb 2018年04月23日 end---------------
	
	------------add by lijb 2018年04月25日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/training/course' and method='findLastTraining' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/training/course','findLastTraining',1,'获取启用的培训课程信息','1','M00008');
    end if;
    ------------add by lijb 2018年04月25日 end---------------
	
	------------add by zhaoy 2018年04月26日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/common' and method='getHyflList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/common','getHyflList',1,'行业分类集合','1','M00008');
    end if;
	------------add by zhaoy 2018年04月26日 end---------------

	------------add by zhaoy 2018年05月03日 start---------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='jcxmPackDetails' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','jcxmPackDetails',0,'获取标段包详情','1','M00008');
    end if;
	------------add by zhaoy 2018年05月03日 end---------------

----------add by nieche 2018年05月03日 start-------------
    num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/create/pdf' and method='createCxpbjlbPdf' and sid = 'M00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/exp/bidding/create/pdf','createCxpbjlbPdf','1','批量生成生成评委重新评标记录表pdf','1','M00008');
  end if;
------------add by nieche 2018年05月03日 end-------------

------------add by hejw 2018年05月07日 start-------------
  num:=0;
    select count(1) into num from bs_qxmx where action='/' and method='userinfo' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','userinfo','0','获取当前登陆信息','1','M00008');
    end if;
------------add by hejw 2018年05月07日 end-------------

------------add by hejw 2018年05月09日 start-------------
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0150' and mkid='B015025' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,subsystem)
        values('B015025','B0150','平台统计报表','广告访问明细报表','/bdm/count/detailed/list.do','/bdm/count/detailed/list.do#/bdm/count/detailed/export.do',1,110,2,'B00008','S00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0150' and mkid='B015030' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,subsystem)
        values('B015030','B0150','平台统计报表','广告访问统计报表','/bdm/count/statistical/list.do','/bdm/count/statistical/list.do#/bdm/count/statistical/export.do',1,120,2,'B00008','S00000');
    end if;

  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/count/detailed' and method='list' and sid = 'B00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('B015025','/bdm/count/detailed','list','2','广告访问明细报表-列表','2','B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/count/detailed' and method='export' and sid = 'B00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('B015025','/bdm/count/detailed','export','2','广告访问明细报表-导出','2','B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/count/statistical' and method='list' and sid = 'B00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('B015030','/bdm/count/statistical','list','2','广告访问统计报表-列表','2','B00008');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdm/count/statistical' and method='export' and sid = 'B00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('B015030','/bdm/count/statistical','export','2','广告访问统计报表-导出','2','B00008');
  end if;
------------add by hejw 2018年05月09日 end-------------

------------add by hejw 2018年05月21日 start-------------
  num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/lug/fund' and method='fzh' and sid = 'M00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/exp/bidding/lug/fund','fzh','0','再次重新生成-固定账户','1','M00008');
  end if;
------------add by hejw 2018年05月21日 end-------------

	------------add by lijb 2018年05月18日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='provingKbCompleter' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084020','/exp/bidding/buy/kb','provingKbCompleter',2,'验证是否可以点击开标完成','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='kbCompleter' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084020','/exp/bidding/buy/kb','kbCompleter',2,'开标完成','1','M00008');
    end if;
    ------------add by lijb 2018年05月18日 end---------------

    ------------add by hejw 2018年05月22日 start---------------
  num:=0;
  select count(1) into num from bs_qxmx where action='/' and method='ubBehaviorMx' and sid = 'M00008';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/','ubBehaviorMx','0','https调用http中转','1','M00008');
  end if;
    ------------add by hejw 2018年05月22日 end---------------

	------------add by zhaoy 2018年05月23日 start---------------
 	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/account' and method='exportKDetail' and sid = 'M00008';
  	if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M060020','/exp/bidding/account','exportKDetail','2','扣款明细导出','1','M00008');
  	end if;
    ------------add by zhaoy 2018年05月23日  end---------------
	
	------------add by lijb 2018年05月28日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='getDeputy' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','getDeputy',2,'ajax获取业主代表的信息','1','M00008');
    end if;
	------------add by lijb 2018年05月28日 end---------------

	------------add by lijb 2018年05月31日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/' and method='toBuild' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','toBuild',0,'正在建设页面','1','M00008');
    end if;
	------------add by lijb 2018年05月31日 end---------------

	------------add by lijb 2018年06月01日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='yskbCompleter' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089092','/exp/bidding/buy/ysopen','yskbCompleter',2,'预审开标完成','1','M00008');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='provingYsKbCompleter' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089092','/exp/bidding/buy/ysopen','provingYsKbCompleter',2,'验证是否可以点击预审开标完成','1','M00008');
    end if;
	------------add by lijb 2018年06月01日 end---------------

	------------add by zhaoy 2018年06月07日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdm/prefic' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011005','/bdm/prefic','download',2,'后台预审审核下载附件','2','B00008');
    end if;
	------------add by wangzh 2018年06月07日 end---------------

------------add by wangzh 2018年06月25日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdm/expertZj' and method='delete' and sid = 'B00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)   
		values('B010520','/bdm/expertZj','delete',2,'彻底删除专家',2,'B00008');
    end if;
	------------add by wangzh 2018年06月25日 end---------------
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
