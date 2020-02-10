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
    select count(1) into num from bs_qxsz where mid='B0110' and mkid='B011055' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B011055','B0110','招标管理','保证金扣款审核','/bdm/audit/deductions/list.do','/bdm/audit/deductions/list.do#/bdm/audit/deductions/toAudit.do#/bdm/audit/deductions/upAudit.do#',1,600,2,'B00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/audit/deductions' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011055', '/bdm/audit/deductions', 'list', 2, '保证金扣款审核-列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/audit/deductions' and method='toAudit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011055', '/bdm/audit/deductions', 'toAudit', 2, '进入审核页面', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/audit/deductions' and method='upAudit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011055', '/bdm/audit/deductions', 'upAudit', 2, '更新审核数据', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='doReturnMultiple' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'doReturnMultiple', 2, '按照订单-退保证金', 1, 'M00008');
    end if;
	-----------add by songw 2017年4月27日 start---------------
    --将生成线下支付资金流水的支付回执的方法更改为公共的
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='checkBidBondReceipt' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='0',accesstag='1',remark='查看线下支付回执（资金流水支付回执）' where action='/exp/bidding/sell/bidbond/pay' and method='checkBidBondReceipt' and sid = 'M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='createReceipt' and sid = 'M00008';
    if num = 1 then
         update bs_qxmx set mkid='0',accesstag='1',remark='生成线下支付回执（资金流水支付回执）' where action='/exp/bidding/sell/bidbond/pay' and method='createReceipt' and sid = 'M00008';
    end if;
    
	-----------add by songw 2017年4月27日 end---------------
	
	----------add by songw 2017年4月28日 start-------------
    --增加保存投标人购买招标文件的购买人名称和购买人联系方式
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and method='addhsbuylxr' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091035','/exp/bidding/sell/signup','addhsbuylxr','2','后审流程-保存招标文件购买人名称和联系方式','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/signup' and method='addyszbwjbuylxr' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091025','/exp/bidding/sell/signup','addyszbwjbuylxr','2','预审流程-保存招标文件购买人名称和联系方式','1','M00008');
    end if;
    
    
	----------add by songw 2017年4月28日 end-------------
	
	----------add by songw 2017年5月4日 start----------
    --add 增加保存财务标记订单是否开票
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/account' and method='markSfkp' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020','/exp/bidding/account','markSfkp','2','资金管理-会员账户-保存财务标记订单是否开票','1','M00008');
    end if; 
	----------add by songw 2017年5月4日 end----------

	----------add by hejw 2017年5月6日 start----------
num:=0;
    select count(1) into num from bs_xtmk where mid='B0140' and sid='B00008';
    if num = 0 then
        insert into bs_xtmk(mid,mname,styp,ordby,sid) values('B0140','资金管理',2,390,'B00008');
    end if;

  num:=0;
    select count(1) into num from bs_qxsz where mid='B0140' and mkid='B014005' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014005','B0140','资金管理','退款申请','/bdm/refund/applyList.do','/bdm/refund/applyList.do#',1,10,2,'B00008');
    end if;
  
  num:=0;
    select count(1) into num from bs_qxsz where mid='B0140' and mkid='B014010' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014010','B0140','资金管理','退款审核','/bdm/refund/auditList.do','/bdm/refund/auditList.do#',1,20,2,'B00008');
    end if;
  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='applyList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'applyList', 2, '退款申请列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='accessAccount' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'accessAccount', 2, 'ajax-获取虚拟账号', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='addApply' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'addApply', 2, '退款申请-新增页面', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='upApply' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'upApply', 2, '退款申请-保存', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='subApply' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'subApply', 2, '退款申请-提交', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='delApply' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014005', '/bdm/refund', 'delApply', 2, '退款申请-删除', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='auditList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014010', '/bdm/refund', 'auditList', 2, '退款审核列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='upAudit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014010', '/bdm/refund', 'upAudit', 2, '退款-审核', 2, 'B00008');
    end if;
    
        num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='saveDeduct' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'saveDeduct', 2, '保存扣款信息', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='toDeduct' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'toDeduct', 2, '进入扣款页面', 1, 'M00008');
    end if;
	----------add by hejw 2017年5月6日 end----------

	----------add by hejw 2017年5月9日 start----------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'download', 2, '下载', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/audit/deductions' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011055', '/bdm/audit/deductions', 'download', 2, '下载', 2, 'B00008');
    end if;
	----------add by hejw 2017年5月9日 end----------

    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/basesetup/agent' and method='index' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent', 'index', 2, '入围代理机构列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/basesetup/agent' and method='toSave' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent', 'toSave', 2, '增加入围代理机构', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/basesetup/agent' and method='upRank' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent', 'upRank', 2, '修改排序-是否前台显示', 2, 'B00008');
    end if;
    
    num:=0;
        select instr(inurl,'/bdm/basesetup/agent/index.do#/bdm/basesetup/agent/toSave.do#/bdm/basesetup/agent/upRank.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010050' and mid='B0100';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/bdm/basesetup/agent/index.do#/bdm/basesetup/agent/toSave.do#/bdm/basesetup/agent/upRank.do') where  sid = 'B00008' and mkid='B010050' and mid='B0100';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/basesetup/agent' and method='viewDljgs' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent', 'viewDljgs', 2, '代理机构查询列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/basesetup/agent' and method='delAllDljg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010050', '/bdm/basesetup/agent', 'delAllDljg', 2, '入围代理机构-批量删除', 2, 'B00008');
    end if;

--add by zhangjian 2017-5-18 未入围代理机构审核 start  --
	  num:=0;  
    select count(1) into num from bs_qxsz where mid='B0110' and  mkid='B011060'  and sid='B00008';   
    if num = 0 then
        insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID, FIXED, QXROLE)
	values ('B011060', 'B0110', '招标管理', '未入围代理机构审核', '/bdm/notinagency/toList.do', '/bdm/notinagency/toList.do', 1, 700, 2, '', 'B00008', null, '');
    end if;
    
    num:=0;  
    select count(1) into num from bs_qxmx where   action='/bdm/notinagency' and method='download' and sid = 'B00008';
    if num = 0 then
           insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011060', '/bdm/notinagency', 'download', 2, '未入围代理机构附件下载', 2, 'B00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where   action='/bdm/notinagency' and method='toList' and sid = 'B00008';
    if num = 0 then
          insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ('B011060', '/bdm/notinagency', 'toList', 2, '未入围代理机构审核列表页', 2, 'B00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where   action='/bdm/notinagency' and method='toEdit' and sid = 'B00008';
    if num = 0 then
       insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('B011060', '/bdm/notinagency', 'toEdit', 2, '未入围代理机构审核审核页面', 2, 'B00008');
    end if;

   num:=0;
    select count(1) into num from bs_qxmx where   action='/bdm/notinagency' and method='auditPass' and sid = 'B00008';
    if num = 0 then
       insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ( 'B011060', '/bdm/notinagency', 'auditPass', 2, '未入围代理机构审核通过', 2, 'B00008');
    end if;

  	num:=0;
    select count(1) into num from bs_qxmx where   action='/bdm/notinagency' and method='auditRefuse' and sid = 'B00008';
    if num = 0 then
     insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B011060', '/bdm/notinagency', 'auditRefuse', 2, '未入围代理机构审核拒绝', 2, 'B00008');
    end if;


   --add by zhangjian 2017-5-18 未入围代理机构审核 end  --


    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='dljgAudit' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'dljgAudit', 2, '入围代理机构列表', 1, 'M00008');
    end if;

   --add by zhangjian 2017-5-20 代理机构申请审核start  --
	    update bs_qxsz a set a.name = '代理机构申请审核' where   mid='B0110' and  mkid='B011060'  and sid='B00008';   
		  
		update bs_qxmx b set b.remark = '代理机构申请审核附件下载'  where action='/bdm/notinagency' and method='download' and sid = 'B00008';
    	update bs_qxmx b set b.remark = '代理机构申请审核列表页'  where action='/bdm/notinagency' and method='toList' and sid = 'B00008';
     	update bs_qxmx b set b.remark = '代理机构申请审核审核页面'  where  action='/bdm/notinagency' and method='toEdit' and sid = 'B00008';
     	update bs_qxmx b set b.remark = '代理机构申请审核审核通过'  where action='/bdm/notinagency' and method='auditPass' and sid = 'B00008';
        update bs_qxmx b set b.remark = '代理机构申请审核审核拒绝'  where action='/bdm/notinagency' and method='auditRefuse' and sid = 'B00008';

	--add by zhangjian 2017-5-20 代理机构申请审核 end  --

    ----------add by songw 2017年5月15日 start-------------
    --资格预审模块，在资格预审评审报告后面增加评委信息维护节点
    num:=0;
    select count(1) into num from bs_qxsz where mid='M0890' and mkid='M089047' and sid='M00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
        values('M089047','M0890','资格预审','评委信息维护','/exp/bidding/buy/premtcfee/packlist.do','/exp/bidding/buy/premtcfee/packlist.do#/exp/bidding/buy/premtcfee/list.do#/exp/bidding/buy/premtcfee/update.do',1,605,1,'M00008','1,5');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/premtcfee' and method='packlist' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089047', '/exp/bidding/buy/premtcfee', 'packlist', 2, '资格预审评委信息维护标段包列表', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/premtcfee' and method='list' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089047', '/exp/bidding/buy/premtcfee', 'list', 2, '资格预审评委信息维护', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/premtcfee' and method='update' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089047', '/exp/bidding/buy/premtcfee', 'update', 2, '保存资格预审评委信息', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/premtcfee' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089047', '/exp/bidding/buy/premtcfee', 'download', 2, '下载文件', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/premtcfee' and method='pwxxWh' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089047', '/exp/bidding/buy/premtcfee', 'pwxxWh', 2, '下载评委信息维护pdf', 1, 'M00008');
    end if;
    
    ----------add by songw 2017年5月15日 end-------------


	----------add by zhangjian 2017年5月24日 start-------------
	---------修改代理机构管理
    num:=0;
	select count(1) into num from bs_qxsz where mid='B0100' and mkid='B010050' and sid='B00008' and name='代理机构管理';
    if num > 0 then
	update bs_qxsz a set a.name = '代理机构名录管理' where   mid='B0100' and  mkid='B010050'  and sid='B00008';   
    end if;

    ----------add by zhangjian 2017年5月24日 end-------------

    ----------add by hejw 2017年5月25日 start-------------
