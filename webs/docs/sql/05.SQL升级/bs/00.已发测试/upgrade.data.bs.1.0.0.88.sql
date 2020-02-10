DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.88'; -- 本升级文件的版本，每个升级文件必须修改
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
	

	--add by linqingqing  start ---
 ----权限设置修改
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086060'and inurl='/ex/exp/bidding/buy/scaling/toGcTzs.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/ex/exp/bidding/buy/scaling/toGcTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/buy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do'
    where sid='M00008' and mid='M0860' and mkid='M086060'and inurl='/ex/exp/bidding/buy/scaling/toGcTzs.do'; 
 end if;

    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toHwTzs.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toHwTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/buy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do'
    where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toHwTzs.do'; 
 end if;

    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086070'and inurl='/exp/bidding/buy/scaling/toJgTzs.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toJgTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/buy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do'
    where sid='M00008' and mid='M0860' and mkid='M086070'and inurl='/exp/bidding/buy/scaling/toJgTzs.do'; 
 end if;

	--------权限设置新增
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089096' and mid='M0890'and styp=1 and sid='M00008';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,qxrole) 
       values('M089096','M0890','资格预审','投标邀请书-代资格审核通过通知书','/exp/bidding/buy/gkys/toEdit.do','/exp/bidding/buy/gkys/toEdit.do',1,610,1,'','M00008','008-1-2-2');
    end if;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089097' and mid='M0890' and styp=1 and sid='M00008';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole) 
       values('M089097','M0890','资格预审','投标邀请书发布(代资格审核通过通知书)','/exp/bidding/buy/gkys/toRelease.do','/exp/bidding/buy/gkys/toRelease.do',1,620,1,'M00008','008-1-2-2');
    end if;
 
    select count(1) into num from bs_qxsz where mkid='M082035'  and mid='M0820' and mname='约标' and url='/exp/bidding/buy/prefic/index.do'and name='投标邀请书编制' and orderno=70 and sid='M00008' and qxrole='1';
    if num > 0 then
	    update bs_qxsz set url='/exp/bidding/buy/yqhs/toEdit.do',inurl='/exp/bidding/buy/yqhs/toEdit.do#/exp/bidding/buy/yqhs/toUpdate.do#/exp/bidding/buy/yqhs/toRelease.do#/exp/bidding/buy/yqhs/toSave.do#/exp/bidding/buy/yqhs/toView.do#/exp/bidding/buy/yqhs/toDownload.do#/exp/bidding/buy/yqhs/hsPackList.do#/exp/bidding/buy/yqhs/invitationUnit.do#/exp/bidding/buy/yqhs/saveInvitation.do#/exp/bidding/buy/yqhs/invitationInfor.do#/exp/bidding/buy/yqhs/delInvitation.do'
	    where mkid='M082035'  and mid='M0820' and mname='约标' and name='投标邀请书编制' and orderno=70 and sid='M00008' and qxrole='1'; 
    end if;
    
    select count(1) into num from bs_qxmx where mkid='M020030' and action='/exp/bidding/sell/invitation' and method='doConfirmYqs' and sid='M00008' and styp=1;
    if num > 0 then
		update bs_qxmx set mkid='M020005' where mkid='M020030' and action='/exp/bidding/sell/invitation' and method='doConfirmYqs' and sid='M00008' and styp=1;
    end if;
----权限明细新增
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='toDownload' and mkid='M089096'and sid='M00008';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M089096','/exp/bidding/buy/gkys','toDownload',2,'代资格审核通过通知书附件',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='toEdit' and mkid='M089096'and sid='M00008';
    if num=0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089096','/exp/bidding/buy/gkys','toEdit',2,'代资格审核通过通知书',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='toRelease' and mkid='M089096'and sid='M00008';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M089096','/exp/bidding/buy/gkys','toRelease',2,'代资格审核通过通知书发布',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='toSave' and mkid='M089096'and sid='M00008';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M089096','/exp/bidding/buy/gkys','toSave',2,'代资格审核通过通知书保存',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='toUpdate' and mkid='M089096'and sid='M00008';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M089096','/exp/bidding/buy/gkys','toUpdate',2,'代资格审核通过通知书修改',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='tocomnext' and mkid='M089096'and sid='M00008';
    if num=0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('M089096','/exp/bidding/buy/gkys','tocomnext',2,'代资格审核通过通知书下一步',1,'M00008');
    end if;

