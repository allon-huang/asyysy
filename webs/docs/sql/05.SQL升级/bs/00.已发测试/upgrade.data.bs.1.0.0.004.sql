DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.4'; -- 本升级文件的版本，每个升级文件必须修改
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
    	num := 0;
	select count(1) into num from bs_qxmx where METHOD='scpreview' and SID='M00201' and ACTION='/exp/contract/template';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'scpreview', 1, '合同模版：评分明细', 1, 'M00201');
	end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where action='/swfupload' and method='fileUpload' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/swfupload','fileUpload',1,'文件上传',1,'M00004');
	end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/swfupload' and method='upload' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/swfupload','upload',1,'文件上传',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/swfupload' and method='uploadKindEditor' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/swfupload','uploadKindEditor',1,'编辑器图片上传',1,'M00004');
	end if;
    
    update bs_codes set code='1' where typ='供应商企业类型' and value='生产商';
	update bs_codes set code='2' where typ='供应商企业类型' and value='代理商';
	update bs_codes set code='3' where typ='供应商企业类型' and value='物流商';
    
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/public/item' and method='getWzdmList' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/public/item','getWzdmList',1,'获取物资编码AJAX',1,'M00004');
	end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M022010' and mid='M0220' and styp=1 and sid='M00004';
	if num =0 then
		insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M022010','M0220','费用管理','费用明细','/tdp/fee/query/list.do','/tdp/fee/query/list.do',1,200,1,'','M00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/fee/query' and method='list' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M022010','/tdp/fee/query','list',2,'费用明细列表',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M022570' and mid='M0225' and styp=1 and sid='M00004';
	if num =0 then
		insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M022570','M0225','集团报表','费用明细查询','/tdp/report/fee/list.do','/tdp/report/fee/list.do',1,1000,1,'','M00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/report/fee' and method='list' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M022570','/tdp/report/fee','list',2,'费用明细列表',1,'M00004');
	end if;

    -------------------------------------------------------------
	-- add 增加买方取消合同权限 by zhangsiwei 20131227
	num := 0;
	select count(1) into num from bs_qxsz where mkid='M01081020' and mid='M0108' and sid='M00201';
	if num = 0 then
	   insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,parent,sid) 
       values('M01081020','M0108','采购订单','取消订单',2,330,1,'M010810','M00201');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='toRefuse' and styp=1 and sid='M00201';
    if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		  values('M01081020','/exp/contract/buy/manage','toRefuse',1,'进入合同取消页面',1,'M00201');
	end if;
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='refuse' and styp=1 and sid='M00201';
    if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		  values('M01081020','/exp/contract/buy/manage','refuse',1,'合同取消页面',1,'M00201');
	end if;
    -- dl 2013-12-27 询比价
        num:=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='getCountQueryInfo' and styp=1 and sid='M00004';
      if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','getCountQueryInfo',0,'询货采购AJAX获取结果统计',1,'M00004');
    end if;
    num:=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='getLowerPrice' and styp=1 and sid='M00004';
      if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','getLowerPrice',0,'询货采购AJAX获取最低报价',1,'M00004');
    end if;
     num:=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='getResponseNumber' and styp=1 and sid='M00004';
      if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','getResponseNumber',0,'询货采购AJAX获取相应人数',1,'M00004');
    end if;
     num:=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='list' and styp=1 and sid='M00004';
      if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','list',0,'询货采购',1,'M00004');
    end if; 

     num:=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='toBsMenber' and styp=1 and sid='M00004';
      if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'0','/exp/querybusiness/common','toBsMenber',0,'转到选择会员',1,'M00004');
    end if; 
    
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/puc/plan/approve' and method='batchAudit' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M012010','/tdp/puc/plan/approve','batchAudit',2,'批量审核',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/puc/mission/approve' and method='batchAudit' and styp=1 and sid='M00004';
    if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M012510','/tdp/puc/mission/approve','batchAudit',2,'批量审核',1,'M00004');
	end if;
	
	update bs_system set sname='采购平台', shortname='采购' where sid='B00004' or sid='M00004';
	
	
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M023025' and sid='M00004';
    if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		values('M023025','M0230','团购管理','团购历史','/gb/hangsource/buy/price/list.do',1,50,1,'M00004');
	end if;

	num:=0;
    select count(1) into num from bs_qxmx where action='/gb/hangsource/buy/price' and method='list' and styp=1 and sid='M00004';
    if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023025','/gb/hangsource/buy/price','list',2,'团购历史',1,'M00004');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where action='/gb/hangsource/buy/price' and method='view' and styp=1 and sid='M00004';
    if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023025','/gb/hangsource/buy/price','view',2,'团购详情',1,'M00004');
	end if;
	
		num:=0;
 	select count(1) into num from bs_qxmx where action='/' and method='allAnnouncement' and styp=1 and sid='M00004';
 	if num = 0 then
 		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/', 'allAnnouncement', 0, '全部公告', 1, 'M00004');
 	end if;
	
		num:=0;
 	select count(1) into num from bs_qxmx where action='/bid/bulletin' and method='zbggTop' and styp=1 and sid='M00004';
 	if num = 0 then
 		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/bid/bulletin', 'zbggTop', 0, '招标公告', 1, 'M00004');
 	end if;
		num:=0;
		
		
 	select count(1) into num from bs_qxmx where action='/' and method='jjggTop' and styp=1 and sid='M00004';
 	if num = 0 then
 		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/', 'jjggTop', 0, '竞价公告', 1, 'M00004');
 	end if;
		num:=0;
		
		
 	select count(1) into num from bs_qxmx where action='/' and method='supplierList' and styp=1 and sid='M00004';
 	if num = 0 then
 		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/', 'supplierList', 0, '供应商列表', 1, 'M00004');
 	end if;
	
select count(1) into num from bs_qxmx where action='/exp/querybusiness/common' and method='xjggTop' and styp=1 and sid='M00004';
 	if num = 0 then
 		insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M017005', '/exp/querybusiness/common', 'xjggTop', 0, '询价公告', 1, 'M00004');
 	end if;
	
	
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  