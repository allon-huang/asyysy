DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.87'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	-- 权限明细 客户端 获取标段包标的物列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/common/project' and METHOD ='getPackItemList' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/common/project','getPackItemList',0,'客户端-获取标段包标的物列表',1,'M00008');
	end if;	
	
	--add by zhaiyy 澄清文件（预审）start ---

	------删除老数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082050' and  sid='M00008' and mid='M0820' and name='澄清文件';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE MKID='M082050' AND SID='M00008' AND MID='M0820';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/cqnotice' AND MKID='M082050' AND SID='M00008';
    end if;

	------重新插入数据 澄清文件
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089060' and mid='M0890';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed,qxrole)
      values('M089060','M0890','资格预审','澄清文件发布','/exp/bidding/buy/yscqnotice/list.do','/exp/bidding/buy/yscqnotice/list.do#/exp/bidding/buy/yscqnotice/toAdd.do#/exp/bidding/buy/yscqnotice/save.do#/exp/bidding/buy/yscqnotice/preview.do#/exp/bidding/buy/yscqnotice/submit.do#/exp/bidding/buy/yscqnotice/downLoad.do#/exp/bidding/buy/yscqnotice/edit.do#/exp/bidding/buy/yscqnotice/delete.do#/exp/bidding/buy/yscqnotice/view.do',1,'50',1,'','M00008',1,'008-1-2-2');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='list' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'list', 2, '澄清文件列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='toAdd' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'toAdd', 2, '新增澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='save' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'save', 2, '保存澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='preview' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'preview', 2, '预览澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='submit' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'submit', 2, '更新澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='downLoad' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'downLoad', 2, '下载公告附件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='edit' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'edit', 2, '澄清文件编辑', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='delete' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'delete', 2, '澄清文件删除', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='view' and mkid='M089060' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089060', '/exp/bidding/buy/yscqnotice', 'view', 2, '澄清文件查看', 1, 'M00008');
    end if;
	--add by zhaiyy 澄清文件（预审）end ---

	--add by zhaiyy 变更公告（发标）start ---

	------删除老数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082085' and  sid='M00008' and mid='M0820' and name='变更公告';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE MKID='M082085' AND SID='M00008' AND MID='M0820';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/bgnotice' AND MKID='M082085' AND SID='M00008';
    end if;
    
    ------重新插入数据 澄清文件
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083050' and mid='M0830';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M083050','M0830','发标','变更公告','/exp/bidding/bgnotice/list.do','/exp/bidding/bgnotice/list.do#/exp/bidding/bgnotice/toAdd.do#/exp/bidding/bgnotice/save.do#/exp/bidding/bgnotice/preview.do#/exp/bidding/bgnotice/submit.do#/exp/bidding/bgnotice/downLoad.do#/exp/bidding/bgnotice/edit.do#/exp/bidding/bgnotice/delete.do#/exp/bidding/bgnotice/view.do',1,'200',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='list' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'list', 2, '变更公告列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='toAdd' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'toAdd', 2, '新增变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='save' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'save', 2, '保存变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='preview' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'preview', 2, '预览变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='submit' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'submit', 2, '更新变更公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='downLoad' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'downLoad', 2, '下载公告附件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='edit' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'edit', 2, '变更公告编辑', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='delete' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'delete', 2, '变更公告删除', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='view' and mkid='M083050' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083050', '/exp/bidding/bgnotice', 'view', 2, '变更公告查看', 1, 'M00008');
    end if;
	--add by zhaiyy 变更公告（发标）end ---


	--add by zhaiyy 澄清文件（发标）start ---
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083055' and mid='M0830';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M083055','M0830','发标','澄清文件发布','/exp/bidding/cqnotice/list.do','/exp/bidding/cqnotice/list.do#/exp/bidding/cqnotice/toAdd.do#/exp/bidding/cqnotice/save.do#/exp/bidding/cqnotice/preview.do#/exp/bidding/cqnotice/submit.do#/exp/bidding/cqnotice/downLoad.do#/exp/bidding/cqnotice/edit.do#/exp/bidding/cqnotice/delete.do#/exp/bidding/cqnotice/view.do',1,'100',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='list' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'list', 2, '澄清文件列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='toAdd' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'toAdd', 2, '新增澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='save' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'save', 2, '保存澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='preview' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'preview', 2, '预览澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='submit' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'submit', 2, '更新澄清文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='downLoad' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'downLoad', 2, '下载公告附件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='edit' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'edit', 2, '澄清文件编辑', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='delete' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'delete', 2, '澄清文件删除', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='view' and mkid='M083055' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M083055', '/exp/bidding/cqnotice', 'view', 2, '澄清文件查看', 1, 'M00008');
    end if;
	--add by zhaiyy 澄清文件（发标）end ---


	--更新澄清文件领取为预审澄清变更公告   zhaiyy
	num:=0;
     select count (1) into num from bs_qxsz where sid='M00008' and mkid='M091030';
     if num > 0 then
      update bs_qxsz set name='预审澄清文件领取' where sid='M00008' and mkid='M091030';
     end if;


	--add by zhaiyy 投标方 预审变更公告 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091070' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,parent,sid,fixed)
      values('M091070','M0910','报名','预审变更公告','/exp/bidding/sell/ysbgnotice/list.do',1,'300',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/ysbgnotice' and  method='list' and mkid='M091070' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091070', '/exp/bidding/sell/ysbgnotice', 'list', 2, '变更公告显示', 1, 'M00008');
    end if;
	--add by zhaiyy 投标方 预审变更公告 end--

	--add by zhaiyy 投标方 开标异议 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M093015' and mid='M0930';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M093015','M0930','开标','异议','/exp/bidding/sell/bid/hitbid/dissent/list.do','/exp/bidding/sell/bid/hitbid/dissent/list.do#/exp/bidding/sell/bid/hitbid/dissent/view.do#/exp/bidding/sell/bid/hitbid/dissent/toAdd.do#/exp/bidding/sell/bid/hitbid/dissent/save.do',1,'100',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bid/hitbid/dissent' and  method='list' and mkid='M093015' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M093015', '/exp/bidding/sell/bid/hitbid/dissent', 'list', 2, '异议列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bid/hitbid/dissent' and  method='view' and mkid='M093015' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M093015', '/exp/bidding/sell/bid/hitbid/dissent', 'view', 2, '异议查看', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bid/hitbid/dissent' and  method='toAdd' and mkid='M093015' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M093015', '/exp/bidding/sell/bid/hitbid/dissent', 'toAdd', 2, '异议新增', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bid/hitbid/dissent' and  method='save' and mkid='M093015' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M093015', '/exp/bidding/sell/bid/hitbid/dissent', 'save', 2, '异议保存签章提交', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/bid/hitbid/dissent' and  method='download' and mkid='M093015' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M093015', '/exp/bidding/sell/bid/hitbid/dissent', 'download', 2, '异议附件下载', 1, 'M00008');
    end if;
	--add by zhaiyy 投标方 开标异议  end--


	--mazg start--
	------招标异常固定菜单
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M084030' and mid='M0840';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M084030','M0840','开标','招标异常','/exp/bidding/buy/abnormal/list.do','/exp/bidding/buy/abnormal/list.do#/exp/bidding/buy/abnormal/refer.do#/exp/bidding/buy/abnormal/save.do',1,'300',1,'','M00008',1);
    end if;
    ----招标异常列表
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/abnormal' and  method='list' and mkid='M084030' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M084030', '/exp/bidding/buy/abnormal', 'list', 2, '招标异常列表', 1, 'M00008');
    end if;
    ----招标异常提交页面跳转
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/abnormal' and  method='refer' and mkid='M084030' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M084030', '/exp/bidding/buy/abnormal', 'refer', 2, '招标异常提交页面跳转', 1, 'M00008');
    end if;
    ----招标异常提交保存
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/abnormal' and  method='save' and mkid='M084030' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M084030', '/exp/bidding/buy/abnormal', 'save', 2, '招标异常提交保存', 1, 'M00008');
    end if;
	--mazg end--

	--add by chenxp start ---
	--招标项目查看
  	num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/subproject' and method='subpInfo';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081025', '/exp/bidding/buy/subproject', 'subpInfo', 2, '招标项目-查看', 1, 'M00008'); 
  	end if;
  	
  	--标段包-分类
  	num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/package' and method='getPackgeFldmJson';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081030', '/exp/bidding/buy/package', 'getPackgeFldmJson', 2, '标段包-分类', 1, 'M00008'); 
  	end if;
  	
  	--招标项目-标的物json
 	num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/package' and method='getSubproItemJson';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081030', '/exp/bidding/buy/package', 'getSubproItemJson', 2, '招标项目-标的物json', 1, 'M00008'); 
  	end if;
  	
  	--标段包-查看
  	num:=0;
    select count(1) into num from  bs_qxmx where sid='M00008' and action='/exp/bidding/buy/package' and method='info';     
    if num = 0 then 
      insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
      values ('M081030', '/exp/bidding/buy/package', 'info', 2, '标段包-查看', 1, 'M00008'); 
  	end if;
  	
  	--标段包-标的物附件下载
  	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/package' and sid = 'M00008' and method='dowloadBdwFile' and mkid='M081030';
    if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M081030','/exp/bidding/buy/package','dowloadBdwFile','2','标段包-标的物附件下载','1','M00008');
 	 end if;
	
	--add by chenxp end ---

 	    --add by linqingqing 约标 start ---
    ------新增数据
    num:=0;
    select count(1) into num from bs_xtmk where mid='M0980' and sid='M00008';
    if num=0 then
       insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole,icon) 
       values('M0980','约标',1,210,'M00008','008-1-2-3','iconb');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M098020' and mid='M0980';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
       values('M098020','M0980','约标','选择邀请单位','/exp/bidding/buy/yqhs/hsPackList.do','/exp/bidding/buy/yqhs/hsPackList.do#',1,65,1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M098010' and mid='M0980';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
       values('M098010','M0980','约标','投标邀请书发布','/exp/bidding/buy/yqhs/toUpdate.do','/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toRelease.do#/exp/bidding/buy/yqhs/toSave.do#/exp/bidding/buy/yqhs/toView.do#/exp/bidding/buy/yqhs/toDownload.do#/exp/bidding/buy/yqhs/hsPackList.do#/exp/bidding/buy/yqhs/invitationUnit.do#/exp/bidding/buy/yqhs/saveInvitation.do#/exp/bidding/buy/yqhs/invitationInfor.do#/exp/bidding/buy/yqhs/delInvitation.do',1,75,1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M098015' and mid='M0980';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
       values('M098015','M0980','约标','投标邀请书状态','/exp/bidding/buy/yqhs/toRelease.do','/exp/bidding/buy/yqhs/toRelease.do#/exp/bidding/buy/yqhs/toSave.do#/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toView.do#/exp/bidding/buy/yqhs/toDownload.do#/exp/bidding/buy/yqhs/hsPackList.do#/exp/bidding/buy/yqhs/invitationUnit.do#/exp/bidding/buy/yqhs/saveInvitation.do#/exp/bidding/buy/yqhs/invitationInfor.do#/exp/bidding/buy/yqhs/delInvitation.do',1,80,1,'M00008');
    end if;


    ------更改数据
    num:=0;
    select count(1) into num from bs_qxsz where mid='M0820'and mkid='M082070' and  sid='M00008' and mname='约标';
    if num>0 then
      update bs_qxsz set mid='M0980',mkid='M098005',inurl='/exp/bidding/buy/yqhs/toEdit.do#/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toRelease.do#/exp/bidding/buy/yqhs/toSave.do#/exp/bidding/buy/yqhs/toView.do#/exp/bidding/buy/yqhs/toDownload.do#/exp/bidding/buy/yqhs/hsPackList.do#/exp/bidding/buy/yqhs/invitationUnit.do#/exp/bidding/buy/yqhs/saveInvitation.do#/exp/bidding/buy/yqhs/invitationInfor.do#/exp/bidding/buy/yqhs/delInvitation.do',orderno=70 where mid='M0820' and mkid='M082070' and sid='M00008' and mname='约标';
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yqhs' and sid='M00008';
    if num>0 then
      update bs_qxmx set mkid='M098005' where action='/exp/bidding/buy/yqhs' and sid='M00008';
    end if;
    --add by linqingqing end ---
	--add by xuz start 查看澄清问题---
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='viewClari' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','viewClari',1,'查看问题澄清页面',1,'M00009');
	end if;
	
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/detail' and METHOD ='download' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/detail','download',1,'问题澄清附件下载',1,'M00009');
	end if;
	--add by xuz end ---

	--mazg start--
	------删除购买资格预审文件下面的一些mx，放到费用支付固定菜单中
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='toDd';
    if num=1 then
    	DELETE FROM bs_qxmx WHERE sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='toDd';
    end if;


    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='deleteDd';
    if num=1 then
    	DELETE FROM bs_qxmx WHERE sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='deleteDd';
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='apply';
    if num=1 then
    	DELETE FROM bs_qxmx WHERE sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='apply';
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='toDownPage';
    if num=1 then
    	DELETE FROM bs_qxmx WHERE sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='toDownPage';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='downLoad';
    if num=1 then
    	DELETE FROM bs_qxmx WHERE sid = 'M00008' and mkid = 'M091020' and action = '/exp/bidding/sell/signup' and method ='downLoad';
    end if;
    
    --删除购买资格预审文件列表里面的inurl
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091020' and instr(inurl,'#/exp/bidding/sell/signup/toDd.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/toDd.do','');
	 end if;
	 
	 num:=0;
	 select  count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091020' and instr(inurl,'#/exp/bidding/sell/signup/deleteDd.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/deleteDd.do','');
	 end if;
	 
	 num:=0;
	 select count(1)  into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091020' and instr(inurl,'#/exp/bidding/sell/signup/apply.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/apply.do','');
	 end if;
	 
	 num:=0;
	 select count(1)  into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091020' and instr(inurl,'#/exp/bidding/sell/signup/toDownPage.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/toDownPage.do','');
	 end if;
	 
	 num:=0;
	 select count(1)  into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091020' and instr(inurl,'#/exp/bidding/sell/signup/downLoad.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=replace(inurl,'#/exp/bidding/sell/signup/downLoad.do','');
	 end if;
	 
	--固定菜单费用支付（业务）预审文件
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091040' and mid='M0910';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed) 
       values('M091040','M0910','报名','费用支付（业务）预审文件','/exp/bidding/sell/signup/toDd.do','/exp/bidding/sell/signup/toDd.do#/exp/bidding/sell/signup/deleteDd.do#/exp/bidding/sell/signup/apply.do#/exp/bidding/sell/signup/toDownPage.do#/exp/bidding/sell/signup/downLoad.do',1,400,1,'M00008',1);
    end if;
    
    --添加权限
	-----资格预审文件订单页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','toDd',2,'资格预审文件订单页面',1,'M00008');
	end if;	
	
	-----删除订单
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='deleteDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','deleteDd',2,'删除订单',1,'M00008');
	end if;	
	
	-----申请支付
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='apply' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','apply',2,'申请支付',1,'M00008');
	end if;	
	
	-----资格预审文件下载列表页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toDownPage' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','toDownPage',2,'资格预审文件下载列表页面',1,'M00008');
	end if;	
	
	-----资格预审文件下载
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='downLoad' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','downLoad',2,'资格预审文件下载',1,'M00008');
	end if;	
	
	--固定菜单费用支付（财务）
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091050' and mid='M0910';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed) 
       values('M091050','M0910','报名','费用支付（财务）','/exp/bidding/sell/signup/paylist.do','/exp/bidding/sell/signup/paylist.do#/exp/bidding/sell/signup/payment.do',1,500,1,'M00008',1);
    end if;
    
    -----费用支付列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='paylist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091050','/exp/bidding/sell/signup','paylist',2,'费用支付列表',1,'M00008');
	end if;
	
	-----支付页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='payment' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091050','/exp/bidding/sell/signup','payment',2,'支付页面',1,'M00008');
	end if;
	--mazg end--

	-- 权限设置 菜单选中 发标 保存招标文件参数设置
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/saveZbwjCssz.do') into num from bs_qxsz where sid='M00008' and mkid='M083010';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/saveZbwjCssz.do') where sid='M00008' and mkid='M083010';
	end if;
	-- 权限设置 菜单选中 发标 保存标书模板文件 
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/saveBsmbWj.do') into num from bs_qxsz where sid='M00008' and mkid='M083015';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/saveBsmbWj.do') where sid='M00008' and mkid='M083015';
	end if;
	-- 权限设置 菜单选中 发标 标书文件预览提交
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/doBswjView.do') into num from bs_qxsz where sid='M00008' and mkid='M083020';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/doBswjView.do') where sid='M00008' and mkid='M083020';
	end if;
	-- 权限设置 菜单选中 发标 标书文件发布
	num:=0;
	select instr(inurl,'/exp/bidding/buy/zbwjone/doBswjPublish.do') into num from bs_qxsz where sid='M00008' and mkid='M083030';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/doBswjPublish.do') where sid='M00008' and mkid='M083030';
	end if;
	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='delOwner' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'delOwner', 2, '组建资格预审委员会-删除业主代表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='delOwner' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'delOwner', 2, '组建评标委员会-删除业主代表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='delExpert' and mkid='M089040' and  sid='M00008';
	if num>0 then
		update bs_qxmx set remark='组建资格预审委员会-删除指定专家' where  method='delExpert' and mkid='M089040' and  sid='M00008';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='delExpert' and mkid='M083040' and  sid='M00008';
	if num>0 then
		update bs_qxmx set remark='组建评标委员会-删除指定专家' where  method='delExpert' and mkid='M083040' and  sid='M00008';
	end if;
	--add by longf end ---
    -- 资格预审公告编制 菜单选中
	
	 num:=0;
	select instr(inurl,'/exp/bidding/buy/prefic/updateGgbz.do') into num from bs_qxsz where sid='M00008' and mkid='M089005';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/prefic/updateGgbz.do') where sid='M00008' and mkid='M089005';
	end if;
	num:=0;
	select instr(inurl,'/exp/bidding/buy/prefic/doSave.do') into num from bs_qxsz where sid='M00008' and mkid='M089005';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/prefic/doSave.do') where sid='M00008' and mkid='M089005';
	end if;
	
	-- add by xuz start ---
	--投标人 资格预审文件问题提出与回复
	select count(1) into num from bs_qxsz where mkid='M091060' and mid='M0910' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
		values('M091060','M0910','报名','资格预审文件问题','/exp/bidding/sell/preficClari/list.do','/exp/bidding/sell/preficClari/list.do',1,100,1,'M00008',1);
	end if;
	
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preficClari' and mkid='M091060' and method='list' and styp=1 and sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M091060','/exp/bidding/sell/preficClari','list',2,'资格预审文件问题列表',1,'M00008'); 
	end if;
	
	  --中标人异议回复列表  jinyanhui
	  select count(1) into num from bs_qxsz where mkid='M086090' and mid='M0860' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
	    values('M086090','M0860','定标','异议列表','/exp/bidding/buy/hitbid/dissent/list.do','/exp/bidding/buy/hitbid/dissent/list.do#/exp/bidding/buy/hitbid/dissent/toAccept.do#/exp/bidding/buy/hitbid/dissent/toRecall.do',1,900,1,'M00008',1);
	  end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='list' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','list',2,'中标人异议回复列表',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='toAccept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','toAccept',2,'中标人异议受理',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='accept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','accept',2,'中标人异议受理',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='toRecall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','toRecall',2,'中标人异议反馈',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='recall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','recall',2,'中标人异议反馈',1,'M00008'); 
		end if;  
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='view' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','view',2,'中标人异议查看',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/hitbid/dissent' and mkid='M086090' and method='download' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M086090','/exp/bidding/buy/hitbid/dissent','download',2,'中标人异议下载',1,'M00008'); 
		end if;  
		-- end; 

	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='delGbunit' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'delGbunit', 2, '组建资格预审委员会-删除规避单位', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='delGbunit' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'delGbunit', 2, '组建评标委员会-删除规避单位', 1, 'M00008');
	end if;
	--add by longf end ---

	-- 权限设置 约标 后审公告编制
	update bs_qxsz set name='公告编制' where mkid='M082010' and sid='M00008';
	-- 权限设置 约标 后审公告发布
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0820' and mkid='M082015' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M082015','M0820','约标','公告发布','/exp/bidding/buy/aftfic/toPublish.do','/exp/bidding/buy/aftfic/toPublish.do#/exp/bidding/buy/aftfic/view.do',1,70,1,'M00008');
	end if;	
	-- 权限明细 约标 后审公告发布
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/aftfic' and METHOD ='doPublish' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082015','/exp/bidding/buy/aftfic','doPublish',2,'约标-后审公告发布',1,'M00008');
	end if;
	-- 权限明细 约标 后审公告发布页面
	update bs_qxmx set mkid='M082015',remark='约标-后审公告发布页面' where action='/exp/bidding/buy/aftfic' and method='toPublish';	
	-- 权限明细 约标 后审公告查看页面
	update bs_qxmx set mkid='M082015',remark='约标-后审公告查看页面' where action='/exp/bidding/buy/aftfic' and method='view';
	-- 权限设置 中标 信息管理
	update bs_qxsz set name='信息管理' where mkid='M095010' and mid='M0950' and name='标段包列表' and sid='M00008';
	
	--add by zhaiyy 投标方 资格 预审文件异议 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091080' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M091080','M0910','报名','预审文件异议','/exp/bidding/sell/pre/hitbid/dissent/list.do','/exp/bidding/sell/pre/hitbid/dissent/list.do#/exp/bidding/sell/pre/hitbid/dissent/view.do#/exp/bidding/sell/pre/hitbid/dissent/toAdd.do#/exp/bidding/sell/pre/hitbid/dissent/save.do',1,'600',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/hitbid/dissent' and  method='list'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091080', '/exp/bidding/sell/pre/hitbid/dissent', 'list', 2, '异议列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/hitbid/dissent' and  method='view'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091080', '/exp/bidding/sell/pre/hitbid/dissent', 'view', 2, '异议查看', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/hitbid/dissent' and  method='toAdd' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091080', '/exp/bidding/sell/pre/hitbid/dissent', 'toAdd', 2, '异议新增', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/hitbid/dissent' and  method='save'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091080', '/exp/bidding/sell/pre/hitbid/dissent', 'save', 2, '异议保存签章提交', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/hitbid/dissent' and  method='download'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091080', '/exp/bidding/sell/pre/hitbid/dissent', 'download', 2, '异议附件下载', 1, 'M00008');
    end if;
	--add by zhaiyy 投标方 资格 预审文件异议  end--
	
	--mazg start--
	--购买招标文件列表
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091025' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
      values('M091025','M0910','报名','购买招标文件','/exp/bidding/sell/signup/zblist.do','/exp/bidding/sell/signup/zblist.do#/exp/bidding/sell/signup/zbbuy.do',1,'300',1,'M00008');
    end if;
	
	--购买招标文件列表   
	 num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='zblist'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091025', '/exp/bidding/sell/signup', 'zblist', 2, '-购买招标文件列表', 1, 'M00008');
    end if;
    
    --购买招标文件列表   
	 num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='zbbuy'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091025', '/exp/bidding/sell/signup', 'zbbuy', 2, '购买招标文件', 1, 'M00008');
    end if;
    
    --费用支付（业务）招标文件
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091045' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
      values('M091045','M0910','报名','费用支付（业务）招标文件','/exp/bidding/sell/signup/toZbDd.do','/exp/bidding/sell/signup/toZbDd.do',1,'450',1,'M00008',1);
    end if;
    
    --购买招标文件列表   
	 num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='toZbDd'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091045', '/exp/bidding/sell/signup', 'toZbDd', 2, '购买招标文件订单列表', 1, 'M00008');
    end if;
    
	--mazg end--

	--将中标人异议查看追加到异议列表的inurl后面（定位） zhaiyy----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M086090' and sid='M00008' and mid='M0860' and instr(inurl,'/exp/bidding/buy/hitbid/dissent/view.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/hitbid/dissent/view.do') where  mkid='M086090' and sid='M00008' and mid='M0860';
		end if;
	
	--add by xuz 中标候选人公示 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086010' and mid='M0860';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M086010','M0860','定标','中标候选人公示','/exp/bidding/buy/scaling/toZbhxrgs.do','/exp/bidding/buy/scaling/toZbhxrgs.do#/exp/bidding/buy/scaling/doSave.do',1,'50',1,'','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='toZbhxrgs'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086010', '/exp/bidding/buy/scaling', 'toZbhxrgs', 2, '中标候选人公示页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='doSave'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086010', '/exp/bidding/buy/scaling', 'doSave', 2, '保存中标候选人公示', 1, 'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='downloadGs'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086010', '/exp/bidding/buy/scaling', 'downloadGs', 2, '候选人公示附件下载', 1, 'M00008');
    end if;
	--add by xuz 中标候选人公示 end--

	--add by xuz 定标 start---
		num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086020' and mid='M0860';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M086020','M0860','定标','定标','/exp/bidding/buy/scaling/toScaling.do','/exp/bidding/buy/scaling/toScaling.do',1,'100',1,'','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='toScaling'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086020', '/exp/bidding/buy/scaling', 'toScaling', 2, '定标页面', 1, 'M00008');
    end if;
    
      num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='viewBj'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086020', '/exp/bidding/buy/scaling', 'viewBj', 2, '报价详情页面', 1, 'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='download' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086020', '/exp/bidding/buy/scaling', 'download', 2, '招标文件下载', 1, 'M00008');
    end if;
    
    	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086030' and mid='M0860';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M086030','M0860','定标','定标审核','/exp/bidding/buy/scaling/verifyScaling.do','/exp/bidding/buy/scaling/verifyScaling.do',1,'150',1,'','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='verifyScaling'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086030', '/exp/bidding/buy/scaling', 'verifyScaling', 2, '定标审核页面', 1, 'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='checkScaling'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086030', '/exp/bidding/buy/scaling', 'checkScaling', 2, '定标审核确认', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086040' and mid='M0860';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M086040','M0860','定标','中标结果公告','/exp/bidding/buy/scaling/toZbjggg.do','/exp/bidding/buy/scaling/toZbjggg.do',1,'200',1,'','M00008');
    end if;
    
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='toZbjggg' and   sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086040', '/exp/bidding/buy/scaling', 'toZbjggg', 2, '中标结果公告', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='saveZbjggg'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M086040', '/exp/bidding/buy/scaling', 'saveZbjggg', 2, '保存中标结果公告', 1, 'M00008');
    end if;
	--add by xuz 定标 end---

	--add by zhaiyy 投标方 资格 预审结果异议 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091085' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M091085','M0910','报名','预审结果异议','/exp/bidding/sell/preout/hitbid/dissent/list.do','/exp/bidding/sell/preout/hitbid/dissent/list.do#/exp/bidding/sell/preout/hitbid/dissent/view.do#/exp/bidding/sell/preout/hitbid/dissent/toAdd.do#/exp/bidding/sell/preout/hitbid/dissent/save.do',1,'650',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preout/hitbid/dissent' and  method='list'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091085', '/exp/bidding/sell/preout/hitbid/dissent', 'list', 2, '异议列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preout/hitbid/dissent' and  method='view' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091085', '/exp/bidding/sell/preout/hitbid/dissent', 'view', 2, '异议查看', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preout/hitbid/dissent' and  method='toAdd'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091085', '/exp/bidding/sell/preout/hitbid/dissent', 'toAdd', 2, '异议新增', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preout/hitbid/dissent' and  method='save'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091085', '/exp/bidding/sell/preout/hitbid/dissent', 'save', 2, '异议保存签章提交', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/preout/hitbid/dissent' and  method='download' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091085', '/exp/bidding/sell/preout/hitbid/dissent', 'download', 2, '异议附件下载', 1, 'M00008');
    end if;
	--add by zhaiyy 投标方 资格 预审结果异议  end--


	--add by zhaiyy 投标方 招标文件异议 start--
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091090' and mid='M0910';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M091090','M0910','报名','招标文件异议','/exp/bidding/sell/tender/hitbid/dissent/list.do','/exp/bidding/sell/tender/hitbid/dissent/list.do#/exp/bidding/sell/tender/hitbid/dissent/view.do#/exp/bidding/sell/tender/hitbid/dissent/toAdd.do#/exp/bidding/sell/tender/hitbid/dissent/save.do',1,'700',1,'','M00008',1);
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/tender/hitbid/dissent' and  method='list'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091090', '/exp/bidding/sell/tender/hitbid/dissent', 'list', 2, '异议列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/tender/hitbid/dissent' and  method='view'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091090', '/exp/bidding/sell/tender/hitbid/dissent', 'view', 2, '异议查看', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/tender/hitbid/dissent' and  method='toAdd' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091090', '/exp/bidding/sell/tender/hitbid/dissent', 'toAdd', 2, '异议新增', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/tender/hitbid/dissent' and  method='save'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091090', '/exp/bidding/sell/tender/hitbid/dissent', 'save', 2, '异议保存签章提交', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/tender/hitbid/dissent' and  method='download'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091090', '/exp/bidding/sell/tender/hitbid/dissent', 'download', 2, '异议附件下载', 1, 'M00008');
    end if;
	--add by zhaiyy 投标方 资格  招标文件异议  end--

	--资格预审文件异议列表  zhaiyy
	  select count(1) into num from bs_qxsz where mkid='M089070' and mid='M0890' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed，qxrole)
	    values('M089070','M0890','资格预审','预审文件异议列表','/exp/bidding/buy/pre/hitbid/dissent/list.do','/exp/bidding/buy/pre/hitbid/dissent/list.do#/exp/bidding/buy/pre/hitbid/dissent/toAccept.do#/exp/bidding/buy/pre/hitbid/dissent/toRecall.do#/exp/bidding/buy/pre/hitbid/dissent/view.do',1,200,1,'M00008',1,'008-1-2-2');
	  end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='list' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','list',2,'资格预审文件异议回复列表',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent' and method='toAccept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','toAccept',2,'资格预审文件异议受理',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='accept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','accept',2,'资格预审文件异议受理',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='toRecall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','toRecall',2,'资格预审文件异议反馈',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='recall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','recall',2,'资格预审文件异议反馈',1,'M00008'); 
		end if;  
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='view' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','view',2,'资格预审文件异议查看',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/pre/hitbid/dissent'  and method='download' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089070','/exp/bidding/buy/pre/hitbid/dissent','download',2,'资格预审文件异议下载',1,'M00008'); 
		end if;  
		-- end; 


	--资格预审结果异议列表  zhaiyy
	  select count(1) into num from bs_qxsz where mkid='M089075' and mid='M0890' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed，qxrole)
	    values('M089075','M0890','资格预审','预审结果异议列表','/exp/bidding/buy/preout/hitbid/dissent/list.do','/exp/bidding/buy/preout/hitbid/dissent/list.do#/exp/bidding/buy/preout/hitbid/dissent/toAccept.do#/exp/bidding/buy/preout/hitbid/dissent/toRecall.do#/exp/bidding/buy/preout/hitbid/dissent/view.do',1,300,1,'M00008',1,'008-1-2-2');
	  end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent'  and method='list' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','list',2,'资格预审结果异议回复列表',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent'  and method='toAccept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','toAccept',2,'资格预审结果异议受理',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent'  and method='accept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','accept',2,'资格预审结果异议受理',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent'  and method='toRecall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','toRecall',2,'资格预审结果异议反馈',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent' and method='recall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','recall',2,'资格预审结果异议反馈',1,'M00008'); 
		end if;  
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent' and method='view' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','view',2,'资格预审结果异议查看',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/preout/hitbid/dissent'  and method='download' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M089075','/exp/bidding/buy/preout/hitbid/dissent','download',2,'资格预审结果异议下载',1,'M00008'); 
		end if;  
		-- end;


	--招标文件异议列表  zhaiyy
	  select count(1) into num from bs_qxsz where mkid='M083060' and mid='M0830' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
	    values('M083060','M0830','发标','异议列表','/exp/bidding/buy/tender/hitbid/dissent/list.do','/exp/bidding/buy/tender/hitbid/dissent/list.do#/exp/bidding/buy/tender/hitbid/dissent/toAccept.do#/exp/bidding/buy/tender/hitbid/dissent/toRecall.do#/exp/bidding/buy/tender/hitbid/dissent/view.do',1,300,1,'M00008',1);
	  end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='list' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','list',2,'招标异议回复列表',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='toAccept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','toAccept',2,'招标异议受理',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='accept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','accept',2,'招标异议受理',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='toRecall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','toRecall',2,'招标异议反馈',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='recall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','recall',2,'招标异议反馈',1,'M00008'); 
		end if;  
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='view' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','view',2,'招标异议查看',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/tender/hitbid/dissent'  and method='download' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M083060','/exp/bidding/buy/tender/hitbid/dissent','download',2,'招标异议下载',1,'M00008'); 
		end if;  
		-- end;


	--开标过程异议列表  zhaiyy
	  select count(1) into num from bs_qxsz where mkid='M084040' and mid='M0840' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
	    values('M084040','M0840','开标','异议列表','/exp/bidding/buy/bid/hitbid/dissent/list.do','/exp/bidding/buy/bid/hitbid/dissent/list.do#/exp/bidding/buy/bid/hitbid/dissent/toAccept.do#/exp/bidding/buy/bid/hitbid/dissent/toRecall.do#/exp/bidding/buy/bid/hitbid/dissent/view.do',1,400,1,'M00008',1);
	  end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='list' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','list',2,'开标异议回复列表',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='toAccept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','toAccept',2,'开标异议受理',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='accept' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','accept',2,'开标异议受理',1,'M00008'); 
		end if;
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='toRecall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','toRecall',2,'开标异议反馈',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='recall' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','recall',2,'开标异议反馈',1,'M00008'); 
		end if;  
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='view' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','view',2,'开标异议查看',1,'M00008'); 
		end if; 
	  
	  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/bid/hitbid/dissent'  and method='download' and styp=1 and sid='M00008';
	  if num=0 then
	    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M084040','/exp/bidding/buy/bid/hitbid/dissent','download',2,'开标异议下载',1,'M00008'); 
		end if;  
		-- end;


	----------2016/06/27 hanglong 合同管理 start------------------
	----------买家合同管理----------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M087010', 'M0870', '合同执行', '合同查询', '/exp/bidding/buy/contract/list.do', '/exp/bidding/buy/contract/list.do#/exp/bidding/buy/contract/toAdd.do#/exp/bidding/buy/contract/save.do#/exp/bidding/buy/contract/showInfo.do#/exp/bidding/buy/contract/showContract.do#/exp/bidding/buy/contract/downLoad.do#/exp/bidding/buy/contract/doSubmit.do', 1, 100, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='list' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087010', '/exp/bidding/buy/contract', 'list', 2, '合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='toAdd' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'toAdd', 2, '新增页面', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='save'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'save', 2, '保存合同信息', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='showInfo'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'showInfo', 2, '合同查看编辑', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='showContract' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'showContract', 2, '合同详情', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='downLoad' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'downLoad', 2, '合同附件下载', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='doSubmit'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'doSubmit', 2, '合同提交', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='packageList' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'packageList', 2, '标段包列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='packageView' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M087010', '/exp/bidding/buy/contract', 'packageView', 2, '标段包查看', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/contract/packageList.do') into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/packageList.do') where sid='M00008' and mkid='M087010' and mid='M0870';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/contract/packageView.do') into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/packageView.do') where sid='M00008' and mkid='M087010' and mid='M0870';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='audit' and mkid='M087010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087010', '/exp/bidding/buy/contract', 'audit', 2, '合同确认', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/contract/audit.do') into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/audit.do') where sid='M00008' and mkid='M087010' and mid='M0870';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='dowloadBdwFile'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087010', '/exp/bidding/buy/contract', 'dowloadBdwFile', 2, '标段包附件下载', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/contract/dowloadBdwFile.do') into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/dowloadBdwFile.do') where sid='M00008' and mkid='M087010' and mid='M0870';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract' and  method='agree'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087010', '/exp/bidding/buy/contract', 'agree', 2, '签章确认', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/buy/contract/agree.do') into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/contract/agree.do') where sid='M00008' and mkid='M087010' and mid='M0870';
		end if;
	end if;
	
	--------卖家合同管理---------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M096010', 'M0960', '签订合同', '合同查询', '/exp/bidding/sell/contract/list.do', '/exp/bidding/sell/contract/list.do##/exp/bidding/sell/contract/showContract.do#/exp/bidding/sell/contract/downLoad.do#/exp/bidding/sell/contract/audit.do', 1, 100, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='list'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096010', '/exp/bidding/sell/contract', 'list', 2, '合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='showContract'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096010', '/exp/bidding/sell/contract', 'showContract', 2, '合同详情', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='downLoad'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096010', '/exp/bidding/sell/contract', 'downLoad', 2, '合同附件下载', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='audit'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096010', '/exp/bidding/sell/contract', 'audit', 2, '合同确认', 1, 'M00008');
	end if;
	
	---------------------------
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='toAdd'  and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'toAdd', 2, '新增页面', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/toAdd.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/toAdd.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='save' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'save', 2, '保存合同信息', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/save.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/save.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='showInfo' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'showInfo', 2, '合同查看编辑', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/showInfo.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/showInfo.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='doSubmit' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'doSubmit', 2, '合同提交', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/doSubmit.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/doSubmit.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='packageList' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'packageList', 2, '标段包列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/packageList.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/packageList.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='packageView' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'packageView', 2, '标段包查看', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/packageView.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/packageView.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='dowloadBdwFile' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'dowloadBdwFile', 2, '标段包附件下载', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/dowloadBdwFile.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/dowloadBdwFile.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract' and  method='agree' and mkid='M096010' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M096010', '/exp/bidding/sell/contract', 'agree', 2, '签章确认', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/contract/agree.do') into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/agree.do') where sid='M00008' and mkid='M096010' and mid='M0960';
		end if;
	end if;
	---------------------------
	
	num:=0;
	select count(1) into num from bs_xtmk where Mid='M0870' and  sid='M00008';
	if num=1 then
		update bs_xtmk set url00 = '/exp/bidding/buy/contract/list.do' where Mid='M0870' and  sid='M00008';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where Mid='M0960' and  sid='M00008';
	if num=1 then
		update bs_xtmk set url00 = '/exp/bidding/sell/contract/list.do' where Mid='M0960' and  sid='M00008';
	end if;
	----------2016/06/27 hanglong 合同管理 end------------------
	
	------mazg start----
	---删除费用支付（财务）里面的inurl的#/exp/bidding/sell/signup/deleteDd.do#/exp/bidding/sell/signup/apply.do
	 num:=0;
	 select count(1)  into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/deleteDd.do#/exp/bidding/sell/signup/apply.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=replace(inurl,'#/exp/bidding/sell/signup/deleteDd.do#/exp/bidding/sell/signup/apply.do','');
	 end if;
	 ---将删除和申请的明细删掉
	num:=0;
	 select count(1)  into num from bs_qxmx where sid = 'M00008' and mkid ='M091040' and action='/exp/bidding/sell/signup' and method='deleteDd';
	 if num = 1 then
	 	delete from bs_qxmx where sid = 'M00008' and mkid ='M091040' and action='/exp/bidding/sell/signup' and method='deleteDd';
	 end if;
	 
	num:=0;
	 select count(1)  into num from bs_qxmx where sid = 'M00008' and mkid ='M091040' and action='/exp/bidding/sell/signup' and method='apply';
	 if num = 1 then
	 	delete from bs_qxmx where sid = 'M00008' and mkid ='M091040' and action='/exp/bidding/sell/signup' and method='apply';
	 end if;
	
	-----删除订单
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='deleteDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/signup','deleteDd',1,'删除订单',1,'M00008');
	end if;	
	
	-----申请支付
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='apply' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/bidding/sell/signup','apply',1,'申请支付',1,'M00008');
	end if;
	------mazg end-----

	-- 系统模块 报名 预审
	update bs_xtmk set qxrole='008-2-1-1' where mid='M0910' and sid='M00008';
	-- 系统模块 报名 后审
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0990' and sid='M00008';
	if num = 0 then
	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole,icon)
	 values('M0990','报名',1,150,'M00008','008-2-1-2','icona');
	end if;
	-- 权限设置 报名 后审 招标公告查看及报名
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091010' and sid='M00008' and url='/exp/bidding/sell/signup/toZbSignup.do';
	if num = 1 then
		update bs_qxsz set mkid='M099005',mid='M0990',orderno='100' where mkid='M091010' and sid='M00008' and url='/exp/bidding/sell/signup/toZbSignup.do';
	end if;
	-- 权限明细 报名 后审 报名(招标公告)页面
	update bs_qxmx set mkid='M099005' where action='/exp/bidding/sell/signup' and method='toZbSignup';
	-- 权限明细 报名 后审 报名
	update bs_qxmx set mkid='M099005',accesstag=0 where action='/exp/bidding/sell/signup' and method='doSignup';
	
	--mazg start--
	--费用支付（业务）招标文件添加inurl
	num:=0;
	select count(1) into num from	bs_qxsz where mkid='M091045' and sid='M00008' and mid='M0910' and instr(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do') where mkid='M091045' and sid='M00008' and mid='M0910';
	end if;
	
	num:=0;
	select count(1) into num from	bs_qxsz where mkid='M091045' and sid='M00008' and mid='M0910' and instr(inurl,'#/exp/bidding/sell/signup/downLoadZb.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/downLoadZb.do') where mkid='M091045' and sid='M00008' and mid='M0910';
	end if;
	--mazg end--

	----chenxp start---
	--待开标列表
  
  	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M084010';
   	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno,styp,  sid) 
    	values('M084010', 'M0840', '开标', '待开标列表','/exp/bidding/buy/kb/kbPackList.do','/exp/bidding/buy/kb/kbPackList.do#/exp/bidding/buy/kb/packageOpen.do#/exp/bidding/buy/kb/closePack.do#/exp/bidding/buy/kb/saveClosePack.do', 1,100, 1, 'M00008');
 	end if;  

  	num:=0;
 	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010'  and method='kbPackList';
  	if num = 0 then
   	 	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','kbPackList','2','待开标列表','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010'  and method='packageOpen';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
     	values('M084010','/exp/bidding/buy/kb','packageOpen','2','开标','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008' and mkid='M084010'  and method='closePack';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','closePack','2','关闭项目包','1','M00008');
    end if; 
  
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='saveClosePack';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','saveClosePack','2','保存关闭项目包','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='addZbStopGg';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','addZbStopGg','2','添加招标终止公告','1','M00008');
    end if;  
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='saveZbStopGg';
    if num = 0 then
   	 	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M084010','/exp/bidding/buy/kb','saveZbStopGg','2','保存招标终止公告','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084010' and method='ggqz';
    if num = 0 then
   		 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
   	     values('M084010','/exp/bidding/buy/kb','ggqz','2','招标终止公告发布','1','M00008');
  	end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008' and method='dowload' and mkid='M084010';
    if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M084010','/exp/bidding/buy/kb','dowload','2','关闭标段包物附件下载','1','M00008');
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/kb/addZbStopGg.do') into num from bs_qxsz where sid='M00008' and mkid='M084010';
    if num = 0 then
   		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/addZbStopGg.do') where sid='M00008' and mkid='M084010';
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/kb/saveZbStopGg.do') into num from bs_qxsz where sid='M00008' and mkid='M084010';
    if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/saveZbStopGg.do') where sid='M00008' and mkid='M084010';
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/kb/ggqz.do') into num from bs_qxsz where sid='M00008' and mkid='M084010';
    if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/ggqz.do') where sid='M00008' and mkid='M084010';
    end if;
  
    num:=0;
    select instr(inurl,'/exp/bidding/buy/kb/dowload.do') into num from bs_qxsz where sid='M00008' and mkid='M084010';
    if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/dowload.do') where sid='M00008' and mkid='M084010';
    end if;
  
  
  	--开标记录确认
  	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M084020';
   	if num = 0 then
    	insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno,styp,  sid) 
    	values('M084020', 'M0840', '开标', '开标记录确认','/exp/bidding/buy/kb/kbRecord.do','/exp/bidding/buy/kb/kbRecord.do', 1,200, 1, 'M00008');
    end if;  
  
  	--开标记录确认
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084020' and method='kbRecord';
  	if num = 0 then
    	 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	 values('M084020','/exp/bidding/buy/kb','kbRecord','2','开标记录确认','1','M00008');
 	 end if; 
  
  	--开标记录签章
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084020' and method='kbjlqz';
  	if num = 0 then
  	   insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
   	   values('M084020','/exp/bidding/buy/kb','kbjlqz','2','开标记录签章确认','1','M00008');
    end if; 
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/kb/kbjlqz.do') into num from bs_qxsz where sid='M00008' and mkid='M084020';
  	if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/kbjlqz.do') where sid='M00008' and mkid='M084020';
  	end if;
	----chenxp end-----

		---------- zhaiyy 资格预审澄清/变更 start------------------
	--更新   zhaiyy
	num:=0;
     select count (1) into num from bs_qxmx where sid='M00008' and mkid='M089050' and method='submit';
     if num > 0 then
      update bs_qxmx set remark='提交变更公告' where sid='M00008' and mkid='M089050' and method='submit';
     end if;
     
     num:=0;
     select count (1) into num from bs_qxmx where sid='M00008' and mkid='M089060' and method='submit';
     if num > 0 then
      update bs_qxmx set remark='提交澄清公告' where sid='M00008' and mkid='M089060' and method='submit';
     end if;

	--新增
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysbgnotice' and  method='update' and mkid='M089050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M089050', '/exp/bidding/buy/ysbgnotice', 'update', 2, '更新变更公告', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/yscqnotice' and  method='update' and mkid='M089060' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M089060', '/exp/bidding/buy/yscqnotice', 'update', 2, '更新澄清公告', 1, 'M00008');
	end if;
	
	--追加澄清变更列表的inurl后面（定位）----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M089050' and sid='M00008' and mid='M0890' and instr(inurl,'/exp/bidding/buy/ysbgnotice/update.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/ysbgnotice/update.do') where  mkid='M089050' and sid='M00008' and mid='M0890';
		end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M089060' and sid='M00008' and mid='M0890' and instr(inurl,'/exp/bidding/buy/yscqnotice/update.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yscqnotice/update.do') where  mkid='M089060' and sid='M00008' and mid='M0890';
		end if;
	
	---------- zhaiyy 资格预审 澄清/变更 end------------------


		---------- zhaiyy 发标 澄清/变更 start------------------
	--更新   zhaiyy
	num:=0;
     select count (1) into num from bs_qxmx where sid='M00008' and mkid='M083050' and method='submit';
     if num > 0 then
      update bs_qxmx set remark='提交变更公告' where sid='M00008' and mkid='M083050' and method='submit';
     end if;
     
     num:=0;
     select count (1) into num from bs_qxmx where sid='M00008' and mkid='M083055' and method='submit';
     if num > 0 then
      update bs_qxmx set remark='提交澄清公告' where sid='M00008' and mkid='M083055' and method='submit';
     end if;

	--新增
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/bgnotice' and  method='update' and mkid='M083050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M083050', '/exp/bidding/bgnotice', 'update', 2, '更新变更公告', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/cqnotice' and  method='update' and mkid='M083055' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M083055', '/exp/bidding/cqnotice', 'update', 2, '更新澄清公告', 1, 'M00008');
	end if;
	
	--追加澄清变更列表的inurl后面（定位）----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M083050' and sid='M00008' and mid='M0830' and instr(inurl,'/exp/bidding/bgnotice/update.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/bgnotice/update.do') where  mkid='M083050' and sid='M00008' and mid='M0830';
		end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M083055' and sid='M00008' and mid='M0830' and instr(inurl,'/exp/bidding/cqnotice/update.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/cqnotice/update.do') where  mkid='M083055' and sid='M00008' and mid='M0830';
		end if;
	
	---------- zhaiyy 发标 澄清/变更 end------------------
	
	-----chenxp start--
	--检测开标记录是否可以进行下一步
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and sid = 'M00008'  and mkid='M084020' and method='checkPack';
  	if num = 0 then
  	   insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M084020','/exp/bidding/buy/kb','checkPack','2','检测开标记录','1','M00008');
  	end if; 
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/kb/checkPack.do') into num from bs_qxsz where sid='M00008' and mkid='M084020';
  	if num = 0 then
  		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/checkPack.do') where sid='M00008' and mkid='M084020';
  	end if;
  	----chenxp end-----

	---------- zhaiyy 中标候选人下载 start------------------
	--新增
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/hitbid/publicity' and  method='download' and mkid='M095020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)  
		VALUES ('M095020', '/exp/bidding/sell/hitbid/publicity', 'download', 2, '附件下载', 1, 'M00008');
	end if;
	
	--追加inurl后面（定位）----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M095020' and sid='M00008' and mid='M0950' and instr(inurl,'/exp/bidding/sell/hitbid/publicity/download.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/publicity/download.do') where  mkid='M095020' and sid='M00008' and mid='M0950';
		end if;
	
	---------- zhaiyy 中标候选人下载 end------------------

  --add by jinyanhui start 注册会员权限参数设置--
  num:=0;
    select count(1) into num from bs_cssz where cskey='JBZC_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('JBZC_GROUP_QX','会员注册权限组','','','系统管理员','会员注册权限组','1',1770);
	 end if; 

  --add by jinyanhui start 后台审核角色参数设置--
  num:=0;
    select count(1) into num from bs_cssz where cskey='B_ROLE_USER_AUDIT';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz) 
      values('B_ROLE_USER_AUDIT','启用后台审核角色功能','1','1','系统管理员','若启用，前台会员角色选择需要平台审核','1',1780,'1 - 启用 0 - 禁用；');
	 end if;  
	 
	 --mazg start--
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='payMoney' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091050','/exp/bidding/sell/signup','payMoney',2,'付钱',1,'M00008');
	end if;
	--mazg end--

  --add by jinyanhui start 后台审核角色参数设置--
  num:=0;
    select count(1) into num from bs_cssz_ext where typ='B_ROLE_USER_AUDIT' and cskey='0';
    if num = 0 then
      insert into bs_cssz_ext(typ,cskey,csvalue) 
      values('B_ROLE_USER_AUDIT','0','禁用');
	 end if; 
   
  --add by jinyanhui start 后台审核角色参数设置--
  num:=0;
    select count(1) into num from bs_cssz_ext where typ='B_ROLE_USER_AUDIT' and cskey='1';
    if num = 0 then
      insert into bs_cssz_ext(typ,cskey,csvalue) 
      values('B_ROLE_USER_AUDIT','1','启用');
	 end if; 
	
	--mazg start--
	------后审-购买招标文件
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M099010' and mid='M0990';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M099010','M0990','报名','购买招标文件','/exp/bidding/sell/signup/hszblist.do','/exp/bidding/sell/signup/hszblist.do',1,'200',1,'','M00008');
    end if;
    
    --购买招标文件列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hszblist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099010','/exp/bidding/sell/signup','hszblist',2,'购买招标文件列表',1,'M00008');
	end if;
	--购买招标文件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hszbbuy' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099010','/exp/bidding/sell/signup','hszbbuy',2,'购买招标文件',1,'M00008');
	end if;
	
    ------后审-费用支付（业务）招标文件--固定菜单
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M099060' and mid='M0990';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M099060','M0990','报名','费用支付（业务）招标文件','/exp/bidding/sell/signup/toHsZbDd.do','/exp/bidding/sell/signup/toHsZbDd.do#/exp/bidding/sell/signup/toHsDownPage.do',1,'400',1,'','M00008',1);
    end if;
    
    --我的订单（招标文件）--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toHsZbDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099060','/exp/bidding/sell/signup','toHsZbDd',2,'我的订单（招标文件）--后审',1,'M00008');
	end if;
	--页面跳转招标文件下载页面--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toHsDownPage' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099060','/exp/bidding/sell/signup','toHsDownPage',2,'页面跳转招标文件下载页面--后审',1,'M00008');
	end if;
	--招标文件下载--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hsdownLoadZb' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099060','/exp/bidding/sell/signup','hsdownLoadZb',2,'招标文件下载--后审',1,'M00008');
	end if;
	
    ------后审-费用支付（财务）--固定菜单
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M099070' and mid='M0990';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed)
      values('M099070','M0990','报名','费用支付（财务）','/exp/bidding/sell/signup/hspaylist.do','/exp/bidding/sell/signup/hspaylist.do',1,'500',1,'','M00008',1);
    end if;
    
    --财务付款列表页面--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hspaylist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099070','/exp/bidding/sell/signup','hspaylist',2,'财务付款列表页面--后审',1,'M00008');
	end if;
	
	 --支付页面（页面跳转）--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hspayment' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099070','/exp/bidding/sell/signup','hspayment',2,'支付页面（页面跳转）--后审',1,'M00008');
	end if;
	
	--付钱--后审
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='hsPayMoney' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M099070','/exp/bidding/sell/signup','hsPayMoney',2,'付钱--后审',1,'M00008');
	end if;
	--mazg end--
	 
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
	
	--投标方开标确认
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/kbqd' and  method='confirmRecord' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M093010','/exp/bidding/sell/kbqd','confirmRecord',2,'投标方-开标记录确认',1,'M00008');
    end if;

	 --add by linqingqing 约标 start ---
   ------新增数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M086050' and mid='M0860';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed) 
       values('M086050','M0860','定标','货物中标通知书','/exp/bidding/buy/scaling/toHwTzs.do','/exp/bidding/buy/scaling/toHwTzs.do',1,450,1,'M00008',1);
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M086060' and mid='M0860';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed) 
       values('M086060','M0860','定标','工程中标通知书','/exp/bidding/buy/scaling/toGcTzs.do','/exp/bidding/buy/scaling/toGcTzs.do',1,460,1,'M00008',1);
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M086070' and mid='M0860';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed) 
       values('M086070','M0860','定标','招标结果通知书','/exp/bidding/buy/scaling/toJgTzs.do','/exp/bidding/buy/scaling/toJgTzs.do',1,470,1,'M00008',1);
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where sid='M00008' and method='tzsSave' and action='/exp/bidding/buy/scaling';
    if num=0 then 
       insert into bs_qxmx t (mkid,action,method,accesstag,remark,styp,sid) 
       values('M08605005','/exp/bidding/buy/scaling','tzsSave',2,'保存通知书',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where  sid='M00008' and method='tzsTJ' and action='/exp/bidding/buy/scaling';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M08605010','/exp/bidding/buy/scaling','tzsTJ',2,'签章并提交',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where  sid='M00008' and method='tzsFS' and action='/exp/bidding/buy/scaling';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M08605015','/exp/bidding/buy/scaling','tzsFS',2,'发送中标通知书',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where  sid='M00008' and method='tzsQT' and action='/exp/bidding/buy/scaling';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M08605020','/exp/bidding/buy/scaling','tzsQT',2,'委托招标中存在：法人代表签章并发送中标通知书',1,'M00008');
    end if;
    	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='toHwTzs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086030','/exp/bidding/buy/scaling','toHwTzs',2,'进入货物通知书',1,'M00008');
	end if;

	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='toGcTzs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086030','/exp/bidding/buy/scaling','toGcTzs',2,'进入工程通知书',1,'M00008');
	end if;

	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/scaling' and METHOD ='toJgTzs' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M086030','/exp/bidding/buy/scaling','toJgTzs',2,'进入招标结果通知书',1,'M00008');
	end if;
	
	--delete from bs_xtmk where mid='M0980' and mname='约标' and qxrole='008-1-2-3' and sid='M00008';
	--update bs_qxsz set mkid='M082020', mid='M0820', qxrole='1' where mid='M0980' and mname='约标' and name='投标邀请书状态' and sid='M00008' and mkid='M098015';
	--update bs_qxsz set mkid='M082025', mid='M0820', qxrole='1' where mid='M0980' and mname='约标' and name='选择邀请单位' and sid='M00008' and mkid='M098020';
	--update bs_qxsz set mkid='M082030', mid='M0820', qxrole='1' where mid='M0980' and mname='约标' and name='投标邀请书发布' and sid='M00008' and mkid='M098010';
	--update bs_qxsz set mkid='M082035', mid='M0820', qxrole='1' where mid='M0980' and mname='约标' and name='投标邀请书编制' and sid='M00008' and mkid='M098005';
	--update bs_qxsz set qxrole='2' where mkid='M082015' and mid='M0820' and sid='M00008';
	--update bs_qxsz set qxrole='2' where mkid='M082010' and mid='M0820' and sid='M00008';
	--update bs_qxmx set mkid='M082035' where action='/exp/bidding/buy/yqhs' and sid='M00008';
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M098020'  and SID='M00008' ;
	if num > 0 then
	delete from bs_qxsz where mkid='M098020'  and SID='M00008';
	end if;	
  
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M098010' and SID='M00008' ;
	if num > 0 then
	delete from bs_qxsz where mkid='M098010'  and SID='M00008';
	end if;	

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M098015' and SID='M00008' ;
	if num > 0 then
	delete from bs_qxsz where mkid='M098015' and SID='M00008';
	end if;	

	num:=0;
	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and SID='M00008' ;
	if num > 0 then
	update bs_qxmx set mkid='M082035' where action='/exp/bidding/buy/yqhs' and SID='M00008';
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
	   
	num:=0;
  	select count(1) into num from bs_qxsz where mkid='M082070' and mid='M0820' and url='/exp/bidding/buy/prefic/index.do' and sid='M00008';
 	if num > 0 then
	delete from bs_qxsz where mkid='M082070' and mid='M0820' and url='/exp/bidding/buy/prefic/index.do' and sid='M00008';
    end if; 
	
    --add by linqingqing end ---
	
    ------新增数据
    num:=0;
    select count(1) into num from bs_xtmk where mid='M0396' and sid='M00000';
    if num=0 then
       insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole,icon) 
       values('M0396','交易角色管理',1,210,'M00000','','');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M039610' and mid='M0396' and sid='M00000';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
       values('M039610','M0396','交易角色管理','角色管理','/bsp/menber/jsxz/list.do','/bsp/menber/jsxz/list.do#/bsp/menber/jsxz/toAdd.do#',1,100,1,'M00000');
    end if;
    
    -- 系统模块 报名 预审
	update bs_xtmk set qxrole='008-2-1' where mid='M0910' and sid='M00008';
	-- 系统模块 报名 后审 删除
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0990' and sid='M00008' and mname='报名';
	if num = 1 then
		delete from bs_xtmk where mid='M0990' and sid='M00008' and mname='报名';	 
	end if;
	
	-- 权限设置 报名 预审 资格预审公告及报名	
	update bs_qxsz set qxrole='1' where mkid='M091005' and sid='M00008';
	-- 权限明细 报名 预审 购买资格预审文件
	update bs_qxsz set qxrole='1' where mkid='M091020' and sid='M00008';
	-- 权限明细 报名 预审 购买招标文件
	update bs_qxsz set qxrole='1' where mkid='M091025' and sid='M00008';
	-- 权限明细 报名 预审 预审澄清文件领取
	update bs_qxsz set qxrole='1' where mkid='M091030' and sid='M00008';
	-- 权限明细 报名 预审 费用支付（业务）预审文件
	update bs_qxsz set qxrole='1' where mkid='M091040' and sid='M00008';
	-- 权限明细 报名 预审 费用支付（业务）招标文件
	update bs_qxsz set qxrole='1' where mkid='M091045' and sid='M00008';
	-- 权限明细 报名 预审 费用支付（财务）
	update bs_qxsz set qxrole='1' where mkid='M091050' and sid='M00008';
	-- 权限明细 报名 预审 资格预审文件问题
	update bs_qxsz set qxrole='1' where mkid='M091060' and sid='M00008';
	-- 权限明细 报名 预审 预审变更公告
	update bs_qxsz set qxrole='1' where mkid='M091070' and sid='M00008';
	-- 权限明细 报名 预审 预审文件异议
	update bs_qxsz set qxrole='1' where mkid='M091080' and sid='M00008';
	-- 权限明细 报名 预审 预审结果异议
	update bs_qxsz set qxrole='1' where mkid='M091085' and sid='M00008';
	-- 权限明细 报名 预审 招标文件异议
	update bs_qxsz set qxrole='1' where mkid='M091090' and sid='M00008';
	
	-- 权限设置 报名 后审 招标公告查看及报名
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M099005' and sid='M00008' and url='/exp/bidding/sell/signup/toZbSignup.do';
	if num = 1 then		
		num:=0;
		select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091010' and sid='M00008';
		if num = 0 then
			update bs_qxsz set mkid='M091010',mid='M0910',orderno='150',qxrole='2' where mkid='M099005' and sid='M00008' and url='/exp/bidding/sell/signup/toZbSignup.do';
		elsif num = 1 then  
			delete from bs_qxsz where mkid='M099005' and sid='M00008' and url='/exp/bidding/sell/signup/toZbSignup.do';
		end if;
	end if;	
	-- 权限明细 报名 后审 报名(招标公告)页面
	update bs_qxmx set mkid='M091010' where action='/exp/bidding/sell/signup' and method='toZbSignup';
	-- 权限明细 报名 后审 报名
	update bs_qxmx set mkid='M091010',accesstag=0 where action='/exp/bidding/sell/signup' and method='doSignup';
	
	-- 权限设置 报名 后审 购买招标文件
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M099010' and sid='M00008' and url='/exp/bidding/sell/signup/hszblist.do';
	if num = 1 then		
		num:=0;
		select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091035' and sid='M00008';
		if num = 0 then
			update bs_qxsz set mkid='M091035',mid='M0910',orderno='350',qxrole='2' where mkid='M099010' and sid='M00008' and url='/exp/bidding/sell/signup/hszblist.do';
		elsif num = 1 then  
			delete from bs_qxsz where mkid='M099010' and sid='M00008' and url='/exp/bidding/sell/signup/hszblist.do';
		end if;
	end if;
	-- 权限明细 报名 后审 购买招标文件列表
	update bs_qxmx set mkid='M091035' where action='/exp/bidding/sell/signup' and method='hszblist';
	-- 权限明细 报名 后审 购买招标文件
	update bs_qxmx set mkid='M091035' where action='/exp/bidding/sell/signup' and method='hszbbuy';
	
	-- 权限设置 报名 后审 费用支付（业务）招标文件
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M099060' and sid='M00008' and url='/exp/bidding/sell/signup/toHsZbDd.do';
	if num = 1 then		
		num:=0;
		select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091055' and sid='M00008';
		if num = 0 then
			update bs_qxsz set mkid='M091055',mid='M0910',orderno='550',qxrole='2' where mkid='M099060' and sid='M00008' and url='/exp/bidding/sell/signup/toHsZbDd.do';
		elsif num = 1 then  
			delete from bs_qxsz where mkid='M099060' and sid='M00008' and url='/exp/bidding/sell/signup/toHsZbDd.do';
		end if;
	end if;
	-- 权限明细 报名 后审 我的订单（招标文件）--后审
	update bs_qxmx set mkid='M091055' where action='/exp/bidding/sell/signup' and method='toHsZbDd';
	-- 权限明细 报名 后审 页面跳转招标文件下载页面--后审
	update bs_qxmx set mkid='M091055' where action='/exp/bidding/sell/signup' and method='toHsDownPage';
	-- 权限明细 报名 后审 招标文件下载--后审
	update bs_qxmx set mkid='M091055' where action='/exp/bidding/sell/signup' and method='hsdownLoadZb';
	
	-- 权限设置 报名 后审 费用支付（财务）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M099070' and sid='M00008' and url='/exp/bidding/sell/signup/hspaylist.do';
	if num = 1 then		
		num:=0;
		select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091065' and sid='M00008';
		if num = 0 then
			update bs_qxsz set mkid='M091065',mid='M0910',orderno='650',qxrole='2' where mkid='M099070' and sid='M00008' and url='/exp/bidding/sell/signup/hspaylist.do';
		elsif num = 1 then  
			delete from bs_qxsz where mkid='M099070' and sid='M00008' and url='/exp/bidding/sell/signup/hspaylist.do';
		end if;
	end if;
	-- 权限明细 报名 后审 财务付款列表页面--后审
	update bs_qxmx set mkid='M091065' where action='/exp/bidding/sell/signup' and method='hspaylist';
	-- 权限明细 报名 后审 支付页面（页面跳转）--后审
	update bs_qxmx set mkid='M091065' where action='/exp/bidding/sell/signup' and method='hspayment';
	-- 权限明细 报名 后审 付钱--后审
	update bs_qxmx set mkid='M091065' where action='/exp/bidding/sell/signup' and method='hsPayMoney';
	
	-- 权限设置 投标管理 正在投标
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0200' and mkid='M020010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M020010','M0200','投标管理','正在投标','/exp/bidding/sell/bidding/list.do','/exp/bidding/sell/bidding/list.do',1,200,1,'M00008');
	end if;
	-- 权限明细 正在投标 正在投标列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020010','/exp/bidding/sell/bidding','list',2,'正在投标-正在投标列表',1,'M00008');
	end if;
   
  select count(1) into num from bs_qxmx where ACTION='/bsp/menber/jsxz' and METHOD ='list' and STYP=1 and SID='M00000';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M039610','/bsp/menber/jsxz','list',2,'角色管理列表',1,'M00000');
	end if;
  
  select count(1) into num from bs_qxmx where ACTION='/bsp/menber/jsxz' and METHOD ='toAdd' and STYP=1 and SID='M00000';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M039610','/bsp/menber/jsxz','toAdd',2,'新增角色',1,'M00000');
	end if;  
  
  select count(1) into num from bs_qxmx where ACTION='/bsp/menber/jsxz' and METHOD ='save' and STYP=1 and SID='M00000';
  if num = 0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M039610','/bsp/menber/jsxz','save',2,'保存角色',1,'M00000');
	end if; 	
	
	-- 权限设置 投标 上传投标文件
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0920' and mkid='M092005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M092005','M0920','投标','上传投标文件','/exp/bidding/sell/bidding/toUploadTbwj.do','/exp/bidding/sell/bidding/toUploadTbwj.do#/exp/bidding/sell/bidding/saveTbwj.do',1,100,1,'M00008');
	end if;
	-- 权限明细 上传投标文件 上传投标文件页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='toUploadTbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M092005','/exp/bidding/sell/bidding','toUploadTbwj',2,'上传投标文件-上传投标文件页面',1,'M00008');
	end if;	
	-- 权限明细 上传投标文件 保存投标文件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='saveTbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M092005','/exp/bidding/sell/bidding','saveTbwj',2,'上传投标文件-保存投标文件',1,'M00008');
	end if;	
	
	--mazg start --
	--招标文件 与费用支付 
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091045' and mid='M0910' and sid='M00008';
    if num=1 then
    	update bs_qxsz set qxrole='' where mkid='M091045' and mid='M0910' and sid='M00008';
    end if; 
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091050' and mid='M0910' and sid='M00008';
    if num=1 then
    	update bs_qxsz set qxrole='' where mkid='M091050' and mid='M0910' and sid='M00008';
    end if; 
    ------删除老数据
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091055' and  sid='M00008' and mid='M0910' and name='费用支付（业务）招标文件';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE mkid='M091055' and  sid='M00008' and mid='M0910';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/sell/signup' AND mkid='M091055' and  sid='M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M091065' and  sid='M00008' and mid='M0910' and name='费用支付（财务）';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE mkid='M091065' and  sid='M00008' and mid='M0910';
    	DELETE FROM BS_QXMX WHERE ACTION = '/exp/bidding/sell/signup' AND mkid='M091065' and  sid='M00008';
    end if;
	--mazg end --




	----------2016/06/27 hanglong 合同管理 start------------------
	----------买家合同审批----------
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087020' and mid='M0870';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M087020', 'M0870', '合同执行', '合同审批', '/exp/bidding/buy/contract/audit/list.do', '/exp/bidding/buy/contract/audit/list.do#/exp/bidding/buy/contract/audit/showContract.do#/exp/bidding/buy/contract/audit/doAudit.do#/exp/bidding/buy/contract/audit/doReject.do#/exp/bidding/buy/contract/audit/dowloadBdwFile.do', 1, 200, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/audit' and  method='list' and mkid='M087020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087020', '/exp/bidding/buy/contract/audit', 'list', 2, '待审核合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/audit' and  method='showContract' and mkid='M087020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087020', '/exp/bidding/buy/contract/audit', 'showContract', 2, '查看合同', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/audit' and  method='doAudit' and mkid='M087020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087020', '/exp/bidding/buy/contract/audit', 'doAudit', 2, '审核通过', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/audit' and  method='doReject' and mkid='M087020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087020', '/exp/bidding/buy/contract/audit', 'doReject', 2, '审核拒绝', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/audit' and  method='dowloadBdwFile' and mkid='M087020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087020', '/exp/bidding/buy/contract/audit', 'dowloadBdwFile', 2, '合同详情-标的物附件下载', 1, 'M00008');
	end if;
	
	--------卖家合同审批---------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096020' and mid='M0960';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M096020', 'M0960', '签订合同', '合同审批', '/exp/bidding/sell/contract/audit/list.do', '/exp/bidding/sell/contract/audit/list.do#/exp/bidding/sell/contract/audit/showContract.do#/exp/bidding/sell/contract/audit/doAudit.do#/exp/bidding/sell/contract/audit/doReject.do#/exp/bidding/sell/contract/audit/dowloadBdwFile.do', 1, 200, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/audit' and  method='list' and mkid='M096020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096020', '/exp/bidding/sell/contract/audit', 'list', 2, '待审核合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/audit' and  method='showContract' and mkid='M096020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096020', '/exp/bidding/sell/contract/audit', 'showContract', 2, '查看合同', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/audit' and  method='doAudit' and mkid='M096020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096020', '/exp/bidding/sell/contract/audit', 'doAudit', 2, '审核通过', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/audit' and  method='doReject' and mkid='M096020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096020', '/exp/bidding/sell/contract/audit', 'doReject', 2, '审核拒绝', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/audit' and  method='dowloadBdwFile' and mkid='M096020' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096020', '/exp/bidding/sell/contract/audit', 'dowloadBdwFile', 2, '合同详情-标的物附件下载', 1, 'M00008');
	end if;
	
	----------2016/06/29 hanglong 合同审批 end------------------

	----------2016/06/30 jinyanhui 注册权限组 start------------------
  --add by jinyanhui start 注册会员权限参数设置--
  num:=0;
    select count(1) into num from bs_cssz where cskey='WSCS_DLS_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('WSCS_DLS_GROUP_QX','网上超市代理商权限组','','','系统管理员','网上超市代理商权限组','1',1790);
	 end if; 
   
  num:=0;
    select count(1) into num from bs_cssz where cskey='DZZTB_SELL_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('DZZTB_SELL_GROUP_QX','电子招投标投标方权限组','','','系统管理员','电子招投标投标方权限组','1',1800);
	 end if;  
   
  num:=0;
    select count(1) into num from bs_cssz where cskey='DZZTB_BUY_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('DZZTB_BUY_GROUP_QX','电子招投标招标方权限组','','','系统管理员','电子招投标招标方权限组','1',1810);
	 end if; 
   
  num:=0;
    select count(1) into num from bs_cssz where cskey='DZZTB_AGENT_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('DZZTB_AGENT_GROUP_QX','电子招投标代理机构权限组','','','系统管理员','电子招投标代理机构权限组','1',1820);
	 end if;        
   
  num:=0;
    select count(1) into num from bs_cssz where cskey='GYS_SELL_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('GYS_SELL_GROUP_QX','供应商权限组','','','系统管理员','供应商权限组','1',1830);
	 end if;   
   
  num:=0;
    select count(1) into num from bs_cssz where cskey='GYS_BUY_GROUP_QX';
    if num = 0 then
      insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
      values('GYS_BUY_GROUP_QX','供应商采购权限组','','','系统管理员','供应商采购权限组','1',1840);
	 end if;
	----------2016/06/30 jinyanhui 注册权限组 end------------------
  num:=0;
  select count(1) into num from bs_qxmx where action='/bsp/menber/jsxz' and  method='toAddTwo' and mkid='M039610' and  sid='M00000';
  if num=0 then
    INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    VALUES ('M039610', '/bsp/menber/jsxz', 'toAddTwo', 2, '完善资料', 1, 'M00000');
	end if;
	
	-- 角色管理 完善资料页面
	num:=0;
	select instr(inurl,'/bsp/menber/jsxz/toAddTwo.do') into num from bs_qxsz where sid='M00000' and mkid='M039610';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/bsp/menber/jsxz/toAddTwo.do') where sid='M00000' and mkid='M039610';
	end if;	
	
	-- 权限明细 资格预审文件 上传资格预审申请文件页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toUpZgyssqwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','toUpZgyssqwj',2,'资格预审文件-上传资格预审申请文件页面',1,'M00008');
	end if;	
	-- 权限明细 资格预审文件 保存资格预审申请文件
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='saveZgyssqwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091040','/exp/bidding/sell/signup','saveZgyssqwj',2,'资格预审文件-保存资格预审申请文件',1,'M00008');
	end if;
	-- 权限设置 菜单选中 资格预审文件 上传资格预审申请文件
	num:=0;
	select instr(inurl,'/exp/bidding/sell/signup/toUpZgyssqwj.do') into num from bs_qxsz where sid='M00008' and mkid='M091040';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toUpZgyssqwj.do') where sid='M00008' and mkid='M091040';
	end if;
	-- 权限设置 菜单选中 资格预审文件 保存资格预审申请文件
	num:=0;
	select instr(inurl,'/exp/bidding/sell/signup/saveZgyssqwj.do') into num from bs_qxsz where sid='M00008' and mkid='M091040';
	if num = 0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/saveZgyssqwj.do') where sid='M00008' and mkid='M091040';
	end if;
	
	
	--add by xuz 资格预审文件参数设置 start--
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089007' and mid='M0890';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID,QXROLE) 
		VALUES ('M089007', 'M0890', '资格预审', '资格预审参数设置', '/exp/bidding/buy/prefic/toZgysCssz.do', '/exp/bidding/buy/prefic/toZgysCssz.do#/exp/bidding/buy/prefic/saveZgysCssz.do', 1, 70, 1, 'M00008','008-1-2-2');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='toZgysCssz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089007','/exp/bidding/buy/prefic','toZgysCssz',2,'资格预审文件参数设置页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='saveZgysCssz' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089007','/exp/bidding/buy/prefic','saveZgysCssz',2,'资格预审文件参数保存',1,'M00008');
	end if;
    --add by xuz 资格预审文件参数设置 end--

	-- 权限明细 正在投标 缴纳保证金页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='toPayBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020010','/exp/bidding/sell/bidding','toPayBzj',2,'正在投标-缴纳保证金页面',1,'M00008');
	end if;	
	-- 权限明细 正在投标 缴纳保证金
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='doPayBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020010','/exp/bidding/sell/bidding','doPayBzj',2,'正在投标-缴纳保证金',1,'M00008');
	end if;	
	
	-- 权限明细 费用支付（财务） 支付保证金页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toZfBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091050','/exp/bidding/sell/signup','toZfBzj',2,'费用支付（财务）-支付保证金页面',1,'M00008');
	end if;	
	-- 权限明细 费用支付（财务） 支付保证金
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='doZfBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091050','/exp/bidding/sell/signup','doZfBzj',2,'费用支付（财务）-支付保证金',1,'M00008');
	end if;
	
	-- 权限设置 发标 费用支付（财务）
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083065' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
		values('M083065','M0830','发标','费用支付（财务）','/exp/bidding/buy/pay/list.do','/exp/bidding/buy/pay/list.do',1,500,1,'M00008',1);
	end if;
	-- 权限明细 费用支付（财务） 订单列表页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pay' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083065','/exp/bidding/buy/pay','list',2,'费用支付（财务）-订单列表页面',1,'M00008');
	end if;
	-- 权限明细 费用支付（财务） 确认保证金页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pay' and METHOD ='toConfirmBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083065','/exp/bidding/buy/pay','toConfirmBzj',2,'费用支付（财务）-确认保证金页面',1,'M00008');
	end if;
	-- 权限明细 费用支付（财务） 确认保证金
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/pay' and METHOD ='doConfirmBzj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083065','/exp/bidding/buy/pay','doConfirmBzj',2,'费用支付（财务）-确认保证金',1,'M00008');
	end if;

	--add by zhaiyy 资格预审结果通知书 start--
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089080' and mid='M0890';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID,FIXED,QXROLE) 
		VALUES ('M089080', 'M0890', '资格预审', '资格预审结果通知书', '/exp/bidding/buy/result/edit.do', '/exp/bidding/buy/result/edit.do', 1, 400, 1, 'M00008',1,'008-1-2-2');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/result' and METHOD ='edit' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089080','/exp/bidding/buy/result','edit',2,'资格预审结果通知书编辑',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/result' and METHOD ='save' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089080','/exp/bidding/buy/result','save',2,'资格预审结果通知书保存',1,'M00008');
	end if;
	--add by zhaiyy 资格预审结果通知书 end--


	--add by zhaiyy 资格预审结果通知书发布 start--
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089085' and mid='M0890';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID,FIXED,QXROLE) 
		VALUES ('M089085', 'M0890', '资格预审', '资格预审结果通知书发布', '/exp/bidding/buy/release/view.do', '/exp/bidding/buy/release/view.do', 1, 450, 1, 'M00008',1,'008-1-2-2');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/release' and METHOD ='view' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089085','/exp/bidding/buy/release','view',2,'资格预审结果通知书发布页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/release' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089085','/exp/bidding/buy/release','download',2,'附件下载',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/release' and METHOD ='release' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089085','/exp/bidding/buy/release','release',2,'资格预审结果通知书发布',1,'M00008');
	end if;
	--add by zhaiyy 资格预审结果通知书发布 end--
	
	--mazg start--
	--保证金inurl
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091050' and sid='M00008' and instr(inurl, '#/exp/bidding/sell/signup/toZfBzj.do') > 0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toZfBzj.do') where sid='M00008' and mkid='M091050';
	end if;
	--mazg end--

	--add by longf start ---
  	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='toDownPage' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','toDownPage',1,'评委审查-查看文件列表',1,'M00009');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/psp/judge/censor' and METHOD ='downLoad' and STYP=1 and SID='M00009';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/psp/judge/censor','downLoad',1,'评委审查-文件下载',1,'M00009');
	end if;
	--add by longf end ---
	
	--mazg start--
	--将资格预审文件下载定位到购买资格预审文件菜单，并且把权限也移过去
	--删除权限明细老数据
		--资格预审文件下载跳转
	num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091040' and action = '/exp/bidding/sell/signup' and method ='toDownPage';
    if num=1 then
    	delete from bs_qxmx where sid = 'M00008' and mkid = 'M091040' and action = '/exp/bidding/sell/signup' and method ='toDownPage';
    end if;
    	--资格预审文件下载
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091040' and action = '/exp/bidding/sell/signup' and method ='downLoad';
    if num=1 then
    	delete from bs_qxmx where sid = 'M00008' and mkid = 'M091040' and action = '/exp/bidding/sell/signup' and method ='downLoad';
    end if;
    --删除原来定位在费用支付（业务）预审文件上面的inurl
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/toDownPage.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/toDownPage.do','');
	 end if;
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/downLoad.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/downLoad.do','');
	 end if;
	 --新增新数据
	--购买预审文件下面增加明细
	--下载预审文件跳转
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='toDownPage' and mkid='M091020' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091020', '/exp/bidding/sell/signup', 'toDownPage', 2, '下载预审文件跳转', 1, 'M00008');
    end if;
	--下载预审文件
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='downLoad' and mkid='M091020' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091020', '/exp/bidding/sell/signup', 'downLoad', 2, '下载预审文件', 1, 'M00008');
    end if;
    --在购买资格预审文件里面添加inurl
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091020' and sid='M00008' and instr(inurl,'#/exp/bidding/sell/signup/toDownPage.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toDownPage.do') where mid='M0910' and mkid='M091020' and sid='M00008';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091020' and sid='M00008' and instr(inurl,'#/exp/bidding/sell/signup/downLoad.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/downLoad.do') where mid='M0910' and mkid='M091020' and sid='M00008';
	end if;
	
	--将招标文件下载定位到购买招标文件菜单，并且把权限也移过去
	--删除权限明细老数据
		--招标文件下载跳转
	num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091045' and action = '/exp/bidding/sell/signup' and method ='toDownPageZb';
    if num=1 then
    	delete from bs_qxmx where sid = 'M00008' and mkid = 'M091045' and action = '/exp/bidding/sell/signup' and method ='toDownPageZb';
    end if;
    	--招标文件下载
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and mkid = 'M091045' and action = '/exp/bidding/sell/signup' and method ='downLoadZb';
    if num=1 then
    	delete from bs_qxmx where sid = 'M00008' and mkid = 'M091045' and action = '/exp/bidding/sell/signup' and method ='downLoadZb';
    end if;
	 --删除原来定位在费用支付（业务）招标文件上面的inurl
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091045' and instr(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do','');
	 end if;
	num:=0;
	 select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091045' and instr(inurl,'#/exp/bidding/sell/signup/downLoadZb.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/downLoadZb.do','');
	 end if;
	 
	 --新增新数据
	--购买招标文件下面增加明细
	--下载招标文件跳转
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='toDownPageZb' and mkid='M091025' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091025', '/exp/bidding/sell/signup', 'toDownPageZb', 2, '下载招标文件跳转', 1, 'M00008');
    end if;
	--下载招标文件
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='downLoadZb' and mkid='M091025' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091025', '/exp/bidding/sell/signup', 'downLoadZb', 2, '下载招标文件', 1, 'M00008');
    end if;
    --在购买招标文件里面添加inurl
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091025' and sid='M00008' and instr(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toDownPageZb.do') where mid='M0910' and mkid='M091025' and sid='M00008';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0910' and mkid='M091025' and sid='M00008' and instr(inurl,'#/exp/bidding/sell/signup/downLoadZb.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/downLoadZb.do') where mid='M0910' and mkid='M091025' and sid='M00008';
	end if;
	--mazg end--

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
