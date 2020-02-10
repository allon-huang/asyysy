DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.69'; -- 本升级文件的版本，每个升级文件必须修改
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
	

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M01122080' and mid='M0112' and styp=1 and sid='M00201' and parent='M011220';
	if num =0 then
		insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp,parent, sid)
      values('M01122080','M0112','销售订单','确认开票','','',2,200,1,'M011220','M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M011220' and mid='M0112' and styp=1 and sid='M00201';
	if num =1 then
		update bs_qxsz set inurl=inurl||'/exp/contract/sell/manage/toDpqr.do#' where mkid='M011220' and mid='M0112' and styp=1 and sid='M00201';
	end if;
	

	num :=0;
	select count(1) into num from bs_cssz where cskey='MOBILE';
	if num =0 then
		insert into bs_cssz(cskey, csmc, csvalue, mrz, opt, remark, flag0,orderno)
		values('MOBILE','平台手机号码','','','系统管理员','平台手机号码',1,900);
	end if;

	
	num :=0;
	select count(1) into num from bs_cssz where cskey='MAIL';
	if num =0 then
		insert into bs_cssz(cskey, csmc, csvalue, mrz, opt, remark, flag0,orderno)
		values('MAIL','平台邮箱','','','系统管理员','平台邮箱',1,1000);
	end if;
    
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

