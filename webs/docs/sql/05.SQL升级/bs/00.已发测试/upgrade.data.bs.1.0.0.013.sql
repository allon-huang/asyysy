DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.13'; -- 本升级文件的版本，每个升级文件必须修改
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
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='chooseMember' and styp=1 and sid='M00004';
    if num = 0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','chooseMember',1,'线下询价：选择会员列表',1,'M00004');
	end if;
  
  num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='addJoinMember' and styp=1 and sid='M00004';
    if num = 0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','addJoinMember',1,'线下询价：保存会员',1,'M00004');
	end if;
	
	update bs_qxsz set name = '应标中' where mkid = 'M021510' and name = '投标中';
	update bs_qxsz set name = '应标结果' where mkid = 'M021530' and name = '投标结果';

	
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B010520' and sid='B00004';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		values('B010520','B0105','基本设置','常用代码设置','/admin/basesetup/codes/list.do',1,300,2,'B00004');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='list' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','list',2,'常用代码类别列表',2,'B00004');
	end if;
	
	update bs_qxsz set inurl='/exp/querybusiness/buy/list.do#/exp/querybusiness/process/buy/list.do#/exp/querybusiness/completed/buy/list.do' where mname='询货采购';
    update bs_qxsz set inurl='/exp/querybusiness/process/sell/list.do#/exp/querybusiness/process/sell/resultList.do' where mname='询货销售';
 
 	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='toAdd' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','toAdd',2,'跳转新增常用代码页面',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='save' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','save',2,'新增常用代码',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='toEdit' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','toEdit',2,'跳转修改常用代码页面',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='update' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','update',2,'修改常用代码',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='batchDelete' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','batchDelete',2,'删除常用代码',2,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/admin/basesetup/codes' and method='show' and styp=2 and sid='B00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010520','/admin/basesetup/codes','show',2,'查看常用代码设置',2,'B00004');
	end if;
	
	--- 团购交易
update bs_xtmk set qxrole ='004-1-1' where sid='M00004' and mid='M0230' and styp=1;
--询价交易
update bs_xtmk set qxrole ='004-1-2' where sid='M00004' and (mid='M0170' or mid='M0180') and styp=1;
--招标交易
update bs_xtmk set qxrole ='004-1-3' where sid='M00004' and (mid='M0105' or mid='M0110') and styp=1;
--竞价采购交易
update bs_xtmk set qxrole ='004-1-4' where sid='M00004' and (mid='M0205' or mid='M0215') and styp=1;
--闲废次交易
update bs_xtmk set qxrole ='004-1-5' where sid='M00004' and (mid='M0235' or mid='M0240') and styp=1;
	
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  