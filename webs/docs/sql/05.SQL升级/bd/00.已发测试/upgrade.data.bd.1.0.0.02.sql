DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.02'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BD',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
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
    select count(1) into num from bd_codes where typ='常用代码类别' and code='付款种类';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','付款种类','付款种类', 1, 100, 1);
    end if;
	
   	
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='采购级别';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','采购级别','采购级别', 1, 200, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='采购类型';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','采购类型','采购类型', 1, 300, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='付款方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','付款方式','付款方式', 1, 400, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='执行方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','执行方式','执行方式', 1, 400, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='BD_CONTRACT';
    if num=0 then
        insert into bd_value (gid,key,value,remark,defaultvalue)
        values('RunTime','BD_CONTRACT','1', '合同号生成规则', '1');
    end if;
    
    ---hejw 代理职权---start--------
    num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_000';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval, 'ZB', 'ZB_000', '起草招标公告');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_001';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval, 'ZB', 'ZB_001', '代拟投标邀请书');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_002';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_002', '编制资格预审文件');
    end if;
	
	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_003';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_003', '编制发售招标文件');
    end if;
	
	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_004';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_004', '协助招标人进行组织澄清答疑');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_005';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_005', '协助招标人评审投标资格预审文件');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_006';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_006', '协助招标人或受招标人委托组建评标委员会');
    end if;
	
	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_007';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_007', '协助招标人或受招标人委托组织开标、评标、定标会');
    end if;
	
	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_008';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_008', '向中标人发出中标通知书，向未中标人发出中标结果通知书');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_009';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_009', '编制招标报告');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_010';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_010', '代拟合同');
    end if;

	num:=0;
    select count(1) into num from bd_subproject_zqmx where ZID='ZB' and QXID='ZB_011';
    if num=0 then
        insert into bd_subproject_zqmx (PKID, ZID, QXID, QXNAME) values (bd_subproject_zqmx_0.nextval,  'ZB', 'ZB_011', '办理招标的备案手续和有关事项的公示手续');
    end if;
    ---hejw 代理职权---end--------
    
    --add by chenxp start 开标记录中最高投标限价参数设置--
	num:=0;
  	select count(1) into num from bd_cssz where cskey='MAX_BID_PRICE';
  	if num = 0 then
    	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno) 
	  	values('MAX_BID_PRICE','最高投标限价','1000000000','','系统管理员','最高投标限价','1',3100);
	 end if;  
	
	num:=0;
  	select count(1) into num from bd_cssz where cskey='KB_TBQR_DATE';
  	if num = 0 then
    	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
	 	values('KB_TBQR_DATE','开标后投标方确认开标记录的时间控制参数','5','','系统管理员','开标后投标方确认开标记录的时间控制参数','1','分钟',3200,'开标后投标方确认开标记录的时间控制参数');
	end if;
  
  
	--add by chenxp end--

	-- SQL升级实例-sys_init  
	num:=0;
	select count(1) into num from sys_init where tname='BD_FB_ZBCSSZ';
	if num = 0 then
	insert into sys_init(tname,flag)
	 values('BD_FB_ZBCSSZ',1);
	end if;
	
	num:=0;
    select count(1) into num from sys_init where tname='BD_BIDPACKAGE_TYPE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_BIDPACKAGE_TYPE',0);
    end if;	
	
	--mazg start--
	-- 招标异常 
	num:=0;
	select count(1) into num from sys_init where tname='BD_ZB_YC';
	if num = 0 then
	insert into sys_init(tname,flag)
	 values('BD_ZB_YC',1);
	end if;	
	
	-- 文件订单
	num:=0;
	select count(1) into num from sys_init where tname='BD_TD_DD';
	if num = 0 then
	insert into sys_init(tname,flag)
	 values('BD_TD_DD',1);
	end if;	
	--mazg end--
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JOB_TYPE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JOB_TYPE',0);
    end if;	
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TRADE_TYPE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TRADE_TYPE',0);
    end if;	
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_XTSZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_XTSZ',0);
    end if;	
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT_ZQMX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT_ZQMX',0);
    end if;	
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PROPERTY';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PROPERTY',0);
    end if;	
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PROPERTY_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PROPERTY_MX',0);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CCNOTICE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CCNOTICE',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CC_RECEIPT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CC_RECEIPT',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_DB_HXRGS';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_DB_HXRGS',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_DISSENT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_DISSENT',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_GHXQJSGG';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_GHXQJSGG',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_HTTSTK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_HTTSTK',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_HTYBTK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_HTYBTK',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_PBBZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_PBBZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_PBBZXZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_PBBZXZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_PBBZ_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_PBBZ_MX',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_TBXZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_TBXZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_TBZLB';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_TBZLB',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_TB_FILE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_TB_FILE',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_ZBCSSZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_ZBCSSZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_HGZJTZS';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_HGZJTZS',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_JURY_CENSOR';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_JURY_CENSOR',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_BAK',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_XZ_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_XZ_BAK',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_XZ_MX_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_XZ_MX_BAK',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PSBF';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PSBF',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PSBF_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PSBF_MX',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_NOTICE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_NOTICE',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_OBJECTION';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_OBJECTION',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_OFFER_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_OFFER_MX',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE_YQDW';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE_YQDW',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_SQRXZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SQRXZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_SUBPROJECT_DLZQ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SUBPROJECT_DLZQ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TBYQSBZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TBYQSBZ',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TB_SIGNUP';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TB_SIGNUP',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TD_DD';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TD_DD',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_ZBGG';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_ZBGG',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_ZBSTOPGG';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_ZBSTOPGG',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_ZB_FILE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_ZB_FILE',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_ZB_YC';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_ZB_YC',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CLIENT_TEMPLATE';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CLIENT_TEMPLATE',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CLIENT_TEMPLATE_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CLIENT_TEMPLATE_MX',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB',2);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_XZ';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_XZ',2);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_XZ_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_XZ_MX',2);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CONTRACT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CONTRACT',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CONTRACT_ITEM';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CONTRACT_ITEM',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CONTRACT_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CONTRACT_MX',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_CONTRACT_PAYPLAN';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_CONTRACT_PAYPLAN',1);
    end if;
    
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  