num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='sendDljg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'sendDljg', 2, '招标项目-发送委托信息给代理机构', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='upEntrust' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'upEntrust', 2, '招标项目-保存委托信息', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='toEntrust' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'toEntrust', 2, '招标项目-进入维护委托信息页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='upWrwdljg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'upWrwdljg', 2, '招标项目-更新选择未入围代理机构理由', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/subproject' and method='toWrwdljg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M081025', '/exp/bidding/buy/subproject', 'toWrwdljg', 2, '招标项目-进入未入围代理机构理由编辑页面', 1, 'M00008');
    end if;

    num:=0;
        select instr(inurl,'#/exp/bidding/buy/subproject/toEntrust.do#/exp/bidding/buy/subproject/upEntrust.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081025' and mid='M0810';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/subproject/toEntrust.do#/exp/bidding/buy/subproject/upEntrust.do') where  sid = 'M00008' and mkid='M081025' and mid='M0810';
    end if;
    ----------add by hejw 2017年5月25日 end-------------

	 --add by zhangjian 2017-5-26 代理机构申请审核start  --
	num:=0;
		   select count(1) into num from bs_qxsz where mid='B0110' and mkid='B011060' and sid='B00008' and name='代理机构申请审核';
    if num > 0 then
	       update bs_qxsz a set a.name = '委托邀请审核' where   mid='B0110' and  mkid='B011060'  and sid='B00008';   
    end if;  
	 num:=0;
		   select count(1) into num from bs_qxmx b where action='/bdm/notinagency' and method='download' and sid = 'B00008' and b.remark = '代理机构申请审核附件下载';
	 if num > 0 then
			update bs_qxmx b set b.remark = '委托邀请审核附件下载'  where action='/bdm/notinagency' and method='download' and sid = 'B00008';
	end if;  
	 num:=0;
		   select count(1) into num from bs_qxmx b where action='/bdm/notinagency' and method='toList' and sid = 'B00008' and b.remark = '代理机构申请审核列表页';
	 if num > 0 then
			update bs_qxmx b set b.remark = '委托邀请审核列表页'  where action='/bdm/notinagency' and method='toList' and sid = 'B00008';
	end if;  
	 num:=0;
		   select count(1) into num from bs_qxmx b where action='/bdm/notinagency' and method='toEdit' and sid = 'B00008' and b.remark = '代理机构申请审核审核页面';
	 if num > 0 then
			update bs_qxmx b set b.remark = '委托邀请审核审核页面'  where  action='/bdm/notinagency' and method='toEdit' and sid = 'B00008';
	end if;  
	num:=0;
		   select count(1) into num from bs_qxmx b where action='/bdm/notinagency' and method='auditPass' and sid = 'B00008' and b.remark = '代理机构申请审核审核通过';
	 if num > 0 then
			update bs_qxmx b set b.remark = '委托邀请审核审核通过'  where action='/bdm/notinagency' and method='auditPass' and sid = 'B00008';
	end if;     	
     num:=0;
		   select count(1) into num from bs_qxmx b where action='/bdm/notinagency' and method='auditRefuse' and sid = 'B00008' and b.remark = '代理机构申请审核审核拒绝';
	 if num > 0 then
			update bs_qxmx b set b.remark = '委托邀请审核审核拒绝'  where action='/bdm/notinagency' and method='auditRefuse' and sid = 'B00008';
	end if;  
	--add by zhangjian 2017-5-26 代理机构申请审核 end  --

	 ----------add by zhangjian 2017年6月1日 start-------------
    --委员会信息补发短信
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0135' and mkid='B013530' and sid='B00008';
    if num = 0 then
    	insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID, FIXED, QXROLE)
		values ('B013530', 'B0135', '平台运维报表', '委员会信息表', '/bdm/report/juryInfo/listJuryInfo.do', '/bdm/report/juryInfo/listJuryInfo.do', 1, 200, 2, '', 'B00008', null, '');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/juryInfo' and method='sendMsgList' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( 'B013530', '/bdm/report/juryInfo', 'sendMsgList', 2, '补发短信专家列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/juryInfo' and method='sendMsgToJuryMember' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
			values ( 'B013530', '/bdm/report/juryInfo', 'sendMsgToJuryMember', 2, '补发短信', 2, 'B00008');
    end if;
    ----------add by zhangjian 2017年6月1日 end-------------

    --add by hejw 2017-6-1 调整委托邀请人权限 start  --
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M082025' and mid='M0820' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole='3,4' where mkid='M082025' and mid='M0820' and sid = 'M00008';
    end if;
    --add by hejw 2017-6-1 调整委托邀请人权限 end  --

    ----------------add by songw 2017年6月5日 start--------------------
    --增加代理机构撤回招标文件权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/zbwjone' and method='withdraw' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083015','/exp/bidding/buy/zbwjone','withdraw','2','发标流程-代理机构撤回招标文件','1','M00008');
    end if;
    
    --增加招标方取消确认招标文件的权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/zbwjone' and method='cancelConfirm' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020','/exp/bidding/buy/zbwjone','cancelConfirm','2','发标流程-招标方取消确认招标文件','1','M00008');
    end if;
    
    --增加招标方撤销招标文件的权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/zbwjone' and method='revoke' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020','/exp/bidding/buy/zbwjone','revoke','2','发标流程-招标方撤销招标文件','1','M00008');
    end if;
    
    
    ----------------add by songw 2017年6月5日 end--------------------

    ----------------add by songw 2017年6月6日 start-------------------
    --资格预审-资格预审文件上传-代理机构撤回预审文件
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and method='withdraw' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089010','/bdp/bidding/buy/preficfile','withdraw','2','资格预审-资格预审文件上传-代理机构撤回预审文件','1','M00008');
    end if;
    
    --资格预审-资格预审文件确认-招标方取消确认资格预审文件
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and method='cancelConfirm' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015','/bdp/bidding/buy/preficfile','cancelConfirm','2','资格预审-资格预审文件确认-招标方取消确认资格预审文件','1','M00008');
    end if;
    
    --资格预审-资格预审文件确认-招标方撤销资格预审文件
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdp/bidding/buy/preficfile' and method='revoke' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015','/bdp/bidding/buy/preficfile','revoke','2','资格预审-资格预审文件确认-招标方撤销资格预审文件','1','M00008');
    end if;
    
    ----------------add by songw 2017年6月6日 end-------------------

    ----------------add by songw 2017年6月13日 start-----------------
    --调整资格预审委托流程招标方可查看报名汇总及文件购买 qxrole增加 4-委托（招标方）
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M089080' and mid='M0890' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole='1,4,5' where mkid='M089080' and mid='M0890' and sid = 'M00008';
    end if;
    
    --调整发标委托流程招标方可查看报名汇总及文件购买 qxrole增加 4-委托（招标方）
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M083090' and mid='M0830' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole='1,2,3,4,5,6,7' where mkid='M083090' and mid='M0830' and sid = 'M00008';
    end if;
    
    ----------------add by songw 2017年6月13日 end-----------------
    
    ----------------add by songw 2017年6月14日 start----------------
    --增加中标候选人公示修改权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='updateZbhxrgs' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086010','/exp/bidding/buy/scaling','updateZbhxrgs','2','定标-中标候选人公示-修改中标候选人公示信息','1','M00008');
    end if;
    
    --增加中标候选人公示发布权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='publishZbhxrgs' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M086010','/exp/bidding/buy/scaling','publishZbhxrgs','2','定标-中标候选人公示-发布中标候选人公示','1','M00008');
    end if;
    
    --增加调整资料归档所需的权限
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='check' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','check','2','资料归档-查看标段（包）','1','M00008');
    end if;
    
    --委托协议
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='wtxy' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','wtxy','2','资料归档-委托协议','1','M00008');
    end if;
    
    --资格预审
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='prequalification' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','prequalification','2','资料归档-资格预审','1','M00008');
    end if;
    
    --发标
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='announcebidding' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','announcebidding','2','资料归档-发标','1','M00008');
    end if;
    
    --投标
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='bid' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','bid','2','资料归档-投标','1','M00008');
    end if;
    
    --开标
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='bidopen' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','bidopen','2','资料归档-开标','1','M00008');
    end if;
    
    --评标
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='bidevaluation' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','bidevaluation','2','资料归档-评标','1','M00008');
    end if;
    
    --定标
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='scaling' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','scaling','2','资料归档-定标','1','M00008');
    end if;
    
    --生成pdf文档
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='createpdf' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','createpdf','2','资料归档-生成pdf文档','1','M00008');
    end if;
    
    --文件下载列表
    num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/buy/dataarchiving' and method='downloadFileList' and sid='M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','downloadFileList','2','资料归档-文件下载列表','1','M00008');
    end if;
    
    --定位左侧菜单
    num:=0;
        select instr(inurl,'/exp/bidding/buy/dataarchiving/check.do#/exp/bidding/buy/dataarchiving/wtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030050' and mid='M0300';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/dataarchiving/check.do#/exp/bidding/buy/dataarchiving/wtxy.do#/exp/bidding/buy/dataarchiving/prequalification.do#/exp/bidding/buy/dataarchiving/announcebidding.do#/exp/bidding/buy/dataarchiving/bid.do#/exp/bidding/buy/dataarchiving/bidopen.do#/exp/bidding/buy/dataarchiving/bidevaluation.do#/exp/bidding/buy/dataarchiving/scaling.do') where  sid = 'M00008' and mkid='M030050' and mid='M0300';
    end if;
    ----------------add by songw 2017年6月14日 end----------------
    ----------------add by hejw 2017年6月15日 start----------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/refund' and method='toView' and sid = 'B00008';
    if num = 0 then
     insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
     values('0', '/bdm/refund', 'toView', 1, '退款申请-查看', 2, 'B00008');
    end if;
    ----------------add by hejw 2017年6月15日 end----------------

	----------------add by zhangjian 2017年6月21日 start----------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/dataarchiving' and method='checkPackageStatus' and sid = 'M00008';
    if num = 0 then
     insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values ('M030050', '/exp/bidding/buy/dataarchiving', 'checkPackageStatus', 2, '资料归档-检查标段包状态', 1, 'M00008');
    end if;

	----------------add by zhangjian 2017年6月21日 end----------------

    -------------add by songw 2017年6月28日 start---------------------
    -- 增加保存退款备注相关权限明细
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='addRemarks' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'addRemarks', 2, '打开退款备注页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/fund' and method='saveRemark' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060010', '/exp/bidding/fund', 'saveRemark', 2, '保存退款备注', 1, 'M00008');
    end if;
    
    -------------add by songw 2017年6月28日 end---------------------
    
    ------------add by songw 2017年7月4日 start---------------
    --增加招投标后台的招标项目终止公告审核菜单
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0110' and mkid='B011035' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B011035','B0110','招标管理','项目终止公告审核','/bdm/zbstopgg/list.do','/bdm/zbstopgg/list.do#/bdm/zbstopgg/auditZbstopgg.do#/bdm/zbstopgg/examineZbstopgg.do',1,450,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zbstopgg' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011035', '/bdm/zbstopgg', 'list', 2, '招标项目终止公告审核列表', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zbstopgg' and method='auditZbstopgg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011035', '/bdm/zbstopgg', 'auditZbstopgg', 2, '招标项目终止公告审核页面', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zbstopgg' and method='examineZbstopgg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011035', '/bdm/zbstopgg', 'examineZbstopgg', 2, '招标项目终止公告审核操作', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zbstopgg' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011035', '/bdm/zbstopgg', 'download', 2, '招标项目终止公告审核下载附件', 2, 'B00008');
    end if;
    
    ------------add by songw 2017年7月4日 end---------------

    ------------add by songw 2017年7月6日 start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/complaint' and method='getNameInfo' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/exp/bidding/complaint', 'getNameInfo', 1, '新增投诉-获取招标项目名称或标段包名称', 1, 'M00008');
    end if;
    ------------add by songw 2017年7月6日 end-----------------

    ------------add by hejw 2017年7月7日 start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/' and method='snIndex' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0', '/', 'snIndex', 0, '山能招投标-首页', 1, 'M00008');
    end if;
    ------------add by hejw 2017年7月7日 end-----------------

    ------------add by songw 2017年7月10日 start----------------
    -- 增加订单支付页面，开票信息常用地址相关权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='toAddCommonAddress' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040', '/exp/bidding/sell/payment', 'toAddCommonAddress', 2, '费用支付-跳转常用收货地址新增或修改页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='saveOrUpdateAddress' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040', '/exp/bidding/sell/payment', 'saveOrUpdateAddress', 2, '费用支付-保存常用收货地址信息', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='deleteAddress' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040', '/exp/bidding/sell/payment', 'deleteAddress', 2, '费用支付-删除常用收货地址信息', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/payment' and method='setDefaultAddress' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060040', '/exp/bidding/sell/payment', 'setDefaultAddress', 2, '费用支付-设置常用收货默认地址', 1, 'M00008');
    end if;
    
    ------------add by songw 2017年7月10日 end----------------

    --------------add by songw 2017年7月12日 start-----------------
    -- 增加CA证书订单页面常用地址相关权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/cert/zfqd' and method='toAddCommonAddress' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010070', '/bsp/cert/zfqd', 'toAddCommonAddress', 2, 'CA证书订单-跳转新增或修改常用地址页面', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/cert/zfqd' and method='saveOrUpdateAddress' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010070', '/bsp/cert/zfqd', 'saveOrUpdateAddress', 2, 'CA证书订单-新增或修改常用地址', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/cert/zfqd' and method='deleteAddress' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010070', '/bsp/cert/zfqd', 'deleteAddress', 2, 'CA证书订单-删除常用地址', 1, 'M00000');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bsp/cert/zfqd' and method='setDefaultAddress' and sid = 'M00000';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M010070', '/bsp/cert/zfqd', 'setDefaultAddress', 2, 'CA证书订单-设置常用默认地址', 1, 'M00000');
    end if;
    
    --------------add by songw 2017年7月12日 end-----------------
    
    --------------add by songw 2017年7月13日 start---------------
    -- 增加投标人放弃投标操作相关权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and method='toGiveupBid' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092005', '/exp/bidding/sell/bidding', 'toGiveupBid', 2, '投标文件上传-跳转放弃投标说明编辑页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and method='saveGiveupReason' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092005', '/exp/bidding/sell/bidding', 'saveGiveupReason', 2, '投标文件上传-保存放弃投标说明内容', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidding' and method='saveGiveupSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092005', '/exp/bidding/sell/bidding', 'saveGiveupSeal', 2, '投标文件上传-保存弃标函PDF签章数据', 1, 'M00008');
    end if;
    
    -- 资格预审文件上传节点弃标
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='toGiveupBid' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091026', '/exp/bidding/sell/signup', 'toGiveupBid', 2, '投标文件上传-跳转放弃投标说明编辑页面', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='saveGiveupReason' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091026', '/exp/bidding/sell/signup', 'saveGiveupReason', 2, '投标文件上传-保存放弃投标说明内容', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='saveGiveupSeal' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091026', '/exp/bidding/sell/signup', 'saveGiveupSeal', 2, '投标文件上传-保存弃标函PDF签章数据', 1, 'M00008');
    end if;
    
    --------------add by songw 2017年7月13日 end---------------
    
    --------------add by songw 2017年7月14日 start-------------
    -- 调整报名及文件购买页面只显示文件购买页面，隐藏报名汇总页面
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M083090' and sid='M00008' and url='/exp/bidding/buy/bmqr/send/sendCheckBm.do'; 
    if num = 1 then
         update bs_qxsz set url='/exp/bidding/buy/bmqr/send/sendPaylist.do' where mkid='M083090' and sid='M00008'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='M089080' and sid='M00008' and url='/exp/bidding/buy/bmqr/checkBm.do'; 
    if num = 1 then
         update bs_qxsz set url='/exp/bidding/buy/bmqr/paylist.do' where mkid='M089080' and sid='M00008'; 
    end if;
    
    --------------add by songw 2017年7月14日 end-------------

    --------------add by hejw 2017年7月18日 start-------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='saveExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040', '/bdp/build/jury', 'saveExpertEntry', 2, '保存线下录入专家', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='sendExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040', '/bdp/build/jury', 'sendExpertEntry', 2, '线下录入专家-发送短信', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='importOffline' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040', '/bdp/build/jury', 'importOffline', 2, '线下录入专家-导入', 1, 'M00008');
    end if;
    
    --------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='saveExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040', '/bdp/build/pre/jury', 'saveExpertEntry', 2, '保存线下录入专家', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='sendExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040', '/bdp/build/pre/jury', 'sendExpertEntry', 2, '线下录入专家-发送短信', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='importOffline' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040', '/bdp/build/pre/jury', 'importOffline', 2, '线下录入专家-导入', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040', '/bdp/build/jury', 'download', 2, '保存线下录入-下载', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040', '/bdp/build/pre/jury', 'download', 2, '线下录入专家-下载', 1, 'M00008');
    end if;
    --------------add by hejw 2017年7月18日 end-------------
    --------------add by hejw 2017年7月19日 start-------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='saveExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010', '/exp/bidding/buy/kb', 'saveExpertEntry', 2, '保存线下补录专家', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='sendExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010', '/exp/bidding/buy/kb', 'sendExpertEntry', 2, '线下补录专家-发送短信', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='importOffline' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010', '/exp/bidding/buy/kb', 'importOffline', 2, '线下补录专家-导入', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/kb' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084010', '/exp/bidding/buy/kb', 'download', 2, '保存线下补录-下载', 1, 'M00008');
    end if;
    -----
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='saveExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090', '/exp/bidding/buy/ysopen', 'saveExpertEntry', 2, '保存线下补录专家', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='sendExpertEntry' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090', '/exp/bidding/buy/ysopen', 'sendExpertEntry', 2, '线下补录专家-发送短信', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='importOffline' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090', '/exp/bidding/buy/ysopen', 'importOffline', 2, '线下补录专家-导入', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/ysopen' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089090', '/exp/bidding/buy/ysopen', 'download', 2, '保存线下补录-下载', 1, 'M00008');
    end if;
    --------------add by hejw 2017年7月19日 end-------------

    --------------add by songw 2017年7月18日 start-----------------
    --参数设置专家确定方式为线下选取专家，需要平台审核
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='submitExamineCssz' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083010', '/exp/bidding/buy/zbwjone', 'submitExamineCssz', 2, '发标流程-招标参数设置提交平台审核', 1, 'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0110' and mkid='B011065' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B011065','B0110','招标管理','线下选取专家审核','/bdm/cssz/list.do','/bdm/cssz/list.do#/bdm/cssz/toExaminCssz.do#/bdm/cssz/examineCssz.do',1,750,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/cssz' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011065', '/bdm/cssz', 'list', 2, '线下选取专家参数设置审核', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/cssz' and method='toExaminCssz' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011065', '/bdm/cssz', 'toExaminCssz', 2, '跳转线下选取专家审核页面', 2, 'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/cssz' and method='examineCssz' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B011065', '/bdm/cssz', 'examineCssz', 2, '线下选取专家审核操作', 2, 'B00008');
    end if;
    
    --------------add by songw 2017年7月18日 end-----------------
    
    --------------add by songw 2017年7月19日 start---------------
    --资格预审文件参数设置提交平台审核
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/prefic' and method='submitExamineCssz' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089007', '/exp/bidding/buy/prefic', 'submitExamineCssz', 2, '资格预审文件参数设置-提交平台审核（线下选取专家）', 1, 'M00008');
    end if;
    --------------add by songw 2017年7月19日 end---------------
    --------------add by hejw 2017年8月08日 start---------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/juryInfo' and method='pauseExtraction' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013530','/bdm/report/juryInfo','pauseExtraction',2,'委员会-暂停抽取',2,'B00008');
    end if;
    --------------add by hejw 2017年8月08日 end---------------
    
    --------------add by songw 2017年8月8日 start------------------
    -- 增加报名-文件购买-查看订单相关权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='showOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091035', '/exp/bidding/sell/signup', 'showOrder', 2, '报名-招标文件购买-查看订单', 1, 'M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/showOrder.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091035' and mid='M0910';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showOrder.do') where  sid = 'M00008' and mkid='M091035' and mid='M0910';
    end if;
    
    -- 增加修改投标保证金订单信息权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/bidbond/pay' and method='updateBidBond' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M092020', '/exp/bidding/sell/bidbond/pay', 'updateBidBond', 2, '投标-投标保证金订单-修改订单信息', 1, 'M00008');
    end if;
    
    -- 增加报名-资格预审文件购买-订单查看权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='showPreOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091020', '/exp/bidding/sell/signup', 'showPreOrder', 2, '报名-资格预审文件购买-订单查看', 1, 'M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/showPreOrder.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091020' and mid='M0910';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showPreOrder.do') where  sid = 'M00008' and mkid='M091020' and mid='M0910';
    end if;
    
    -- 增加预审流程-报名-招标文件购买-订单查看页面
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/signup' and method='showPreZbwjOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M091025', '/exp/bidding/sell/signup', 'showPreZbwjOrder', 2, '报名-资格预审文件购买-订单查看', 1, 'M00008');
    end if;
    
    num:=0;
    select instr(inurl,'/exp/bidding/sell/signup/showPreZbwjOrder.do') into num from bs_qxsz where sid = 'M00008' and mkid='M091025' and mid='M0910';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/signup/showPreZbwjOrder.do') where  sid = 'M00008' and mkid='M091025' and mid='M0910';
    end if;
    --------------add by songw 2017年8月8日 end------------------

    --------------add by songw 2017年8月14日 start---------------
    --后台批量导入专家页面
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='toImportExpert' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505', '/bdm/expert', 'toImportExpert', 2, '专家管理-跳转批量导入专家页面', 2, 'B00008');
    end if;
    
    num:=0;
    select instr(inurl,'/bdm/expert/toImportExpert.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010505' and mid='B0105';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/bdm/expert/toImportExpert.do') where  sid = 'B00008' and mkid='B010505' and mid='B0105';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='doImportExpert' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505', '/bdm/expert', 'doImportExpert', 2, '专家管理-批量导入专家', 2, 'B00008');
    end if;
    
    num:=0;
    select instr(inurl,'/bdm/expert/doImportExpert.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010505' and mid='B0105';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/bdm/expert/doImportExpert.do') where  sid = 'B00008' and mkid='B010505' and mid='B0105';
    end if;
    
    -- 导出错误专家数据
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='exportError' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505', '/bdm/expert', 'exportError', 2, '专家管理-导出错误专家数据', 2, 'B00008');
    end if;
    
    num:=0;
    select instr(inurl,'/bdm/expert/exportError.do') into num from bs_qxsz where sid = 'B00008' and mkid='B010505' and mid='B0105';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/bdm/expert/exportError.do') where  sid = 'B00008' and mkid='B010505' and mid='B0105';
    end if;
    
    -- 下载模板
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='download' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505', '/bdm/expert', 'download', 2, '专家管理-导出专家模板', 2, 'B00008');
    end if;

    --------------add by songw 2017年8月14日 end---------------
    

    --------------add by hejw 2017年8月16日 start------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/httpback' and method='sendYqzjSmsOk' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/httpback','sendYqzjSmsOk',0,'HTTP回掉-专家邀请短信发送成功回调',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/httpback' and method='yqzjSmsReplyCallBack' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/httpback','yqzjSmsReplyCallBack',0,'HTTP回掉-专家回复短信回调-业务处理',1,'M00008');
    end if;
    --------------add by hejw 2017年8月16日 end------------------

    --------------add by songw 2017年8月21日 start------------
    -- 调整代理机构可以查看合同执行章节的履约保证金节点和合同签订节点
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M087040' and mid='M0870' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole='1,2,3,4,5,6,7' where mkid='M087040' and mid='M0870' and sid = 'M00008';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M087010' and mid='M0870' and sid = 'M00008';
    if num = 1 then
         update bs_qxsz set qxrole='1,2,3,4,5,6,7' where mkid='M087010' and mid='M0870' and sid = 'M00008';
    end if;
    --------------add by songw 2017年8月21日 end------------

    ----------add by hejw start --------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='delJury' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','delJury',2,'组建评标委员会-删除委员会',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='delJury' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040','/bdp/build/pre/jury','delJury',2,'组建预审委员会-删除委员会',1,'M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='toDisband' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','toDisband',2,'组建评标委员会-进入委员会解散页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='toDisband' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040','/bdp/build/pre/jury','toDisband',2,'组建预审委员会-进入委员会解散页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/jury' and method='saveDisband' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083040','/bdp/build/jury','saveDisband',2,'组建评标委员会-进入委员会解散页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/build/pre/jury' and method='saveDisband' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089040','/bdp/build/pre/jury','saveDisband',2,'组建预审委员会-保存解散信息',1,'M00008');
    end if;
    --------------add by hejw end ---------

    ---------------add by songw 2017年8月24日 start-------------------
    -- 增加履约保证金优化流程相关权限
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and method='toPayPerformanceBond' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096030','/exp/bidding/sell/contract/bidbond','toPayPerformanceBond',2,'签订合同-履约保证金-跳转编辑履约保证金订单',1,'M00008');
    end if; 
       
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and method='doPayPerformanceBond' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096030','/exp/bidding/sell/contract/bidbond','doPayPerformanceBond',2,'签订合同-履约保证金-生成履约保证金订单',1,'M00008');
    end if; 
       
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and method='editPerformanceBond' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096030','/exp/bidding/sell/contract/bidbond','editPerformanceBond',2,'签订合同-履约保证金-编辑履约保证金订单',1,'M00008');
    end if; 
       
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/contract/bidbond' and method='checkPerformanceBond' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M096030','/exp/bidding/sell/contract/bidbond','checkPerformanceBond',2,'签订合同-履约保证金-查看履约保证金订单',1,'M00008');
    end if; 
       
    num:=0;
    select instr(inurl,'/exp/bidding/sell/contract/bidbond/checkPerformanceBond.do') into num from bs_qxsz where sid = 'M00008' and mkid='M096030' and mid='M0960';
    if num = 0 then
       update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/contract/bidbond/checkPerformanceBond.do') where  sid = 'M00008' and mkid='M096030' and mid='M0960';
    end if;
    ---------------add by songw 2017年8月24日 end-------------------

    ---------------add by hejw 2017年8月30日 start-------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='addHtml' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','addHtml',2,'生成html页面',2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/manager/publicfun' and method='getAllAreaInSm' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/manager/publicfun','getAllAreaInSm',1,'公共选择-省市',2,'B00008');
    end if;
    ---------------add by hejw 2017年8月30日 end-------------------

    ---------------add by hejw 2017年9月19日 start-------------------
      num:=0;
      select count(1) into num from bs_qxmx where  action='/zlogin' and method='index' and sid = 'M00009';
      if num = 0 then
           insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
           values('0','/zlogin','index',0,'专家自荐-登陆页面',1,'M00009');
      end if;
      
      num:=0;
      select count(1) into num from bs_qxmx where  action='/zlogin' and method='doLogout' and sid = 'M00009';
      if num = 0 then
           insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
           values('0','/zlogin','doLogout',0,'自荐专家-登出',1,'M00009');
      end if;
      
      num:=0;
      select count(1) into num from bs_qxmx where  action='/zlogin' and method='doLogin' and sid = 'M00009';
      if num = 0 then
           insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
           values('0','/zlogin','doLogin',0,'自荐专家-提交登录请求',1,'M00009');
      end if;
      

  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='reg' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','reg',0,'专家注册页面',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='saveReg' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','saveReg',0,'保存注册信息',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='toForget' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','toForget',0,'忘记密码页面',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='subForget' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','subForget',0,'专家-重设密码',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/zjme/home' and method='home' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/zjme/home','home',1,'专家信息页面',1,'M00009');
  end if;
  
   num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='checkMsgCode' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','checkMsgCode',0,'判断-验证码是否失效',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='sendRegMobileCode' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','sendRegMobileCode',0,'注册-发送手机校验码',1,'M00009');
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where  action='/reg/expert' and method='sendMobileCode' and sid = 'M00009';
  if num = 0 then
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
       values('0','/reg/expert','sendMobileCode',0,'重置密码-发送短信',1,'M00009');
  end if;
    ---------------add by hejw 2017年9月19日 end  -------------------

    ---------------add by lijb start--------------------
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0105' and mkid='B010510' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B010510','B0105','专家管理','自荐专家管理','/bdm/expertZj/list.do','/bdm/expertZj/list.do',1,1000,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expertZj' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010510','/bdm/expertZj','list','2','自荐专家管理-专家清单','2','B00008');
    end if;
    ----- add by lijb end---------------

        ---------------add by jinyanhui 2017年9月20日 end-------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and method='addHtml' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030020','/exp/bidding/buy/beingPro','addHtml',2,'生成html页面',1,'M00008');
    end if;
        ---------------add by jinyanhui 2017年9月20日 end-------------------

	---------------add by lijb 2017年9月20日start--------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expertZj' and method='toAudit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010510','/bdm/expertZj','toAudit','2','自荐专家管理-审核页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expertZj' and method='audit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010510','/bdm/expertZj','audit','2','自荐专家管理-审核','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  url='/bdm/expertZj/list.do' and inurl='/bdm/expertZj/list.do' and sid = 'B00008';
    if num = 1 then
         update bs_qxsz set inurl='/bdm/expertZj/list.do#/bdm/expertZj/toAudit.do' where url='/bdm/expertZj/list.do' and inurl='/bdm/expertZj/list.do' and sid = 'B00008';
    end if;
    ----- add by lijb 2017年9月20日end---------------

    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='addPbbg' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','addPbbg',2,'生成评标结果pdf',2,'B00008');
    end if;
    
    ---------------add by lijb 2017年9月25日start--------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='home' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','home','1','自荐专家信息页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='saveExpert' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','saveExpert','1','保存自荐专家信息','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='xzzy' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','xzzy','1','跳转自荐专家选择专业页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='download' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','download','1','自荐专家相关附件下载','1','M00009');
    end if;
    ----- add by lijb 2017年9月25日end---------------

    ----- add by hejw 2017年9月26日start---------------
      num:=0;
      select count(1) into num from bs_qxmx where  action='/reg/expert' and method='regSuccess' and sid = 'M00009';
      if num = 0 then
           insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
           values('0','/reg/expert','regSuccess',0,'注册及重置密码成功页面',1,'M00009');
      end if;
    ----- add by hejw 2017年9月26日end---------------

	---------------add by lijb 2017年9月26日start--------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='submitExpert' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','submitExpert','1','提交自荐专家信息','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='tochangeTel' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','tochangeTel','1','跳转到变更手机号页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='changeTel' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','changeTel','1','变更手机号','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='tochangePassw' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','tochangePassw','1','跳转到修改密码页面','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='changePassw' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','changePassw','1','修改密码','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/zjme/home' and method='sendMobileCode' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','sendMobileCode','1','变更手机号 发送验证码','1','M00009');
    end if;
    ----- add by lijb 2017年9月26日end---------------
	---------------add by lijb 2017年10月19日start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='checkTel' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505','/bdm/expert','checkTel','2','专家管理-验证联系电话是否唯一','2','B00008');
    end if;
	-------------- add by lijb 2017年10月19日end---------------

	-------------- add by hejw 2017年10月20日start---------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/subproject' and METHOD ='listInquiryAgency' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M081025','/exp/bidding/buy/subproject','listInquiryAgency',2,'获取询价代理机构|在线选择代理机构',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/exp/bidding/account' and METHOD ='kDetail' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M060020','/exp/bidding/account','kDetail',2,'扣款明细',1,'M00008');
    end if;
	-------------- add by hejw 2017年10月20日end---------------

	---------------add by lijb 2017年10月23日start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/account' and method='toRemark' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020','/exp/bidding/account','toRemark','2','跳转到备注页面','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/account' and method='kRemark' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020','/exp/bidding/account','kRemark','2','保存扣款备注','1','M00008');
    end if;
	-------------- add by lijb 2017年10月23日end---------------

    -------hejw 2017-10-24 start ---------------
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/subproject' and METHOD ='checkRwDljg' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('M081025','/exp/bidding/buy/subproject','checkRwDljg',2,'检查是否入围代理机构',1,'M00008');
    end if;
    -------hejw 2017-10-24 end ---------------

	---------------add by lijb 2017年10月24日start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/expert' and method='checkIdCard' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B010505','/bdm/expert','checkIdCard','2','专家管理-验证身份证号是否唯一','2','B00008');
    end if;
	-------------- add by lijb 2017年10月24日end---------------
	
	---------------add by lijb 2017年10月26日start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/abnormal' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M084030','/exp/bidding/buy/abnormal','download','2','下载附件','1','M00008');
    end if;
	-------------- add by lijb 2017年10月26日end---------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/hitbid/notice' and method='downloadGs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M09504005','/exp/bidding/sell/hitbid/notice','downloadGs','2','下载附件','1','M00008');
    end if;
    --------------------------------------------------------------
	----------add by lijb 2017年11月02日start----------
	num:=0;
    select count(1) into num from bs_xtmk where mid='B0145' and sid='B00008';
    if num = 0 then
        insert into bs_xtmk(mid,mname,styp,ordby,sid) values('B0145','会员权益管理',2,250,'B00008');
    end if;

  	num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014505' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014505','B0145','会员权益管理','会员权益管理','/bdm/hyqy/list.do','/bdm/hyqy/list.do#/bdm/hyqy/toEdit.do',1,100,2,'B00008');
    end if;
  
  	num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014510' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014510','B0145','会员权益管理','会员标准设置','/bdm/hybz/list.do','/bdm/hybz/list.do#/bdm/hybz/toEdit.do',1,200,2,'B00008');
    end if;
    -------------- add by lijb 2017年11月02日end---------------
    -------------- add by hejw 2017年11月02日start---------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hyqy' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014505','/bdm/hyqy','list','2','权益管理','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hybz' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014510','/bdm/hybz','list','2','标准设置','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hybz' and method='toShowBz' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014510','/bdm/hybz','toShowBz','2','查看标准详情','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hybz' and method='editBz' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014510','/bdm/hybz','editBz','2','编辑组装标准数据','2','B00008');
    end if;
    -------------- add by hejw 2017年11月02日end---------------
	---------------add by lijb 2017年11月03日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/ind' and method='index' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/hyqy/ind','index','0','会员权益首页','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/me' and method='index' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/hyqy/me','index','1','会员权益管理','1','M00008');
    end if;
	-------------- add by lijb 2017年11月03日end---------------

    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/bdp/hyqy/me' and METHOD ='toDealWith' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bdp/hyqy/me','toDealWith',1,'去办理',1,'M00008');
    end if;

    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/bdp/hyqy/me' and METHOD ='saveInvoice' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bdp/hyqy/me','saveInvoice',1,'保存发票信息',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where ACTION='/bdp/hyqy/me' and METHOD ='saveDealWith' and SID='M00008';
    if num = 0 then
        insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
        values('0','/bdp/hyqy/me','saveDealWith',1,'保存去办理页面',1,'M00008');
    end if;


	---------------add by lijb 2017年11月07日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hyqy' and method='toEdit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014505','/bdm/hyqy','toEdit','2','跳转到该会员已购买的标准详情页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hyqy' and method='update' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014505','/bdm/hyqy','update','2','修改会员权益','2','B00008');
    end if;
	-------------- add by lijb 2017年11月07日end---------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/account' and method='markSfkpAll' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M060020','/exp/bidding/account','markSfkpAll','2','批量开票','1','M00008');
    end if;
    ---------------add by lijb 2017年11月14日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/dataarchiving' and method='archivingFile' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','archivingFile','2','资料附件文件|代理机构','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/dataarchiving' and method='download' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','download','2','下载附件','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hybz' and method='toEditFwx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014510','/bdm/hybz','toEditFwx','2','编辑服务项页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hybz' and method='editFwx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014510','/bdm/hybz','editFwx','2','编辑服务项','2','B00008');
    end if;
	-------------- add by lijb 2017年11月14日end---------------

	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createYsgg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createYsgg','0','批量生成预审公告静态页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createZbgg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createZbgg','0','批量生成招标公告静态页面','1','M00008');
    end if;
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createDzgtzs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createDzgtzs','0','批量生成代资格审核通过通知书静态页面','1','M00008');
    end if;   
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createTbyqs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createTbyqs','0','批量生成投标邀请书静态页面','1','M00008');
    end if;  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createHxrgs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createHxrgs','0','批量生成候选人公示静态页面','1','M00008');
    end if;  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createZbtzs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createZbtzs','0','批量生成中标通知书静态页面','1','M00008');
    end if;   
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createJgtzs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createJgtzs','0','批量生成结果通知书静态页面','1','M00008');
    end if;  
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createZzbjggg' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createZzbjggg','0','批量生成招标结果公告静态页面','1','M00008');
    end if;    
	---------------add by lijb 2017年11月17日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/dataarchiving' and method='saveArchivingFile' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','saveArchivingFile','2','资料归档附件上传','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/dataarchiving' and method='deleteArchivingFile' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M030050','/exp/bidding/buy/dataarchiving','deleteArchivingFile','2','资料归档附件删除','1','M00008');
    end if;
	-------------- add by lijb 2017年11月17日end---------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createYsRecord' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createYsRecord','0','批量生成预审记录静态页面','1','M00008');
    end if;    
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/create/html' and method='createRecord' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/exp/bidding/create/html','createRecord','0','批量生成开标记录公告静态页面','1','M00008');
    end if;    
    ---------------add by lijb 2017年11月22日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/me' and method='checkHydj' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/hyqy/me','checkHydj','1','招标人购买CA证书时判断是否是会员','1','M00008');
    end if;
    -------------- add by lijb 2017年11月22日end---------------

	num:=0;
    select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/zbwjone' and method='pbzjqdfs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M083020','/exp/bidding/buy/zbwjone','pbzjqdfs','2','查看委员会抽取方式附件','1','M00008');
    end if;
    ---------------add by lijb 2017年11月23日start------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/me' and method='saveOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/hyqy/me','saveOrder','1','确认订单','1','M00008');
    end if;
    
    ---------------add by zhaoy 2017年11月23日start------------
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='editzbje' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','editzbje','2','编辑标段包中标金额','2','B00008');
    end if;
   
 
     num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='toEdit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','toEdit','2','编辑标段包中标金额','2','B00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='edit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','edit','2','保存标段包中标金额','2','B00008');
    end if;
    -------------- add by zhaoy 2017年11月23日end---------------
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/hyqy/me' and method='deleteOrder' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/bdp/hyqy/me','deleteOrder','1','取消订单','1','M00008');
    end if;
    -------------- add by lijb 2017年11月23日end---------------
	-----------------------add by lijb 2017年11月27日start----------------------------
	num:=0;
    select count(1) into num from bs_qxmx where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'toAddCommonAddress';
    if num = 1 then
         update bs_qxmx set accesstag='1' where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'toAddCommonAddress';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'saveOrUpdateAddress';
    if num = 1 then
         update bs_qxmx set accesstag='1' where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'saveOrUpdateAddress';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'savekpxx';
    if num = 1 then
         update bs_qxmx set accesstag='1' where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'savekpxx';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'setDefaultAddress';
    if num = 1 then
         update bs_qxmx set accesstag='1' where accesstag='2' and sid = 'M00008'and action = '/exp/bidding/sell/payment' and method = 'setDefaultAddress';
    end if;
	------------------------add by lijb 2017年11月27日end---------------------------

	------------------------add by hejw 2017年11月27日start---------------------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='zbxx' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','zbxx','0','首页-招标信息','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='zbdl' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','zbdl','0','首页-招标代理','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='tbs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','tbs','0','首页-投标商','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='zjk' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','zjk','0','首页-专家库','1','M00008');
    end if;
    
     num:=0;
    select count(1) into num from bs_qxmx where  action='/' and method='pbzx' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','pbzx','0','首页-评标中心','1','M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='zbggIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','zbggIframe','0','首页Iframe-招标公告','1','M00008');
    end if;
	------------------------add by hejw 2017年11月27日end---------------------------
	-----------------------add by lijb 2017年11月29日start----------------------------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014515' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014515','B0145','会员权益管理','会员订单管理','/bdm/hydd/list.do','/bdm/hydd/list.do#',1,50,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/hydd' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','list','2','会员订单分页列表','2','B00008');
    end if;
	------------------------add by lijb 2017年11月29日end---------------------------
	-----------------------add by lijb 2017年11月30日start----------------------------
	num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B014520' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
        values('B014520','B0145','会员权益管理','支付登记信息','/bdm/zfxx/list.do','/bdm/zfxx/list.do#',1,300,2,'B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B01452005' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,isuse,styp,parent,sid)
        values('B01452005','B0145','会员权益管理','编辑',2,2,'B014520','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where mid='B0145' and mkid='B01452010' and sid='B00008';
    if num = 0 then
        insert into bs_qxsz(mkid,mid,mname,name,isuse,styp,parent,sid)
        values('B01452010','B0145','会员权益管理','审核',2,2,'B014520','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014520','/bdm/zfxx','list','2','支付登记分页列表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='toAddZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452005','/bdm/zfxx','toAddZfxx','2','跳转到新增页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='addZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452005','/bdm/zfxx','addZfxx','2','新增支付信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='toUpdateZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452005','/bdm/zfxx','toUpdateZfxx','2','跳转到修改页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='updateZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452005','/bdm/zfxx','updateZfxx','2','修改支付信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='readZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014520','/bdm/zfxx','readZfxx','2','查看支付信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='toAuditZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452010','/bdm/zfxx','toAuditZfxx','2','跳转到审核页面','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/zfxx' and method='auditZfxx' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B01452010','/bdm/zfxx','auditZfxx','2','审核信息','2','B00008');
    end if;
	------------------------add by lijb 2017年11月30日end---------------------------
    ---------------add by zhaoy 2017年11月29日start------------
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'B013025' and mid = 'B0130' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
         values('B013025','B0130','考评管理','代理机构综合考评','/bdm/dljgzhappraisal/list.do','/bdm/dljgzhappraisal/list.do','1','250','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where  mkid = 'B013025' and mid = 'B0130' and sid = 'B10008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
         values('B013025','B0130','考评管理','代理机构综合考评','/bdm/dljgzhappraisal/list.do','/bdm/dljgzhappraisal/list.do','1','250','2','B10008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgzhappraisal' and method='list' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013025','/bdm/dljgzhappraisal','list','2','代理机构综合考评列表','2','B00008');
                         
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgzhappraisal' and method='toAdd' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013025','/bdm/dljgzhappraisal','toAdd','2','代理机构综合考评新增','2','B00008');
                         
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgzhappraisal' and method='toEdit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013025','/bdm/dljgzhappraisal','toEdit','2','代理机构综合考评编辑','2','B00008');
                         
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgzhappraisal' and method='save' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013025','/bdm/dljgzhappraisal','save','2','代理机构综合考评编辑','2','B00008');
                         
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/dljgzhappraisal' and method='update' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013025','/bdm/dljgzhappraisal','update','2','代理机构综合考评编辑','2','B00008');
                         
    end if;
    -------------- add by zhaoy 2017年11月29日end---------------
	
	------------------------add by nieche 2017年12月01日start---------------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='zgysIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','zgysIframe','0','首页Iframe-资格预审公告','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='ccNoticesIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','ccNoticesIframe','0','首页Iframe-变更（澄清）公告','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='zzNoticesIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','zzNoticesIframe','0','首页Iframe-终止公告','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='scalingsIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','scalingsIframe','0','首页Iframe-中标候选人公示','1','M00008');
    end if;
	
	num:=0;
    select count(1) into num from bs_qxmx where  action='/iframe' and method='bdZbjgggIframe' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/iframe','bdZbjgggIframe','0','首页Iframe-中标结果公告','1','M00008');
    end if;
	------------------------add by nieche 2017年12月01日end---------------------------
    

    ------------2017-11-30-hejw-start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/' and method='retrieve' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/','retrieve','0','首页-招标信息-信息检索','1','M00008');
    end if;
    ------------2017-11-30-hejw-end-----------------
    
	------------add by lijb 2017年12月04日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='toVideoLearn' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','toVideoLearn','0','跳转到在线视频学习','1','M00009');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/zjme/home' and method='videoLearn' and sid = 'M00009';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('0','/zjme/home','videoLearn','0','在线视频学习','1','M00009');
    end if;
    ------------add by lijb 2017年12月04日end-----------------

	------------------------add by zhangzq 2017年12月04日start---------------------------
 	--------------平台统计报表
    num:=0;
    select count(1) into num from bs_xtmk where  mid='B0150' and sid = 'B00008';
    if num = 0 then
         insert into bs_xtmk(mid,mname,styp,ordby,sid) 
         values('B0150','平台统计报表','2',385,'B00008');
    end if;
    
     --------------子集团统计报表
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B015005' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B015005','B0150','平台统计报表','子集团统计报表','/bdm/count/subgroup/listSubgroup.do','/bdm/count/subgroup/listSubgroup.do', 1, 50, 2, 'B00008');
    end if;

	num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/subgroup' AND METHOD = 'listSubgroup' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015005', '/bdm/count/subgroup','listSubgroup','2','子集团统计报表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/subgroup' AND METHOD = 'export' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015005', '/bdm/count/subgroup','export','2','子集团统计报表-导出','2','B00008');
    end if;
    
     --------------投标详情统计报表
	num:=0;
    select count(1) into num from bs_qxsz where  mkid='B015010' and sid='B00008';
    if num = 0 then
         insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid) 
         values('B015010','B0150','平台统计报表','投标详情统计报表','/bdm/count/bid/listBid.do','/bdm/count/bid/listBid.do', 1, 100, 2, 'B00008');
    end if;
    
   num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/bid' AND METHOD = 'listBid' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015010', '/bdm/count/bid','listBid','2','投标详情统计报表','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from BS_QXMX WHERE ACTION = '/bdm/count/bid' AND METHOD = 'export' AND SID = 'B00008';
    if num = 0 then
      insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B015010', '/bdm/count/bid','export','2','投标详情统计报表-导出','2','B00008');
    end if;
    ------------------------add by zhangzq 2017年12月04日end---------------------------
	--------------add by zhaoy start--------------------
	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/bidding/buy/preficfile' and method='pbzjqdfs' and sid = 'M00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015', '/bdp/bidding/buy/preficfile', 'pbzjqdfs', 2, '招标方查看代理机构设置专家抽取方式页面', 1, 'M00008');
    end if;

  	num:=0;
    select count(1) into num from bs_qxmx where  action='/bdp/bidding/buy/preficfile' and method='pbzjqdfs' and sid = 'M10008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('M089015', '/bdp/bidding/buy/preficfile', 'pbzjqdfs', 2, '招标方查看代理机构设置专家抽取方式页面', 1, 'M10008');
    end if;
	--------------add by zhaoy end----------------------
	-----------add by lijb 2017年12月05日 start---------------
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='B014520' and sid='B00008' and name='新增支付信息'; 
    if num = 1 then
         update bs_qxsz set name='收款通知单审核' where mkid='B014520' and sid='B00008'; 
    end if;
    
    num:=0;
    select count(1) into num from  bs_qxsz where mkid='B014515' and sid='B00008' and orderno='50'; 
    if num = 1 then
         update bs_qxsz set orderno='250' where mkid='B014515' and sid='B00008'; 
    end if;
	-----------add by lijb 2017年12月05日 end---------------
    ---------------add by zhaoy 2017年12月07日start------------
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='downLoad' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','downLoad','2','下载投标文件','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where  action='/bdm/report/bdpack' and method='downLoad' and sid = 'B10008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B013505','/bdm/report/bdpack','downLoad','2','下载投标文件','2','B10008');
    end if;
    -------------- add by zhaoy 2017年12月07日end---------------
	------------add by lijb 2017年12月11日start-----------------
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toInvoiceEdit' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toInvoiceEdit','2','跳转到发票维护页面','2','B00008');
    end if;
    
	num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='saveInvoice' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','saveInvoice','2','保存发票信息','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toPlkp' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toPlkp','2','批量开票','2','B00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/bdm/hydd' and method='toExport' and sid = 'B00008';
    if num = 0 then
         insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) 
         values('B014515','/bdm/hydd','toExport','2','导出发票信息','2','B00008');
    end if;
    ------------add by lijb 2017年12月11日end-----------------
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
