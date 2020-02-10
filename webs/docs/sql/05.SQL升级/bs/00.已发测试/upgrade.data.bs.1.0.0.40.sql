DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.40'; -- 本升级文件的版本，每个升级文件必须修改
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

	-- 2014/4/22	hangl	物流服务管理
	-- start
	num:=0;
	select count(1) into num from bs_xtmk where mid='B0140' and sid='B00004';
	if num = 0 then
		insert into bs_xtmk (mid,mname,styp,ordby,sid)
		values('B0140','物流服务管理',2,500,'B00004');
	end if;
	
	-- 公路运输设置
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B014005' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014005','B0140','物流服务管理','公路运输设置','/exm/tender/transport/gl/list.do','/exm/tender/transport/gl/list.do',1,100,2,'','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='list' and styp=2 and mkid='B014005' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014005','/exm/tender/transport/gl','list',2,'公路运输设置列表',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01400505' and parent='B014005' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01400505','B0140','物流服务管理','新增','','',2,110,2,'B014005','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='toAdd' and styp=2 and mkid='B01400505' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01400505','/exm/tender/transport/gl','toAdd',2,'打开新增页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='doAdd' and styp=2 and mkid='B01400505' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01400505','/exm/tender/transport/gl','doAdd',2,'新增保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01400510' and parent='B014005' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01400510','B0140','物流服务管理','修改','','',2,120,2,'B014005','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='toEdit' and styp=2 and mkid='B01400510' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01400510','/exm/tender/transport/gl','toEdit',2,'打开修改页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='doEdit' and styp=2 and mkid='B01400510' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01400510','/exm/tender/transport/gl','doEdit',2,'修改保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01400515' and parent='B014005' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01400515','B0140','物流服务管理','删除','','',2,130,2,'B014005','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/gl' and method='doDelete' and styp=2 and mkid='B01400515' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01400515','/exm/tender/transport/gl','doDelete',2,'删除',2,'B00004');
	end if;
	
	-- 铁路运输设置
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B014010' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014010','B0140','物流服务管理','铁路运输设置','/exm/tender/transport/tl/list.do','/exm/tender/transport/tl/list.do',1,200,2,'','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='list' and styp=2 and mkid='B014010' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014010','/exm/tender/transport/tl','list',2,'铁路运输设置列表',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401005' and parent='B014010' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401005','B0140','物流服务管理','新增','','',2,210,2,'B014010','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='toAdd' and styp=2 and mkid='B01401005' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401005','/exm/tender/transport/tl','toAdd',2,'打开新增页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='doAdd' and styp=2 and mkid='B01401005' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401005','/exm/tender/transport/tl','doAdd',2,'新增保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401010' and parent='B014010' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401010','B0140','物流服务管理','修改','','',2,220,2,'B014010','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='toEdit' and styp=2 and mkid='B01401010' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401010','/exm/tender/transport/tl','toEdit',2,'打开修改页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='doEdit' and styp=2 and mkid='B01401010' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401010','/exm/tender/transport/tl','doEdit',2,'修改保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401015' and parent='B014010' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401015','B0140','物流服务管理','删除','','',2,230,2,'B014010','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/tl' and method='doDelete' and styp=2 and mkid='B01401015' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401015','/exm/tender/transport/tl','doDelete',2,'删除',2,'B00004');
	end if;
	
	-- 水路运输设置
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B014015' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014015','B0140','物流服务管理','水路运输设置','/exm/tender/transport/sl/list.do','/exm/tender/transport/sl/list.do',1,300,2,'','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='list' and styp=2 and mkid='B014015' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014015','/exm/tender/transport/sl','list',2,'水路运输设置列表',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401505' and parent='B014015' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401505','B0140','物流服务管理','新增','','',2,310,2,'B014015','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='toAdd' and styp=2 and mkid='B01401505' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401505','/exm/tender/transport/sl','toAdd',2,'打开新增页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='doAdd' and styp=2 and mkid='B01401505' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401505','/exm/tender/transport/sl','doAdd',2,'新增保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401510' and parent='B014015' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401510','B0140','物流服务管理','修改','','',2,320,2,'B014015','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='toEdit' and styp=2 and mkid='B01401510' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401510','/exm/tender/transport/sl','toEdit',2,'打开修改页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='doEdit' and styp=2 and mkid='B01401510' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401510','/exm/tender/transport/sl','doEdit',2,'修改保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01401515' and parent='B014015' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01401515','B0140','物流服务管理','删除','','',2,330,2,'B014015','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/sl' and method='doDelete' and styp=2 and mkid='B01401515' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01401515','/exm/tender/transport/sl','doDelete',2,'删除',2,'B00004');
	end if;
	
	-- 仓储价格参考设置
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B014020' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B014020','B0140','物流服务管理','仓储价格参考设置','/exm/tender/transport/cangchu/list.do','/exm/tender/transport/cangchu/list.do',1,400,2,'','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='list' and styp=2 and mkid='B014020' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B014020','/exm/tender/transport/cangchu','list',2,'仓储价格参考设置列表',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01402005' and parent='B014020' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01402005','B0140','物流服务管理','新增','','',2,410,2,'B014020','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='toAdd' and styp=2 and mkid='B01402005' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402005','/exm/tender/transport/cangchu','toAdd',2,'打开新增页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='doAdd' and styp=2 and mkid='B01402005' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402005','/exm/tender/transport/cangchu','doAdd',2,'新增保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01402010' and parent='B014020' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01402010','B0140','物流服务管理','修改','','',2,420,2,'B014020','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='toEdit' and styp=2 and mkid='B01402010' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402010','/exm/tender/transport/cangchu','toEdit',2,'打开修改页面',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='doEdit' and styp=2 and mkid='B01402010' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402010','/exm/tender/transport/cangchu','doEdit',2,'修改保存',2,'B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxsz where mkid='B01402015' and parent='B014020' and mid='B0140' and sid='B00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('B01402015','B0140','物流服务管理','删除','','',2,430,2,'B014020','B00004');
	end if;
	
	num :=0;
	select count(1) into num from bs_qxmx where action='/exm/tender/transport/cangchu' and method='doDelete' and styp=2 and mkid='B01402015' and sid='B00004';
	if num=0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('B01402015','/exm/tender/transport/cangchu','doDelete',2,'删除',2,'B00004');
	end if;
	
	----- end

    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  