DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.52'; -- 本升级文件的版本，每个升级文件必须修改
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
  	 
  	  -- 2014/05/14 hanglong	删除收款管理
	  delete from bs_xtmk t where t.mid='B0200' and t.sid='B00201';
	 
	  -- 2014/05/14 hanglong	设置支付方式权限明细
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='setZflx' and styp=1 and mkid='M01081040' and sid='M00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('M01081040','/exp/contract/buy/manage','setZflx',2,'设置支付方式',1,'M00201');
	  end if;
	  
	  -- 2014/05/14 hanglong	查询用户可用余额权限明细
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/exp/contract/buy/manage' and method='doQueryKyAmt' and styp=1 and mkid='M01081040' and sid='M00201';
	  if num=0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('M01081040','/exp/contract/buy/manage','doQueryKyAmt',2,'查询用户可用余额',1,'M00201');
	  end if;
    
	
	
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and method='list' and styp=1 and mkid='M010010' and sid='M00301';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010010','/bk/subaccount/inout','list',2,'交易账户-资金账户流水列表',1,'M00301');
	  end if;
	
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bk/subaccount/inout' and method='getAccount' and styp=1 and mkid='M010010' and sid='M00301';
	  if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M010010','/bk/subaccount/inout','getAccount',2,'交易账户-资金账户流水列表-查询余额',1,'M00301');
	  end if;
	
	  num :=0;
	  select count(1) into num from bs_qxmx where action='/bk/subaccount/zfmx' and method='list' and styp=1 and mkid='M010020' and sid='M00301';
	  if num=0 then
			insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
			values('M010020','/bk/subaccount/zfmx','list',2,'交易账户-订单付款明细',1,'M00301');
	  end if;
	
	  num :=0;
	  select count(1) into num from bs_xtmk where mid='M0100'  and sid='M00301';
	  if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0100','交易账户',1,'1000','M00301','201-4');
	  end if;
	
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='M010010'  and sid='M00301';
	  if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M010010','M0100','交易账户','资金账户流水','/bk/subaccount/inout/list.do','/bk/subaccount/inout/list.do#',1,'100',1,'M00301');
	  end if;
	
	  num :=0;
	  select count(1) into num from bs_qxsz where mkid='M010020'  and sid='M00301';
	  if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M010020','M0100','交易账户','订单划款明细','/bk/subaccount/zfmx/list.do','/bk/subaccount/zfmx/list.do#',1,'200',1,'M00301');
	  end if;
	  
	  
	

    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

