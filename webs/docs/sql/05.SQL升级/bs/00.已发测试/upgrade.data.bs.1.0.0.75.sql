DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.75'; -- 本升级文件的版本，每个升级文件必须修改
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

	--- 个人会员审核
	update bs_qxsz set url='/bsp/personal/audit/list.do', inurl='/bsp/personal/audit/list.do#/bsp/personal/audit/toAudit.do#/bsp/personal/audit/delList.do' where mkid='B010095' and name='个人用户审核' and sid='B00000';
	update bs_qxmx set action='/bsp/personal/audit',remark='个人用户-审核列表' where mkid='B010095' and sid='B00000';
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='toAudit';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'toAudit', '2','个人用户-调整到审核界面', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='agree';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'agree', '2','个人用户-审核通过', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='refuse';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'refuse', '2','个人用户-审核拒绝', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='checkMbname';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'checkMbname', '2','个人用户-检查会员全称是否重复', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='checkLogid';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'checkLogid', '2','个人用户-检查管理员代码是否重复', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='delList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'delList', '2','个人用户-会员审核列表', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='del';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'del', '2','个人用户-回收站', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/personal/audit' and method='restore';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/personal/audit', 'restore', '2','个人用户-回收站还原', '2', 'B00000');
    END IF;
	
	-- end

	-- 2014/09/17	合同夸节点登记	 hanglong 
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M014505' and action='/tdp/trail/receive' and method='htList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M014505', '/tdp/trail/receive', 'htList', 2,'到货登记-待登记合同列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M014505' and action='/tdp/trail/receive' and method='jhList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M014505', '/tdp/trail/receive', 'jhList', 2,'到货登记-待登记交货列表', 1, 'M00004');
    END IF;
    
    update bs_qxsz set inurl='/tdp/trail/receive/list.do#/tdp/trail/receive/toRecord.do#/tdp/trail/receive/getGoodsList.do#/tdp/trail/receive/toEditRecord.do#/tdp/trail/receive/getTrailList.do#/tdp/trail/receive/htList.do#/tdp/trail/receive/jhList.do' where mkid='M014505' and mid='M0145' and sid='M00004';
	
	---个人用户
	update bs_qxsz set 
       inurl = '/bsm/personal/manager/list.do#/bsm/personal/manager/toAdd.do#/bsm/personal/manager/save.do#/bsm/personal/manager/toEdit.do#/bsm/personal/manager/update.do#/bsm/personal/manager/export.do' 
       where mid = 'B0100' and sid = 'B00000' and mkid = 'B010085';

	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='toAdd';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('B010085', '/bsm/personal/manager', 'toAdd', '2','个人用户管理-新增', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='save';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('B010085', '/bsm/personal/manager', 'save', '2','个人用户管理-新增-保存', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('B010085', '/bsm/personal/manager', 'toEdit', '2','个人用户管理-编辑', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='update';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('B010085', '/bsm/personal/manager', 'update', '2','个人用户管理-编辑-保存', '2', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='export';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('B010085', '/bsm/personal/manager', 'export', '2','个人用户管理-导出', '2', 'B00000');
    END IF;
	
	
	
	
	-- end

-- 2014/09/17 huangjunyi 企业物资采购统计表
	


	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M022590' and sid='M00004' and mid='M0225';     
	if num = 0 then 
        insert into bs_qxsz values ('M022590','M0225','集团报表','企业物资采购统计表','/tdp/report/qywzcg/list.do','/tdp/report/qywzcg/list.do',1,960,1,'','M00004');
   end if;
   
   
    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/qywzcg' and method='list' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022590','/tdp/report/qywzcg','list',2,'企业物资采购统计表',1,'M00004');
    end if;
   
   
    update bs_qxsz set orderno = 220 where mname = '我是卖家' and sid = 'M00103' and mkid = 'M011010' and name = '挂牌管理' and url = '/exp/hangsource/sell/hangadmin/index.do';
    update bs_qxsz set orderno = 200 where mname = '我是卖家' and sid = 'M00103' and mkid = 'M011065' and name = '我的资源' and url = '/exp/hangsource/sell/wzdr/index.do';
    update bs_qxsz set isuse = 0 where mname = '我是卖家' and sid = 'M00103' and mkid = 'M011055' and name = '集中采购' and url = '/exp/collect/caigou/index.do';
	update bs_qxsz set isuse = 0 where mname = '我是卖家' and sid = 'M00103' and mkid = 'M011060' and name = '供求管理' and url = '/exp/collect/source/index.do';
	update bs_qxsz set isuse = 0 where mname = '我是卖家' and sid = 'M00103' and mkid = 'M011040' and name = '应标管理' and url = '/exp/tender/sell/bout/list.do';

	num:=0;
	select count(1) into num from bs_cssz where cskey='B_REG_PERSONAL_USER_AUDIT';       
	if num = 0 then 
		insert into bs_cssz(cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
		values('B_REG_PERSONAL_USER_AUDIT','启用后台审核注册个人用户功能','0','1','系统管理员','若启用，前台注册的个人用户需要平台审核','1','750','1 - 启用 0 - 禁用；');
	end if;
	
	num:=0;
	select count(1) into num from Bs_Cssz_Ext where typ='B_REG_PERSONAL_USER_AUDIT' and Cskey = '0';       
	if num = 0 then 
		insert into Bs_Cssz_Ext(typ , Cskey, Csvalue) values ('B_REG_PERSONAL_USER_AUDIT', '0', '禁用');
	end if;
	
	num:=0;
	select count(1) into num from Bs_Cssz_Ext where typ='B_REG_PERSONAL_USER_AUDIT' and Cskey = '1';       
	if num = 0 then 
		insert into Bs_Cssz_Ext(typ , Cskey, Csvalue) values ('B_REG_PERSONAL_USER_AUDIT', '1', '启用');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/ext/index/market' and method = 'index' and sid = 'M00103';       
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
                  values('0', '/ext/index/market', 'index', '0','商铺中心', '1', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/ext/index/market' and method = 'shopCenter' and sid = 'M00103';       
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0', '/ext/index/market', 'shopCenter', '0','商铺中心', '1', 'M00103');
	end if;
	
	-- 2014/09/18 zhminfu 成员企业首页
	num:=0;
	select count(1) into num from bs_qxmx where action='/ext/index/market' and method = 'memberList' and sid = 'M00103';       
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('0', '/ext/index/market', 'memberList', '0','首页-成员企业', '1', 'M00103');
	end if;
	
--end

	-- 2014/09/18	合同夸节点登记	 hanglong 
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M015005' and action='/tdp/trail/warehouse' and method='htList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M015005', '/tdp/trail/warehouse', 'htList', 2,'入库登记-待登记合同列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M015005' and action='/tdp/trail/warehouse' and method='jhList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M015005', '/tdp/trail/warehouse', 'jhList', 2,'入库登记-待登记交货列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M015005' and action='/tdp/trail/warehouse' and method='fhList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M015005', '/tdp/trail/warehouse', 'fhList', 2,'入库登记-待登记发货列表', 1, 'M00004');
    END IF;
    
    
    
    update bs_qxsz set inurl='/tdp/trail/warehouse/list.do#/tdp/trail/warehouse/toRecord.do#/tdp/trail/warehouse/getGoodsList.do#/tdp/trail/warehouse/toEditRecord.do#/tdp/trail/warehouse/getTrailList.do#/tdp/trail/warehouse/toOpRecord.do#/tdp/trail/warehouse/htList.do#/tdp/trail/warehouse/jhList.do#/tdp/trail/warehouse/fhList.do' where mkid='M015005' and mid='M0150' and sid='M00004';
	-- end
	
	
	-- 2014/09/20	模块角色修改	 zzm 
	update bs_xtmk set qxrole='103-1' where mid='M0105' and sid='M00103';
	update bs_xtmk set qxrole='103-2' where mid='M0110' and sid='M00103';
	update bs_xtmk set qxrole='103-3' where mid='M0115' and sid='M00103';
	-- end
	
	
	-- 2014/09/20	商铺中心方法名修改	lvcy
	update bs_qxmx set method = 'shopCenter' where action = '/ext/index/market' and sid = 'M00103' and pkid = '6177';
	
	update bs_qxsz set inurl = '/exp/auction/sell/resource/list.do#/exp/auction/sell/resource/getBrowseFile.do#/exp/auction/sell/resource/doFilePreview.do#/exp/auction/sell/tray/list.do#/exp/auction/sell/tray/resourceInfoList.do#/exp/auction/sell/bout/list.do#/exp/auction/sell/result/list.do#/exp/appoint/sell/dxhy/list.do#/exp/auction/sell/bout/toAdd.do#/exp/appoint/sell/dxhy/toAdd.do#/exp/appoint/sell/dxhy/getMemberList.do#/exp/auction/sell/bout/toEdit.do'
 		where url = '/exp/auction/sell/resource/list.do' and sid = 'M00103' and mkid = 'M011030';
	
	-- 2014/09/20	添加资金平台获取基础平台系统方法	zzm
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00000'and action='/me/home' and method='getMeSystems';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0', '/me/home', 'getMeSystems', 1,'ajax获得会员能访问的系统', 1, 'M00000');
    END IF;
	
	-- 2014/09/20  修改入库为验收  hanglong
	num:=0;
	select count(1) into num from  bs_qxsz where mid='M0225' and sid='M00004' and mkid='M022560';
	if num = 1 then 
		update bs_qxsz set name='验收明细报表' where mid='M0225' and sid='M00004' and mkid='M022560';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_xtmk where sid='M00004' and mid='M0150';
	if num = 1 then 
		update bs_xtmk set mname='验收登记' where sid='M00004' and mid='M0150';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where mid='M0150' and sid='M00004' and mkid='M015005';
	if num = 1 then 
		update bs_qxsz set name='验收登记' where mid='M0150' and sid='M00004' and mkid='M015005';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where mid='M0150' and sid='M00004' and mkid='M015010';
	if num = 1 then 
		update bs_qxsz set name='验收审核' where mid='M0150' and sid='M00004' and mkid='M015010';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where mid='M0150' and sid='M00004' and mkid='M015015';
	if num = 1 then 
		update bs_qxsz set name='验收明细' where mid='M0150' and sid='M00004' and mkid='M015015';
    END IF;
    -- end
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0105' and sid='B00004' and mkid='B010530';
	if num = 1 then 
		update bs_qxsz set url='/exm/td/register/set/toEdit.do' where mid='B0105' and sid='B00004' and mkid='B010530';
    END IF;


    --20140920 huangjunyi  拒绝交易

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01700505' and action='/exp/querybusiness/process/buy' and method='refusePrice';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M01700505', '/exp/querybusiness/process/buy', 'refusePrice', 2,'拒绝交易', 1, 'M00004');
    END IF;


--end
	
	-------fyh  2014/09/20  产品sql---
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/product/market' and method='lbList';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/product/market', 'lbList', 0, '产品类别分类', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/product/market' and method='getProductCategorySm';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/product/market', 'getProductCategorySm', 1, '通过上级类别获取下级产品类别', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/product/market' and method='list';      
	if num = 0 then 
	insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/product/market', 'list', 0, '产品类别', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/productInfo/market' and method='infoShow';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/productInfo/market', 'infoShow', 0, '产品信息-内容', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/productInfo/market' and method='listShow';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/productInfo/market', 'listShow', 0, '产品信息-列表', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/productInfo/market' and method='spuproductList';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/productInfo/market', 'spuproductList', 0, '商铺产品列表', 1, 'M00103');
	END IF;
	 




	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/productInfo/market' and method='sputop';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/productInfo/market', 'sputop', 0, '商铺首页产品显示', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exm/product/manage' and method='list' and STYP=2  and  sid='B00103'  ;     
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'B014055', '/exm/product/manage', 'list', 2, '产品类别管理', 2, 'B00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exm/product/manage' and method='del' and STYP=2  and  sid='B00103'  ;       
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'B014055', '/exm/product/manage', 'del', 2, '产品类别删除', 2, 'B00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exm/product/manage' and method='saveOrUpdate' and STYP=2  and  sid='B00103'  ;      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'B014055', '/exm/product/manage', 'saveOrUpdate', 2, '产品类别保存或修改', 2, 'B00103');
	END IF;

	 


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exm/product/manage' and method='tree' and STYP=2  and  sid='B00103'  ;      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'B014055', '/exm/product/manage', 'tree', 2, '产品类别tree', 2, 'B00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='toEdit' and STYP=1 and sid='M00103'  ;       
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M011070', '/exp/productInfo/market', 'toEdit', 2, '产品信息-修改', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='index' and STYP=1 and sid='M00103'  ;       
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M011070', '/exp/productInfo/market', 'index', 2, '产品信息-新增', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='save' and STYP=1 and sid='M00103'  ;        
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M011070', '/exp/productInfo/market', 'save', 2, '产品信息-保存', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='list' and STYP=1 and sid='M00103'  ;       
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ('M011070', '/exp/productInfo/market', 'list', 2, '产品信息列表', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='doDel' and STYP=1 and sid='M00103'  ;       
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M011070', '/exp/productInfo/market', 'doDel', 2, '产品信息-删除', 1, 'M00103');
	END IF;


	num:=0;
	select count(1) into num from  bs_qxmx where  action='/exp/productInfo/market' and method='doDelAll' and STYP=1 and sid='M00103'  ;      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'M011070', '/exp/productInfo/market', 'doDelAll', 2, '产品信息-批量删除', 1, 'M00103');
	END IF;

	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0140' and sid='B00103' and mkid='B014055';
	if num = 0 then 
	   insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
	values ('B014055', 'B0140', '基础设置', '产品类别管理', '/exm/product/manage/list.do', '', 1, 1000, 2, '', 'B00103');

	END IF;

	num:=0;
	select count(1) into num from  bs_qxsz where mid='M0110' and sid='M00103' and mkid='M011070';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
	values ('M011070', 'M0110', '我是卖家', '产品信息', '/exp/productInfo/market/list.do', '/exp/productInfo/market/list.do#/exp/productInfo/market/index.do#/exp/productInfo/market/toEdit.do', 1, 240, 1, '', 'M00103');
	END IF;
	
	-- 2014/09/18 zhminfu 删除多余商铺模版
	delete from bs_Store_Template_Manage where Template_Id not in ('0000','0001');
	delete from bs_Store_Template where Template_Id not in ('0000','0001');
	update bs_Store_Template set Template_name = '蓝色经典' where Template_Id = '0000';
	update bs_Store_Template set Template_name = '蓝色商务' where Template_Id = '0001';

	num:=0;
	select count(1) into num from  bs_qxmx where action='/login' and method='mallIndex' and sid='M00000';
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','doMallLogin',0,'前台登录',1,'M00000');
	END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where action='/login' and method='mallIndex' and sid='M00000';
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/login','mallIndex',0,'前台登录',1,'M00000');
	END IF;
	
	update bs_qxsz set isuse=2 where  mkid = 'M01122020' and sid='M00211';

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/productInfo/market' and method='gdtop';      
	if num = 0 then 
	  insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/productInfo/market', 'gdtop', 0, '商铺首页产品滚动显示', 1, 'M00103');
	END IF;
	
	--2014/9/22  huangjunyi  企业物资采购统计表

   num:=0;
  select count(1) into num from bs_xtmk where mid='M0360' and sid='M00004';
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0360','企业物资采购统计表',1,1200,'M00004','004-3');
  end if;
  
  
  num:=0;
     select count(1) into num from bs_qxsz  where mkid='M036010' and sid='M00004' and mid='M0360';     
     if num = 0 then 
        insert into bs_qxsz values ('M036010','M0360','企业物资采购统计表','企业物资采购统计表','/tdp/report/pccontractMx/listme.do','/tdp/report/pccontractMx/listme.do',1,100,1,'','M00004');
   end if;



 num:=0;
     select count(1) into num from bs_qxmx where action='/tdp/report/pccontractMx' and method='listme' and  sid='M00004' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M036010','/tdp/report/pccontractMx','listme',2,'企业物资采购统计表',1,'M00004');
    end if;
    
    
   
   
   
   num:=0;
     select count(1) into num from bs_qxsz  where mkid='M036010' and sid='M00004' and mid='M0360' ;     
     if num = 1 then 
        update bs_qxsz set url='/tdp/report/qywzcg/listme.do',inurl='/tdp/report/qywzcg/listme.do'where mkid='M036010' and sid='M00004' and mid='M0360' ;
   end if;
   
   num:=0;
     select count(1) into num from bs_qxmx where action='/tdp/report/qywzcg' and method='listme' and  sid='M00004' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M036010','/tdp/report/qywzcg','listme',2,'企业物资采购统计表',1,'M00004');
    end if;
   
   

	--end 

	-- 2014/09/22	保证金管理	hanglong
	num := 0;
	select count(1) into num from bs_xtmk where mid='B0120' and sid='B00301';
	if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('B0120','公共账户',2,200,'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B012005';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B012005', 'B0120', '公共账户', '保证金管理', '/manager/common/account/deposit/list.do', '/manager/common/account/deposit/list.do', 1, 100, 2, '', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B012005' and action='/manager/common/account/deposit' and method='list';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B012005', '/manager/common/account/deposit', 'list', 2, '保证金管理-保证金申请列表', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01200505' and action='/manager/common/account/deposit' and method='preview';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01200505', '/manager/common/account/deposit', 'preview', 1, '保证金管理-查看', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B01200505';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01200505', 'B0120', '公共账户', '编辑', '', '', 2, 200, 2, 'B012005', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01200505' and action='/manager/common/account/deposit' and method='toEdit';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01200505', '/manager/common/account/deposit', 'toEdit', 2, '保证金管理-进入修改页面', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01200505' and action='/manager/common/account/deposit' and method='doEdit';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01200505', '/manager/common/account/deposit', 'doEdit', 2, '保证金管理-修改', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01200505' and action='/manager/common/account/deposit' and method='doSubmit';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01200505', '/manager/common/account/deposit', 'doSubmit', 2, '保证金管理-提交', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01200505' and action='/manager/common/account/deposit' and method='doDel';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01200505', '/manager/common/account/deposit', 'doDel', 2, '保证金管理-删除', 2, 'B00301');
	end if;
	
	----------
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B012010';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B012010', 'B0120', '公共账户', '公共账户明细', '/manager/common/account/mx/list.do', '/manager/common/account/mx/list.do', 1, 50, 2, '', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B012010' and action='/manager/common/account/mx' and method='list';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B012010', '/manager/common/account/mx', 'list', 2, '公共账户明细-银行流水列表', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B012010' and action='/manager/common/account/mx' and method='export';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B012010', '/manager/common/account/mx', 'export', 2, '公共账户明细-银行流水导出', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B01201005';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01201005', 'B0120', '公共账户', '退保证金申请', '', '', 2, 200, 2, 'B012010', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01201005' and action='/manager/common/account/mx' and method='toAdd';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01201005', '/manager/common/account/mx', 'toAdd', 2, '公共账户明细-进入退保证金申请页面', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01201005' and action='/manager/common/account/mx' and method='doAdd';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01201005', '/manager/common/account/mx', 'doAdd', 2, '公共账户明细-保存退保证金申请', 2, 'B00301');
	end if;
	
	-----------------
	
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B012015';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B012015', 'B0120', '公共账户', '退保证金审核', '/manager/common/account/audit/list.do', '/manager/common/account/audit/list.do', 1, 200, 2, '', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B012015' and action='/manager/common/account/audit' and method='list';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B012015', '/manager/common/account/audit', 'list', 2, '退保证金审核-待审核列表', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where mid='B0120' and sid='B00301' and mkid='B01201505';
	if num = 0 then 
		insert into BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01201505', 'B0120', '公共账户', '审核', '', '', 2, 200, 2, 'B012015', 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01201505' and action='/manager/common/account/audit' and method='toAudit';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01201505', '/manager/common/account/audit', 'toAudit', 2, '退保证金审核-进入退保证金审核页面', 2, 'B00301');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00301' and mkid='B01201505' and action='/manager/common/account/audit' and method='doAudit';      
	if num = 0 then 
		insert into BS_QXMX (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B01201505', '/manager/common/account/audit', 'doAudit', 2, '退保证金审核-审核退保证金申请', 2, 'B00301');
	end if;
	
	--20140923  lvcy
	update bs_qxsz set name = '交易商品信息' where mname = '我是卖家' and name = '我的资源' and mkid = 'M011065' and sid = 'M00103';
	
	--20140924 lvcy
	num:=0;
	select count(1) into num from  bs_store_template where template_id='0002';      
	if num = 0 then
		insert into bs_store_template(template_id,template_name,template_type,preview,realpath,sell_views,timeout_days)
		values('0002', '蓝色简洁', 'velocity', 'template/shop/0002/images/template_0002_preview.png', '/template/shop/0002/t_0002.vm', '0', '15');
	end if;
	
	num:=0;
	select count(1) into num from  bs_store_template where template_id='0003'; 
	if num = 0 then
		insert into bs_store_template(template_id,template_name,template_type,preview,realpath,sell_views,timeout_days)
		values('0003', '蓝色理念', 'velocity', 'template/shop/0003/images/template_0003_preview.png', '/template/shop/0003/t_0003.vm', '0', '15');
	end if;
	
	update bs_store_template a set a.preview = 'template/shop/0000/images/template_0000_preview.png' where a.template_id = '0000';
	
	--end	

	--20140924  zzm
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'list', 2, '合同跟踪列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013505' and action='/exp/trail/deliver' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013505', '/exp/trail/deliver', 'list', 2, '合同跟踪-交货登记-列表页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01350505' and action='/exp/trail/deliver' and method='toRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01350505', '/exp/trail/deliver', 'toRecord', 2, '合同跟踪-交货登记-登记页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01350505' and action='/exp/trail/deliver' and method='doRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01350505', '/exp/trail/deliver', 'doRecord', 2, '合同跟踪-交货登记-登记保存', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300110' and action='/exp/trail/pccontract' and method='save' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300110', '/exp/trail/pccontract', 'save', 2, '保存采购合同', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300110' and action='/exp/trail/pccontract' and method='toAdd' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300110', '/exp/trail/pccontract', 'toAdd', 2, '新增采购合同', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01350505' and action='/exp/trail/deliver' and method='toEditRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01350505', '/exp/trail/deliver', 'toEditRecord', 2, '合同跟踪-交货登记-编辑', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013505' and action='/exp/trail/deliver' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013505', '/exp/trail/deliver', 'getGoodsList', 2, '合同跟踪-交货登记-登记列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013505' and action='/exp/trail/deliver' and method='delRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013505', '/exp/trail/deliver', 'delRecord', 2, '合同跟踪-交货登记-删除', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014005' and action='/exp/trail/send' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014005', '/exp/trail/send', 'list', 2, '合同跟踪-发货登记-列表页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01400505' and action='/exp/trail/send' and method='toRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01400505', '/exp/trail/send', 'toRecord', 2, '合同跟踪-发货登记-登记页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01400505' and action='/exp/trail/send' and method='doRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01400505', '/exp/trail/send', 'doRecord', 2, '合同跟踪-发货登记-登记保存', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01400505' and action='/exp/trail/send' and method='toEditRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01400505', '/exp/trail/send', 'toEditRecord', 2, '合同跟踪-发货登记-编辑', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01400505' and action='/exp/trail/send' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01400505', '/exp/trail/send', 'getGoodsList', 2, '合同跟踪-发货登记-编辑', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014005' and action='/exp/trail/send' and method='delRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014005', '/exp/trail/send', 'delRecord', 2, '合同跟踪-发货登记-删除', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'list', 2, '合同跟踪-到货登记-列表页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01450505' and action='/exp/trail/receive' and method='toRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01450505', '/exp/trail/receive', 'toRecord', 2, '合同跟踪-到货登记-登记页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01450505' and action='/exp/trail/receive' and method='doRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01450505', '/exp/trail/receive', 'doRecord', 2, '合同跟踪-到货登记-登记保存', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01450505' and action='/exp/trail/receive' and method='toEditRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01450505', '/exp/trail/receive', 'toEditRecord', 2, '合同跟踪-到货登记-编辑', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550510' and action='/exp/trail/pay' and method='doSave' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550510', '/exp/trail/pay', 'doSave', 2, '保存支付登记信息', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='export2AesFile' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'export2AesFile', 2, '导出任务明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='getBrowseFile' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'getBrowseFile', 2, '转至导入页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='importFile' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'importFile', 2, '转至导入页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='payList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'payList', 2, '转至导入页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='getExtraContractList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'getExtraContractList', 2, '转至导入页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013001' and action='/exp/trail/pccontract' and method='getExtraContract4Edit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001', '/exp/trail/pccontract', 'getExtraContract4Edit', 2, '外入外部合同详情', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300120' and action='/exp/trail/pccontract' and method='downLoad' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval, 'M01300120', '/exp/trail/pccontract', 'downLoad', 2, '下载附件', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01450505' and action='/exp/trail/receive' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01450505', '/exp/trail/receive', 'exportExcel', 2, '合同跟踪-到货登记-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013510' and action='/exp/trail/deliverDtl' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013510', '/exp/trail/deliverDtl', 'exportExcel', 2, '合同跟踪-交货登记-交货明细-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013510' and action='/exp/trail/deliverDtl' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014010', '/exp/trail/sendDtl', 'exportExcel', 2, '合同跟踪-发货登记-发货明细-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014510' and action='/exp/trail/receiveDtl' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014510', '/exp/trail/receiveDtl', 'exportExcel', 2, '合同跟踪-收货登记-收货明细-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550510' and action='/exp/trail/pay' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550510', '/exp/trail/pay', 'exportExcel', 2, '支付合同导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'getGoodsList', 2, '合同跟踪-到货登记-登记列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='delRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'delRecord', 2, '合同跟踪-到货登记-删除', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015510' and action='/exp/trail/audit' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015510', '/exp/trail/audit', 'list', 2, '支付审核列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013020' and action='/exp/trail/pccontractMx' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013020', '/exp/trail/pccontractMx', 'list', 2, '合同明细列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013020' and action='/exp/trail/pccontractMx' and method='update' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013020', '/exp/trail/pccontractMx', 'update', 2, '修改状态为完成', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300120' and action='/exp/trail/pccontract' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300120', '/exp/trail/pccontract', 'exportExcel', 2, '合同导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015515' and action='/exp/trail/payInfo' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015515', '/exp/trail/payInfo', 'exportExcel', 2, '支付明细导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013020' and action='/exp/trail/pccontractMx' and method='showGoods' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013020', '/exp/trail/pccontractMx', 'showGoods', 2, '查看登记流水', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013030' and action='/exp/audit/pccontract' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/exp/audit/pccontract', 'list', 2, '合同登记-合同审核', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01303030' and action='/exp/audit/pccontract' and method='doAudit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/exp/audit/pccontract', 'doAudit', 2, '合同登记-合同审核', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013030' and action='/exp/audit/pccontract' and method='showInfo' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/exp/audit/pccontract', 'showInfo', 2, '合同登记-合同审核-查看详情', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01303030' and action='/exp/audit/pccontract' and method='doReject' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/exp/audit/pccontract', 'doReject', 2, '合同登记-合同审核拒绝', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300110' and action='/exp/trail/pccontract' and method='doSubmit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300110', '/exp/trail/pccontract', 'doSubmit', 2, '提交合同或取消合同', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300110' and action='/exp/trail/pccontract' and method='doSubmit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01303030', '/exp/audit/pccontract', 'cancel', 2, '取消审核', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013520' and action='/exp/trail/warning' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval, 'M013520', '/exp/trail/warning', 'list', 2, '合同跟踪-交货预警', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550520' and action='/exp/trail/audit' and method='doAudit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550520', '/exp/trail/audit', 'doAudit', 2, '审核支付登记', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550520' and action='/exp/trail/audit' and method='toAudit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550520', '/exp/trail/audit', 'toAudit', 2, '转向审核页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015520' and action='/exp/trail/payplan' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015520', '/exp/trail/payplan', 'list', 2, '支付计划合同列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01552010' and action='/exp/trail/payplan' and method='getPayplan' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01552010', '/exp/trail/payplan', 'getPayplan', 2, '合同信息和支付计划', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01350505' and action='/exp/trail/deliver' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01350505', '/exp/trail/deliver', 'exportExcel', 2, '合同跟踪-交货登记-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013020' and action='/exp/trail/pccontractMx' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013020', '/exp/trail/pccontractMx', 'exportExcel', 2, '合同明细列表-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300120' and action='/exp/trail/pccontract' and method='downLoadModel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300120', '/exp/trail/pccontract', 'downLoadModel', 2, '下载合同模板', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300120' and action='/exp/trail/pccontract' and method='showInfo' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300120', '/exp/trail/pccontract', 'showInfo', 2, '查看合同', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013505' and action='/exp/trail/deliver' and method='getTrailList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013505', '/exp/trail/deliver', 'getTrailList', 2, '合同跟踪-交货登记-跟踪列表信息', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013510' and action='/exp/trail/deliverDtl' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013510', '/exp/trail/deliverDtl', 'list', 2, '合同跟踪-交货登记-交货明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014005' and action='/exp/trail/send' and method='exportExcel' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014005', '/exp/trail/send', 'exportExcel', 2, '合同跟踪-发货登记-导出', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015505' and action='/exp/trail/pay' and method='warnList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015505', '/exp/trail/pay', 'warnList', 2, '支付登记-预警', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015505' and action='/exp/trail/pay' and method='getPayList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015505', '/exp/trail/pay', 'getPayList', 2, '已登记的支付列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015505' and action='/exp/trail/pay' and method='payList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015505', '/exp/trail/pay', 'payList', 2, '支付登记', 1, 'M00103');
	end if;
	
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550520' and action='/exp/trail/pay' and method='submitPay' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550520', '/exp/trail/pay', 'submitPay', 2, '提交支付登记信息', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550510' and action='/exp/trail/pay' and method='toEditPay' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550510', '/exp/trail/pay', 'toEditPay', 2, '修改支付登记信息', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014010' and action='/exp/trail/sendDtl' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014010', '/exp/trail/sendDtl', 'list', 2, '合同跟踪-发货登记-发货明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014510' and action='/exp/trail/receiveDtl' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014510', '/exp/trail/receiveDtl', 'list', 2, '合同跟踪-收货登记-收货明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='getTrailList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'getTrailList', 2, '合同跟踪-到货登记-跟踪列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='getTrailList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'getTrailList', 2, '合同跟踪-到货登记-跟踪列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014005' and action='/exp/trail/send' and method='getTrailList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014005', '/exp/trail/send', 'getTrailList', 2, '合同跟踪-发货登记-跟踪列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01300110' and action='/exp/trail/pccontract' and method='showDeliveryPlan' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300110', '/exp/trail/pccontract', 'showDeliveryPlan', 2, '交货计划：显示页', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01552010' and action='/exp/trail/payplan' and method='doEdit' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01552010', '/exp/trail/payplan', 'doEdit', 2, '修改支付计划', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013510' and action='/exp/trail/deliverDtl' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013510', '/exp/trail/deliverDtl', 'getGoodsList', 2, '合同跟踪-交货登记-交货明细-已发货量明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013510' and action='/exp/trail/deliverDtl' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014010', '/exp/trail/sendDtl', 'getGoodsList', 2, '合同跟踪-发货登记-发货明细-已到货量明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014510' and action='/exp/trail/receiveDtl' and method='getGoodsList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014510', '/exp/trail/receiveDtl', 'getGoodsList', 2, '合同跟踪-收货登记-收货明细-已入库量明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015505' and action='/exp/trail/pay' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015505', '/exp/trail/pay', 'list', 2, '支付合同列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M015515' and action='/exp/trail/payInfo' and method='list' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M015515', '/exp/trail/payInfo', 'list', 2, '支付明细', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550520' and action='/exp/trail/audit' and method='reject' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550520', '/exp/trail/audit', 'reject', 2, '审核支付不通过', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M01550520' and action='/exp/trail/audit' and method='resultList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01550520', '/exp/trail/audit', 'resultList', 2, '审核支付不通过', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013030' and action='/exp/audit/pccontract' and method='resultList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/exp/audit/pccontract', 'resultList', 2, '合同登记审核-审核结果', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013030' and action='/exp/audit/pccontract' and method='toAuditRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/exp/audit/pccontract', 'toAuditRecord', 2, '合同登记审核-进入线下审核登记页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M013030' and action='/exp/audit/pccontract' and method='doAuditRecord' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013030', '/exp/audit/pccontract', 'doAuditRecord', 2, '合同登记审核-线下审核登记', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='htList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'htList', 2, '到货登记-待登记合同列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014505' and action='/exp/trail/receive' and method='jhList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014505', '/exp/trail/receive', 'jhList', 2, '到货登记-待登记交货列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where  mkid='M014005' and action='/exp/trail/send' and method='htList' and sid='M00103';      
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M014005', '/exp/trail/send', 'htList', 2, '发货登记-合同记录', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01350505' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01350505', 'M0135', '交货登记', '编辑', '', '', 2, 100, 1, 'M013505', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01400505' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01400505', 'M0140', '发货登记', '编辑', '', '', 2, 100, 1, 'M014005', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01450505' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01450505', 'M0145', '到货登记', '编辑', '', '', 2, 100, 1, 'M014505', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013520' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013520', 'M0135', '交货登记', '交货预警', '/exp/trail/warning/list.do', '/exp/trail/warning/list.do', 1, 50, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01303030' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01303030', 'M0130', '合同登记', '编辑', '', '', 2, 200, 1, 'M013030', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M014005' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M014005', 'M0140', '发货登记', '发货登记', '/exp/trail/send/list.do', '/exp/trail/send/list.do#/exp/trail/send/toRecord.do#/exp/trail/send/getGoodsList.do#/exp/trail/send/toEditRecord.do#/exp/trail/send/getTrailList.do#/exp/trail/send/htList.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M015505' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M015505', 'M0155', '合同支付', '支付登记', '/exp/trail/pay/list.do', '/exp/trail/pay/list.do#/exp/trail/pay/payList.do#/exp/trail/pay/getPayList.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M015515' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M015515', 'M0155', '合同支付', '支付明细', '/exp/trail/payInfo/list.do', '/exp/trail/payInfo/list.do', 1, 300, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013020' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013020', 'M0130', '合同登记', '合同明细', '/exp/trail/pccontractMx/list.do', '/exp/trail/pccontractMx/list.do', 1, 300, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013030' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013030', 'M0130', '合同登记', '合同审核', '/exp/audit/pccontract/list.do', '/exp/audit/pccontract/list.do#/exp/audit/pccontract/showInfo.do#/exp/audit/pccontract/resultList.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013505'and  sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013505', 'M0135', '交货登记', '交货登记', '/exp/trail/deliver/list.do', '/exp/trail/deliver/list.do#/exp/trail/deliver/toRecord.do#/exp/trail/deliver/getGoodsList.do#/exp/trail/deliver/toEditRecord.do#/exp/trail/deliver/getTrailList.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M015520' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M015520', 'M0155', '合同支付', '支付计划', '/exp/trail/payplan/list.do', '/exp/trail/payplan/list.do#/exp/trail/payplan/getPayplan.do', 1, 50, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01552010' and  sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01552010', 'M0155', '合同支付', '编辑', '', '', 2, 50, 1, 'M015520', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M014505' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M014505', 'M0145', '到货登记', '到货登记', '/exp/trail/receive/list.do', '/exp/trail/receive/list.do#/exp/trail/receive/toRecord.do#/exp/trail/receive/getGoodsList.do#/exp/trail/receive/toEditRecord.do#/exp/trail/receive/getTrailList.do#/exp/trail/receive/htList.do#/exp/trail/receive/jhList.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013510' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013510', 'M0135', '交货登记', '交货明细', '/exp/trail/deliverDtl/list.do', '/exp/trail/deliverDtl/list.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M015525' and  sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M015525', 'M0155', '合同支付', '支付预警', '/exp/trail/pay/warnList.do', '/exp/trail/pay/warnList.do', 1, 400, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01300110' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01300110', 'M0130', '合同登记', '编辑', '', '', 2, 100, 1, 'M013001', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01300120' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01300120', 'M0130', '合同登记', '详情', '', '', 2, 100, 1, 'M013001', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01550510' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01550510', 'M0155', '合同支付', '编辑', '', '', 2, 100, 1, 'M015505', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01550515' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01550515', 'M0155', '合同支付', '提交', '', '', 2, 100, 1, 'M015505', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M01550520' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01550520', 'M0155', '合同支付', '审核', '', '', 2, 200, 1, 'M015510', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M013001' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013001', 'M0130', '合同登记', '合同查询', '/exp/trail/pccontract/list.do', '/exp/trail/pccontract/list.do#/exp/trail/pccontract/showInfo.do#/exp/trail/pccontract/toAdd.do#/exp/trail/pccontract/getExtraContractList.do#/exp/trail/pccontract/getBrowseFile.do#/exp/trail/pccontract/getExtraContract4Edit.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M015510' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M015510', 'M0155', '合同支付', '支付审核', '/exp/trail/audit/list.do', '/exp/trail/audit/list.do#/exp/trail/audit/toAudit.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M014010' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M014010', 'M0140', '发货登记', '发货明细', '/exp/trail/sendDtl/list.do', '/exp/trail/sendDtl/list.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M014510' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M014510', 'M0145', '到货登记', '到货明细', '/exp/trail/receiveDtl/list.do', '/exp/trail/receiveDtl/list.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M014510' and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M014510', 'M0145', '到货登记', '到货明细', '/exp/trail/receiveDtl/list.do', '/exp/trail/receiveDtl/list.do', 1, 200, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0135' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0135', '交货登记', 1, '', '', '', '', '', '', '', '', '', '', '', 500, 'M00103', '103-3');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0140' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0140', '发货登记', 1, '', '', '', '', '', '', '', '', '', '', '', 600, 'M00103', '103-3');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0145' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0145', '到货登记', 1, '', '', '', '', '', '', '', '', '', '', '', 700, 'M00103', '103-3');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0155' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0155', '合同支付', 1, '', '', '', '', '', '', '', '', '', '', '', 900, 'M00103', '103-3');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0130' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0130', '合同登记', 1, '', '', '', '', '', '', '', '', '', '', '', 400, 'M00103', '103-3');
	end if;
	
	num:=0;
	select count(1) into num from  bs_xtmk where  mid='M0320' and  sid='M00103';      
	if num = 0 then
		insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
		values ('M0320', '供应商管理', 1, '', '', '', '', '', '', '', '', '', '', '', 2000, 'M00103', '');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M032005'and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M032005', 'M0320', '供应商管理', '供应商管理', '/exp/td/supplier/manager/list.do', '/exp/td/supplier/manager/list.do#/exp/td/supplier/manager/toAdd.do#/exp/td/supplier/manager/doAdd.do#/exp/td/supplier/manager/toEdit.do#/exp/td/supplier/manager/doEdit.do#/exp/td/supplier/manager/doDel.do', 1, 100, 1, '', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M03200505'and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200505', 'M0320', '供应商管理', '新增', '', '', 2, 100, 1, 'M032005', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M03200510'and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200510', 'M0320', '供应商管理', '编辑', '', '', 2, 200, 1, 'M032005', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxsz where  mkid='M03200515'and sid='M00103';      
	if num = 0 then
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200515', 'M0320', '供应商管理', '删除', '', '', 2, 300, 1, 'M032005', 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='doAdd' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200505', '/exp/td/supplier/manager', 'doAdd', 2, '新增', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='doDel' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200515', '/exp/td/supplier/manager', 'doDel', 2, '删除', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='list' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M032005', '/exp/td/supplier/manager', 'list', 2, '供应商列表', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='showimg' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200510', '/exp/td/supplier/manager', 'showimg', 2, '查看图片', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='toAdd' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200505', '/exp/td/supplier/manager', 'toAdd', 2, '进入新增页面', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='toEdit' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200510', '/exp/td/supplier/manager', 'toEdit', 2, '进入编辑页面', 1, 'M00103');
	end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/td/supplier/manager' and method='doEdit' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M03200510', '/exp/td/supplier/manager', 'doEdit', 2, '编辑', 1, 'M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/productInfo/market' and method='spuproductListJson' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		values('0','/exp/productInfo/market','spuproductListJson','0','商铺产品列表Json','1','M00103');
	end if;
	
	--20140925 lvcy
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/productInfo/market' and method='spuproductListJson' and sid = 'M00103';      
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
		values('0','/exp/productInfo/market','spuproductListJson','0','商铺产品列表Json','1','M00103');
	end if;
	
	-- end
	-- 2014/09/15	采购平台登记设置	start
	--	前台设置
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00000' and mid='M0100' and mkid = 'M010060';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M010060', 'M0100', '登记设置', '登记设置', '/exp/td/register/set/toEdit.do', '/exp/td/register/set/toEdit.do#/exp/td/register/set/doEdit.do#', 1, 100, 1, '', 'M00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00000' and mkid='M010060' and action='/exp/td/register/set' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M010060', '/exp/td/register/set', 'toEdit', 2, '编辑', 1, 'M00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00000' and mid='M0100' and mkid = 'M01006005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01006005', 'M0100', '登记设置', '编辑', '', '', 2, 200, 1, 'M010060', 'M00000');
    END IF;
    
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00000' and mkid='M01006005' and action='/exp/td/register/set' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01006005', '/exp/td/register/set', 'doEdit', 2, '编辑', 1, 'M00000');
    END IF;

    
    
    --- 20140925 huangjunyi 询价结果发布公告
   num:=0;
     select count(1) into num from bs_qxmx where action='/exp/querybusiness/completed/buy' and method='dogg' and  sid='M00004' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/completed/buy','dogg',2,'询价结果发布公告',1,'M00004');
    end if;
    
    
    ---询价结果公告审核链接

   num:=0;
     select count(1) into num from bs_qxsz  where mkid='B014520' and sid='B00004' and mid='B0145';    
     if num = 0 then
        insert into bs_qxsz values ('B014520','B0145','询货采购管理','询价结果公告审核','/exm/querybusiness/manager/ggshlist.do','/exm/querybusiness/manager/ggshlist.do',1,250,2,'','B00004');
   end if;
   
   
   ---询价结果公告审核列表方法
     num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action='/exm/querybusiness/manager' and method='ggshlist';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014520', '/exm/querybusiness/manager', 'ggshlist', 2, '询价结果公告审核列表', 2, 'B00004');
    END IF;
   


	--- end 

    
    delete from bs_xtmk t where t.sid='M00004' and t.mid='M0350';
	
	update bs_xtmk set mname='客户管理'  where sid='M00103' and Mid='M0320';
	update bs_qxsz set mname='客户管理'  where sid='M00103' and Mid='M0320';
	update bs_qxsz set name='客户管理'  where sid='M00103' and Mkid='M032005';

	-- 2014/09/25 货款结算单导出	hanglong
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B011550' and action='/exm/contract/bill/manage' and method='export';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011550', '/exm/contract/bill/manage', 'export', 2, '导出', 2, 'B00201');
    END IF;
    
    -- 2014/09/26 lvcy 
    update bs_qxsz set inurl = '/exp/auction/buy/result/list.do#/exp/auction/buy/bout/toJoin.do' where mname = '我是买家' and name = '拍卖采购' and mkid = 'M012520' and sid = 'M00103' and mid = 'M0105';

	update bs_qxsz set isuse=0  where sid='M00103' and Mkid='M010550';
	update bs_qxsz set isuse=0  where sid='B00103' and Mid='B0113';
	
    update bs_qxsz set inurl =  '/exp/delivery/buy/manage/list.do#/exp/delivery/buy/manage/print.do#/exp/delivery/buy/manage/toEdit.do#/exp/delivery/buy/manage/toCreateDelivery.do#/exp/delivery/buy/manage/toNextStep.do#/exp/dissent/buy/manage/toAdd.do#/exp/dissent/buy/manage/toView.do#/exp/dissent/buy/manage/toEdit.do#/exp/transport/buy/entrust/list.do' where mkid='M010520' and sid='M00103';
	
	---20140929 huangjunyi  代理商审核未通过列表
 num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='M010035' and action ='/bsp/menber/wldw' and method='auditRefuseList';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010035' , '/bsp/menber/wldw', 'auditRefuseList' , 2, '审核未通过代理商列表', 1, 'M00000');
    END IF;

    
    
    
    update bs_qxsz set inurl =  '/bsp/menber/wldw/list.do#/bsp/menber/wldw/auditList.do#/bsp/menber/wldw/toAdd.do#/bsp/menber/wldw/auditRefuseList.do' where mkid='M010035' and sid='M00000';
    
    
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='M010035' and action ='/bsp/menber/wldw' and method='refuseDelete';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010035' , '/bsp/menber/wldw', 'refuseDelete' , 2, '审核未通过代理商删除', 1, 'M00000');
    END IF;
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='M010035' and action ='/bsp/menber/wldw' and method='toRefuseEdit';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010035' , '/bsp/menber/wldw', 'toRefuseEdit' , 2, '审核未通过代理商修改页面', 1, 'M00000');
    END IF;
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='M010035' and action ='/bsp/menber/wldw' and method='doRefuseEdit';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010035' , '/bsp/menber/wldw', 'doRefuseEdit' , 2, '审核未通过代理商修改', 1, 'M00000');
    END IF;
    
    
    --end
    
 


	
	 num:=0;
       select count (1) into num from  BS_XTMK where sid='M00103' and MID='M0120' ;     
       if num = 0 then
		insert into BS_XTMK (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
	values ('M0120', '产品信息', 1, '', '', '', '', '', '', '', '', '', '', '', 400, 'M00103', '103-4');
	 END IF;

update BS_QXMX  set MKID='M012005'    where sid='M00103' and  MKID='M011070';

update BS_QXSZ  set MKID='M012005' , MID='M0120' ,MNAME='产品信息'     where sid='M00103' and  MKID='M011070';

update BS_QXFP set  MKID='M012005'    where sid='M00103' and  MKID='M011070';

     num:=0;
       select count (1) into num from  bs_qxmx where sid='M00103' and mkid='0' and action ='/exp/mobile/productInfo' and method='ajaxlist';     
       if num = 0 then
			 insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
			values ( '0', '/exp/mobile/productInfo', 'ajaxlist', 0, '手机产品信息列表', 1, 'M00103');
		end if;
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00103' and mkid='0' and action ='/exp/mobile/productInfo' and method='ajaxInfo';     
       if num = 0 then
	insert into BS_QXMX ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( '0', '/exp/mobile/productInfo', 'ajaxInfo', 0, '手机产品信息详情', 1, 'M00103');
	end if;
	
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

