DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.1.1'; -- 本升级文件的版本，每个升级文件必须修改
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
	

------add by xuz start 资格预审招标异常----
	  num:=0;
    select count(1) into num from bs_qxsz where mkid = 'M089094' and sid = 'M00008' and mid = 'M0890';
    if num = 0 then
	     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid,fixed,qxrole)
       values('M089094', 'M0890', '资格预审', '招标异常', '/exp/bidding/buy/yszbyc/list.do', '/exp/bidding/buy/yszbyc/list.do#/exp/bidding/buy/yszbyc/refer.do#/exp/bidding/buy/yszbyc/save.do#/exp/bidding/buy/yszbyc/packlist.do#/exp/bidding/buy/yszbyc/toEdit.do#/exp/bidding/buy/yszbyc/submits.do#/exp/bidding/buy/yszbyc/toView.do', 1, '70', 1, 'M00008',1,'1,2,3,4,5,6,7');   
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','list',2,'招标异常列表页',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='refer' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','refer',2,'招标异常提交页面跳转',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='save' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','save',2,'招标异常提交保存',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','packlist',2,'标段包过渡页',1,'M00008');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='toEdit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','toEdit',2,'编辑页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='submits' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','submits',2,'提交',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','toView',2,'查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='applyStop' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','applyStop',2,'申请终止',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='toConfirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','toConfirm',2,'审核页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='confirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','confirm',2,'审核通过',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yszbyc' and METHOD ='refuse' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089094','/exp/bidding/buy/yszbyc','refuse',2,'审核不通过',1,'M00008');
	end if;
	
	
    
------add by xuz 资格预审招标异常 end----

------add by xuz start 发标 招标异常----
	  num:=0;
    select count(1) into num from bs_qxsz where mkid = 'M083095' and sid = 'M00008' and mid = 'M0830';
    if num = 0 then
	     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid,fixed,qxrole)
       values('M083095', 'M0830', '发标', '招标异常', '/exp/bidding/buy/fbzbyc/list.do', '/exp/bidding/buy/fbzbyc/list.do#/exp/bidding/buy/fbzbyc/refer.do#/exp/bidding/buy/fbzbyc/save.do#/exp/bidding/buy/fbzbyc/packlist.do#/exp/bidding/buy/fbzbyc/toEdit.do#/exp/bidding/buy/fbzbyc/submits.do#/exp/bidding/buy/fbzbyc/toView.do', 1, '70', 1, 'M00008',1,'1,2,3,4,5,6,7');   
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','list',2,'招标异常列表页',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='refer' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','refer',2,'招标异常提交页面跳转',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='save' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','save',2,'招标异常提交保存',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='packlist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','packlist',2,'标段包过渡页',1,'M00008');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='toEdit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','toEdit',2,'编辑页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='submits' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','submits',2,'提交',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='toView' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','toView',2,'查看页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='applyStop' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','applyStop',2,'申请终止',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='toConfirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','toConfirm',2,'审核页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='confirm' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','confirm',2,'审核通过',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/fbzbyc' and METHOD ='refuse' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083095','/exp/bidding/buy/fbzbyc','refuse',2,'审核不通过',1,'M00008');
	end if;
	
	
    
------add by xuz 发标 招标异常 end----


------add by hejw 权限名称调整  start----
  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089098';    
	if num = 1 then
		update bs_qxsz set name='提问与回复',orderno='20' where sid='M00008' and mkid='M089098' and name='资格预审问题回复列表';
	end if;

  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089060';    
	if num = 1 then
		update bs_qxsz set name='澄清与修改',orderno='30' where sid='M00008' and mkid='M089060' and name='澄清文件发布';
	end if;
  
  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089050';    
	if num = 1 then
		update bs_qxsz set name='变更（终止）公告',orderno='60' where sid='M00008' and mkid='M089050' and name='变更公告';
	end if;
	
	  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083055' and name='澄清文件发布';    
	if num = 1 then
		update bs_qxsz set name='澄清与修改',orderno='60' where sid='M00008' and mkid='M083055' and name='澄清文件发布';
	end if;
  
    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083060' and name='异议列表';    
	if num = 1 then
		update bs_qxsz set name='异议',orderno='70' where sid='M00008' and mkid='M083060' and name='异议列表';
	end if;
  
  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083050' and name='变更公告';    
	if num = 1 then
		update bs_qxsz set name='变更（终止 ）公告',orderno='90' where sid='M00008' and mkid='M083050' and name='变更公告';
	end if;
  
    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083095' and name='招标异常';    
	if num = 1 then
		update bs_qxsz set orderno='100' where sid='M00008' and mkid='M083095' and name='招标异常';
	end if;

    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083080' and name='招标文件问题';    
	if num = 1 then
		update bs_qxsz set name='提问与回复' where sid='M00008' and mkid='M083080' and name='招标文件问题';
	end if;
	
	   num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M084030' and name='招标异常';    
	if num = 1 then
		update bs_qxsz set orderno='400' where sid='M00008' and mkid='M084030' and name='招标异常';
	end if;
  
    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M084040' and name='异议列表';    
	if num = 1 then
		update bs_qxsz set name='异议',orderno='300' where sid='M00008' and mkid='M084040' and name='异议列表';
	end if;
  
    num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086090' and name='异议列表';    
	if num = 1 then
		update bs_qxsz set name='异议' where sid='M00008' and mkid='M086090' and name='异议列表';
	end if;
