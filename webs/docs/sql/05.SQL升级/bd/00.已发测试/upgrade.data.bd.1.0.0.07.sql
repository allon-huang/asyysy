DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.7'; -- 本升级文件的版本，每个升级文件必须修改
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
    select count(1) into num from bd_stepurl where step='Z0210' and step0='Z0210';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/gkys/packlist.do' where  step='Z0210' and step0='Z0210';
   end if;
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0209' and step0='Z0209';
    if num = 1 then
      update bd_stepurl set url='/bdp/pre/result/packlist.do' where  step='Z0209' and step0='Z0209';
   end if;
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0208' and step0='Z0208';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/ysopen/ysjlPackList.do' where  step='Z0208' and step0='Z0208';
   end if;
  
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0207' and step0='Z0207';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/ysopen/ysPackList.do' where  step='Z0207' and step0='Z0207';
   end if;
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0206' and step0='Z0206';
    if num = 1 then
      update bd_stepurl set url='/bdp/build/pre/jury/index.do' where  step='Z0206' and step0='Z0206';
   end if;
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0205' and step0='Z0205';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/prefic/view.do' where  step='Z0205' and step0='Z0205';
   end if;
   
  num:=0;
    select count(1) into num from bd_stepurl where step='Z0204' and step0='Z0204';
    if num = 1 then
      update bd_stepurl set url='/bdp/bidding/buy/preficfile/toconfirmpacklist.do' where  step='Z0204' and step0='Z0204';
   end if;
  
  
  --add by chenxp start 变更公告和澄清文件后台参数设置---
  num:=0;
    select count(1) into num from bd_cssz where cskey='CQWJ_SFHTSH';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('CQWJ_SFHTSH','澄清文件是否需要后台审核','0','','系统管理员','澄清文件是否需要后台审核0-审核 1-审核','1','',3600,'澄清文件是否需要后台审核0-审核 1-审核');
  end if;
    

  num:=0;
    select count(1) into num from bd_cssz where cskey='BGGG_SFHTSH';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('BGGG_SFHTSH','变更公告是否需要后台审核','0','','系统管理员','变更公告是否需要后台审核0-审核 1-审核','1','',3700,'变更公告是否需要后台审核0-审核 1-审核');
  end if;
  --add by chenxp end 变更公告和澄清文件后台参数设置-----
  
  -------2016年8月18日18:17:01 zhangdl 新增平台验证责任人参数 start-----
  num:=0;
    select count(1) into num from bd_cssz where cskey='PTYZZRR';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('PTYZZRR','平台验证责任人','系统管理员','','系统管理员','系统自动关联平台验证责任人，并记录验证时间','1','',3800,'系统自动关联平台验证责任人，并记录验证时间');
  end if;
  -------2016年8月18日18:17:01 zhangdl 新增平台验证责任人参数 end-----
                      

    num:=0;
  	select count(1) into num from bd_cssz where cskey='BGGG_SFHTSH';
  	if num = 0 then
    	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
	 	values('BGGG_SFHTSH','变更公告是否需要后台审核','0','','系统管理员','变更公告是否需要后台审核0-审核 1-审核','1','',3700,'变更公告是否需要后台审核0-审核 1-审核');
	end if;
	--add by chenxp end 变更公告和澄清文件后台参数设置-----

   num:=0;
    select count(1) into num from bd_stepurl where step='D0103' and step0='D0103';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/beingPro/subpInfo.do' where  step='D0103' and step0='D0103';
   end if;    
   
   --提问与回复
    num:=0;
    select count(1) into num from bd_stepurl where step='T0401' and step0='T0401';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/sell/zbwj/dissent/zbClariList.do' where  step='T0401' and step0='T0401';
   end if; 
    
       ---add by chenxp start 招标公告时间参数---
   num:=0;
   select count(1) into num from bd_cssz where cskey='ZBWJ_GMJSSJ';
   if num = 0 then
    	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
	 	values('ZBWJ_GMJSSJ','招标文件购买开始至结束时间','5','','系统管理员','招标文件购买开始至结束时间','1','天',3800,'招标文件购买开始至结束时间');
	end if;
    
    
   num:=0;
   select count(1) into num from bd_cssz where cskey='TBWJ_JZSJ';
   if num = 0 then
    	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
	 	values('TBWJ_JZSJ','招标文件购买结束时间至投标文件截止日期(即开标日期)','20','','系统管理员','招标文件购买结束时间至投标文件截止日期(即开标日期)','1','天',3900,'招标文件购买结束时间至投标文件截止日期(即开标日期)');
   end if;
   ---add by chenxp end   招标公告时间参数--- 
   ---add by xuz start --

	
	 num:=0;
    select count(1) into num from bd_cssz where cskey='MAX_BID_PRICE' and csmc='最高投标限价';
    if num = 1 then
      update bd_cssz set flag0='0' where  cskey='MAX_BID_PRICE' and csmc='最高投标限价';
   end if;
   
   ---add by xuz end--    
          
  	---add by chenxp start--
	num:=0;
  	select count(1) into num from bd_cssz where cskey='CQWJ_SFHTSH';
  	if num = 1 then
       update bd_cssz set remark ='澄清文件是否需要后台审核0-不审核 1-审核' , csbz='澄清文件是否需要后台审核0-不审核 1-审核' where cskey='CQWJ_SFHTSH';
	  end if;
    
    
    num:=0;
  	select count(1) into num from bd_cssz where cskey='BGGG_SFHTSH';
  	if num = 1 then
      update bd_cssz set remark ='变更公告是否需要后台审核0-不审核 1-审核' , csbz='变更公告是否需要后台审核0-不审核 1-审核' where cskey='BGGG_SFHTSH';
    end if;
    ---add by chenxp end  -- 
       	        
   --添加审查委员会人数 2016年8月24日17:51:03 zhangdl start--
   num:=0;
   select count(1) into num from bd_cssz where cskey='PSWYH_RS';
   if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('PSWYH_RS','审查委员会人数','5','','系统管理员','审查委员会人数:最少人数为5人','1','',4100,'审查委员会人数:最少人数为5人');
   end if;  
   --添加审查委员会人数 2016年8月24日17:51:03 zhangdl end--

	-- bd_cssz 抽取专家短信回复有效期
	num:=0;
	select count(1) into num from bd_cssz where cskey='EXTRACT_ZJ_REPLY_SC';
	if num = 0 then
	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz)
	 values('EXTRACT_ZJ_REPLY_SC','抽取专家短信回复有效期','15','15','系统管理员','短信超过该时长后回复是失效的',1,'分钟',4000,'短信超过该时长后回复是失效的');
	end if;
	
	

