DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.77'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	
	update bs_xtmk set qxrole='103-1' where sid='M00103' and mid in('M0120');
	update bs_xtmk set qxrole='103-2' where sid='M00103' and mid in('M0115','M0110','M0105');
	update bs_xtmk set qxrole='103-3' where sid='M00103' and mid in('M0135','M0140','M0145','M0130','M0155','M0320');
	
	update bs_qxmx set accesstag=0 where mkid='0' and action='/' and method='index' and sid='M00211';--网上超市首页

	update bs_qxmx set accesstag=0 where mkid='0' and action='/dingzhi' and method='execute' and sid='M00211';--定制商品列表
	
	update bs_qxmx set accesstag=0 where mkid='0' and action='/tonyong' and method='execute' and sid='M00211';--通用商品列表
	
	update bs_qxsz set inurl='/exp/auction/buy/bout/list.do#/exp/auction/buy/result/list.do#/exp/auction/buy/bout/toJoin.do' where sid='M00103' and mkid='M012520';
	
	num:=0;
	select count(1) into num from  bs_cssz where cskey='WXKEY';      
	if num = 0 then 
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno)
		values('WXKEY','微信KEY密钥','GOLDEN','GOLDEN','系统管理员','KEY密钥','1','1200');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_cssz where cskey='WXHYDM';      
	if num = 0 then 
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno)
		values('WXHYDM','微信超级管理员编号','000000','000000','系统管理员','微信超级管理员编号','1','1300');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_cssz where cskey='WXPATH';      
	if num = 0 then 
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno)
		values('WXPATH','微信访问域名地址','http://zbwx.yunshang.org.cn/index.php','http://zbwx.yunshang.org.cn/index.php','系统管理员','微信访问域名地址','1','1400');
	END IF;
	
	num :=0;
	select count(1) into num from bs_cssz where cskey='MB_END_MONTH';
	if num =0 then
		insert into bs_cssz(cskey, csmc, csvalue, mrz, opt, remark, flag0,unit,orderno)
		values('MB_END_MONTH','会员有效期','12','','系统管理员','会员多少个月有效',1,'月',1100);
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/hangsource/buy/picksource' and method='getBoutList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/exp/hangsource/buy/picksource','getBoutList',0,'竞价销售首页',1,'M00103');
    END IF;
	
	update bs_xtmk set ordby=50 where mid='M0120' and  sid='M00103';
	
	-- 2014-10-10 lvcy
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/product/market' and method='tree';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		values ('0','/exp/product/market','tree','1','产品类别树','1','M00103');
	END IF;
	
	update bs_qxsz set mname = '合同收款' where  mname = '合同支付' and sid = 'M00103' and mid = 'M0155';
	
	-- 2014-10-11 lvcy

	update bs_xtmk set qxrole = '103-4' where  sid = 'M00103' and mname = '客户管理' and mid = 'M0320';
	
	
     num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/exm/productInfo/manage' and method='list';      
	if num = 0 then 
		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values ( 'B014060', '/exm/productInfo/manage', 'list', 2, '产品管理', 2, 'B00103');
	END IF;
	
	  num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/exm/productInfo/manage' and method='export';      
	if num = 0 then 
		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values ( 'B014060', '/exm/productInfo/manage', 'export', 2, '产品导出', 2, 'B00103');
	END IF;
	
	
     num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/exm/productInfo/manage' and method='toImport';      
	if num = 0 then 
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values ( 'B014060', '/exm/productInfo/manage', 'toImport', 2, '产品导入页面', 2, 'B00103');
	END IF;
	
	  num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/exm/productInfo/manage' and method='doImport';      
	if num = 0 then 
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values ('B014060', '/exm/productInfo/manage', 'doImport', 2, '产品导入', 2, 'B00103');
	END IF;
	
		  num:=0;
	select count(1) into num from  bs_qxmx where sid='B00103'  and action='/exm/productInfo/manage' and method='downLoadWeb';      
	if num = 0 then 
		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values ('B014060', '/exm/productInfo/manage', 'downLoadWeb', 2, '产品导入模版下载', 2, 'B00103');
	END IF;
	
	num:=0;
	select count(1) into num from  BS_QXsz where sid='B00103'  and MKID='B014060' ;      
	if num = 0 then 
	insert into BS_QXsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
values ('B014060', 'B0140', '基础设置', '产品管理', '/exm/productInfo/manage/list.do', '/exm/productInfo/manage/list.do#/exm/productInfo/manage/export.do#/exm/productInfo/manage/list.do#/exm/productInfo/manage/toImport.do#/exm/productInfo/manage/doImpor.do', 1, 1000, 2, '', 'B00103');
	END IF;
	
	update bs_xtmk set mname=REGEXP_REPLACE(mname,'货', '价') where sid='B00004' and styp='2' and mname like '%询货%';
	update bs_xtmk set mname=REGEXP_REPLACE(mname,'货', '价') where sid='M00004' and styp='1' and mname like '%询货%';
	update bs_qxsz set mname=REGEXP_REPLACE(mname,'货', '价') where sid='B00004' and styp='2' and mname like '%询货%';
	update bs_qxsz set mname=REGEXP_REPLACE(mname,'货', '价') where sid='M00004' and styp='1' and mname like '%询货%';
	update bs_qxsz set name=REGEXP_REPLACE(name,'货', '价') where sid='B00004' and styp='2' and name like '%询货%';
	update bs_qxsz set name=REGEXP_REPLACE(name,'货', '价') where sid='M00004' and styp='1' and name like '%询货%';
	update bs_qxmx set remark=REGEXP_REPLACE(remark,'货', '价') where sid='M00004' and styp='1' and remark like '%询货%';
	update bs_qxmx set remark=REGEXP_REPLACE(remark,'货', '价') where sid='B00004' and styp='2' and remark like '%询货%';
    
    -- 2014/10/13 采购供应商管理和制造商管理权限修改	hanglong
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00004' and mid='M0320';
	if num = 1 then
		update bs_xtmk set qxrole='005' where sid='M00004' and mid='M0320';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00004' and mid='M0330';
	if num = 1 then
		update bs_xtmk set qxrole='005' where sid='M00004' and mid='M0330';
	end if;
	
	
	-- 2014-10-13 首页 交易公告 lvcy
	num:=0;
	select count(1) into num from bs_qxmx where action = '/exp/hangsource/buy/picksource' and method = 'getJyggList' and sid = 'M00103';
	if num = 1 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
        values ('0','/exp/hangsource/buy/picksource','getJyggList','0','首页-交易公告','1','M00103');
    end if;
    
    
	-- end
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

