 DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.80'; -- 本升级文件的版本，每个升级文件必须修改
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
	
	-- 2015/01/24	hanglong	供应商库存管理中查看商品详情
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/managersell' and method='info'  and mkid='M038010' and  sid='M00201' ;      
	if num = 0 then
		insert into bs_qxmx values(bs_qxmx_0.nextval,'M038010','/exp/stock/managersell','info',2,'供应商库存管理中查看商品详情',1,'M00201');
		update bs_qxsz set inurl = inurl || '#/exp/stock/managersell/info.do' where mkid='M038010' and mid='M0380' and  sid='M00201' ; 
	end if;
     --采购需求修改到货日期--suping 2015-01-24  ---start
    num:=0;
     select count(1) into num from bs_qxmx where mkid='M01150505' and action='/tdp/puc/req'  and method='doEditdhrqSave' and  sid='M00004';
    if num=0 then
    insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
      values(bs_qxmx_0.nextval,'M01150505','/tdp/puc/req','doEditdhrqSave',0,'采购需求修改到货日期',1,'M00004');
    end if;         
    -- end------------------
   --提交资质信息
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='saveZzxx' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','saveZzxx',1,'提交资质信息',1,'M00004');
    end if;
    
    --查看资质信息
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='toShowZzxx' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','toShowZzxx',1,'查看资质信息',1,'M00004');
    end if;
   
    --同意资质信息
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='agree' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','agree',1,'同意资质信息',1,'M00004');
    end if;
    
    --查看附件
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='showimg' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','showimg',1,'同意附件',1,'M00004');
    end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='toZzxx' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','toZzxx',1,'资质信息页面',1,'M00004');
    end if;
    
    num:=0;
  		select count(1) into num from bs_qxmx where action='/exp/auction/buy/bout' and  method='toZzxx' and styp=1  and  mkid='M024010' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M024010','/exp/auction/buy/bout','toZzxx',1,'资质信息页面',1,'M00004');
    end if;
    
    -- 20150127 huangjunyi  商品评分参数设置
     num:=0;
     select count(1) into num from bs_qxsz  where mkid='B014070' and sid='B00201' and mid='B0140';    
     if num = 0 then
        insert into bs_qxsz values ('B014070','B0140','基本设置','评分参数设置','/exm/basesetup/setpf/list.do','/exm/basesetup/setpf/list.do',1,1100,2,'','B00201');
   	 end if;
   	 
   	num:=0;
       select count (1) into num from  bs_qxmx where sid='B00201' and mkid='B014070' and action ='/exm/basesetup/setpf' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014070' , '/exm/basesetup/setpf', 'list' , 2, '评分参数设置', 2, 'B00201');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='B00201' and mkid='B014070' and action ='/exm/basesetup/setpf' and method='dosave';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B014070' , '/exm/basesetup/setpf', 'dosave' , 2, '评分参数设置保存', 2, 'B00201');
    END IF;
    
    num:=0;
   	select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M021510' and action ='/exp/tender/sell/bout' and method='joinTender';     
   	if num = 0 then
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M021510' , '/exp/tender/sell/bout', 'joinTender' , 1, '公告详情参与招标', 1, 'M00004');
    END IF;
    
    update bs_qxmx set accesstag = 1 where mkid = 'M01800505' and action = '/exp/querybusiness/process/sell' and method = 'joinPrice' and sid = 'M00004';

    --  end

	-- 20150128 huangjunyi  商品评分 统计表
	 num:=0;
     select count(1) into num from bs_qxsz  where mkid='B018050' and sid='B00201' and mid='B0180';    
     if num = 0 then
        insert into bs_qxsz values ('B018050','B0180','交易统计报表','商品评分统计表','/exm/report/goodspftj/list.do','/exm/report/goodspftj/list.do',1,500,2,'','B00201');
   	 end if;
   	 
   	 num:=0;
       select count (1) into num from  bs_qxmx where sid='B00201' and mkid='B018050' and action ='/exm/report/goodspftj' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B018050' , '/exm/report/goodspftj', 'list' , 2, '商品评分统计表', 2, 'B00201');
    END IF;
    
   	 num:=0;
       select count (1) into num from  bs_qxmx where sid='B00201' and mkid='B018050' and action ='/exm/report/goodspftj' and method='export2Excel';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'B018050' , '/exm/report/goodspftj', 'export2Excel' , 2, '商品评分统计表-导出', 2, 'B00201');
    END IF;
   	 

	-- end

	--hjw
	num:=0;
		select count(1) into num from  bs_qxmx where sid='M00004' and action='/tdp/puc/pcrepertory' and method='toAdd';     
	if num = 0 then 
		insert into bs_qxmx (mkid, action, method, accesstag, remark, styp, sid)
		values ('M037005', '/tdp/puc/pcrepertory', 'toAdd', 1, '初始库存值新增', 1, 'M00004'); 
	end if;
  
	num:=0;
		select count(1) into num from  bs_qxsz where sid='M00004' and mkid='M037005' and mid='M0370' and inurl='/tdp/puc/pcrepertory/list.do';    
	if num = 1 then 
		update bs_qxsz set inurl='/tdp/puc/pcrepertory/list.do#/tdp/puc/pcrepertory/toAdd.do' where sid='M00004' and mkid='M037005' and mid='M0370' and inurl='/tdp/puc/pcrepertory/list.do'; 
	end if;
	
	
	num:=0;
  	select count(1) into num from bs_qxmx where action='/jjxiaoshou' and  method='joinBout' and styp=1  and  mkid='0' and  sid='M00004';
	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'0','/jjxiaoshou','joinBout',1,'竞价销售我要参加',1,'M00004');
    end if;
	
	--end
	
   --hjw   inurl
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00004' and mkid='M023530' and mid='M0235' and url='/exp/auction/sell/tray/list.do' and inurl='/exp/auction/sell/tray/list.do';
  if num=1 then
        update bs_qxsz set inurl='/exp/auction/sell/tray/list.do#/exp/auction/sell/tray/toShowZzxx.do' where sid='M00004' and mkid='M023530' and mid='M0235' and url='/exp/auction/sell/tray/list.do' and inurl='/exp/auction/sell/tray/list.do';
    end if;

    --查看资质信息
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/sell/tray' and  method='toShowZzxx' and styp=1  and  mkid='M023530' and  sid='M00004';
  if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M023530','/exp/auction/sell/tray','toShowZzxx',2,'卖家-查看资质信息',1,'M00004');
    end if;
   
    --同意资质信息
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/sell/tray' and  method='agree' and styp=1  and  mkid='M023530' and  sid='M00004';
  if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M023530','/exp/auction/sell/tray','agree',2,'卖家-同意资质信息',1,'M00004');
    end if;
    
    --查看附件
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/sell/tray' and  method='showimg' and styp=1  and  mkid='M023530' and  sid='M00004';
  if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M023530','/exp/auction/sell/tray','showimg',2,'卖家-查看附件',1,'M00004');
    end if;
  	
  	--end
  --查看附件
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/auction/sell/tray' and  method='downLoad' and styp=1  and  mkid='M023530' and  sid='M00004';
  	if num=0 then
        insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
        values(bs_qxmx_0.nextval,'M023530','/exp/auction/sell/tray','downLoad',2,'卖家-查看附件',1,'M00004');
    end if;
    
    -- 2015/01/30	hanglong	销售后台添加刷新缓存权限
	num:=0;
	select count(1) into num from bs_qxmx where action='/cache' and  method='reflashCache' and mkid='0' and  sid='B00103';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/cache','reflashCache',0,'刷新销售平台后台缓存',2,'B00103');
	end if;
	--- end ---

	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/dev/package' and  method='makeTendersResult' and mkid='M010515' and  sid='M00004';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'M010515','/tdp/dev/package','makeTendersResult',2,'投标结果打印',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/expert/score' and  method='subScore' and mkid='0' and  sid='M00005';
	if num=0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
		values(bs_qxmx_0.nextval,'0','/exp/expert/score','subScore',1,'专家评分-提交评分',1,'M00005');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M011030' and sid='M00004' and instr(inurl, '#/tdp/join/quote/uploadQuality.do') > 0;
	if num=0 then
		update bs_qxsz set inurl=inurl||'#/tdp/join/quote/uploadQuality.do' where mkid='M011030' and sid='M00004';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M010515' and sid='M00004' and instr(inurl, '#/tdp/dev/package/queryQualityList.do#/tdp/dev/package/auditQuality.do') > 0;
	if num=0 then
		update bs_qxsz set inurl=inurl||'#/tdp/dev/package/queryQualityList.do#/tdp/dev/package/auditQuality.do' where mkid='M010515' and sid='M00004';
	end if;
    
     -- 20150202 WXD  招标管理-纪委监察
     num:=0;
     select count(1) into num from bs_qxsz  where mkid='M010535' and sid='M00004' and mid='M0105';    
     if num = 0 then
        insert into bs_qxsz values ('M010535','M0105','招标信息','纪委监察','/tdp/dev/jwjcproject/list.do','/tdp/dev/jwjcproject/list.do#/tdp/dev/jwjcproject/index.do#/tdp/dev/jwjcproject/xmbindex.do#/tdp/dev/jwjcproject/suspend.do#/tdp/dev/jwjcproject/cancel.do#/tdp/dev/jwjcproject/restore.do',1,700,1,'','M00004');
   	 end if;
   	 
   	num:=0;
    select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='list';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'list' , 2, '纪委监察-信息查询', 1, 'M00004');
    END IF;

   	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='index';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'index' , 2, '纪委监察-子项目监察', 1, 'M00004');
    END IF;
    
   	num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='xmbindex';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'xmbindex' , 2, '纪委监察-项目包监察', 1, 'M00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='to_suspend';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'to_suspend' , 2, '纪委监察-项目包中止理由', 1, 'M00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='suspendxmb';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'suspendxmb' , 2, '纪委监察-项目包中止', 1, 'M00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='cancel';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'cancel' , 2, '纪委监察-项目包取消中止', 1, 'M00004');
    END IF;
    
     num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='to_restore';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'to_restore' , 2, '纪委监察-项目包恢复理由', 1, 'M00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='restorexmb';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'restorexmb' , 2, '纪委监察-项目包恢复', 1, 'M00004');
    END IF;
    
     num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='to_endxmb';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'to_endxmb' , 2, '纪委监察-项目包结束理由', 1, 'M00004');
    END IF;
    
    num:=0;
       select count (1) into num from  bs_qxmx where sid='M00004' and mkid='M010535' and action ='/tdp/dev/jwjcproject' and method='endxmb';     
       if num = 0 then
             insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
             values (bs_qxmx_0.nextval, 'M010535' , '/tdp/dev/jwjcproject', 'endxmb' , 2, '纪委监察-项目包结束', 1, 'M00004');
    END IF;
    
    ----end----- 

    
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
