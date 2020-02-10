drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	-- ==================================================================================
    -- mysql升级版本
	-- ==================================================================================
	

    -- ---2018-07-26 hejw start-------------
    set @num=0;
    select count(0) into @num from BD_STEPURL where step='D0710' AND STEP0='D0710';
    if @num = 0 then
        INSERT INTO `BD_STEPURL`(`STEP`, `STEP0`, `TYP`, `URL`, `STR03`, `STR04`)
        VALUES ('D0710', 'D0710', '1', '/exp/bidding/buy/scaling/listjg.do', 'probid', 'bdid');
    end if;

    set @num=0;
    select count(0) into @num from BD_STEPURL where step='D0705' AND STEP0='D0705';
    if @num = 0 then
        INSERT INTO `BD_STEPURL`(`STEP`, `STEP0`, `TYP`, `URL`, `STR03`, `STR04`)
        VALUES ('D0705', 'D0705', '1', '/exp/bidding/buy/scaling/listgg.do', 'probid', 'bdid');
    end if;
    
    set @num=0;
    select count(0) into @num from BD_STEPURL where step='Z0710' AND STEP0='Z0710';
    if @num = 0 then
        INSERT INTO `BD_STEPURL`(`STEP`, `STEP0`, `TYP`, `URL`, `STR03`, `STR04`)
        VALUES ('Z0710', 'Z0710', '1', '/exp/bidding/buy/scaling/listjg.do', 'probid', 'bdid');
    end if;

    set @num=0;
    select count(0) into @num from BD_STEPURL where step='Z0705' AND STEP0='Z0705';
    if @num = 0 then
        INSERT INTO `BD_STEPURL`(`STEP`, `STEP0`, `TYP`, `URL`, `STR03`, `STR04`)
        VALUES ('Z0705', 'Z0705', '1', '/exp/bidding/buy/scaling/listgg.do', 'probid', 'bdid');
    end if;
    -- ---2018-07-26 hejw end-----------------------
    -- --自增长
	set @num=0;
    select count(0) into @num from BD_VALUE where gid='RunTime' and key1='BD_CEBPUBSERVICE';
    if @num = 0 then
        INSERT INTO `BD_VALUE`(`GID`, `KEY1`, `VALUE`, `REMARK`, `DEFAULTVALUE`, `CSFLAG`)
        VALUES ('RunTime', 'BD_CEBPUBSERVICE','0','68e50413db5d41b48848w3ww46e345997','0','2');
    end if;
    
    -- --20180820 批量初始化sql start-----------------------------
	-- update BD_JURY_SIGN s set s.typ='4' where s.date00<'2018-08-23 23:35:10' and
	-- exists(select 1 from BD_JURY_MEMBER m where s.wyhdm=m.wyhdm and s.xh=m.xh and m.typ='4' ) ;
	-- update BD_JURY_SIGN s set s.typ='1' where s.typ <> '4' and s.date00<'2018-08-23 23:35:10' and
	-- exists(select 1 from BD_JURY_MEMBER m where s.wyhdm=m.wyhdm and s.xh=m.xh and m.typ <> '4' ) ;
    -- --20180820 批量sql end-----------------------------

    -- --20180821 增加调用短信微服务地址   start-----------------------------
	set @num=0;
    select count(0) into @num from BD_VALUE where gid='UTIL_CONFIG' and key1='SMS_ADDRESS_URL';
    if @num = 0 then
        INSERT INTO `BD_VALUE`(`GID`, `KEY1`, `VALUE`, `REMARK`, `DEFAULTVALUE`, `CSFLAG`)
        VALUES ('UTIL_CONFIG', 'SMS_ADDRESS_URL','http://172.19.140.65:9012/v1','短信微服务请求地址','0','2');
    end if;
    
	set @num=0;
    select count(0) into @num from BD_VALUE where gid='UTIL_CONFIG' and key1='SMS_LOG';
    if @num = 0 then
        INSERT INTO `BD_VALUE`(`GID`, `KEY1`, `VALUE`, `REMARK`, `DEFAULTVALUE`, `CSFLAG`)
        VALUES ('UTIL_CONFIG', 'SMS_LOG','1','短信微服务日志0-关闭日志 1-开启日志','0','2');
    end if;
    -- --20180821 增加调用短信微服务地址   end-----------------------------

	-- --wyd 2018年12月24日11:05:18 修改流程节点对应的url   start-----------------------------
	set @num=0;
    select count(1) into @num from BD_STEPURL where  STEP='Z0703' and STEP0 = 'Z0703';
    if @num = 1 then
         update BD_STEPURL set URL='/exp/bidding/buy/scaling/confirmList.do' where URL='/exp/bidding/buy/scaling/listjg.do' and STEP='Z0703' and STEP0 = 'Z0703';
    end if;
	
	set @num=0;
    select count(1) into @num from BD_STEPURL where  STEP='Z0705' and STEP0 = 'Z0705';
    if @num = 1 then
         update BD_STEPURL set URL='/exp/bidding/buy/scaling/listgg.do' where URL='/exp/bidding/buy/scaling/confirmList.do' and STEP='Z0705' and STEP0 = 'Z0705';
    end if;
	
	set @num=0;
    select count(1) into @num from BD_STEPURL where  STEP='Z0710' and STEP0 = 'Z0710';
    if @num = 1 then
         update BD_STEPURL set URL='/exp/bidding/buy/scaling/listjg.do' where URL='/exp/bidding/buy/scaling/listgg.do' and STEP='Z0710' and STEP0 = 'Z0710';
    end if;
  	-- --wyd 2018年12月24日11:05:18 修改流程节点对应的url   end-----------------------------  
    

    -- --2018-11-07-16 增加ES搜索调用地址及日志    start-----------------------------
	set @num=0;
    select count(0) into @num from BD_VALUE where gid='UTIL_CONFIG' and key1='ES_SEARCH_LOG';
    if @num = 0 then
        INSERT INTO `BD_VALUE`(`GID`, `KEY1`, `VALUE`, `REMARK`, `DEFAULTVALUE`, `CSFLAG`)
        VALUES ('UTIL_CONFIG', 'ES_SEARCH_LOG','1','ES搜索-日志开关-0-关闭日志 1-开启','0','2');
    end if;

	set @num=0;
    select count(0) into @num from BD_VALUE where gid='UTIL_CONFIG' and key1='ES_SEARCH_URL';
    if @num = 0 then
        INSERT INTO `BD_VALUE`(`GID`, `KEY1`, `VALUE`, `REMARK`, `DEFAULTVALUE`, `CSFLAG`)
        VALUES ('UTIL_CONFIG', 'ES_SEARCH_URL','http://192.168.2.56:9173/v1','ES搜索-请求路径','0','2');
    end if;
    
    set @num=0;
    select count(0) into @num from BD_AUTO_TASK where taskid='AutoTaskAction.autoSearch';
    if @num = 0 then
        INSERT INTO `BD_AUTO_TASK`(`TASKID`, `SERVERNAME`, `REMARK`, `RUNTYP`)
        VALUES ('AutoTaskAction.autoSearch', 'hejw', '前台-自动推送搜索数据到ES平台', 1);
    end if;
    -- --2018-11-07-16 增加ES搜索调用地址及日志    end-----------------------------







	-- ==================================================================================
end
$$
CALL P_IM_UPGRADE();