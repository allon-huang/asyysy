DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.72'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0180' and mkid = 'B018015';       
	if num = 1 then 
		update bs_qxsz set isuse = 0 where sid='B00201' and mid='B0180' and mkid = 'B018015';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0180' and mkid = 'B018020';       
	if num = 1 then 
		update bs_qxsz set isuse = 0 where sid='B00201' and mid='B0180' and mkid = 'B018020';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and name='订单成交统计表' and isuse = 1 and styp = 2;       
	if num = 1 then 
		update bs_qxsz set mkid = 'B018025', mid = 'B0180', mname = '交易统计报表', orderno = '50' where sid='B00201' and name='订单成交统计表' and isuse = 1 and styp = 2;
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/daycjtj' and method='list';       
	if num = 1 then 
		update bs_qxmx set mkid = 'B018025' where sid='B00201' and action = '/exm/report/daycjtj' and method='list';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/daycjtj' and method='export2Excel';   
	if num = 1 then 
		update bs_qxmx set mkid = 'B018025' where sid='B00201' and action = '/exm/report/daycjtj' and method='export2Excel';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and name='品牌成交统计表' and isuse = 1 and styp = 2;       
	if num = 1 then 
		update bs_qxsz set mkid = 'B018030', mid = 'B0180' , mname = '交易统计报表', orderno = '250' where sid='B00201' and name='品牌成交统计表' and isuse = 1 and styp = 2;
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/cjtj' and method='list';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018030' where sid='B00201' and action = '/exm/report/cjtj' and method='list';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/cjtj' and method='export2Excel';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018030' where sid='B00201' and action = '/exm/report/cjtj' and method='export2Excel';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and name='交易成交统计表' and isuse = 1 and styp = 2;       
	if num = 1 then 
		update bs_qxsz set mkid = 'B018035', mid = 'B0180', mname = '交易统计报表', name = '商品成交统计表',orderno = '300' where sid='B00201' and name='交易成交统计表' and isuse = 1 and styp = 2;
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/jycjtj' and method='list';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018035' where sid='B00201' and action = '/exm/report/jycjtj' and method='list';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/jycjtj' and method='export2Excel';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018035' where sid='B00201' and action = '/exm/report/jycjtj' and method='export2Excel';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and name='上架商品统计表' and isuse = 1 and styp = 2;       
	if num = 1 then 
		update bs_qxsz set mkid = 'B018040' , mid = 'B0180' , mname = '交易统计报表' , orderno = '350' where sid='B00201' and name='上架商品统计表' and isuse = 1 and styp = 2;
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/gpwztj' and method='list';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018040' where sid='B00201' and action = '/exm/report/gpwztj' and method='list';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/gpwztj' and method='export2Excel';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018040' where sid='B00201' and action = '/exm/report/gpwztj' and method='export2Excel';
    END IF;
    
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and name='价格对比表' and isuse = 1 and styp = 2;       
	if num = 1 then 
		update bs_qxsz set mkid = 'B018045' , mid = 'B0180' , mname = '交易统计报表' , orderno = '400' where sid='B00201' and name='价格对比表' and isuse = 1 and styp = 2;
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/jgdb' and method='list';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018045' where sid='B00201' and action = '/exm/report/jgdb' and method='list';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and action = '/exm/report/jgdb' and method='export2Excel';
	if num = 1 then 
		update bs_qxmx set mkid = 'B018045' where sid='B00201' and action = '/exm/report/jgdb' and method='export2Excel';
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0175' and mkid = 'M017570';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M017570', 'M0175', '市场管理中心', '订单执行报表树', '/exp/contract/order/reportTree/index.do', '/exp/contract/order/reportTree/index.do#/exp/contract/order/reportTree/list.do', 1, 110, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017570' and action='/exp/contract/order/reportTree' and method='index';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017570', '/exp/contract/order/reportTree', 'index', 2, '订单执行报表树首页', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017570' and action='/exp/contract/order/reportTree' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017570', '/exp/contract/order/reportTree', 'list', 2, '订单执行报表树列表', 1, 'M00201');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017550' and action='/exp/contract/jycjtj/report' and method='export2Excel';      
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M017550', '/exp/contract/jycjtj/report', 'export2Excel', 2, '导出会员交易统计表', 1, 'M00201');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017560' and action='/exp/contract/jytj/report' and method='export2Excel';      
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M017560', '/exp/contract/jytj/report', 'export2Excel', 2, '导出交易统计报表', 1, 'M00201');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M017540' and action='/exp/contract/cjtj/report' and method='export2Excel';      
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M017540', '/exp/contract/cjtj/report', 'export2Excel', 2, '导出会员交易总表', 1, 'M00201');
    END IF;
    
    -- 2014/8/8	hanglong	邮件订阅和邮件模板  start
    num:=0;
    select count(1) into num from  bs_xtmk where sid='B00002' and mid='B0101';      
    if num = 0 then 
        insert into bs_xtmk (mid, mname, styp, ordby, sid)
        values ('B0101', '邮件订阅', 2, 107, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00002' and mid='B0101' and mkid = 'B010020';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B010020', 'B0101', '邮件订阅', '订阅设置', '/smsm/mail/busset/list.do', '/smsm/mail/busset/list.do#', 1, 800, 2, '', 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B010020' and action='/smsm/mail/busset' and method='showEditTemplate';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010020', '/smsm/mail/busset', 'showEditTemplate', 2, '显示邮件订阅模版编辑页面', 2, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B010020' and action='/smsm/mail/busset' and method='doShowTemplate';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010020', '/smsm/mail/busset', 'doShowTemplate', 2, '显示邮件订阅模版列表页面', 2, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B010020' and action='/smsm/mail/busset' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B010020', '/smsm/mail/busset', 'list', 2, '显示邮件订阅列表页面', 2, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00002' and mid='B0101' and mkid = 'B01002005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B01002005', 'B0101', '邮件订阅', '编辑', '', '', 2, 850, 2, 'B010020', 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B01002005' and action='/smsm/mail/busset' and method='enabled';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01002005', '/smsm/mail/busset', 'enabled', 2, '启用/禁用邮件设置', 2, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B01002005' and action='/smsm/mail/busset' and method='enabledTemplate';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01002005', '/smsm/mail/busset', 'enabledTemplate', 2, '启用/禁用邮件模板', 2, 'B00002');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00002' and mkid='B01002005' and action='/smsm/mail/busset' and method='saveTemplate';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01002005', '/smsm/mail/busset', 'saveTemplate', 2, '保存邮件模板修改内容', 2, 'B00002');
    END IF;
    
    -- 邮件订阅和邮件模板  end
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='B014510' and sid='B00004';
    if num = 1 then 
        update bs_qxsz set isuse=0 where mkid='B014510' and sid='B00004';
    END IF;
    

    
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M011220' and action='/exp/contract/sell/manage' and method='getHistory';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011220', '/exp/contract/sell/manage', 'getHistory', 2, '获得发货人历史信息', 1, 'M00201');
    END IF;
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M011220' and action='/exp/contract/sell/manage' and method='getHistorydz';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011220', '/exp/contract/sell/manage', 'getHistorydz', 2, '获得发货人地址的历史信息', 1, 'M00201');
    END IF;
    

    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00000' and mkid='M011505' and action='/market/menber/mboptQx' and method='copyUserQx';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M011505', '/market/menber/mboptQx', 'copyUserQx', 2, '权限复制', 1, 'M00000');
    END IF;
    num:=0;
    
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B01153010' and action='/exm/entrust/manage' and method='reject';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B01153010', '/exm/entrust/manage', 'reject', 2, '配送拒绝', 2, 'B00201');
    END IF;
    
    num:=0;
    select count(1) into num from bs_qxmx where action='/swfupload' and method='uploadKindEditor' and sid='M00000';
    if num = 1 then 
        update bs_qxmx set accesstag=0 where action='/swfupload' and method='uploadKindEditor' and sid='M00000';
    END IF;
    
    -- 2014/08/14	换货查询	hanglong
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00201' and mid='B0115' and mkid = 'B011560';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B011560', 'B0115', '订单管理', '换货查询', '/exm/contract/return/manage/list.do', '/exm/contract/return/manage/list.do#', 1, 120, 2, '', 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B011560' and action='/exm/contract/return/manage' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011560', '/exm/contract/return/manage', 'list', 2, '换货查询列表', 2, 'B00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B011560' and action='/exm/contract/return/manage' and method='export';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011560', '/exm/contract/return/manage', 'export', 2, '换货查询列表', 2, 'B00201');
    END IF;
    -- end
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='B00201' and mid='B0140' and mkid='B014015';
    if num = 1 then 
        update bs_qxsz set isuse=0 where sid='B00201' and mid='B0140' and mkid='B014015';
    END IF;
    
     num:=0;
    select count(1) into num from  bs_qxmx mx where MKID='M020500' and  mx.accesstag=2 and  mx.action ='/exp/tender/buy/bout' and mx.method='downLoadFile' and mx.styp = 1 and mx.sid='M00004';    
    if num = 0 then 
       insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M020500', '/exp/tender/buy/bout', 'downLoadFile', 2, '竞价附件下载', 1, 'M00004');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx mx where MKID='B013010' and  mx.accesstag=2 and  mx.action ='/exm/tender/bout/verify' and mx.method='downLoadFile' and mx.styp = 2 and mx.sid='B00004';    
    if num = 0 then       
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'B013010', '/exm/tender/bout/verify', 'downLoadFile', 2, '竞标申请审核：附件查看', 2, 'B00004');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx mx where MKID='M021510' and  mx.accesstag=2 and  mx.action ='/exp/tender/sell/bout' and mx.method='downLoadFile' and mx.styp = 1 and mx.sid='M00004';    
    if num = 0 then       
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'M021510','/exp/tender/sell/bout','downLoadFile',2,'竞标附件查看',1,'M00004');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx mx where MKID='0' and  mx.accesstag=0 and  mx.action ='/' and mx.method='downLoadFile' and mx.styp = 1 and mx.sid='M00004';    
    if num = 0 then       
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, '0', '/', 'downLoadFile', 0, '附件查看', 1, 'M00004');
    END IF;
    
    num:=0;
    select count(1) into num from  bs_qxmx mx where MKID='B014510' and  mx.accesstag=2 and  mx.action ='/exm/querybusiness/manager' and mx.method='showTd' and mx.styp = 2 and mx.sid='B00004';    
    if num = 0 then       
         insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
        values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'showTd', 2, '询货采购查看', 2, 'B00004');
    END IF;
    
    num:=0;
    select count(1) into num from bs_qxmx mx where mkid = 'B014510' and mx.accesstag = 0 and action = '/exm/querybusiness/manager' and method = 'list' and sid = 'B00004';
    if num = 1 then 
        update bs_qxmx mx set mx.accesstag = 2 where mkid = 'B014510' and action = '/exm/querybusiness/manager' and method = 'list' and remark = '后台-询货采购管理' and sid = 'B00004';
    END IF;
     num:=0;
    select count(1) into num from bs_qxsz sz where MKID='B014510' and MID='B0145' and sz.isuse=0 and styp = 2 and sid ='B00004';
    if num = 1 then 
        update bs_qxsz sz set sz.isuse=1 where MKID='B014510' and MID='B0145' and styp = 2 and sid ='B00004';
    END IF;
    
    num:=0;
    select count(1) into num from bs_qxsz sz where MKID='B014510' and MID='B0145' and styp = 2 and sid ='B00004';
    if num = 1 then 
        update bs_qxsz sz set sz.name='询货采购查询',inurl='/exm/querybusiness/manager/list.do#/exm/querybusiness/manager/abort.do#/exm/querybusiness/manager/issue.do#/exm/querybusiness/manager/cancelIssue.do' where MKID='B014510' and MID='B0145' and styp = 2 and sid ='B00004';
    END IF;
    
    -- 2014/08/22	询货采购平台强制中止	hanglong
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014510' and action='/exm/querybusiness/manager' and method='abort';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'abort', 2, '平台强制中止询货采购', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='B00004' and mid='B0145' and mkid = 'B014515';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('B014515', 'B0145', '询货采购管理', '强制中止审核', '/exm/querybusiness/manager/audit/list.do', '/exm/querybusiness/manager/audit/list.do#/exm/querybusiness/manager/audit/agree.do#/exm/querybusiness/manager/audit/reject.do', 1, 300, 2, '', 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014515' and action='/exm/querybusiness/manager/audit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014515', '/exm/querybusiness/manager/audit', 'list', 2, '强制中止询货采购-列表', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014515' and action='/exm/querybusiness/manager/audit' and method='preview';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014515', '/exm/querybusiness/manager/audit', 'preview', 2, '强制中止询货采购-查看单据', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014515' and action='/exm/querybusiness/manager/audit' and method='agree';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014515', '/exm/querybusiness/manager/audit', 'agree', 2, '强制中止询货采购-同意', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014515' and action='/exm/querybusiness/manager/audit' and method='reject';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014515', '/exm/querybusiness/manager/audit', 'reject', 2, '强制中止询货采购-拒绝', 2, 'B00004');
    END IF;
    -- end

	-- 2014/08/22	询货采购发布公告	hanglong
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014510' and action='/exm/querybusiness/manager' and method='issue';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'issue', 2, '询货采购-发布公告', 2, 'B00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014510' and action='/exm/querybusiness/manager' and method='cancelIssue';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'cancelIssue', 2, '询货采购-撤销公告', 2, 'B00004');
    END IF;
	-- end

	--  2014/08/25 询货采购出价信息	huangjy
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00004' and mkid='B014510' and action='/exm/querybusiness/manager' and method='showchujia';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B014510', '/exm/querybusiness/manager', 'showchujia', 2, '询货采购-查看出价信息', 2, 'B00004');
    END IF;
    -- end
	--  2014/08/28货款结算导出	huangjy
	num:=0;
	select count(1) into num from  bs_qxmx where sid='B00201' and mkid='B011540' and action='/exm/settle/contract/manage' and method='export3Excel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'B011540', '/exm/settle/contract/manage', 'export3Excel', 2, '货款结算-导出', 2, 'B00201');
    END IF;
    -- end

	-- 2014/08/28 监察管理中心 hanglong start
	num:=0;
	select count(1) into num from  bs_xtmk where sid='M00201' and mid='M0185' ;      
	if num = 0 then 
		insert into bs_xtmk (mid, mname, styp, ordby, sid, qxrole)
		values ('M0185', '监察管理中心', 1, 800, 'M00201', '201-6');
    END IF;
	
	num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018505', 'M0185', '监察管理中心', '订单执行报表', '/exp/contract/order/report/jc/list.do', '/exp/contract/order/report/jc/list.do', 1, 200, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018505' and action='/exp/contract/order/report/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018505', '/exp/contract/order/report/jc', 'list', 2, '订单执行报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018510', 'M0185', '监察管理中心', '换货报表', '/exp/contract/exchangegoods/report/jc/list.do', '/exp/contract/exchangegoods/report/jc/list.do#/exp/contract/exchangegoods/report/jc/toInfo.do', 1, 400, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018510' and action='/exp/contract/exchangegoods/report/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018510', '/exp/contract/exchangegoods/report/jc', 'list', 2, '换货报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018510' and action='/exp/contract/exchangegoods/report/jc' and method='toInfo';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018510', '/exp/contract/exchangegoods/report/jc', 'toInfo', 2, '换货报表-查看换货详情', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018515';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018515', 'M0185', '监察管理中心', '会员交易总表', '/exp/contract/cjtj/report/jc/list.do', '/exp/contract/cjtj/report/jc/list.do', 1, 500, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018515' and action='/exp/contract/cjtj/report/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018515', '/exp/contract/cjtj/report/jc', 'list', 2, '会员交易总表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018515' and action='/exp/contract/cjtj/report/jc' and method='export2Excel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018515', '/exp/contract/cjtj/report/jc', 'export2Excel', 2, '导出会员交易报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018520';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018520', 'M0185', '监察管理中心', '会员交易统计表', '/exp/contract/jycjtj/report/jc/list.do', '/exp/contract/jycjtj/report/jc/list.do', 1, 600, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018520' and action='/exp/contract/jycjtj/report/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018520', '/exp/contract/jycjtj/report/jc', 'list', 2, '会员交易统计表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018520' and action='/exp/contract/jycjtj/report/jc' and method='export2Excel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018520', '/exp/contract/jycjtj/report/jc', 'export2Excel', 2, '导出会员交易统计表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018525';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018525', 'M0185', '监察管理中心', '交易统计报表', '/exp/contract/jytj/report/jc/list.do', '/exp/contract/jytj/report/jc/list.do', 1, 100, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018525' and action='/exp/contract/jytj/report/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018525', '/exp/contract/jytj/report/jc', 'list', 2, '交易统计报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018525' and action='/exp/contract/jytj/report/jc' and method='export2Excel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018525', '/exp/contract/jytj/report/jc', 'export2Excel', 2, '导出交易统计报表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00201' and mid='M0185' and mkid = 'M018530';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018530', 'M0185', '监察管理中心', '订单执行报表树', '/exp/contract/order/reportTree/jc/index.do', '/exp/contract/order/reportTree/jc/index.do#/exp/contract/order/reportTree/jc/list.do', 1, 300, 1, '', 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018530' and action='/exp/contract/order/reportTree/jc' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018530', '/exp/contract/order/reportTree/jc', 'list', 2, '订单执行报表树列表', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='M018530' and action='/exp/contract/order/reportTree/jc' and method='index';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018530', '/exp/contract/order/reportTree/jc', 'index', 2, '订单执行报表树首页', 1, 'M00201');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00201' and mkid='0' and action='/me/report/jc/home' and method='index';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/me/report/jc/home', 'index', 1, '监察管理中心首页', 1, 'M00201');
    END IF;
    
	-- end


    --询货采购审核   hjy
	  
	num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0180' and mkid = 'M018010';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M018010', 'M0180', '询货销售', '询货销售审核', '/exp/querybusiness/process/sell/shlist.do', '/exp/querybusiness/process/sell/shlist.do', 1, 200, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M018010' and action='/exp/querybusiness/process/sell' and method='shlist';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M018010', '/exp/querybusiness/process/sell', 'shlist', 2, '询货销售审核列表', 1, 'M00004');
    END IF;
    
    num:=0;
  	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M018010' and action='/exp/querybusiness/process/sell' and method='checkPrice';      
  	if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M018010', '/exp/querybusiness/process/sell', 'checkPrice', 2, '询货销售报价审核', 1, 'M00004');
    END IF;
    
    
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0180' and mkid = 'M01801005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M01801005', 'M0180', '询货审核', '询货销售审核', '', '', 2, 100, 1, 'M018010', 'M00004');
    END IF;
    
    
    num:=0;
  	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01801005' and action='/exp/querybusiness/process/sell' and method='tocheckPrice';      
  	if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01801005', '/exp/querybusiness/process/sell', 'tocheckPrice', 1, '询货销售报价审核页面', 1, 'M00004');
    END IF;
    
    
    num:=0;
  	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01801005' and action='/exp/querybusiness/process/sell' and method='docheckPrice';      
  	if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01801005', '/exp/querybusiness/process/sell', 'docheckPrice', 1, '询货销售报价审核', 1, 'M00004');
    END IF;
    
    num:=0;
  	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M01801005' and action='/exp/querybusiness/process/sell' and method='doplcheckPrice';      
  	if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M01801005', '/exp/querybusiness/process/sell', 'doplcheckPrice', 1, '询货销售报价批量审核', 1, 'M00004');
    END IF;
	--end


	-- 2014/09/02	采购平台供应商管理和制造商管理	start
	num:=0;
	select count(1) into num from  bs_xtmk where sid='M00004' and mid='M0320' ;      
	if num = 0 then 
		insert into bs_xtmk (mid, mname, styp, ordby, sid, qxrole)
		values ('M0320', '供应商管理', 1, 2000, 'M00004', '');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0320' and mkid = 'M032005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M032005', 'M0320', '供应商管理', '供应商管理', '/exp/td/supplier/manager/list.do', '/exp/td/supplier/manager/list.do#/exp/td/supplier/manager/toAdd.do#/exp/td/supplier/manager/doAdd.do#/exp/td/supplier/manager/toEdit.do#/exp/td/supplier/manager/doEdit.do#/exp/td/supplier/manager/doDel.do', 1, 100, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M032005' and action='/exp/td/supplier/manager' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M032005', '/exp/td/supplier/manager', 'list', 2, '供应商列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0320' and mkid = 'M03200505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200505', 'M0320', '供应商管理', '新增', '', '', 2, 100, 1, 'M032005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200505' and action='/exp/td/supplier/manager' and method='toAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200505', '/exp/td/supplier/manager', 'toAdd', 2, '进入新增页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200505' and action='/exp/td/supplier/manager' and method='doAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200505', '/exp/td/supplier/manager', 'doAdd', 2, '新增', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0320' and mkid = 'M03200510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200510', 'M0320', '供应商管理', '编辑', '', '', 2, 200, 1, 'M032005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200510' and action='/exp/td/supplier/manager' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200510', '/exp/td/supplier/manager', 'toEdit', 2, '进入编辑页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200510' and action='/exp/td/supplier/manager' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200510', '/exp/td/supplier/manager', 'doEdit', 2, '编辑', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0320' and mkid = 'M03200515';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03200515', 'M0320', '供应商管理', '删除', '', '', 2, 300, 1, 'M032005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200515' and action='/exp/td/supplier/manager' and method='doDel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200515', '/exp/td/supplier/manager', 'doDel', 2, '删除', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_xtmk where sid='M00004' and mid='M0330' ;      
	if num = 0 then 
		insert into bs_xtmk (mid, mname, styp, ordby, sid, qxrole)
		values ('M0330', '制造商管理', 1, 2500, 'M00004', '');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0330' and mkid = 'M033005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M033005', 'M0330', '制造商管理', '制造商管理', '/exp/td/manufacturer/manager/list.do', '/exp/td/manufacturer/manager/list.do#/exp/td/manufacturer/manager/toAdd.do#/exp/td/manufacturer/manager/doAdd.do#/exp/td/manufacturer/manager/toEdit.do#/exp/td/manufacturer/manager/doEdit.do#/exp/td/manufacturer/manager/doDel.do', 1, 100, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M033005' and action='/exp/td/manufacturer/manager' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M033005', '/exp/td/manufacturer/manager', 'list', 2, '制造商列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0330' and mkid = 'M03300505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03300505', 'M0330', '制造商管理', '新增', '', '', 2, 100, 1, 'M033005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300505' and action='/exp/td/manufacturer/manager' and method='toAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300505', '/exp/td/manufacturer/manager', 'toAdd', 2, '进入新增页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300505' and action='/exp/td/manufacturer/manager' and method='doAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300505', '/exp/td/manufacturer/manager', 'doAdd', 2, '新增', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0330' and mkid = 'M03300510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03300510', 'M0330', '制造商管理', '编辑', '', '', 2, 200, 1, 'M033005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300510' and action='/exp/td/manufacturer/manager' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300510', '/exp/td/manufacturer/manager', 'toEdit', 2, '进入编辑页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300510' and action='/exp/td/manufacturer/manager' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300510', '/exp/td/manufacturer/manager', 'doEdit', 2, '编辑', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0330' and mkid = 'M03300515';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03300515', 'M0330', '制造商管理', '删除', '', '', 2, 300, 1, 'M033005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300515' and action='/exp/td/manufacturer/manager' and method='doDel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300515', '/exp/td/manufacturer/manager', 'doDel', 2, '删除', 1, 'M00004');
    END IF;
	
	-- end

	-- 2014/09/02	集中采购	start
	--牵引到询价的权限
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M017005' and action='/exp/querybusiness/buy' and method='toConReqAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M017005', '/exp/querybusiness/buy', 'toConReqAdd', 1, '集中采购牵引到询价页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0170' and mkid='M017005';     
	if num = 1 then 
		update bs_qxsz set inurl='/exp/querybusiness/buy/list.do#/exp/querybusiness/process/buy/list.do#/exp/querybusiness/completed/buy/list.do#/exp/querybusiness/buy/toAdd.do#/exp/querybusiness/buy/toEdit.do#/exp/querybusiness/buy/arAdd.do#/exp/querybusiness/buy/toConReqAdd.do' where sid='M00004' and mid='M0170' and mkid='M017005';
    END IF;
    
	num:=0;
	select count(1) into num from  bs_xtmk where sid='M00004' and mid='M0340' ;      
	if num = 0 then 
		insert into bs_xtmk (mid, mname, styp, ordby, sid, qxrole)
		values ('M0340', '集中采购', 1, 350, 'M00004', '004-2');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M034005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M034005', 'M0340', '集中采购', '需求计划编制', '/tdp/puc/concentration/req/list.do', '/tdp/puc/concentration/req/list.do#/tdp/puc/concentration/req/preview.do#/tdp/puc/concentration/req/createQuery.do#/tdp/puc/concentration/req/toAdd.do#/tdp/puc/concentration/req/doAdd.do#/tdp/puc/concentration/req/toImportPm.do#/tdp/puc/concentration/req/downloadPmTemplate.do#/tdp/puc/concentration/req/doImportPm.do#/tdp/puc/concentration/req/toEdit.do#/tdp/puc/concentration/req/doEdit.do', 1, 100, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034005' and action='/tdp/puc/concentration/req' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034005', '/tdp/puc/concentration/req', 'list', 2, '需求计划编制列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034005' and action='/tdp/puc/concentration/req' and method='preview';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034005', '/tdp/puc/concentration/req', 'preview', 2, '需求计划编制查看', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034005' and action='/tdp/puc/concentration/req' and method='createQuery';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034005', '/tdp/puc/concentration/req', 'createQuery', 2, '需求计划编制-生成询价单', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03400505';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03400505', 'M0340', '需求计划编制', '新增', '', '', 2, 100, 1, 'M034005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='category';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'category', 2, '需求计划编制-进入类目选择页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='toAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'toAdd', 2, '需求计划编制-进入新增页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='toPmAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'toPmAdd', 2, '需求计划编制-进入新增产品页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='doAdd';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'doAdd', 2, '需求计划编制-新增', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='toImportPm';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'toImportPm', 2, '需求计划编制-进入导入产品页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='downloadPmTemplate';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'downloadPmTemplate', 2, '需求计划编制-下载产品模版', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400505' and action='/tdp/puc/concentration/req' and method='doImportPm';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400505', '/tdp/puc/concentration/req', 'doImportPm', 2, '需求计划编制-导入产品', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03400510';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03400510', 'M0340', '需求计划编制', '修改', '', '', 2, 200, 1, 'M034005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400510' and action='/tdp/puc/concentration/req' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400510', '/tdp/puc/concentration/req', 'toEdit', 2, '需求计划编制-进入修改页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400510' and action='/tdp/puc/concentration/req' and method='doEdit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400510', '/tdp/puc/concentration/req', 'doEdit', 2, '需求计划编制-修改', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03400515';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03400515', 'M0340', '需求计划编制', '提交', '', '', 2, 300, 1, 'M034005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400515' and action='/tdp/puc/concentration/req' and method='doSubmit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400515', '/tdp/puc/concentration/req', 'doSubmit', 2, '需求计划编制-提交', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03400520';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03400520', 'M0340', '需求计划编制', '删除', '', '', 2, 400, 1, 'M034005', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03400520' and action='/tdp/puc/concentration/req' and method='doDel';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03400520', '/tdp/puc/concentration/req', 'doDel', 2, '需求计划编制-删除', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M034010';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M034010', 'M0340', '集中采购', '需求计划审核', '/tdp/puc/concentration/audit/list.do', '/tdp/puc/concentration/audit/list.do#/tdp/puc/concentration/audit/resultList.do#/tdp/puc/concentration/audit/doMoreAudit.do', 1, 200, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034010' and action='/tdp/puc/concentration/audit' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034010', '/tdp/puc/concentration/audit', 'list', 2, '需求计划审核待审核列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034010' and action='/tdp/puc/concentration/audit' and method='resultList';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034010', '/tdp/puc/concentration/audit', 'resultList', 2, '需求计划审核审核结果列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034010' and action='/tdp/puc/concentration/audit' and method='preview';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034010', '/tdp/puc/concentration/audit', 'preview', 2, '需求计划编制查看', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03401005';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03401005', 'M0340', '需求计划审核', '审核', '', '', 2, 100, 1, 'M034010', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03401005' and action='/tdp/puc/concentration/audit' and method='toAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03401005', '/tdp/puc/concentration/audit', 'toAudit', 2, '需求计划审核-进入审核界面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03401005' and action='/tdp/puc/concentration/audit' and method='doAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03401005', '/tdp/puc/concentration/audit', 'doAudit', 2, '需求计划审核-审核', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03401005' and action='/tdp/puc/concentration/audit' and method='doMoreAudit';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03401005', '/tdp/puc/concentration/audit', 'doMoreAudit', 2, '需求计划审核-批量审核', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M03401010';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M03401010', 'M0340', '需求计划审核', '线下审核登记', '', '', 2, 100, 1, 'M034010', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03401010' and action='/tdp/puc/concentration/audit' and method='toAuditRecord';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03401010', '/tdp/puc/concentration/audit', 'toAuditRecord', 2, '需求计划审核-进入线下审核登记页面', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03401010' and action='/tdp/puc/concentration/audit' and method='doAuditRecord';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03401010', '/tdp/puc/concentration/audit', 'doAuditRecord', 2, '需求计划审核-线下审核登记', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0340' and mkid = 'M034015';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M034015', 'M0340', '集中采购', '需求计划明细', '/tdp/puc/concentration/mx/list.do', '/tdp/puc/concentration/mx/list.do', 1, 300, 1, '', 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034015' and action='/tdp/puc/concentration/mx' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034015', '/tdp/puc/concentration/mx', 'list', 2, '需求计划明细列表', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034015' and action='/tdp/puc/concentration/mx' and method='preview';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034015', '/tdp/puc/concentration/mx', 'preview', 2, '需求计划编制查看', 1, 'M00004');
    END IF;
	
	--	end
   -- 20140905  查看图片文件hjy
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03200510' and action='/exp/td/supplier/manager' and method='showimg';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03200510', '/exp/td/supplier/manager', 'showimg', 2, '查看图片', 1, 'M00004');
    END IF;
    
    num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M03300510' and action='/exp/td/manufacturer/manager' and method='showimg';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M03300510', '/exp/td/manufacturer/manager', 'showimg', 2, '查看图片', 1, 'M00004');
    END IF;


-- end 

	-- 2014/09/05 供应商和制造商弹出选择框
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='0' and action='/market/publicfun' and method='menber';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/market/publicfun', 'menber', 1, '供应商和制造商弹出选择框', 1, 'M00004');
    END IF;


	-- end

	-- 2014/09/11 物资品种树弹出选择框 hanglong
	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='0' and action='/market/publicfun' and method='getWzPzTree';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, '0', '/market/publicfun', 'getWzPzTree', 1, '物资品种树弹出选择框', 1, 'M00004');
    END IF;


	-- end


	--2014/09/10 hjy 引用集中采购需求
 	num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M034005' and action='/tdp/puc/concentration/req' and method='importlist';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M034005', '/tdp/puc/concentration/req', 'importlist', 1, '引用集中采购需求', 1, 'M00004');
    END IF;


	--end

	update bs_qxsz set name='拍卖采购' where mkid='M012520' and name='竞拍选购' and sid='M00103';
	update bs_qxsz set name='拍卖管理' where mkid='M011030' and name='竞拍管理' and sid='M00103';

    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

