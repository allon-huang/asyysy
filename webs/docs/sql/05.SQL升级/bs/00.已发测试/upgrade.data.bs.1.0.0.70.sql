DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.70'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_xtmk where mid='B0145' and mname='询货采购管理' and sid='B00004';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('B0145','询货采购管理','2',50,'B00004');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where sid='B00004' and mid='B0145'  and mkid='B014505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B014505', 'B0145', '询货采购管理', '询货采购审核', '/exm/querybusiness/audit/list.do', '/exm/querybusiness/audit/list.do', 1, 100, 2, '', 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014505' and action='/exm/querybusiness/audit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014505', '/exm/querybusiness/audit', 'list', 2, '后台-询货采购审核', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014505' and action='/exm/querybusiness/audit' and method='toVerifyPreview';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014505', '/exm/querybusiness/audit', 'toVerifyPreview', 2, '后台-询货采购审核', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014505' and action='/exm/querybusiness/audit' and method='audit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014505', '/exm/querybusiness/audit', 'audit', 2, '后台-询货采购审核', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014505' and action='/exm/querybusiness/audit' and method='reject';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014505', '/exm/querybusiness/audit', 'reject', 2, '后台-询货采购审核', 2, 'B00004');
    END IF;
    
    update bs_qxsz set name='支付申请单打印' where mkid='M010825' and sid='M00201' and mid='M0108';
	
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M017005' and mid='M0170' and styp=1 and sid='M00201';
	if num =1 then
		update bs_qxsz set mname = '售后服务' where mkid='M017005' and mid='M0170' and styp=1 and sid='M00201';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M016505' and mid='M0165' and styp=1 and sid='M00201';
	if num =1 then
		update bs_qxsz set mname = '售后服务' where mkid='M016505' and mid='M0165' and styp=1 and sid='M00201';
	end if;
	
	-- 新增所有商品查询功能权限--
	num:=0;
	select count(1) into num from bs_qxmx where mkid='0' and action='/allthing' and method='index' and sid='M00201';
	if num =0 then
		insert into bs_qxmx q(q.pkid,q.mkid,q.action,q.method,q.accesstag,q.remark,q.styp,q.sid) 
		values(bs_qxmx_0.nextval,'0','/allthing','index',1,'所有商品',1,'M00201');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action = '/exp/hangsource/buy/picksource' and method = 'sourceInfo' and mkid = 'M010505' and sid = 'M00201' and accesstag = 0;
	if num =1 then
		update bs_qxmx set accesstag =1 where action = '/exp/hangsource/buy/picksource' and method = 'sourceInfo' and mkid = 'M010505' and sid = 'M00201';
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01700505' and action='/exp/querybusiness/buy' and method='downLoad';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01700505', '/exp/querybusiness/buy', 'downLoad', 1, '附件查看', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01800505' and action='/exp/querybusiness/process/sell' and method='downLoad';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01800505', '/exp/querybusiness/process/sell', 'downLoad', 1, '附件查看', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014505' and action='/exm/querybusiness/audit' and method='downLoad';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014505', '/exm/querybusiness/audit', 'downLoad', 1, '附件查看', 2, 'B00004');
    END IF;
	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

