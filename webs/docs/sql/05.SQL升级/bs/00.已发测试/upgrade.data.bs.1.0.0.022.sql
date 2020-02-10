DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.22'; -- 本升级文件的版本，每个升级文件必须修改
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
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0135'  and mkid='M013520';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M013520', 'M0135', '交货登记', '交货预警', '/tdp/trail/warning/list.do', '/tdp/trail/warning/list.do', 1, 50, 1, '', 'M00004');
     END IF;
      num:=0;
	select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M013520' and action='/tdp/trail/warning' and method='list';      
	if num = 0 then 
		insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values (bs_qxmx_0.nextval, 'M013520', '/tdp/trail/warning', 'list', 2, '合同跟踪-交货预警', 1, 'M00004');
     END IF;


     	num:=0;
	select count(1) into num from bs_qxmx where action='/tdp/trail/pay' and method='warnList' and styp=2 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx (pkid,mkid,action,method,accesstag,remark,styp,sid)
                values(bs_qxmx_0.nextval,'M015505','/tdp/trail/pay','warnList',2,'支付登记-预警',1,'M00004');
	end if;
	
		num:=0;
	select count(1) into num from bs_qxmx where action='/exp/tender/buy/evaluate' and method='dxhylist' and styp=2 and sid='M00004';
	if num = 0 then
		insert into BS_QXMX (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
			values (bs_qxmx_0.nextval, 'M020530', '/exp/tender/buy/evaluate', 'dxhylist', 2, '竞价采购-竞价中-查看定向会员', 1, 'M00004');
	end if;
	

       num:=0;
	select count(1) into num from  bs_qxsz where sid='M00004' and mid='M0155'  and mkid='M015525';       
	if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values('M015525','M0155','合同支付','支付预警','/tdp/trail/pay/warnList.do','/tdp/trail/pay/warnList.do',1,400,1,'','M00004');
       END IF;

    -------------------------------------------------------------
	num := 0;
	select count(1) into num from bs_xtmk where mid='M0265' and mname='采购定额管理' and sid='M00004';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0265','采购定额管理','1',260,'M00004','004-1-6');
	end if;

	num := 0;
	select count(1) into num from bs_xtmk where mid='M0270' and mname='产量管理' and sid='M00004';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0270','产量管理','1',265,'M00004','004-1-6');
	end if;

	num := 0;
	select count(1) into num from bs_xtmk where mid='M0275' and mname='订货分析管理' and sid='M00004';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0275','订货分析管理','1',270,'M00004','004-1-6');
	end if;

	num := 0;
	select count(1) into num from bs_xtmk where mid='M0260' and mname='库存管理' and sid='M00004';
	if num=0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid,qxrole)
		values('M0260','库存管理','1',275,'M00004','004-1-6');
	end if;

	num := 0;
	tmp1 := 'M026505';
	tmp2 := 'M0265';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'采购定额管理','产品管理',1, 100, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026510';
	tmp2 := 'M0265';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'采购定额管理','零部件全信息查询',1, 200, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026515';
	tmp2 := 'M0265';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'采购定额管理','零部件维护',1, 300, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027005';
	tmp2 := 'M0270';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'产量管理','月度计划',1, 100, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027010';
	tmp2 := 'M0270';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'产量管理','产量走势分析',1, 200, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027015';
	tmp2 := 'M0270';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'产量管理','产量维护',1, 300, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027505';
	tmp2 := 'M0275';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'订货分析管理','订货卡',1, 100, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027510';
	tmp2 := 'M0275';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'订货分析管理','生产进度查询',1, 200, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027515';
	tmp2 := 'M0275';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'订货分析管理','理论订货模型',1, 300, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M027515';
	tmp2 := 'M0275';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'订货分析管理','订货台账',1, 400, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026005';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','断点日历',1, 100, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026010';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','库龄分析',1, 200, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026015';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','断点清单',1, 300, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026020';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','配送看板',1, 400, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026025';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','在库台账',1, 400, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := 'M026030';
	tmp2 := 'M0260';
	select count(1) into num from bs_qxsz where mkid=tmp1 and mid=tmp2 and sid='M00004';
	if num=0 then
		insert into bs_qxsz(mkid,mid,mname,name,isuse,orderno,styp,sid)
		values(tmp1,tmp2,'库存管理','捆包出入库查询',1, 500, 1, 'M00004');
	end if;

	num := 0;
	tmp1 := '/me/estimate/home';
	tmp2 := 'index';
	select count(1)into num from bs_qxmx where mkid='0' and action=tmp1 and method=tmp2 and sid='M00004';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values ('0','/me/estimate/home','index',1,'我的平台(需求测算管理)',1,'M00004');
	end if;

	update bs_xtmk set qxrole='004-7' where sid='M00004' and mid in ('M0265','M0260','M0270','M0275');
	update bs_xtmk set qxrole='004-6' where sid='M00004' and mid='M0245';
	update bs_xtmk set qxrole='000-6' where sid='M00000' and mid='M0300';
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  