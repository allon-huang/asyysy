DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.2'; -- 本升级文件的版本，每个升级文件必须修改
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
    -- add 商品预览的时候,未上架高亮 by zhangsiwei on 20131226
    num := 0;
    select count(1) into num from bs_qxsz where sid='M00201' and mkid='M011010';
    if num = 1 then
      update bs_qxsz set inurl=inurl||'/exp/hangsource/sell/hangadmin/doGpAllPreview.do' where sid='M00201' and mkid='M011010';
    end if;

  -- 询货买家 bs_xtmk
  num :=0;
      select count(1) into num from bs_xtmk where mid='M0170' and sid='M00004';
      if num=0 then
      insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0170','询货采购',1,200,'M00004','004-1');
  end if;
  -- 询货买家 bs_qxsz
  num :=0;
      select count(0) into num from bs_qxsz where mkid='M017005' and sid='M00004';
      if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M017005','M0170','询货采购','询货采购','/exp/querybusiness/buy/list.do','/exp/querybusiness/buy/list.do',1,200,1,'','M00004');
  end if;
  num :=0;
      select count(0) into num from bs_qxsz where mkid='M017010' and sid='M00004';
      if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M017010','M0170','新建询货单','新建询货单','/exp/querybusiness/buy/toAdd.do','/exp/querybusiness/buy/toAdd.do',1,100,1,'','M00004');
  end if;
  -- 询货买家 bs_qxmx
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='list' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','list',2,'询比价分页列表',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='toEdit' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','toEdit',2,'询比价编辑页面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='toInfo' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','toInfo',2,'询比价详情页面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='save' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','save',2,'询比价新增保存',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='update' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','update',2,'询比价修改保存',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='export2Excel' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','export2Excel',2,'导出询比价单据',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='list' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','list',2,'询比价询价中分页列表',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/completed/buy' and method='list' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/completed/buy','list',2,'询比价完成分页列表',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='dodel' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','dodel',2,'询比价删除',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='release' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','release',2,'询比价发布',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='releases' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/buy','releases',2,'询比价批量发布',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='preview' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','preview',0,'订单填写页面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='saveContract2Tmp' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','saveContract2Tmp',0,'保存购物车数据到合同临时表',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='getorderMx' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','getorderMx',0,'获取订单填写页面的商品明细',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='createbill' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','createbill',0,'生成订单',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='toAddShd' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','toAddShd',0,'跳转新增收货地址界面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='saveShd' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','saveShd',0,'保存新增收货地址界面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='toAdd' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017010','/exp/querybusiness/buy','toAdd',2,'询比价新增页面',1,'M00004');
  end if;


  -- 询货卖家 bs_xtmk
  num :=0;
      select count(1) into num from bs_xtmk where mid='M0180' and sid='M00004';
      if num=0 then
      insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0180','询货销售',1,200,'M00004','004-1');
  end if;
  -- 询货卖家 bs_qxsz
  num :=0;
      select count(0) into num from bs_qxsz where mkid='M018005' and sid='M00004';
      if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M018005','M0180','询货销售','询货销售','/exp/querybusiness/process/sell/list.do','/exp/querybusiness/process/sell/list.do',1,100,1,'','M00004');
  end if;
  num :=0;
      select count(0) into num from bs_qxsz where mkid='M017010' and sid='M00004';
      if num = 0 then
      insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M01800505','M0180','询货管理','询货管理','','',2,100,1,'M018005','M00004');
  end if;
  -- 询货卖家 bs_qxmx
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and method='list' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M018005','/exp/querybusiness/process/sell','list',2,'询货管理分页列表',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and method='resultList' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M018005','/exp/querybusiness/process/sell','resultList',2,'询货管理结果页面',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and method='joinPrice' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M01800505','/exp/querybusiness/process/sell','joinPrice',0,'询货管理参与报价',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and method='savePrice' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M01800505','/exp/querybusiness/process/sell','savePrice',2,'询货管理保存报价',1,'M00004');
  end if;
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/sell' and method='updatePrice' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M01800505','/exp/querybusiness/process/sell','updatePrice',2,'询货管理更新报价',1,'M00004');
  end if;



	-- 团购移到TD平台
	num:=0;
	select count(1) into num from bs_xtmk where mid='M0230' and sid='M00004';
	if num = 0 then
		update bs_xtmk set mid='M0230',sid='M00004',qxrole='004-1' where mid='M0120' and sid='M00201' and mname='团购管理';
		
		update bs_qxsz set mkid='M023005',mid='M0230',sid='M00004' where mkid='M012005' and sid='M00201' and mname='团购管理' and name='我的团购';
		update bs_qxsz set mkid='M023010',mid='M0230',sid='M00004' where mkid='M012010' and sid='M00201' and mname='团购管理' and name='未上架';
		update bs_qxsz set mkid='M023015',mid='M0230',sid='M00004' where mkid='M012015' and sid='M00201' and mname='团购管理' and name='团购中';
		update bs_qxsz set mkid='M023020',mid='M0230',sid='M00004' where mkid='M012020' and sid='M00201' and mname='团购管理' and name='新增';
		
		
		update bs_qxmx set mkid='M023005',sid='M00004' where mkid='M012005' and sid='M00201' and action='/gb/hangsource/sell/hangadmin';
		update bs_qxmx set mkid='M023010',sid='M00004' where mkid='M012010' and sid='M00201' and action='/gb/hangsource/sell/hangadmin';
		update bs_qxmx set mkid='M023015',sid='M00004' where mkid='M012015' and sid='M00201' and action='/gb/hangsource/sell/hangadmin';
		update bs_qxmx set mkid='M023020',sid='M00004' where mkid='M012020' and sid='M00201' and action='/gb/hangsource/sell/publish';
		
		update bs_qxmx set sid='M00004' where sid='M00201' and action='/gb/hangsource/sell/publish' and method='getCategory' and styp=1;
		
		update bs_qxmx set sid='M00004' where sid='M00201' and action='/tuangou';

	end if;


	num :=0;
	select count(1) into num from bs_qxmx where action='/public/item' and method='getPpList' and styp=1 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/public/item','getPpList',1,'获取品牌列表AJAX',1,'M00004');
	end if;


	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and method='checkMbname' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values (bs_qxmx_0.nextval, '0', '/bsp/supplier/reg', 'checkMbname', 0, '供应商注册-验证公司全称是否重复AJAX', 1, 'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and method='checkUsname' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values (bs_qxmx_0.nextval, '0', '/bsp/supplier/reg', 'checkUsname', 0, '供应商注册-验证公司全称(英文)是否重复AJAX', 1, 'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and method='checkLogid' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values (bs_qxmx_0.nextval, '0', '/bsp/supplier/reg', 'checkLogid', 0, '供应商注册-验证用户名是否重复AJAX', 1, 'M00000');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and method='reg' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values (bs_qxmx_0.nextval, '0', '/bsp/supplier/reg', 'reg', 0, '供应商注册-提交注册', 1, 'M00000');
	end if;

	num :=0;
	select count(1) into num from bs_qxmx where action='/bsp/supplier/reg' and method='info' and sid='M00000';
	if num = 0 then
		insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
		values (bs_qxmx_0.nextval, '0', '/bsp/supplier/reg', 'info', 0, '供应商注册-注册页面', 1, 'M00000');
	end if;




    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  