DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.6'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	------------2016/07/11 hanglong 支付申请记录初始化表 start--------------
	num:=0;
	tmp1:=upper('BD_PAY_REQUEST');
	select count(1) into num from sys_init where TNAME=tmp1;
	if num = 0 then
		insert into sys_init(TNAME, flag)
		values(tmp1,1);
	end if;
	------------2016/07/11 hanglong 支付申请记录初始化表 end--------------

	------------2016/07/11 hanglong 支付申请记录单据号生成规则 start--------------
	num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key='BD_PAY_REQUEST';
    if num=0 then
        insert into bd_value (gid,key,value,remark,defaultvalue)
        values('RunTime','BD_PAY_REQUEST','1', '支付申请记录单据号生成规则', '1');
    end if;
    ------------2016/07/11 hanglong 支付申请记录单据号生成规则 end--------------

  ------------2016/07/11 jinyanhui 继续任务节点跳转路径 start-------------- 	
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
    select count(1) into num from bd_stepurl where step='Z0210' and step0='Z0210';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0210','Z0210','1','/bdp/bidding/buy/preficfile/toconfirmpacklist.do','','','probid','','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0301' and step0='Z0301';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0301','Z0301','1','/exp/bidding/buy/yqhs/hsPackList.do','','','probid','','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0302' and step0='Z0302';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0302','Z0302','1','/exp/bidding/buy/yqhs/toEdit.do','','','probid','','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0303' and step0='Z0303';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0303','Z0303','1','/exp/bidding/buy/aftfic/index.do','','','probid','','','');
   end if;
    
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0401' and step0='Z0401';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0401','Z0401','1','/exp/bidding/buy/zbwjone/toZbwjCssz.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0402' and step0='Z0402';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0402','Z0402','1','/exp/bidding/buy/zbwjone/packlist.do','','','probid','bdid','','');
   end if;  

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0403' and step0='Z0403';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0403','Z0403','1','/exp/bidding/buy/zbwjone/toconfirmpacklist.do','','','probid','bdid','','');
   end if; 


    num:=0;
    select count(1) into num from bd_stepurl where step='Z0404' and step0='Z0404';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0404','Z0404','1','/exp/bidding/buy/aftfic/toPublish.do','','','probid','bdid','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0405' and step0='Z0405';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0405','Z0405','1','/exp/bidding/buy/yqhs/toUpdate.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0406' and step0='Z0406';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0406','Z0406','1','/bdp/buy/survey/notice/packlist.do','','','probid','bdid','','');
   end if; 
   
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0407' and step0='Z0407';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0407','Z0407','1','/bdp/build/jury/index.do','','','probid','bdid','','');
   end if; 
   
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0501' and step0='Z0501';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0501','Z0501','1','/exp/bidding/buy/kb/kbPackList.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0502' and step0='Z0502';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0502','Z0502','1','/exp/bidding/buy/kb/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0601' and step0='Z0601';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0601','Z0601','1','/bdp/review/result/packlist.do','','','probid','bdid','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0602' and step0='Z0602';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0602','Z0602','1','/bdp/mtcfee/expert/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0701' and step0='Z0701';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0701','Z0701','1','/exp/bidding/buy/scaling/listzb.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0702' and step0='Z0702';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0702','Z0702','1','/exp/bidding/buy/scaling/listdb.do','','','probid','bdid','','');
   end if;    
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0703' and step0='Z0703';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0703','Z0703','1','/exp/bidding/buy/scaling/listjg.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0704' and step0='Z0704';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0704','Z0704','1','/exp/bidding/buy/scaling/listgg.do','','','probid','bdid','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='Z0801' and step0='Z0801';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0801','Z0801','1','/exp/bidding/buy/contract/bidbond/list.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0802' and step0='Z0802';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0802','Z0802','1','/exp/bidding/buy/contract/packageList.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0803' and step0='Z0803';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0803','Z0803','1','/exp/bidding/buy/contract/execute/list.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0804' and step0='Z0804';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0804','Z0804','1','/exp/bidding/buy/contract/audit/list.do','','','probid','bdid','','');
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
      values('T0106','T0106','2','/exp/bidding/sell/signup/toZbggInfo.do','','','probid','bdid','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='T0107' and step0='T0107';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0107','T0107','2','/exp/bidding/sell/invitation/toConfirmYqs.do','','','probid','bdid','','');
   end if;
  
    num:=0;
    select count(1) into num from bd_stepurl where step='T0108' and step0='T0108';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0108','T0108','2','/exp/bidding/sell/signup/zblist.do','','','probid','bdid','','');
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

    num:=0;
    select count(1) into num from bd_stepurl where step='D0101' and step0='D0101';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0101','D0101','3','/exp/bidding/buy/subproject/wtxybz.do','','','probid','','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0102' and step0='D0102';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0102','D0102','3','/exp/bidding/buy/beingPro/editwtxy.do','','','probid','','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='D0103' and step0='D0103';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0103','D0103','3','/exp/bidding/buy/beingPro/editwtxy.do','','','probid','','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0104' and step0='D0104';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0104','D0104','3','/exp/bidding/buy/package/list.do','','','probid','','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0201' and step0='D0201';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0201','D0201','1','/exp/bidding/buy/prefic/index.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0202' and step0='D0202';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0202','D0202','1','/exp/bidding/buy/prefic/toZgysCssz.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0203' and step0='D0203';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0203','D0203','1','/bdp/bidding/buy/preficfile/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0204' and step0='D0204';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0204','D0204','1','/exp/bidding/buy/prefic/view.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0205' and step0='D0205';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0205','D0205','1','/bdp/build/pre/jury/index.do','','','probid','bdid','','');
   end if;
    
    num:=0;
    select count(1) into num from bd_stepurl where step='D0206' and step0='D0206';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0206','D0206','1','/exp/bidding/buy/ysopen/ysPackList.do','','','probid','bdid','','');
   end if;  
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0208' and step0='D0208';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0208','D0208','1','/bdp/pre/result/packlist.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0209' and step0='D0209';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0209','D0209','1','/exp/bidding/buy/gkys/packlist.do','','','probid','bdid','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0301' and step0='D0301';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0301','D0301','1','/exp/bidding/buy/yqhs/hsPackList.do','','','probid','','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='D0302' and step0='D0302';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0302','D0302','1','/exp/bidding/buy/yqhs/toEdit.do','','','probid','','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0303' and step0='D0303';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0303','D0303','1','/exp/bidding/buy/aftfic/index.do','','','probid','','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='D0401' and step0='D0401';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0401','D0401','1','/exp/bidding/buy/zbwjone/toZbwjCssz.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0402' and step0='D0402';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0402','D0402','1','/exp/bidding/buy/zbwjone/packlist.do','','','probid','bdid','','');
   end if;  

    num:=0;
    select count(1) into num from bd_stepurl where step='D0403' and step0='D0403';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0403','D0403','1','/exp/bidding/buy/yqhs/toUpdate.do','','','probid','bdid','','');
   end if; 

    num:=0;
    select count(1) into num from bd_stepurl where step='D0404' and step0='D0404';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0404','D0404','1','/exp/bidding/buy/aftfic/toPublish.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0405' and step0='D0405';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0405','D0405','1','/bdp/buy/survey/notice/packlist.do','','','probid','bdid','','');
   end if; 
   
   num:=0;
    select count(1) into num from bd_stepurl where step='D0406' and step0='D0406';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0406','D0406','1','/bdp/build/jury/index.do','','','probid','bdid','','');
   end if; 

   num:=0;
    select count(1) into num from bd_stepurl where step='D0501' and step0='D0501';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0501','D0501','1','/exp/bidding/buy/kb/kbPackList.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0502' and step0='D0502';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0502','D0502','1','/exp/bidding/buy/kb/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0601' and step0='D0601';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0601','D0601','1','/bdp/review/result/packlist.do','','','probid','bdid','','');
   end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='D0602' and step0='D0602';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0602','D0602','1','/bdp/mtcfee/expert/packlist.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0701' and step0='D0701';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0701','D0701','1','/exp/bidding/buy/scaling/listzb.do','','','probid','bdid','','');
   end if; 
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0702' and step0='D0702';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0702','D0702','1','/exp/bidding/buy/scaling/listdb.do','','','probid','bdid','','');
   end if;    
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0703' and step0='D0703';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0703','D0703','1','/exp/bidding/buy/scaling/listjg.do','','','probid','bdid','','');
   end if;
   
    num:=0;
    select count(1) into num from bd_stepurl where step='D0704' and step0='D0704';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0704','D0704','1','/exp/bidding/buy/scaling/listgg.do','','','probid','bdid','','');
   end if; 

  	------------2016/07/11 jinyanhui 继续任务节点跳转路径 end--------------  	
	-- bd_cssz 报名是否确认
	num:=0;
	select count(1) into num from bd_cssz where cskey='ISCONFIRM' and csmc='报名是否确认';
	if num = 0 then
	insert into bd_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz)
	 values('ISCONFIRM','报名是否确认','0','0','系统管理员','0-不需要审核，1-需要审核价',1,'',3100,'0-不需要审核，1-需要审核');
	end if;

    num:=0;
    select count(1) into num from bd_stepurl where step='T0109' and step0='T0109';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('T0109','T0109','2','/exp/bidding/sell/signup/hszblist.do','','','probid','bdid','','');
   end if; 	
   
    num:=0;
    select count(1) into num from bd_stepurl where step='Z0705' and step0='Z0705';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0705','Z0705','2','/exp/bidding/buy/scaling/confirmList.do','','','probid','bdid','','');
   end if;       
   
     num:=0;
	select count(1) into num from bd_stepurl where step='D0101' and step0='D0101';  
	if num = 1 then
		update bd_stepurl set url='/exp/bidding/buy/beingPro/viewEntrust.do' where step='D0101' and step0='D0101' and url='/exp/bidding/buy/subproject/wtxybz.do';
	end if; 
	
   num:=0;
    select count(1) into num from bd_stepurl where step='Z0103' and step0='Z0103';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0103','Z0103','2','/exp/bidding/buy/subproject/wtxybz.do','','','probid','','','');
   end if;  
   
   num:=0;
    select count(1) into num from bd_stepurl where step='D0103' and step0='D0103';
    if num = 1 then
      update bd_stepurl set url='/exp/bidding/buy/subproject/list.do' where step='D0103' and step0='D0103' and url='/exp/bidding/buy/beingPro/editwtxy.do';
   end if;  
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0705' and step0='Z0705';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0705','Z0705','1','/exp/bidding/buy/scaling/confirmList.do','','','probid','','','');
   end if;  
   
   
     num:=0;
    select count(1) into num from bd_stepurl where step='Z0207' and step0='Z0207';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('Z0207','Z0207','1','/exp/bidding/buy/ysopen/ysjlPackList.do','','','probid','','','');
   end if;  
   
        num:=0;
    select count(1) into num from bd_stepurl where step='D0207' and step0='D0207';
    if num = 0 then
      insert into bd_stepurl(step,step0,typ,url,str01,str02,str03,str04,str05,str06) 
      values('D0207','D0207','1','/exp/bidding/buy/ysopen/ysjlPackList.do','','','probid','','','');
   end if; 
   
      num:=0;
    select count(1) into num from bd_stepurl where step='Z0101' and step0='Z0101';
    if num = 1 then
      update bd_stepurl set str03='probid' where step='Z0101' and step0='Z0101' ;
   end if; 
   
   ---add by xuz start---
	num:=0;
    select count(1) into num from bd_cssz where cskey='ZBYC_SFSH';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('ZBYC_SFSH','招标异常是否审核','1','系统管理员','招标异常是否审核 0-不审核 1-审核',1,'',3000,'招标异常是否审核 0-不审核 1-审核');
	end if;
   ---add by xuz end---
            	        
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  