----权限明细修改

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='tzsFS' and mkid='M0860'and sid='M00008';
    if num>0 then
       update bs_qxmx set mkid='M086060' where action='/exp/bidding/buy/scaling' and  method='tzsFS' and mkid='M0860'and sid='M00008';
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='tzsQT' and mkid='M0860'and sid='M00008';
    if num>0 then
       update bs_qxmx set mkid='M086060' where action='/exp/bidding/buy/scaling' and  method='tzsQT' and mkid='M0860'and sid='M00008';
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='tzsSave' and mkid='M0860'and sid='M00008';
    if num>0 then
       update bs_qxmx set mkid='M086060' where action='/exp/bidding/buy/scaling' and  method='tzsSave' and mkid='M0860'and sid='M00008';
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='tzsTJ' and mkid='M0860'and sid='M00008';
    if num>0 then
       update bs_qxmx set mkid='M086060' where action='/exp/bidding/buy/scaling' and  method='tzsTJ' and mkid='M0860'and sid='M00008';
    end if;
     
 ------add by linqingqing end-----    
	
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/menber/jsxz' and sid = 'M00000'    and method='openOrForbid';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M039610','/bsp/menber/jsxz','openOrForbid','2','启用禁用','1','M00000');
  	end if;	
	
	-----by zhaiyy statr-------
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and sid = 'M00008'    and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M095030','/exp/bidding/sell/hitbid/notice','download','2','附件下载','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/result' and sid = 'M00008'    and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M095040','/exp/bidding/sell/hitbid/result','download','2','附件下载','1','M00008');
  	end if;
	-----zhaiyy end-------

	--------------------------------------------添加招标方评标结果BY.zhminfu-------------------------------------------------------
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M085010' and mid='M0850';
    if num=0 then
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
      values('M085010','M0850','评标','评标结果','/bdp/review/result/index.do','/bdp/review/result/index.do',1,'100',1,'','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/review/result' and  method='index'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M085010', '/bdp/review/result', 'index', 2, '评标-评标结果', 1, 'M00008');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089045' and mid='M0890';
  	if num=0 then
	    insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,qxrole)
	    values('M089045','M0890','资格预审','资格预审评审报告','/bdp/pre/result/index.do','/bdp/pre/result/index.do',1,'600',1,'','M00008','008-1-2-2');
  	end if;
  	
  	num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/pre/result' and  method='index' and   sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M089045', '/bdp/pre/result', 'index', 2, '资格预审-资格预审评审报告', 1, 'M00008');
    end if;
    --------------------------------------------------------------------------------------------------------------------------------

	--------------------------------------------mazg start-------------------------------------------------------
	--费用支付（业务）预审文件查看订单
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='showZgDd'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091040', '/exp/bidding/sell/signup', 'showZgDd', 2, '订单查看', 1, 'M00008');
    end if;
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/showZgDd.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showZgDd.do') where sid = 'M00008' and mid = 'M0910' ;
    end if;
    --费用支付（业务）招标文件查看订单
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='showZbDd'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091045', '/exp/bidding/sell/signup', 'showZbDd', 2, '订单查看', 1, 'M00008');
    end if;
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091045' and instr(inurl,'#/exp/bidding/sell/signup/showZbDd.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showZbDd.do') where sid = 'M00008' and mid = 'M0910' and mkid ='M091045';
    end if;
    --费用支付（财务）查看订单
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and  method='showCwDd' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091050', '/exp/bidding/sell/signup', 'showCwDd', 2, '订单查看', 1, 'M00008');
    end if;
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091050' and instr(inurl,'#/exp/bidding/sell/signup/showCwDd.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showCwDd.do') where sid = 'M00008' and mid = 'M0910' and mkid ='M091050';
    end if;
	--------------------------------------------mazg end-------------------------------------------------------

	---xuz start----
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091060'  and mid='M0910' and name='资格预审文件问题' and url='/exp/bidding/sell/preficClari/list.do' and sid='M00008' ;
    if num > 0 then
	    update bs_qxsz set url='/exp/bidding/sell/pre/dissent/preClariList.do',inurl='/exp/bidding/sell/pre/dissent/preClariList.do#/exp/bidding/sell/pre/dissent/toSlClari.do#/exp/bidding/sell/pre/dissent/toReplyZjwt.do'
	    where mkid='M091060'  and mid='M0910' and name='资格预审文件问题' and url='/exp/bidding/sell/preficClari/list.do' and sid='M00008' ;
    end if;
	
    
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/dissent' and  method='toSlClari' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091060', '/exp/bidding/sell/pre/dissent', 'toSlClari', 2, '资格预审文件问题受理页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/dissent' and  method='acceptScaling'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091060', '/exp/bidding/sell/pre/dissent', 'acceptScaling', 2, '资格预审文件问题受理', 1, 'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/dissent' and  method='toReplyZjwt'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091060', '/exp/bidding/sell/pre/dissent', 'toReplyZjwt', 2, '资格预审文件问题回复页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/dissent' and  method='saveReplyZjwt'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091060', '/exp/bidding/sell/pre/dissent', 'saveReplyZjwt', 2, '资格预审文件问题回复', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/pre/dissent' and  method='download'  and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091060', '/exp/bidding/sell/pre/dissent', 'download', 2, '专家提问附件下载', 1, 'M00008');
    end if;
	---xuz  end----=

	
	-----chenxp start-----
	-----正在项目
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
   	 	insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno,styp,  sid ) 
   		values('M010065', 'M0100', '招标管理', '正在项目','/exp/bidding/buy/beingPro/list.do','/exp/bidding/buy/beingPro/list.do', 1,300, 1, 'M00008');
  	end if;  

  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='list';
  	if num = 0 then
   		 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010065','/exp/bidding/buy/beingPro','list','2','正在项目','1','M00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='viewEntrust';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M010065','/exp/bidding/buy/beingPro','viewEntrust','2','查看委托','1','M00008');
  	end if;
  
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='trustReceipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
   	 	values('M010065','/exp/bidding/buy/beingPro','trustReceipt','2','委托回执','1','M00008');
  	end if;
  
 
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'    and method='saveTrustReceipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M010065','/exp/bidding/buy/beingPro','saveTrustReceipt','2','保存委托回执','1','M00008');
  	end if;
  
 	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'   and method='editwtxy';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M010065','/exp/bidding/buy/beingPro','editwtxy','2','编制委托协议','1','M00008');
 	end if;
  
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='savewtxy';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M010065','/exp/bidding/buy/beingPro','savewtxy','2','保存委托协议','1','M00008');
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/viewEntrust.do') into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
  	    update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/viewEntrust.do') where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/saveTrustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
    	 update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/saveTrustReceipt.do') where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	end if;
 
 	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/trustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
      	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/trustReceipt.do') where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/editwtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/editwtxy.do') where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/savewtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100';
  	if num = 0 then
    	 update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/savewtxy.do') where  sid = 'M00008' and mkid='M010065' and mid='M0100';
  	end if;
	-----chenxp end-------

    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/menber/jsxz' and sid = 'M00000'  and mkid='M039610'  and method='openOrForbid';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M039610','/bsp/menber/jsxz','openOrForbid','2','启用禁用','1','M00000');
  	end if;	
	
	-----by zhaiyy statr-------
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and sid = 'M00008'  and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M095030','/exp/bidding/sell/hitbid/notice','download','2','附件下载','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/result' and sid = 'M00008'    and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M095040','/exp/bidding/sell/hitbid/result','download','2','附件下载','1','M00008');
  	end if;
	-----zhaiyy end-------
	
	--add by zhaiyy 预审变更公告start ---
	--预审变更公告的inurl（定位）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091070' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/ysbgnotice/list.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'/exp/bidding/sell/ysbgnotice/list.do') where  mkid='M091070' and sid='M00008' and mid='M0910';
	end if;
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/ysbgnotice' and sid = 'M00008'  and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091070','/exp/bidding/sell/ysbgnotice','download','2','附件下载','1','M00008');
  	end if;
	--add by zhaiyy 预审变更公告end ---


    select count(1) into num from bs_qxsz where mkid='M091061' and mid='M0910'and styp=1 and sid='M00008';
    if num=0 then
       insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed,qxrole) 
       values('M091061','M0910','报名','预审列表','/exp/bidding/sell/result/list.do','/exp/bidding/sell/result/list.do',1,101,1,'','M00008','1','1');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/result' and  method='list' and  sid='M00008';
    if num=0 then
      insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
      values('M091061', '/exp/bidding/sell/result', 'list', 2, '预审列表', 1, 'M00008');
    end if;
    
    ---hejw--start-------
  num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089090';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
      values ('M089090','M0890','资格预审','资格预审申请文件开启列表','/exp/bidding/buy/ysopen/ysPackList.do','/exp/bidding/buy/ysopen/ysPackList.do',1,500,1,'M00008','008-1-2-2'); 
	end if;
  
  num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089095';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
      values ('M089095','M0890','资格预审','资格预审申请文件开启记录表','/exp/bidding/buy/ysopen/ysRecord.do','/exp/bidding/buy/ysopen/ysRecord.do',1,550,1,'M00008','008-1-2-2'); 
	end if;
  
 num:=0;
 select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089090' and inurl='/exp/bidding/buy/ysopen/ysPackList.do'; 
 if num = 1 then
  update bs_qxsz set inurl='/exp/bidding/buy/ysopen/ysPackList.do#/exp/bidding/buy/ysopen/packageYsOpen.do'
   where sid='M00008' and mid='M0890' and mkid='M089090' and inurl='/exp/bidding/buy/ysopen/ysPackList.do';
 end if;
 
  num:=0;
 select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089095' and inurl='/exp/bidding/buy/ysopen/ysRecord.do'; 
 if num = 1 then
  update bs_qxsz set inurl='/exp/bidding/buy/ysopen/ysRecord.do#/exp/bidding/buy/ysopen/ysjlqz.do'
   where sid='M00008' and mid='M0890' and mkid='M089095' and inurl='/exp/bidding/buy/ysopen/ysRecord.do';
 end if;

	--add by zhaiyy 投标人 招标变更公告start ---
	num:=0;
  	select count(1) into num from bs_qxsz where  sid = 'M00008' and mkid='M091071' and mid='M0910';
  	if num = 0 then
   	 	insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno,styp,  sid,fixed ) 
   		values('M091071', 'M0910', '报名', '招标变更公告','/exp/bidding/sell/zbbgnotice/view.do','/exp/bidding/sell/zbbgnotice/view.do', 1,800, 1, 'M00008',1);
  	end if; 
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbbgnotice' and sid = 'M00008'    and method='view';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091071','/exp/bidding/sell/zbbgnotice','view','2','附件下载','1','M00008');
  	end if;
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbbgnotice' and sid = 'M00008' and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091071','/exp/bidding/sell/zbbgnotice','download','2','附件下载','1','M00008');
  	end if;
	--add by zhaiyy 投标人 招标变更公告end ---

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and  method='ysPackList' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089090','/exp/bidding/buy/ysopen','ysPackList',2,'待预审列表',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and  method='packageYsOpen' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089090','/exp/bidding/buy/ysopen','packageYsOpen',2,'进入标段（包）预审页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and  method='ysRecord' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089090','/exp/bidding/buy/ysopen','ysRecord',2,'预审记录',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/ysopen' and  method='ysjlqz'  and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089090','/exp/bidding/buy/ysopen','ysjlqz',2,'预审记录签章确认',1,'M00008');
    end if;
    
    
    
    
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0910' and mkid='M091092';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
      values ('M091092','M0910','报名','资格预审文件开启','/exp/bidding/sell/ysopen/index.do','/exp/bidding/sell/ysopen/index.do',1,10,1,'M00008','3'); 
	end if;
  
      num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0910' and mkid='M091094';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
      values ('M091094','M0910','报名','资格预审文件开启情况','/exp/bidding/sell/ysopen/show.do','/exp/bidding/sell/ysopen/show.do',1,20,1,'M00008','3'); 
	end if;
  
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/ysopen' and  method='index' and   sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M091092','/exp/bidding/sell/ysopen','index',2,'投标方 预审 标段包 列表',1,'M00008');
    end if;
 
   num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/ysopen' and  method='sign' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M091092','/exp/bidding/sell/ysopen','sign',2,'投标方资格预审开启 签到',1,'M00008');
    end if;   
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/ysopen' and  method='show' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M091094','/exp/bidding/sell/ysopen','show',2,'投标方显示资格预审开启记录',1,'M00008');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/ysopen' and  method='confirmRecord' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M091094','/exp/bidding/sell/ysopen','confirmRecord',2,'投标方确认资格预审开启记录',1,'M00008');
    end if; 
    ---hejw--end-------
    
    --add by zhaiyy 投标人 招标变更公告start ---
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0910' and mkid='M091064';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed,qxrole)
      values ('M091064','M0910','报名','资格预审结果通知书','/exp/bidding/sell/result/view.do','/exp/bidding/sell/result/view.do',1,110,1,'M00008',1,1); 
	end if;
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/result' and sid = 'M00008'  and method='view';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091064','/exp/bidding/sell/result','view','2','结果通知书查看','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/result' and sid = 'M00008'  and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091064','/exp/bidding/sell/result','download','2','结果通知书查看','1','M00008');
  	end if;
	--add by zhaiyy 投标人 招标变更公告start ---


	--add by zhaiyy 投标人澄清文件领取（预审）start ---
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/yscqnotice' and sid = 'M00008'  and method='receipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091030','/exp/bidding/sell/yscqnotice','receipt','2','回执页面','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/yscqnotice' and sid = 'M00008'   and method='confirm';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091030','/exp/bidding/sell/yscqnotice','confirm','2','确认回执','1','M00008');
  	end if;
  	
  	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091030' and sid='M00008' and mid='M0910' and instr(inurl,'#/exp/bidding/sell/yscqnotice/receipt.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/yscqnotice/receipt.do') where  mkid='M091030' and sid='M00008' and mid='M0910';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091030' and sid='M00008' and mid='M0910' and instr(inurl,'#/exp/bidding/sell/yscqnotice/confirm.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/yscqnotice/confirm.do') where  mkid='M091030' and sid='M00008' and mid='M0910';
	end if;
    --add by zhaiyy 投标人 澄清文件领取（预审）start ---

	--add by zhaiyy 投标人澄清文件领取（招标）start ---
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0910' and mkid='M091072';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
      values ('M091072','M0910','报名','招标澄清文件领取','/exp/bidding/sell/zbcqnotice/list.do','/exp/bidding/sell/zbcqnotice/list.do#/exp/bidding/sell/zbcqnotice/receipt.do#/exp/bidding/sell/zbcqnotice/confirm.do#/exp/bidding/sell/zbcqnotice/view.do',1,790,1,'M00008',1); 
	end if;
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008'   and method='list';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091072','/exp/bidding/sell/zbcqnotice','list','2','澄清文件领取列表','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008'  and method='receipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091072','/exp/bidding/sell/zbcqnotice','receipt','2','回执页面','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008' and method='confirm';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091072','/exp/bidding/sell/zbcqnotice','confirm','2','回执页面','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008' and method='view';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091072','/exp/bidding/sell/zbcqnotice','view','2','澄清文件查看','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/zbcqnotice' and sid = 'M00008' and method='downLoad';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M091072','/exp/bidding/sell/zbcqnotice','downLoad','2','附件下载','1','M00008');
  	end if;
	--add by zhaiyy 投标人 澄清文件领取（招标）start ---
    

  num:=0;
  select count(1) into num from bs_codes where typ='学历' and code='本科';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('学历','本科','本科',1,1,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='学历' and code='专科';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('学历','专科','专科',1,2,1);
  end if;  
  
  num:=0;
  select count(1) into num from bs_codes where typ='资信等级' and code='一级';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('资信等级','一级','一级',1,1,1);
  end if; 
  
  	--------------------------------------------mazg start-------------------------------------------------------
	--删除老数据
	--费用支付（业务）招标文件
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091045' and  sid='M00008' and mid='M0910';
    if num>0 then
    	delete from bs_qxsz where mkid='M091045' and  sid='M00008' and mid='M0910';
    	delete from bs_qxmx where action = '/exp/bidding/sell/signup' and mkid='M091045' and sid='M00008';
    end if;
    --修改数据费用支付（业务）预审文件 为公共的
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091040' and  sid='M00008' and mid='M0910';
    if num=1 then
    	update bs_qxsz set qxrole=''  where mkid='M091040' and  sid='M00008' and mid='M0910';
    end if;
    --修改数据费用支付（业务）预审文件的name
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M091040' and  sid='M00008' and mid='M0910';
    if num=1 then
    	update bs_qxsz set name='费用支付（业务）'  where mkid='M091040' and  sid='M00008' and mid='M0910';
	end if;

	--------------------------------------------mazg end-------------------------------------------------------
  
  
  

    --add by xuz start---
	------删除老数据
     num:=0;
    select count(1) into num from bs_qxsz where mkid='M089015' and  sid='M00008' and mid='M0890' and url='/bdp/bidding/buy/preficfile/viewZgyswj.do';
    if num>0 then
    	DELETE FROM BS_QXSZ WHERE MKID='M089015' AND SID='M00008' AND MID='M0890'  and url='/bdp/bidding/buy/preficfile/viewZgyswj.do';
    	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND MKID='M089015' AND SID='M00008' and METHOD='publishWj';
    	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND MKID='M089015' AND SID='M00008' and METHOD='viewZgyswj';
    	DELETE FROM BS_QXMX WHERE ACTION = '/bdp/bidding/buy/preficfile' AND MKID='M089015' AND SID='M00008' and METHOD='download';
    end if;
    
    -----增加新的资格预审文件上传qxmx
		
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/bdp/bidding/buy/preficfile' and sid = 'M00008'  and method='publishWj';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089010','/bdp/bidding/buy/preficfile','publishWj','2','资格预审文件发布','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/bdp/bidding/buy/preficfile' and sid = 'M00008'  and method='viewZgyswj';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089010','/bdp/bidding/buy/preficfile','viewZgyswj','2','预览资格预审文件','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/bdp/bidding/buy/preficfile' and sid = 'M00008'  and method='download';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M089010','/bdp/bidding/buy/preficfile','download','2','下载资格预审文件','1','M00008');
  	end if;
  	
  	----更改资格预审文件上传qxsz的inurl
	num:=0;
  	select instr(inurl,'/bdp/bidding/buy/preficfile/viewZgyswj.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089010' and mid='M0890';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/viewZgyswj.do') where  sid = 'M00008' and mkid='M089010' and mid='M0890';
  	end if;
  	
  	num:=0;
  	select instr(inurl,'/bdp/bidding/buy/preficfile/download.do') into num from bs_qxsz where sid = 'M00008' and mkid='M089010' and mid='M0890';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/download.do') where  sid = 'M00008' and mkid='M089010' and mid='M0890';
  	end if;
  	
    --add by xuz end---
	--add linqingqing start---
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do'
	    where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do'; 
 	end if;
   --add linqingqing end--- 


	--add zhaiyy start---
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and sid = 'M00008' and method='receipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M092005','/exp/bidding/sell/bidding','receipt','2','上传投标文件-回执页面','1','M00008');
  	end if;
  	
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and sid = 'M00008' and method='confirm';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M092005','/exp/bidding/sell/bidding','confirm','2','上传投标文件-确认回执','1','M00008');
  	end if;
  	
  	num:=0;
	select count(1) into num from bs_qxsz where mkid='M092005' and sid='M00008' and mid='M0920' and instr(inurl,'/exp/bidding/sell/bidding/receipt.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidding/receipt.do') where  mkid='M092005' and sid='M00008' and mid='M0920';
	end if;
	--add zhaiyy end--- 




    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/supplier/reg/new' and sid = 'M00000'  and method='info';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('0','/bsp/supplier/reg/new','info','0','供应商注册-注册页面','1','M00000');
  	end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/supplier/reg/new' and sid = 'M00000'  and method='reg';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('0','/bsp/supplier/reg/new','reg','0','供应商注册-提交注册','1','M00000');
  	end if; 
  	
  	--add by xuz start--
	 num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089007'and inurl='/exp/bidding/buy/prefic/toZgysCssz.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/prefic/toZgysCssz.do#/exp/bidding/buy/prefic/saveZgysCssz.do',qxrole='008-1-2-2'
	    where sid='M00008' and mid='M0890' and mkid='M089007'and inurl='/exp/bidding/buy/prefic/toZgysCssz.do'; 
 	end if;
    --add by xuz end--

  	--------------------------------------------mazg start-------------------------------------------------------
	--履约保证金菜单
	--权限设置
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0960' and mkid='M096030';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
      values ('M096030','M0960','签订合同','履约保证金','/exp/bidding/sell/contract/bidbond/list.do','/exp/bidding/sell/contract/bidbond/list.do',1,50,1,'M00008'); 
	end if;
	--权限明细
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'   and method='list';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096030','/exp/bidding/sell/contract/bidbond','list','2','履约保证金（已经中标的列表）',1,'M00008');
  	end if;
  	--------------------------------------------mazg end-------------------------------------------------------
    
    num:=0;
    select count(1) into num from bs_xtmk where mid='M0980' and mname='约标' and styp=1 and ordby=210 and sid='M00008' and qxrole='008-1-2-3' and icon='iconb';    
	if num = 1 then
		DELETE FROM bs_xtmk WHERE mid='M0980' and mname='约标' and styp=1 and ordby=210 and sid='M00008' and qxrole='008-1-2-3' and icon='iconb';
	end if;
	
	  num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0910' and mkid='M091026';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
      values ('M091026','M0910','报名','上传资格预审文件','/exp/bidding/sell/signup/toUpZgyssqwj.do','/exp/bidding/sell/signup/toUpZgyssqwj.do',1,201,1,'M00008',1); 
	end if;
	
     num:=0;
   select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/toUpZgyssqwj.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/toUpZgyssqwj.do','');
	 end if; 
	 
   num:=0;
   select count(1) into num  from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091040' and instr(inurl,'#/exp/bidding/sell/signup/saveZgyssqwj.do')>0;
	 if num = 1 then
	 	update bs_qxsz set inurl=REPLACE(inurl,'#/exp/bidding/sell/signup/saveZgyssqwj.do','');
	 end if; 
  
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0910' and mkid ='M091026' and instr(inurl,'#/exp/bidding/sell/signup/saveZgyssqwj.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/saveZgyssqwj.do') where sid = 'M00008' and mid = 'M0910' and mkid ='M091026';
    end if;    
    
    --- hanglong 公共标段列表----
    num:=0;
    select count(1) into num from bs_qxmx where  action='/common/package' and sid = 'M00008' and method='list';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('0', '/common/package', 'list' , 1, '公共标段包列表', 1, 'M00008');
  	end if;
  	
  	num:=0;
    select count(1) into num from bs_qxmx where action='/common/package' and sid = 'M00008'  and method='saleList';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('0', '/common/package', 'saleList' , 1, '投标方标段包选择过度界面', 1, 'M00008');
  	end if;
  	--- hanglong 公共标段列表----

  	--- hejw start----
