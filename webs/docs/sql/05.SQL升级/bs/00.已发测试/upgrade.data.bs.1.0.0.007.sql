DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.7'; -- 本升级文件的版本，每个升级文件必须修改
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
  
  
  select count(1) into num from bs_xtmk where mid='M0245' and sid='M00004';       
  if num = 0 then
	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0245','物资调剂',1,50,'M00004','004-2');
  end if;
  
  select count(1) into num from bs_qxsz where mkid='M024505' and sid='M00004';       
  if num = 0 then
	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	values('M024505','M0245','物资调剂','物资调剂管理','/tdp/materials/manager/list.do','/tdp/materials/manager/list.do#/tdp/materials/manager/add.do',1,100,1,'','M00004');
  end if;
  
  select count(1) into num from bs_qxsz where mkid='M02450505' and sid='M00004';       
  if num = 0 then
	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	values('M02450505','M0245','物资调剂','编辑','','',2,100,1,'M024505','M00004');
  end if;
  
  select count(1) into num from bs_qxsz where mkid='M024510' and sid='M00004';       
  if num = 0 then
	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	values('M024510','M0245','物资调剂','物资调剂审核','/tdp/materials/audit/list.do','/tdp/materials/audit/list.do#/tdp/materials/audit/add.do',1,200,1,'','M00004');
  end if;	
  
  select count(1) into num from bs_qxsz where mkid='M02451005' and sid='M00004';       
  if num = 0 then
	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
	values('M02451005','M0245','物资调剂','审核','','',2,100,1,'M024510','M00004');
  end if;	
  
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='list' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M024505','/tdp/materials/manager','list','2','物资调剂-物资调剂管理','1','M00004');
  end if;	
  
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='info' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'0','/tdp/materials/manager','info','0','物资调剂-物资调剂查看','1','M00004');
  end if;	 
  
  
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='add' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02450505','/tdp/materials/manager','add','2','物资调剂-物资调剂管理-新增','1','M00004');
  end if;	 
  
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='save' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02450505','/tdp/materials/manager','save','2','物资调剂-物资调剂管理-保存','1','M00004');
  end if;	   
  
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='delete' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02450505','/tdp/materials/manager','delete','2','物资调剂-物资调剂管理-删除','1','M00004');
  end if;	   
    
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='deletemore' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02450505','/tdp/materials/manager','deletemore','2','物资调剂-物资调剂管理-批量删除','1','M00004');
  end if;	   

  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/manager' and METHOD='offshelf' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02450505','/tdp/materials/manager','offshelf','2','物资调剂-物资调剂管理-下架','1','M00004');
  end if;	

  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/audit' and METHOD='list' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M024510','/tdp/materials/audit','list','2','物资调剂-物资调剂审核','1','M00004');
  end if;	

  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/audit' and METHOD='audit' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02451005','/tdp/materials/audit','audit','2','物资调剂-物资调剂审核-审核信息','1','M00004');
  end if;	

   select count(1) into num from bs_qxmx where ACTION='/tdp/materials/audit' and METHOD='confirm' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02451005','/tdp/materials/audit','confirm','2','物资调剂-物资调剂审核-审核','1','M00004');
  end if;	
  
   select count(1) into num from bs_qxmx where ACTION='/tdp/materials/audit' and METHOD='passmore' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02451005','/tdp/materials/audit','passmore','2','物资调剂-物资调剂审核-批量审核','1','M00004');
  end if;	

   select count(1) into num from bs_qxmx where ACTION='/tdp/materials/audit' and METHOD='cancelmore' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'M02451005','/tdp/materials/audit','cancelmore','2','物资调剂-物资调剂审核-批量弃审','1','M00004');
  end if;	

   select count(1) into num from bs_qxmx where ACTION='/login' and METHOD='indexLogin' and STYP='1' and SID='M00000';     
  if num = 0 then
        insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values ('0', '/login', 'indexLogin', 0, '前台登录', 1, 'M00000');
  end if;

   select count(1) into num from bs_qxmx where ACTION='/login' and METHOD='indexIndex' and STYP='1' and SID='M00000';     
  if num = 0 then
        insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values ('0', '/login', 'indexIndex', 0, '前台登录', 1, 'M00000');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/tdp/puc/req/approve' and METHOD='cancelApprove' and STYP='1' and SID='M00004';     
  if num = 0 then
        insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values ('M011510', '/tdp/puc/req/approve', 'cancelApprove', 2, '取消审核', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/tdp/puc/plan/approve' and METHOD='cancelApprove' and STYP='1' and SID='M00004';     
  if num = 0 then
        insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values ('M012010', '/tdp/puc/plan/approve', 'cancelApprove', 2, '取消审核', 1, 'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where ACTION='/tdp/puc/mission/approve' and METHOD='cancelApprove' and STYP='1' and SID='M00004';     
  if num = 0 then
        insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values ('M012510', '/tdp/puc/mission/approve', 'cancelApprove', 2, '取消审核', 1, 'M00004');
  end if;



	num:=0;
	select count(1) into num from bs_qxsz where mkid='M023010' and sid='M00004';
	if num = 1 then
		update bs_qxsz set inurl = '/gb/hangsource/sell/hangadmin/doGpAllPreview.do#/gb/hangsource/sell/publish/preview.do#' where mkid='M023010' and sid='M00004';
	end if;
	
	
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/index' and METHOD='index' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'0','/tdp/materials/index','index','0','物资调剂-首页','1','M00004');
  end if;	

	
  select count(1) into num from bs_qxmx where ACTION='/tdp/materials/index' and METHOD='frame' and STYP='1' and SID='M00004';     
  if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
	values(bs_qxmx_0.nextval,'0','/tdp/materials/index','frame','0','物资调剂-首页','1','M00004');
  end if;	

  
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  