------add by hejw 权限名称调整  end----

	---add by chenxp 招标方查看澄清回执文件 start---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yscqnotice' and sid = 'M00008' and method='ysReceipt';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M089060','/exp/bidding/buy/yscqnotice','ysReceipt','2','预审澄清文件回执','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/cqnotice' and sid = 'M00008' and method='hsReceipt';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M083055','/exp/bidding/cqnotice','hsReceipt','2','澄清文件回执','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yscqnotice/ysReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089060';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yscqnotice/ysReceipt.do') where  sid = 'M00008' and mkid='M089060';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/cqnotice/hsReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M083055';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/cqnotice/hsReceipt.do') where  sid = 'M00008' and mkid='M083055';
    end if;
	---add by chenxp 招标方查看澄清回执文件 end----
	------------------cheny 2016/08/10服务端模板管理--start-----------------------------
    --添加"模板管理"菜单项
    num:=0;
    select count(1) into num from bs_qxsz where mkid = 'B011505' and sid = 'B00008';
    if num = 1 then
	     update bs_qxsz set url = '/bdm/client/template/index.do' where mkid = 'B011505' and sid = 'B00008';
    end if;	
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/client/template' and sid = 'M00008' and mkid='0' and method='deleteTemp';
    if num = 0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
    VALUES ('0', '/client/template', 'deleteTemp', '0', '客户端-模板管理-删除模板', '1', 'M00008');
    end if;
	
	------------------cheny 2016/08/10服务端模板管理--end----------------------------- 
	
	--------------zhangdl 2016年8月10日  设置下载回执的权限 start-----------
	num:=0;
	select count(1) into num from BS_QXMX where mkid='M089096' and sid='M00008' and action='/exp/bidding/buy/gkys' and method='toExportReceipt';
	if num = 0 then
		insert into BS_QXMX(mkid, action, method,accesstag, remark, styp, sid)
		values('M089096','/exp/bidding/buy/gkys','toExportReceipt','2','代资格审核通过通知书下载回执','1','M00008');
	end if;
	--------------zhangdl 2016年8月10日  设置下载回执的权限 end-----------
	---------------songw  2016年9月18日 增加查看资格预审通过单位的签章列表的权限  start-------------
	num:=0;
	select count(1) into num from BS_QXMX where mkid='M089096' and sid='M00008' and action='/exp/bidding/buy/gkys' and method='sealList';
	if num = 0 then
		insert into BS_QXMX(mkid, action, method,accesstag, remark, styp, sid)
		values('M089096','/exp/bidding/buy/gkys','sealList','2','代资格审核通过通知书签章列表','1','M00008');
	end if;
	--增加保存资格预审通过通知书签章后的文件的权限
	num:=0;
	select count(1) into num from BS_QXMX where mkid='M089096' and sid='M00008' and action='/exp/bidding/buy/gkys' and method='toSaveSeal';
	if num = 0 then
		insert into BS_QXMX(mkid, action, method,accesstag, remark, styp, sid)
		values('M089096','/exp/bidding/buy/gkys','toSaveSeal','2','保存签章提交的资格预审通过通知书pdf文件','1','M00008');
	end if;
	---------------songw  2016年9月18日 增加查看资格预审通过单位的签章列表的权限  end-------------
	---------add by songw start-------------
	--add 增加代资格预审通过通知书清除签章权限
	num:=0;
	select count(1) into num from BS_QXMX where mkid='M089096' and sid='M00008' and action='/exp/bidding/buy/gkys' and method='toDelSeal';
	if num = 0 then
		insert into BS_QXMX(mkid, action, method,accesstag, remark, styp, sid)
		values('M089096','/exp/bidding/buy/gkys','toDelSeal','2','发送投标邀请书(代资格审核通过通知书)页面清除签章','1','M00008');
	end if;

	--add 增加选择代理机构权限
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and sid = 'M00008'  and mkid='M081025'  and method='menberByDLS';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025','/exp/bidding/buy/subproject','menberByDLS','2','选择代理机构','1','M00008');
    end if;
 
    --add 增加生成资格评审报告pdf文件权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and sid = 'M00009'  and mkid='0'  and method='createPdfFile';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','createPdfFile','1','生成资格评审报告pdf文件','1','M00009');
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and sid = 'M00009'  and mkid='0'  and method='adjustOrder';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/psp/judge/report','adjustOrder','1','评审报告界面-手动调整排序','1','M00009');
    end if;

     --add 增加下载资格评审报告pdf文件或评标报告pdf文件的权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and sid = 'M00009'  and mkid='0'  and method='downloadPdf';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','downloadPdf','1','下载资格评审报告pdf文件或评标报告pdf文件','1','M00009');
    end if;
	---------add by songw end-------------
	---add by xuz start--------------------------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091060' and name='资格预审文件问题';    
	if num = 1 then
		update bs_qxsz set name='提问与回复' where sid='M00008' and mkid='M091060' and name='资格预审文件问题';
	end if;
	
	num:=0;
	  select count(1) into num from bs_qxsz where mkid='M091087' and  sid='M00008' and mid='M0910' and name='招标文件问题';
	  if num>0 then
	  	DELETE FROM BS_QXSZ WHERE MKID='M091087' AND SID='M00008' AND MID='M0910'  and name='招标文件问题';  
	  end if;
	 
	 num:=0;
	  select count(1) into num from bs_qxsz where mkid='M094005' and  sid='M00008' and mid='M0940' and name='提问与回复';
	  if num>0 then
	  	DELETE FROM BS_QXSZ WHERE MKID='M094005' AND SID='M00008' AND MID='M0940'  and name='提问与回复';  
	  end if;
	   
	  num:=0;
	  select count(1) into num from bs_qxmx where mkid='M094005' and  sid='M00008'  and method='list' and action='/exp/bidding/sell/qureply';
	  if num>0 then
	  	DELETE FROM BS_QXMX WHERE mkid='M094005' and  sid='M00008'  and method='list' and action='/exp/bidding/sell/qureply';  
	  end if;
	  
	 num:=0;
    select count(1) into num from bs_qxsz where mkid = 'M094005' and sid = 'M00008' and mid = 'M0940';
    if num = 0 then
	     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, sid,fixed,qxrole)
       values('M094005', 'M0940', '评标', '提问与回复', '/exp/bidding/sell/zbwj/dissent/zbClariList.do', '/exp/bidding/sell/zbwj/dissent/zbClariList.do#/exp/bidding/sell/zbwj/dissent/toSlClari.do#/exp/bidding/sell/zbwj/dissent/acceptScaling.do#/exp/bidding/sell/zbwj/dissent/toReplyZbwt.do#/exp/bidding/sell/zbwj/dissent/saveReplyZbwt.do#/exp/bidding/sell/zbwj/dissent/download.do#/exp/bidding/sell/zbwj/dissent/toView.do#/exp/bidding/sell/zbwj/dissent/packlist.do#/exp/bidding/sell/zbwj/dissent/toAsk.do#/exp/bidding/sell/zbwj/dissent/saveAsk.do', 1, '70', 1, 'M00008',1,'1,2,3,4,5,6,7');   
    end if; 
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00008' and mkid='M091087' and action='/exp/bidding/sell/zbwj/dissent' ;    
	if num >0 then
		update bs_qxmx set mkid='M094005' where sid='M00008' and mkid='M091087' and action='/exp/bidding/sell/zbwj/dissent' ;
	end if;
	
	 num:=0;
	select count(1) into num from bs_xtmk where sid='M00008' and mid='M0940' and url00='/exp/bidding/sell/qureply/list.do';    
	if num >0 then
		update bs_xtmk set url00='/exp/bidding/sell/zbwj/dissent/zbClariList.do' where sid='M00008' and mid='M0940' and url00='/exp/bidding/sell/qureply/list.do';
	end if;
	---add by xuz end----------------------------

	-- 权限设置 资格预审 资格预审评审办法
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0890' and mkid='M089008' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
		values('M089008','M0890','资格预审','资格预审评审办法','/exp/bidding/buy/prefic/topsbfpacklist.do','/exp/bidding/buy/prefic/topsbfpacklist.do#/exp/bidding/buy/prefic/toChoosePbmb.do#/exp/bidding/buy/prefic/toPsbf.do',1,80,1,'M00008','1,5');
	end if;
	-- 权限明细 资格预审评审办法 标段包列表过渡页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='topsbfpacklist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089008','/exp/bidding/buy/prefic','topsbfpacklist',2,'资格预审评审办法-标段包列表过渡页面',1,'M00008');
	end if;
	-- 权限明细 资格预审评审办法 选择模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toChoosePbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089008','/exp/bidding/buy/prefic','toChoosePbmb',2,'资格预审评审办法-选择模板页面',1,'M00008');
	end if;
	-- 权限明细 资格预审评审办法 评审办法编辑页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toPsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089008','/exp/bidding/buy/prefic','toPsbf',2,'资格预审评审办法-评审办法编辑页面',1,'M00008');
	end if;
	-- 权限明细 资格预审评审办法 保存评审办法
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='savePsbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089008','/exp/bidding/buy/prefic','savePsbf',2,'资格预审评审办法-保存评审办法',1,'M00008');
	end if;
	-- 权限明细 资格预审评审办法 保存评审办法至评标模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='savePsbfToPbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089008','/exp/bidding/buy/prefic','savePsbfToPbmb',2,'资格预审评审办法-保存评审办法至评标模板',1,'M00008');
	end if;
	
	-- 权限设置 发标 评标办法
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083013' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
		values('M083013','M0830','发标','评标办法','/exp/bidding/buy/zbwjone/topbbfpacklist.do','/exp/bidding/buy/zbwjone/topbbfpacklist.do#/exp/bidding/buy/zbwjone/toChoosePbmb.do#/exp/bidding/buy/zbwjone/toPbbf.do',1,130,1,'M00008','1,2,3,5,6,7');
	end if;
	-- 权限明细 评标办法 标段包列表过渡页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='topbbfpacklist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083013','/exp/bidding/buy/zbwjone','topbbfpacklist',2,'评标办法-标段包列表过渡页面',1,'M00008');
	end if;
	-- 权限明细 评标办法 选择模板页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toChoosePbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083013','/exp/bidding/buy/zbwjone','toChoosePbmb',2,'评标办法-选择模板页面',1,'M00008');
	end if;
	-- 权限明细 评标办法 评标办法编辑页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toPbbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083013','/exp/bidding/buy/zbwjone','toPbbf',2,'评标办法-评标办法编辑页面',1,'M00008');
	end if;
	-- 权限明细 评标办法 保存评标办法
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='savePbbf' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083013','/exp/bidding/buy/zbwjone','savePbbf',2,'评标办法-保存评标办法',1,'M00008');
	end if;
	-- 权限明细 评标办法 保存评标办法至评标模板
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='savePbbfToPbmb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083013','/exp/bidding/buy/zbwjone','savePbbfToPbmb',2,'评标办法-保存评标办法至评标模板',1,'M00008');
	end if;
	
	------------------cheny 2016/08/10服务端模板管理--start-----------------------------
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0115' and parent = 'B011505' and name = '编辑';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
           values('B01150505', 'B0115', '模板管理', '编辑', '', '', '2', '100', '2', 'B011505', 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid = 'B011505' and sid = 'B00008';
    if num = 1 then
	     update bs_qxsz set inurl = '/bdm/client/template/index.do#' where mkid = 'B011505' and sid = 'B00008';
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxmx where sid = 'B00008' and mkid = 'B011505' and method not in('list', 'index');
    if num > 1 then
       update bs_qxmx set mkid = 'B01150505' where sid = 'B00008' and mkid = 'B011505' and method not in('list', 'index');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B01150505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'copy';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
              values('B01150505', '/bdm/client/template', 'copy', '2', '客户端管理-模板复制', '2' , 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B01150505' and sid = 'B00008' and action = '/bdm/client/template' and method = 'toEditMx';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B01150505', '/bdm/client/template', 'toEditMx', '2', '客户端管理-跳转至编辑页面', '2' , 'B00008');
    end if;

	------------------cheny 2016/08/10服务端模板管理--end-----------------------------
	
	-------------BY.zhminfu-------------
	num:=0;
    select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='checkButton' and STYP=1 and SID='M00009';
    if num = 0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('0','/psp/judge/sign','checkButton',1,'AJAX判断去评审按钮是否显示',1,'M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00008' and mkid='B020010' and name='日志管理';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
       values('B020010', 'B0200', '系统管理', '日志管理', '/bdm/log/query/list.do', '/bdm/log/query/list.do', '1', '200', '2', '', 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/bdm/log/query' and METHOD ='list' and STYP=2 and SID='B00008';
    if num = 0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B020010','/bdm/log/query','list',2,'日志管理-查询',2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/bdm/log/query' and METHOD ='export2Excel' and STYP=2 and SID='B00008';
    if num = 0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('B020010','/bdm/log/query','export2Excel',2,'日志管理-导出',2,'B00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/project' and  method='delProject' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M081010','/exp/bidding/buy/project','delProject',2,'项目删除',1,'M00008');
    end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='toEnchashment' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','toEnchashment',2,'转出提现页面',1,'M00008');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='doEnchashment' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','doEnchashment',2,'转出提现',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='toOverdraw' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','toOverdraw',2,'透支页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='doOverdraw' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','doOverdraw',2,'透支',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='toReturn' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','toReturn',2,'退保证金页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='doReturn' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','doReturn',2,'退保证金',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='payRequestList' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','payRequestList',2,'会员出入金申请记录',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/fund' and method='delPayRequest' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M060010','/exp/bidding/fund','delPayRequest',2,'删除支付申请记录',1,'M00008');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxsz where mkid='M081050' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxsz (MKID, mid, mname, name, url, inurl, isuse, orderno, styp, sid, qxrole)
		values('M081050', 'M0810', '招标方案', '招标项目', '/exp/bidding/buy/beingPro/subpInfo.do', '/exp/bidding/buy/beingPro/subpInfo.do#/exp/bidding/buy/beingPro/editSubp.do', 1, 280, 1, 'M00008', '5,6,7');
	end if;

	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/beingPro' and method='subpInfo' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M081050','/exp/bidding/buy/beingPro','subpInfo',2,'招标项目-查看',1,'M00008');
	end if;
  
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/beingPro' and method='editSubp' and sid='M00008';      
	if num = 0 then 
		insert into bs_qxmx (mkid, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values('M081050','/exp/bidding/buy/beingPro','editSubp',2,'招标项目-代理机构更新',1,'M00008');
	end if;
	
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M081025' and sid='M00008' and qxrole='1,2,3,4,5,6,7';
    if num=1 then
		update bs_qxsz set qxrole='1,2,3,4' where mkid='M081025' and sid='M00008' and qxrole='1,2,3,4,5,6,7'; 
    end if;
	
	---add by chenxp start 专家管理---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and sid = 'B00008' and method='qyzj';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B01050505','/bdm/expert','qyzj','2','专家管理-启用或暂停专家','2','B00008');
    end if;
  
    num:=0;
    select instr(inurl,'/bdm/expert/qyzj.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010505';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdm/expert/qyzj.do') where  sid = 'B00008' and mkid='B010505';
    end if;
	---add by chenxp end 专家管理-----
	------------------cheny 2016/08/15 项目采购清单权限配置--start-----------------------------
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'B00008'  and mid = 'B0110' and name = '价格信息库';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
            values('B011535', 'B0110', '招标管理', '价格信息库', '/bdm/bdpackage/list.do', '/bdm/bdpackage/list.do#', '1', '100', '2', null, 'B00008');
    end if;
    
     num:=0;
     select count(1) into num from bs_qxsz where sid = 'B00008'  and mid = 'B0110' and mname = '价格信息库' and name = '编辑';
     if num = 0 then
     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
             values('B01153505', 'B0110', '价格信息库', '编辑', '', '', '2', '100', '2', 'B011535', 'B00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx 
            where mkid = 'B011535' and sid = 'B00008' and action = '/bdm/bdpackage' and method = 'list';
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
               values('B011535', '/bdm/bdpackage', 'list', '2', '价格信息库-项目采购清单列表', '2' , 'B00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'B00008'  and mkid = 'B01153505' and action = '/bdm/bdpackage' and method = 'toEdit';
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
               values('B01153505', '/bdm/bdpackage', 'toEdit', '2', '价格信息库-跳转编辑项目清单页面', '2' , 'B00008');
     end if;
     
      num:=0;
      select count(1) into num from bs_qxmx where sid = 'B00008'  and mkid = 'B01153505' and action = '/bdm/bdpackage' and method = 'edit';
      if num = 0 then
         insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
               values('B01153505', '/bdm/bdpackage', 'edit', '2', '价格信息库-编辑项目清单', '2' , 'B00008');
      end if;
    ------------------cheny 2016/08/15 项目采购清单权限配置--end-----------------------------
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/swfupload' and  method='uploadPDF' and sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/common/swfupload','uploadPDF',0,'PDF文件上传',1,'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/common/sealpdf' and  method='sealpdf' and sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/common/sealpdf','sealpdf',1,'进入-PDF-签章页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/sealpdf' and  method='showpdf' and sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/common/sealpdf','showpdf',1,'查看-PDF',1,'M00008');
    end if;
    
    
    ---add by chenxp start 投诉---
	--前台
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='list';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','list','1','查看投诉列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='delete';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','delete','1','删除投诉','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='add';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','add','1','添加投诉','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='save';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','save','1','保存投诉','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='edit';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','edit','1','编辑投诉','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='update';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','update','1','修改投诉','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='tjTssl';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','tjTssl','1','提交投诉','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='info';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','info','1','查看投诉','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and sid = 'M00008' and method='download';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/complaint','download','1','下载附件','1','M00008');
    end if;
    --前台

	--后台
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'B00008' and mkid='B011040' and mid='B0110';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno , styp,sid) 
        values('B011040','B0110','招标管理','投诉受理','/bdm/complaint/list.do','/bdm/complaint/list.do#/bdm/complaint/info.do','1','500','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='list';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','list','2','投诉列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='tssl';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','tssl','2','投诉受理','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='savesl';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','savesl','2','保存投诉受理','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='slfk';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','slfk','2','受理反馈','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='savefk';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','savefk','2','保存受理反馈','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='info';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','info','2','查看投诉','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/complaint' and sid = 'B00008' and method='download';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('B011040','/bdm/complaint','download','2','下载附件','2','B00008');
    end if;
	--后台
	---add by chenxp end   投诉---

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/payment' and METHOD ='callback' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/payment','callback',0,'中金在线支付回调请求',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='choiceExpert';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','choiceExpert','2','选择要替换的专家界面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='toRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','toRepair','2','跳转到补抽专家界面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='repairExpert';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','repairExpert','2','补抽专家','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='confirmRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','confirmRepair','2','确认补抽','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='delRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','delRepair','2','删除补抽','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/kb/toRepair.do') into num from bs_qxsz where sid='M00008' and mkid='M084010';
    if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/toRepair.do') where sid='M00008' and mkid='M084010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090' and method='choiceExpert';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089090','/exp/bidding/buy/ysopen','choiceExpert','2','选择要替换的专家界面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090' and method='toRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089090','/exp/bidding/buy/ysopen','toRepair','2','跳转到补抽专家界面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090' and method='repairExpert';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089090','/exp/bidding/buy/ysopen','repairExpert','2','补抽专家','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090' and method='confirmRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089090','/exp/bidding/buy/ysopen','confirmRepair','2','确认补抽','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='M089090' and method='delRepair';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089090','/exp/bidding/buy/ysopen','delRepair','2','删除补抽','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/ysopen/toRepair.do') into num from bs_qxsz where sid='M00008' and mkid='M089090';
    if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/ysopen/toRepair.do') where sid='M00008' and mkid='M089090';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/public/item' and sid = 'M00008' and method='unitList';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('0','/public/item','unitList','1','AJAX获取专家库单位名称列表','1','M00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/sign' and METHOD ='cancelSign' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/sign','cancelSign',1,'评委取消签到',1,'M00009');
	end if;
	
	
	----add by xuz start----
	num:=0;
    select instr(inurl,'/exp/bidding/buy/gkys/toUpdate.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089096';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/gkys/toUpdate.do') where  sid = 'M00008' and mkid='M089096';
    end if;
    
     num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089096' and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do#/exp/bidding/buy/gkys/toTg.do';    
	if num = 1 then
		update bs_qxsz set inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#/exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#/exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do#/exp/bidding/buy/gkys/toTg.do' where sid='M00008' and mkid='M089096' and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do#/exp/bidding/buy/gkys/toTg.do'; 
	end if;
	---add by xuz end---
	------------------cheny 2016/08/20 评价管理--start-----------------------------
    --修改投标人评价模块
    num:=0;
    select count(1) into num from bs_xtmk where mid = 'M0970' and sid = 'M00008' and url00 is null;
    if num = 1 then
       update bs_xtmk set url00 = '/exp/bidding/sell/evaluate/evalAgency.do', icon = 'iconh' where mid = 'M0970' and mname = '评价';
    end if;
    --修改招标人评价模块
    num:=0;
    select count(1) into num from bs_xtmk where mid = 'M0880' and sid = 'M00008' and url00 is null;
    if num = 1 then
       update bs_xtmk set url00 = '/exp/bidding/buy/evaluate/evalAgency.do', icon = 'iconh' where mid = 'M0880' and sid = 'M00008';
    end if;
    --招标人评价菜单
     num:=0;
     select count(1) into num from bs_qxsz where mid = 'M0880' and sid = 'M00008' and mname = '评价' and name = '评价代理机构';
     if num = 0 then
        insert into bs_qxsz values('M088010', 'M0880', '评价', '评价代理机构', '/exp/bidding/buy/evaluate/evalAgency.do', '/exp/bidding/buy/evaluate/evalAgency.do', '1', '10', '1', '', 'M00008', '1', '1,2,3,4');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxsz where mid = 'M0880' and sid = 'M00008' and mname = '评价' and name = '评价专家';
     if num = 0 then
        insert into bs_qxsz values('M088020', 'M0880', '评价', '评价专家', '/exp/bidding/buy/evaluate/evalExpert.do', '/exp/bidding/buy/evaluate/evalExpert.do', '1', '20', '1', '', 'M00008', '1', '1,2,3,4,5,6,7');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxsz where mid = 'M0880' and sid = 'M00008' and mname = '评价' and name = '评价中标人';
     if num = 0 then
        insert into bs_qxsz values('M088030', 'M0880', '评价', '评价中标人', '/exp/bidding/buy/evaluate/evalSuccBidder.do', '/exp/bidding/buy/evaluate/evalSuccBidder.do', '1', '30', '1', '', 'M00008', '1', '1,2,3,4,5,6,7');
     end if;
     
      num:=0;
      select count(1) into num from bs_qxsz where mid = 'M0880' and sid = 'M00008' and mname = '评价' and name = '评价其它投标人';
      if num = 0 then
         insert into bs_qxsz values('M088040', 'M0880', '评价', '评价其它投标人', '/exp/bidding/buy/evaluate/evalBidder.do', '/exp/bidding/buy/evaluate/evalBidder.do', '1', '40', '1', '', 'M00008', '1', '1,2,3,4,5,6,7');
      end if;
      --投标人评价菜单
      num:=0;
      select count(1) into num from bs_qxsz where mid = 'M0970' and sid = 'M00008' and mname = '评价' and name = '评价代理机构' and url = '/exp/bidding/sell/evaluate/evalAgency.do';
      if num = 0 then
         insert into bs_qxsz values('M097010', 'M0970', '评价', '评价代理机构', '/exp/bidding/sell/evaluate/evalAgency.do', '/exp/bidding/sell/evaluate/evalAgency.do', '1', '10', '1', '', 'M00008', '1', '1,2,3');
      end if;
      
      num:=0;
      select count(1) into num from bs_qxsz where mid = 'M0970' and sid = 'M00008' and mname = '评价' and name = '评价招标人';
      if num = 0 then
         insert into bs_qxsz values('M097020', 'M0970', '评价', '评价招标人', '/exp/bidding/sell/evaluate/evalTenderer.do', '/exp/bidding/sell/evaluate/evalTenderer.do', '1', '20', '1', '', 'M00008', '1', '1,2,3');
      end if;
    ----------------------------------权限明细 start------------------------
    --招标方
     num:=0;
      select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088010' and action = '/exp/bidding/buy/evaluate' and method = 'evalAgency'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088010', '/exp/bidding/buy/evaluate', 'evalAgency', '2', '评价代理机构', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088020' and action = '/exp/bidding/buy/evaluate' and method = 'evalExpert'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088020', '/exp/bidding/buy/evaluate', 'evalExpert', '2', '评价专家', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088030' and action = '/exp/bidding/buy/evaluate' and method = 'evalSuccBidder'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088030', '/exp/bidding/buy/evaluate', 'evalSuccBidder', '2', '评价中标人', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088040' and action = '/exp/bidding/buy/evaluate' and method = 'evalBidder'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088040', '/exp/bidding/buy/evaluate', 'evalBidder', '2', '评价其它投标人', '1', 'M00008');
     end if;
     --投标方
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M097010' and action = '/exp/bidding/sell/evaluate' and method = 'evalAgency'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M097010', '/exp/bidding/sell/evaluate', 'evalAgency', '2', '评价代理机构', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M097020' and action = '/exp/bidding/sell/evaluate' and method = 'evalTenderer'; 
     if num = 0 then
         insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M097020', '/exp/bidding/sell/evaluate', 'evalTenderer', '2', '评价招标人', '1', 'M00008');
     end if;
     --招标方保存
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088010' and action = '/exp/bidding/buy/evaluate' and method = 'saveEvalAgency'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088010', '/exp/bidding/buy/evaluate', 'saveEvalAgency', '2', '保存代理机构评价', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088020' and action = '/exp/bidding/buy/evaluate' and method = 'saveEvalExpert'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088020', '/exp/bidding/buy/evaluate', 'saveEvalExpert', '2', '保存专家评价', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088030' and action = '/exp/bidding/buy/evaluate' and method = 'saveEvalSucc'; 
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088030', '/exp/bidding/buy/evaluate', 'saveEvalSucc', '2', '保存中标人评价', '1', 'M00008');
     end if;
     
     num:=0; 
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M088040' and action = '/exp/bidding/buy/evaluate' and method = 'saveEevalBidder';
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M088040', '/exp/bidding/buy/evaluate', 'saveEevalBidder', '2', '保存其它投标人评价', '1', 'M00008');
     end if;
    --投标方保存
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M097010' and action = '/exp/bidding/sell/evaluate' and method = 'saveEvalAgency';
     if num = 0 then
        insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M097010', '/exp/bidding/sell/evaluate', 'saveEvalAgency', '2', '保存代理机构评价', '1', 'M00008');
     end if;
     
     num:=0;
     select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M097020' and action = '/exp/bidding/sell/evaluate' and method = 'saveEvalTend';
     if num = 0 then
         insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid) values('M097020', '/exp/bidding/sell/evaluate', 'saveEvalTend', '2', '保存招标人评价', '1', 'M00008');
     end if;
    ----------------------------------权限明细 end------------------------
     
    ------------------cheny 2016/08/20 评价管理--end-----------------------------

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/payment' and METHOD ='getEciAccount' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060040','/exp/bidding/sell/payment','getEciAccount',2,'获得中信临时账户',1,'M00008');
	end if;

	
    num:=0;
    select count(1) into num from bs_qxmx where action='/common/sealpdf' and  method='editpdf' and sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('0','/common/sealpdf','editpdf',1,'PDF打开签章',1,'M00008'); 
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='confirmExpert' and mkid='M089040' and  sid='M00008';
	if num=0 then
	   insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	   values('M089040', '/bdp/build/pre/jury', 'confirmExpert', 2, '组建资格预审委员会-确认指定专家', 1, 'M00008');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='confirmExpert' and mkid='M083040' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M083040', '/bdp/build/jury', 'confirmExpert', 2, '组建评标委员会-确认指定专家', 1, 'M00008');
  	end if;
    
    
    
    ---add by xuz start----
	  num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091060' and url='/exp/bidding/sell/pre/dissent/preClariList.do';
	if num = 1 then
		update bs_qxsz set name='提问与回复',qxrole='1' where sid='M00008' and mkid='M091060' and url='/exp/bidding/sell/pre/dissent/preClariList.do'; 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091090' and url='/exp/bidding/sell/tender/hitbid/dissent/yypackList.do';
	if num = 1 then
		update bs_qxsz set qxrole='1,2,3' where sid='M00008' and mkid='M091090' and url='/exp/bidding/sell/tender/hitbid/dissent/yypackList.do'; 
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0920' and mkid='M092070' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed,qxrole)
		values('M092070','M0920','投标','提问与回复','/exp/bidding/sell/zbwjtb/dissent/zbClariList.do','/exp/bidding/sell/zbwjtb/dissent/zbClariList.do#/exp/bidding/sell/zbwjtb/dissent/packlist.do#/exp/bidding/sell/zbwjtb/dissent/toView.do#/exp/bidding/sell/zbwjtb/dissent/toAsk.do#/exp/bidding/sell/zbwjtb/dissent/saveAsk.do#/exp/bidding/sell/zbwjtb/dissent/uploadTwProduct.do#/exp/bidding/sell/zbwjtb/dissent/download.do',1,50,1,'M00008',1,'1,2,3');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='zbClariList' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'zbClariList', 2, '提问与回复列表', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='packlist' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'packlist', 2, '提问与回复过渡页', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='toView' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'toView', 2, '提问与回复查看页面', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='toAsk' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'toAsk', 2, '提问与回复提问页面', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='saveAsk' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'saveAsk', 2, '提问与回复提问保存', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='uploadTwProduct' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'uploadTwProduct', 2, '提问与回复提问附件上传', 1, 'M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/zbwjtb/dissent' and  method='download' and mkid='M092070' and  sid='M00008';
  	if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M092070', '/exp/bidding/sell/zbwjtb/dissent', 'download', 2, '提问与回复提问附件下载', 1, 'M00008');
  	end if;
	---add by xuz end-----

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='signature' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086050','/exp/bidding/buy/scaling','signature',2,'中标通知书-签章',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/getpdf' and METHOD ='signature' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/getpdf','signature',1,'通用获取生成pdf',1,'M00008');
	end if;
	
	--hejw   start--
	  --增加inurl 
	 num:=0;
	 select instr(inurl,'/exp/bidding/buy/scaling/signature.do') into num from bs_qxsz where mkid='M086050' and sid='M00008';
	 if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/signature.do') where mkid='M086050' and sid='M00008';
	 end if;
 
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/sealpdf' and METHOD ='bounced' and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/sealpdf','bounced',1,'打开过渡页面',1,'M00008');
	end if;
	
   num:=0;
   select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and  method='tocomnext' and  sid='M00008';
   if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M083035', '/exp/bidding/buy/yqhs', 'tocomnext', 2, '进入投标确认函', 1, 'M00008');
   end if; 
	--hejw   end--
	
	
   --zhangdl 2016年8月27日10:40:01 查看投标单位 start--
   num:=0;
   select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='showTbdw' and mkid='M089040' and  sid='M00008';
   if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M089040', '/bdp/build/pre/jury', 'showTbdw', 2, '组建资格预审委员会-查看投标单位', 1, 'M00008');
   end if;
   
   num:=0;
   select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='showTbdw' and mkid='M083040' and  sid='M00008';
   if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
	    values('M083040', '/bdp/build/jury', 'showTbdw', 2, '组建评标委员会-查看投标单位', 1, 'M00008');
   end if;
    --zhangdl 2016年8月27日10:40:01 查看投标单位 end--

	--jyh 2016年8月27日15:40:01 资格预审异议调整 start--
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089075' and mname='资格预审' and sid='M00008';
    if num = 1 then
       update bs_qxsz set isuse=0 where mkid='M089075' and mname='资格预审' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089070' and mname='资格预审' and sid='M00008';
    if num = 1 then
       update bs_qxsz set name='异议' where mkid='M089070' and mname='资格预审' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091085' and mname='报名' and sid='M00008';
    if num = 1 then
       update bs_qxsz set isuse=0 where mkid='M091085' and mname='报名' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091080' and mname='报名' and sid='M00008';
    if num = 1 then
       update bs_qxsz set name='异议' where mkid='M091080' and mname='报名' and sid='M00008';
    end if;    
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091090' and mname='报名' and sid='M00008';
    if num = 1 then
       update bs_qxsz set mkid='M092080',mid='M0920',mname='投标',name='异议' where mkid='M091090' and mname='报名' and sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M091090' and sid='M00008';
    if num > 0 then
       update bs_qxmx set mkid='M092080' where sid='M00008' and mkid='M091090';
    end if;      
    
    num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='twclariList' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','twclariList',1,'澄清提问列表查看页面',1,'M00009');
	end if;
    --jyh 2016年8月27日15:40:01 资格预审异议调整 end--


	-- 权限明细 组建资格预审委员会 完成并短信发送
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/build/pre/jury' and METHOD ='doComplete' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089040','/bdp/build/pre/jury','doComplete',2,'组建资格预审委员会-完成并短信发送',1,'M00008');
	end if;		
	-- 权限明细 组建评标委员会 完成并短信发送
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/build/jury' and METHOD ='doComplete' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089040','/bdp/build/jury','doComplete',2,'组建评标委员会-完成并短信发送',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='toSeeBond' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','toSeeBond',1,'评委审查-查看保证金',1,'M00009');
	end if;
	--add by xuz start---
	 num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='refuseDb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086020','/exp/bidding/buy/scaling','refuseDb',2,'定标审核不通过',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/ysbgnotice' and METHOD ='view' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091070','/exp/bidding/sell/ysbgnotice','view',2,'招标变更公告查看',1,'M00008');
	end if;
	
	 num:=0;
    select instr(inurl,'/exp/bidding/sell/ysbgnotice/view.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091070';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/ysbgnotice/view.do') where  sid = 'M00008' and mkid='M091070';
    end if;
    
     num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091070' and name='预审变更公告';    
	if num = 1 then
		update bs_qxsz set name='变更（终止）公告' where sid='M00008' and mkid='M091070' and name='预审变更公告';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091071' and name='招标变更公告';    
	if num = 1 then
		update bs_qxsz set isuse='0' where sid='M00008' and mkid='M091071' and name='招标变更公告';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/yscqnotice' and METHOD ='listZb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091030','/exp/bidding/sell/yscqnotice','listZb',2,'招标澄清文件列表',1,'M00008');
	end if;
	
	 num:=0;
    select instr(inurl,'/exp/bidding/sell/yscqnotice/listZb.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091030';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/yscqnotice/listZb.do') where  sid = 'M00008' and mkid='M091030';
    end if;
    
     num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091030' and name='预审澄清文件领取';    
	if num = 1 then
		update bs_qxsz set name='澄清与修改' where sid='M00008' and mkid='M091030' and name='预审澄清文件领取';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091072' and name='招标澄清文件领取';    
	if num = 1 then
		update bs_qxsz set isuse='0' where sid='M00008' and mkid='M091072' and name='招标澄清文件领取';
	end if;
	--add by xuz end----

	------------------cheny 2016/08/30 终止公告-附件下载--start-----------------------------
    num:=0;
    select count(1) into num from bs_qxmx where action = '/exp/subp/stop/send' and mkid = 'M08305005' and method = 'download';
    if num = 0 then
      insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M08305005', '/exp/subp/stop/send', 'download', 1, '终止公告-附件下载', 1, 'M00008');
    end if;
    ------------------cheny 2016/08/30 终止公告-附件下载--end---------------------------

	------------------cheny 2016/08/25-后台评价管理--start-----------------------------
    --添加"评价管理"菜单项
    num:=0;
    select count(1) into num from bs_xtmk where mid = 'B0120' and sid = 'B00008';
    if num = 0 then
	     insert into bs_xtmk (mid, mname, styp, ordby, sid) values('B0120', '评价管理', '2', '300', 'B00008');	   
    end if;
    --添加"评价信息"子菜单
    num:=0;
    select count(1) into num from bs_qxsz where mkid = 'B012005' and sid = 'B00008' and mid = 'B0120';
    if num = 0 then
	     insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
       values('B012005', 'B0120', '评价管理', '评价信息', '/bdm/evaluation/list.do', '/bdm/evaluation/list.do', '1', '100', '2', null, 'B00008');   
    end if;
  
    --添加访问权限
    num:=0;
    select count(1) into num from bs_qxmx where mkid = 'B012005' and sid = 'B00008' and action = '/bdm/evaluation' and method = 'list';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('B012005', '/bdm/evaluation', 'list', '2', '评价管理-评价列表', '2' , 'B00008');
    end if;
    
    ------------------cheny 2016/08/25-后台评价管理--end-----------------------------
    
    ------------------huyq 2016/08/31-招标管理-正在项目-查询代理项目（用弹出框的形式展现项目信息）--start-----------------------------
    num := 0;
	select count(1) into num from bs_qxmx where METHOD='agentProInfo' and SID='M00008' and ACTION='/exp/bidding/buy/beingPro';
	if num = 0 then
	   insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		 values (bs_qxmx_0.nextval, 'M030020', '/exp/bidding/buy/beingPro', 'agentProInfo', 2, '查询代理项目', 1, 'M00008');
	end if;
    ------------------huyq 2016/08/31-招标管理-正在项目-查询代理项目（用弹出框的形式展现项目信息）--end-----------------------------
	
	--add by chenxp start 查看邀请回执--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='tocomnext' and sid = 'M00008';
    if num = 1 then
        update bs_qxmx set mkid='M083035' where action='/exp/bidding/buy/yqhs' and method='tocomnext' and sid = 'M00008';
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/yqhs/tocomnext.do') into num from bs_qxsz where sid = 'M00008' and mkid='M083035';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/tocomnext.do') where  sid = 'M00008' and mkid='M083035';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='cktbfhz' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083035','/exp/bidding/buy/yqhs','cktbfhz','2','查看投标方邀请确认回执','1','M00008');
    end if;
	--add by chenxp end   查看邀请回执--


	--add by hejw start   --
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and method='sealwtxy' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081045','/exp/bidding/buy/beingPro','sealwtxy','2','代理机构-签章及发送-委托协议','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/common/sealpdf' and method='createpdf' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/common/sealpdf','createpdf','1','创建一个pdf','1','M00008');
    end if;
	--add by hejw end  --


	--add by chexp start 踏勘现场记录 ---
	 num:=0;
     select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083025' and mid='M0830';    
     if num = 0 then
         insert into bs_qxsz(mkid , mid , mname, name , url , inurl , isuse , orderno , styp , sid , qxrole) 
         values('M083025' ,'M0830' , '发标' , '踏勘现场记录' , '/bdp/buy/survey/note/packlist.do','/bdp/buy/survey/note/packlist.do#/bdp/buy/survey/note/viewtkjl.do','1','180','1','M00008' ,'4');
    end if;
      
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/buy/survey/note' and method='packlist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083025','/bdp/buy/survey/note','packlist','2','查看标段包列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/buy/survey/note' and method='viewtkjl' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083025','/bdp/buy/survey/note','viewtkjl','2','查看踏勘记录','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/buy/survey/note' and method='downloadfj' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083025','/bdp/buy/survey/note','downloadfj','2','下载附件','1','M00008');
    end if;
	--add by chexp end  踏勘现场记录 ---

    --去掉-中标通知书确认 hejw-----
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M086055' and sid='M00008' and url='/exp/bidding/buy/scaling/confirmList.do';  
    if num = 1 then
        update bs_qxsz set isuse=0 where mkid='M086055' and sid='M00008' and url='/exp/bidding/buy/scaling/confirmList.do'; 
    end if;
    --去掉-中标通知书确认 hejw-----

	num:=0;
    select count(1) into num from bs_qxsz where mkid='M085020' and sid='M00008' and url='/bdp/mtcfee/expert/packlist.do';  
    if num = 1 then
        update bs_qxsz set name='评委信息维护' where mkid='M085020' and sid='M00008' and url='/bdp/mtcfee/expert/packlist.do' and name='专家咨询维护费'; 
    end if;

	
	------------------zhangdl 2016/09/11-首页-系统公告列表页面和详情页面--start--------------------
    num:=0;
    select count(1) into num from bs_qxmx where mkid = '0' and sid = 'M00008' and action = '/' and method = 'xtggList';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('0', '/', 'xtggList', '0', '首页-系统公告列表页面', '1' , 'M00008');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where mkid = '0' and sid = 'M00008' and action = '/' and method = 'toXtggInfo';
    if num = 0 then
       insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
         values('0', '/', 'toXtggInfo', '0', '首页-系统公告详情页面', '1' , 'M00008');
    end if;
    ------------------zhangdl 2016/09/11-首页-系统公告列表页面和详情页面--end--------------------

	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/invitation' and method='toDownload' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020005','/exp/bidding/sell/invitation','toDownload','2','查看附件','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='xzzy' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01050505','/bdm/expert','xzzy','2','专家管理-选择专业','2','B00008');
    end if;
    
    --add by chenxp start 签收评标报告--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/review/result' and method='qspbbg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M085010','/bdp/review/result','qspbbg','2','签收评标报告','1','M00008');
    end if;
    --add by chenxp end   签收评标报告--

    --add by hejw start   --
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='showYqdw' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020','/exp/bidding/buy/zbwjone','showYqdw','2','邀请单位','1','M00008');
    end if;
    --add by hejw end  --


	--add by chenxp start 踏勘现场通知--
	num:=0;
     select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083025' and mid='M0830';    
     if num = 1 then
         update bs_qxsz set name='踏勘现场' where sid='M00008' and mkid='M083025' and mid='M0830';    
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/buy/survey/note' and method='tktzList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083025','/bdp/buy/survey/note','tktzList','2','踏勘通知列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/buy/survey/note' and method='viewtktz' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083025','/bdp/buy/survey/note','viewtktz','2','查看踏勘通知','1','M00008');
    end if;

    num:=0;
    select instr(inurl,'/bdp/buy/survey/note/tktzList.do') into num from bs_qxsz where sid = 'M00008' and mkid='M083025';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdp/buy/survey/note/tktzList.do') where  sid = 'M00008' and mkid='M083025';
    end if;

    num:=0;
    select instr(inurl,'/bdp/buy/survey/note/viewtktz.do') into num from bs_qxsz where sid = 'M00008' and mkid='M083025';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/bdp/buy/survey/note/viewtktz.do') where  sid = 'M00008' and mkid='M083025';
    end if;
	--add by chenxp end   踏勘现场通知--

	--add by hejw start   --
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='digital' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010','/exp/bidding/buy/kb','digital','2','评委数字证书使用登记表-下载','1','M00008');
    end if;
	--add by hejw end   --


	--add by chenxp start 变更公告--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/bgnotice' and method='list' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set remark = '标段包列表' where action='/exp/bidding/bgnotice' and method='list' and sid = 'M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/bgnotice' and method='bggglist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083050','/exp/bidding/bgnotice','bggglist','2','变更公告列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/bgnotice/bggglist.do') into num from bs_qxsz where sid = 'M00008' and mkid='M083050';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/bgnotice/bggglist.do') where  sid = 'M00008' and mkid='M083050';
    end if;
    --add by chenxp end   变更公告--

	--add by chenxp start 合同签订--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract' and method='refuse' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096010','/exp/bidding/sell/contract','refuse','2','签章驳回','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/contract/refuse.do') into num from bs_qxsz where sid = 'M00008' and mkid='M096010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/refuse.do') where  sid = 'M00008' and mkid='M096010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/contract' and method='refuse' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M087010','/exp/bidding/buy/contract','refuse','2','签章驳回','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/contract/refuse.do') into num from bs_qxsz where sid = 'M00008' and mkid='M087010';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/refuse.do') where  sid = 'M00008' and mkid='M087010';
    end if;
	--add by chenxp end   合同签订--

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='showInfo' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','showInfo',1,'评审汇总-查看详情',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/summary' and METHOD ='reconsider' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/summary','reconsider',1,'评审汇总-复议',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/report' and METHOD ='scoreAgain' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/report','scoreAgain',1,'评分复议',1,'M00009');
	end if;

	--add by hejw start--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='showZbr' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','showZbr','2','查看招标人或代理机构','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='showZbr' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040','/bdp/build/pre/jury','showZbr','2','查看招标人或代理机构','1','M00008');
    end if;
	--add by hejw end--

	--add by chexp start--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and method='dowload' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030020','/exp/bidding/buy/beingPro','dowload','2','下载附件','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and method='ckPackList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030020','/exp/bidding/buy/beingPro','ckPackList','2','查看标段包列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and method='packInfo' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030020','/exp/bidding/buy/beingPro','packInfo','2','查看标段包详情','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/beingPro/ckPackList.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/ckPackList.do') where  sid = 'M00008' and mkid='M030020';
    end if;
   	--add by chenxp end--

	--add by chenxp start  招标项目停用--
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M03002010' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname, name, url,inurl,isuse，orderno,styp,parent,sid) 
         values('M03002010','M0300','招标管理','招标项目停用','','','2','250','1','M030020','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/disablePro' and method='revokePro' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','revokePro','2','撤回招标项目','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/disablePro' and method='blockPro' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','blockPro','2','停用招标项目','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/disablePro' and method='dljagree' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M03002010','/exp/bidding/buy/disablePro','dljagree','2','代理机构同意停用','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and sid = 'M00008' and method='downloadHz';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M092005','/exp/bidding/sell/bidding','downloadHz','2','下载回执','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M081030' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole = '1,2,3,4,5,6,7' where mkid='M081030' and sid='M00008';
    end if;
	--add by chenxp end    招标项目停用--

	num:=0;
    select count(1) into num from bs_qxmx where  action='/common/swfupload' and method='getUploadProgress' and sid = 'M00008';
    if num = 0 then
        INSERT INTO "BS_QXMX" ("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/common/swfupload', 'getUploadProgress', '0', '获取文件上传进度(断点续传用)', '1', 'M00008');
    end if;

    --add 增加预审申请文件开启记录权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='index';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','index','1','预审申请文件开启记录','1','M00009');
    end if;

    --add 增加预审申请文件开启签名页面权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='ysRecord';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','ysRecord','1','预审申请文件开启签名页面','1','M00009');
    end if;
    
    --add 增加预审申请文件开启签名权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='ysjlqz';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','ysjlqz','1','预审申请文件开启签名','1','M00009');
    end if;
    
    --add 增加评审报告权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='psIndex';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','psIndex','1','评审报告','1','M00009');
    end if;
    
    --add 增加查看评审报告权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='toPsbg';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','toPsbg','1','查看评审报告','1','M00009');
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen' and sid = 'M00009'  and mkid='0'  and method='download';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen','download','1','下载附件','1','M00009');
    end if;
    
    --add 增加查看评审报告权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen/kb' and sid = 'M00009'  and mkid='0'  and method='index';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','index','1','查看开标列表','1','M00009');
    end if;  
    
        --add 增加开标详情权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen/kb' and sid = 'M00009'  and mkid='0'  and method='kbRecord';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','kbRecord','1','开标详情','1','M00009');
    end if; 
    
        --add 增加开标签名权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen/kb' and sid = 'M00009'  and mkid='0'  and method='kbjlqz';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','kbjlqz','1','开标签名','1','M00009');
    end if; 
    
        --add 增加评审结果报告过度页面权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen/kb' and sid = 'M00009'  and mkid='0'  and method='packlist';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','packlist','1','评审结果报告过度页面','1','M00009');
    end if; 
    
        --add 增加评审结果报告页面权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/jbropen/kb' and sid = 'M00009'  and mkid='0'  and method='toPsjg';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/jbropen/kb','toPsjg','1','评审结果报告页面','1','M00009');
    end if; 
    
    --add by chenxp start 合同审批履约--
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M087020' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set orderno = 150 where mkid='M087020' and sid = 'M00008';
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M087030' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set orderno = 200 where mkid='M087030' and sid = 'M00008';
    end if;
    --add by chenxp edn  --
	
	--add 增加下载数字证书登记表权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/mtcfee/expert' and sid = 'M00008'  and mkid='M085020'  and method='download';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M085020','/bdp/mtcfee/expert','download','2','下载数字证书登记表','1','M00008');
    end if; 
    
    --CA登录方法
    num:=0;
    select count(1) into num from bs_qxmx where  action='/login' and sid = 'M00000' and method='caLogin';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/login','caLogin','0','招标平台CA登录方法','1','M00000');
    end if; 

    
    --  add by huyq start  --
    num:=0;
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and sid = 'M00009'  and mkid='0'  and method='adjustOrderReport';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/psp/judge/report','adjustOrderReport','1','评标报告-手动调整排序','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and sid = 'M00008'  and mkid='0'  and method='downloadPreFile';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('0','/exp/bidding/buy/ysopen','downloadPreFile','1','资审文件开启记录-下载资审文件','1','M00008');
    end if;
    --  add by huyq end --

	--- add by xuz start---
	 num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='editTbwjDd' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020','/exp/bidding/sell/bidbond/pay','editTbwjDd','2','修改保证金订单页面','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='doUpdateDd' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020','/exp/bidding/sell/bidbond/pay','doUpdateDd','2','修改保证金订单','1','M00008');
    end if;
    
     num:=0;
    select instr(inurl,'/exp/bidding/sell/bidbond/pay/editTbwjDd.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidbond/pay/editTbwjDd.do') where  sid = 'M00008' and mkid='M092020';
    end if;
    
     num:=0;
    select instr(inurl,'/exp/bidding/sell/bidbond/pay/doUpdateDd.do') into num from bs_qxsz where sid = 'M00008' and mkid='M092020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidbond/pay/doUpdateDd.do') where  sid = 'M00008' and mkid='M092020';
    end if;
	---add by xuz end---

	---add by chenxp start签章管理---
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M030040' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname, name, url,inurl,isuse，orderno,styp,sid) 
         values('M030040','M0300','招标管理','签章管理','/exp/bidding/buy/signature/list.do','/exp/bidding/buy/signature/list.do','1','400','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='list' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','list','2','标段包列表','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='seal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','seal','2','签章','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='wtxySeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','wtxySeal','2','委托协议签章','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='cqwjlist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','cqwjlist','2','澄清文件列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/signature/cqwjlist.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/signature/cqwjlist.do') where  sid = 'M00008' and mkid='M030040';
    end if;
    
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='cqwjSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','cqwjSeal','2','澄清文件签章','1','M00008');
    end if;
	---add by chenxp end  签章管理---

	---add by hejw start 投标方 签章管理---
   num:=0;
    select count(1) into num from bs_qxsz where  mkid='M020020' and sid='M00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('M020020','M0200','投标管理','签章管理','/exp/bidding/sell/signature/cqSealList.do','/exp/bidding/sell/signature/cqSealList.do#/exp/bidding/sell/signature/bgList.do', 1, 250, 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='cqSealList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','cqSealList','2','澄清文件签章','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='bgList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','bgList','2','变更公告签章','1','M00008');
    end if;
	---add by hejw end 投标方 签章管理---


	---add by chenxp start  签章管理-资格审核结果通知书---
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='zgshjgSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','zgshjgSeal','2','资格审核结果通知书签章','1','M00008');
    end if;
	---add by chenxp end   签章管理---
	
	---add by jinyanhui start  首页更多页面权限---
	  num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='noticeMore' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','noticeMore','0','系统公告更多页面','1','M00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='ccNoticeMore' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','ccNoticeMore','0','澄清（变更）公告更多页面','1','M00008');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='scaMore' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','scaMore','0','中标候选人公示更多页面','1','M00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='bdZbjgggMore' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','bdZbjgggMore','0','中标结果公告','1','M00008');
    end if;
	---add by jinyanhui end  首页更多页面权限---

	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/webupload' and METHOD ='uploadFile' and STYP=1 and SID='M00008';
	if num = 0 then
		INSERT INTO BS_QXMX("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('0', '/common/webupload', 'uploadFile', '0', '断点文件上传', '1', 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pbmb' and METHOD ='saveToXtmb' and STYP=1 and SID='M00008';
	if num = 0 then
		INSERT INTO BS_QXMX("MKID", "ACTION", "METHOD", "ACCESSTAG", "REMARK", "STYP", "SID") 
		VALUES ('M050005', '/exp/bidding/buy/pbmb', 'saveToXtmb', '2', '模板管理-保存至系统模板', '1', 'M00008');
	end if;
	
	-- 权限明细 判断是否登录ajax 专场设置列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/me/home' and METHOD ='checkislogin' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/me/home','checkislogin',0,'判断是否登录ajax',1,'M00008');
	end if;

	--add by chenxp start 签章管理--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='tbyqslist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','tbyqslist','2','投标邀请书列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/buy/signature/tbyqslist.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030040';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/signature/tbyqslist.do') where  sid = 'M00008' and mkid='M030040';
    end if;
    
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='tbyqsSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','tbyqsSeal','2','投标邀请书签章','1','M00008');
    end if;
	--add by chenxp end  --

	--add by chenxp start 签章管理--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='zbtzsSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','zbtzsSeal','2','中标通知书签章','1','M00008');
    end if;
	--add by chenxp end  --

 	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='decode' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/buy/kb','decode','1','解密快捷入口','1','M00008');
    end if;
    
    --add by chenxp start 签章管理--
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='zbwjSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','zbwjSeal','2','招标文件确认签章','1','M00008');
    end if;

	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='zgyswjSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','zgyswjSeal','2','资格预审文件确认签章','1','M00008');
    end if;
    --add by chenxp end  --

	--add by chenxp start--
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M096020' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set orderno = 150 where mkid='M096020' and sid = 'M00008';
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M096050' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set orderno = 200 where mkid='M096050' and sid = 'M00008';
    end if;
	--add by chenxp end  --

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