------add by hejw 资格预审-招标方-继续任务 start----
--删除原 资格预审继续任务
delete bd_stepurl where step in ('Z0201','Z0202','Z0203','Z0204','Z0205','Z0206','Z0207','Z0208','Z0209','Z0210');

num:=0;
select count(1) into num from bd_stepurl where step='Z0200' and step0='Z0200';
if num = 0 then
--Z0201
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0200', 'Z0200', 1, '/exp/bidding/buy/prefic/index.do', null, null, 'probid', 'bdid', null, null, '资格预审公告编制');
end if;   

num:=0;
select count(1) into num from bd_stepurl where step='Z0205' and step0='Z0205';
if num = 0 then
--Z0202
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0205', 'Z0205', 1, '/exp/bidding/buy/prefic/toZgysCssz.do', null, null, 'probid', 'bdid', null, null, '资格预审参数设置');
end if;   


num:=0;
select count(1) into num from bd_stepurl where step='Z0210' and step0='Z0210';
if num = 0 then
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0210', 'Z0210', 1, '/exp/bidding/buy/prefic/topsbfpacklist.do', null, null, 'probid', 'bdid', null, null, '资格预审评审办法');
end if;   


num:=0;
select count(1) into num from bd_stepurl where step='Z0215' and step0='Z0215';
if num = 0 then
--Z0203
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0215', 'Z0215', 1, '/bdp/bidding/buy/preficfile/packlist.do', null, null, 'probid', 'bdid', null, null, '资格预审文件上传');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0220' and step0='Z0220';
if num = 0 then
--Z0204
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0220', 'Z0220', 1, '/bdp/bidding/buy/preficfile/toconfirmpacklist.do', null, null, 'probid', 'bdid', null, null, '资格预审文件确认');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0225' and step0='Z0225';
if num = 0 then
--Z0205
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0225', 'Z0225', 1, '/exp/bidding/buy/prefic/view.do', null, null, 'probid', 'bdid', null, null, '资格预审公告发布');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0230' and step0='Z0230';
if num = 0 then
--Z0206
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
    values ('Z0230', 'Z0230', 1, '/bdp/build/pre/jury/index.do', null, null, 'probid', 'bdid', null, null, '组建资格预审委员会');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0235' and step0='Z0235';
