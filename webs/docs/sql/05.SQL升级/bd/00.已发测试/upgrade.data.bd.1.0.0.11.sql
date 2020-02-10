DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.10'; -- 本升级文件的版本，每个升级文件必须修改
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
  

    --------------add by hejw 2017年8月17日 start-----------------
    num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='CFCA-WATER-BACK-OUT';
    if num = 0 then
        insert into bd_value(gid, key, value, remark, csflag)
        values('RunTime', 'CFCA-WATER-BACK-OUT', 'http://192.168.1.105:8080/exp/bidding/lug/fund/callback.do', '资金归集-保证金资金退费-出金申请回调地址', '0');
    end if;
    --------------add by hejw 2017年8月17日 end-----------------

    --------------add by hejw 2017年9月2日 start-----------------
    num:=0;
    select count(1) into num from sys_init where tname='BD_SJDZ';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_SJDZ', 0);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_EXPERT_TEMP';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_EXPERT_TEMP', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_FINALIST';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_FINALIST', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_CZ_TASK_BAK';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_CZ_TASK_BAK', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_DB_HXRGS_EXT';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_DB_HXRGS_EXT', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_HGZJTZS_EXT';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_HGZJTZS_EXT', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_PROJECT_EXT';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_PROJECT_EXT', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_ZBGG_EXT';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_ZBGG_EXT', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_CZ_TASK';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_CZ_TASK', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_CZ_SJDZ';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_CZ_SJDZ', 0);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_COMMON_BANK';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_COMMON_BANK', 1);
    end if;

    num:=0;
    select count(1) into num from sys_init where tname='BD_CFCA_CONF';
    if num = 0 then
        insert into sys_init(tname,flag) values('BD_CFCA_CONF', 0);
    end if;
    --------------add by hejw 2017年9月2日 end-----------------
	--------------add by lijb 2017年9月16日 start--------------
	num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoQueryAbnormalFunds';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoQueryAbnormalFunds','lijb','查询前7天的异常资金流水并发送短信通知',1);
    end if;
	--------------add by lijb 2017年9月16日 end----------------

    --------------add by jinyanhui 2017年9月16日 start-----------------
    num:=0;
    select count(1) into num from bd_value where gid='POST' and key ='MAC';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('POST','MAC','','秘钥','2');
    end if;
    
    num:=0;
    select count(1) into num from bd_value where gid='POST' and key ='BD_ZBGG_POST';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('POST','BD_ZBGG_POST','','招标公告推送地址','2');
    end if;
    
    num:=0;
    select count(1) into num from bd_value where gid='POST' and key ='BD_JGGG_POST';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('POST','BD_JGGG_POST','','中标结果公告推送地址','2');
    end if;
    
    num:=0;
    select count(1) into num from bd_value where gid='POST' and key ='BD_TBYQS_POST';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('POST','BD_TBYQS_POST','','投标邀请书推送地址','2');
    end if; 
    
    num:=0;
    select count(1) into num from bd_value where gid='POST' and key ='BD_CONTRACT_POST';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('POST','BD_CONTRACT_POST','','合同信息推送地址','2');
    end if;        
    
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoBdPostQueue' and runtyp ='1';
    if num = 0 then
        insert into bd_auto_task(taskid,runtyp,servername,remark) values('AutoBdPostQueueTimeScheduler.autoBdPostQueue', 1 ,'jinyanhui','航发接口数据同步定时发送');
    end if; 
	--------------add by jinyanhui 2017年9月16日 end-----------------

	---- 山能框架协议 中标人允许多个调整
	update bd_tb_signup  b set b.iswin=1 where exists (select 1 from bd_package a where a.bdid=b.packid and a.winbiddm=b.hydm);
	
	
	--------------add by hejw 2017年11月06日 start-----------------
    num:=0;
    select count(1) into num from bd_value where gid='CHARGES_CONFIG' and key ='CHARGES_POST_ADDRESS';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('CHARGES_CONFIG','CHARGES_POST_ADDRESS','','计费平台访问地址','2');
    end if; 
    
    num:=0;
    select count(1) into num from bd_value where gid='CHARGES_CONFIG' and key ='CHARGES_POST_APPID';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,csflag) values('CHARGES_CONFIG','CHARGES_POST_APPID','','计费平台-服务分配编号','2');
    end if; 
	--------------add by hejw 2017年11月06日 end-----------------

	--------------add by lijb 2017年9月16日 start--------------
	num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F04' and CONTENTID='F040101';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (14, '1', '0', '50万以下', 101, null, null, '基础服务', 'F04', '不限次数投标', 'F040101', '1', 'S00000', null, null, '&#xe938;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F04' and CONTENTID='F040102';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (15, '2', '0', null, 102, null, null, '基础服务', 'F04', '项目信息查询', 'F040102', '1', 'S00000', null, null, '&#xe934;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F04' and CONTENTID='F040103';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (16, '2', '0', null, 103, null, null, '基础服务', 'F04', '全流程在线招投标业务', 'F040103', '1', 'S00000', null, null, '&#xe92e;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F04' and CONTENTID='F040104';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (17, '1', '0', null, 104, null, null, '基础服务', 'F04', '赠送CA数字证书', 'F040104', '1', 'S00000', null, null, '&#xe92f;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F05' and CONTENTID='F050101';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (1, '1', '0', null, 201, null, null, '通知提醒', 'F05', '站内消息提醒', 'F050101', '1', 'S00000', null, null, '&#xe937;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F05' and CONTENTID='F050102';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (2, '1', '0', null, 202, null, null, '通知提醒', 'F05', '全流程短信提醒', 'F050102', '1', 'S00000', null, null, '&#xe939;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F06' and CONTENTID='F060101';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (3, '2', '0', null, 301, null, null, '知识技能', 'F06', '热线服务', 'F060101', '1', 'S00000', null, null, '&#xe930;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F06' and CONTENTID='F060102';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (4, '2', '0', null, 302, null, null, '知识技能', 'F06', '法律法规库', 'F060102', '1', 'S00000', null, null, '&#xe932;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F06' and CONTENTID='F060103';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (5, '2', '0', null, 305, null, null, '知识技能', 'F06', '投标人高级培训课程', 'F060103', '2', 'S00000', null, '人次', '&#xe933;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F06' and CONTENTID='F060104';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (6, '2', '0', null, 303, null, null, '知识技能', 'F06', '操作手册', 'F060104', '1', 'S00000', null, null, '&#xe936;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F06' and CONTENTID='F060105';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (7, '2', '0', null, 304, null, null, '知识技能', 'F06', '视频教学课程', 'F060105', '1', 'S00000', null, null, '&#xe931;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F07' and CONTENTID='F070101';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (8, '2', '0', null, 401, null, null, '高级特权', 'F07', '加入专属微信沟通群', 'F070101', '1', 'S00000', null, null, '&#xe93a;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F07' and CONTENTID='F070102';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (9, '2', '0', null, 402, null, null, '高级特权', 'F07', '5*8小时及时响应问题', 'F070102', '1', 'S00000', null, null, '&#xe950;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F07' and CONTENTID='F070103';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (10, '2', '0', null, 403, null, null, '高级特权', 'F07', '远程协助操作指导', 'F070103', '2', 'S00000', null, '次', '&#xe935;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F07' and CONTENTID='F070104';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (11, '2', '0', null, 404, null, null, '高级特权', 'F07', '投标法律咨询', 'F070104', '2', 'S00000', null, '次', '&#xe94f;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F07' and CONTENTID='F070105';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (12, '2', '0', null, 405, null, null, '高级特权', 'F07', '专属客户经理', 'F070105', '1', 'S00000', null, null, '&#xe94e;');
    end if;
    
    num:=0;
    select count(1) into num from BD_BILLING_DETAILS where CATEGORYID='F08' and CONTENTID='F080101';
    if num = 0 then
        insert into BD_BILLING_DETAILS (PKID, TYP, WORTH, REMARKS, CODEORDER, CDATE, COPT, CATEGORY, CATEGORYID, CONTENT, CONTENTID, CONTENTTYPE, SYSCODE, WORTHL, WORTHR, ICOFILE)
		values (13, '2', '0', null, 501, null, null, '营销服务', 'F08', '首页广告位展示', 'F080101', '2', 'S00000', null, '周', null);
    end if;
	--------------add by lijb 2017年9月16日 end----------------
	--------------add by lijb 2017年11月17日 start--------------
	num:=0;
    select count(1) into num from BD_SCHEME_BUSINESS where BUSINESSID='XM00001';
    if num = 0 then
        insert into BD_SCHEME_BUSINESS (PKID, SCHEMEID, SCHEMENAME, BUSINESSID, BUSINESSNAME)
		values (1, null, null, 'XM00001', '招投标平台会员收费项目');
    end if;
	--------------add by lijb 2017年11月17日 end----------------

