 DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.78'; -- 本升级文件的版本，每个升级文件必须修改
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
   
   --修改集团报表-企业物资采购统计表为物资采购综合报表
  num:=0;
  select count(1) into num from  bs_qxsz where sid = 'M00004' and mid='M0225' and  mkid='M022590';    
  if num = 1 then 
     update bs_qxsz set name ='物资采购综合报表' where sid = 'M00004' and mid='M0225' and  mkid='M022590'; 
    END IF;
    
    --修改集团报表-物资采购消耗统计月报为企业消耗月报
    num:=0;
  select count(1) into num from  bs_qxsz where     sid = 'M00004' and mid='M0225'  and  mkid='M022585';
  if num = 1 then 
     update bs_qxsz set name ='企业消耗月报' where     sid = 'M00004' and mid='M0225'  and  mkid='M022585';
    END IF;

   
    --修改合同登记-企业物资采购统计表隐藏
    num:=0;
	select count(1) into num from  bs_qxsz where   sid = 'M00004' and mid='M0360' and  mkid='M036010';  
	if num = 1 then 
		 update bs_qxsz set isuse ='0' where   sid = 'M00004' and mid='M0360' and  mkid='M036010';
    END IF;
    
    
     --修改询价销售为卖方报价
    num:=0;
		select count(1) into num from  bs_xtmk where   sid = 'M00004' and mid='M0180';  
	if num = 1 then 
		update bs_xtmk set mname ='卖方报价' where    sid = 'M00004' and mid='M0180';  
    
    END IF;
    
      num:=0;
		select count(1) into num from  bs_qxsz where  sid = 'M00004' and mid='M0180' and   mkid='M018005'  ; 
	if num = 1 then 
		update bs_qxsz set mname ='卖方报价'  ,name='卖方报价' where   sid = 'M00004' and mid='M0180' and   mkid='M018005'  ; 
    
    END IF;
    
    --修改询价销售-询价销售审核为报价单审核
	num:=0;
	select count(1) into num from  bs_qxsz where  sid = 'M00004'  and  mid='M0180' and mkid='M018010'  ; 
	if num = 1 then 
		update bs_qxsz set mname ='卖方报价',name='报价单审核' where sid = 'M00004'  and  mid='M0180' and mkid='M018010'  ; 
    END IF;
    
    --修改询价采购为买方询价
    
	num:=0;
	select count(1) into num from  bs_xtmk where  sid = 'M00004' and mid='M0170';  
	if num = 1 then 
		update bs_xtmk set mname ='买方询价' where  sid = 'M00004' and mid='M0170';  
	END IF;
	
	num:=0;
	select count(1) into num from  bs_qxsz where   sid = 'M00004' and mid='M0170' and   mkid='M017005'  ;
	if num = 1 then 
		update bs_qxsz set mname ='买方询价',name='买方询价' where   sid = 'M00004' and mid='M0170' and   mkid='M017005'  ;
	END IF;
    
    --修改卖方报价和买方询价位置
	num:=0;
	select count(1) into num from  bs_qxsz where sid = 'M00004'   and   mid='M0180'; 
	if num = 1 then 
		update  bs_xtmk set ordby ='201' where sid = 'M00004'   and   mid='M0180'; 
	END IF;
    
    -- 2014-10-14 lvcy 合同支付
    update bs_qxsz set mname = '合同收款' where mid = 'M0155' and sid = 'M00103' and styp = '1';
	update bs_qxsz set name = '收款登记' where mid = 'M0155' and sid = 'M00103' and styp = '1' and url = '/exp/trail/pay/list.do';
	update bs_qxsz set name = '收款明细' where mid = 'M0155' and sid = 'M00103' and styp = '1' and url = '/exp/trail/payInfo/list.do';
	update bs_qxsz set name = '收款计划' where mid = 'M0155' and sid = 'M00103' and styp = '1' and url = '/exp/trail/payplan/list.do';
	update bs_qxsz set name = '收款预警' where mid = 'M0155' and sid = 'M00103' and styp = '1' and url = '/exp/trail/pay/warnList.do';
	update bs_qxsz set name = '收款审核' where mid = 'M0155' and sid = 'M00103' and styp = '1' and url = '/exp/trail/audit/list.do';
    
    
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/invoice/buy/manage' and method='delete';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M010712', '/exp/invoice/buy/manage', 'delete', '2','删除发票信息', '1', 'M00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/invoice/buy/manage' and method='save';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M010712', '/exp/invoice/buy/manage', 'save', '2','保存发票信息', '1', 'M00103');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103'  and action='/exp/invoice/buy/manage' and method='toAdd';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M010712', '/exp/invoice/buy/manage', 'toAdd', '2','保存发票信息', '1', 'M00103');
    END IF;
	
	-- 2014/10/15	采购平台集团报表迁移到销售平台	hanglong
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00103' and mid='M0225';
	if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0225','集团报表',1,1000,'M00103','103-5');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022515';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022515','M0225','集团报表','合同明细报表','/tdp/report/pccontractMx/list.do','/tdp/report/pccontractMx/list.do#/tdp/report/pccontractMx/showInfo.do',1,100,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022525';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022525','M0225','集团报表','交货明细报表','/tdp/report/deliverDtl/list.do','/tdp/report/deliverDtl/list.do#/tdp/report/deliverDtl/showInfo.do',1,200,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022550';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022550','M0225','集团报表','发货明细报表','/tdp/report/sendDtl/list.do','/tdp/report/sendDtl/list.do#/tdp/report/sendDtl/showInfo.do',1,300,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022555';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022555','M0225','集团报表','到货明细报表','/tdp/report/receiveDtl/list.do','/tdp/report/receiveDtl/list.do#/tdp/report/receiveDtl/showInfo.do',1,400,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022565';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022565','M0225','集团报表','支付明细报表','/tdp/report/payInfo/list.do','/tdp/report/payInfo/list.do#/tdp/report/payInfo/showInfo.do',1,500,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022515' and action='/tdp/report/pccontractMx' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022515', '/tdp/report/pccontractMx', 'list', 2,'集团报表-合同明细报表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022515' and action='/tdp/report/pccontractMx' and method='exportExcel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022515', '/tdp/report/pccontractMx', 'exportExcel', 2,'集团报表-合同明细报表-导出', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022515' and action='/tdp/report/pccontractMx' and method='showInfo';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022515', '/tdp/report/pccontractMx', 'showInfo', 2,'集团报表-合同明细报表-查看详情', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022525' and action='/tdp/report/deliverDtl' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022525', '/tdp/report/deliverDtl', 'list', 2,'集团报表-交货明细报表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022525' and action='/tdp/report/deliverDtl' and method='exportExcel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022525', '/tdp/report/deliverDtl', 'exportExcel', 2,'集团报表-交货明细报表-导出', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022525' and action='/tdp/report/deliverDtl' and method='showInfo';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022525', '/tdp/report/deliverDtl', 'showInfo', 2,'集团报表-交货明细报表-查看详情', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022550' and action='/tdp/report/sendDtl' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022550', '/tdp/report/sendDtl', 'list', 2,'集团报表-发货明细报表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022550' and action='/tdp/report/sendDtl' and method='exportExcel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022550', '/tdp/report/sendDtl', 'exportExcel', 2,'集团报表-发货明细报表-导出', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022550' and action='/tdp/report/sendDtl' and method='showInfo';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022550', '/tdp/report/sendDtl', 'showInfo', 2,'集团报表-发货明细报表-查看详情', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022555' and action='/tdp/report/receiveDtl' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022555', '/tdp/report/receiveDtl', 'list', 2,'集团报表-到货报表明细', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022555' and action='/tdp/report/receiveDtl' and method='exportExcel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022555', '/tdp/report/receiveDtl', 'exportExcel', 2,'集团报表-到货报表明细-导出', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022555' and action='/tdp/report/receiveDtl' and method='showInfo';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022555', '/tdp/report/receiveDtl', 'showInfo', 2,'集团报表-到货明细报表-查看详情', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022565' and action='/tdp/report/payInfo' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022565', '/tdp/report/payInfo', 'list', 2,'集团报表-支付明细报表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022565' and action='/tdp/report/payInfo' and method='exportExcel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022565', '/tdp/report/payInfo', 'exportExcel', 2,'集团报表-支付明细报表-导出', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022565' and action='/tdp/report/payInfo' and method='showInfo';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022565', '/tdp/report/payInfo', 'showInfo', 2,'集团报表-支付明细报表-查看详情', 1, 'M00103');
    END IF;
	--end
	
	
	num:=0;
	  select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M013030' and action='/exp/audit/pccontract' and method='cancel';      
	  if num = 0 then 
	  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		  values('M013030', '/exp/audit/pccontract', 'cancel', 2,'合同登记-取消审核', 1, 'M00103');
	END IF;
	
	
	-- huangjunyi 更新商城已完成订单

 	num:=0;
  	select count(1) into num from  bs_qxsz where sid = 'M00211' and mid='M0108' and  mkid='M010815';    
  	if num = 1 then 
     update bs_qxsz set inurl ='/exp/contract/buy/manage/completedlist.do#/exp/contract/buy/manage/toRated.do' where sid = 'M00211' and mid='M0108' and  mkid='M010815'; 
    END IF;
   --end

	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M014010' and action='/exp/trail/sendDtl' and method='getGoodsList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M014010', '/exp/trail/sendDtl', 'getGoodsList', 2,'合同跟踪-发货登记-发货明细-已到货量明细', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_xtmk where sid='M00103' and mid='M0155';      
	if num = 1 then 
		update bs_xtmk set mname = '合同收款' where sid='M00103' and mid='M0155';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0155' and mkid='M015505';      
	if num = 1 then 
		update bs_qxsz set name = '收款登记' where sid='M00103' and mid='M0155' and mkid='M015505';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0155' and mkid='M015510';      
	if num = 1 then 
		update bs_qxsz set name = '收款审核' where sid='M00103' and mid='M0155' and mkid='M015510';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0155' and mkid='M015515';      
	if num = 1 then 
		update bs_qxsz set name = '收款明细' where sid='M00103' and mid='M0155' and mkid='M015515';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0155' and mkid='M015520';      
	if num = 1 then 
		update bs_qxsz set name = '收款计划' where sid='M00103' and mid='M0155' and mkid='M015520';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0155' and mkid='M015525';      
	if num = 1 then 
		update bs_qxsz set name = '收款预警' where sid='M00103' and mid='M0155' and mkid='M015525';
    END IF;
	
	num:=0;
	  select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M014010' and action='/exp/trail/sendDtl' and method='exportExcel';      
	  if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
			values('M014010', '/exp/trail/sendDtl', 'exportExcel', 2,'合同跟踪-发货登记-发货明细-批量导出', 1, 'M00103');
    END IF;
	
	--  2014-10-17 lvcy 
	num:=0;
	  select count(1) into num from bs_qxmx where sid='M00000' and mkid='M010515' and action='/bsp/shop/msg' and method='detailQydt';   
	  if num = 0 then 
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('M010515','/bsp/shop/msg','detailQydt','0','商铺企业动态详情','1','M00000');
    END IF;
    
    num:=0;
	  select count(1) into num from bs_qxmx where sid='M00000' and mkid='M010515' and action='/bsp/shop/msg' and method='getQydtList';   
	  if num = 0 then 
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('M010515','/bsp/shop/msg','getQydtList','0','商铺企业动态列表','1','M00000');
    END IF;
	
	--hjw
	num:=0;
	  select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M012005' and action='/exp/productInfo/market' and method='toContact';      
	  if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
			values('M012005', '/exp/productInfo/market', 'toContact', 0,'产品信息-联系我们', 1, 'M00103');
    END IF;
	
	
	
	-- end

     -- huangjunyi    网上商城未登录用户可以查看商品详情和商品分类
	num:=0;
	select count(1) into num from bs_qxmx where  action='/exp/hangsource/buy/picksource' and method='sourceInfo' and sid='M00211';
	if num = 1 then 
		update bs_qxmx set accesstag = 0 where  action='/exp/hangsource/buy/picksource' and method='sourceInfo' and sid='M00211';
    END IF;
	num:=0;
	select count(1) into num from bs_qxmx where  action='/allthing' and method='index' and sid='M00211';
	if num = 1 then 
		update bs_qxmx set accesstag = 0 where  action='/allthing' and method='index' and sid='M00211';
    END IF;

	
	-- hjw
	
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00103' and mid='M0105' and mkid='M010520';      
	if num = 1 then 
		update bs_qxsz q set q.inurl = q.inurl || '#/exp/delivery/buy/manage/toConfirm.do' where sid='M00103' and mid='M0105' and mkid='M010520' and url='/exp/delivery/buy/manage/list.do';
    END IF;
    
    num:=0;
	  select count(1) into num from bs_qxmx where sid='M00103' and action='/swfupload' and method='uploadKindEditor';   
	  if num = 0 then 
	    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values ('0','/swfupload','uploadKindEditor','1','编辑器图片上传','1','M00103');
    END IF;
	
	-- 2014/10/17	客户情况报表	hanglong
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022570';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M022570','M0225','集团报表','客户情况报表','/tdp/report/khqk/list.do','/tdp/report/khqk/list.do#/tdp/report/khqk/mxList.do',1,600,1,'','M00103');
	end if;
	
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022570' and action='/tdp/report/khqk' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022570', '/tdp/report/khqk', 'list', 2,'集团报表-客户情况报表-列表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022570' and action='/tdp/report/khqk' and method='mxList';
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022570', '/tdp/report/khqk', 'mxList', 2,'集团报表-客户情况报表-明细列表', 1, 'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00103' and mkid='M022570' and action='/tdp/report/khqk' and method='showContract';
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M022570', '/tdp/report/khqk', 'showContract', 2,'集团报表-客户情况报表-查看合同', 1, 'M00103');
    END IF;
    --end

	num:=0;
	select count(1) into num from bs_qxsz where sid='M00103' and mid='M0225' and mkid='M022565';
	if num = 1 then
		update bs_qxsz set name = '收款明细报表' where sid='M00103' and mid='M0225' and mkid='M022565';
	end if;

    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  