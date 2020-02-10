DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.15'; -- 本升级文件的版本，每个升级文件必须修改
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
    --增加集团报表导出权限 by zhuchunhong 2014-01-05
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M022525' and sid='M00004' and action='/tdp/report/deliverDtl' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022525', '/tdp/report/deliverDtl', 'exportExcel', 2, '集团报表-交货明细报表-导出', 1, 'M00004');
    END IF;
     num:=0;
	select count(1) into num from bs_qxmx where mkid='M022550' and sid='M00004' and action='/tdp/report/sendDtl' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022550', '/tdp/report/sendDtl', 'exportExcel', 2, '集团报表-发货明细报表-导出', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M022555' and sid='M00004' and action='/tdp/report/receiveDtl' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022555', '/tdp/report/receiveDtl', 'exportExcel', 2, '集团报表-到货报表明细-导出', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M022560' and sid='M00004' and action='/tdp/report/warehouseDtl' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022560', '/tdp/report/warehouseDtl', 'exportExcel', 2, '集团报表-入库明细报表-导出', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M022565' and sid='M00004' and action='/tdp/report/payInfo' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022565', '/tdp/report/payInfo', 'exportExcel', 2, '集团报表-支付明细报表-导出', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M022515' and sid='M00004' and action='/tdp/report/pccontractMx' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022515', '/tdp/report/pccontractMx', 'exportExcel', 2, '集团报表-合同明细报表-导出', 1, 'M00004');
    END IF;
    num:=0;
	select count(1) into num from bs_qxmx where  mkid='M022575' and sid='M00004' and action='/tdp/report/perfrom' and method='exportExcel';       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M022575', '/tdp/report/perfrom', 'exportExcel', 2, '集团报表-执行情况报表-导出', 1, 'M00004');
    END IF;
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='9';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','9','生产商',1,'100',0,1);
    END IF;
	
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='10';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','10','代理商',1,'100',0,1);
    END IF;
	
    num:=0;
    select count(1) into num from bs_codes where typ='企业类型' and code='11';       
    if num = 0 then 
		insert into bs_codes(typ,code,value,isuse,orderno,iscanset,disflag0)
		values('企业类型','11','物流商',1,'100',0,1);
    END IF;
	
	update bs_qxsz set inurl='/tdp/dev/project/index.do#/tdp/dev/scheme/index.do#/tdp/dev/scheme/add.do#/tdp/dev/scheme/toAnnouncement.do#/tdp/dev/package/index.do#/tdp/dev/package/add.do#/tdp/dev/package/chooosePbzj.do#/tdp/dev/package/zgys.do#/tdp/dev/package/zghs.do#/tdp/dev/package/anwser.do#/tdp/dev/package/kbinfo.do#/tdp/dev/package/secondbid.do#/tdp/dev/package/quote.do#/tdp/dev/package/add.do#/tdp/dev/package/scoreList.do#/tdp/dev/package/score.do' where mkid='M010515' and sid='M00004';

	
	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  