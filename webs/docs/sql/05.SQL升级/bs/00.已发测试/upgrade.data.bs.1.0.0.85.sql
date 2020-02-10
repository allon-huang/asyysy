DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.85'; -- 本升级文件的版本，每个升级文件必须修改
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
	--add by Linqingqing start ---
	--投标邀请书编制邀请单位
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/yqhs' and METHOD ='tobackjson' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M082070','/exp/bidding/buy/yqhs','tobackjson',2,'邀请单位',1,'M00008');
	end if;
	
	--add by linqingqing end ---

	--mazg start--
	--项目建档在招标方案里面的位置调整
	num:=0;
	select count(1) into num from bs_qxsz where mkid = 'M081010' and mid = 'M0810' and sid ='M00008';
	if num=1 then
		update  bs_qxsz set orderno = '100' where mkid = 'M081010' and mid = 'M0810' and sid ='M00008';
		end if;
	--mazg start--
	--jinyanhui start--
	  num:=0;
	  select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/kbqd' and METHOD ='show' and STYP=1 and SID='M00008';
	  if num = 0 then
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
	    values('M093010','/exp/bidding/sell/kbqd','show',2,'开标详情',1,'M00008');
	  end if;
	--end--

	--add by longf start ---
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/pre/jury' and  method='loadMember' and mkid='M089040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M089040', '/bdp/build/pre/jury', 'loadMember', 2, '组建资格预审委员会-AJAX调用评委列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/bdp/build/jury' and  method='loadMember' and mkid='M083040' and  sid='M00008';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M083040', '/bdp/build/jury', 'loadMember', 2, '组建评标委员会-AJAX调用评委列表', 1, 'M00008');
	end if;
	--add by longf end ---

	--mazg start--
	--我的订单
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='toDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','toDd',2,'购买资格预审文件订单页面',1,'M00008');
	end if;
	
	--将我的订单追加到购买资格预审文件的inurl后面（定位）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091020' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/signup/toDd.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/toDd.do') where  mkid='M091020' and sid='M00008' and mid='M0910';
		end if;
		
	--删除订单
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='deleteDd' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M091020','/exp/bidding/sell/signup','deleteDd',2,'删除订单',1,'M00008');
	end if;
	--将删除订单追加到购买资格预审文件的inurl后面（定位）
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M091020' and sid='M00008' and mid='M0910' and instr(inurl,'/exp/bidding/sell/signup/deleteDd.do')>0;
		if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/deleteDd.do') where  mkid='M091020' and sid='M00008' and mid='M0910';
		end if;
	--mazg start--


    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