num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089090' and styp=1 and name='资格预审申请文件开启列表';    
  if num = 1 then
    update bs_qxsz set name='资格预审文件开启' where sid='M00008' and mid='M0890' and mkid='M089090' and styp=1 and name='资格预审申请文件开启列表';
  end if;
  
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089095' and styp=1 and name='资格预审申请文件开启记录表';    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0890' and mkid='M089095' and styp=1 and name='资格预审申请文件开启记录表';
  end if;
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/ysopen/ysRecord.do#/exp/bidding/buy/ysopen/ysjlqz.do') into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089090' and styp=1; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/ysopen/ysRecord.do#/exp/bidding/buy/ysopen/ysjlqz.do') where sid='M00008' and mid='M0890' and mkid='M089090' and styp=1; 
 end if;
 
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089096' and styp=1 and url='/exp/bidding/buy/gkys/toEdit.do' and name='投标邀请书-代资格审核通过通知书';    
  if num = 1 then
    update bs_qxsz set name='资格预审结果发布' where sid='M00008' and mid='M0890' and mkid='M089096' and styp=1 and name='投标邀请书-代资格审核通过通知书' and url='/exp/bidding/buy/gkys/toEdit.do';
  end if;

  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089097' and styp=1 and name='投标邀请书发布(代资格审核通过通知书)' and url='/exp/bidding/buy/gkys/toRelease.do';    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0890' and mkid='M089097' and styp=1 and name='投标邀请书发布(代资格审核通过通知书)' and url='/exp/bidding/buy/gkys/toRelease.do';
  end if;
  
   num:=0;
 select instr(inurl,'/exp/bidding/buy/gkys/toRelease.do') into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089096' and styp=1; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/gkys/toRelease.do') where sid='M00008' and mid='M0890' and mkid='M089096' and styp=1; 
 end if;
 
