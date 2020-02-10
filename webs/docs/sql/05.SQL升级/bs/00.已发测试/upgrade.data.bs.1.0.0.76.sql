DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.76'; -- 本升级文件的版本，每个升级文件必须修改
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

	--- 个人会员审核
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/basesetup/pubmsg' and method='view';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/exp/basesetup/pubmsg', 'view', '0','查看公共', '1', 'M00103');
    END IF;
	
	delete from bs_qxsz  where mkid='M011070' and sid='M00103';
	
	update BS_QXSZ set inurl='/exp/productInfo/market/list.do#/exp/productInfo/market/index.do#/exp/productInfo/market/toEdit.do#/exp/productInfo/market/save.do' where MKID='M012005' and MID='M0120' and sid='M00103';

	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='cdlist';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'cdlist', 1, '通过品名+材质获取厂商', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='czlist';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'czlist', 1, '通过品名材质AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='getCdList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'getCdList', 1, '获得产地列表AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='getCzList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'getCzList', 1, '获得材质列表AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='getDlList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'getDlList', 1, '获得品种(大类)列表AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='getPmList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'getPmList', 1, '获得品名列表AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='getUsList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'getUsList', 1, '获得用途列表AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='pmlist';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'pmlist', 1, '通过品种获取品名AJAX', 2, 'B00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/admin/public/item' and method='uslist';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ( '0', '/admin/public/item', 'uslist', 1, '通过品名、材质、厂商获取用途', 2, 'B00103');
    END IF;
	
	update bs_qxsz set isuse=0 where mkid='M011060' and sid='M00103';
	update bs_qxsz set isuse=0 where mkid='M011040' and sid='M00103';
	update bs_qxsz set isuse=0 where mkid='M010535' and sid='M00103';
	
	
	-- 2014/09/29 销售门户head导航		hanglong
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/ext/index/market' and method='headWeb';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/ext/index/market', 'headWeb', '0','销售门户head导航', '1', 'M00103');
    END IF;
	
	-- end 
	update bs_qxmx set accesstag=1 where mkid='0' and action='/' and method='index' and sid='M00211';--网上超市首页

	update bs_qxmx set accesstag=1 where mkid='0' and action='/dingzhi' and method='execute' and sid='M00211';--定制商品列表
	
	update bs_qxmx set accesstag=1 where mkid='0' and action='/tonyong' and method='execute' and sid='M00211';--通用商品列表

	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

