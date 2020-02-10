DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.64'; -- 本升级文件的版本，每个升级文件必须修改
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
	update bs_qxmx set mkid='M026505',action='/exp/stock/fixed' where mkid='M027015' and method='seeProductTree' and sid='M00004';
	update bs_qxsz set inurl='/exp/stock/fixed/list.do#/exp/stock/fixed/toAdd.do#/exp/stock/fixed/toEdit.do#/exp/stock/fixed/showInfo.do#/exp/stock/fixed/seeProductTree.do' where mkid='M026505' and mid='M0265' and name='产品' and sid='M00004';
	
    -- 2014/06/17 hanglong 实际付款登记
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01154020' and mid='B0115' and sid='B00201';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01154020','B0115','订单管理','实际付款登记','','',2,300,2,'B011540','B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/settle/contract/manage' and method='toPayReg' and styp=2 and mkid='B01154020' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('B01154020','/exm/settle/contract/manage','toPayReg',2,'进入实际付款登记页面',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/settle/contract/manage' and method='doPayReg' and styp=2 and mkid='B01154020' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('B01154020','/exm/settle/contract/manage','doPayReg',2,'实际付款登记',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/contract/bill/manage' and method='print' and styp=2 and mkid='B011550' and sid='B00201';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('B011550','/exm/contract/bill/manage','print',2,'打印',2,'B00201');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/parts' and method='showParts' and styp=1 and mkid='M026510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026510','/exp/stock/parts','showParts',2,'查看一级零部件信息',1,'M00004');
	end if;

	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/fixed' and method='getProductTree' and styp=1 and mkid='M026505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026505','/exp/stock/fixed','getProductTree',0,'产品信息树',1,'M00004');
	end if;

	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/partsbj' and method='updateBjStatus' and styp=1 and mkid='M026515' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026515','/exp/stock/partsbj','updateBjStatus',2,'修改二级零部件状态',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/parts' and method='updateLjStatus' and styp=1 and mkid='M026510' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026510','/exp/stock/parts','updateLjStatus',2,'修改一级零部件状态',1,'M00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exp/stock/fixed' and method='updateCpStatus' and styp=1 and mkid='M026505' and sid='M00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid) values('M026505','/exp/stock/fixed','updateCpStatus',2,'修改产品状态',1,'M00004');
	end if;

	update bs_qxmx set accesstag=2 where mkid='M01081020' and action='/exp/contract/buy/manage' and method='toRefuse' and sid='M00201';
	update bs_qxmx set accesstag=2 where mkid='M01081020' and action='/exp/contract/buy/manage' and method='refuse' and sid='M00201';
	update bs_qxmx set accesstag=2 where mkid='M01081020' and action='/exp/contract/buy/manage' and method='refuseRequest' and sid='M00201';
	update bs_qxmx set accesstag=2 where mkid='M01081020' and action='/exp/contract/buy/manage' and method='previewRefuse' and sid='M00201';
	
    
    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

