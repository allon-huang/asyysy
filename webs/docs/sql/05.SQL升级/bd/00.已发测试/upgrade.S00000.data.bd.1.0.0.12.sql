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
  
	    ------------add by zhaoy 2017-12-12 start---------
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='ZBWJ_GMJSSJ' and csmc='招标文件发售期';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue, opt,remark,flag0,unit,orderno,csbz)
        values('ZBWJ_GMJSSJ',1,'招标文件发售期','5','系统管理员','招标文件发售期不得少于5日',1,'日',4100,'招标文件购买开始至结束时间');
    end if; 
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='TBWJ_JZSJ' and csmc='递交投标文件的期限，不少于';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue, opt,remark,flag0,unit,orderno,csbz)
        values('TBWJ_JZSJ',1,'递交投标文件的期限，不少于','20','系统管理员','递交投标文件的期限，自招标文件发出之日起不得少于20日',1,'日',4200,'招标文件购买开始时间至投标文件截止日期(即开标日期)');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='KB_TBQR_DATE' and csmc='开标后各方确认开标记录的时间控制参数';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue, opt,remark,flag0,unit,orderno,csbz)
        values('KB_TBQR_DATE',1,'开标后各方确认开标记录的时间控制参数','5','系统管理员','开标后各方确认开标记录的时间控制参数',1,'分钟',4300,'开标后投标方确认时间控制参数');
    end if; 
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='PSWYH_RS' and csmc='委员会人数，不少于';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue, opt,remark,flag0,orderno,csbz)
        values('PSWYH_RS',1,'委员会人数，不少于','5','系统管理员','审查委员会人数',1,4900,'审查委员会人数:最少人数为5人');
    end if;
        
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='M_BUILD_JURY_TIME' and csmc='投标文件递交截止时间前';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,mrp,opt,remark,flag0,unit,orderno,csbz)
        values('M_BUILD_JURY_TIME',1,'投标文件递交截止时间前','72','5','系统管理员','开始组建评标委员会的时间',1,'小时',5200,'组建评审委员会开始');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='ZBHXRGS_JSSJ' and csmc='中标候选人公示期(开始当天不算)';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,opt,remark,flag0,unit,orderno,csbz)
        values('ZBHXRGS_JSSJ',1,'中标候选人公示期(开始当天不算)','3','系统管理员','中标候选人公示期不少于3日',1,'日',4500,'中标候选人公示开始至结束时间(开始当天不算)');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='M_TBR_ASK_TIME' and csmc='投标文件递交截止日期前';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,mrp,opt,remark,flag0,unit,orderno,csbz)
        values('M_TBR_ASK_TIME',1,'投标文件递交截止日期前','4','5','系统管理员','投标人提问的截止时间',1,'日',4600,'投标人投标文件提问截止');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='M_ZBR_CLARIFY_TIME' and csmc='澄清或修改招标文件的时间';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,mrp,opt,remark,flag0,unit,orderno,csbz)
        values('M_ZBR_CLARIFY_TIME',1,'澄清或修改招标文件的时间','5','5','系统管理员','澄清或修改招标文件影响投标文件编制的，应在投标截止时间15日前作出。',1,'日',4800,'招标人投标文件澄清截止');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='ZBWJYYTJSJ' and csmc='招标文件异议提出时间期限';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,opt,remark,flag0,unit,orderno,csbz)
        values('ZBWJYYTJSJ',1,'招标文件异议提出时间期限','10','系统管理员','投标截止时间10日前提出',1,'日',4400,'投标文件递交截止时间前');
    end if;
    
    num:=0;
    select count(1) into num from BD_CSSZ_STANDARD where cskey='KBYYTJSJ' and csmc='开标异议提出期限';
    if num = 0 then
        insert into BD_CSSZ_STANDARD(cskey, type, csmc, csvalue,opt,remark,flag0,unit,orderno,csbz)
        values('KBYYTJSJ',1,'开标异议提出期限','5','系统管理员','自生成开标记录表后-分钟内',1,'分钟',4700,'开标后-分钟之内');
    end if;
    ------------add by zhaoy 2017-12-12 end---------
	--------------add by lijb 2017年12月25日 start--------------
	num:=0;
  select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoQueryExpert';
  if num = 0 then
      insert into bd_auto_task(taskid, servername, remark, runtyp)
      values('AutoBdPostQueueTimeScheduler.autoQueryExpert','lijb','查询目前专家库中没有账号的专家,批量发送短信',1);
  end if;
  
  num:=0;
  select count(1) into num from bd_codes where typ='常用代码类别' and code='职业资格人员最高学位';
  if num=0 then
      insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
      values('常用代码类别','职业资格人员最高学位','职业资格人员最高学位', 1, 45, 1);
  end if;
	--------------add by lijb 2017年12月25日 end----------------
	--------------add by hejw 2018年01月04日 start----------------
  num:=0;
  select count(1) into num from bd_codes where typ='会员认证费用退款账号' and code='T00005';
  if num=0 then
      insert into bd_codes (typ,code,value,isuse,disflag0)
      values('会员认证费用退款账号','T00005','3110710027570000005', 1, 1);
  end if;   
	--------------add by hejw 2018年01月04日 end----------------
	--------------add by lijb 2017年12月25日 start--------------
	num:=0;
  select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoExpertBlack';
  if num = 0 then
      insert into bd_auto_task(taskid, servername, remark, runtyp)
      values('AutoBdPostQueueTimeScheduler.autoExpertBlack','lijb','每天凌晨执行专家黑名单自动启用回正式库',1);
  end if;
  
  ------add by hejw ------
  num:=0;
  select count(1) into num from bd_value where gid='TRAINING-KEY' and key='TRAINING_NO';
  if num = 0 then
      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
      values('TRAINING-KEY','TRAINING_NO','0000','培训费收款账号','0','2');
  end if;
  
  num:=0;
  select count(1) into num from bd_value where gid='TRAINING-KEY' and key='TRAINING_NAME';
  if num = 0 then
      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
      values('TRAINING-KEY','TRAINING_NAME','名称','培训费收款账号名称','0','2');
  end if;
  
  num:=0;
  select count(1) into num from bd_value where gid='TRAINING-KEY' and key='BACK_POSTURL';
  if num = 0 then
      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
      values('TRAINING-KEY','BACK_POSTURL','http://192.168.2.56/bdplatform/exp/bidding/training/order/paycallback.do','培训费支付成功回掉','0','2');
  end if;
  ---------20180125-hejw-end---------------------

  ------------add by nieche 2018年01月25日 培训课程报名订单单据号生成规则 start--------------
	num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='BD_TRAINING_ORDER';
    if num=0 then
        insert into bd_value (gid,key,value,remark,defaultvalue,csflag)
        values('RunTime','BD_TRAINING_ORDER','1', '培训课程报名订单单据号生成规则', '1', '2');
    end if;
    ------------add by nieche 2018年01月25日 培训课程报名订单单据号生成规则 end--------------

    ------------add by nieche 2018年01月29日 start---------------
	num:=0;
    select count(1) into num from bd_value where gid='TRAINING-KEY' and key='TRAINING_PAYMENTSECOND';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
        values('TRAINING-KEY','TRAINING_PAYMENTSECOND','600','订单点击去支付请求监管平台后禁止删除订单时间（单位秒）','0','2');
    end if;
	------------add by nieche 2018年01月29日 end---------------

  ------------add by nieche 2018年01月30日 优惠卷ID生成规则 start--------------
	  num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='BD_COUPON';
    if num=0 then
        insert into bd_value (gid,key,value,remark,defaultvalue,csflag)
        values('RunTime','BD_COUPON','1', '优惠卷ID生成规则', '1', '2');
    end if;
    ------------add by nieche 2018年01月30日 优惠卷ID生成规则 end--------------
	--------------add by lijb 2018年02月05日 start--------------
	num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoConfirmBidOpeningTbf';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoConfirmBidOpeningTbf','lijb','查询前30分钟开标记录超过投标单位确认时间，且投标单位未确认的数据',1);
    end if;
    --------------add by lijb 2010年02月05日 start--------------
	--------------add by lijb 2018年02月24日 start--------------
	num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoDelExpert';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoBdPostQueueTimeScheduler.autoDelExpert','lijb','6 月 1 日之后未提交资料的专家， 直接从专家库管理中移出，进入待启用专家中， 状态为待启用',1);
    end if;
    --------------add by lijb 2010年02月24日 start--------------
	--------------add by lijb 2018年02月25日 start--------------
	num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoEldExpert';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoBdPostQueueTimeScheduler.autoEldExpert','lijb','年龄超过 70 岁的专家， 直接从专家库管理中移出 ',1);
    end if;
    --------------add by lijb 2010年02月25日 start--------------

    ------------add by nieche 2018年03月07日 start---------------
	--是否启用评标控制开关 1表示启用 0表示不启用 目前中兵启用，山能不启用
	num:=0;
    select count(1) into num from bd_value where gid='PS_FLAG_KEY' and key='BID_EVALUATION_FLAG';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
        values('PS_FLAG_KEY','BID_EVALUATION_FLAG','1','是否启用评标控制开关 1表示启用 0表示不启用','0','2');
    end if;
	------------add by nieche 2018年03月07日 end---------------

	-------保证金提现-----add by hejw 2018年03月13日 start---------------
      num:=0;
      select count(1) into num from bd_codes where typ='平台保证金归集账户' and code='111111';
      if num=0 then
          insert into bd_codes (typ,code,value,isuse,disflag0)
          values('平台保证金归集账户','111111','110110', 1, 1);
      end if;
	------------add by hejw 2018年03月13日 end---------------
	------------add by hejw 2018年03月14日 start---保证金指定退款天数------------
    num:=0;
    select count(1) into num from bd_cssz where cskey='MARGIN_BACK_REFUND_DAYS';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz)
        values('MARGIN_BACK_REFUND_DAYS','保证金指定退款时间N+1天','0', '0','系统管理员','0-及时退款，1-延后1天退款',1,'天', 7900,'1延后1天，2延后2天');
    end if;
	------------add by hejw 2018年03月14日 end---------------

	------------add by hejw 2018年03月16日 start--监管平台配置-------------
      num:=0;
      select count(1) into num from bd_value where gid='BD_BANK_CONFIG' and key='BANK_SHOPNO';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('BD_BANK_CONFIG','BANK_SHOPNO','GBK-D00000','监管平台分配-商户号','','2');
      end if;
       
     num:=0;
      select count(1) into num from bd_value where gid='BD_BANK_CONFIG' and key='BANK_MAC';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('BD_BANK_CONFIG','BANK_MAC','12DI39EF93K02LO498DNC82Y8USMNE9U','监管平台分配-签名验签密钥','','2');
      end if;
      
       num:=0;
      select count(1) into num from bd_value where gid='BD_BANK_CONFIG' and key='BANK_URL';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('BD_BANK_CONFIG','BANK_URL','http://192.168.2.250:8080/bdmbank/','监管平台-访问地址','','2');
      end if;
  
	------------add by hejw 2018年03月16日 end---------------
	--------------add by zhaoy 2018年04月03日 start--------------
	num:=0;
	  select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoCreatePdfOrHtml';
	  if num = 0 then
	      insert into bd_auto_task(taskid, servername, remark, runtyp)
	      values('AutoAuctionAction.autoCreatePdfOrHtml','YPOJ7SM0HKDEPPJ','标段异常后,满足可生成pdf,html页面需求条件,则生成',1);
	  end if;
	--------------add by zhaoy 2018年04月03日 end--------------

    -----add by hejw 2018-04-03  start ------
      num:=0;
      select count(1) into num from bd_value where gid='RunTime' and key='BD_TD_DD';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('RunTime','BD_TD_DD','1','33470234b54f4a2ab33afd39409a4fef','120207','2');
      end if;
    -----add by hejw 2018-04-03  end ------

    -----add by hejw 2018-05-10  start ------
      num:=0;
      select count(1) into num from bd_value where gid='UB_CONFIG' and key='POST_URL';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('UB_CONFIG','POST_URL','http://127.0.0.1:9071/v1','用户行为分析平台调用地址','','2');
      end if;
    -----add by hejw 2018-05-10  end ------
    -----add by hejw 2018-05-24  start ------
  num:=0;
  select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoOpenTbrAllFile';
  if num = 0 then
      insert into bd_auto_task(taskid, servername, remark, runtyp)
      values('AutoAuctionAction.autoOpenTbrAllFile','hejw','前台-定时处理投标方都解密完成的标段状态',1);
  end if;
    -----add by hejw 2018-05-24  end ------
	-----add by lijb 2018-06-01  start ------
    num:=0;
  	select count(1) into num from bd_auto_task where taskid='AutoBdPostQueueTimeScheduler.autoQueryReceipt';
  	if num = 0 then
      	insert into bd_auto_task(taskid, servername, remark, runtyp)
      	values('AutoBdPostQueueTimeScheduler.autoQueryReceipt','lijb','自动扫描投标人获取已发布的澄清与变更公告 ',1);
  	end if;
	-----add by lijb 2018-06-01  end ------
	
	------------add by zhaoy 2018年06月04日 start---------------
 	num:=0;
	  	select count(1) into num from bd_value where gid='SYSTEM' and key='BD_IS_PAGE_HYDD';
	  	if num = 0 then
	      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
	      values('SYSTEM','BD_IS_PAGE_HYDD','1','后台-是否分页导出会员订单','','0');
	 	end if;
	------------add by zhaoy 2018年06月04日 end---------------

	------------add by hejw 2018年06月07日 start---------------
      num:=0;
      select count(1) into num from bd_value where gid='EXTERNAL_CONFIG' and key='OPEN_CONTROL';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('EXTERNAL_CONFIG','OPEN_CONTROL','0','1-开启监管黑名单控制，0ornull-关闭','','2');
      end if;
	------------add by hejw 2018年06月07日 end---------------

	------------add by zhaoy 2018年06月21日 start---------------
	num:=0;
    select count(1) into num from bd_value where gid='ADMISSIBLE_COMPLAINTS' and key='COMPLAINTS_SMS_SEND_NAME';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
        values('ADMISSIBLE_COMPLAINTS','COMPLAINTS_SMS_SEND_NAME','吉安娜','存在未受理投诉,向指定人发送短信提醒,指定人名称','管理员','0');
    end if;
    
    num:=0;
    select count(1) into num from bd_value where gid='ADMISSIBLE_COMPLAINTS' and key='COMPLAINTS_SMS_SEND_MOBILE';
    if num = 0 then
        insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
        values('ADMISSIBLE_COMPLAINTS','COMPLAINTS_SMS_SEND_MOBILE','11321421321','存在未受理投诉,向指定人发送短信提醒,短信发送电话','1111111','0');
    end if;
  
	num:=0;
	  select count(1) into num from bd_auto_task where taskid='AutoSmsTimeScheduler.autoSmsAdmissibleComplaints';
	  if num = 0 then
	      insert into bd_auto_task(taskid, servername, remark, runtyp)
	      values('AutoSmsTimeScheduler.autoSmsAdmissibleComplaints','zhaoy','未受理投诉发送短信提醒指定人',1);
	  end if;
	------------add by zhaoy 2018年06月21日 end---------------
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