-----发标权限修改
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0830' and mkid='M083010' and styp=1 and name='制作招标文件';    
  if num = 1 then
    update bs_qxsz set name='招标文件参数设置' where sid='M00008' and mid='M0830' and mkid='M083010' and styp=1 and name='制作招标文件' ;
  end if;
  
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0830' and mkid='M083015' and styp=1 and name='上传标书模板文件';    
  if num = 1 then
    update bs_qxsz set name='招标文件上传' where sid='M00008' and mid='M0830' and mkid='M083015' and styp=1 and name='上传标书模板文件' ;
  end if;
  
 num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0830' and mkid='M083020' and styp=1 and name='标书文件预览' and url='/exp/bidding/buy/zbwjone/toBswjView.do';    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0830' and mkid='M083020' and styp=1 and name='标书文件预览' and url='/exp/bidding/buy/zbwjone/toBswjView.do';
  end if;
  
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0830' and mkid='M083030' and styp=1 and name='发布标书文件' and url='/exp/bidding/buy/zbwjone/toBswjPublish.do';    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0830' and mkid='M083030' and styp=1 and name='发布标书文件' and url='/exp/bidding/buy/zbwjone/toBswjPublish.do';
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where sid='M00008' and mkid='M083020' or mkid='M083030' and styp=1 and action='/exp/bidding/buy/zbwjone';    
  if num > 0 then
    update bs_qxmx set mkid='M083015' where sid='M00008' and mkid='M083020' or mkid='M083030' and styp=1 and action='/exp/bidding/buy/zbwjone';
  end if;
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/zbwjone/toBswjPublish.do#/exp/bidding/buy/zbwjone/doBswjPublish.do') into num from bs_qxsz where  sid='M00008' and mid='M0830' and mkid='M083015' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toBswjPublish.do#/exp/bidding/buy/zbwjone/doBswjPublish.do') where  sid='M00008' and mid='M0830' and mkid='M083015' ; 
 end if;
 
  num:=0;
 select instr(inurl,'/exp/bidding/buy/zbwjone/toBswjView.do#/exp/bidding/buy/zbwjone/doBswjView.do') into num from bs_qxsz where  sid='M00008' and mid='M0830' and mkid='M083015' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/toBswjView.do#/exp/bidding/buy/zbwjone/doBswjView.do') where  sid='M00008' and mid='M0830' and mkid='M083015' ; 
 end if;
  
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083070' and styp=1  and name='踏勘现场通知';    
  if num = 1 then
    update bs_qxsz set name='踏勘现场',orderno='350' where sid='M00008' and mkid='M083070' and styp=1 and name='踏勘现场通知';
  end if;
  
  
