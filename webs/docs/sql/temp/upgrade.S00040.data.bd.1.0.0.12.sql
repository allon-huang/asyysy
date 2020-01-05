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
    ------------add by hejw 2018年04月11日 start---------------
   num:=0;
      select count(1) into num from bd_value where gid='SYSTEM' and key='PLATFORM_BACK_MARGIN';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('SYSTEM','PLATFORM_BACK_MARGIN','0','前台-是否开启退还保证金等功能  0-关闭','','2');
      end if;

         num:=0;
      select count(1) into num from bd_value where gid='SYSTEM' and key='MANAGER_BACK_REFUND';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('SYSTEM','MANAGER_BACK_REFUND','0','后台-是否开启退款功能  0-关闭','','2');
      end if;

         num:=0;
      select count(1) into num from bd_value where gid='SYSTEM' and key='PLATFORM_BACK_ONLINE_PAYMENT';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('SYSTEM','PLATFORM_BACK_ONLINE_PAYMENT','0','前台-是否开启线上支付 0-关闭','','2');
      end if;
    ------------add by hejw 2018年04月11日 end---------------

	------------add by zhaoy 2018年05月23日 start---------------
 	num:=0;
	  	select count(1) into num from bd_value where gid='SYSTEM' and key='ZBWJ_FILENAME_VALIDATION';
	  	if num = 0 then
	      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
	      values('SYSTEM','ZBWJ_FILENAME_VALIDATION','1','前台-是否开启招标文件名匹配验证','','2');
	 	end if;
	------------add by zhaoy 2018年05月23日 end---------------

	------------add by zhaoy 2018年05月28日 start---------------
 	num:=0;
	  	select count(1) into num from bd_value where gid='SYSTEM' and key='IS_GUARANTEE_PAYMENT';
	  	if num = 0 then
	      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
	      values('SYSTEM','IS_GUARANTEE_PAYMENT','1','前台-是否开启保函支付(1开启)','','2');
	 	end if;
	------------add by zhaoy 2018年05月28日 end---------------



------------add by nieche 2018年05月30日 start---------------
    --bd_fb_zbcssz    tbyxqts 字段长度从2改成4
    -- 增加 tbyxqts_tmp
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 0 then
  execute immediate 'alter table '||tmp1||' add('||tmp2||' NUMBER(4))';
  end if;
-- 赋值 tbyxqts_tmp
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts_tmp');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set tbyxqts_tmp = tbyxqts';
  end if;
-- 清空 tknr
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
  if num = 1 then
  execute immediate 'update '||tmp1||' set tbyxqts=null';
  end if;
-- 修改 tknr
  tmp1:=upper('bd_fb_zbcssz');
  tmp2:=upper('tbyxqts');
  num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' modify ('||tmp2||' NUMBER(4))';
	end if;
-- 赋值 tknr
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('tbyxqts');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'update '||tmp1||' set tbyxqts = tbyxqts_tmp';
	end if;
