DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.12'; -- 本升级文件的版本，每个升级文件必须修改
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
    select count(1) into num from bs_xtmk where mid='M0250' and sid='M00004';
    if num=0 then
       insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0250','成交结果','1',350,'M00004','004-1');
    end if;
    select count(1) into num from bs_qxsz where mkid='M025010' and sid='M00004';       
  if num = 0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M025010','M0250','成交结果','销售订单','/exp/tdcontract/sell/manage/list.do','/exp/tdcontract/sell/manage/list.do',1,100,1,'','M00004');
  end if;
  select count(1) into num from bs_qxsz where mkid='M025020' and sid='M00004';       
  if num = 0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
        values('M025020','M0250','成交结果','采购订单','/exp/tdcontract/buy/manage/list.do','/exp/tdcontract/buy/manage/list.do',1,100,1,'','M00004');
  end if;
  num:=0;
    select count(1) into num from bs_qxmx where  mkid='M025010' and sid='M00004' and action='/exp/tdcontract/sell/manage' and method='list';
    if num = 0 then
      insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
      values (bs_qxmx_0.nextval, 'M025010', '/exp/tdcontract/sell/manage', 'list', 2, '成交结果-销售订单', 1, 'M00004');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M025020' and sid='M00004' and action='/exp/tdcontract/buy/manage' and method='list';
    if num = 0 then
      insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
      values (bs_qxmx_0.nextval, 'M025020', '/exp/tdcontract/buy/manage', 'list', 2, '成交结果-采购订单', 1, 'M00004');
    end if;
  
  update bs_qxsz set name='费用明细报表' where  mkid='M022570' and styp=1 and sid='M00004';
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='cannelPbzj' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','cannelPbzj','2','招标管理-项目包管理-撤销专家','1','M00004');
    END IF;
 
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='finishScore' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','finishScore','2','招标管理-项目包管理-完成评分','1','M00004');
    END IF;
  
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M011505' and sid='M00004' and action='/tdp/puc/req' and method='importFile';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M011505','/tdp/puc/req','importFile',2,'加密导出',1,'M00004');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M011505' and sid='M00004' and action='/tdp/puc/req' and method='getBrowseFile';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M011505','/tdp/puc/req','getBrowseFile',2,'加密导出',1,'M00004');
    end if;

num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='export2AesFile' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( 'M013001', '/tdp/trail/pccontract', 'export2AesFile', 2, '导出任务明细', 1, 'M00004');
    END IF;

  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='getBrowseFile' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( 'M013001', '/tdp/trail/pccontract', 'getBrowseFile', 2, '转至导入页面', 1, 'M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='importFile' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( 'M013001', '/tdp/trail/pccontract', 'importFile', 2, '导入excel', 1, 'M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/filedownload' and method='downLoad' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( '0', '/tdp/puc/filedownload', 'downLoad', 1, '下载excel模板', 1, 'M00004');
    END IF;
    
    
    -- 设置团购价格
    num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/hangadmin' and method='toSetPrice' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023005', '/gb/hangsource/sell/hangadmin', 'toSetPrice', 2, '设置团购价格页面', 1, 'M00004');
    END IF;
    
    num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/hangadmin' and method='doSetPrice' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023005', '/gb/hangsource/sell/hangadmin', 'doSetPrice', 2, '设置团购价格', 1, 'M00004');
    END IF;
    
    
    num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/hangadmin' and method='toViewPrice' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023005', '/gb/hangsource/sell/hangadmin', 'toViewPrice', 2, '查看出价明细', 1, 'M00004');
    END IF;
    
    
     num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/buy/price' and method='toConfirm' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023025', '/gb/hangsource/buy/price', 'toConfirm', 2, '确认团购价格页面', 1, 'M00004');
    END IF;
    
    num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/buy/price' and method='agree' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023025', '/gb/hangsource/buy/price', 'agree', 2, '同意团购价格', 1, 'M00004');
    END IF;
    
     num:=0;
  select count(1) into num from bs_qxmx where action='/gb/hangsource/buy/price' and method='reject' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values ( bs_qxmx_0.nextval, 'M023025', '/gb/hangsource/buy/price', 'reject', 2, '拒绝团购价格', 1, 'M00004');
    END IF;
    
    
  update bs_qxsz set inurl='/tdp/puc/req/index.do#/tdp/puc/req/toAdd.do#/tdp/puc/req/toEdit.do#/tdp/puc/req/toSubmit.do#/tdp/puc/req/view.do#/tdp/puc/req/getBrowseFile.do' where mkid='M011505' and styp=1 and sid='M00004';
    --------------------------------------------------------------------
    update bs_qxsz set inurl='/tdp/report/fee/list.do#/tdp/report/fee/listMx.do' where  mkid='M022570' and styp=1 and sid='M00004';
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/zhaobiao' and method='execute' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx ( pkid, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values(bs_qxmx_0.nextval,0,'/zhaobiao','execute',1,'招标首页',1,'M00004');
    END IF;
	
  update bs_qxmx set ACCESSTAG=1 where  action='/tdp/common/index' and method='paclist' and styp='1' and sid='M00004';       
  
  
	update bs_qxmx set ACCESSTAG=1 where  action='/tdp/common/index' and method='paclist' and styp='1' and sid='M00004';       
	
	UPDATE bs_qxsz SET NAME='竞价采购审核' where  sid='B00004' AND MID='B0130' and mkid='B013010'; 
	UPDATE bs_qxsz SET NAME='竞价采购管理' where  sid='B00004' AND MID='B0130' and mkid='B013030'; 



	--合同跟踪联查 add by zhuchunhong 2014-01-04
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/pccontractMx' and method='showGoods' and mkid='M013020' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013020', '/tdp/trail/pccontractMx', 'showGoods', 2, '查看登记流水', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/deliverDtl' and method='getGoodsList' and mkid='M013510' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013510', '/tdp/trail/deliverDtl', 'getGoodsList', 2, '合同跟踪-交货登记-交货明细-已发货量明细', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/sendDtl' and method='getGoodsList' and mkid='M014010' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014010', '/tdp/trail/sendDtl', 'getGoodsList', 2, '合同跟踪-发货登记-发货明细-已到货量明细', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/receiveDtl' and method='getGoodsList' and mkid='M014510' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014510', '/tdp/trail/receiveDtl', 'getGoodsList', 2, '合同跟踪-收货登记-收货明细-已入库量明细', 1, 'M00004');
    END IF;
	
	update bs_qxmx set ACCESSTAG=1 where  action='/xunhuo' and method='execute' and styp='1' and sid='M00004';   
	update bs_qxmx set ACCESSTAG=1 where  action='/jjxiaoshou' and method='execute' and styp='1' and sid='M00004';   
	
	
	-------fyh 2014-1-4
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD='projectTop' and STYP='1' and SID='M00004';     
	if num = 0 then
	 insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'projectTop', 0, '中标公告tab', 1, 'M00004'); 
	end if;
 
 	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD='projectList' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'projectList', 0, '中标公告列表', 1, 'M00004'); 
	end if;
	
	
		num:=0;
	select count(1) into num from bs_qxmx where ACTION='/' and METHOD='projectInfo' and STYP='1' and SID='M00004';     
	if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values ( '0', '/', 'projectInfo', 0, '中标公告详情', 1, 'M00004'); 
	end if;
 
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  