if num = 0 then
--Z0207
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
values ('Z0235', 'Z0235', 1, '/exp/bidding/buy/ysopen/ysPackList.do', null, null, 'probid', null, null, null, '资格预审申请文件开启列表');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0240' and step0='Z0240';
if num = 0 then
--Z0208
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0240', 'Z0240', 1, '/exp/bidding/buy/ysopen/ysjlPackList.do', null, null, 'probid', 'bdid', null, null, '资格预审申请文件开启记录');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0245' and step0='Z0245';
if num = 0 then
--Z0209
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0245', 'Z0245', 1, '/bdp/pre/result/packlist.do', null, null, 'probid', 'bdid', null, null, '资格预审评审报告');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0250' and step0='Z0250';
if num = 0 then
--Z0210
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
  values ('Z0250', 'Z0250', 1, '/exp/bidding/buy/gkys/packlist.do', null, null, 'probid', null, null, null, '资格预审结果发布');
end if;  
------add by hejw 资格预审-招标方继续任务 end----

------add by hejw 发标-招标方继续任务 start----
--删除原 发标-继续任务
delete bd_stepurl where step in ('Z0401','Z0402','Z0403','Z0404','Z0405','Z0406','Z0407');

num:=0;
select count(1) into num from bd_stepurl where step='Z0400' and step0='Z0400';
if num = 0 then
--Z0401
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0400', 'Z0400', 1, '/exp/bidding/buy/zbwjone/toZbwjCssz.do', null, null, 'probid', 'bdid', null, null, '招标文件参数设置');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='Z0405' and step0='Z0405';
if num = 0 then
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0405', 'Z0405', 1, '/exp/bidding/buy/zbwjone/topbbfpacklist.do', null, null, 'probid', 'bdid', null, null, '评标办法');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0410' and step0='Z0410';
if num = 0 then
--Z0402
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0410', 'Z0410', 1, '/exp/bidding/buy/zbwjone/packlist.do', null, null, 'probid', 'bdid', null, null, '招标文件上传');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0415' and step0='Z0415';
if num = 0 then
--Z0403
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0415', 'Z0415', 1, '/exp/bidding/buy/zbwjone/toconfirmpacklist.do', null, null, 'probid', 'bdid', null, null, '招标文件确认');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0420' and step0='Z0420';
if num = 0 then
--Z0404
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0420', 'Z0420', 1, '/exp/bidding/buy/aftfic/toPublish.do', null, null, 'probid', 'bdid', null, null, '招标公告发布');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0425' and step0='Z0425';
if num = 0 then
--Z0405
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
values ('Z0425', 'Z0425', 1, '/exp/bidding/buy/yqhs/toUpdate.do', null, null, 'probid', 'bdid', null, null, '投标邀请书发布');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0430' and step0='Z0430';
if num = 0 then
--Z0406
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0430', 'Z0430', 1, '/bdp/buy/survey/notice/packlist.do', null, null, 'probid', 'bdid', null, null, '踏勘现场');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='Z0435' and step0='Z0435';
if num = 0 then
--Z0407
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('Z0435', 'Z0435', 1, '/bdp/build/jury/index.do', null, null, 'probid', 'bdid', null, null, '组建评标委员会');
end if;  
------add by hejw 发标-招标方-继续任务 end----

------add by hejw 资格预审-代理机构-继续任务 start----
delete bd_stepurl where step in ('D0201','D0202','D0203','D0204','D0205','D0206','D0207','D0208','D0209');

num:=0;
select count(1) into num from bd_stepurl where step='D0200' and step0='D0200';
if num = 0 then
--D0201
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0200', 'D0200', 1, '/exp/bidding/buy/prefic/index.do', null, null, 'probid', 'bdid', null, null, '资格预审公告编制');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='D0205' and step0='D0205';
if num = 0 then
--D0202
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0205', 'D0205', 1, '/exp/bidding/buy/prefic/toZgysCssz.do', null, null, 'probid', 'bdid', null, null, '资格预审参数设置');
end if;  

