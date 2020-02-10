 DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.79'; -- 本升级文件的版本，每个升级文件必须修改
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
   
	--新增-初始库存值维护
	num:=0;
  select count(1) into num from bs_xtmk where mid='M0370' and sid='M00004';
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0370','初始库存值维护',1,355,'M00004','004-2');
  end if;
  
  --初始库存值维护-左边列表
 	num:=0;
  select count(1) into num from bs_qxsz where mkid='M037005' and mid='M0370' and styp=1 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M037005','M0370','初始库存值维护','初始库存值维护','/tdp/puc/pcrepertory/list.do','/tdp/puc/pcrepertory/list.do',1,100,1,'M00004');
	end if;
	
  --初始库存值维护-明细列表
	num:=0;
  select count(1) into num from bs_qxmx where  action='/tdp/puc/pcrepertory' and  method='list' and styp=1 and mkid='M037005' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M037005','/tdp/puc/pcrepertory','list',1,'初始库存值维护列表',1,'M00004');
    end if;
    
    
--初始库存值维护新增
    num:=0;
  select count(1) into num from bs_qxmx where   action='/tdp/puc/pcrepertory' and  method='doAddSave' and styp=1  and   mkid='M03700505' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M03700505','/tdp/puc/pcrepertory','doAddSave',1,'初始库存值维护新增',1,'M00004');
    end if;

--初始库存值维护编辑
    num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/pcrepertory' and  method='doeditSave' and styp=1  and  mkid='M03700505' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M03700505','/tdp/puc/pcrepertory','doeditSave',1,'初始库存值维护编辑',1,'M00004');
    end if;
    
--初始库存值维护查看
    num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/pcrepertory' and  method='view' and styp=1  and mkid='M03700505' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M03700505','/tdp/puc/pcrepertory','view',1,'初始库存值维护查看',1,'M00004');
    end if; 
    
--初始库存值维护删除
    num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/pcrepertory' and  method='doDelete' and styp=1  and mkid='M03700505' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M03700505','/tdp/puc/pcrepertory','doDelete',1,'初始库存值维护删除',1,'M00004');
    end if;  
    
