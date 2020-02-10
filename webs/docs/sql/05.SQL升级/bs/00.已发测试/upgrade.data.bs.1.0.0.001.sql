DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.001'; -- 本升级文件的版本，每个升级文件必须修改
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
  select count(1) into num from bs_qxmx where mkid='M012005' and method='viewRequirement' and sid='M00004';
  if num=0 then
    insert into bs_qxmx values(bs_qxmx_0.nextval,'M012005','/tdp/puc/plan/manager','viewRequirement',2,'查看采购需求',1,'M00004');
    update bs_qxsz set inurl=inurl||'#/tdp/puc/plan/manager/viewRequirement.do' where mkid='M012005' and sid='M00004';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where mkid='M012505' and method='toViewPlan' and sid='M00004';
  if num=0 then
    insert into bs_qxmx values(bs_qxmx_0.nextval,'M012505','/tdp/puc/mission/manager','toViewPlan',2,'查看采购计划',1,'M00004');
    update bs_qxsz set inurl=inurl||'#/tdp/puc/mission/manager/toViewPlan.do' where mkid='M012505' and sid='M00004';
  end if;

  num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/hangadmin' and method='doDelAll' and styp=1 and sid='M00201';
  if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M012005','/gb/hangsource/sell/hangadmin','doDelAll',2,'批量删除',1,'M00201');
  end if;
    -------------------------------------------------------------
  -- add by zhangsiwei on 20131226
  num:=0;
  select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and method='syscodelist' and styp=1 and sid='M00201';
  if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,0,'/market/syscode/publicfun','syscodelist',1,'获取常用代码设置AJAX',1,'M00201');
  end if;
  num:=0;
  select count(1) into num from bs_qxmx where action='/public/item' and method='queryWzdmList' and styp=1 and sid='M00201';
  if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,0,'/public/item','queryWzdmList',1,'获取物资编码AJAX',1,'M00201');
  end if;
  
  num:=0;
  select count(1) into num from bs_xtmk where mid='M0220' and sid='M00004';
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0220','费用管理',1,1100,'M00004','004-4');
  end if;
  
  num:=0;
  select count(1) into num from bs_xtmk where mid='M0225' and sid='M00004';
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0225','集团报表',1,1200,'M00004','004-5');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M011520' and mid='M0115' and styp=1 and sid='M00004';
  if num > 0 then
    update bs_qxsz set mkid='M022535',mid='M0225',mname='集团报表',url='/tdp/report/req/list.do',name='需求明细查询' where mkid='M011520' and mid='M0115' and styp=1 and sid='M00004';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M012020' and mid='M0120' and styp=1 and sid='M00004';
  if num > 0 then
    update bs_qxsz set mkid='M022540',mid='M0225',mname='集团报表',url='/tdp/report/plan/list.do',name='计划明细查询' where mkid='M012020' and mid='M0120' and styp=1 and sid='M00004';
    end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M012520' and mid='M0125' and styp=1 and sid='M00004';
  if num > 0 then
    update bs_qxsz set mkid='M022545',mid='M0225',mname='集团报表',url='/tdp/report/mission/list.do',name='任务明细查询' where mkid='M012520' and mid='M0125' and styp=1 and sid='M00004';
    end if;
  -------------------------------------------------------------
    select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and  method='syscodelist' and styp='1' and sid='M00004';       
    if num = 0 then       
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid) 
    values(bs_qxmx_0.nextval,0,'/market/syscode/publicfun','syscodelist',1,'获取常用代码设置AJAX',1,'M00004');
    end if;
    
  update bs_qxsz set inurl='/tdp/dev/eval/pbmb/index.do#/tdp/dev/eval/pbmb/add.do' where sid='M00004' and mkid='M010505';
  update bs_qxsz set inurl='/tdp/dev/bsmb/index.do#/tdp/dev/bsmb/add.do' where sid='M00004' and mkid='M010510';
  update bs_qxsz set inurl='/tdp/dev/project/index.do#/tdp/dev/scheme/index.do#/tdp/dev/scheme/add.do#/tdp/dev/scheme/toAnnouncement.do#/tdp/dev/package/index.do#/tdp/dev/package/add.do#/tdp/dev/package/chooosePbzj.do#/tdp/dev/package/zgys.do#/tdp/dev/package/zghs.do#/tdp/dev/package/anwser.do#/tdp/dev/package/kbinfo.do#/tdp/dev/package/secondbid.do#/tdp/dev/package/secondbid.do' where sid='M00004' and mkid='M010515';
  update bs_qxsz set inurl='/tdp/dev/expert/index.do#/tdp/dev/expert/add.do' where sid='M00004' and mkid='M010520';
  update bs_qxsz set inurl='/tdp/dev/cost/index.do' where sid='M00004' and mkid='M010525';
  update bs_qxsz set inurl='/tdp/join/quote/index.do#/tdp/join/quote/fileup.do#/tdp/join/quote/question.do#/tdp/join/result/index.do#/tdp/join/result/anwserzj.do' where sid='M00004' and mkid='M011030';
  
  update bs_qxsz set inurl='/tdp/puc/req/index.do#/tdp/puc/req/toAdd.do#/tdp/puc/req/toEdit.do#/tdp/puc/req/toSubmit.do#/tdp/puc/req/view.do' where sid='M00004' and mkid='M011505' and styp=1;
	-- add by zhangsiwei on 20131226
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and method='syscodelist' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/market/syscode/publicfun','syscodelist',1,'获取常用代码设置AJAX',1,'M00201');
	end if;
	num:=0;
	select count(1) into num from bs_qxmx where action='/public/item' and method='queryWzdmList' and styp=1 and sid='M00201';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/public/item','queryWzdmList',1,'获取物资编码AJAX',1,'M00201');
	end if;
	
	  select count(1) into num from bs_qxmx where action='/market/syscode/publicfun' and  method='syscodelist' and styp='1' and sid='M00004';       
	  if num = 0 then       
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid) 
		values(bs_qxmx_0.nextval,0,'/market/syscode/publicfun','syscodelist',1,'获取常用代码设置AJAX',1,'M00004');
	  end if;
	  
	select count(1) into num from bs_qxmx where action='/tdp/dev/expertReport' and mkid='M010530' and method='index' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010530','/tdp/dev/expertReport','index',2,'招标管理-专家签到情况',1,'M00004'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/tdp/dev/expertReport' and mkid='M010530' and method='view' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010530','/tdp/dev/expertReport','view',2,'招标管理-专家签到情况-评分信息',1,'M00004'); 
	end if;
	
	select count(1) into num from bs_qxsz where mkid='M010530' and mid='M0105' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M010530','M0105','招标信息','专家签到情况','/tdp/dev/expertReport/index.do','/tdp/dev/expertReport/index.do#/tdp/dev/expertReport/view.do',1,600,1,'M00004');
	end if;
	  
	select count(1) into num from bs_qxmx where action='/tdp/common/index' and mkid='0' and method='queryPriceCompareList' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/tdp/common/index','queryPriceCompareList',1,'报价对比查询报价信息',1,'M00004'); 
	end if;
	
	select count(1) into num from bs_qxmx where action='/tdp/dev/package' and mkid='M010515' and method='pricecompare' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010515','/tdp/dev/package','pricecompare',2,'招标管理-报价对比',1,'M00004'); 
	end if;
	
	
	select count(1) into num from bs_qxmx where action='/tdp/dev/package' and mkid='M010515' and method='tbqk' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010515','/tdp/dev/package','tbqk',2,'招标管理-报价情况',1,'M00004'); 
	end if;
	
	
	  
	update bs_qxsz set orderno='100',inurl='/tdp/dev/eval/pbmb/index.do#/tdp/dev/eval/pbmb/add.do' where sid='M00004' and mkid='M010505';
	update bs_qxsz set orderno='200',inurl='/tdp/dev/bsmb/index.do#/tdp/dev/bsmb/add.do' where sid='M00004' and mkid='M010510';
	update bs_qxsz set orderno='400',inurl='/tdp/dev/project/index.do#/tdp/dev/scheme/index.do#/tdp/dev/scheme/add.do#/tdp/dev/scheme/toAnnouncement.do#/tdp/dev/package/index.do#/tdp/dev/package/add.do#/tdp/dev/package/chooosePbzj.do#/tdp/dev/package/zgys.do#/tdp/dev/package/zghs.do#/tdp/dev/package/anwser.do#/tdp/dev/package/kbinfo.do#/tdp/dev/package/secondbid.do#/tdp/dev/package/secondbid.do' where sid='M00004' and mkid='M010515';
	update bs_qxsz set orderno='300',inurl='/tdp/dev/expert/index.do#/tdp/dev/expert/add.do' where sid='M00004' and mkid='M010520';
	update bs_qxsz set orderno='500',inurl='/tdp/dev/cost/index.do' where sid='M00004' and mkid='M010525';
	update bs_qxsz set orderno='600',inurl='/tdp/join/quote/index.do#/tdp/join/quote/fileup.do#/tdp/join/quote/question.do#/tdp/join/result/index.do#/tdp/join/result/anwserzj.do' where sid='M00004' and mkid='M011030';

    update bs_qxsz set inurl='/tdp/puc/req/approve/list.do#/tdp/puc/req/approve/approve.do' where sid='M00004' and mkid='M011510' and styp=1;
    
     update bs_qxsz set inurl='/tdp/puc/req/query/list.do' where sid='M00004' and mkid='M011515' and styp=1; 
	 
	 
	 update bs_qxsz set name='员工管理' where mkid='M011505' and sid='M00000';
	 
	 UPDATE BS_QXSZ SET ISUSE = 1, INURL = URL WHERE SID='M00000' AND MKID='M010015';
    -------------------------------------------------------------
	-- add 禁用委托历史功能 by zhangsiwei on 20131226
	select count(1) into num from bs_qxsz where mkid='M016015' and mid='M0160';
	if num=1 then
		update bs_qxsz set isuse=0 where mkid='M016015' and mid='M0160'
	end if;
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  