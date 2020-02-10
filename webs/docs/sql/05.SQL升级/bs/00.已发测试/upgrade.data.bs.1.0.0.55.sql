DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.55'; -- 本升级文件的版本，每个升级文件必须修改
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
	  num :=0;
	  select count(1) into num from bs_qxsz where name='我的商品' and sid='M00201';
	  if num=1 then
  	 	update bs_Qxsz set inurl='/exp/hangsource/sell/hangadmin/index.do#/exp/hangsource/sell/publish/info.do#' where name='我的商品' and sid='M00201';
	  end if;
	  
	  num :=0;
	  select count(1) into num from bs_qxsz where name='配送跟踪' and sid='M00201';
	  if num=1 then
  	 	update bs_Qxsz set inurl='/exp/entrust/logistics/follow/index.do#/exp/contract/sell/manage/toDhqr.do#' where name='配送跟踪' and sid='M00201';
	  end if;

	  num :=0;
	  select count(1) into num from bs_qxsz where sid = 'M00000' and name = '员工管理' and mname = '基本管理' and url = '/bsp/menber/mbopt/list.do';
	  if num=1 then
  	 	update bs_Qxsz set mname = '基本设置' where sid = 'M00000' and name = '员工管理' and mname = '基本管理' and url = '/bsp/menber/mbopt/list.do';
	  end if;

	  num :=0;
	  select count(1) into num from bs_qxsz where name = '部门管理' and mname = '基本管理' and url = '/bsp/menber/mbdep/list.do' and sid = 'M00000';
	  if num=1 then
  	 	update bs_Qxsz set mname = '基本设置' where name = '部门管理' and mname = '基本管理' and url = '/bsp/menber/mbdep/list.do' and sid = 'M00000';
	  end if;

	  num :=0;
	  select count(1) into num from bs_qxsz where name = '审批流设置' and mname = '基本管理' and url = '/bsp/menber/checkgroup/list.do' and sid = 'M00000';
	  if num=1 then
  	 	update bs_Qxsz set mname = '基本设置' where name = '审批流设置' and mname = '基本管理' and url = '/bsp/menber/checkgroup/list.do' and sid = 'M00000';
	  end if;

	  num :=0;
	  select count(1) into num from bs_qxsz where name = '代理商管理' and mname = '基本管理' and url = '/bsp/menber/wldw/list.do' and sid = 'M00000';
	  if num=1 then
  	 	update bs_Qxsz set mname = '基本设置' where name = '代理商管理' and mname = '基本管理' and url = '/bsp/menber/wldw/list.do' and sid = 'M00000';
	  end if;

	  num :=0;
	  select count(1) into num from bs_qxsz where name = '公司介绍' and mname = '基本管理' and url = '/bsp/menber/manager/intro.do' and sid = 'M00000';
	  if num=1 then
  	 	update bs_Qxsz set mname = '基本设置' where name = '公司介绍' and mname = '基本管理' and url = '/bsp/menber/manager/intro.do' and sid = 'M00000';
	  end if;
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