--初始库存值显示 
    num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/puc/pcrepertory' and  method='viewkcz' and styp=1  and mkid='M03700505' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M03700505','/tdp/puc/pcrepertory','viewkcz',1,'初始库存值',1,'M00004');
    end if; 
    -- 升级文件到此结束
	
	--hjw 11-5
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/puc/req' and  method='downLoadModel' and mkid='M011505' and  sid='M00004';
	if num=0 then
		insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M011505','/tdp/puc/req','downLoadModel',2,'下载标准文件模板',1,'M00004');
    end if; 
	
	----wxd 2014/11/04 添加附件下载权限
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/querybusiness/process/buy' and method='downLoad' and styp=1 and sid='M00004';
  	if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M017005','/exp/querybusiness/process/buy','downLoad',2,'附件下载',1,'M00004');
 	end if;
	----end------wxd 2014/11/04 添加附件下载权限

	---wxd 2014/11/05添加查看采购计划明细权限
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/tdp/puc/plan/list' and  method='toView' and styp=1 and mkid='M012015' and  sid='M00004';
  	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M012015','/tdp/puc/plan/list','toView',2,'查看采购计划明细',1,'M00004');
    end if;
    ----end-----wxd 2014/11/05添加查看采购计划明细权限
	
	--hjw   2014/11/07  采购需求-采购需求详情
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/tdp/puc/req' and  method='view1' and mkid='M011510' and  sid='M00004';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M011510','/tdp/puc/req','view1',2,'采购需求审核-采购需求详情',1,'M00004');
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/tdp/puc/req' and  method='view2' and mkid='M011515' and  sid='M00004';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
			values('M011515','/tdp/puc/req','view2',2,'采购需求明细-采购需求详情',1,'M00004');
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxsz where  sid='M00004' and  mkid='M011510' and  url='/tdp/puc/req/approve/list.do';
  	if num=1 then
        update bs_qxsz a set a.inurl = a.inurl || '#/tdp/puc/req/view1.do' where a.sid='M00004' and a.mkid='M011510' and a.url='/tdp/puc/req/approve/list.do';
    end if;
	
	num:=0;
  	select count(1) into num from bs_qxsz where  sid='M00004' and  mkid='M011515' and  url='/tdp/puc/req/query/list.do';
  	if num=1 then        
		update bs_qxsz a set a.inurl = a.inurl || '#/tdp/puc/req/view2.do' where a.sid='M00004' and a.mkid='M011515' and a.url='/tdp/puc/req/query/list.do';
    end if;
	
	
	num:=0;
		select count(1) into num from bs_xtmk where  sid='M00004' and  mid='M0180' and mname='卖方报价';
		if num=1 then        
			update bs_xtmk a set a.ordby='201' where sid='M00004' and  mid='M0180' and mname='卖方报价';
	end if;
	
	
	-- 2014/11/13	hanglong	订单监察	start
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M018535' and mid='M0185' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M018535','M0185','监察管理中心','订单监察','/exp/contract/ddjc/list.do','/exp/contract/ddjc/list.do#/exp/contract/ddjc/export.do',1,50,1,'M00201');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/contract/ddjc' and  method='list' and mkid='M018535' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M018535','/exp/contract/ddjc','list',2,'订单监察-列表',1,'M00201');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/contract/ddjc' and  method='export' and mkid='M018535' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M018535','/exp/contract/ddjc','export',2,'订单监察-导出',1,'M00201');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M01853505' and mid='M0185' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01853505','M0185','订单监察','暂停','','',2,50,1,'M018535','M00201');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/contract/ddjc' and  method='doPause' and mkid='M01853505' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M01853505','/exp/contract/ddjc','doPause',2,'订单监察-暂停',1,'M00201');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M01853510' and mid='M0185' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01853510','M0185','订单监察','恢复','','',2,100,1,'M018535','M00201');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/contract/ddjc' and  method='doRecover' and mkid='M01853510' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('M01853510','/exp/contract/ddjc','doRecover',2,'订单监察-恢复',1,'M00201');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='B01150525' and mid='B0115' and sid='B00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01150525','B0115','订单查询','暂停','','',2,150,2,'B011505','B00201');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exm/contract/shop/manage' and  method='doPause' and mkid='B01150525' and  sid='B00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01150525','/exm/contract/shop/manage','doPause',2,'订单查询-暂停',2,'B00201');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='B01150530' and mid='B0115' and sid='B00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01150530','B0115','订单查询','恢复','','',2,200,2,'B011505','B00201');
	end if;
	
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exm/contract/shop/manage' and  method='doRecover' and mkid='B01150530' and  sid='B00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('B01150530','/exm/contract/shop/manage','doRecover',2,'订单查询-恢复',2,'B00201');
    end if;
	
	--- end	---

	-- 2014/11/16	hanglong	获得首页顶部页面
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/' and  method='headWeb' and mkid='0' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','headWeb',0,'获得首页顶部页面',1,'M00201');
    end if;
    
    -- 2014/11/16	hanglong	获得热门晒单页面
	num:=0;
  	select count(1) into num from bs_qxmx where  action='/' and  method='rmsdList' and mkid='0' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
		values('0','/','rmsdList',0,'获得热门晒单页面',1,'M00201');
    end if;
    
    
    --2014-11-17   huangjunyi   询价申请内部审核
 	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01700510' and action ='/exp/querybusiness/buy' and method='donbsh';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01700510' , '/exp/querybusiness/buy', 'donbsh' , 2, '申请内部审核', 1, 'M00004');
    END IF;
    
    
     num:=0;
     select count(1) into num from bs_qxsz  where mkid='M017010' and sid='M00004' and mid='M0170';    
     if num = 0 then
        insert into bs_qxsz values ('M017010','M0170','询价单审核','询价单审核','/exp/querybusiness/buy/nbshlist.do','/exp/querybusiness/buy/nbshlist.do',1,300,1,'','M00004');
   end if;
   
   
   num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M017010' and action ='/exp/querybusiness/buy' and method='nbshlist';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M017010' , '/exp/querybusiness/buy', 'nbshlist' , 2, '内部审核列表', 1, 'M00004');
    END IF;
    
   num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M017010' and action ='/exp/querybusiness/buy' and method='reject';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M017010' , '/exp/querybusiness/buy', 'reject' , 2, '内部审核拒绝', 1, 'M00004');
    END IF;


    -- huangjunyi end
	
	
	
   --2014-11-20    suping     修改初始库存值维护为初始库存维护
    num:=0;
	select count(1) into num from bs_xtmk where mid='M0370' and sid='M00004';
	if num = 1 then 
		 update bs_xtmk set mname ='初始库存维护' where  sid = 'M00004' and mid='M0370';  
		   END IF;
       
     num:=0;
		select count(1) into num from  bs_qxsz where   sid = 'M00004' and mid='M0370' and   mkid='M037005' ;
	if num = 1 then 
	update bs_qxsz set mname ='初始库存维护',name='初始库存维护' where   sid = 'M00004' and mid='M0370' and   mkid='M037005'  ;
     END IF;
    -- end

	---wxd 2014/11/21添加保密协议权限
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/hangsource/buy/createbill' and  method='viewBmxy' and styp=1 and mkid='M01050505' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M01050505','/exp/hangsource/buy/createbill','viewBmxy',2,'资源选购：保密协议',1,'M00201');
    end if;
    ----end-----wxd 2014/11/21添加保密协议权限

	---wxd 2014/11/24添加查看保密协议权限
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/contract/template' and  method='bmxypreview' and styp=1 and mkid='0' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'0','/exp/contract/template','bmxypreview',0,'合同模版：保密协议',1,'M00201');
    end if;
    ----end-----wxd 2014/11/24添加查看保密协议权限

	---wxd 2014/11/25添加卖家确认保密协议权限
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/hangsource/buy/createbill' and  method='checkBmxy' and styp=1 and mkid='M01050505' and  sid='M00201';
  	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M01050505','/exp/hangsource/buy/createbill','checkBmxy',2,'卖家确认保密协议',1,'M00201');
    end if;
    ----end-----wxd 2014/11/25

	--huangjunyi  2014/11/27  供应商注册异步上传Excel文件
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='0' and action ='/bsp/supplier/reg' and method='fileajax';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, '0' , '/bsp/supplier/reg', 'fileajax' , 0, 'ajax读取excel文件', 1, 'M00000');
    END IF;
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00000' and mkid='0' and action ='/bsp/supplier/reg' and method='downLoadModel';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, '0' , '/bsp/supplier/reg', 'downLoadModel' , 0, '下载商品模版', 1, 'M00000');
    END IF;


    --huangjunyi end 


	--huangjunyi  2014-12-01 会员审核下载产品信息附件
	num:=0;
       select count (1) into num from  bs_qxmx where sid='B00000' and mkid='0' and action ='/bsp/supplier/regaudit' and method='downLoadFile';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, '0' , '/bsp/supplier/regaudit', 'downLoadFile' , 0, '下载商品附件', 2, 'B00000');
    END IF;
	--huangjunyi end

	-- 2014/12/1	hanglong 	合同管理中所有模块添加查看合同功能
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013001' and action ='/tdp/trail/pccontract' and method='showContract';     
	if num = 0 then
		update bs_qxsz t set inurl = inurl || '#/tdp/trail/pccontract/showContract.do' where t.sid='M00004' and mid='M0130' and mkid='M013001';
		update bs_qxsz t set inurl = inurl || '#/tdp/trail/pccontract/showContract.do' where t.sid='M00004' and mid='M0135' and mkid='M013505';
		update bs_qxsz t set inurl = inurl || '#/tdp/trail/pccontract/showContract.do' where t.sid='M00004' and mid='M0140' and mkid='M014005';
		update bs_qxsz t set inurl = inurl || '#/tdp/trail/pccontract/showContract.do' where t.sid='M00004' and mid='M0145' and mkid='M014505';
		update bs_qxsz t set inurl = inurl || '#/tdp/trail/pccontract/showContract.do' where t.sid='M00004' and mid='M0150' and mkid='M015005';
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013001' , '/tdp/trail/pccontract', 'showContract' , 1, '查看合同', 1, 'M00004');
	END IF;
	--- end ---

	-- 2014/12/2	wxd  采购后台导航问题
	num:=0;
	select count (1) into num from  bs_qxsz where sid='B00004' and  mid='B0145' and mkid='B014520' and regexp_like(inurl,'[/exm/querybusiness/manager/ggshlist.do#/exm/querybusiness/manager/issue.do#/exm/querybusiness/manager/cancelIssue.do]');     
	if num = 0 then
		update bs_qxsz t set inurl = inurl || '#/exm/querybusiness/manager/issue.do#/exm/querybusiness/manager/cancelIssue.do' where t.sid='B00004' and mid='B0145' and mkid='B014520';
	END IF;
	--- end ---

	-- 2014/12/03	hanglong 网上超市库存管理	start--
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00201' and mid='M0190';
	if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0190','库存管理',1,1000,'M00201','201-7');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M019005' and mid='M0190' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M019005','M0190','库存管理','商品入库','/exp/stock/goods/storage/list.do','/exp/stock/goods/storage/list.do',1,100,1,'M00201');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M019010' and mid='M0190' and sid='M00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M019010','M0190','库存管理','库存管理','/exp/stock/manager/list.do','/exp/stock/manager/list.do',1,200,1,'M00201');
	end if;
	--- end ---

	-- 2014/12/4	wxd  采购后台导航问题 bug 27943
	num:=0;
	select count (1) into num from  bs_qxsz where sid='B00004' and  mid='B0145' and mkid='B014520' and regexp_like(inurl,'[/exm/querybusiness/manager/result/ggshlist.do#/exm/querybusiness/manager/result/issue.do#/exm/querybusiness/manager/result/cancelIssue.do]') and url='/exm/querybusiness/manager/result/ggshlist.do';     
	if num = 0 then
		update bs_qxsz t set url='/exm/querybusiness/manager/result/ggshlist.do',inurl = '/exm/querybusiness/manager/result/ggshlist.do#/exm/querybusiness/manager/result/issue.do#/exm/querybusiness/manager/result/cancelIssue.do' where t.sid='B00004' and mid='B0145' and mkid='B014520';
	END IF;
	
	num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action ='/exm/querybusiness/manager/result' and method='cancelIssue';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014520' , '/exm/querybusiness/manager/result', 'cancelIssue' , 2, '询价结果公告-撤销公告', 2, 'B00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action ='/exm/querybusiness/manager/result' and method='ggshlist';     
       if num = 0 then
             update bs_qxmx t set t.action='/exm/querybusiness/manager/result' where t.sid='B00004' and t.mkid='B014520' and t.method='ggshlist' and t.styp='2';
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action ='/exm/querybusiness/manager/result' and method='issue';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014520' , '/exm/querybusiness/manager/result', 'issue' , 2, '询价结果公告-发布公告', 2, 'B00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action ='/exm/querybusiness/manager/result' and method='showTd';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014520' , '/exm/querybusiness/manager/result', 'showTd' , 2, '询价结果公告查看', 2, 'B00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='B00004' and mkid='B014520' and action ='/exm/querybusiness/manager/result' and method='showchujia';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014520' , '/exm/querybusiness/manager/result', 'showchujia' , 2, '询价结果公告-查看出价信息', 2, 'B00004');
    END IF;
	--- end ---

	-- 2014/12/5	wxd  询价单信息显示
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M017005' and action ='/exp/querybusiness/buy' and method='showTd';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M017005' , '/exp/querybusiness/buy', 'showTd' , 2, '显示询价单信息', 1, 'M00004');
    END IF;
	-- end ---

    --2014/12/5   hjy  商品入库页面
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'list' , 2, '商品入库列表', 1, 'M00201');
    END IF;
    --- end ---

    --- 2014/12/08  hjy  商品入库导入页面和导入操作
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='toimport';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'toimport' , 2, '商品入库手动导入列表', 1, 'M00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='doimport';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'doimport' , 2, '商品入库手动导入', 1, 'M00201');
    END IF;

    --- hjy end ---

    --- 2014/12/09  huangjunyi  商品入库主表，入库明细表数据删除  

     num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='deleteStorage';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'deleteStorage' , 2, '商品入库主表删除', 1, 'M00201');
     END IF;
     
     num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='deletemx';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'deletemx' , 2, '商品入库明细删除', 1, 'M00201');
     END IF;
    
    --- hjy end

	--- 2014/12/10  wxd  自动入库功能
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='category' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'category' , 2, '自动入库页面', 1, 'M00201');
    END IF;
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='getCategory' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'getCategory' , 2, '获取子类', 1, 'M00201');
    END IF;
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019005' and action ='/exp/stock/goods/storage' and method='autoImport' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019005' , '/exp/stock/goods/storage', 'autoImport' , 2, '自动入库功能', 1, 'M00201');
    END IF;
    
	----end---

    ---2014/12/10 hjy 库存管理 

    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019010' and action ='/exp/stock/manager' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019010' , '/exp/stock/manager', 'list' , 2, '库存管理', 1, 'M00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019010' and action ='/exp/stock/manager' and method='addStorageManage';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019010' , '/exp/stock/manager', 'addStorageManage' , 2, '调整到库存维护页面', 1, 'M00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019010' and action ='/exp/stock/manager' and method='doaddStorageManage';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019010' , '/exp/stock/manager', 'doaddStorageManage' , 2, '执行库存维护', 1, 'M00201');
    END IF;

    ---end hjy---
	--- 2014/12/11  wxd  外部合同必须唯一
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='checkColumn' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'checkColumn' , 2, '检查外部合同必须唯一性', 1, 'M00004');
    END IF;
    ---- end wxd 20141211-----



     ---2014/12/12 hjy 是否允许供应商查看库存情况

    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019010' and action ='/exp/stock/manager' and method='changeopentosup';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M019010' , '/exp/stock/manager', 'changeopentosup' , 2, '更改库存对供应商开放状态', 1, 'M00201');
    END IF;
    
    
    -- end

    --- 2014/12/12  wxd  跳转至物资详情页面
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='towzxq' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'towzxq' , 2, '物资详情页面', 1, 'M00004');
    END IF;
    ---- end wxd 20141212-----


      ---2014/12/13 hjy 获取子集团或直管单位

    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013001' and action ='/tdp/trail/pccontract' and method='getzgdw';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013001' , '/tdp/trail/pccontract', 'getzgdw' , 2, '获取子集团或直管单位', 1, 'M00004');
    END IF;
    
    
    -- end

	num:=0;
       select count (1) into num from  bs_system where sid='M00050' and sname ='积分平台';    
       if num = 0 then
      insert into bs_system ( SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00 , URL01 , URL02 , URL03 , URL04)
 	values('M00050','积分平台','积分','1','/me/home/index.do','920','http://sc.td.dev.steel56.com.cn/scplatform','/login/index.do','/auth/noAuth.do','/login/doLogout.do','_scSystem');
	end if;

	num:=0;
       select count (1) into num from  bs_system where sid='B00050' and sname ='积分平台';    
       if num = 0 then
      insert into bs_system ( SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00 , URL01 , URL02 , URL03 , URL04)
 	values('B00050','积分平台','积分','2','/admin/index.do','930','http://sc.td.dev.steel56.com.cn/scmanager','/admin/login/index.do','/admin/noAuth.do','/admin/login/doLogout.do','_scSystem'); 
	end if;   
	
	--- 2014/12/13  wxd  ajax通过物资名称，型号，规格，标准返回物资编码
  	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='getwzdm' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'getwzdm' , 2, 'ajax通过物资名称，型号，规格，标准返回物资编码', 1, 'M00004');
    END IF;
    ---- end wxd 20141213-----


    ---20141215 hjy   设置企业消耗月报导入时的inurl
    	num:=0;
       select count (1) into num from  bs_qxsz where sid='M00004' and mkid='M022585' ;     
       if num = 1 then

    update bs_qxsz set inurl='/tdp/report/goodsdetail/list.do#/tdp/report/goodsdetail/toImportGoods.do' where mkid='M022585' and sid='M00004';
     END IF;
    --- end 

	
		     
	  --20141216 suping 集团分类-左边
	 	num:=0;
	  select count(1) into num from bs_qxsz where mkid='B010535' and mid='B0105' and styp=2 and sid='B00004';
		if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
			values('B010535','B0105','集团分类设置','集团分类设置','/exm/basesetup/setjtfl/list.do','/exm/basesetup/setjtfl/list.do#/exm/basesetup/setjtflChild/secondList.do',1,600,2,'B00004');
		end if;
	
      --集团分类列表
		num:=0;
	   select count(1) into num from bs_qxmx where mkid='B010535' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B010535','/exm/basesetup/setjtfl','list',1,'集团分类列表',2,'B00004');
	  end if;
	
	
     --集团分类跳转新增页面
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtfl' and  method='toAdd' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtfl','toAdd',1,'集团分类跳转新增页面',2,'B00004');
	  end if;
	  
	  --集团分类新增
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtfl' and  method='save' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtfl','save',1,'集团分类新增',2,'B00004');
	  end if;
	  
     --集团分类跳转编辑页面
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setjtfl' and  method='toEdit' and styp=2  and  mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtfl','toEdit',1,'集团分类跳转编辑页面',2,'B00004');
	  end if;
	  
	  --集团分类编辑
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setjtfl' and  method='update' and styp=2  and  mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtfl','update',1,'集团分类编辑',2,'B00004');
	  end if;
	  
     --集团分类删除
	     num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setjtfl' and  method='delete' and styp=2  and mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtfl','delete',1,'集团分类删除',2,'B00004');
	  end if;  
	
	  --集团二级子类列表 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='secondList' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','secondList',1,'集团二级子类列表',2,'B00004');
	  end if;
	  
	  
	    --三级、四级子类列表
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='thirdList' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','thirdList',1,'三级、四级子类列表',2,'B00004');
	  end if;
	  
	    --跳转新增集团分类子类页面
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='toAdd' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','toAdd',1,'跳转新增集团分类子类页面',2,'B00004');
	  end if;
	  
	    --新增集团分类子类
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='save' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','save',1,'新增集团分类子类',2,'B00004');
	  end if;
	  
	    --修改集团分类子类 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='update' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','update',1,'修改集团分类子类',2,'B00004');
	  end if;
	  
	    --删除集团分类子类 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setjtflChild' and  method='delete' and styp=2  and   mkid='B01053505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01053505','/exm/basesetup/setjtflChild','delete',1,'删除集团分类子类',2,'B00004');
	  end if;
	  
	     
	  --统计分类-左边
	 	num:=0;
	  select count(1) into num from bs_qxsz where mkid='B010545' and mid='B0105' and styp=2 and sid='B00004';
		if num=0 then
			insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
			values('B010545','B0105','统计分类设置','统计分类设置','/exm/basesetup/setcountfl/list.do','/exm/basesetup/setcountfl/list.do#/exm/basesetup/setcountflChild/secondList.do',1,700,2,'B00004');
		end if;
	
      --统计分类列表
		num:=0;
	   select count(1) into num from bs_qxmx where mkid='B010545' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B010545','/exm/basesetup/setcountfl','list',1,'统计分类列表',2,'B00004');
	  end if;
	
	
     --统计分类跳转新增页面
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountfl' and  method='toAdd' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountfl','toAdd',1,'统计分类跳转新增页面',2,'B00004');
	  end if;
	  
	  --统计分类新增
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountfl' and  method='save' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountfl','save',1,'统计分类新增',2,'B00004');
	  end if;
	  
      --统计分类跳转编辑页面
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setcountfl' and  method='toEdit' and styp=2  and  mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountfl','toEdit',1,'统计分类跳转编辑页面',2,'B00004');
	  end if;
	  
	  --统计分类编辑
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setcountfl' and  method='update' and styp=2  and  mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountfl','update',1,'统计分类编辑',2,'B00004');
	  end if;
	  
     --统计分类删除
	     num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setcountfl' and  method='delete' and styp=2  and mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountfl','delete',1,'统计分类删除',2,'B00004');
	  end if;  
	 
	  --统计分类二级子类列表 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='secondList' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','secondList',1,'统计分类二级子类列表',2,'B00004');
	  end if;
	  
	  
	    --三级、四级子类列表
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='thirdList' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','thirdList',1,'三级、四级子类列表',2,'B00004');
	  end if;
	  
	    --跳转新增统计分类子类页面
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='toAdd' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','toAdd',1,'跳转新增统计分类子类页面',2,'B00004');
	  end if;
	  
	    --新增统计分类子类
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='save' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','save',1,'新增统计分类子类',2,'B00004');
	  end if;
	  
	    --修改统计分类子类 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='update' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','update',1,'修改统计分类子类',2,'B00004');
	  end if;
	  
	    --删除统计分类子类 
	 num:=0;
	   select count(1) into num from bs_qxmx where   action='/exm/basesetup/setcountflChild' and  method='delete' and styp=2  and   mkid='B01054505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01054505','/exm/basesetup/setcountflChild','delete',1,'删除统计分类子类',2,'B00004');
	  end if;
	  
	  
    --集团分类树弹出选择框
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/market/publicfun' and  method='getJtflTree' and styp=1  and  mkid='0' and  sid='M00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/market/publicfun','getJtflTree',1,'集团分类树弹出选择框',1,'M00004');
	  end if;
    --统计分类树弹出选择框
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/market/publicfun' and  method='getCountflTree' and styp=1  and  mkid='0' and  sid='M00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/market/publicfun','getCountflTree',1,'统计分类树弹出选择框',1,'M00004');
	  end if;
	  
	  
	  
	  
    --集团分类树弹出选择框--后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setjtfl' and  method='getJtflTree' and styp=2  and  mkid='0' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/exm/basesetup/setjtfl','getJtflTree',1,'集团分类树弹出选择框--后台',2,'B00004');
	  end if;
	  
    --统计分类树弹出选择框--后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setjtfl' and  method='getCountflTree' and styp=2  and  mkid='0' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/exm/basesetup/setjtfl','getCountflTree',1,'统计分类树弹出选择框--后台',2,'B00004');
	  end if;
	  
	  --物资代码弹出选择-前台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/market/publicfun' and  method='wzdmpage' and styp=1 and  mkid='0' and  sid='M00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/market/publicfun','wzdmpage',1,'物资代码弹出选择-前台',1,'M00004');
	  end if;
	  --物资供应商弹出选择-后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/admin/publicfun' and  method='menber' and styp=2 and  mkid='0' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'0','/admin/publicfun','menber',1,'物资供应商弹出选择-后台',2,'B00004');
	  end if;
	  --物资代码导入跳转--后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setwzdm' and  method='getBrowseFile' and styp=2 and  mkid='B01051505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01051505','/exm/basesetup/setwzdm','getBrowseFile',2,'物资代码导入跳转',2,'B00004');
	  end if;
	   --物资代码模板下载--后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setwzdm' and  method='downLoadModel' and styp=2 and  mkid='B01051505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01051505','/exm/basesetup/setwzdm','downLoadModel',2,'物资代码模板下载',2,'B00004');
	  end if;
	 
	   --物资代码导入--后台
	  num:=0;
	   select count(1) into num from bs_qxmx where action='/exm/basesetup/setwzdm' and  method='importFile' and styp=2 and  mkid='B01051505' and  sid='B00004';
		if num=0 then
	  insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
	    values(bs_qxmx_0.nextval,'B01051505','/exm/basesetup/setwzdm','importFile',2,'物资代码导入',2,'B00004');
	  end if;
	    
	   --物资代码显示左边-后台
	 	num:=0;
	  select count(1) into num from bs_qxsz where mkid='B010515' and mid='B0105' and styp=2 and sid='B00004';
		if num=1 then
	  update bs_qxsz set inurl ='#/exm/basesetup/setwzdm/list.do#/exm/basesetup/setwzdm/getBrowseFile.do#/exm/basesetup/setwzdm/importFile.do' where  mkid='B010515' and mid='B0105' and styp=2 and sid='B00004';
	  end if;
	
	--物资会员选择-前台
      num:=0;
       select count(1) into num from bs_qxmx where action='/market/publicfun' and  method='menberhy' and styp=1 and  mkid='0' and  sid='M00004';
      if num=0 then
      insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'0','/market/publicfun','menberhy',1,'物资会员选择-前台',1,'M00004');
      end if;
      
     -----suping  end

     ---20141217  hjy  添加集中采购时目录选择
       num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action ='/tdp/puc/concentration/req' and method='categoryCountfl';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M03400505' , '/tdp/puc/concentration/req', 'categoryCountfl' , 2, '需求计划编制-通过统计分类进入类目选择页面', 1, 'M00004');
      END IF;
      
      
       num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='0' and action ='/gb/hangsource/sell/publish' and method='getCategoryCountfl';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, '0' , '/gb/hangsource/sell/publish', 'getCategoryCountfl' , 1, 'ajax获得类目统计分类', 1, 'M00004');
      END IF;

     --- end

	 --- 2014/12/17  wxd  模糊查询功能
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='getLikeResult' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'getLikeResult' , 2, ' 模糊查询功能', 1, 'M00004');
    END IF;
    ---- end wxd 20141217-----


    ---2014/12/18 hjy 审批流获得合同签订审批领导

    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013001' and action ='/tdp/trail/pccontract' and method='getspl';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013001' , '/tdp/trail/pccontract', 'getspl' , 2, '审批流获得合同签订审批领导', 1, 'M00004');
    END IF;
    
    
    -- end

	---2014/12/18 hanglong 下载物资编码模板
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300120' and action ='/tdp/trail/pccontract' and method='downWzbmTemplate';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01300120' , '/tdp/trail/pccontract', 'downWzbmTemplate' , 2, '下载物资编码模板', 1, 'M00004');
    END IF;
    -- end

	---2014/12/18 hjy 查看合同物资明细

    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300120' and action ='/tdp/trail/pccontract' and method='showInfoMx';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300120' , '/tdp/trail/pccontract', 'showInfoMx' , 2, '查看合同物资明细', 1, 'M00004');
    END IF;
    
    
    -- end

 	--- 2014/12/22  wxd  合同编辑初始化物资详情
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='initEditWzxq' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'initEditWzxq' , 2, '合同编辑初始化物资详情', 1, 'M00004');
    END IF;
    ---- end wxd 20141222-----

	--- 2014/12/24  hanglong  网超后台设置挂牌商品的市场价和参考价
	num:=0;
	select count (1) into num from  bs_qxmx where sid='B00201' and mkid='B010505' and action ='/exm/hangsource/hangadmin' and method='doScjAndCkj';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010505' , '/exm/hangsource/hangadmin', 'doScjAndCkj' , 2, '设置挂牌商品的市场价和参考价', 2, 'B00201');
    END IF;
    --- end ---

	--- 2014/12/25  hanglong  网超前台修改上架商品库存
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M011015' and action ='/exp/hangsource/sell/hangadmin' and method='toEditKC';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011015' , '/exp/hangsource/sell/hangadmin', 'toEditKC' , 2, '网超前台修改上架商品库存', 1, 'M00201');
    END IF;
    --- end ---


    -- 2014/12/25	hjy  审批流设置，查看关系图导航问题
	num:=0;
	select count (1) into num from  bs_qxsz where sid='M00000' and  mid='M0100' and mkid='M011510' and inurl='/bsp/menber/checkgroup/list.do#/bsp/menber/checkgroupopt/list.do#//bsp/menber/checkgroupopt/viewMap.do';     
	if num = 1 then
		update bs_qxsz t set inurl =inurl ||'#/bsp/menber/checkgroup/viewMap.do' where t.sid='M00000' and mid='M0100' and mkid='M011510';
	END IF;
	--- end ---

    -- 2014/12/26	hjy  审批流设置，查看关系图导航问题
	num:=0;
	select count (1) into num from  bs_qxsz where sid='M00004' and  mid='M0225' and mkid='M022515' and inurl='/tdp/report/pccontractMx/list.do';     
	if num = 1 then
		update bs_qxsz t set inurl =inurl ||'#/tdp/report/pccontractMx/showInfo.do' where t.sid='M00004' and mid='M0225' and mkid='M022515';
	END IF;
	--- end ---

	--- 2014/12/26  hanglong  网超前台所有操作提醒
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00201' and mkid='0' and action ='/me/home' and method='arYwtx';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0' , '/me/home', 'arYwtx' , 1, '网超前台所有操作提醒', 1, 'M00201');
    END IF;
    --- end ---
    --- 2014/12/26  wxd  合同单位集团树选择功能
	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01300110' and action ='/tdp/trail/pccontract' and method='selectGroupByHy' and styp='1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M01300110' , '/tdp/trail/pccontract', 'selectGroupByHy' , 2, '合同单位集团树选择功能', 1, 'M00004');
    END IF;
    ---- end wxd 20141226-----

    --- 2014/12/26 hjy  合同明细-合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013020' and action ='/tdp/trail/pccontractMx' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013020' , '/tdp/trail/pccontractMx', 'showInfo' , 2, '合同明细--查看合同', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M013020' and inurl like '%/tdp/trail/pccontractMx/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/pccontractMx/showInfo.do' where t.sid='M00004' and mkid='M013020' ;
     END IF;
    --- end  

    --- 2014/12/29 hjy  交货预警--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013520' and action ='/tdp/trail/warning' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013520' , '/tdp/trail/warning', 'showInfo' , 2, '交货预警--查看合同', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M013520' and inurl like '%/tdp/trail/warning/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/warning/showInfo.do' where t.sid='M00004' and mkid='M013520' ;
     END IF;
    --- end  

	--- 2014/12/29 hjy  交货登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013505' and action ='/tdp/trail/deliver' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013505' , '/tdp/trail/deliver', 'showInfo' , 2, '交货登记--查看合同', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M013505' and inurl like '%/tdp/trail/deliver/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/deliver/showInfo.do' where t.sid='M00004' and mkid='M013505' ;
     END IF;
    --- end  

    --- 2014/12/29 hjy  交货明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M013510' and action ='/tdp/trail/deliverDtl' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M013510' , '/tdp/trail/deliverDtl', 'showInfo' , 2, '交货明细--查看合同', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M013510' and inurl like '%/tdp/trail/deliverDtl/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/deliverDtl/showInfo.do' where t.sid='M00004' and mkid='M013510' ;
     END IF;
    --- end  

    --- 2014/12/29 hjy  发货登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M014005' and action ='/tdp/trail/send' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M014005' , '/tdp/trail/send', 'showInfo' , 2, '发货登记--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M014005' and inurl like '%/tdp/trail/send/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/send/showInfo.do' where t.sid='M00004' and mkid='M014005' ;
     END IF;
    --- end  
	
	 --- 2014/12/29 hjy  发货明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M014010' and action ='/tdp/trail/sendDtl' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M014010' , '/tdp/trail/sendDtl', 'showInfo' , 2, '发货明细--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M014010' and inurl like '%/tdp/trail/sendDtl/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/sendDtl/showInfo.do' where t.sid='M00004' and mkid='M014010' ;
     END IF;
    --- end  

	 --- 2014/12/29 hjy  到货登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M014505' and action ='/tdp/trail/receive' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M014505' , '/tdp/trail/receive', 'showInfo' , 2, '到货登记--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M014505' and inurl like '%/tdp/trail/receive/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/receive/showInfo.do' where t.sid='M00004' and mkid='M014505' ;
     END IF;
    --- end  


	 --- 2014/12/29 hjy  到货明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M014510' and action ='/tdp/trail/receiveDtl' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M014510' , '/tdp/trail/receiveDtl', 'showInfo' , 2, '到货明细--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M014510' and inurl like '%/tdp/trail/receive/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/receive/showInfo.do' where t.sid='M00004' and mkid='M014510' ;
     END IF;
    --- end 

	 --- 2014/12/29 hjy  验收登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015005' and action ='/tdp/trail/warehouse' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015005' , '/tdp/trail/warehouse', 'showInfo' , 2, '验收登记--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015005' and inurl like '%/tdp/trail/warehouse/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/warehouse/showInfo.do' where t.sid='M00004' and mkid='M015005' ;
     END IF;
    --- end 

	 --- 2014/12/29 hjy  验收明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015015' and action ='/tdp/trail/warehouseDtl' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015015' , '/tdp/trail/warehouseDtl', 'showInfo' , 2, '验收明细--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015015' and inurl like '%/tdp/trail/warehouseDtl/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/warehouseDtl/showInfo.do' where t.sid='M00004' and mkid='M015015' ;
     END IF;
    --- end 

	 --- 2014/12/29 hjy  支付计划--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015520' and action ='/tdp/trail/payplan' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015520' , '/tdp/trail/payplan', 'showInfo' , 2, '支付计划--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015520' and inurl like '%/tdp/trail/payplan/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/payplan/showInfo.do' where t.sid='M00004' and mkid='M015520' ;
     END IF;
    --- end 

     --- 2014/12/29 hjy  支付登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015505' and action ='/tdp/trail/pay' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015505' , '/tdp/trail/pay', 'showInfo' , 2, '支付登记--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015505' and inurl like '%/tdp/trail/pay/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/pay/showInfo.do' where t.sid='M00004' and mkid='M015505' ;
     END IF;
    --- end 
    
    --- 2014/12/29 hjy  支付明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015515' and action ='/tdp/trail/payInfo' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015515' , '/tdp/trail/payInfo', 'showInfo' , 2, '支付明细--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015515' and inurl like '%/tdp/trail/payInfo/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/payInfo/showInfo.do' where t.sid='M00004' and mkid='M015515' ;
     END IF;
    --- end 

    --- 2014/12/29 hjy  支付预警--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M015505' and action ='/tdp/trail/pay' and method='showInfo1';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M015505' , '/tdp/trail/pay', 'showInfo1' , 2, '支付预警--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M015525' and inurl like '%/tdp/trail/pay/showInfo1.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/pay/showInfo1.do' where t.sid='M00004' and mkid='M015525' ;
     END IF;
    --- end 

	--- 2014/12/29 hjy  出库登记--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M016505' and action ='/tdp/trail/out' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M016505' , '/tdp/trail/out', 'showInfo' , 2, '出库登记--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M016505' and inurl like '%/tdp/trail/out/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/out/showInfo.do' where t.sid='M00004' and mkid='M016505' ;
     END IF;
    --- end 

	--- 2014/12/29 hjy  出库明细--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M016515' and action ='/tdp/trail/outDtl' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M016515' , '/tdp/trail/outDtl', 'showInfo' , 2, '出库明细--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M016515' and inurl like '%/tdp/trail/outDtl/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/outDtl/showInfo.do' where t.sid='M00004' and mkid='M016515' ;
     END IF;
    --- end 

	--- 2014/12/29 hjy  库存报表--合同查看导航栏
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M017505' and action ='/tdp/trail/repertory' and method='showInfo';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M017505' , '/tdp/trail/repertory', 'showInfo' , 2, '库存报表--合同查看', 1, 'M00004');
    END IF;
    
     num:=0;
     select count (1) into num from  bs_qxsz where sid='M00004'  and mkid='M017505' and inurl like '%/tdp/trail/repertory/showInfo.do%' ;    
     if num = 0 then
           update bs_qxsz t set inurl =inurl ||'#/tdp/trail/repertory/showInfo.do' where t.sid='M00004' and mkid='M017505' ;
     END IF;
    --- end 

	--- 2014/12/29  hanglong  采购供应商和制造商添加启用和停用功能
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M03200510' and action ='/exp/td/supplier/manager' and method='doDisable';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200510' , '/exp/td/supplier/manager', 'doDisable' , 2, '供应商停用', 1, 'M00004');
    END IF;
    
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M03200510' and action ='/exp/td/supplier/manager' and method='doEnable';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200510' , '/exp/td/supplier/manager', 'doEnable' , 2, '供应商启用', 1, 'M00004');
    END IF;
    
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M03300510' and action ='/exp/td/manufacturer/manager' and method='doDisable';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300510' , '/exp/td/manufacturer/manager', 'doDisable' , 2, '制造商停用', 1, 'M00004');
    END IF;
    
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M03300510' and action ='/exp/td/manufacturer/manager' and method='doEnable';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300510' , '/exp/td/manufacturer/manager', 'doEnable' , 2, '制造商启用', 1, 'M00004');
    END IF;
    --- end ---
      
    --网上超市前台已完成订单评分查看-显示左边-suping

    num:=0;
    select count(1) into num from bs_qxsz where mkid='M010815' and mid='M0108' and styp=1 and sid='M00201';
    if num=1 then
    update bs_qxsz set inurl ='/exp/contract/buy/manage/completedlist.do#/exp/contract/buy/manage/toRated.do' where  mkid='M010815' and mid='M0108' and styp=1 and sid='M00201';
    end if;

     --网上超市前台销售订单操作确认开票-显示左边
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M011220' and mid='M0112' and styp=1 and sid='M00201';
    if num=1 then
    update bs_qxsz set inurl ='/exp/contract/sell/manage/list.do#/exp/delivery/sell/manage/toCreateDelivery.do#/exp/delivery/sell/manage/toNextStep.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toView.do#/exp/contract/sell/tk/toAdd.do#/exp/contract/sell/manage/paymentConfirmPage.do#/exp/dissent/sell/manage/toEdit.do#/exp/entrust/sell/manage/toCreate.do#/exp/entrust/sell/manage/preview.do#/exp/entrust/sell/manage/toUpdate.do#/exp/contract/sell/manage/toConfirmOrder.do#/exp/contract/sell/manage/toDhqr.do#/exp/contract/sell/manage/toDpqr.do#/exp/contract/sell/manage/toDpqr.do' where mkid='M011220' and mid='M0112' and styp=1 and sid='M00201';
    end if;
      --- end ---


	---wxd 20150106 销售平台前台浏览量统计报表

	num:=0;
    select count (1) into num from  bs_qxsz where sid='M00103' and mkid='M012010';    
    if num = 0 then
         insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		 values('M012010','M0120','产品信息','浏览统计','/exp/productInfo/market/view.do',1,250,1,'M00103');
    END IF;
    
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00103' and mkid='M012010' and action ='/exp/productInfo/market' and method='view';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M012010' , '/exp/productInfo/market', 'view' , 2, '浏览统计', 1, 'M00103');
    END IF;
    
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00103' and mkid='M012010' and action ='/exp/productInfo/market' and method='export2Excel';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M012010' , '/exp/productInfo/market', 'export2Excel' , 2, '导出浏览量', 1, 'M00103');
    END IF;
    num:=0;
	select count (1) into num from  bs_qxmx where sid='M00103' and mkid='M012010' and action ='/exp/productInfo/market' and method='detail';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M012010' , '/exp/productInfo/market', 'detail' , 2, '浏览量明细', 1, 'M00103');
    END IF;
    
	---end -----

	---wxd 20150107 销售平台后台浏览量统计报表

    num :=0;
	select count(1) into num from bs_xtmk where mid='B0143' and styp=2 and sid='B00103';
	if num=0 then
		insert into bs_xtmk(mid, mname, styp, ordby, sid)
		values('B0143','浏览统计', 2, 730, 'B00103');
	end if;

	num:=0;
    select count (1) into num from  bs_qxsz where sid='B00103' and mkid='B014300';    
    if num = 0 then
         insert into bs_qxsz (mkid,mid,mname,name,url,isuse,orderno,styp,sid)
		 values('B014300','B0143','浏览统计','产品浏览统计','/exm/productInfo/visit/view.do',1,100,2,'B00103');
    END IF;
    
	num:=0;
	select count (1) into num from  bs_qxmx where sid='B00103' and mkid='B014300' and action ='/exm/productInfo/visit' and method='view';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014300' , '/exm/productInfo/visit', 'view' , 2, '产品浏览统计', 2, 'B00103');
    END IF;
    
    num:=0;
	select count (1) into num from  bs_qxmx where sid='B00103' and mkid='B014300' and action ='/exm/productInfo/visit' and method='export2Excel';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014300' , '/exm/productInfo/visit', 'export2Excel' , 2, '导出浏览量', 2, 'B00103');
    END IF;
    num:=0;
	select count (1) into num from  bs_qxmx where sid='B00103' and mkid='B014300' and action ='/exm/productInfo/visit' and method='detail';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014300' , '/exm/productInfo/visit', 'detail' , 2, '浏览量明细', 2, 'B00103');
    END IF;
    
	---end -----

	num:=0;
    select count (1) into num from  bs_qxsz where sid='M00201' and mid='M0112' and mkid='M011220';    
    if num = 1 then
    	update bs_qxsz set inurl='/exp/contract/sell/manage/list.do#/exp/delivery/sell/manage/toCreateDelivery.do#/exp/delivery/sell/manage/toNextStep.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toEdit.do#/exp/contract/sell/tk/toView.do#/exp/contract/sell/tk/toAdd.do#/exp/contract/sell/manage/paymentConfirmPage.do#/exp/dissent/sell/manage/toEdit.do#/exp/entrust/sell/manage/toCreate.do#/exp/entrust/sell/manage/preview.do#/exp/contract/sell/manage/toConfirmOrder.do#/exp/contract/sell/manage/toDhqr.do#/exp/contract/sell/manage/toDpqr.do#/exp/contract/sell/manage/toDpqr.do' where sid='M00201' and mid='M0112' and mkid='M011220';
    	update bs_qxsz set inurl='/exp/entrust/sell/manage/list.do#/exp/entrust/sell/manage/toEntrustSave.do#/exp/entrust/sell/manage/doEntrustSave.do#/exp/entrust/sell/manage/doDelete.do#/exp/entrust/sell/manage/toUpdate.do' where sid='M00201' and mid='M0112' and mkid='M011225';
    END IF;


	---20150108  huangjunyi 库存管理
    update bs_xtmk  set qxrole = '201-1' where sid='M00201' and mid='M0190' ;
           
    num:=0;
  	select count(1) into num from bs_xtmk where mid='M0380' and sid='M00201';
  	if num=0 then
    	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0380','库存管理',1,1000,'M00201','201-2');
  	end if;
  	
  	num:=0;
     select count(1) into num from bs_qxsz  where mkid='M038005' and sid='M00201' and mid='M0380';    
     if num = 0 then
        insert into bs_qxsz values ('M038005','M0380','库存管理','商品入库','/exp/stock/goods/storagesell/list.do','/exp/stock/goods/storagesell/list.do',1,100,1,'','M00201');
   end if;
   
   num:=0;
     select count(1) into num from bs_qxsz  where mkid='M038010' and sid='M00201' and mid='M0380';    
     if num = 0 then
        insert into bs_qxsz values ('M038010','M0380','库存管理','库存管理','/exp/stock/managersell/list.do','/exp/stock/managersell/list.do',1,200,1,'','M00201');
   end if;
   
   
   
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='list'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','list',2,'商品入库列表',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='toimport'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','toimport',2,'商品入库手动导入列表',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='doimport'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','doimport',2,'商品入库手动导入',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='deleteStorage'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','deleteStorage',2,'商品入库主表删除',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='deletemx'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','deletemx',2,'商品入库明细删除',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='category'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','category',2,'自动入库页面',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='getCategory'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','getCategory',2,'获取子类',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/goods/storagesell' and method='autoImport'  and mkid='M038005' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038005','/exp/stock/goods/storagesell','autoImport',2,'自动入库功能',1,'M00201');
    end if;
    
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='changeopentosup'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','changeopentosup',2,'更改库存对供应商开放状态',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='addStorageManage'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','addStorageManage',2,'调整到库存维护页面',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='doaddStorageManage'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','doaddStorageManage',2,'执行库存维护',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='list'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','list',2,'库存管理',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='doDxSl'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','doDxSl',2,'维护定向库存',1,'M00201');
    end if;
    
    num:=0;
     select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='delDxSl'  and mkid='M038010' and  sid='M00201' ;      
     if num = 0 then
     insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','delDxSl',2,'删除定向库存',1,'M00201');
    end if;
    --- end
	
	-- 2015/01/15	hanglong 	新版本选择会员弹出框权限
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/publicfun' and method='menberNew'  and mkid='0' and  sid='M00000' ;      
	if num = 0 then
		insert into bs_qxmx values(bs_qxmx_0.nextval,'0','/market/publicfun','menberNew',0,'获得会员列表-新页面',1,'M00000');
    end if;
    --- end ---

