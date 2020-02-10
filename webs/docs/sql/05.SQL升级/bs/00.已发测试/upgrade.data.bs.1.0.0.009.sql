DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.9'; -- 本升级文件的版本，每个升级文件必须修改
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
    --下载合同附件 add by zhuchunhong 2013-01-02
    select count(1) into num from bs_qxmx where  mkid='M01300120' and sid='M00004' and action='/tdp/trail/pccontract' and method='downLoad';
    if num = 0 then
  insert into bs_qxmx values(bs_qxmx_0.nextval,'M01300120','/tdp/trail/pccontract','downLoad',2,'下载附件',1,'M00004');
    end if;



    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M01350505' and sid='M00004' and action='/tdp/trail/deliver' and method='exportExcel';
    if num = 0 then
  insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M01350505', '/tdp/trail/deliver', 'exportExcel', 2, '合同跟踪-交货登记-导出', 1, 'M00004');
    end if;
    

	select count(1) into num from bs_qxmx where  mkid='0' and sid='M00004' and action='/tdp/common/index' and method='paclist';
    if num = 0 then
	insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid) values(bs_qxmx_0.nextval,'0','/tdp/common/index','paclist',0,'下载附件',1,'M00004');
    end if;
	
    UPDATE BS_QXSZ SET ISUSE=0 WHERE MKID='B011515' AND SID='B00004';
    -------------------------------------------------------------
  -- add 增加销售订单，物流跟踪权限 by zhangsiwei on 20140102
  num := 0;
  select count(1) into num from bs_qxmx where mkid='M011225' and sid='M00201' and action='/exp/entrust/sell/manage' and method='list';
  if num = 0 then 
    insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid) values('M011225','/exp/entrust/sell/manage','list',2,'网上超市委托：列表',1,'M00201');
  end if;

  num := 0;
  select count(1) into num from bs_qxsz where mkid='M011225' and mid='M0112' and sid='M00201';
  if num = 0 then 
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
    values('M011225','M0112','销售订单','物流跟踪','/exp/entrust/sell/manage/list.do','/exp/entrust/sell/manage/list.do#',1,400,1,'M00201');
  end if;
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  