num:=0;
select count(1) into num from bd_stepurl where step='D0210' and step0='D0210';
if num = 0 then
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0210', 'D0210', 1, '/exp/bidding/buy/prefic/topsbfpacklist.do', null, null, 'probid', 'bdid', null, null, '资格预审评审办法');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0215' and step0='D0215';
if num = 0 then
--D0203
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0215', 'D0215', 1, '/bdp/bidding/buy/preficfile/packlist.do', null, null, 'probid', 'bdid', null, null, '资格预审文件上传');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0220' and step0='D0220';
if num = 0 then
--D0204
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0220', 'D0220', 1, '/exp/bidding/buy/prefic/view.do', null, null, 'probid', 'bdid', null, null, '资格预审公告发布');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0225' and step0='D0225';
if num = 0 then
--D0205
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0225', 'D0225', 1, '/bdp/build/pre/jury/index.do', null, null, 'probid', 'bdid', null, null, '组建资格预审委员会');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0230' and step0='D0230';
if num = 0 then
--D0206
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0230', 'D0230', 1, '/exp/bidding/buy/ysopen/ysPackList.do', null, null, 'probid', 'bdid', null, null, '资格预审申请文件开启列表');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0235' and step0='D0235';
if num = 0 then
--D0207
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0235', 'D0235', 1, '/exp/bidding/buy/ysopen/ysjlPackList.do', null, null, 'probid', null, null, null, '资格预审申请文件开启记录');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0240' and step0='D0240';
if num = 0 then
--D0208
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0240', 'D0240', 1, '/bdp/pre/result/packlist.do', null, null, 'probid', 'bdid', null, null, '资格预审评审报告');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0245' and step0='D0245';
if num = 0 then
--D0209
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0245', 'D0245', 1, '/exp/bidding/buy/gkys/packlist.do', null, null, 'probid', 'bdid', null, null, '资格预审结果发布');
end if; 
------add by hejw 资格预审-代理机构-继续任务 end----

------add by hejw 发标-代理机构-继续任务 start----
delete bd_stepurl where step in ('D0401','D0402','D0403','D0404','D0405','D0406');

num:=0;
select count(1) into num from bd_stepurl where step='D0400' and step0='D0400';
if num = 0 then
--D0401
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0400', 'D0400', 1, '/exp/bidding/buy/zbwjone/toZbwjCssz.do', null, null, 'probid', 'bdid', null, null, '招标文件参数设置');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0405' and step0='D0405';
if num = 0 then
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0405', 'D0405', 1, '/exp/bidding/buy/zbwjone/topbbfpacklist.do', null, null, 'probid', 'bdid', null, null, '评标办法');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0410' and step0='D0410';
if num = 0 then
--D0402
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0410', 'D0410', 1, '/exp/bidding/buy/zbwjone/packlist.do', null, null, 'probid', 'bdid', null, null, '招标文件上传');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0415' and step0='D0415';
if num = 0 then
--D0403
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0415', 'D0415', 1, '/exp/bidding/buy/yqhs/toUpdate.do', null, null, 'probid', 'bdid', null, null, '投标邀请书发布');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0420' and step0='D0420';
if num = 0 then
--D0404
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0420', 'D0420', 1, '/exp/bidding/buy/aftfic/toPublish.do', null, null, 'probid', 'bdid', null, null, '招标公告发布');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0425' and step0='D0425';
if num = 0 then
--D0405
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0425', 'D0425', 1, '/bdp/buy/survey/notice/packlist.do', null, null, 'probid', 'bdid', null, null, '踏勘现场');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='D0430' and step0='D0430';
if num = 0 then
--D0406
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('D0430', 'D0430', 1, '/bdp/build/jury/index.do', null, null, 'probid', 'bdid', null, null, '组建评标委员会');
end if; 
------add by hejw 发标-代理机构-继续任务 end----

------add by hejw 报名-投标人-继续任务 end----
delete bd_stepurl where step in ('T0107','T0108','T0109') and url in ('/exp/bidding/sell/invitation/toConfirmYqs.do','/exp/bidding/sell/signup/zblist.do','/exp/bidding/sell/signup/hszblist.do');

num:=0;
select count(1) into num from bd_stepurl where step='T0137' and step0='T0137';
if num = 0 then
--T0107
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('T0137', 'T0137', 2, '/exp/bidding/sell/invitation/toConfirmYqs.do', null, null, 'probid', 'bdid', null, null, '邀请书确认页面');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='T0138' and step0='T0138';
if num = 0 then
--T0108
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('T0138', 'T0138', 2, '/exp/bidding/sell/signup/zblist.do', null, null, 'probid', 'bdid', null, null, '招标文件购买-预审');
end if; 

num:=0;
select count(1) into num from bd_stepurl where step='T0139' and step0='T0139';
if num = 0 then
--T0109
  insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, REMARK)
  values ('T0139', 'T0139', 2, '/exp/bidding/sell/signup/hszblist.do', null, null, 'probid', 'bdid', null, null, '招标文件购买-后审');
