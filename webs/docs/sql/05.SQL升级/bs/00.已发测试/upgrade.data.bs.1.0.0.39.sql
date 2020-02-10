DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.39'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxsz where mkid='M01101020' and sid='M00201';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M01101020','M0110','商品管理','批量导入',2,115,1,'M011010','M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/hangadmin' and method='doFile' and styp=1 and mkid='M01101020' and sid='M00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M01101020','/exp/hangsource/sell/hangadmin','doFile',2,'上传页面',1,'M00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/hangadmin' and method='downLoad' and styp=1 and mkid='M01101020' and sid='M00201';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01101020','/exp/hangsource/sell/hangadmin','downLoad',2,'下载模板',1,'M00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/hangadmin' and method='doFilePreview' and styp=1 and mkid='M01101020' and sid='M00201';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01101020','/exp/hangsource/sell/hangadmin','doFilePreview',2,'保存浏览',1,'M00201');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/exp/hangsource/sell/hangadmin' and method='doFileModel' and styp=1 and mkid='M01101020' and sid='M00201';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M01101020','/exp/hangsource/sell/hangadmin','doFileModel',2,'临时表转正式表',1,'M00201');
  end if;
  
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/swfupload' and method='uploadKindEditor' and styp=1 and mkid='0' and sid='M00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/swfupload','uploadKindEditor',1,'编辑器图片上传',1,'M00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/swfupload' and method='upload' and styp=1 and mkid='0' and sid='M00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/swfupload','upload',0,'文件上传',1,'M00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B010060' and mid='B0100';
  if num=0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B010060','B0100','基本管理','公司介绍','/bsm/menber/intro/index.do','/bsm/menber/intro/index.do',1,'10',2,'','B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='B01006005' and mid='B0100' and parent='B010060';
  if num=0 then
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
    values('B01006005','B0100','基本管理','审核','','',2,'1500',2,'B010060','B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/menber/intro' and method='index' and styp=2 and mkid='B010060' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B010060','/bsm/menber/intro','index',2,'文件上传',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/menber/intro' and method='intro' and styp=2 and mkid='B010060' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B010060','/bsm/menber/intro','intro',2,'文件上传',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsm/menber/intro' and method='doConfirmIntro' and styp=2 and mkid='B01006005' and sid='B00000';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('B01006005','/bsm/menber/intro','doConfirmIntro',2,'文件上传',2,'B00000');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/bk/login/license' and method='success' and styp=1 and mkid='0' and sid='M00301';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('0','/bk/login/license','success',0,'签约确认跳转成功页面',1,'M00301');
  end if;
  
  num :=0;
  select count(1) into num from bs_xtmk where mid='M0305' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby, sid,qxrole) 
    values('M0305','供需发布',1,85,'M00004','004-9');
  end if;
  
  num :=0;
  select count(1) into num from bs_xtmk where mid='M0310' and sid='M00004' and styp=1;
  if num=0 then
    insert into bs_xtmk(mid,mname,styp,ordby, sid,qxrole) 
    values('M0310','线上委托',1,95,'M00004','004-10');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M030510' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M030510','M0305','供需发布','资源管理','/tdp/logistics/supply/index.do','/tdp/logistics/supply/index.do#/tdp/logistics/supply/toAdd.do','1','100','1','','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03051005' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03051005','M0305','供需发布','编辑','','','2','100','1','M030510','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M030515' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M030515','M0305','供需发布','资源审核','/tdp/logistics/supply/rev/index.do','/tdp/logistics/supply/rev/index.do#/tdp/logistics/supply/rev/toAudit.do','1','200','1','','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03051505' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03051505','M0305','供需发布','审核','','','2','200','1','M030515','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M030520' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M030520','M0305','供需发布','需求管理','/tdp/logistics/demand/index.do','/tdp/logistics/demand/index.do#/tdp/logistics/demand/toAdd.do','1','300','1','','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03052005' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03052005','M0305','供需发布','编辑','','','2','300','1','M030520','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M030525' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M030525','M0305','供需发布','需求审核','/tdp/logistics/demand/rev/index.do','/tdp/logistics/supply/rev/index.do#/tdp/logistics/demand/rev/toAudit.do','1','400','1','','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03052505' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03052505','M0305','供需发布','审核','','','2','400','1','M030525','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03052505' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M031010','M0310','线上委托','项目物流管理','/tdp/logistics/scheme/index.do','/tdp/logistics/scheme/index.do','1','100','1','','M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxsz where mkid='M031015' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M031015','M0310','线上委托','运输服务管理','/tdp/logistics/transport/index.do','/tdp/logistics/transport/index.do#/tdp/logistics/transport/toAdd.do','1','200','1','','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03101505' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03101505','M0310','线上委托','编辑','','','2','200','1','M031015','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M031020' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M031020','M0310','线上委托','运输服务审核','/tdp/logistics/transport/rev/index.do','/tdp/logistics/transport/rev/index.do#/tdp/logistics/transport/rev/toAudit.do','1','300','1','','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03102005' and sid='M00004' and styp=1;
  if num=0 then    
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
   values('M03102005','M0310','线上委托','审核','','','2','300','1','M031020','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M031025' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M031025','M0310','线上委托','仓储服务管理','/tdp/logistics/storage/index.do','/tdp/logistics/storage/index.do#/tdp/logistics/storage/toAdd.do','1','400','1','','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03102505' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03102505','M0310','线上委托','编辑','','','2','400','1','M031025','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M031030' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M031030','M0310','线上委托','仓储服务审核','/tdp/logistics/storage/rev/index.do','/tdp/logistics/storage/rev/index.do#/tdp/logistics/storage/rev/toAudit.do','1','500','1','','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxsz where mkid='M03103005' and sid='M00004' and styp=1;
  if num=0 then
  insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
  values('M03103005','M0310','线上委托','审核','','','2','500','1','M031030','M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply' and method='index' and styp=1 and sid='M00004';
  if num=0 then
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M030510','/tdp/logistics/supply','index',2,'供需发布-资源管理',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply' and method='toAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051005','/tdp/logistics/supply','toAdd',2,'供需发布-资源管理-新增',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply' and method='doAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051005','/tdp/logistics/supply','doAdd',2,'供需发布-资源管理-新增',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply' and method='delete' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051005','/tdp/logistics/supply','delete',2,'供需发布-资源管理-批量删除',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply' and method='info' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/supply','info',0,'供需发布-资源管理-资源信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply/rev' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M030515','/tdp/logistics/supply/rev','index',2,'供需发布-资源审核-资源信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply/rev' and method='toAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051505','/tdp/logistics/supply/rev','toAudit',2,'供需发布-资源审核-审核',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply/rev' and method='doAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051505','/tdp/logistics/supply/rev','doAudit',2,'供需发布-资源审核-审核',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply/rev' and method='doPassAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051505','/tdp/logistics/supply/rev','doPassAll',2,'供需发布-资源审核-批量审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/supply/rev' and method='doCannalAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03051505','/tdp/logistics/supply/rev','doCannalAll',2,'供需发布-资源审核-批量弃审',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M030520','/tdp/logistics/demand','index',2,'供需发布-需求管理-需求信息',1,'M00004');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand' and method='toAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052005','/tdp/logistics/demand','toAdd',2,'供需发布-需求管理-需求新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand' and method='doAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052005','/tdp/logistics/demand','doAdd',2,'供需发布-需求管理-需求新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand' and method='delete' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052005','/tdp/logistics/demand','delete',2,'供需发布-需求管理-需求删除',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand' and method='info' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/demand','info',0,'供需发布-需求管理-需求信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand/rev' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/demand/rev','index',0,'供需发布-需求管理-需求信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand/rev' and method='toAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052505','/tdp/logistics/demand/rev','toAudit',2,'供需发布-需求审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand/rev' and method='doAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052505','/tdp/logistics/demand/rev','doAudit',2,'供需发布-需求审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand/rev' and method='doPassAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052505','/tdp/logistics/demand/rev','doPassAll',2,'供需发布-需求审核-批量审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/demand/rev' and method='doCannalAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03052505','/tdp/logistics/demand/rev','doCannalAll',2,'供需发布-需求审核-批量弃审',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M031015','/tdp/logistics/transport','index',2,'线上委托-运输服务管理',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport' and method='toAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03101505','/tdp/logistics/transport','toAdd',2,'线上委托-运输服务管理-新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport' and method='doAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03101505','/tdp/logistics/transport','doAdd',2,'线上委托-运输服务管理-新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport' and method='delete' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03101505','/tdp/logistics/transport','delete',2,'线上委托-运输服务管理-删除',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport' and method='info' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/transport','info',0,'线上委托-运输服务管理-运输服务信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport/rev' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M031020','/tdp/logistics/transport/rev','index',2,'线上委托-运输服务审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport/rev' and method='toAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102005','/tdp/logistics/transport/rev','toAudit',2,'线上委托-运输服务审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport/rev' and method='doAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102005','/tdp/logistics/transport/rev','doAudit',2,'线上委托-运输服务审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport/rev' and method='doPassAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102005','/tdp/logistics/transport/rev','doPassAll',2,'线上委托-运输服务审核-批量审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/transport/rev' and method='doCannalAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102005','/tdp/logistics/transport/rev','doCannalAll',2,'线上委托-运输服务审核-批量弃审',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M031025','/tdp/logistics/storage','index',2,'线上委托-仓储服务管理',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage' and method='toAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102505','/tdp/logistics/storage','toAdd',2,'线上委托-仓储服务管理-新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage' and method='doAdd' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102505','/tdp/logistics/storage','doAdd',2,'线上委托-仓储服务管理-新增',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage' and method='delete' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03102505','/tdp/logistics/storage','delete',2,'线上委托-仓储服务管理-删除',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage' and method='info' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/storage','info',0,'线上委托-仓储服务管理-仓储服务信息',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage/rev' and method='index' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M031030','/tdp/logistics/storage/rev','index',2,'线上委托-仓储服务审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage/rev' and method='toAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03103005','/tdp/logistics/storage/rev','toAudit',2,'线上委托-仓储服务审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage/rev' and method='doAudit' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03103005','/tdp/logistics/storage/rev','doAudit',2,'线上委托-仓储服务审核-审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage/rev' and method='doPassAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03103005','/tdp/logistics/storage/rev','doPassAll',2,'线上委托-仓储服务审核-批量审核',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/storage/rev' and method='doCannalAll' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('M03103005','/tdp/logistics/storage/rev','doCannalAll',2,'线上委托-仓储服务审核-批量弃审',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='xqzy' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','xqzy',0,'物流平台-首页-需求资源',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='ysjg' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','ysjg',0,'物流平台-首页-参考价格',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='search' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','search',0,'物流平台-首页-参考价格查询',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='slys' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','slys',0,'物流平台-首页-水路运输信息',1,'M00004');
  end if;
    
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='ccfw' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','ccfw',0,'物流平台-首页-仓储服务信息',1,'M00004');
  end if;
    
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='searchMore' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','searchMore',0,'物流平台-首页-参考价格查询',1,'M00004');
  end if;
  
  num :=0;
  select count(1) into num from bs_qxmx where action='/tdp/logistics/index' and method='xqzyMore' and styp=1 and sid='M00004';
  if num=0 then
  insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
  values('0','/tdp/logistics/index','xqzyMore',0,'物流平台-首页-资源信息查询',1,'M00004');
  end if;


  

    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  