DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.32'; -- 本升级文件的版本，每个升级文件必须修改
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
    select count(1) into num from bs_qxmx where action='/bk/login/license' and method='license' and styp=1 and sid='M00301';
    if num = 0 then
    	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/bk/login/license','license',1,'会员登录签约',1,'M00301');
	end if;
  	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bk/login/license' and method='sendLicense' and styp=1 and sid='M00301';
    if num = 0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,0,'/bk/login/license','sendLicense',1,'会员登录签约',1,'M00301');
	end if;
	
update bs_qxmx set accesstag='0' where  action='/swfupload' and method='upload' and sid='M00201';
	
	
	-- 代理商管理
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M010035' and sid='M00000';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		values('M010035','M0100','基本管理','代理商管理','/bsp/menber/wldw/list.do',1,3,1,'M00000');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='list' and styp=1 and sid='M00000';
    if num = 0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010035','/bsp/menber/wldw','list',2,'代理商列表',1,'M00000');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='toAdd' and styp=1 and sid='M00000';
    if num = 0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010035','/bsp/menber/wldw','toAdd',2,'新增代理商页面',1,'M00000');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='save' and styp=1 and sid='M00000';
    if num = 0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010035','/bsp/menber/wldw','save',2,'新增代理商',1,'M00000');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/bsp/menber/wldw' and method='delete' and styp=1 and sid='M00000';
    if num = 0 then
		insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010035','/bsp/menber/wldw','delete',2,'删除代理商',1,'M00000');
	end if;
	
	update bs_qxsz set isuse='0' where  mname ='基础设置' and styp=2 and sid='B00002' and mkid in('B010205','B010210');
	update bs_qxsz set isuse='0' where  mname ='短信订阅' and styp=2 and sid='B00002' and mkid ='B010015';
	
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  