--开标
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0840' and mkid='M084010' and styp=1 and name='待开标列表';    
  if num = 1 then
    update bs_qxsz set name='开标列表' where sid='M00008' and mid='M0840' and mkid='M084010' and styp=1 and name='待开标列表' ;
  end if;

--定标
   num:=0;
  select count(1) into num from bs_qxmx where sid='M00008' and mkid='M086030' and styp=1 and action='/exp/bidding/buy/scaling' ;    
  if num > 0 then
    update bs_qxmx set mkid='M086020' where sid='M00008' and mkid='M086030'  and styp=1 and action='/exp/bidding/buy/scaling';
  end if;
  
     num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086030' and styp=1 and name='定标审核' and url='/exp/bidding/buy/scaling/verifyScaling.do';    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0860' and mkid='M086030' and styp=1 and name='定标审核' and url='/exp/bidding/buy/scaling/verifyScaling.do';
  end if;
  
    num:=0;
 select instr(inurl,'/exp/bidding/buy/scaling/verifyScaling.do') into num from bs_qxsz where  sid='M00008' and mid='M0860' and mkid='M086020' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/verifyScaling.do') where  sid='M00008' and mid='M0860' and mkid='M086020' ; 
 end if;
 
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086040' and styp=1 and name='中标结果公告';    
  if num = 1 then
    update bs_qxsz set name='中标结果公告发布' where sid='M00008' and mid='M0860' and mkid='M086040' and styp=1 and name='中标结果公告' ;
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089080' and fixed=1 and name='资格预审结果通知书' ;    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0890' and mkid='M089080' and fixed=1 and name='资格预审结果通知书' ;
  end if;
  
    num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089085' and fixed=1 and name='资格预审结果通知书发布' ;    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0890' and mkid='M089085' and fixed=1 and name='资格预审结果通知书发布' ;
  end if;
  
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M08909605' and mid='M0890' ;
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M08909605','M0890','资格预审','资格预审结果发布-通知书',2,700,1,'M089096','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M08909610' and mid='M0890' ;
    if num=0 then
        insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
        values('M08909610','M0890','资格预审','资格预审结果发布-通知书发布',2,710,1,'M089096','M00008');
    end if;
    
    num:=0;
  select count(1) into num from bs_qxmx where sid='M00008' and action='/exp/bidding/buy/result' and mkid='M089080' and styp=1 ;    
  if num >0 then
    update bs_qxmx set mkid='M08909605' where sid='M00008' and action='/exp/bidding/buy/result' and mkid='M089080' and styp=1 ; 
  end if;
  
      num:=0;
  select count(1) into num from bs_qxmx where sid='M00008' and action='/exp/bidding/buy/release' and mkid='M089085' and styp=1 ;    
  if num >0 then
    update bs_qxmx set mkid='M08909610' where sid='M00008' and action='/exp/bidding/buy/release' and mkid='M089085' and styp=1 ; 
  end if;

   num:=0;
 select instr(inurl,'/exp/bidding/buy/release/view.do') into num from bs_qxsz where  sid='M00008' and mid='M0890' and mkid='M089096' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/release/view.do') where  sid='M00008' and mid='M0890' and mkid='M089096' ; 
 end if;
 
    num:=0;
 select instr(inurl,'/exp/bidding/buy/result/edit.do') into num from bs_qxsz where  sid='M00008' and mid='M0890' and mkid='M089096' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/result/edit.do') where  sid='M00008' and mid='M0890' and mkid='M089096' ; 
 end if;
 
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050' and styp=1 and name='货物中标通知书';    
  if num = 1 then
    update bs_qxsz set name='结果发布',fixed='',orderno=150 where sid='M00008' and mid='M0860' and mkid='M086050' and styp=1 and name='货物中标通知书' ;
  end if; 
  
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086060' and fixed=1 and name='工程中标通知书' ;    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0860' and mkid='M086060' and fixed=1 and name='工程中标通知书' ;
  end if;
  
     num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086070' and fixed=1 and name='招标结果通知书' ;    
  if num = 1 then
    DELETE FROM bs_qxsz WHERE sid='M00008' and mid='M0860' and mkid='M086070' and fixed=1 and name='招标结果通知书' ;
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where sid='M00008' and mkid='M086060' and styp=1 and action='/exp/bidding/buy/scaling' ;    
  if num > 0 then
    update bs_qxmx set mkid='M086050' where sid='M00008' and mkid='M086060'  and styp=1 and action='/exp/bidding/buy/scaling' and
     method in ('tzsSave','tzsTJ','tzsFS','tzsQT');
  end if;
    num:=0;
  ------下面两条语句有换行，请勿动
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toHwTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/b

