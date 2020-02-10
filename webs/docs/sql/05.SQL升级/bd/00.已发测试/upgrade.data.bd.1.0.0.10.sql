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
  
    --初始化sql hejw start ----
    --update bd_jury t set t.fristdate=t.cdate where nvl(t.status, 0)=3 and t.cdate is not null and t.fristdate is null;
    --初始化sql hejw end ----
    --流水表时间初始化 start ---
    --update BD_IN_OUT_AMT t set t.TRAN_DATE=t.CDATE where t.cdate is not null and t.TRAN_DATE is null;
    --流水表时间初始化 end ---
    --初始化委员会抽取条件人数 start--
    --update bd_jury_require t set t.currentrs2=t.currentrs where t.currentrs2 is null and t.wyhdm in (select j.wyhdm from bd_jury j where nvl(j.limit, '0')='1' );
    --初始化委员会抽取条件人数 end--


    --add by zhangjian 2017-5-10 踏勘现场是否需要后台审核 start  --
	num:=0;
    select count(1) into num from bd_cssz where cskey='TKXC_SFHTSH';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('TKXC_SFHTSH','踏勘现场是否需要后台审核','1','系统管理员','0-不需要审核 ，1-需要审核',1,'',7600,'踏勘现场是否需要后台审核0-不审核 1-审核');
	end if;
	--add by zhangjian 2017-5-10 end  --

    --保证金退款状态兼容初始化 start ------
--------投标保证金-------start-------------
--1.订单中的标识，修改所有已退款成功标段 下 所有订单为退款成功 statusback=10
   -- update bd_td_dd d set d.statusback=10 where d.flag1 in ('3','4') and d.zffs = '1' and d.fyly='3' and d.statusback is null
   -- and exists( select 1 from bd_package p where p.bdid=d.bdid and nvl(p.returntbbzj, '0') in ('1','2') );
    
--2.标段包标识，替换 标段已退款标识到新标识中 status02=4
    --update bd_package p set p.status02=4 where nvl(p.returntbbzj, '0') in ('1','2') and p.status02 is null;
    
--3.招标项目标识，是不是所有标段已退款 status02=4
    --update bd_subproject s set status02=4 where s.status02 is null
    --and s.probid in (select DISTINCT p.probid from bd_package p where nvl(p.returntbbzj, '0') in ('1','2') )
    --and  1 > (select count(*) from bd_package p where s.probid=p.probid and nvl(p.returntbbzj, '0')='0');
--------投标保证金-------end-------------
    
--------图纸押金5-------start-------------
--1.订单中的标识，修改所有已退款成功标段 下 所有订单为退款成功 statusback=10
    --update bd_td_dd d set d.statusback=10 where d.flag1 in ('3','4') and d.zffs = '1' and d.fyly='5' and d.statusback is null
   -- and exists( select 1 from bd_package p where p.bdid=d.bdid and nvl(p.returntzyj, '0') in ('1','2') );
    
--2.标段包标识，替换 标段已退款标识到新标识中 status02=4
    --update bd_package p set p.status03=4 where nvl(p.returntzyj, '0') in ('1','2') and p.status03 is null;
    
--3.招标项目标识，是不是所有标段已退款 status02=4
    --update bd_subproject s set status03=4 where s.status03 is null
    --and s.probid in (select DISTINCT p.probid from bd_package p where nvl(p.returntzyj, '0') in ('1','2') )
    --and  1 > (select count(*) from bd_package p where s.probid=p.probid and nvl(p.returntzyj, '0')='0');
--------图纸押金-------end-------------
    
--------履约保证金4-------start-------------
--1.订单中的标识，修改所有已退款成功标段 下 所有订单为退款成功 statusback=10
   -- update bd_td_dd d set d.statusback=10 where d.flag1 in ('3','4') and d.zffs = '1' and d.fyly='4' and d.statusback is null
   -- and exists( select 1 from bd_package p where p.bdid=d.bdid and nvl(p.returnlybzj, '0') in ('1','2') );
    
