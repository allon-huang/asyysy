DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.5'; -- 本升级文件的版本，每个升级文件必须修改
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
    -- add 商品新增添加高亮路径 by zhangsiwei on 20131228
    num := 0;
	select count(1) into num from bs_qxsz where sid='M00201' and mkid='M011020';
	if num=1 then 
		update bs_qxsz set inurl=inurl||'/exp/hangsource/sell/publish/copy.do#' where sid='M00201' and mkid='M011020';
	end if;
	
	
	num := 0;
	select count(1) into num from bs_qxmx where action='/tdp/common/index' and mkid='0' and method='queryPriceCompareList' and styp=1 and sid='M00004';
	if num= 1 then 
		
		num := 0;
		select count(1) into num from bs_qxmx where action='/tdp/common/ajax' and mkid='0' and method='queryPriceCompareList' and styp=1 and sid='M00004';
		if num= 1 then 
			delete from bs_qxmx where action='/tdp/common/index' and mkid='0' and method='queryPriceCompareList' and styp=1 and sid='M00004';
		else
			update bs_qxmx set action='/tdp/common/ajax' where action='/tdp/common/index' and mkid='0' and method='queryPriceCompareList' and styp=1 and sid='M00004';
		end if;
	end if;
	

	--add 引入外部合同 by  zhuchunhong 20131228
	num := 0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='getExtraContract4Edit' and mkid='M013001' and sid='M00004';
	if num=0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/tdp/trail/pccontract', 'getExtraContract4Edit', 2, '外入外部合同详情', 1, 'M00004');
	end if;
	num := 0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/pccontract' and method='getExtraContractList' and mkid='M013001' and sid='M00004';
	if num=0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/tdp/trail/pccontract', 'getExtraContractList', 2, '外部合同结果', 1, 'M00004');
	end if;
	
	
	-- 定向会员
	num := 0;
	select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/dxhy' and method='list' and styp=1 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023005','/gb/hangsource/sell/dxhy','list',2,'定向会员列表',1,'M00004');
	end if;

	num := 0;
	select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/dxhy' and method='toAdd' and styp=1 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023005','/gb/hangsource/sell/dxhy','toAdd',2,'新增定向会员页面',1,'M00004');
	end if;

	num := 0;
	select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/dxhy' and method='save' and styp=1 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023005','/gb/hangsource/sell/dxhy','save',2,'新增定向会员',1,'M00004');
	end if;

	num := 0;
	select count(1) into num from bs_qxmx where action='/gb/hangsource/sell/dxhy' and method='delete' and styp=1 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M023005','/gb/hangsource/sell/dxhy','delete',2,'删除定向会员',1,'M00004');
	end if;
	
	
	-- add by zhangsiwei on 20131228
    num := 0;
	select count(1) into num from bs_qxsz where name='未上架' and sid='M00201';
	if num=1 then 
		update bs_qxsz set inurl='/exp/hangsource/sell/hangadmin/waitHang.do#/exp/hangsource/sell/hangadmin/doGpAllPreview.do/exp/hangsource/sell/hangadmin/doGpAllPreview.do#'  
		where name='未上架' and sid='M00201';
	end if;
	
	num := 0;
	select count(1) into num from bs_qxmx where action='/tdp/report/fee' and method='listMx' and mkid='M022570' and sid='M00004';
	if num=0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022570', '/tdp/report/fee', 'listMx', 2, '费用统计', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action = '/me/fee/home' and method = 'index' and styp=1  and sid ='M00004';
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/me/fee/home', 'index', 1, '我的平台(集团报表)', 1, 'M00004');
	end if;

		num := 0;
	select count(1) into num from bs_qxmx where METHOD='scpreview' and SID='M00201' and ACTION='/exp/contract/template';
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'scpreview', 1, '合同模版：评分明细', 1, 'M00201');
	end if;

    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  