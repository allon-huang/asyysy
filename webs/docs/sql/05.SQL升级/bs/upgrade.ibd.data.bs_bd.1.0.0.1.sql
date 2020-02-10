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
 
      num:=0;
      select count(1) into num from bs_system where sid='B00080';
      if num = 0 then
        insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04)
        values('B00080', '中兵国际招投标平台', '国标后台', 2, '/admin/index.do', 1001, 'http://gbm.test.norincogroup-ebuy.com/ibdmanager', '/admin/login/index.do', '/admin/noAuth.do', '/admin/login/doLogout.do', '_ibdSystem');
      end if;
      
      num:=0;
      select count(1) into num from bs_system where sid='M00080';
      if num = 0 then
        insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04)
        values('M00080', '中兵国际招投标平台', '国标前台', 1, '/me/home/index.do', 1001, 'http://gb.test.norincogroup-ebuy.com/ibdplatform', '/login/bdIndex.do', '/auth/noAuth.do', '/login/doLogout.do', '_ibdSystem');
      end if;
      
      
      num:=0;
      select count(1) into num from bs_system where sid='M00090';
      if num = 0 then
        insert into bs_system(SID, SNAME, SHORTNAME, STYP, HOMEPAGE, ORDERNO, URL00, URL01, URL02, URL03, URL04)
        values('M00090', '国标评审平台', '国标评审平台', 1, '/me/home/index.do', 991, 'http://ips.test.norincogroup-ebuy.com/psplatform', '/zlogin/index.do', '/auth/noAuth.do', '/login/doLogout.do', '_ipsSystem');
      end if;
      
 
 
     -------bs_qxsz-------
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M092020' and mid='M0920' and sid='M00080';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M092020', 'M0920', '投标', '投标保证金支付', '/exp/bidding/sell/bidbond/pay/list.do', '/exp/bidding/sell/bidbond/pay/list.do#/exp/bidding/sell/bidbond/pay/toPayBzj.do#/exp/bidding/sell/bidbond/pay/doPayBzj.do#/exp/bidding/sell/bidbond/pay/showContract.do#/exp/bidding/sell/bidbond/pay/packageView.do#/exp/bidding/sell/bidbond/pay/dowloadBdwFile.do#', 1, 200, 1, '', 'M00080');
    END IF;
	
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00080' and mid = 'M0890' and mkid ='M089010' and instr(inurl,'#/bdp/bidding/buy/preficfile/saveZgyswj.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/saveZgyswj.do') where sid = 'M00080' and mid = 'M0890' and mkid ='M089010';
    end if;
	 
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00080' and mid = 'M0830' and mkid ='M083035' and instr(inurl,'#/exp/bidding/buy/yqhs/yqsFbYulan.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/yqhs/yqsFbYulan.do') where sid = 'M00080' and mid = 'M0830' and mkid ='M083035';
    end if; 
	
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00080' and mid = 'M0830' and mkid ='M083030' and instr(inurl,'#/exp/bidding/buy/aftfic/ggFbYulan.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/aftfic/ggFbYulan.do') where sid = 'M00080' and mid = 'M0830' and mkid ='M083030';
    end if;  
	 -----bs_qxmx-----------
 	 num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/monitor' and method='jcBdInspector' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/monitor','jcBdInspector',0,'监察驻派员','1','M00080');
    end if;
 
 
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='packList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M082010','/exp/bidding/buy/aftfic','packList',2,'公告编制列表','1','M00080');
    end if;
    
   num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='zbwjCsszList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083010','/exp/bidding/buy/zbwjone','zbwjCsszList',2,'参数设置列表','1','M00080');
    end if;
    
   num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='yqsList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M082035','/exp/bidding/buy/yqhs','yqsList',2,'投标邀请书-列表','1','M00080');
    end if;
 
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='customPackSettingDialog' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083010','/exp/bidding/buy/zbwjone','customPackSettingDialog',2,'招标文件参数设置-开标一览表模板设置弹出页面','1','M00080');
    end if;
 
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='customPackSettingSave' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083010','/exp/bidding/buy/zbwjone','customPackSettingSave',2,'招标文件参数设置-保存开标一览表模板设置','1','M00080');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='getcustomPackList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083010','/exp/bidding/buy/zbwjone','getcustomPackList',2,'招标文件参数设置-开标一览表模板列表','1','M00080');
    end if;

    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='zbggFbList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','zbggFbList',2,'招标公告发布-列表','1','M00080');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='yqsFbList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083035','/exp/bidding/buy/yqhs','yqsFbList',2,'投标邀请书发布-列表','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/bmqr/send' and method='openPayDialog' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083090','/exp/bidding/buy/bmqr/send','openPayDialog',2,'文件购买-确认已购买弹出框','1','M00080');
    end if;
  
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/bmqr/send' and method='confirmPay' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083090','/exp/bidding/buy/bmqr/send','confirmPay',2,'文件购买-确认已购买保存方法','1','M00080');
    end if;
	
	----------------------------------------------  招标公告-标的物列表 start	----------------------------------------------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='listBom' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','listBom',2,'招标公告-标的物列表','1','M00080');
    end if;
	----------------------------------------------  招标公告-标的物列表 end		-----------------------------------------------------
	----------------------------------------------  招标公告-保存标的物 start	----------------------------------------------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='saveBdw' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','saveBdw',2,'招标公告-保存标的物','1','M00080');
    end if;
	----------------------------------------------  招标公告-保存标的物 end		-----------------------------------------------------	
	----------------------------------------------  招标公告编辑-下载标的物 start	----------------------------------------------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='exportExcel' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','exportExcel',2,'招标公告编辑-下载标的物','1','M00080');
    end if;
	----------------------------------------------  招标公告编辑-下载标的物 end		-----------------------------------------------------		
    
	----------------------------------------------  招标公告发布-查看页面 start		-----------------------------------------------------		
	num:=0;
	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='ggFbYulan' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','ggFbYulan',2,'招标公告发布-查看页面','1','M00080');
    end if;	
	----------------------------------------------  招标公告发布-查看页面 end		-----------------------------------------------------
    
	----------------------------------------------  投标邀请书发布-查看页面 start   -----------------------------------------------------		
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='yqsFbYulan' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083035','/exp/bidding/buy/yqhs','yqsFbYulan',2,'投标邀请书发布-查看页面','1','M00080');
    end if;
	----------------------------------------------  投标邀请书发布-查看页面 end		-----------------------------------------------------		
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='openChangeRuleDialog' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','openChangeRuleDialog',2,'组建评标委员会-变更专家选取规则弹出框','1','M00080');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='changeRuleSave' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','changeRuleSave',2,'组建评标委员会-变更专家选取规则保存','1','M00080');
    end if; 
		
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='majormcChoose' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','majormcChoose',2,'组建评标委员会-专家选择专业弹出框','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='changeMemberDialog' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','changeMemberDialog',2,'组建评标委员会-变更专家信息弹出框','1','M00080');
    end if; 
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='showChangeReason' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','showChangeReason',2,'组建评标委员会-查看变更专家原因信息弹出框','1','M00080');
    end if; 
	
    
    -----2018-07-30 hejw start 增加商务评议--------------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='index' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','index',1,'技术评议-页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='index' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','index',1,'价格评议-页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/biz' and method='index' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/biz','index',1,'商务评议-页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='sealConfirm' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','sealConfirm',1,'技术评议-确认并提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='sealConfirm' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','sealConfirm',1,'价格评议-确认并提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/biz' and method='sealConfirm' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/biz','sealConfirm',1,'商务评议-确认并提交','1','M00090');
    end if;
    
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='summary' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','summary',1,'技术评议-汇总页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='summary' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','summary',1,'价格评议-汇总页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/biz' and method='summary' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/biz','summary',1,'商务评议-汇总页面','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='summarySeal' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','summarySeal',1,'技术评议-汇总签章提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='summarySeal' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','summarySeal',1,'价格评议-汇总签章提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/biz' and method='summarySeal' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/biz','summarySeal',1,'商务评议-汇总签章提交','1','M00090');
    end if;
    -----2018-07-30 hejw end 增加商务评议--------------------
    
        num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='toParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','toParam',1,'技术评议-确认并提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='saveParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','saveParam',1,'技术评议-保存填写的参数','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='subParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','subParam',1,'技术评议-提交参数','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='conParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','conParam',1,'技术评议-各专家确认参数','1','M00090');
    end if;
    
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='saveParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','saveParam',1,'价格评议-保存参数','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='conParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','conParam',1,'价格评议-确认参数','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='download' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','download',1,'价格评议-文件下载','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and method='subReport' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','subReport',1,'评标报告-提交','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and method='conReport' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','conReport',1,'评标报告-各专家确认','1','M00090');
    end if;
    ------20180806 hejw end -------------

	----------------------------------------------  异议与投诉  wyd		-----------------------------------------------------
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='yytsList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','yytsList',2,'异议投诉列表','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='updateRecall' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','updateRecall',2,'更新异议','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='getObjectionList' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','getObjectionList',2,'查询异议单位','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='complain' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','complain',2,'保存投诉','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='toComplain' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','toComplain',2,'新增投诉页面','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/hitbid/dissent' and method='updateComplain' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086090','/exp/bidding/buy/hitbid/dissent','updateComplain',2,'更新投诉','1','M00080');
    end if;
	
	----------------------------------------------  异议与投诉  wyd	 end	-----------------------------------------------------

    --------2018-08-07 hejw 评标报告tab start --------------------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and method='reportTab' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','reportTab',0,'评标报告Tab','1','M00090');
    end if;
    --------2018-08-07 hejw 评标报告tab start --------------------------


    --------客户端权限 add by nieche 2018年08月01日 start----------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/client/template' and METHOD ='checkCertStatus' and STYP=1 and SID='M00080';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/client/template','checkCertStatus',0,'客户端-校验ca证书状态',1,'M00080');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/client/customPack' and METHOD ='findBdCustomPacks' and STYP=1 and SID='M00080';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/client/customPack','findBdCustomPacks',0,'查询标段包下开标一览表模板列表（客户端专用）',1,'M00080');
    end if; 
    -------- 客户端权限 add by nieche 2018年08月01日 end------------------
	
	--------美元支付确认已支付 add by wyd 2018年8月9日16:17:28 start----------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/contract/bidbond' and METHOD ='confirmPay' and STYP=1 and SID='M00080';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M087040','/exp/bidding/buy/contract/bidbond','confirmPay',0,'美元确认已支付',1,'M00080');
    end if; 
    -------- 客户端权限 add by wyd 2018年8月9日16:17:28 end------------------
	
	-- 以下不允许出现升级SQL
    -------------------------------------------------------------
	
	----------------------------------------------  招标公告编辑-购买招标文件结束日期取得 start	----------------------------------------------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/aftfic' and method='dateConvert' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083030','/exp/bidding/buy/aftfic','dateConvert',2,'招标公告编辑-购买招标文件结束日期取得','1','M00080');
    end if;
	----------------------------------------------  招标公告编辑-购买招标文件结束日期取得 end		-------------------------------------------------
	----------------------------------------------  投标邀请书编辑-购买招标文件结束日期取得 start	----------------------------------------------------
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/yqhs' and method='dateConvert' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083035','/exp/bidding/buy/yqhs','dateConvert',2,'投标邀请书编辑-购买招标文件结束日期取得','1','M00080');
    end if;
	----------------------------------------------  投标邀请书编辑-购买招标文件结束日期取得 end		-------------------------------------------------	
	----------------------------------------------  资料备案、资料备案权限 start	----------------------------------------------------
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082030' and mid='M0820' and sid='M00080';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M082030', 'M0820', '标前准备', '资料备案', '/exp/bidding/buy/zlba/zlbaList.do', '/exp/bidding/buy/zlba/zlbaList.do#/exp/bidding/buy/zlba/toEditZlba.do#/exp/bidding/buy/zlba/toEditZlba.do#', 1, 66, 1, '', 'M00080');
    END IF;
	
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082045' and mid='M0820' and sid='M00080';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M082045', 'M0820', '标前准备', '资料备案确认', '/exp/bidding/buy/zlba/zlbaExamList.do', '/exp/bidding/buy/zlba/zlbaExamList.do#/exp/bidding/buy/zlba/toExamZlbaDetail.do#', 1, 68, 1, '', 'M00080');
    END IF;	
	----------------------------------------------  资料备案、资料备案权限 start	----------------------------------------------------	
	
	----20180818 hejw 图纸押金列表 start-------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/signup' and METHOD ='tzyjlist' and SID='M00080';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M091035','/exp/bidding/sell/signup','tzyjlist',2,'图纸押金列表',1,'M00080');
    end if; 
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00080' and mid='M0910' and mkid='M091035' and instr(inurl,'#/exp/bidding/sell/signup/tzyjlist.do')>0;
    if num=0 then
		   update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/tzyjlist.do') where sid='M00080' and mid='M0910' and mkid ='M091035';
    end if;
	----20180818 hejw 图纸押金列表 start-------------
	----20180818 hejw 评标退回 start-------------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='backParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','backParam',1,'价格评议-退回','1','M00090');
    end if;
    
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/tech' and method='backParam' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/tech','backParam',1,'技术评议-退回','1','M00090');
    end if;
	----20180818 hejw 评标退回 end-------------
	
	----2018-08-18-11-01--- start--------
    num:=0; 
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and method='subTbwj' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092005','/exp/bidding/sell/bidding','subTbwj',2,'投标文件-递交','1','M00080');
    end if;
	----2018-08-18-11-01--- end--------
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/price' and method='indexzh' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/price','indexzh',1,'投标文件-递交','1','M00090');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/psp/judge/report' and method='saveYjb' and sid = 'M00090';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/psp/judge/report','saveYjb',1,'保存评委会意见表','1','M00090');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='ggInfo' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','ggInfo',0,'首页-英文-公告页面','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='bgggIframe' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','bgggIframe',0,'首页-英文-更公告公告','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='scalingsIframe' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','scalingsIframe',0,'首页-英文-中标候选人公示','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='bdZbjgggIframe' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','bdZbjgggIframe',0,'首页-英文-中标结果公告','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='retrieve' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','retrieve',0,'首页-英文-信息检索','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='zbggIframe' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','zbggIframe',0,'首页-英文-招标公告','1','M00080');
    end if;
	
	num:=0; 
    select count(1) into num from bs_qxmx where  action='/en' and method='index' and sid = 'M00080';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/en','index',0,'前台交易英文首页','1','M00080');
    end if;
	
	
	--------------------------------------------------------------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
	 
END;  