--2.标段包标识，替换 标段已退款标识到新标识中 status02=4
    --update bd_package p set p.status04=4 where nvl(p.returnlybzj, '0') in ('1','2') and p.status04 is null;
    
--3.招标项目标识，是不是所有标段已退款 status02=4
    --update bd_subproject s set status04=4 where s.status04 is null
    --and s.probid in (select DISTINCT p.probid from bd_package p where nvl(p.returnlybzj, '0') in ('1','2') )
   -- and  1 > (select count(*) from bd_package p where s.probid=p.probid and nvl(p.returnlybzj, '0')='0');
--------履约保证金-------end-------------
    --保证金退款状态兼容初始化end ------
--注：以上初始化sql 正式环境已经执行过，所以屏蔽掉

  num:=0;
    select count(1) into num from sys_init where tname='BD_AUDIT_RECORDS';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_AUDIT_RECORDS', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_CFCA_QUEUE';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_CFCA_QUEUE', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_CFCA_SEND';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_CFCA_SEND', 1);
    end if;
    
  num:=0;
    select count(1) into num from sys_init where tname='BD_CFCA_ZFQD';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_CFCA_ZFQD', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_CFCA_ZFQD_MX';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_CFCA_ZFQD_MX', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_DP_DYNAMIC';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_DP_DYNAMIC', 1);
    end if;
    
  num:=0;
    select count(1) into num from sys_init where tname='BD_DP_QUEUE';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_DP_QUEUE', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_INTERFACE_LOG';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_INTERFACE_LOG', 1);
    end if;
    
  num:=0;
    select count(1) into num from sys_init where tname='BD_IN_OUT_AMT';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_IN_OUT_AMT', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_JURY_CENTER';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_JURY_CENTER', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_MESSAGE';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_MESSAGE', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE_RECORD';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE_RECORD', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_PTJBXX';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_PTJBXX', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_REFUND_APPLY';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_REFUND_APPLY', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_SMS_QUEUE';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_SMS_QUEUE', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_SOFTWARE';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_SOFTWARE', 1);
    end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_TB_SIGNUP_RECORD';   
    if num = 0 then
        insert into sys_init (tname,flag) values('BD_TB_SIGNUP_RECORD', 1);
    end if;
    
    -------add by songw 2017年5月15日 start-----------
    --add 增加资格预审评委信息维护步骤节点
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0247' and step0='Z0247';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0247','Z0247','1','/exp/bidding/buy/premtcfee/packlist.do','','','probid','bdid','','');
    end if; 
    
    num:=0;
    select count(1) into num from bd_stepurl where step='D0242' and step0='D0242';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0242','D0242','1','/exp/bidding/buy/premtcfee/packlist.do','','','probid','bdid','','');
    end if; 
    
    -------add by songw 2017年5月15日 end-----------
 	
 	---------------add by songw 2017年6月2日 start---------------
    --将公告/邀请书发布时间更新至标段包中的ggfbsj
    --更新邀请流程的发布时间保存至相应标段包中
    --update bd_package t set t.ggfbsj = (select a.fbdate from bd_tbyqsbz a where a.probid = t.probid) 
    --where t.probid in (select b.probid from bd_tbyqsbz b where b.probid = t.probid and b.typ = '1' and b.tstate = '1' and b.fbdate is not null) and t.ggfbsj is null;

    ----更新预审公告或招标公告中的发布时间保存至相应标段包中
    --update bd_package t set t.ggfbsj = (select a.date1 from bd_zbgg a where a.probid = t.probid) 
    --where t.probid in (select b.probid from bd_zbgg b where b.probid = t.probid and b.status = '2' and b.date1 is not null) and t.ggfbsj is null;
 	---------------add by songw 2017年6月2日 end---------------
 	
 	---------------add by songw 2017年6月14日 start-------------
    --增加中标候选人公示状态字段，原来是保存就等于发布，故将原有的中标候选人公示的新增的状态字段更新为 5-已发布
    update bd_db_hxrgs t set t.status = '5' where exists (select 1 from bd_package b where t.packid = b.bdid) and t.status is null;
 	---------------add by songw 2017年6月14日 end-------------

 	---------------add by hejw 2017年6月15日 start-------------
    num:=0;
    select count(1) into num from bd_codes where typ='培训费退款账号' and code='T00006';
    if num = 0 then
      insert into bd_codes(typ, code, value, isuse, disflag0) 
      values('培训费退款账号', 'T00006', '3110710027570000006', 1, 1);
    end if; 
    
    num:=0;
    select count(1) into num from bd_codes where typ='培训费退款账号' and code='T00002';
    if num = 0 then
      insert into bd_codes(typ, code, value, isuse, disflag0) 
      values('培训费退款账号', 'T00002', '3110710027570000002', 1, 1);
    end if; 

    num:=0;
    select count(1) into num from bd_codes where typ='CA退款账号' and code='T00004';
    if num = 0 then
      insert into bd_codes(typ, code, value, isuse, disflag0) 
      values('CA退款账号', 'T00004', '3110710027570000004', 1, 1);
    end if; 
    
    num:=0;
    select count(1) into num from bd_codes where typ='CA退款账号' and code='T00008';
    if num = 0 then
      insert into bd_codes(typ, code, value, isuse, disflag0) 
      values('CA退款账号', 'T00008', '3110710027570000008', 1, 1);
    end if; 
 	---------------add by hejw 2017年6月15日 end-------------

    --------------add by songw 2017年6月30日 start-----------------
    --后台交易参数设置增加招标项目终止审核，1-是，需要平台审核 0-否，不需要平台审核
    num:=0;
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_EXAMINE_ABNORMAL';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CSSZ_IS_EXAMINE_ABNORMAL','招标项目终止是否需要审核','0', '0','系统管理员','若选择是，则招标项目终止需要平台审核',1, 5450,'1-是 0-否');
    end if;
  
    num:=0;
    select count(1) into num from bd_cssz_ext where typ='CSSZ_IS_EXAMINE_ABNORMAL';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_EXAMINE_ABNORMAL', '0', '否');
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_EXAMINE_ABNORMAL', '1', '是');
    end if;
    --------------add by songw 2017年6月30日 end-----------------
	
	----------------add by songw 2017年7月17日 start---------------
    --招标参数设置专家确定方式增加线下选取专家方式
    num:=0;
    select count(1) into num from bd_codes where typ='评标专家确认方式' and code='4';
    if num = 0 then
      insert into bd_codes(typ, code, value, isuse, orderno, disflag0) 
      values('评标专家确认方式', '4', '线下选取专家', 1, 40, 1);
    end if; 
	----------------add by songw 2017年7月17日 end---------------

	----------------add by hejw 2017年7月27日 start---------------
    num:=0;
    select count(1) into num from bd_cssz where cskey='STOP_TRADING_TIME';   
    if num = 1 then
       update bd_cssz set flag1=1 where cskey='STOP_TRADING_TIME';
    end if;
	----------------add by hejw 2017年7月27日 end---------------

    --------------add by songw 2017年8月1日 start-----------------
    -- 增加开标前5分钟自动组建完成委员会相关定时任务
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoBuildJury';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoBuildJury','songw','开标前5分钟自动组建完成委员会',1);
    end if;
    --------------add by songw 2017年8月1日 end-----------------

    --------------add by hejw 2017年8月17日 start-----------------
    num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='CFCA-WATER-BACK-OUT';
    if num = 0 then
        insert into bd_value(gid, key, value, remark, csflag)
        values('RunTime', 'CFCA-WATER-BACK-OUT', 'http://192.168.1.105:8080/exp/bidding/lug/fund/callback.do', '资金归集-保证金资金退费-出金申请回调地址', '0');
    end if;
    --------------add by hejw 2017年8月17日 end-----------------
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  