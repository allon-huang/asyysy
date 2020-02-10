DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.24'; -- 本升级文件的版本，每个升级文件必须修改
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
  
        update bs_system set orderno=100 where sid='B00201' and styp='2';
	update bs_system set orderno=200 where sid='B00004' and styp='2';
	update bs_system set orderno=300 where sid='B00000' and styp='2';
	update bs_system set orderno=400 where sid='B00100' and styp='2';
	update bs_system set orderno=500 where sid='B00002' and styp='2';

	update bs_qxsz set name='需求明细报表' where mkid='M022535' and styp=1 and sid='M00004';
    update bs_qxsz set name='计划明细报表' where mkid='M022540' and styp=1 and sid='M00004';
    update bs_qxsz set name='任务明细报表' where mkid='M022545' and styp=1 and sid='M00004';
  	
	num:=0;
	select count(1) into num from bs_xtmk where  mid='M0285' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0285','价格公示',1,75,'M00004','004-8');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028505' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028505','M0285','价格公示','价格公示管理','/tdp/price/publicity/manage/list.do','/tdp/price/publicity/manage/list.do#/tdp/price/publicity/manage/add.do#/tdp/price/publicity/manage/copy.do',1,100,1,'','M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M02850505' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02850505','M0285','价格公示','编辑','','',2,100,1,'M028505','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028510' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028510','M0285','价格公示','价格公示审核','/tdp/price/publicity/audit/list.do','/tdp/price/publicity/audit/list.do#/tdp/price/publicity/audit/audit.do',1,200,1,'','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M02851005' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M02851005','M0285','价格公示','编辑','','',2,200,1,'M028510','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028515' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028515','M0285','价格公示','公共信息','/tdp/price/publicity/index/publicList.do','/tdp/price/publicity/index/publicList.do',1,300,1,'','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028520' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028520','M0285','价格公示','公共过期信息','/tdp/price/publicity/index/publicOverdueList.do','/tdp/price/publicity/index/publicOverdueList.do',1,400,1,'','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028525' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028525','M0285','价格公示','定向信息','/tdp/price/publicity/index/appointList.do','/tdp/price/publicity/index/appointList.do',1,500,1,'','M00004');
    end if;
	
 	num:=0;
	select count(1) into num from bs_qxsz where  mkid='M028530' and sid='M00004' ;       
	if num = 0 then 
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M028530','M0285','价格公示','定向过期信息','/tdp/price/publicity/index/appointOverdueList.do','/tdp/price/publicity/index/appointOverdueList.do',1,600,1,'','M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='list' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028505','/tdp/price/publicity/manage','list',2,'价格管理-查看',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='add' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','add',2,'价格管理-新增编辑',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='copy' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','copy',2,'价格管理-转发',1,'M00004');
    end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='save' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','save',2,'价格管理-保存',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='delete' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','delete',2,'价格管理-删除',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='deletemore' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','deletemore',2,'价格管理-批量删除',1,'M00004');
    end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='offshelf' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02850505','/tdp/price/publicity/manage','offshelf',2,'价格管理-下架',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/manage' and method='info' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,0,'/tdp/price/publicity/manage','info',0,'价格管理-查询信息',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/audit' and method='list' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028510','/tdp/price/publicity/audit','list',2,'价格审核-审核查看',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/audit' and method='audit' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02851005','/tdp/price/publicity/audit','audit',2,'价格审核-审核',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/audit' and method='confirm' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02851005','/tdp/price/publicity/audit','confirm',2,'价格审核-审核',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/audit' and method='cancelmore' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02851005','/tdp/price/publicity/audit','cancelmore',2,'价格审核-批量弃审',1,'M00004');
    end if;
	
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/audit' and method='passmore' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M02851005','/tdp/price/publicity/audit','passmore',2,'价格审核-批量审核',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='publicList' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028515','/tdp/price/publicity/index','publicList',2,'价格公示-公共信息',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='publicOverdueList' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028520','/tdp/price/publicity/index','publicOverdueList',2,'价格公示-公共过期信息',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='appointList' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028525','/tdp/price/publicity/index','appointList',2,'价格公示-定向信息',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='appointOverdueList' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M028530','/tdp/price/publicity/index','appointOverdueList',2,'价格公示-定向过期信息',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='frame' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'0','/tdp/price/publicity/index','frame',0,'价格公示-门户嵌套',1,'M00004');
    end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='filter' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'0','/tdp/price/publicity/index','filter',0,'价格公示-查询条件过滤',1,'M00004');
    end if;
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/price/publicity/index' and method='index' and  sid='M00004' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'0','/tdp/price/publicity/index','index',0,'价格公示-门户首页',1,'M00004');
    end if;
	
	update bs_qxsz set inurl='/tdp/report/req/list.do#/tdp/report/req/view.do' where mkid='M022535' and styp=1 and sid='M00004';
	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/req' and method='view' and sid='M00004' and styp=1;
	if num =0 then
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,'M022535','/tdp/report/req','view',2,'任务明细报表 - 查看',1,'M00004');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/login' and method='doIndexLogout' and  sid='M00000' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx ( MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ( '0', '/login', 'doIndexLogout', 0, '前台首页退出登录', 1, 'M00000');
    end if;
	
	update bs_qxmx set mkid='0',accesstag='0'where action='/tdp/puc/mission/manager' and method='viewPlanSupplier' and sid='M00004' and styp=1;
	
    num:=0;
	select count(1) into num from bs_xtmk where  mid='M0175' and sid='M00004' and QXROLE='004-3';       
	if num = 0 then 
	insert into bs_xtmk (MID, MNAME, STYP, URL00, URL01, URL02, URL03, URL04, URL05, URL06, URL07, URL08, URL09, URL10, ORDBY, SID, QXROLE)
        values ('M0175', '库存报表', 1, '', '', '', '', '', '', '', '', '', '', '', 1100, 'M00004', '004-3');

    end if;	
	
    num:=0;
	select count(1) into num from bs_qxsz  where mkid='M017505' and sid='M00004' and mid='M0175';     
	if num = 0 then 
        insert into bs_qxsz values ('M017505','M0175','库存报表','库存报表','/tdp/trail/repertory/list.do','/tdp/trail/repertory/list.do',1,100,1,'','M00004');
    end if;

    num:=0;
	select count(1) into num from bs_qxsz  where mkid='M016515' and sid='M00004' and mid='M0165';     
	if num = 0 then 
        insert into bs_qxsz values ('M016515','M0165','出库登记','出库明细','/tdp/trail/outDtl/list.do','/tdp/trail/outDtl/list.do',1,300,1,'','M00004');
    end if;

    num:=0;
	select count(1) into num from bs_qxsz  where mkid='M022580' and sid='M00004' and mid='M0225';     
	if num = 0 then 
        insert into bs_qxsz values ('M022580','M0225','集团报表','出库明细报表','/tdp/report/outDtl/list.do','/tdp/report/outDtl/list.do',1,850,1,'','M00004');
   end if;

   num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/repertory' and method='list' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M017505','/tdp/trail/repertory','list',2,'合同跟踪-库存报表',1,'M00004');
    end if;

    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/repertory' and method='exportExcel' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M017505','/tdp/trail/repertory','exportExcel',2,'合同跟踪-库存报表-导出',1,'M00004');
    end if;

    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/outDtl' and method='list' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022580','/tdp/report/outDtl','list',2,'集团报表—出库明细列表',1,'M00004');
    end if;

    num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/outDtl' and method='list' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M016515','/tdp/trail/outDtl','list',2,'合同跟踪-出库登记-明细列表',1,'M00004');
    end if;

        num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/outDtl' and method='exportExcel' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M016515','/tdp/trail/outDtl','exportExcel',2,'合同跟踪-出库登记-导出',1,'M00004');
    end if;

        num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/report/outDtl' and method='exportExcel' and  sid='M00004' ;       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M022580','/tdp/report/outDtl','exportExcel',2,'集团报表—导出',1,'M00004');
    end if;
    

    --新增出库登记模块权限 add by zhuchunhong 2014-01-11
    num:=0;
	select count(1) into num from bs_xtmk where mid='M0165' and sid='M00004' and qxrole='004-3';       
	if num = 0 then 
	insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole) values('M0165','出库登记',1,950,'M00004','004-3');
    end if;
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M016505' and sid='M00004' and mid='M0165';       
	if num = 0 then 
	insert into bs_qxsz values('M016505','M0165','出库登记','出库登记','/tdp/trail/out/list.do','/tdp/trail/out/list.do#/tdp/trail/out/toRecord.do#/tdp/trail/out/getTrailList.do#/tdp/trail/out/toEditRecord.do#/tdp/trail/out/toOpRecord.do',1,100,1,null,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxsz where  mkid='M016510' and sid='M00004' and mid='M0165';       
	if num = 0 then 
	insert into bs_qxsz values('M016510','M0165','出库登记','出库审核','/tdp/trail/outAudit/list.do','/tdp/trail/outAudit/list.do#/tdp/trail/outAudit/toOpRecord.do',1,200,1,null,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M01650510' and sid='M00004' and mid='M0165';       
	if num = 0 then 
	insert into bs_qxsz values('M01650510','M0165','出库登记','编辑',null,null,2,100,1,'M016505','M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M01651010' and sid='M00004' and mid='M0165';       
	if num = 0 then 
	insert into bs_qxsz values('M01651010','M0165','出库登记','审核',null,null,2,200,1,'M016510','M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M016505' and sid='M00004' and action='/tdp/trail/out' and method='list';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M016505','/tdp/trail/out','list',2,'合同跟踪-出库登记-登记列表',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M016505' and sid='M00004' and action='/tdp/trail/out' and method='getTrailList';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M016505','/tdp/trail/out','getTrailList',2,'合同跟踪-出库登记-登记列表',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='toRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','toRecord',2,'合同跟踪-出库登记-登记页面',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='doRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','doRecord',2,'合同跟踪-出库登记-登记保存',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='toEditRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','toEditRecord',2,'合同跟踪-出库登记-编辑',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='toOpRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','toOpRecord',2,'合同跟踪-出库登记-提交页面',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='submitRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','submitRecord',2,'合同跟踪-出库登记-出库提交',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01650510' and sid='M00004' and action='/tdp/trail/out' and method='exportExcel';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01650510','/tdp/trail/out','exportExcel',2,'合同跟踪-出库登记-导出',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M016510' and sid='M00004' and action='/tdp/trail/outAudit' and method='list';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M016510','/tdp/trail/outAudit','list',2,'合同跟踪-出库审核-审核列表',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01651010' and sid='M00004' and action='/tdp/trail/outAudit' and method='toOpRecord';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01651010','/tdp/trail/outAudit','toOpRecord',2,'合同跟踪-出库审核-审核页面',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01651010' and sid='M00004' and action='/tdp/trail/outAudit' and method='agree';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01651010','/tdp/trail/outAudit','agree',2,'合同跟踪-出库审核-审核同意',1,'M00004');
    end if;
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M01651010' and sid='M00004' and action='/tdp/trail/outAudit' and method='reject';       
	if num = 0 then 
	insert into bs_qxmx values(bs_qxmx_0.nextval,'M01651010','/tdp/trail/outAudit','reject',2,'合同跟踪-出库审核-审核不同意',1,'M00004');
    end if;

    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  