uy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do'
    where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toHwTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/b

uy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do'; 
 ------上面两条语句有换行，请勿动
 end if;
  	--- hejw end----
	-------修改投标人 左边菜单
	num:=0;
  	select count(1) into num from bs_qxmx where sid='M00008' and mkid='M091094' and action='/exp/bidding/sell/ysopen' and method='show' ; 
  	if num = 1 then
		update bs_qxsz set name='资格预审申请文件开启', qxrole=1, inurl='/exp/bidding/sell/ysopen/index.do#/exp/bidding/sell/ysopen/show.do' 
		where mkid='M091092' and mid='M0910' and name='资格预审文件开启';
		delete from bs_qxsz where mkid='M091094' and mid='M0910' and name='资格预审文件开启情况';
		update bs_qxmx set mkid='M091092' where mkid='M091094' and action='/exp/bidding/sell/ysopen' and method='show';
		update bs_qxmx set mkid='M091092' where mkid='M091094' and action='/exp/bidding/sell/ysopen' and method='confirmRecord';
	end if;
  	--- hejw Start----
 num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089010' and url='/bdp/bidding/buy/preficfile/toScZgyswj.do';    
  if num = 1 then
    update bs_qxsz set url='/bdp/bidding/buy/preficfile/packlist.do' where sid='M00008' and mkid='M089010' and url='/bdp/bidding/buy/preficfile/toScZgyswj.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/bdp/bidding/buy/preficfile/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M089010' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/packlist.do') where  sid='M00008' and mkid='M089010' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089010','/bdp/bidding/buy/preficfile','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    
    --------------
  num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089096' and url='/exp/bidding/buy/gkys/toEdit.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/gkys/packlist.do' where sid='M00008' and mkid='M089096' and url='/exp/bidding/buy/gkys/toEdit.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/gkys/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M089096' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/gkys/packlist.do') where  sid='M00008' and mkid='M089096' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/gkys' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089096','/exp/bidding/buy/gkys','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
   -- 招标文件上传
      num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M083015' and url='/exp/bidding/buy/zbwjone/toUpBsmbWj.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/zbwjone/packlist.do' where sid='M00008' and mkid='M083015' and url='/exp/bidding/buy/zbwjone/toUpBsmbWj.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/zbwjone/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M083015' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/zbwjone/packlist.do') where  sid='M00008' and mkid='M083015' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/zbwjone' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M083015','/exp/bidding/buy/zbwjone','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
       -- 开标记录
      num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M084020' and url='/exp/bidding/buy/kb/kbRecord.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/kb/packlist.do' where sid='M00008' and mkid='M084020' and url='/exp/bidding/buy/kb/kbRecord.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/kb/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M084020' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/kb/packlist.do') where  sid='M00008' and mkid='M084020' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/kb' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M084020','/exp/bidding/buy/kb','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
    --评标结果
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M085010' and url='/bdp/review/result/index.do';    
  if num = 1 then
    update bs_qxsz set url='/bdp/review/result/packlist.do' where sid='M00008' and mkid='M085010' and url='/bdp/review/result/index.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/bdp/review/result/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M085010' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/bdp/review/result/packlist.do') where  sid='M00008' and mkid='M085010' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/review/result' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M085010','/bdp/review/result','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
    
   --中标候选人公示
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086010' and url='/exp/bidding/buy/scaling/toZbhxrgs.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/scaling/listzb.do' where sid='M00008' and mkid='M086010' and url='/exp/bidding/buy/scaling/toZbhxrgs.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/scaling/listzb.do') into num from bs_qxsz where  sid='M00008' and mkid='M086010' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/listzb.do') where  sid='M00008' and mkid='M086010' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='listzb' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M086010','/exp/bidding/buy/scaling','listzb',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
  --结果发布
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086050' and url='/exp/bidding/buy/scaling/toHwTzs.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/scaling/listjg.do' where sid='M00008' and mkid='M086050' and url='/exp/bidding/buy/scaling/toHwTzs.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/scaling/listjg.do') into num from bs_qxsz where  sid='M00008' and mkid='M086050' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/listjg.do') where  sid='M00008' and mkid='M086050' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='listjg' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M086050','/exp/bidding/buy/scaling','listjg',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
    
      --中标结果公告发布
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086040' and url='/exp/bidding/buy/scaling/toZbjggg.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/scaling/listgg.do' where sid='M00008' and mkid='M086040' and url='/exp/bidding/buy/scaling/toZbjggg.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/scaling/listgg.do') into num from bs_qxsz where  sid='M00008' and mkid='M086040' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/listgg.do') where  sid='M00008' and mkid='M086040' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='listgg' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M086040','/exp/bidding/buy/scaling','listgg',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
        --定标
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M086020' and url='/exp/bidding/buy/scaling/toScaling.do';    
  if num = 1 then
    update bs_qxsz set url='/exp/bidding/buy/scaling/listdb.do' where sid='M00008' and mkid='M086020' and url='/exp/bidding/buy/scaling/toScaling.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/exp/bidding/buy/scaling/listdb.do') into num from bs_qxsz where  sid='M00008' and mkid='M086020' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/scaling/listdb.do') where  sid='M00008' and mkid='M086020' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and  method='listdb' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M086020','/exp/bidding/buy/scaling','listdb',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
  	--- hejw end----
	--------------------------------------------mazg start-------------------------------------------------------
	--履约保证金菜单
	--权限明细 申请支付
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096030'  and method='applyPay';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096030','/exp/bidding/sell/contract/bidbond','applyPay','2','申请支付',1,'M00008');
  	end if;
  	--inurl
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mid='M0960' and mkid='M096030'  and instr(inurl,'#/exp/bidding/sell/contract/bidbond/applyPay.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/bidbond/applyPay.do') where sid='M00008' and mid='M0960' and mkid='M096030';
    end if;
    
    --财务列表（费用支付（财务））
	--权限设置
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0960' and mkid='M096040';     
    if num = 0 then 
      insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
      values ('M096040','M0960','签订合同','费用支付（财务）','/exp/bidding/sell/contract/bidbond/cwlist.do','/exp/bidding/sell/contract/bidbond/cwlist.do#/exp/bidding/sell/contract/bidbond/pay.do#/exp/bidding/sell/contract/bidbond/payMoney.do#/exp/bidding/sell/contract/bidbond/delete.do#/exp/bidding/sell/contract/bidbond/showDd.do',1,500,1,'M00008',1); 
	end if;
	--权限明细 费用支付（财务）列表
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096040'  and method='cwlist';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096040','/exp/bidding/sell/contract/bidbond','cwlist','2','费用支付（财务）列表',1,'M00008');
  	end if;
  	--权限明细 删除订单
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096040'  and method='delete';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096040','/exp/bidding/sell/contract/bidbond','delete','2','删除订单',1,'M00008');
  	end if;
  	--权限明细 支付(页面跳转)
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096040'  and method='pay';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096040','/exp/bidding/sell/contract/bidbond','pay','2','支付(页面跳转)',1,'M00008');
  	end if;
  	--权限明细 付钱
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096040'  and method='payMoney';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096040','/exp/bidding/sell/contract/bidbond','payMoney','2','付钱',1,'M00008');
  	end if;
  	--权限明细 查看
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and sid = 'M00008'  and mkid='M096040'  and method='showDd';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
      values('M096040','/exp/bidding/sell/contract/bidbond','showDd','2','查看订单',1,'M00008');
  	end if;
  	--------------------------------------------mazg end-------------------------------------------------------

