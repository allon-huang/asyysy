DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.25'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxmx where action='/tdp/report/pccontractMx' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022515', '/tdp/report/pccontractMx', 'showInfo', 2, '集团报表-合同明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/deliverDtl' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022525', '/tdp/report/deliverDtl', 'showInfo', 2, '集团报表-交货明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/sendDtl' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022550', '/tdp/report/sendDtl', 'showInfo', 2, '集团报表-发货明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/receiveDtl' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022555', '/tdp/report/receiveDtl', 'showInfo', 2, '集团报表-到货明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/warehouseDtl' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022560', '/tdp/report/warehouseDtl', 'showInfo', 2, '集团报表-入库明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/outDtl' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022580', '/tdp/report/outDtl', 'showInfo', 2, '集团报表-出库明细报表-查看详情', 1, 'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/payInfo' and method='showInfo' and sid='M00004' and styp=1;
	if num=0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
values (bs_qxmx_0.nextval, 'M022565', '/tdp/report/payInfo', 'showInfo', 2, '集团报表-支付明细报表-查看详情', 1, 'M00004');
	end if;

update BS_QXSZ t set t.parent='M011225' where t.sid='M00201' and t.mid='M0112' and t.mkid='M01122040';



	num:=0;
	select count(1) into num from bs_qxmx where action='/bsm/menber/mbgroup' and method='mbGroupTree' and styp=2 and sid='B00000';
	if num = 0 then
    	insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'B010050','/bsm/menber/mbgroup','mbGroupTree',2,'集团树',2,'B00000');
	end if;

	update bs_mb_group t set t.zhyname = (select mbname from bs_menber where hydm = t.zhydm) where zhyname is null; 

    
    --dl 2014-01-20 采购定额管理-产品管理权限--start
    update  bs_qxsz set url='/exp/stock/fixed/list.do',inurl='/exp/stock/fixed/list.do#/exp/stock/fixed/toAdd.do#/exp/stock/fixed/toEdit.do' where mname = '产品采购定额管理' and sid='M00004' and mkid='M026505' ;

    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='list';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'list', 2, '分页列表', 1, 'M00004');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='toAdd';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'toAdd', 2, '新增页面', 1, 'M00004');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='toEdit';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'toEdit', 2, '编辑页面', 1, 'M00004');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='save';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'save', 2, '新增保存', 1, 'M00004');
    end if; 
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='update';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'update', 2, '修改保存', 1, 'M00004');
    end if;  
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='dodel';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'dodel', 2, '删除', 1, 'M00004');
    end if;    
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='category';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'category', 2, '类目选择（新增）', 1, 'M00004');
    end if;  
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M026505' and sid='M00004' and action='/exp/stock/fixed' and method='getCategory';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M026505', '/exp/stock/fixed', 'getCategory', 2, '根据选择的类目获取子集(AJAX调用)', 1, 'M00004');
    end if;
    --dl 2014-01-20 采购定额管理-产品管理权限--end
    -------------------------------------------------------------
	
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='M028535' and sid='M00004';
    if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028535','M0285','价格公示','积压物资管理','/tdp/overstock/manage/index.do','/tdp/overstock/manage/index.do#/tdp/overstock/manage/add.do/tdp/overstock/manage/save.do/tdp/overstock/manage/delete.do#/tdp/overstock/manage/deletemore.do',1,'50',1,null,'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxsz where  mkid='M02853505' and sid='M00004';
    if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02853505','M0285','价格公示','编辑','','',2,'50',1,'M028535','M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M028535' and sid='M00004' and action='/tdp/overstock/manage' and method='index';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M028535', '/tdp/overstock/manage', 'index', 2, '积压物资-管理查询', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M02853505' and sid='M00004' and action='/tdp/overstock/manage' and method='add';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M02853505', '/tdp/overstock/manage', 'add', 2, '积压物资-新增编辑', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M02853505' and sid='M00004' and action='/tdp/overstock/manage' and method='save';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M02853505', '/tdp/overstock/manage', 'save', 2, '积压物资-保存', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M02853505' and sid='M00004' and action='/tdp/overstock/manage' and method='delete';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M02853505', '/tdp/overstock/manage', 'delete', 2, '积压物资-删除', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='M02853505' and sid='M00004' and action='/tdp/overstock/manage' and method='deletemore';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M02853505', '/tdp/overstock/manage', 'deletemore', 2, '积压物资-批量上传', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='0' and sid='M00004' and action='/tdp/overstock/index' and method='index';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 0, '/tdp/overstock/index', 'index', 0, '积压物资-首页', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='0' and sid='M00004' and action='/tdp/overstock/index' and method='filter';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 0, '/tdp/overstock/index', 'filter', 0, '积压物资-筛选条件', 1, 'M00004');
    end if;
	
    num:=0;
    select count(1) into num from bs_qxmx where  mkid='0' and sid='M00004' and action='/tdp/overstock/manage' and method='info';
    if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 0, '/tdp/overstock/manage', 'info', 0, '积压物资-详情', 1, 'M00004');
    end if;
	
	
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  