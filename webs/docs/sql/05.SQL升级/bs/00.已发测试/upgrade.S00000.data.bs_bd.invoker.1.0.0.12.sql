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
	
	--------------------------------------------------hejw 2017-07-10 新增基础Invoker系统 start------------------------------------------------------
	
	
	
	
	
	
	
	
	--------------------------------------------------hanglong 2017-06-21 新增基础Invoker系统 start------------------------------------------------------
	--num:=0;
	--select count(1) into num from bs_system where sid='B10000';
	--if num = 0 then
	--	insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04, SYSTYPE)
	--	values('B10000', '基础子平台', '基础子平台', 2, '/', 10000, '/', '/', '/', '/', '_bsInvokerSystem', 2);
	--end if;
	
	--num:=0;
	--select count(1) into num from bs_xtmk where sid='B10000' and mid='B0100';
	--if num = 0 then
	--	insert into bs_xtmk(MID, MNAME, STYP, ORDBY, SID)
	--	values('B0100', '会员管理', 2, 100, 'B10000');
	--end if;
	
	--num:=0;
	--select count(1) into num from bs_qxsz where sid='B10000' and mkid='B020030';
	--if num = 0 then
	--	insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
	--	values('B020030','B0200','基本设置','密码修改','/invoker/basesetup/pwd/index.do','/invoker/basesetup/pwd/index.do',1,300,2,'B10000');
	--end if;
	
	--num:=0;
    --select count(1) into num from bs_qxmx where action='/invoker/system/auth' and method='doQxfp' and sid='B10000';
    --if num = 0 then
    --     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
    --     values('B03001005', '/invoker/system/auth', 'doQxfp', 2, '更新权限', 2, 'B10000');
    --end if;
    --------------------------end--------------------------------------------------------------

    ---------add by hejw 2017-08-23  start --------------------------------------------------------------------------------------------------
    ------需要删除时放开---------
    ---------delete bs_system where sid in ('B10008','M10008','M10009');
    ------需要删除时放开---------
    -----xtmk表删除
   -- delete bs_xtmk where sid in ('B10008','M10008','M10009');
    -----qxsz表-需要先删除
    --delete bs_qxsz where sid in ('B10008','M10008','M10009');
    -----qxmx表-需要先删除
    --delete bs_qxmx where sid in ('B10008','M10008','M10009');
    
    ----------------- 2017-08-16 hejw start------------------------------------------------------
     -- num:=0;
     -- select count(1) into num from bs_system where sid='B10008';
     -- if num = 0 then
     --   insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04, SYSTYPE)
     --   values('B10008', '山能招投标平台', '招投标', 2, '/admin/index.do', 10000, 'http://bd.td.steel56.com.cn/bdmanager', '/admin/login/index.do', '/admin/noAuth.do', '/admin/login/doLogout.do', '_snbdSystem', 2);
     -- end if;
      
     -- num:=0;
     -- select count(1) into num from bs_system where sid='M10008';
     -- if num = 0 then
     --   insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04, SYSTYPE)
     --   values('M10008', '山能招投标平台', '招投标', 1, '/me/home/index.do', 10000, 'http://bd.td.steel56.com.cn/bdplatform', '/login/bdIndex.do', '/auth/noAuth.do', '/login/doLogout.do', '_snbdSystem', 2);
     -- end if;
      
     -- num:=0;
     -- select count(1) into num from bs_system where sid='M10009';
     -- if num = 0 then
     --   insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04, SYSTYPE)
     --   values('M10009', '山能评审平台', '评审', 1, '/me/home/index.do', 10000, 'http://ps.td.steel56.com.cn/psplatform', '/login/index.do', '/auth/noAuth.do', '/login/doLogout.do', '_snpsSystem', 2);
     -- end if;
    -------------------------------------------------------------------------------------------------------

    --招投标前台-xtmk
    insert into bs_xtmk(mid, mname, styp, url00, ordby, sid, qxrole, icon)
    select k.mid, k.mname, k.styp, k.url00, k.ordby, 'M10008', k.qxrole, k.icon from bs_xtmk k where sid='M00008'
    and not exists(select 1 from bs_xtmk t where t.mid=k.mid and t.sid='M10008');

    --招投标前台-qxsz
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed,qxrole)
    select z.mkid,z.mid,z.mname,z.name,z.url,z.inurl,z.isuse,z.orderno,z.styp,z.parent,'M10008',z.fixed,z.qxrole from bs_qxsz z where sid='M00008' 
    and not exists(select 1 from bs_qxsz t where t.mkid=z.mkid and t.mid=z.mid and t.sid='M10008');

    --招投标前台-qxmx
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    select BS_QXMX_0.nextval, x.mkid, x.action, x.method, x.accesstag, x.remark, x.styp, 'M10008' from bs_qxmx x 
    where x.sid='M00008' and not exists(select 1 from bs_qxmx t where t.method=x.method and 
     t.action=x.action and t.mkid=x.mkid and t.sid='M10008');
    ---------------------------------------------------------------------------------------
    --招投标后台-xtmk
    insert into bs_xtmk(mid, mname, styp, ordby, sid)
    select k.mid, k.mname, k.styp, k.ordby, 'B10008' from bs_xtmk k where sid='B00008'
    and not exists(select 1 from bs_xtmk t where t.mid=k.mid and t.sid='B10008');

    --招投标后台-qxsz
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid,fixed,qxrole)
    select z.mkid,z.mid,z.mname,z.name,z.url,z.inurl,z.isuse,z.orderno,z.styp,z.parent,'B10008',z.fixed,z.qxrole from bs_qxsz z where z.sid='B00008' 
    and not exists(select 1 from bs_qxsz t where t.mkid=z.mkid and t.mid=z.mid and t.sid='B10008');

    --招投标后台-qxmx-批量插入SQL
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    select BS_QXMX_0.nextval, x.mkid, x.action, x.method, x.accesstag, x.remark, x.styp, 'B10008' from bs_qxmx x 
    where x.sid='B00008' and not exists(select 1 from bs_qxmx t where t.method=x.method and 
     t.action=x.action and t.mkid=x.mkid and t.sid='B10008');

    -----------------------------------------------------------------------------
    --专家平台-qxmx-批量复制SQL
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    select BS_QXMX_0.nextval, x.mkid, x.action, x.method, x.accesstag, x.remark, x.styp, 'M10009' from bs_qxmx x 
    where x.sid='M00009' and not exists(select 1 from bs_qxmx t where t.method=x.method and 
     t.action=x.action and t.mkid=x.mkid and t.sid='M10009');
     
    ---------add by hejw 2017-08-23  end ---------------------------------------------------------------------------------------------------------------

	---------add by 2018-06-08 zhaoy start------------------------------------------------------
	--屏蔽山能会员权益功能
	update bs_qxsz set isuse = 0 where mid = 'B0145' and sid = 'B10008' and mname = '会员权益管理';
	---------add by 2018-06-08 zhaoy end --------------------------------------------------------
----------------------------------正式环境执行过后删除---------------------------------------------------------------------------
	---停用--交易管理
    --update bs_qxsz set isuse=0 where sid='B10008' and mid='B0125' and mkid in ('B012505','B012510');
	
	
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
