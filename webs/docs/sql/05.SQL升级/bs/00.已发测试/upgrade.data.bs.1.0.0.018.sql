DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.18'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from bs_qxmx where  sid='M00000' and action='/market/publicfun' and method='getBsCsgroupAByGID' and styp=1;       
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values(bs_qxmx_0.nextval,0,'/market/publicfun','getBsCsgroupAByGID',1,'根据客户组id查询所有的客服人员',1,'M00000');
    end if;
	
    
  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/suplier/manage' and method='showimg' and sid='M00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'0','/bsp/supplier/manage','showimg',0,'供应商审核-查看附件',1,'M00000');
  end if;

  num :=0;
  select count(1) into num from bs_qxmx where action='/bsp/suplier/manage' and method='delete' and sid='M00000';
  if num = 0 then
    insert into bs_qxmx(pkid, mkid, action, method, accesstag, remark, styp, sid)
    values(bs_qxmx_0.nextval,'M03000505','/bsp/suplier/manage','delete',2,'供应商登记-删除',1,'M00000');
  end if;
  
update bs_qxsz set isuse=0 where sid='M00004' and mkid in('M024505','M024510');
    -- 团购权限调整
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M02300505' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M02300505','M0230','发起团购','编辑',2,5,1,'M023005','M00004');
		
		update bs_qxmx set mkid='M02300505' where action='/gb/hangsource/sell/publish' and styp=1 and sid='M00004' and method in ('category','index','preview','save');
		
		update bs_qxmx set mkid='M02300505' where action='/gb/hangsource/sell/hangadmin' and styp=1 and sid='M00004' and method in ('toSetPrice','doSetPrice','doDel','doDelAll');
		
	end if;

	num:=0;
	select count(1) into num from bs_qxsz where mkid='M02300510' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,isuse,orderno,styp,parent,sid)
		values('M02300510','M0230','发起团购','发布',2,10,1,'M023005','M00004');
		
		update bs_qxmx set mkid='M02300510' where action='/gb/hangsource/sell/hangadmin' and styp=1 and sid='M00004' and method in ('doGpAll','doGpAllPreview','doCp','doCpAll');
	end if;
    
    delete bs_qxsz where mkid='M023020' and sid='M00004';
    
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M023005' and sid='M00004' and inurl like '#/gb/hangsource/sell/publish/index.do';
	if num = 0 then
		update bs_qxsz set inurl = concat(inurl,'#/gb/hangsource/sell/publish/index.do') where mkid='M023005' and sid='M00004';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M023005' and sid='M00004' and inurl like '#/gb/hangsource/sell/publish/preview.do';
	if num = 0 then
		update bs_qxsz set inurl = concat(inurl,'#/gb/hangsource/sell/publish/preview.do') where mkid='M023005' and sid='M00004';
	end if;
    

    --dl询价权限调整 2014-01-07 start
    delete from bs_qxsz where mkid='M017010' and mid='M0170' and mname='新建询货单' and styp=1 and sid='M00004';
    --询价权限设置
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M01700505' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01700505','M0170','询货采购','编辑','','',2,100,1,'M017005','M00004');
	end if;
    num:=0;
	select count(1) into num from bs_qxsz where mkid='M01700510' and sid='M00004';
	if num = 0 then
		insert into bs_qxsz (mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M01700510','M0170','询货采购','发布','','',2,200,1,'M017005','M00004');
	end if;
  
  --询价新增
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='tenderChooseAppointMember' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='showAppointMemberList' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='delete' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='getMemberList' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toAddQuery' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='saveQuery' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toUpdate' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='batchEnable' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='batchDisable' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='batchDelete' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='category' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='getCategory' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='previewBj' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='savaPrice' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toPrice' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toAdd' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toEdit' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='toInfo' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='save' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='update' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='export2Excel' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/buy' and method='dodel' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='preview' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='saveContract2Tmp' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='getorderMx' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='createbill' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='toAddShd' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700505' where action='/exp/querybusiness/process/buy' and method='saveShd' and styp=1 and sid='M00004';
 
  --询价查看
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/common' and method='xjggTop' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/common' and method='xjggList' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/common' and method='xjggInfo' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/buy' and method='list' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/process/buy' and method='list' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M017005' where action='/exp/querybusiness/completed/buy' and method='list' and styp=1 and sid='M00004';

  --发布
  update bs_qxmx set mkid='M01700510' where action='/exp/querybusiness/buy' and method='release' and styp=1 and sid='M00004';
  update bs_qxmx set mkid='M01700510' where action='/exp/querybusiness/buy' and method='releases' and styp=1 and sid='M00004';

  --dl询价权限调整 2014-01-07 end

	-------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  