end if; 
------add by hejw 报名-投标人-继续任务 end----
	
	--add by chenxp start---
	num:=0;
    select count(1) into num from bd_cssz where cskey='ZBHXRGS_JSSJ';
    if num = 0 then
       insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
       values('ZBHXRGS_JSSJ','中标候选人公示开始至结束时间(开始当天不算)','3','','系统管理员','中标候选人公示开始至结束时间(开始当天不算)','1','天',4200,'中标候选人公示开始至结束时间(开始当天不算)');
    end if;
    
    num:=0;
    select count(1) into num from bd_cssz where cskey='TBWJ_JZSJ';
    if num = 1 then
       update bd_cssz set csvalue = '20',csmc='招标文件购买开始时间至投标文件截止日期(即开标日期)', remark='招标文件购买开始时间至投标文件截止日期(即开标日期)' ,csbz='招标文件购买开始时间至投标文件截止日期(即开标日期)' where cskey='TBWJ_JZSJ';
    end if;
	--add by chenxp end  ---

   num:=0;
    select count(1) into num from bd_stepurl where step='Z0705' and step0='Z0705';
    if num = 1 then
      update bd_stepurl set typ=1 where  step='Z0705' and step0='Z0705';
   end if;
   
   --add by hejw start  ---
    num:=0;
    select count(1) into num from sys_init where tname='BD_DB_ZBJGGG';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_DB_ZBJGGG',1);
    end if;
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FB_SURVEY';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FB_SURVEY',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_HZJL';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_HZJL',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_SEAL';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_SEAL',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_PACKAGE_EXT';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_PACKAGE_EXT',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_WS_TASK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_WS_TASK',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_WS_TASK_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_WS_TASK_BAK',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TSSL';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TSSL',1);
    end if; 
    
    --继续任务标识表-不要清 
    num:=0;
    select count(1) into num from sys_init where tname='BD_STEPURL';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_STEPURL',0);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_BILLCHECK_LIST';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_BILLCHECK_LIST',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_TD_DD_MX';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_TD_DD_MX',1);
    end if;   
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_EVALUATION';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_EVALUATION',1);
    end if;   
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_FILES_HTTP';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_FILES_HTTP',1);
    end if;  
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_NODE_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_NODE_BAK',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_TK_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_TK_BAK',1);
    end if; 
    
    num:=0;
    select count(1) into num from sys_init where tname='BD_MB_PBMB_TK_MX_BAK';
    if num=0 then
        insert into sys_init (tname,flag) values('BD_MB_PBMB_TK_MX_BAK',1);
    end if; 

   --add by hejw end  ---

 num:=0;
    select count(1) into num from bd_cssz where cskey='JMJ_CERTDATA';
    if num = 0 then
    INSERT INTO "BD_CSSZ" ("CSKEY", "CSMC", "CSVALUE", "MRZ", "OPT", "REMARK", "FLAG0", "ORDERNO", "CSBZ") 
	VALUES ('JMJ_CERTDATA', '加密机加解密证书', 'MIICyzCCAm6gAwIBAgIFEAMYKZUwDAYIKoEcz1UBg3UFADBcMQswCQYDVQQGEwJDTjEwMC4GA1UECgwnQ2hpbmEgRmluYW5jaWFsIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MRswGQYDVQQDDBJDRkNBIFRFU1QgU00yIE9DQTEwHhcNMTYwOTIzMDMwMTIwWhcNMTgwOTIzMDMwMTIwWjCBgjELMAkGA1UEBhMCQ04xGTAXBgNVBAoMEENGQ0EgU00yIFRFU1QgQ0ExETAPBgNVBAsMCExvY2FsIFJBMRkwFwYDVQQLDBBPcmdhbml6YXRpb25hbC0xMSowKAYDVQQDDCEwNTFA5Yqg5a+G5py66K+B5LmmQFo4ODg2NjY5OTlAMTAwWTATBgcqhkjOPQIBBggqgRzPVQGCLQNCAATTVNh057nyVBcCNqwPUcy2oOn2DU3/TfMcgdHeMS6znsabFgKedf5DZS8ZVVV2Z5Qc5sI8kp/Dod0ZHauonKfXo4HzMIHwMB8GA1UdIwQYMBaAFGv+GNqPQjqmuG2zLoiDOjSiwTDhMEgGA1UdIARBMD8wPQYIYIEchu8qAQEwMTAvBggrBgEFBQcCARYjaHR0cDovL3d3dy5jZmNhLmNvbS5jbi91cy91cy0xNC5odG0wOAYDVR0fBDEwLzAtoCugKYYnaHR0cDovL3VjcmwuY2ZjYS5jb20uY24vU00yL2NybDEwMDAuY3JsMAsGA1UdDwQEAwID6DAdBgNVHQ4EFgQUhkrEInSwXRSsXyvVqY0Ri3vc9s8wHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGCCqBHM9VAYN1BQADSQAwRgIhAM55AkYB5wXeGay5e4iWmZkyOb9qb6nQy9kmJaDKiUryAiEA14BfSG23FVxstB4Bwsct86E6EVN0neIsDO4OXPY2M0o=', NULL, '系统管理员', '加密机加解密证书（不要随意修改）', '1', '4300', '加密机加解密证书（不要随意修改）');
  end if;
  
   num:=0;
    select count(1) into num from bd_cssz where cskey='JMJ_KEYID';
    if num = 0 then
    INSERT INTO "BD_CSSZ" ("CSKEY", "CSMC", "CSVALUE", "MRZ", "OPT", "REMARK", "FLAG0", "ORDERNO", "CSBZ") 
	VALUES ('JMJ_KEYID', '加密机加解密KEY序号', '2', NULL, '系统管理员', '加密机加解密KEY序号（不要随意修改）', '1', '4400', '加密机加解密KEY序号（不要随意修改）');
  end if;
  
  
  	--add by chenxp start---
	num:=0;
    select count(1) into num from bd_stepurl where step='Z0803';
    if num = 1 then
         update bd_stepurl set url = '/exp/bidding/buy/contract/audit/list.do' where step='Z0803';
    end if;
    
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0804';
    if num = 1 then
         update bd_stepurl set url = '/exp/bidding/buy/contract/execute/list.do' where step='Z0804';
    end if;
  	--add by chenxp end  ---
	
