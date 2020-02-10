DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.3'; -- 本升级文件的版本，每个升级文件必须修改
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
    -- add 商品预览的时候,未上架高亮 by zhangsiwei on 20131226
   

    --dl 2013-12-17 询比价
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='category' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017010','/exp/querybusiness/buy','category',2,'类目选择',1,'M00004');
  end if;
  
  num :=0;
      select count(1) into num from bs_qxmx where action='/exp/querybusiness/buy' and method='getCategory' and sid='M00004';
      if num = 0 then
      insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
      values(bs_qxmx_0.nextval,'M017010','/exp/querybusiness/buy','getCategory',2,'新增场次（卖）：(AJAX)获取类目',1,'M00004');
  end if;
  -------------------------------------------------------------
  --费用登记 add by gyp 20131227
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M022005' and mid='M0220' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxsz values('M022005','M0220','费用管理','费用登记','/tdp/fee/manager/list.do','/tdp/fee/manager/list.do#/tdp/fee/manager/toEdit.do',1,100,1,'','M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxsz where mkid='M02200505' and mid='M0220' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxsz values('M02200505','M0220','费用管理','编辑','','',2,200,1,'M022005','M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where mkid='M022005' and styp=1 and sid='M00004' and method='list';
  if num=0 then
  insert into bs_qxmx values(bs_qxmx_0.nextval,'M022005','/tdp/fee/manager','list',2,'费用登记列表',1,'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where mkid='M02200505' and styp=1 and sid='M00004' and method='toEdit';
  if num=0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M02200505','/tdp/fee/manager','toEdit',2,'进入费用编辑页面',1,'M00004');
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where mkid='M02200505' and styp=1 and sid='M00004' and method='save';
  if num=0 then
   insert into bs_qxmx values(bs_qxmx_0.nextval,'M02200505','/tdp/fee/manager','save',2,'保存费用',1,'M00004');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where mkid='M02200505' and styp=1 and sid='M00004' and method='delete';
  if num=0 then
  insert into bs_qxmx values(bs_qxmx_0.nextval,'M02200505','/tdp/fee/manager','delete',2,'费用删除',1,'M00004');
  end if;

  -------------------------------------------------------------
  --招标物资代码 add by songb 20131227
  num:=0;
  select count(1) into num from bs_qxmx where action='/admin/public/item' and method='getPzList' and styp=2 and sid='B00004';
  if num=0 then
  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
  values(bs_qxmx_0.nextval,'0','/admin/public/item','getPzList',1,'获得品种列表AJAX',2,'B00004');
  end if;

  num:=0;
  select count(1) into num from bs_qxmx where action='/admin/public/item' and method='hasChild' and styp=2 and sid='B00004';
  if num=0 then
  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
  values(bs_qxmx_0.nextval,'0','/admin/public/item','hasChild',1,'获得品种列表AJAX',2,'B00004');
  end if;
  
  
  num:=0;
  select count(1) into num from bs_codes where typ='供应商企业类型' and code='生产商';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('供应商企业类型','生产商','生产商',1,1,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='供应商企业类型' and code='代理商';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('供应商企业类型','代理商','代理商',1,2,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='供应商企业类型' and code='物流商';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('供应商企业类型','物流商','物流商',1,3,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='国有企业';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','国有企业','国有企业',1,1,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='外资企业';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','外资企业','外资企业',1,2,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='股份合作公司';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','股份合作公司','股份合作公司',1,3,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='集体企业';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','集体企业','集体企业',1,4,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='私营企业';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','私营企业','私营企业',1,5,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='股份有限公司';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','股份有限公司','股份有限公司',1,6,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='有限责任公司';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','有限责任公司','有限责任公司',1,7,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='联营企业';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','联营企业','联营企业',1,8,1);
  end if;
  
  num:=0;
  select count(1) into num from bs_codes where typ='企业性质' and code='其他类型';
  if num=0 then
    insert into bs_codes(typ,code,value,isuse,orderno,iscanset)
    values('企业性质','其他类型','其他类型',1,9,1);
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where action = '/me/groupreport/home' and method = 'index' and styp=1  and sid ='M00004';
  if num=0 then
  insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
  values (3910, '0', '/me/groupreport/home', 'index', 1, '我的平台(集团报表)', 1, 'M00004');
  end if;
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  