-------2017-11-20 hejw start --------
    num:=0;
    select count(1) into num from bd_cssz where cskey='BD_TBXJ_FLAG';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('BD_TBXJ_FLAG','平台收费投标限价','1', '0','系统管理员','若启用，将控制普通投标会员报价金额',1, 7700,'1-启用 0-禁用');
    end if;
  
    num:=0;
    select count(1) into num from bd_cssz_ext where typ='BD_TBXJ_FLAG';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('BD_TBXJ_FLAG', '0', '禁用');
    insert into bd_cssz_ext (typ, cskey, csvalue) values('BD_TBXJ_FLAG', '1', '启用');
    end if;
-------2017-11-20 hejw end --------

	--------------add by nieche 2017年11月23日 start--------------
	num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoQueryLeaderboards';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoQueryLeaderboards','nieche','自动查询首页排行信息并生成静态页面-前台',1);
    end if;
	--------------add by nieche 2017年11月23日 end----------------
  --------------add by zhaoy 2017年12月1日 start--------------
	num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY001';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10001','HY001','能源电力');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY002';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10002','HY002','石油石化');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY003';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10003','HY003','水利水电');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY004';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10004','HY004','生态环保');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY005';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10005','HY005','矿产冶金');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY006';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10006','HY006','港口航道');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY007';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10007','HY007','农林牧渔');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY008';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10008','HY008','公路');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY009';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10009','HY009','铁路');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY010';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10010','HY010','水运');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY011';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10011','HY011','民航');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY012';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10012','HY012','市政');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY013';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10013','HY013','商业服务');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY014';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10014','HY014','保险金融');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY015';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10015','HY015','房屋建筑');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY016';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10016','HY016','园林绿化');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY017';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10017','HY017','化学工业');
    end if;
    
      num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY018';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10018','HY018','科教文卫');
    end if;
    
      num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY019';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10019','HY019','广电通信');
    end if;
    
      num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY020';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10020','HY020','航空航天');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY021';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10021','HY021','地球科学');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY022';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10022','HY022','设备机械');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY023';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10023','HY023','纺织轻工');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY024';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10024','HY024','信息电子');
    end if;
    
    num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY025';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10025','HY025','生物医药');
    end if;
    
     num:=0;
    select count(1) into num from bd_bidpackage_hyfl where hyfldm='HY026';
    if num = 0 then
        insert into bd_bidpackage_hyfl(pkid,hyfldm, hyflmc)
        values('10026','HY026','其他');
    end if;
	--------------add by zhaoy 2017年12月1日 end----------------

    ------------add by hejw 2017-12-07 start---------
    num:=0;
    select count(1) into num from bd_value where gid='DATABASE_USER_NAME' and key='BS';
    if num = 0 then
        insert into bd_value(gid, key, value, remark, defaultvalue, csflag)
        values('DATABASE_USER_NAME', 'BS', 'zbbsdb', '数据库用户名-不要出现空格', 'bsdb', '0');
    end if;
    ------------add by hejw 2017-12-07 end---------

	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
