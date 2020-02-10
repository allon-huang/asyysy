DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.1.3'; -- 本升级文件的版本，每个升级文件必须修改
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
  --2018-06-07 --- 2018-07-27

	------------add by zhaoy 2018年06月07日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdm/prefic' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011005','/bdm/prefic','download',2,'后台预审审核下载附件','2','B00008');
    end if;
	------------add by wangzh 2018年06月07日 end---------------

------------add by wangzh 2018年06月25日 start---------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdm/expertZj' and method='delete' and sid = 'B00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)   
		values('B010520','/bdm/expertZj','delete',2,'彻底删除专家',2,'B00008');
    end if;
	------------add by wangzh 2018年06月25日 end---------------


	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
