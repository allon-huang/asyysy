DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.14'; -- 本升级文件的版本，每个升级文件必须修改
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
    update bs_qxmx set accesstag = 0 where method = 'doShowSource' and mkid = 'B013020' and sid = 'B00004';
    num:=0;
    select count(1) into num from bs_qxmx where action='/exm/tender/bout/verify' and method='remove' and styp=2 and sid='B00004';
    if num = 0 then
      insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B013010', '/exm/tender/bout/verify', 'remove', 2, '竞标申请审核：删除被拒绝竞标', 2, 'B00004');
	end if;
	
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='downLoadModel' and mkid='M01300120' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300120', '/tdp/trail/pccontract', 'downLoadModel', 2, '下载合同模板', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='tenderChooseAppointMember' and mkid='M017010' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'tenderChooseAppointMember', 2, '询比价定向会员', 1, 'M00004');
    END IF;
    
        num:=0;
	select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='showAppointMemberList' and mkid='M017010' and sid='M00004';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'showAppointMemberList', 2, '询比价定向会员', 1, 'M00004');
    END IF;

    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='delete' and mkid='M017010' and sid='M00004';       
    if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'delete', 2, '询比价定向会员：删除', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='getMemberList' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'getMemberList', 2, '询比价定向会员:列表', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='toAddQuery' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'toAddQuery', 2, '询比价定向会员:新增', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='saveQuery' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'saveQuery', 2, '询比价定向会员:保存', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='toUpdate' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'toUpdate', 2, '询比价定向会员:编辑', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='batchEnable' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'batchEnable', 2, '询比价定向会员:批量启用', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='batchDisable' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'batchDisable', 2, '询比价定向会员:批量禁用', 1, 'M00004');
    END IF;
    
        num:=0;
  select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='batchDelete' and mkid='M017010' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017010', '/exp/querybusiness/buy', 'batchDelete', 2, '询比价定向会员:批量删除', 1, 'M00004');
    END IF;
    
     num:=0;
  select count(1) into num from bs_qxmx where action='/exp/auction/buy/bidding' and method='getContractMxStatByGpls' and sid='M00004';       
  if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/exp/auction/buy/bidding', 'getContractMxStatByGpls', 0, 'AJAX资源详情页面成交历史统计', 1, 'M00004');
    END IF;
    
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='9';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','9','生产商',1,'100',0,1);
    END IF;
	
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='10';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','10','代理商',1,'100',0,1);
    END IF;
	
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='11';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','11','物流商',1,'100',0,1);
    END IF;
    

    num:=0;
    select count(1) into num from bs_qxsz where url='/tdp/trail/pccontract/list.do' and mkid='M013001' and sid='M00004' and mid='M0130';       
    if num = 1 then 
    update bs_qxsz set inurl='/tdp/trail/pccontract/list.do#/tdp/trail/pccontract/showInfo.do#/tdp/trail/pccontract/toAdd.do#/tdp/trail/pccontract/getExtraContractList.do#/tdp/trail/pccontract/getBrowseFile.do' 
    where url='/tdp/trail/pccontract/list.do' and mkid='M013001' and sid='M00004' and mid='M0130';  
    END IF;

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M022575' and mid='M0225' and sid='M00004';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M022575', 'M0225', '集团报表', '执行情况报表', '/tdp/report/perfrom/list.do', '/tdp/report/perfrom/list.do', 1, 1100, 1, '', 'M00004');
    END IF;
    
     num:=0;
     select count(1) into num from bs_qxmx where mkid='M022575' and action='/tdp/report/perfrom' and method='list' and sid='M00004';       
     if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022575', '/tdp/report/perfrom', 'list', 2, '集团报表-执行情况报表', 1, 'M00004');
     END IF;
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  