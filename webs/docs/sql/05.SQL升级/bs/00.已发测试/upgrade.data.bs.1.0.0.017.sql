DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.17'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_xtmk where  sid='M00000' and mid='M0300';       
	if num = 0 then 
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0300','供应商管理',1,'10','M00000','004-6');
    END IF;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='M0300' and mkid='M030015' and sid='M00000';       
    if num = 0 then
   		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M030015','M0300','供应商管理','合格供应商','/bsp/suplier/qualified/list.do','/bsp/suplier/qualified/list.do',1,100,1,'','M00000');
   end if;
   num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/qualified' and method='list' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M030015', '/bsp/suplier/qualified', 'list', 2, '供应商管理-合格信息', 1, 'M00000');
    END IF;
	


	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00201' and action='/exp/hangsource/buy/picksource' and method='sourceSnapshot' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/exp/hangsource/buy/picksource', 'sourceSnapshot', 0, '商品快照', 1, 'M00201');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/menber/checkgroup' and method='viewMap' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011510', '/bsp/menber/checkgroup', 'viewMap', 2, '审批流关系图', 1, 'M00000');
    end if;

    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M030005' and sid='M00000';       
    if num = 0 then
   		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M030005','M0300','供应商管理','供应商登记','/bsp/suplier/manage/index.do','/bsp/suplier/manage/index.do#/bsp/suplier/manage/add.do#/bsp/suplier/manage/save.do',1,10,1,'','M00000');
   end if;
   
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M030010' and sid='M00000';       
    if num = 0 then
   		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M030010','M0300','供应商管理','供应商审核','/bsp/suplier/audit/index.do','/bsp/suplier/audit/index.do#/bsp/suplier/audit/audit.do#/bsp/suplier/audit/confirm.do',1,20,1,'','M00000');
   end if;
   
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M03000505' and sid='M00000';       
    if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M03000505','M0300','供应商管理','编辑','','',2,10,1,'M030005','M00000');
   end if;
   
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M03001005' and sid='M00000';       
    if num = 0 then
   		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M03001005','M0300','供应商审核','审核','','',2,20,1,'M030010','M00000');
   end if;
   
   
   
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/audit' and method='index' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M030010', '/bsp/suplier/audit', 'index', 2, '供应商审核', 1, 'M00000');
    end if;
   
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/audit' and method='audit' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03001005', '/bsp/suplier/audit', 'audit', 2, '供应商审核', 1, 'M00000');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/audit' and method='confirm' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03001005', '/bsp/suplier/audit', 'confirm', 2, '供应商审核', 1, 'M00000');
    end if;

	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/manage' and method='index' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M030005', '/bsp/suplier/manage', 'index', 2, '供应商登记', 1, 'M00000');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/manage' and method='add' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03000505', '/bsp/suplier/manage', 'add', 2, '供应商登记', 1, 'M00000');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/bsp/suplier/manage' and method='save' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03000505', '/bsp/suplier/manage', 'save', 2, '供应商登记', 1, 'M00000');
    end if;
    
    
    num:=0;
	select count(1) into num from bs_xtmk where mid='M0230' and sid='M00004';
	if num = 1 then
    	update bs_xtmk set mname='发起团购' where mid='M0230' and sid='M00004' and mname='团购管理';
    	update bs_qxsz set mname='发起团购' where mkid='M023005' and sid='M00004' and mname='团购管理';
		update bs_qxsz set mname='发起团购',name='未发布' where mkid='M023010' and sid='M00004' and mname='团购管理';
		update bs_qxsz set mname='发起团购' where mkid='M023015' and sid='M00004' and mname='团购管理';
		update bs_qxsz set mname='发起团购' where mkid='M023020' and sid='M00004' and mname='团购管理';
    end if;

	num:=0;
	select count(1) into num from bs_xtmk where mid='M0255' and sid='M00004';
	if num = 0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid,qxrole)
		values('M0255','参加团购',1,300,'M00004','004-1-1');
	end if;
    
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M025505' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		values('M025505','M0255','参加团购','加入团购','/tuangou/',1,10,1,'M00004');
	end if;

	num:= 0;
	select count(1) into num from bs_qxsz where mkid='M023025' and sid='M00004';
	if num = 1 then
		update bs_qxsz set mkid='M025510',mid='M0255',mname='参加团购',name='我的团购',orderno=20 where mkid='M023025' and sid='M00004' and name='团购历史';
		update bs_qxmx set mkid='M025510' where mkid='M023025' and sid='M00004';
	end if;
	
	
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00004' and action='/me/supplier/home' and method='index' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/me/supplier/home','index',1,'我的平台(供应商管理)',1,'M00004');
    end if;
    
	
	num:=0;
	select count(1) into num from bs_qxmx where  sid='M00004' and action='/me/supplier/home' and method='home' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/me/supplier/home','home',1,'我的平台(供应商管理)',1,'M00004');
    end if;
	
	update  bs_qxsz set inurl='/bsp/menber/checkgroup/list.do#/bsp/menber/checkgroupopt/list.do#//bsp/menber/checkgroupopt/viewMap.do' where mkid='M011510'and sid='M00000'and styp=1;

	num:=0;
    select count(1) into num from bs_qxmx where  sid='M00201' and action='/me/home' and method='showDiscuss' and styp=1;       
    if num = 0 then 
	    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	    values (bs_qxmx_0.nextval, 'M011545', '/me/home', 'showDiscuss', 1, '业务提醒', 1, 'M00201');
    END IF;
    
    num:=0;
  select count(1) into num from bs_qxmx where  sid='M00004' and action='/me/home' and method='showDiscuss' and styp=1;       
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M011545', '/me/home', 'showDiscuss', 1, '业务提醒', 1, 'M00004');
    END IF;
	
    
    
    
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  