-- 2015/01/17  wxd   更改保密协议权限
  num:=0;
  select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and method='checkBmxy'  and mkid='M01050505' and  sid='M00201' ;      
	if num = 0 then
		update bs_qxmx set accesstag='1' where action='/exp/hangsource/buy/createbill' and method='checkBmxy'  and mkid='M01050505' and  sid='M00201' ;      
  end if;
    num:=0;
  select count(1) into num from bs_qxmx where action='/exp/hangsource/buy/createbill' and method='viewBmxy'  and mkid='M01050505' and  sid='M00201' ;      
	if num = 0 then
		update bs_qxmx set accesstag='1' where action='/exp/hangsource/buy/createbill' and method='viewBmxy'  and mkid='M01050505' and  sid='M00201' ;      
  end if;
--- end ---

	-- 2015/01/19	hanglong 	判断是否登录
	num:=0;
	select count(1) into num from bs_qxmx where action='/' and method='isLogin'  and mkid='0' and  sid='M00201' ;      
	if num = 0 then
		insert into bs_qxmx values(bs_qxmx_0.nextval,'0','/','isLogin',0,'判断是否登录',1,'M00201');
    end if;
    --- end ---

	-- 2015/01/15	hanglong 	新版本选择会员弹出框权限
	num:=0;
	select count(1) into num from bs_qxmx where action='/market/publicfun' and method='menberNew' and mkid='0' and  sid='M00201' ;      
	if num = 0 then
		insert into bs_qxmx values(bs_qxmx_0.nextval,'0','/market/publicfun','menberNew',0,'获得会员列表-新页面',1,'M00201');
    end if;
    --- end ---

	--2015/01/21  songb  新增-监察管理报表
	num:=0;
  	select count(1) into num from bs_xtmk where mid='M0380' and sid='M00004';
  	if num=0 then
    	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0380','监察管理报表',1,1300,'M00004','005-1');
  	end if;
  	
  	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038015' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038015','M0380','监察管理报表','合同明细报表','/tdp/monitor/report/pccontractMx/list.do','/tdp/monitor/report/pccontractMx/list.do#/tdp/monitor/report/pccontractMx/showInfo.do',1,400,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038025' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038025','M0380','监察管理报表','交货明细报表','/tdp/monitor/report/deliverDtl/list.do','/tdp/monitor/report/deliverDtl/list.do',1,500,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038035' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038035','M0380','监察管理报表','需求明细报表','/tdp/monitor/report/req/list.do','/tdp/monitor/report/req/list.do#/tdp/monitor/report/req/view.do',1,100,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038040' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038040','M0380','监察管理报表','计划明细报表','/tdp/monitor/report/plan/list.do','/tdp/monitor/report/plan/list.do',1,200,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038045' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038045','M0380','监察管理报表','任务明细报表','/tdp/monitor/report/mission/list.do','/tdp/monitor/report/mission/list.do',1,300,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038050' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038050','M0380','监察管理报表','发货明细报表','/tdp/monitor/report/sendDtl/list.do','/tdp/monitor/report/sendDtl/list.do',1,600,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038055' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038055','M0380','监察管理报表','到货明细报表','/tdp/monitor/report/receiveDtl/list.do','/tdp/monitor/report/receiveDtl/list.do',1,700,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038060' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038060','M0380','监察管理报表','验收明细报表','/tdp/monitor/report/warehouseDtl/list.do','/tdp/monitor/report/warehouseDtl/list.do',1,800,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038065' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038065','M0380','监察管理报表','支付明细报表','/tdp/monitor/report/payInfo/list.do','/tdp/monitor/report/payInfo/list.do',1,900,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038070' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038070','M0380','监察管理报表','费用明细报表','/tdp/monitor/report/fee/list.do','/tdp/monitor/report/fee/list.do#/tdp/monitor/report/fee/listMx.do',1,1000,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038075' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038075','M0380','监察管理报表','执行情况报表','/tdp/monitor/report/perfrom/list.do','/tdp/monitor/report/perfrom/list.do#/tdp/monitor/report/perfrom/viewRequirement.do',1,1100,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038080' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038080','M0380','监察管理报表','出库明细报表','/tdp/monitor/report/outDtl/list.do','/tdp/monitor/report/outDtl/list.do',1,850,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038085' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038085','M0380','监察管理报表','企业消耗月报','/tdp/monitor/report/goodsdetail/list.do','/tdp/monitor/report/goodsdetail/list.do#/tdp/report/goodsdetail/toImportGoods.do',1,950,1,'','M00004');
   	end if;
   	
   	num:=0;
    select count(1) into num from bs_qxsz  where mkid='M038090' and sid='M00004' and mid='M0380';    
    if num = 0 then
        insert into bs_qxsz values ('M038090','M0380','监察管理报表','物资采购综合报表','/tdp/monitor/report/qywzcg/list.do','/tdp/monitor/report/qywzcg/list.do',1,960,1,'','M00004');
   	end if;
   	
   	update bs_xtmk set qxrole = '004-5' where mid = 'M0380' and sid = 'M00004';
   	
   	num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/req' and method='list'  and mkid='M038035' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038035','/tdp/monitor/report/req','list',2,'需求明细查询',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/req' and method='view'  and mkid='M038035' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038035','/tdp/monitor/report/req','view',2,'任务明细报表 - 查看',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/pccontractMx' and method='exportExcel'  and mkid='M038015' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038015','/tdp/monitor/report/pccontractMx','exportExcel',2,'合同明细报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/pccontractMx' and method='list'  and mkid='M038015' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038015','/tdp/monitor/report/pccontractMx','list',2,'合同明细报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/pccontractMx' and method='listme'  and mkid='M038015' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038015','/tdp/monitor/report/pccontractMx','listme',2,'企业物资采购统计表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/pccontractMx' and method='showInfo'  and mkid='M038015' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038015','/tdp/monitor/report/pccontractMx','showInfo',2,'合同明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/deliverDtl' and method='exportExcel'  and mkid='M038025' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038025','/tdp/monitor/report/deliverDtl','exportExcel',2,'交货明细报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/deliverDtl' and method='list'  and mkid='M038025' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038025','/tdp/monitor/report/deliverDtl','list',2,'交货明细报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/deliverDtl' and method='showInfo'  and mkid='M038025' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038025','/tdp/monitor/report/deliverDtl','showInfo',2,'交货明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/plan' and method='list'  and mkid='M038040' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038040','/tdp/monitor/report/plan','list',2,'计划明细列表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/plan' and method='view'  and mkid='M038040' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038040','/tdp/monitor/report/plan','view',2,'采购计划详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/mission' and method='list'  and mkid='M038045' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038045','/tdp/monitor/report/mission','list',2,'任务明细列表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/mission' and method='view'  and mkid='M038045' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038045','/tdp/monitor/report/mission','view',2,'采购任务详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/sendDtl' and method='exportExcel'  and mkid='M038050' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038050','/tdp/monitor/report/sendDtl','exportExcel',2,'发货明细报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/sendDtl' and method='list'  and mkid='M038050' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038050','/tdp/monitor/report/sendDtl','list',2,'发货明细报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/sendDtl' and method='showInfo'  and mkid='M038050' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038050','/tdp/monitor/report/sendDtl','showInfo',2,'发货明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/receiveDtl' and method='exportExcel'  and mkid='M038055' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038055','/tdp/monitor/report/receiveDtl','exportExcel',2,'到货报表明细-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/receiveDtl' and method='list'  and mkid='M038055' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038055','/tdp/monitor/report/receiveDtl','list',2,'到货报表明细',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/receiveDtl' and method='showInfo'  and mkid='M038055' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038055','/tdp/monitor/report/receiveDtl','showInfo',2,'到货明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/warehouseDtl' and method='exportExcel'  and mkid='M038060' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038060','/tdp/monitor/report/warehouseDtl','exportExcel',2,'入库明细报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/warehouseDtl' and method='list'  and mkid='M038060' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038060','/tdp/monitor/report/warehouseDtl','list',2,'入库明细报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/warehouseDtl' and method='showInfo'  and mkid='M038060' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038060','/tdp/monitor/report/warehouseDtl','showInfo',2,'入库明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/payInfo' and method='exportExcel'  and mkid='M038065' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038065','/tdp/monitor/report/payInfo','exportExcel',2,'支付明细报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/payInfo' and method='list'  and mkid='M038065' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038065','/tdp/monitor/report/payInfo','list',2,'支付明细报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/payInfo' and method='showInfo'  and mkid='M038065' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038065','/tdp/monitor/report/payInfo','showInfo',2,'支付明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/fee' and method='list'  and mkid='M038070' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038070','/tdp/monitor/report/fee','list',2,'费用明细列表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/fee' and method='listMx'  and mkid='M038070' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038070','/tdp/monitor/report/fee','listMx',2,'费用统计',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='exportExcel'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','exportExcel',2,'执行情况报表-导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='getGoodsList'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','getGoodsList',2,'执行情况报表-跟踪查询',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='list'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','list',2,'执行情况报表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='viewMission'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','viewMission',2,'执行情况报表-任务查询',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='viewPlan'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','viewPlan',2,'执行情况报表-计划查询',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/perfrom' and method='viewRequirement'  and mkid='M038075' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038075','/tdp/monitor/report/perfrom','viewRequirement',2,'执行情况报表-需求查询',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/outDtl' and method='exportExcel'  and mkid='M038080' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038080','/tdp/monitor/report/outDtl','exportExcel',2,'导出',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/outDtl' and method='list'  and mkid='M038080' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038080','/tdp/monitor/report/outDtl','list',2,'出库明细列表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/outDtl' and method='showInfo'  and mkid='M038080' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038080','/tdp/monitor/report/outDtl','showInfo',2,'出库明细报表-查看详情',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/goodsdetail' and method='doImportGoods'  and mkid='M038085' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038085','/tdp/monitor/report/goodsdetail','doImportGoods',2,'导入物资采购消耗统计',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/goodsdetail' and method='downloadGoodsTemplate'  and mkid='M038085' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038085','/tdp/monitor/report/goodsdetail','downloadGoodsTemplate',2,'下载物资采购消耗统计月报模版',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/goodsdetail' and method='list'  and mkid='M038085' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038085','/tdp/monitor/report/goodsdetail','list',2,'物资采购消耗统计月报',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/goodsdetail' and method='toImportGoods'  and mkid='M038085' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038085','/tdp/monitor/report/goodsdetail','toImportGoods',2,'物资采购消耗统计月报导入页面',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/qywzcg' and method='list'  and mkid='M038090' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038090','/tdp/monitor/report/qywzcg','list',2,'企业物资采购统计表',1,'M00004');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/tdp/monitor/report/qywzcg' and method='listme'  and mkid='M038090' and  sid='M00004' ;      
    if num = 0 then
    	insert into bs_qxmx values(bs_qxmx_0.nextval,'M038090','/tdp/monitor/report/qywzcg','listme',2,'企业物资采购统计表',1,'M00004');
    end if;
  	
  	--- end ---
    --买方询价 新建询价类目选择-统计分类 --suping 2015-01-22  ---start
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M01700505' and action='/exp/querybusiness/buy'  and method='categoryCountfl' and  sid='M00004';
    if num = 0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
                      values(bs_qxmx_0.nextval,'M01700505','/exp/querybusiness/buy','categoryCountfl',0,'类目选择-统计分类',1,'M00004');
    end if;
    --end --------------------
	
	-- 2014/01/22	hanglong	卖方库存管理
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M038005' and sid='M00201' and mid='M0380';    
	if num = 1 then
		update bs_qxsz set name='客户存库查看' where mkid='M038005' and sid='M00201' and mid='M0380';    
	end if;
	--- end ---

	-- 2014/01/22	hanglong	买方库存管理
	num:=0;
	select count(1) into num from bs_qxsz  where mkid='M019015' and mid='M0190' and sid='M00201';    
	if num = 0 then
		insert into bs_qxsz values ('M019015','M0190','库存管理','挂牌库存','/exp/stock/dx/list.do','/exp/stock/dx/list.do#/exp/stock/dx/createOrder.do#/exp/stock/dx/toCreateOrder.do',1,300,1,'','M00201');
	end if;
	
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019015' and action ='/exp/stock/dx' and method='list';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M019015' , '/exp/stock/dx', 'list' , 2, '挂牌库存-列表', 1, 'M00201');
	END IF;
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019015' and action ='/exp/stock/dx' and method='toCreateOrder';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M019015' , '/exp/stock/dx', 'toCreateOrder' , 2, '挂牌库存-进入生成订单页面', 1, 'M00201');
	END IF;
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00201' and mkid='M019015' and action ='/exp/stock/dx' and method='createOrder';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M019015' , '/exp/stock/dx', 'createOrder' , 2, '挂牌库存-生成订单', 1, 'M00201');
	END IF;
	--- end ---

	-- 2014/01/22	songb	上传投标资质
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01103005' and action ='/tdp/join/quote' and method='uploadQuality';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01103005' , '/tdp/join/quote', 'uploadQuality' , 2, '招标信息-参与招标-资质上传页面', 1, 'M00004');
	END IF;
	
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M01103005' and action ='/tdp/join/quote' and method='saveQuality';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M01103005' , '/tdp/join/quote', 'saveQuality' , 2, '招标信息-参与招标-保存上传资质', 1, 'M00004');
	END IF;
	
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010515' and action ='/tdp/dev/package' and method='queryQualityList';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M010515' , '/tdp/dev/package', 'queryQualityList' , 2, '招标信息-上传资质审核', 1, 'M00004');
	END IF;
	
	num:=0;
	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010515' and action ='/tdp/dev/package' and method='auditQuality';     
	if num = 0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M010515' , '/tdp/dev/package', 'auditQuality' , 2, '招标信息-上传资质审核', 1, 'M00004');
	END IF;
	
    --合同登记 引用采购任务列表 --suping 2015-01-23  ---start
     num:=0;
     select count(1) into num from bs_qxmx where mkid='M013001' and action='/tdp/trail/pccontract'  and method='getMissionContractList' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'M013001','/tdp/trail/pccontract','getMissionContractList',0,'引用采购任务列表',1,'M00004');
    end if;
    --合同登记 确认引用采购任务
    num:=0;
     select count(1) into num from bs_qxmx where mkid='M013001' and action='/tdp/trail/pccontract'  and method='getMissionContract4Edit' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'M013001','/tdp/trail/pccontract','getMissionContract4Edit',0,'确认引用采购任务',1,'M00004');
    end if;
    --合同登记-引用采购任务-显示左边
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M013001' and mid='M0130' and styp=1 and sid='M00004';
    if num=1 then
    update bs_qxsz set inurl ='/tdp/trail/pccontract/list.do#/tdp/trail/pccontract/showInfo.do#/tdp/trail/pccontract/toAdd.do#/tdp/trail/pccontract/getExtraContractList.do#/tdp/trail/pccontract/getBrowseFile.do#/tdp/trail/pccontract/getExtraContract4Edit.do#/tdp/trail/pccontract/showContract.do#/tdp/trail/pccontract/showContract.do#/tdp/trail/pccontract/showContract.do#/tdp/trail/pccontract/getMissionContractList.do#/tdp/trail/pccontract/getMissionContract4Edit.do' where mkid='M013001' and mid='M0130' and styp=1 and sid='M00004';
    end if;
    --end --------------------

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