----add by xuz start---

  num:=0;
    select count(1) into num from bd_cssz where cskey='ZGYSYYTJSJ';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('ZGYSYYTJSJ','资格预审文件异议可提交时间','2','','系统管理员','资格预审申请文件递交截止时间前','1','天',4000,'资格预审申请文件递交截止时间前');
  end if;
  
  num:=0;
    select count(1) into num from bd_cssz where cskey='ZBWJYYTJSJ';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('ZBWJYYTJSJ','招标文件异议可提交时间','10','','系统管理员','投标文件递交截止时间前','1','天',4100,'投标文件递交截止时间前');
  end if;
  
  num:=0;
    select count(1) into num from bd_cssz where cskey='KBYYTJSJ';
    if num = 0 then
      insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz) 
     values('KBYYTJSJ','开标异议可提交时间','5','','系统管理员','开标后-分钟之内','1','分钟',4200,'开标后-分钟之内');
  end if;
----add by xuz end----

----add by hejw start----------
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0901';
    if num = 0 then
      insert into bd_stepurl(step, step0, typ, url, str03) 
     values('Z0901', 'Z0901', 1, '/exp/bidding/buy/evaluate/evalExpert.do', 'probid');
  end if;
  
   num:=0;
    select count(1) into num from bd_stepurl where step='D0901';
    if num = 0 then
      insert into bd_stepurl(step, step0, typ, url, str03) 
     values('D0901', 'D0901', 1, '/exp/bidding/buy/evaluate/evalExpert.do', 'probid');
  end if;
  
   num:=0;
    select count(1) into num from bd_stepurl where step='T0701';
    if num = 0 then
      insert into bd_stepurl(step, step0, typ, url, str03) 
     values('T0701', 'T0701', 2, '/exp/bidding/sell/evaluate/evalTenderer.do', 'probid');
  end if;  
----add by hejw end----------
	
	--add by chenxp start --
	num:=0;
    select count(1) into num from bd_stepurl where step='T0604';
    if num = 0 then
      insert into bd_stepurl (STEP, STEP0, TYP, URL, STR01, STR02, STR03, STR04, STR05, STR06, remark)
      values ('T0604', 'T0604', 2, '/exp/bidding/sell/contract/execute/list.do', null, null, 'probid', 'bdid', null, null, '合同履约');
    end if;  
    
    num:=0;
    select count(1) into num from bd_stepurl where step='T0603';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/sell/contract/audit/list.do'  where step='T0603' and step0='T0603';
    end if;
	--add by chenxp end   --

    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  