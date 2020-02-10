DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.74'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	-- 2014/09/15	采购平台登记设置	start
	--	前台设置
	num:=0;
	select count(1) into num from  bs_xtmk where sid='M00004' and mid='M0350';      
	if num = 0 then 
		insert into bs_xtmk (mid, mname, styp, ordby, sid, qxrole)
		values ('M0350', '登记设置', 1, 1500, 'M00004', '');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0350' and mkid = 'M035005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M035005', 'M0350', '登记设置', '登记设置', '/exp/td/register/set/toEdit.do', '/exp/td/register/set/toEdit.do#/exp/td/register/set/doEdit.do#', 1, 100, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M035005' and action='/exp/td/register/set' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M035005', '/exp/td/register/set', 'toEdit', 2, '编辑', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0350' and mkid = 'M03500510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03500510', 'M0350', '登记设置', '编辑', '', '', 2, 200, 1, 'M035005', 'M00004');
    END IF;
    
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03500510' and action='/exp/td/register/set' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03500510', '/exp/td/register/set', 'doEdit', 2, '编辑', 1, 'M00004');
    END IF;
    
    -- 后台设置
	num:=0;
	select count(1) into num from  bs_qxsz where sid='B00004' and mid='B0105' and mkid = 'B010530';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B010530', 'B0105', '登记设置', '登记设置', '/exm/td/register/set/list.do', '/exm/td/register/set/list.do#/exm/td/register/set/toAdd.do#/exm/td/register/set/doAdd.do#/exm/td/register/set/toEdit.do#/exm/td/register/set/doEdit.do#', 1, 10, 2, '', 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'list', 2, '列表页面', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='toAdd';
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'toAdd', 2, '新增页面', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='doAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'doAdd', 2, '新增保存', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'toEdit', 2, '修改页面', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'doEdit', 2, '修改保存', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B010530' and action='/exm/td/register/set' and method='doDel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010530', '/exm/td/register/set', 'doDel', 2, '删除', 2, 'B00004');
    END IF;
	
    
    num:=0;
	select count(1) into num from  bs_xtmk where sid='M00103' and mid='M0115' ;      
	if num = 0 then 
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0115','运输公司',1,'300','M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mkid='M01102510';      
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01102510','M0110','我是卖家','委托配送','','','2',500,1,'M011025','M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mkid='M011505';      
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M011505','M0115','运输公司','单据管理','/exp/transport/manager/list.do','/exp/transport/manager/list.do#/exp/transport/manager/confirm.do#/exp/transport/manager/info.do','1',100,1,'','M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/buy/entrust' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011025', '/exp/transport/buy/entrust', 'list', 1, '提单管理-配送详情', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/buy/entrust' and method='info';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011025', '/exp/transport/buy/entrust', 'info', 1, '提单管理-配送详情', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/buy/entrust' and method='add';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01102510', '/exp/transport/buy/entrust', 'add', 1, '提单管理-新增配送', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/buy/entrust' and method='save';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01102510', '/exp/transport/buy/entrust', 'save', 1, '提单管理-新增配送', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/manager' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011505', '/exp/transport/manager', 'list', 1, '单据管理-配送管理', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/manager' and method='confirm';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011505', '/exp/transport/manager', 'confirm', 1, '单据管理-配送确认', 1, 'M00103');
    END IF;
	
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/transport/manager' and method='info';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011505', '/exp/transport/manager', 'info', 1, '单据管理-配送详情', 1, 'M00103');
    END IF;
    
	
	-- end


    -- 2014/09/15 huangjunyi  物资采购消耗统计月报

 	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M022585' and sid='M00004' and mid='M0225';     
	if num = 0 then 
        insert into bs_qxsz values ('M022585','M0225','集团报表','物资采购消耗统计月报','/tdp/report/goodsdetail/list.do','/tdp/report/goodsdetail/list.do',1,950,1,'','M00004');
   end if;
   
   
   num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/goodsdetail' and method='list' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022585','/tdp/report/goodsdetail','list',2,'物资采购消耗统计月报',1,'M00004');
    end if;
    
    
     num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/goodsdetail' and method='toImportGoods' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022585','/tdp/report/goodsdetail','toImportGoods',2,'物资采购消耗统计月报导入页面',1,'M00004');
    end if;
    
     num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/goodsdetail' and method='downloadGoodsTemplate' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022585','/tdp/report/goodsdetail','downloadGoodsTemplate',2,'下载物资采购消耗统计月报模版',1,'M00004');
    end if;
    
    
     num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/goodsdetail' and method='doImportGoods' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022585','/tdp/report/goodsdetail','doImportGoods',2,'导入物资采购消耗统计',1,'M00004');
    end if;







		--  end 






    --信息设置

    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mkid='M011510';     
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M011510','M0115','运输公司','信息管理','/exp/transport/info/list.do','','1',200,1,'','M00103');
    END IF;

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M011510' and action='/exp/transport/info' and method='list';     
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
			values ('M011510', '/exp/transport/info', 'list', 2, '信息管理-显示信息', 1, 'M00103');
    END IF;

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M011510' and action='/exp/transport/info' and method='toEntity';     
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		 values ('M011510', '/exp/transport/info', 'toEntity', 2, '信息管理-新增修改显示', 1, 'M00103'); 
    END IF;

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M011510' and action='/exp/transport/info' and method='delete';     
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
			values ('M011510', '/exp/transport/info', 'delete', 2, '信息管理-删除', 1, 'M00103');  
    END IF;

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M011510' and action='/exp/transport/info' and method='save';     
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M011510', '/exp/transport/info', 'save', 2, '信息管理-保存', 1, 'M00103'); 
    END IF;

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M011510' and action='/exp/transport/info' and method='edit';     
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M011510', '/exp/transport/info', 'edit', 2, '信息管理-修改', 1, 'M00103');
    END IF;

	--end


    

    

    

    
 



  
  --- 增加网上商城系统
   num :=0;
   select count(1) into num from bs_system where sid='M00211';
   if num =0 then
	insert into bs_system (sid, sname, shortname, styp, homepage, orderno, url00, url01, url02, url03, url04)
		values('M00211', '网上商城平台','网上商城', 1, '/me/home/index.do', 910, 'http://mall.td.dev.steel56.com.cn/mallplatform','/login/index.do','/auth/noAuth.do','/login/doLogout.do','_mallSystem');
   end if;
   
   num :=0;
   select count(1) into num from bs_system where sid='B00211';
   if num =0 then
	insert into bs_system (sid, sname, shortname, styp, homepage, orderno, url00, url01, url02, url03, url04)
		values('B00211', '网上商城平台','网上商城', 2, '/admin/me/home/index.do', 110, 'http://mall.td.dev.steel56.com.cn/mallmanager','/admin/login/index.do','/admin/auth/noAuth.do','/admin/login/doLogout.do','_mallSystem');
   end if;
   
   
   num :=0;
   select count(1) into num from bs_xtmk where sid='M00211';
   if num = 0 then
    insert into bs_xtmk(mid, mname, styp, ordby, sid, qxrole)  select mid, mname, styp, ordby, 'M00211', '211-' || substr(qxrole, 5,1) from bs_xtmk where sid='M00201' ;
   end if;
   
   num :=0;
   select count(1) into num from bs_xtmk where sid='B00211';
   if num = 0 then
    insert into bs_xtmk(mid, mname, styp, ordby, sid)  select mid, mname, styp, ordby, 'B00211' from bs_xtmk where sid='B00201' ;
   end if;
   
   num :=0;
   select count(1) into num from bs_qxsz where sid='M00211';
   if num =0 then
  insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid) select mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, 'M00211'  from bs_qxsz where sid='M00201';
   end if;
   
      num :=0;
   select count(1) into num from bs_qxsz where sid='B00211';
   if num =0 then
  insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid) select mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, 'B00211'  from bs_qxsz where sid='B00201';
   end if;
   
   num :=0;
   select count(1) into num from bs_qxmx where sid='M00211';
   if num =0 then
  insert into bs_qxmx(MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP,SID) SELECT MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP,'M00211' FROM BS_QXMX WHERE SID='M00201';
   end if;
   
   num :=0;
   select count(1) into num from bs_qxmx where sid='B00211';
   if num =0 then
  insert into bs_qxmx(MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP,SID) SELECT MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP,'B00211' FROM BS_QXMX WHERE SID='B00201';
   end if;
   
   
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and action='/swfupload' and method='upload';     
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('0','/swfupload','upload',0,'文件上传','1','M00103');
    END IF;

      num :=0;
   select count(1) into num from bs_value where GID='CACHE' and key='mallmanager';
   if num =0 then
		INSERT INTO BS_VALUE(gid, key, value, Remark)
			values('CACHE','mallmanager','http://mall.td.dev.steel56.com.cn/mallmanager/cache/reflashCache.do','网上商城后台刷新缓存地址');
   end if;
   
   num :=0;
   select count(1) into num from bs_value where GID='CACHE' and key='mallplatform';
   if num =0 then
		INSERT INTO BS_VALUE(gid, key, value, Remark)
			values('CACHE','mallplatform','http://mall.td.dev.steel56.com.cn/mallplatform/cache/reflashCache.do','网上商城前台刷新缓存地址');
   end if;
   update bs_system set homepage='/admin/index.do' ,url01='/admin/login/index.do', url02='/admin/noAuth.do', url03='/admin/login/doLogout.do' where sid='B00211';
  
  
     
   num:=0;
	select count(1) into num from bs_qxmx where sid='M00000' and mkid='M010515' and action='/bsp/shop/msg' and method='getShowMsgList';   
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('M010515','/bsp/shop/msg','getShowMsgList','0','查询企业动态','1','M00000');
    END IF;
    
    --- 销售平台登录
    update bs_system set url01='/login/exIndex.do' where sid='M00103';
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00000' and action='/login' and method='exIndex';   
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('0','/login','exIndex','0','EX前台登录页面','1','M00000');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00000' and action='/login' and method='doExLogin';   
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('0','/login','doExLogin','0','EX前台登录','1','M00000');
    end if;
    
    --- 个人会员
	num:=0;
	select count(1) into num from  bs_qxsz where sid='B00000' and mid='B0100' and mkid = 'B010085';       
	if num = 0 then 
		insert into bs_qxsz(mkid, mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B010085', 'B0100', '会员管理', '个人用户管理', '/bsm/personal/manager/list.do', '/bsm/personal/manager/list.do', '1', '6', '2', '', 'B00000');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010085' and action='/bsm/personal/manager' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010085', '/bsm/personal/manager', 'list', '2','个人用户管理', '2', 'B00000');
    END IF;
    ------------
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00000' and mid='B0100' and mkid = 'B010095';       
	if num = 0 then 
		insert into bs_qxsz(mkid, mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B010095', 'B0100', '会员管理', '个人用户审核', '/bsp/supplier/personal/list.do', '/bsp/supplier/personal/list.do', '1', '6', '2', '', 'B00000');
	END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00000' and mkid='B010095' and action='/bsp/supplier/personal' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('B010095', '/bsp/supplier/personal', 'list', '2','个人用户审核', '2', 'B00000');
    END IF;
  	--- end


	-- 2014/09/16	合同夸节点登记	 hanglong 
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M014005' and action='/tdp/trail/send' and method='htList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M014005', '/tdp/trail/send', 'htList', 2,'发货登记-合同记录', 1, 'M00004');
    END IF;
    
    update bs_qxsz set inurl='/tdp/trail/send/list.do#/tdp/trail/send/toRecord.do#/tdp/trail/send/getGoodsList.do#/tdp/trail/send/toEditRecord.do#/tdp/trail/send/getTrailList.do#/tdp/trail/send/htList.do' where mkid='M014005' and mid='M0140' and sid='M00004';
	
	-- end
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