-- 删除 tbyxqts_tmp
	tmp1:=upper('bd_fb_zbcssz');
	tmp2:=upper('tbyxqts_tmp');
	num:=0; -- 注意：查询前必须初始化此变量
	select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
	if num = 1 then
	execute immediate 'alter table '||tmp1||' DROP COLUMN '||tmp2||' ';
	end if;
	------------add by nieche 2018年05月30日 end---------------

    -----2018-06-20 17:40 start hejw -----
      num:=0;
      select count(1) into num from bd_value where gid='BD_BANK_CONFIG' and key='BANK_BKID';
      if num = 0 then
          insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
          values('BD_BANK_CONFIG','BANK_BKID','01','银行编号 01-中信   03-民生','','2');
      end if;
    -----2018-06-20 17:40 end hejw -----

	------------add by zhaoy 2018年11月26日 start---------------
 	num:=0;
	  	select count(1) into num from bd_value where gid='SYSTEM' and key='IS_GUARANTEE_PAYMENT_TBBZJ';
	  	if num = 0 then
	      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
	      values('SYSTEM','IS_GUARANTEE_PAYMENT_TBBZJ','1','前台-是否开启投标保证金保函支付(1开启)','','2');
	 	end if;
	------------add by zhaoy 2018年11月26日 end---------------
	------------add by zhaoy 2018年11月28日 start---------------
 	num:=0;
	  	select count(1) into num from bd_value where gid='DATABASE_USER_NAME' and key='BS';
	  	if num = 0 then
	      insert into bd_value(gid,key,value,remark,defaultvalue,csflag)
	      values('DATABASE_USER_NAME','BS','htbsdb','数据库用户名-不要出现空格','bsdb','0');
	 	end if;
	------------add by zhaoy 2018年11月28日 end---------------


	  -----2019-02-26 11:31 start huangyaoyu -----
	  num:=0;
	  select count(1) into num from BD_AUTO_TASK where TASKID='AutoAerospaceQueue.autoAppQueue' and RUNTYP=1 and REMARK='中国航天采购平台招投标对接手机APP接口-定时任务' ;
	  if num = 0 then
	      insert into BD_AUTO_TASK(TASKID,RUNTYP,IP, SERVERNAME,REMARK)
	      values('AutoAerospaceQueue.autoAppQueue',1,'','bd','中国航天采购平台招投标对接手机APP接口-定时任务');
	  end if;
	  -----2019-02-26 11:31 end huangyaoyu -----

	  -----2019-06-18 11:31 start huangyaoyu -----
	  num:=0;
	  select count(1) into num from BD_AUTO_TASK where TASKID='AutoAerospaceQueue.autoQianLiMaQueue' and RUNTYP=1 and REMARK='中国航天采购平台招投标（千里马）接口-定时任务' ;
	  if num = 0 then
	      insert into BD_AUTO_TASK(TASKID,RUNTYP,IP, SERVERNAME,REMARK)
	      values('AutoAerospaceQueue.autoQianLiMaQueue',1,'','bd','中国航天采购平台招投标（千里马）接口-定时任务');
	  end if;
	  -----2019-06-18 11:31 end huangyaoyu -----


	 -----2019-09-03 11:17 start huangyaoyu -----
	  num:=0;
	  select count(1) into num from BD_AUTO_TASK where TASKID='AutoJcwQueue.autoJcwNoticeQueue' and RUNTYP=1 and REMARK='中国航天采购平台招投标-对接军采网-公告-定时任务' ;
	  if num = 0 then
	      insert into BD_AUTO_TASK(TASKID,RUNTYP,IP, SERVERNAME,REMARK)
	      values('AutoJcwQueue.autoJcwNoticeQueue',1,'','bd','中国航天采购平台招投标-对接军采网-公告-定时任务');
	  end if;
	  -----2019-09-03 11:17 end huangyaoyu -----

	------------add by huangyaoyu 2019年09月09日 start-------------
 	  num:=0;
      select count(1) into num from bd_cssz where cskey='JCW_CREATOR_NAME';   
      if num = 0 then
         insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,unit,orderno,csbz)
         values('JCW_CREATOR_NAME','军采网创建人用户名','xzcjgcs', '','元茂管理员','军采网创建人用户名',1,'小时', 7600,'军采网创建人用户名');
      end if;
	------------add by huangyaoyu 2019年09月09日 end-------------


	------------add by huangyaoyu 2019年09月19日 start-----初始化-采购领域-------
	 	num:=0;
	    select count(1) into num from bd_codes where typ='常用代码类别' and code='采购领域';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('常用代码类别','采购领域','采购领域', 1, 110, 1);
	    end if;
	------------add by huangyaoyu 2019年09月19日 end-------初始化-采购领域------


	------------add by huangyaoyu 2019年09月24日 start-------初始化-采购领域------
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='办公用品及营具';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','办公用品及营具','办公用品及营具', 1, 1, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='固定资产';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','固定资产','固定资产', 1, 2, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='民用产业产品外协外包';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','民用产业产品外协外包','民用产业产品外协外包', 1, 3, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='民用产业服务外协外包';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','民用产业服务外协外包','民用产业服务外协外包', 1, 4, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='民用产业工序外协外包';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','民用产业工序外协外包','民用产业工序外协外包', 1, 5, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='民用产业物资';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','民用产业物资','民用产业物资', 1, 6, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='生产保障物资';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','生产保障物资','生产保障物资', 1, 7, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='服务';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','服务','服务', 1, 8, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='型号物资';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','型号物资','型号物资', 1, 9, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='型号外协外包';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','型号外协外包','型号外协外包', 1, 10, 1);
	    end if;
	 	num:=0;
	    select count(1) into num from bd_codes where typ='采购领域' and code='其他';
	    if num=0 then
	        insert into bd_codes (typ,code,value,isuse,orderno,iscanset)
	        values('采购领域','其他','其他', 1, 11, 1);
	    end if;
	------------add by huangyaoyu 2019年09月24日 end---------初始化-采购领域----

	------------add by huangyaoyu 2019年10月30日 end-----军采网创建人用户名--------

		num:=0;
	    select count(1) into num from bd_cssz where cskey='JCW_CREATOR_NAME';
	    if num = 1 then
	       update bd_cssz set unit = '',flag1=1 where cskey='JCW_CREATOR_NAME' and csmc = '军采网创建人用户名';
    	end if;
    ------------add by huangyaoyu 2019年10月30日 end-----军采网创建人用户名----

         
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;
