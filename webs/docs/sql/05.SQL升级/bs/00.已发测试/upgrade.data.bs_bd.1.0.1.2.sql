DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.1.2'; -- 本升级文件的版本，每个升级文件必须修改
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

	--cheny-- 2016-10-13 -- 交易管理 - start--------------------------------
    num:=0;
       select count(1) into num from bs_xtmk where sid = 'B00008' and mid = 'B0125';
    if num = 0 then
       insert into bs_xtmk (mid, mname, styp, ordby, sid) values('B0125', '交易管理', '2', '350', 'B00008');
    end if;
    
    num:=0;
        select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0125' and mkid = 'B012505' and url = '/bdm/transaction/listSubMx.do';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
             values('B012505', 'B0125', '交易管理', '招标项目明细', '/bdm/transaction/listSubMx.do', '/bdm/transaction/listSubMx.do#', '1', '100', '2', null, 'B00008');
    end if;
    
    num:=0;
        select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0125' and mkid = 'B01250505';
    if num = 0 then
        insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
           values('B01250505', 'B0125', '招标项目明细', '编辑', '', '', '2', '100', '2', 'B012505', 'B00008');
    end if;
    
    num:=0;
        select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0125' and mkid = 'B012510' and url = '/bdm/transaction/listPacMx.do';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
             values('B012510', 'B0125', '交易管理', '标段（包）明细', '/bdm/transaction/listPacMx.do', '/bdm/transaction/listPacMx.do#', '1', '100', '2', null, 'B00008');
    end if;
    
    num:=0;
       select count(1) into num from bs_qxsz where sid = 'B00008' and mid = 'B0125' and mkid = 'B01251005';
    if num = 0 then
       insert into bs_qxsz (mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid)
           values('B01251005', 'B0125', '标段（包）明细', '编辑', '', '', '2', '100', '2', 'B012510', 'B00008');
    end if;
    
    num:=0;
     	select count(1) into num from bs_qxmx where mkid = 'B01251005' and sid = 'B00008' and action = '/bdm/transaction' and method = 'showBidder';
    if num = 0 then
    	insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
      		values('B01251005', '/bdm/transaction', 'showBidder', '2', '标段（包）明细-投标人详情', '2' , 'B00008');
    end if;
    
    num:=0;
     	select count(1) into num from bs_qxmx where mkid = 'B01251005' and sid = 'B00008' and action = '/bdm/transaction' and method = 'export';
  	if num = 0 then
    	insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
      	values('B01251005', '/bdm/transaction', 'export', '2', '标段（包）明细-导出', '2' , 'B00008');
  	end if;
  
	num:=0;
		select count(1) into num from bs_qxmx where mkid = 'B01251005' and sid = 'B00008' and action = '/bdm/transaction' and method = 'listPacMx';
	if num = 0 then
		insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
			values('B01251005', '/bdm/transaction', 'listPacMx', '2', '标段（包）明细-列表', '2' , 'B00008');
	end if;
    
    	num:=0;
		select count(1) into num from bs_qxmx where mkid = 'B01251005' and sid = 'B00008' and action = '/bdm/transaction' and method = 'listSubMx';
	if num = 0 then
		insert into bs_qxmx ( mkid, action, method, accesstag, remark, styp, sid)
			values('B01251005', '/bdm/transaction', 'listSubMx', '2', '招标项目明细-列表', '2' , 'B00008');
	end if;
    --cheny-- 2016-10-13 -- 交易管理 - end----------------------------------

	--add by chenxp start 签章管理--
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/signature' and method='contractSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030040','/exp/bidding/buy/signature','contractSeal','2','合同签订签章','1','M00008');
    end if;
    
    --投标人合同签章
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='contractSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','contractSeal','2','合同签订签章','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signature' and method='contractList' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M020020','/exp/bidding/sell/signature','contractList','2','合同签订列表','1','M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signature/contractList.do') into num from bs_qxsz where sid = 'M00008' and mkid='M020020';
    if num = 0 then
        update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signature/contractList.do') where  sid = 'M00008' and mkid='M020020';
    end if;
	--add by chenxp end   --



    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