------hejw start-------
   --资格预审评审报告
   num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M089045' and url='/bdp/pre/result/index.do';    
  if num = 1 then
    update bs_qxsz set url='/bdp/pre/result/packlist.do' where sid='M00008' and mkid='M089045' and url='/bdp/pre/result/index.do' ;
  end if; 
  
 num:=0;
 select instr(inurl,'/bdp/pre/result/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M089045' ; 
 if num = 0 then
  update bs_qxsz set inurl=concat(inurl,'#/bdp/pre/result/packlist.do') where  sid='M00008' and mkid='M089045' ; 
 end if;
 
 	  num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/pre/result' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M089045','/bdp/pre/result','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    ---------------
------hejw end-------

	-----chenxp start-----
    -- 项目管理
    num:=0;
	select count(1) into num from bs_xtmk where mid='M0100' and sid ='M00008';
	if num=1 then
		update bs_xtmk set mname = '项目管理' where mid='M0100' and sid ='M00008';
	end if;
  
  
    -- 招标管理
  	num:=0;
  	select count(1) into num from bs_xtmk where mid='M0300' and sid='M00008';
  	if num=0 then   
   		insert into bs_xtmk (mid,mname ,styp,ordby , sid,qxrole) 
   		values('M0300','招标管理','1','130','M00008','008-1');
  	end if;  
  
  	--发起招标
   	num:=0;
   	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M030010' and mid='M0300';
   	if num = 0 then 
      	insert into bs_qxsz(mkid, mid, mname, name,  isuse, orderno,styp,  sid ) 
   		values('M030010', 'M0300', '招标管理', '发起招标', 1,100, 1, 'M00008');
   	end if;
   	
   	num:=0;
   	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M030010' and mid='M0300';
   	if num = 1 then 
        update bs_qxsz set inurl='/exp/bidding/buy/launchtender/launchList.do' , url='/exp/bidding/buy/launchtender/launchList.do' where  sid = 'M00008' and mkid='M030010' and mid='M0300';
   	end if;
   
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/launchtender' and sid = 'M00008'  and method='launchList';
  	if num = 0 then
   		 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values('M030010','/exp/bidding/buy/launchtender','launchList','2','发起招标','1','M00008');
    end if;
  
  	--已完成招标
   	num:=0;
   	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M030030' and mid='M0300';
   	if num = 0 then 
        insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ) 
        values('M030030', 'M0300', '招标管理', '已完成招标', '/exp/bidding/buy/completePro/list.do', '/exp/bidding/buy/completePro/list.do' , 1,300, 1, 'M00008');
   	end if;
   
    num:=0;
   	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M030030' and mid='M0300';
   	if num = 1 then 
        update bs_qxsz set inurl='/exp/bidding/buy/completePro/list.do' , url='/exp/bidding/buy/completePro/list.do' where  sid = 'M00008' and mkid='M030030' and mid='M0300';
   	end if;
   
   
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/completePro' and sid = 'M00008'  and method='list';
  	if num = 0 then
   		 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030030','/exp/bidding/buy/completePro','list','2','已完成招标','1','M00008');
    end if;
    
  
  	--正在项目
  	num:=0;
  	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M010065' and mid='M0100' and url='/exp/bidding/buy/beingPro/list.do';
  	if num = 1 then 
      delete from bs_qxsz  where sid = 'M00008' and mkid='M010065' and mid='M0100' and url='/exp/bidding/buy/beingPro/list.do';
  	end if; 
  
   	num:=0;
   	select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
   	if num = 0 then 
        insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ) 
        values('M030020', 'M0300', '招标管理', '正在项目', '/exp/bidding/buy/beingPro/list.do', '/exp/bidding/buy/beingPro/list.do' , 1,200, 1, 'M00008');
   	end if;
   
   	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and mkid='M010065' ;
  	if num >0 then
      delete bs_qxmx where action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and mkid='M010065' ;
    end if;
   
   	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008' and method='list';
  	if num = 0 then
   		 insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030020','/exp/bidding/buy/beingPro','list','2','正在项目','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='viewEntrust';
    if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M030020','/exp/bidding/buy/beingPro','viewEntrust','2','查看委托','1','M00008');
  	end if;
  
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='trustReceipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
   	 	values('M030020','/exp/bidding/buy/beingPro','trustReceipt','2','委托回执','1','M00008');
  	end if;
  
 
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='saveTrustReceipt';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M030020','/exp/bidding/buy/beingPro','saveTrustReceipt','2','保存委托回执','1','M00008');
  	end if;
  
 	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='editwtxy';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M030020','/exp/bidding/buy/beingPro','editwtxy','2','编制委托协议','1','M00008');
 	end if;
  
  	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'   and method='savewtxy';
  	if num = 0 then
    	insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    	values('M030020','/exp/bidding/buy/beingPro','savewtxy','2','保存委托协议','1','M00008');
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/viewEntrust.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
  	if num = 0 then
  	    update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/viewEntrust.do') where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/saveTrustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
  	if num = 0 then
    	 update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/saveTrustReceipt.do') where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
 
 	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/trustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
  	if num = 0 then
      	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/trustReceipt.do') where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/editwtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/editwtxy.do') where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
  
  	num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/savewtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
  	if num = 0 then
    	 update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/savewtxy.do') where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
  
   ---chenxp end-------


    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
