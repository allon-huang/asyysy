DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.5'; -- 本升级文件的版本，每个升级文件必须修改
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
    select count(1) into num from bd_codes where typ='常用代码类别' and code='评标专家确认方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','评标专家确认方式','评标专家确认方式', 1, 200, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保形式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保形式','履约担保形式', 1, 210, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保金额单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保金额单位','履约担保金额单位', 1, 220, 1);
    end if;
    
  
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='评标专家确认方式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','评标专家确认方式','评标专家确认方式', 1, 200, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保形式';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保形式','履约担保形式', 1, 210, 1);
    end if;
	num:=0;
    select count(1) into num from bd_codes where typ='常用代码类别' and code='履约担保金额单位';
    if num=0 then
        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
        values('常用代码类别','履约担保金额单位','履约担保金额单位', 1, 220, 1);
    end if;
    
    num:=0;
    select count(1) into num from bd_cssz where cskey='MAX_BID_PRICE';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz) 
      values('ISCONFIRM','报名是否确认','0','','系统管理员','0-不需要审核，1-需要审核价','1',3100,'0-不需要审核，1-需要审核');
	 end if; 
	 
	 num:=0;
    select count(1) into num from bd_property_mx where propid=12 and tname='BD_FB_ZBCSSZ' and tfield='PROBID';
    if num=0 then
        insert into bd_property_mx (pkid,propid,showtext,tname,tfield,typ,sortno,isuse,isedit)
        values(bd_property_mx_0.nextval,12,'文件参数.招标项目编号','BD_FB_ZBCSSZ', 'PROBID', 'S', 38,'1','0');
    end if;
   
   
	------------2016/07/09 hanglong 资金支付清单业务处理队列添加到初始化表 start--------------
	num:=0;
	tmp1:=upper('BD_ZFQD_QUENUE');
	select count(1) into num from sys_init where TNAME=tmp1;
	if num = 0 then
		insert into sys_init(TNAME, flag)
		values(tmp1,1);
	end if;
	
	num:=0;
	tmp1:=upper('BD_ZFQD_QUENUE_BAK');
	select count(1) into num from sys_init where TNAME=tmp1;
	if num = 0 then
		insert into sys_init(TNAME, flag)
		values(tmp1,1);
	end if;
	------------2016/07/09 hanglong 资金支付清单业务处理队列添加到初始化表 end--------------

	------------2016/07/09 hanglong 资金支付定时任务 start--------------
	num:=0;
	select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoEcitibankPay';
	if num = 0 then
		insert into bd_auto_task(taskid, servername, remark, runtyp)
		values('AutoAuctionAction.autoEcitibankPay','PC201406300944','中信银行出金转账定时查询',1);
	end if;
	------------2016/07/09 hanglong 资金支付定时任务 end--------------
	
  	------------2016/07/09 jinyanhui 继续任务节点跳转路径 start-------------- 	
   	delete bd_stepurl;
	num:=0;
    select count(1) into num from bd_stepurl where step='Z0101' and step0='Z0101';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0101','Z0101','1','/exp/bidding/buy/subproject/list.do','','','','','','proid');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0102' and step0='Z0102';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0102','Z0102','1','/exp/bidding/buy/package/list.do','','','probid','','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0201' and step0='Z0201';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0201','Z0201','1','/exp/bidding/buy/prefic/index.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0202' and step0='Z0202';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0202','Z0202','1','/exp/bidding/buy/prefic/toZgysCssz.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0203' and step0='Z0203';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0203','Z0203','1','/bdp/bidding/buy/preficfile/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0204' and step0='Z0204';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0204','Z0204','1','/exp/bidding/buy/prefic/view.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0205' and step0='Z0205';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0205','Z0205','1','/bdp/build/pre/jury/index.do','','','probid','bdid','','');
   end if;
    
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0206' and step0='Z0206';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0206','Z0206','1','/exp/bidding/buy/ysopen/ysPackList.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0208' and step0='Z0208';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0208','Z0208','1','/bdp/pre/result/packlist.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0209' and step0='Z0209';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0209','Z0209','1','/exp/bidding/buy/gkys/packlist.do','','','probid','bdid','','');
   end if;  
    
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0301' and step0='Z0301';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0301','Z0301','1','/exp/bidding/buy/zbwjone/toZbwjCssz.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0302' and step0='Z0302';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0302','Z0302','1','/exp/bidding/buy/zbwjone/packlist.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0303' and step0='Z0303';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0303','Z0303','1','/bdp/buy/survey/notice/packlist.do','','','probid','bdid','','');
   end if; 
   
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0304' and step0='Z0304';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0304','Z0304','1','/bdp/build/jury/index.do','','','probid','bdid','','');
   end if; 
   
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0401' and step0='Z0401';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0401','Z0401','1','/exp/bidding/buy/kb/kbPackList.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0402' and step0='Z0402';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0402','Z0402','1','/exp/bidding/buy/kb/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0501' and step0='Z0501';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0501','Z0501','1','/bdp/review/result/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0601' and step0='Z0601';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0601','Z0601','1','/exp/bidding/buy/scaling/listzb.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0602' and step0='Z0602';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0602','Z0602','1','/exp/bidding/buy/scaling/listdb.do','','','probid','bdid','','');
   end if;    
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0603' and step0='Z0603';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0603','Z0603','1','/exp/bidding/buy/scaling/listjg.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0604' and step0='Z0604';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0604','Z0604','1','/exp/bidding/buy/scaling/listgg.do','','','probid','bdid','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0701' and step0='Z0701';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0701','Z0701','1','/exp/bidding/buy/contract/bidbond/list.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0702' and step0='Z0702';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0702','Z0702','1','/exp/bidding/buy/contract/packageList.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0703' and step0='Z0703';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0703','Z0703','1','/exp/bidding/buy/contract/execute/list.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0704' and step0='Z0704';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0704','Z0704','1','/exp/bidding/buy/contract/audit/list.do','','','probid','bdid','','');
   end if;           
      
   num:=0;
    select count(1) into num from bd_stepurl where step='T0101' and step0='T0101';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0101','T0101','2','/exp/bidding/sell/signup/toZgysSignup.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0102' and step0='T0102';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0102','T0102','2','/exp/bidding/sell/signup/list.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0103' and step0='T0103';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0103','T0103','2','/exp/bidding/sell/signup/toUpZgyssqwj.do','','','probid','bdid','','');
   end if;      

    num:=0;
    select count(1) into num from bd_stepurl where step='T0104' and step0='T0104';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0104','T0104','2','/exp/bidding/sell/ysopen/index.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0105' and step0='T0105';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0105','T0105','2','/exp/bidding/sell/result/list.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0106' and step0='T0106';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0106','T0106','2','/exp/bidding/sell/signup/zblist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0201' and step0='T0201';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0201','T0201','2','/exp/bidding/sell/bidding/toUploadTbwj.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0202' and step0='T0202';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0202','T0202','2','/exp/bidding/sell/bidbond/pay/list.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0301' and step0='T0301';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0301','T0301','2','/exp/bidding/sell/kbqd/index.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0401' and step0='T0401';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0401','T0401','2','/exp/bidding/sell/qureply/list.do','','','probid','bdid','','');
   end if;   
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0501' and step0='T0501';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0501','T0501','2','/exp/bidding/sell/hitbid/publicity/packlist.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0502' and step0='T0502';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0502','T0502','2','/exp/bidding/sell/hitbid/result/packlist.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0601' and step0='T0601';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0601','T0601','2','/exp/bidding/sell/contract/bidbond/list.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0602' and step0='T0602';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0602','T0602','2','/exp/bidding/sell/contract/packageList.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='T0603' and step0='T0603';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0603','T0603','2','/exp/bidding/sell/contract/execute/list.do','','','probid','bdid','','');
   end if; 
  	------------2016/07/09 jinyanhui 继续任务节点跳转路径 end--------------             	        
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  