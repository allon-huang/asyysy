DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.30'; -- 本升级文件的版本，每个升级文件必须修改
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
    
  	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='syncBstatus' and styp=2 and sid='B00301';
	if num=0 then
		insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
		values('B010525','/ecim/account/info/manage','syncBstatus',2,'中信银行账户签约同步银行状态',2,'B00301');
	end if;
	num :=0;
	select count(1) into num from bs_qxmx where action='/ecim/account/info/manage' and method='export2Excel' and styp=2 and sid='B00301';
	if num=0 then
	    insert into bs_qxmx(mkid, action, method, accesstag, remark, styp, sid)
	    values('B010525','/ecim/account/info/manage','export2Excel',2,'中信银行账户签约导出',2,'B00301');
	end if;

	
  	update bs_qxsz set isuse=0 where  sid='B00002' and mkid='B010002';
update bs_qxsz set isuse=0 where  sid='B00002' and mkid='B010003';
update bs_qxsz set isuse=0 where  sid='B00002' and mkid='B010004';
update bs_qxsz set isuse=0 where  sid='B00002' and mkid='B010005';
update bs_qxsz set isuse=0 where  sid='B00002' and mkid='B010010';

 delete from bs_value where gid='CACHE';

  num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='bsmanager';
  if num=0 then 
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','bsmanager','http://bs.td.steel56.com.cn/bsmanager/cache/reflashCache.do','基础平台后台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='bsplatform';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','bsplatform','http://bs.td.steel56.com.cn/bsplatform/cache/reflashCache.do','设置中心前台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='armanager';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','armanager','http://ar.td.steel56.com.cn/armanager/cache/reflashCache.do','交易后台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='arplatform';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','arplatform','http://ar.td.steel56.com.cn/arplatform/cache/reflashCache.do','交易前台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='scmanager';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','scmanager','http://sc.td.steel56.com.cn/scmanager/cache/reflashCache.do','积分平台后台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='scplatform';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','scplatform','http://sc.td.steel56.com.cn/scplatform/cache/reflashCache.do','积分平台前台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='smsmanager';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','smsmanager','http://sms.td.steel56.com.cn/smsmanager/cache/reflashCache.do','短信平台后台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='smsplatform';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','smsplatform','http://sms.td.steel56.com.cn/smsplatform/cache/reflashCache.do','短信平台前台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='tdmanager';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','tdmanager','http://td.td.steel56.com.cn/tdmanager/cache/reflashCache.do','招标平台后台刷新缓存地址');
	end if;
   num :=0;
  select count(1) into num from bs_value where gid='CACHE' and key='tdplatform';
  if num=0 then
      insert into bs_value(gid, key, value, remark)
	    values('CACHE','tdplatform','http://td.td.steel56.com.cn/tdplatform/cache/reflashCache.do','招标平台前台刷新缓存地址');
	end if;
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  