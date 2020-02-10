DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.8'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BD',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
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
    select count(1) into num from bd_cssz where cskey='SAFETY_TIPS';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('SAFETY_TIPS','会员密码安全性提示','建议用户每三个月修改密码！！！','系统管理员','',1,'',4500,'');
	end if;
	
	  num:=0;
    select count(1) into num from bd_cssz where cskey='JMJ_CERTDATA';   
	if num = 1 then
		update bd_cssz set flag1=1 where cskey='JMJ_CERTDATA';
	end if;
  
    num:=0;
    select count(1) into num from bd_cssz where cskey='SAFETY_TIPS';   
	if num = 1 then
		update bd_cssz set flag1=1 where cskey='SAFETY_TIPS';
	end if;
	
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_TIME_NODE_CONTROL';   
	if num = 0 then
		insert into bd_cssz (cskey, csmc, csvalue, mrz, opt, remark, flag0,unit,orderno,csbz)
  		values('M_TIME_NODE_CONTROL', '启用时间节点控制', '0', '0', '系统管理员', '若启用，业务流程受时间控制', 1, '', 5000,'1 - 启用 0 - 禁用；');
  		insert into bd_cssz_ext(typ,cskey,csvalue)values('M_TIME_NODE_CONTROL','0','禁用');
  		insert into bd_cssz_ext(typ,cskey,csvalue)values('M_TIME_NODE_CONTROL','1','启用');
	end if;
	
	--新增提交资格预审申请文件的时间参数设置
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_TBR_PRE_ASK_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_TBR_PRE_ASK_TIME','预审文件递交截止日期前','5','5','系统管理员','投标人提问截止',1,'天',5100,'投标人预审文件提问截止');
	end if;
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_ZBR_PRE_CLARIFY_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_ZBR_PRE_CLARIFY_TIME','预审文件递交截止日期前','5','5','系统管理员','招标人澄清截止',1,'天',5200,'招标人预审文件澄清截止');
	end if;
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_TBR_ASK_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_TBR_ASK_TIME','投标文件递交截止日期前','5','5','系统管理员','投标人提问截止',1,'天',5300,'投标人投标文件提问截止');
	end if;
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_ZBR_CLARIFY_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_ZBR_CLARIFY_TIME','投标文件递交截止日期前','5','5','系统管理员','招标人澄清截止',1,'天',5400,'招标人投标文件澄清截止');
	end if;
	
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_BUILD_PRE_JURY_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_BUILD_PRE_JURY_TIME','申请文件递交截止时间前','5','5','系统管理员','开始组建评审委员会',1,'小时',5500,'组建评审委员会开始');
	end if;
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_BUILD_JURY_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_BUILD_JURY_TIME','投标文件递交截止时间前','5','5','系统管理员','开始组建评标委员会',1,'小时',5600,'组建评标委员会开始');
	end if;
	
	num:=0;
    select count(1) into num from bd_cssz where cskey='M_BID_PUBLIC_TIME';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
  		values('M_BID_PUBLIC_TIME','中标候选人公示期','5','5','系统管理员','公示开始时间和公示结束时间间隔天数',1,'天',5700,'公示开始时间和公示结束时间间隔天数');
	end if;
	
  num:=0;
    select count(1) into num from sys_init where tname='BD_FJJBXX';   
	if num = 0 then
		insert into sys_init(tname, flag) values('BD_FJJBXX', 1);
	end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_REWARD';   
	if num = 0 then
		insert into sys_init(tname, flag) values('BD_REWARD', 1);
	end if;
  
  num:=0;
    select count(1) into num from sys_init where tname='BD_PBBG_ZSJG';   
	if num = 0 then
		insert into sys_init(tname, flag) values('BD_PBBG_ZSJG', 1);
	end if;
	
	num:=0;
	select count(1) into num from BD_value where key='CFCA-POSTURL' AND Gid='RunTime';   
	if num = 0 then
	   insert into BD_value (Gid, Key, Value, Remark)
	   values('RunTime','CFCA-POSTURL','http://192.168.1.105:8080/bdplatform/exp/bidding/sell/payment/callback.do','中金在线支付回调地址');
	end if;
	
	-----hejunwei  start--- value表是否还原标识-------------------
  num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key in ('BD_PROJECT','BD_JURY','BD_CONTRACT','BD_PAY_REQUEST');   
    if num > 0 then
        update bd_value set csflag='2' where gid='RunTime' and key in ('BD_PROJECT','BD_JURY','BD_CONTRACT','BD_PAY_REQUEST');  
    end if;
  
  num:=0;
    select count(1) into num from bd_value where gid='RunTime' and key in ('HostDomain','CFCA-POSTURL');   
    if num > 0 then
        update bd_value set csflag='0' where gid='RunTime' and key in ('HostDomain','CFCA-POSTURL');   
    end if;
	-----hejunwei  end----------------------
	-----hejunwei  Start----------------------
  num:=0;
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_USERID';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CSSZ_IS_CHECK_USERID','签章及签名用户名控制','1', '0','系统管理员','若启用，签章及签名受用户名影响',1, 5750,'1-启用 0-禁用');
    end if;
  
  num:=0;
    select count(1) into num from bd_cssz_ext where typ='CSSZ_IS_CHECK_USERID';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_USERID', '0', '禁用');
    insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_USERID', '1', '启用');
    end if;
  
  num:=0;
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_MBNAME';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CSSZ_IS_CHECK_MBNAME','签章及签名公司名称控制','0', '0','系统管理员','若启用，签章及签名受公司名称影响',1, 5800,'1-启用 0-禁用');
    end if;
  
  num:=0;
    select count(1) into num from bd_cssz_ext where typ='CSSZ_IS_CHECK_MBNAME';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_MBNAME', '0', '禁用');
    insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_MBNAME', '1', '启用');
    end if;
  
  num:=0;
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_ZTBCODE';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CSSZ_IS_CHECK_ZTBCODE','签章及签名CFCA标识控制','1', '0','系统管理员','若启用，签章及签名受CFCA代码影响',1, 5850,'1-启用 0-禁用');
    end if;

  num:=0;
    select count(1) into num from bd_cssz_ext where typ='CSSZ_IS_CHECK_ZTBCODE';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_ZTBCODE', '0', '禁用');
    insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_ZTBCODE', '1', '启用');
    end if;
    
  num:=0;
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_CERT';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CSSZ_IS_CHECK_CERT','签章及签名证书控制','1', '0','系统管理员','若启用，签章及签名受证书影响',1, 5900,'1-启用 0-禁用');
    end if;

  num:=0;
    select count(1) into num from bd_cssz_ext where typ='CSSZ_IS_CHECK_CERT';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_CERT', '0', '禁用');
    insert into bd_cssz_ext (typ, cskey, csvalue) values('CSSZ_IS_CHECK_CERT', '1', '启用');
    end if;
	-----hejunwei  end----------------------
	
	
	--删除多出的中标候选人公示期
    num:=0;
    select count(1) into num from bd_cssz where cskey='M_BID_PUBLIC_TIME';   
    if num = 1 then
        delete  from bd_cssz where cskey='M_BID_PUBLIC_TIME';
    end if;
    --删除多出的中标候选人公示期

	num := 0;
	select count(1) into num from BD_BK_BANK where bkcode='102' and bktype=2;
	if num = 0 then
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '工商银行', '102', 'zbztb_bankicbc.jpg', 1, 10, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '农业银行', '103', 'zbztb_bankabc.jpg', 1, 20, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中国银行', '104', 'zbztb_bankboc.jpg', 1, 30, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '建设银行', '105', 'zbztb_bankccb.jpg', 1, 40, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '民生银行', '305', 'zbztb_bankcmbc.jpg', 1, 50, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '广发银行', '306', 'zbztb_bankcgb.jpg', 1, 60, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '交通银行', '301', 'zbztb_bankbocom.jpg', 1, 70, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '光大银行', '303', 'zbztb_bankceb.jpg', 1, 80, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '北京银行', '403', 'zbztb_bankbob.jpg', 1, 90, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '平安银行', '307', 'zbztb_bankpab.jpg', 1, 110, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '招商银行', '308', 'zbztb_bankcmb.jpg', 1, 120, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '东亚银行', '3001', 'zbztb_bankbea.jpg', 1, 130, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '兰州银行', '447', 'zbztb_bankblz.jpg', 1, 140, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '宁波银行', '408', 'zbztb_bankbnb.jpg', 1, 150, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '南京银行', '424', 'zbztb_bankbnj.jpg', 1, 160, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '青岛银行', '450', 'zbztb_bankbqd.jpg', 1, 170, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '上海银行', '401', 'zbztb_bankbsh.jpg', 1, 180, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中金支付', '700', 'zbztb_bankcfca.jpg', 1, 190, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '兴业银行', '309', 'zbztb_bankcib.jpg', 1, 200, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '常熟农商银行', '1403', 'zbztb_bankcrcb.jpg', 1, 210, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '浙商银行', '316', 'zbztb_bankczb.jpg', 1, 220, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中信银行', '302', 'zbztb_bankecitic.jpg', 1, 230, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '河北银行', '422', 'zbztb_bankhb.jpg', 1, 240, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '哈尔滨银行', '442', 'zbztb_bankhrbcb.jpg', 1, 250, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '徽商银行', '440', 'zbztb_bankhs.jpg', 1, 260, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '华夏银行', '304', 'zbztb_bankhxb.jpg', 1, 270, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '杭州银行', '423', 'zbztb_bankhzb.jpg', 1, 280, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '邮储银行', '100', 'zbztb_bankpsbc.jpg', 1, 290, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '浦发银行', '310', 'zbztb_bankspd.jpg', 1, 300, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '天津银行', '434', 'zbztb_banktccb.jpg', 1, 310, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '尧都农商银行', '1434', 'zbztb_bankydrcb.jpg', 1, 320, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '颍淮农村商业银行', '1565', 'zbztb_bankyhrcb.jpg', 1, 330, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '工商银行', '102', 'zbztb_bankicbc.jpg', 2, 10, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '农业银行', '103', 'zbztb_bankabc.jpg', 2, 20, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中国银行', '104', 'zbztb_bankboc.jpg', 2, 30, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '建设银行', '105', 'zbztb_bankccb.jpg', 2, 40, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '民生银行', '305', 'zbztb_bankcmbc.jpg', 2, 50, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '广发银行', '306', 'zbztb_bankcgb.jpg', 2, 60, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '交通银行', '301', 'zbztb_bankbocom.jpg', 2, 70, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '光大银行', '303', 'zbztb_bankceb.jpg', 2, 80, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '北京银行', '403', 'zbztb_bankbob.jpg', 2, 90, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '在线支付', '889', 'zbztb_bankup.jpg', 2, 100, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '平安银行', '307', 'zbztb_bankpab.jpg', 2, 110, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '招商银行', '308', 'zbztb_bankcmb.jpg', 2, 120, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '东亚银行', '3001', 'zbztb_bankbea.jpg', 2, 130, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '兰州银行', '447', 'zbztb_bankblz.jpg', 2, 140, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '宁波银行', '408', 'zbztb_bankbnb.jpg', 2, 150, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '南京银行', '424', 'zbztb_bankbnj.jpg', 2, 160, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '青岛银行', '450', 'zbztb_bankbqd.jpg', 2, 170, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '上海银行', '401', 'zbztb_bankbsh.jpg', 2, 180, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中金支付', '700', 'zbztb_bankcfca.jpg', 2, 190, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '兴业银行', '309', 'zbztb_bankcib.jpg', 2, 200, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '常熟农商银行', '1403', 'zbztb_bankcrcb.jpg', 2, 210, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '浙商银行', '316', 'zbztb_bankczb.jpg', 2, 220, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '中信银行', '302', 'zbztb_bankecitic.jpg', 2, 230, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '河北银行', '422', 'zbztb_bankhb.jpg', 2, 240, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '哈尔滨银行', '442', 'zbztb_bankhrbcb.jpg', 2, 250, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '徽商银行', '440', 'zbztb_bankhs.jpg', 2, 260, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '华夏银行', '304', 'zbztb_bankhxb.jpg', 2, 270, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '杭州银行', '423', 'zbztb_bankhzb.jpg', 2, 280, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '邮储银行', '100', 'zbztb_bankpsbc.jpg', 2, 290, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '浦发银行', '310', 'zbztb_bankspd.jpg', 2, 300, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '天津银行', '434', 'zbztb_banktccb.jpg', 2, 310, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '尧都农商银行', '1434', 'zbztb_bankydrcb.jpg', 2, 320, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '颍淮农村商业银行', '1565', 'zbztb_bankyhrcb.jpg', 2, 330, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '在线支付', '889', 'zbztb_bankup.jpg', 1, 100, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '广州农商行', '1405', 'zbztb_bankgzrcb', 1, 340, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '齐鲁银行', '409', 'zbztb_bankql', 1, 350, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '南昌银行', '448', 'zbztb_banknc', 1, 360, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '桂林银行', '491', 'zbztb_bankgl', 1, 370, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '珲春农商行', '1562', 'zbztb_bankhcr', 1, 380, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '延边农商行', '1580', 'zbztb_bankybr', 1, 390, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '广州农商行', '1405', 'zbztb_bankgzrcb', 2, 340, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '齐鲁银行', '409', 'zbztb_bankql', 2, 350, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '南昌银行', '448', 'zbztb_banknc', 2, 360, 1);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '桂林银行', '491', 'zbztb_bankgl', 2, 370, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '珲春农商行', '1562', 'zbztb_bankhcr', 2, 380, 0);
		
		insert into BD_BK_BANK (PKID, BKNAME, BKCODE, BKLOGO, BKTYPE, ORDERNO, STATUS)
		values (BD_BK_BANK_0.nextval, '延边农商行', '1580', 'zbztb_bankybr', 2, 390, 0);
	end if;
	
	
	num:=0;
    select count(1) into num from sys_init where tname='BD_BK_BANK';   
	if num = 0 then
		insert into sys_init(tname, flag) values('BD_BK_BANK', 0);
	end if;
	
	--hejw 20161209 start------
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoSmsTimeScheduler.autoSmsPayManager';   
    if num = 0 then
        insert into bd_auto_task (taskid,runtyp,servername,remark)
        values('AutoSmsTimeScheduler.autoSmsPayManager',1,'短信定时服务在招投标后台','短信及消息定时发送');
    end if;
	--hejw 20161209 end------

	------------2016/12/08 hanglong 资金支付定时任务 start--------------
	num:=0;
	select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoBondRelease';
	if num = 0 then
		insert into bd_auto_task(taskid, servername, remark, runtyp)
		values('AutoAuctionAction.autoBondRelease','hanglong','开标-保证金解冻转出',1);
	end if;
	
	num:=0;
	select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoBondLock';
	if num = 0 then
		insert into bd_auto_task(taskid, servername, remark, runtyp)
		values('AutoAuctionAction.autoBondLock','hanglong','保证金退款-保证金冻结转入',1);
	end if;
	------------2016/12/08 hanglong 资金支付定时任务 end--------------

	-----------2016/12/14 huyq 招投标后台参数设置名称、说明及排序调整  start------
	num:=0; --1.交易平台标识代码
    select count(1) into num from bd_cssz where cskey='JYPTBZDM';   
	if num = 1 then
		update bd_cssz set orderno=3000 where cskey='JYPTBZDM';
	end if;
	
	num:=0; --2.发布资格预审的媒介
    select count(1) into num from bd_cssz where cskey='ZZT_ZGYSWJMJ';   
	if num = 1 then
		update bd_cssz set orderno=3100 where cskey='ZZT_ZGYSWJMJ';
	end if;
	
	num:=0; --3.平台验证责任人
    select count(1) into num from bd_cssz where cskey='PTYZZRR';   
	if num = 1 then
		update bd_cssz set orderno=3200 where cskey='PTYZZRR';
	end if;
	
	num:=0; --4.会员密码安全性提示
    select count(1) into num from bd_cssz where cskey='SAFETY_TIPS';   
	if num = 1 then
		update bd_cssz set orderno=3300 where cskey='SAFETY_TIPS';
	end if;
	
	num:=0; --5.启用时间节点控制
    select count(1) into num from bd_cssz where cskey='M_TIME_NODE_CONTROL';   
	if num = 1 then
		update bd_cssz set orderno=3400 where cskey='M_TIME_NODE_CONTROL';
	end if;
	
	num:=0; --6.资格预审申请文件递交截止时间
    select count(1) into num from bd_cssz where cskey='SQWJDJJZSJ';   
	if num = 1 then
		update bd_cssz set orderno=3500,csmc='递交资格预审申请文件的期限，不少于',unit='日',remark='自资格预审文件购买开始发售之日起' where cskey='SQWJDJJZSJ';
	end if;
	
	num:=0; --7.资格预审申请文件发售期
    select count(1) into num from bd_cssz where cskey='ZGYSWJFSQ';   
	if num = 1 then
		update bd_cssz set orderno=3600,csmc='资格预审文件发售期',unit='日',remark='资格预审文件发售期不得少于5日' where cskey='ZGYSWJFSQ';
	end if;
	
	num:=0; --8.提交资格预审申请文件的时间
    select count(1) into num from bd_cssz where cskey='TJZGYSWJSJ';   
	if num = 1 then
		update bd_cssz set orderno=3700,csmc='递交资格预审申请文件的期限，不少于',unit='日',remark='自资格预审文件停止发售之日起' where cskey='TJZGYSWJSJ';
	end if;
	
	num:=0; --9.资格预审文件异议提交时间
    select count(1) into num from bd_cssz where cskey='ZGYSYYTJSJ';   
	if num = 1 then
		update bd_cssz set orderno=3800,csmc='资格预审文件异议提出期限',unit='日',remark='资格预审申请文件递交截止时间2日前提出' where cskey='ZGYSYYTJSJ';
	end if;
	
	num:=0; --10.预审文件递交截止日期前
    select count(1) into num from bd_cssz where cskey='M_TBR_PRE_ASK_TIME';   
	if num = 1 then
		update bd_cssz set orderno=3900,csmc='资格预审文件递交截止日期前',unit='日',remark='投标人提问的截止时间' where cskey='M_TBR_PRE_ASK_TIME';
	end if;
	
	num:=0; --11.预审文件递交截止日期前
    select count(1) into num from bd_cssz where cskey='M_ZBR_PRE_CLARIFY_TIME';   
	if num = 1 then
		update bd_cssz set orderno=4000,csmc='澄清或修改资格预审文件的期限',unit='日',remark='澄清或修改资格预审文件影响资格预审申请文件编制的，应在资格预审申请文件递交截止时间3日前作出。' where cskey='M_ZBR_PRE_CLARIFY_TIME';
	end if;
	
	num:=0; --12.招标文件购买开始至结束时间
    select count(1) into num from bd_cssz where cskey='ZBWJ_GMJSSJ';   
	if num = 1 then
		update bd_cssz set orderno=4100,csmc='招标文件发售期',unit='日',remark='招标文件发售期不得少于5日' where cskey='ZBWJ_GMJSSJ';
	end if;
	
	num:=0; --13.招标文件购买开始时间至投标文件截止日期(即开标日期)
    select count(1) into num from bd_cssz where cskey='TBWJ_JZSJ';   
	if num = 1 then
		update bd_cssz set orderno=4200,csmc='递交投标文件的期限，不少于',unit='日',remark='递交投标文件的期限，自招标文件发出之日起不得少于20日' where cskey='TBWJ_JZSJ';
	end if;
	
	num:=0; --14.开标后投标方确认时间控制参数
    select count(1) into num from bd_cssz where cskey='KB_TBQR_DATE';   
	if num = 1 then
		update bd_cssz set orderno=4300,csmc='开标后各方确认开标记录的时间控制参数',remark='开标后各方确认开标记录的时间控制参数' where cskey='KB_TBQR_DATE';
	end if;
	
	num:=0; --15.招标文件异议可提交时间
    select count(1) into num from bd_cssz where cskey='ZBWJYYTJSJ';   
	if num = 1 then
		update bd_cssz set orderno=4400,csmc='招标文件异议提出时间期限',unit='日',remark='投标截止时间10日前提出' where cskey='ZBWJYYTJSJ';
	end if;
	
	num:=0; --16.中标候选人公示开始至结束时间(开始当天不算)
    select count(1) into num from bd_cssz where cskey='ZBHXRGS_JSSJ';   
	if num = 1 then
		update bd_cssz set orderno=4500,csmc='中标候选人公示期(开始当天不算)',unit='日',remark='中标候选人公示期不少于3日' where cskey='ZBHXRGS_JSSJ';
	end if;
	
	num:=0; --17.投标文件递交截止日期前
    select count(1) into num from bd_cssz where cskey='M_TBR_ASK_TIME';   
	if num = 1 then
		update bd_cssz set orderno=4600,csmc='投标文件递交截止日期前',unit='日',remark='投标人提问的截止时间' where cskey='M_TBR_ASK_TIME';
	end if;
	
	num:=0; --18.开标异议可提交时间
    select count(1) into num from bd_cssz where cskey='KBYYTJSJ';   
	if num = 1 then
		update bd_cssz set orderno=4700,csmc='开标异议提出期限',remark='自生成开标记录表后-分钟内' where cskey='KBYYTJSJ';
	end if;
	
	num:=0; --19.投标文件递交截止日期前
    select count(1) into num from bd_cssz where cskey='M_ZBR_CLARIFY_TIME';   
	if num = 1 then
		update bd_cssz set orderno=4800,csmc='澄清或修改招标文件的时间',unit='日',remark='澄清或修改招标文件影响投标文件编制的，应在投标截止时间15日前作出。' where cskey='M_ZBR_CLARIFY_TIME';
	end if;
	
	num:=0; --20.审查委员会人数
    select count(1) into num from bd_cssz where cskey='PSWYH_RS';   
	if num = 1 then
		update bd_cssz set orderno=4900,csmc='委员会人数，不少于',remark='审查委员会人数' where cskey='PSWYH_RS';
	end if;
	
	num:=0; --21.抽取专家回复有效期
    select count(1) into num from bd_cssz where cskey='EXTRACT_ZJ_REPLY_SC';   
	if num = 1 then
		update bd_cssz set orderno=5000,csmc='抽取专家短信回复有效期',remark='超过该时长回复的短信确认为无效' where cskey='EXTRACT_ZJ_REPLY_SC';
	end if;
	
	num:=0; --22.申请文件递交截止时间前
    select count(1) into num from bd_cssz where cskey='M_BUILD_PRE_JURY_TIME';   
	if num = 1 then
		update bd_cssz set orderno=5100,csmc='资格预审文件递交截止时间前',remark='开始组建评审委员会的时间' where cskey='M_BUILD_PRE_JURY_TIME';
	end if;
	
	num:=0; --23.投标文件递交截止时间前
    select count(1) into num from bd_cssz where cskey='M_BUILD_JURY_TIME';   
	if num = 1 then
		update bd_cssz set orderno=5200,csmc='投标文件递交截止时间前',remark='开始组建评标委员会的时间' where cskey='M_BUILD_JURY_TIME';
	end if;
	
	num:=0; --24.资格预审公告是否审核
    select count(1) into num from bd_cssz where cskey='ISVERIFY';   
	if num = 1 then
		update bd_cssz set orderno=5300,csmc='资格预审公告是否需要审核' where cskey='ISVERIFY';
	end if;
	
	num:=0; --25.招标异常是否审核
    select count(1) into num from bd_cssz where cskey='ZBYC_SFSH';   
	if num = 1 then
		update bd_cssz set orderno=5400,csmc='招标异常是否需要审核',remark='0-不需要审核 ，1-需要审核' where cskey='ZBYC_SFSH';
	end if;
	
	num:=0; --26.报名是否确认
    select count(1) into num from bd_cssz where cskey='ISCONFIRM';   
	if num = 1 then
		update bd_cssz set orderno=5500,csmc='招标异常是否需要审核',remark='0-不需要审核 ，1-需要审核' where cskey='ISCONFIRM';
	end if;
	
	num:=0; --27.澄清文件是否需要后台审核
    select count(1) into num from bd_cssz where cskey='CQWJ_SFHTSH';   
	if num = 1 then
		update bd_cssz set orderno=5600,csmc='澄清文件发送是否需要后台审核',remark='0-不需要审核 ，1-需要审核' where cskey='CQWJ_SFHTSH';
	end if;
	
	num:=0; --28.变更公告是否需要后台审核
    select count(1) into num from bd_cssz where cskey='BGGG_SFHTSH';   
	if num = 1 then
		update bd_cssz set orderno=5700,csmc='变更公告是否需要后台审核',remark='0-不需要审核 ，1-需要审核' where cskey='BGGG_SFHTSH';
	end if;
	
	num:=0; --29.加密机加解密证书
    select count(1) into num from bd_cssz where cskey='JMJ_CERTDATA';   
	if num = 1 then
		update bd_cssz set orderno=5800 where cskey='JMJ_CERTDATA';
	end if;
	
	num:=0; --30.加密机加解密KEY序号
    select count(1) into num from bd_cssz where cskey='JMJ_KEYID';   
	if num = 1 then
		update bd_cssz set orderno=5900 where cskey='JMJ_KEYID';
	end if;
	
	num:=0; --31.签章及签名用户名控制
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_USERID';   
	if num = 1 then
		update bd_cssz set orderno=6000 where cskey='CSSZ_IS_CHECK_USERID';
	end if;
	
	num:=0; --32.签章及签名公司名称控制
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_MBNAME';   
	if num = 1 then
		update bd_cssz set orderno=6100 where cskey='CSSZ_IS_CHECK_MBNAME';
	end if;
	
	num:=0; --33.签章及签名CFCA标识控制
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_ZTBCODE';   
	if num = 1 then
		update bd_cssz set orderno=6200,remark='若启用，签章及签名受CFCA代码影响' where cskey='CSSZ_IS_CHECK_ZTBCODE';
	end if;
	
	num:=0; --34.签章及签名证书控制
    select count(1) into num from bd_cssz where cskey='CSSZ_IS_CHECK_CERT';   
	if num = 1 then
		update bd_cssz set orderno=6300 where cskey='CSSZ_IS_CHECK_CERT';
	end if;
	
	num:=0; --26.报名是否确认
    select count(1) into num from bd_cssz where cskey='ISCONFIRM';   
	if num = 1 then
		update bd_cssz set orderno=5500,csmc='报名是否需要确认',remark='0-不需要审核 ，1-需要审核' where cskey='ISCONFIRM';
	end if;
	
	-----------2016/12/14 huyq 招投标后台参数设置名称、说明及排序调整  end------
    
    --add by chenxp start--
    num:=0;
    select count(1) into num from bd_cssz where cskey='HTQD_TXSJ';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('HTQD_TXSJ','提醒未签订合同的招标人和中标人在中标通知书发出之后的','26','','系统管理员','合同签订',1,'天',6400,'提醒招标人和中标人签订合同');
    end if;
    
    num:=0;
    select count(1) into num from bd_cssz where cskey='XMJS_TXSJ';   
      if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue, mrz,opt,remark,flag0,unit,orderno,csbz)
        values('XMJS_TXSJ','短信提醒距招标项目有效期还有','5','','系统管理员','合同签订',1,'天',6500,'提醒招标人,代理机构,投标人招标项目有效期快结束');
    end if;
    --add by chenxp end--

	--zhangzq 20170112 采招网数据同步定时任务 start------
    num:=0;
    select count(1) into num from bd_auto_task where taskid='NoticeQueueAction.reflashQueue';   
    if num = 0 then
        insert into bd_auto_task (taskid,runtyp,servername,remark)
        values('NoticeQueueAction.reflashQueue',1,'zhangzq','采招网数据同步定时任务');
    end if;
	--zhangzq 20170112 end------

	----------------- 2017-01-11 zhangzq 数据对照表插入数据 start--------------------
	----------------- 标讯招标
	num := 0;
	select count(1) into num from bd_sjdz where typ='标讯类别' and code='1';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'标讯类别','0','国内招标');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'标讯类别','1','国际招标');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'标讯类别','2','政府采购');	
	end if;
	
	----------------- 资金来源
	num := 0;
	select count(1) into num from bd_sjdz where typ='资金来源' and code='1';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','0','国内政府资金');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','1','商业融资');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','2','外国政府贷款');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','3','世界银行贷款');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','4','亚洲开发银行');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','5','日元贷款');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','6','非洲开发银行贷款');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','7','欧洲复兴与开发银行贷款');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'资金来源','10','其它');
	end if;
	
	----------------- 招标类型
	num := 0;
	select count(1) into num from bd_sjdz where typ='招标类型' and code='001';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'招标类型','001','工程招标');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'招标类型','002','货物招标');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'招标类型','003','服务招标');	
	end if;
	
	----------------- 行业
	num := 0;
	select count(1) into num from bd_sjdz where typ='行业' and code='1';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','2','网络通讯计算机');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑');	
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','4','水利桥梁');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','6','环保');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','8','医疗卫生');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','11','出版印刷');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','15','其它');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'行业','16','园林绿化');
	end if;
	
	----------------- 地区
	num := 0;
	select count(1) into num from bd_sjdz where typ='地区' and code='1';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','1','北京');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','2','上海');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','3','天津');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','4','重庆');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','5','河北');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','6','山西');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','7','内蒙古');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','8','辽宁');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','9','吉林');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','10','黑龙江');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','11','江苏');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','12','浙江');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','13','安徽');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','14','福建');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','15','江西');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','16','山东');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','17','河南');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','18','湖北');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','19','湖南');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','20','广东');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','21','广西');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','22','海南');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','23','贵州');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','24','云南');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','25','西藏');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','26','陕西');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','27','四川');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','28','甘肃');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','29','青海');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','30','新疆');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','31','宁夏');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','32','香港');
	
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','33','澳门');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','34','台湾');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','36','跨省');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','43','亚洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','44','欧洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','45','非洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','46','北美洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','47','南美洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','48','大洋洲');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','50','加勒比');
		
		insert into bd_sjdz (pkid,typ,code,mc)
		values(BD_SJDZ_0.nextval,'地区','49','中美洲');
	end if;
	----------------- 2017-01-11 zhangzq  end--------------------

    -- 修改之前的几个主要数据 2017-01-12 hejw start-------------------------
    num := 0;
    select count(1) into num from bd_package where bdzt is null and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    if num > 0 then
        update bd_package set bdzt=0 where bdzt is null and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    end if;
  
    num := 0;
    select count(1) into num from bd_package where packStatus is null and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    if num > 0 then
        update bd_package set packStatus=0 where packStatus is null and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    end if;
  
    num := 0;
    select count(1) into num from bd_subproject t where status is null and t.date1 <=  TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    if num > 0 then
        update bd_subproject t set status=0 where status is null and t.date1 <=  TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    end if;
    
    num := 0;
    select count(1) into num from bd_package where nvl(packStatus, 0)=100 and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    if num > 0 then
        update bd_package set packStatus=900 where nvl(packStatus, 0)=100 and edtdate <= TO_DATE('2017-01-22 01:00:00','yyyy-mm-dd hh24:mi:ss');
    end if;
    -- 修改之前的几个主要数据 2017-01-12 hejw end-------------------------

	----------------- 2017-01-16 zhangzq 数据对照表增加数据 start--------------------
	----地区
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='1';   
	if num = 1 then
		update bd_sjdz set provincedm='110100' where typ='地区' and code='1';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='2';   
	if num = 1 then
		update bd_sjdz set provincedm='310000' where typ='地区' and code='2';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='3';   
	if num = 1 then
		update bd_sjdz set provincedm='120000' where typ='地区' and code='3';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='4';   
	if num = 1 then
		update bd_sjdz set provincedm='500000' where typ='地区' and code='4';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='5';   
	if num = 1 then
		update bd_sjdz set provincedm='130000' where typ='地区' and code='5';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='6';   
	if num = 1 then
		update bd_sjdz set provincedm='140000' where typ='地区' and code='6';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='7';   
	if num = 1 then
		update bd_sjdz set provincedm='150000' where typ='地区' and code='7';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='8';   
	if num = 1 then
		update bd_sjdz set provincedm='210000' where typ='地区' and code='8';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='9';   
	if num = 1 then
		update bd_sjdz set provincedm='220000' where typ='地区' and code='9';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='10';   
	if num = 1 then
		update bd_sjdz set provincedm='230000' where typ='地区' and code='10';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='11';   
	if num = 1 then
		update bd_sjdz set provincedm='320000' where typ='地区' and code='11';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='12';   
	if num = 1 then
		update bd_sjdz set provincedm='330000' where typ='地区' and code='12';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='13';   
	if num = 1 then
		update bd_sjdz set provincedm='340000' where typ='地区' and code='13';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='14';   
	if num = 1 then
		update bd_sjdz set provincedm='350000' where typ='地区' and code='14';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='15';   
	if num = 1 then
		update bd_sjdz set provincedm='360000' where typ='地区' and code='15';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='16';   
	if num = 1 then
		update bd_sjdz set provincedm='370000' where typ='地区' and code='16';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='17';   
	if num = 1 then
		update bd_sjdz set provincedm='410000' where typ='地区' and code='17';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='18';   
	if num = 1 then
		update bd_sjdz set provincedm='420000' where typ='地区' and code='18';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='19';   
	if num = 1 then
		update bd_sjdz set provincedm='430000' where typ='地区' and code='19';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='20';   
	if num = 1 then
		update bd_sjdz set provincedm='440000' where typ='地区' and code='20';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='21';   
	if num = 1 then
		update bd_sjdz set provincedm='450000' where typ='地区' and code='21';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='22';   
	if num = 1 then
		update bd_sjdz set provincedm='460000' where typ='地区' and code='22';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='23';   
	if num = 1 then
		update bd_sjdz set provincedm='520000' where typ='地区' and code='23';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='24';   
	if num = 1 then
		update bd_sjdz set provincedm='530000' where typ='地区' and code='24';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='25';   
	if num = 1 then
		update bd_sjdz set provincedm='540000' where typ='地区' and code='25';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='26';   
	if num = 1 then
		update bd_sjdz set provincedm='610000' where typ='地区' and code='26';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='27';   
	if num = 1 then
		update bd_sjdz set provincedm='510000' where typ='地区' and code='27';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='28';   
	if num = 1 then
		update bd_sjdz set provincedm='620000' where typ='地区' and code='28';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='29';   
	if num = 1 then
		update bd_sjdz set provincedm='630000' where typ='地区' and code='29';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='30';   
	if num = 1 then
		update bd_sjdz set provincedm='650000' where typ='地区' and code='30';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='地区' and code='31';   
	if num = 1 then
		update bd_sjdz set provincedm='640000' where typ='地区' and code='31';
	end if;
	
	----行业
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='1';   
	if num = 1 then
		update bd_sjdz set hyfl='G' where typ='行业' and code='1';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='7';   
	if num = 1 then
		update bd_sjdz set hyfl='D' where typ='行业' and code='7';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='10';   
	if num = 1 then
		update bd_sjdz set hyfl='B' where typ='行业' and code='10';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='2';   
	if num = 1 then
		update bd_sjdz set hyfl='I' where typ='行业' and code='2';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='3';   
	if num = 1 then
		update bd_sjdz set hyfl='E' where typ='行业' and code='3';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='4';   
	if num = 1 then
		update bd_sjdz set hyfl='N' where typ='行业' and code='4';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='8';   
	if num = 1 then
		update bd_sjdz set hyfl='Q' where typ='行业' and code='8';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='9';   
	if num = 1 then
		update bd_sjdz set hyfl='P' where typ='行业' and code='9';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='12';   
	if num = 1 then
		update bd_sjdz set hyfl='C' where typ='行业' and code='12';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='13';   
	if num = 1 then
		update bd_sjdz set hyfl='A' where typ='行业' and code='13';
	end if;
	
	num:=0;
	select count(1) into num from bd_sjdz where typ='行业' and code='14';   
	if num = 1 then
		update bd_sjdz set hyfl='L' where typ='行业' and code='14';
	end if;
	----------------- 2017-01-16 zhangzq 数据对照表增加数据 end--------------------

	----------------- 2017-01-19 zhangzq 后台参数设置是否启用采招网消息队列同步 start--------------------
	num:=0;
	select count(1) into num from bd_cssz where cskey='CZ_ENABLE';   
	if num = 0 then
		insert into bd_cssz (cskey, csmc, csvalue, mrz, opt, remark, flag0,unit,orderno,csbz)
		values('CZ_ENABLE', '启用采招网消息队列同步', '0', '0', '系统管理员', '0-禁用，1-启用', 1, '', 7000,'1 - 启用 0 - 禁用；');
		insert into bd_cssz_ext(typ,cskey,csvalue)values('CZ_ENABLE','0','禁用');
		insert into bd_cssz_ext(typ,cskey,csvalue)values('CZ_ENABLE','1','启用');
	end if;
	----------------- 2017-01-19 zhangzq 后台参数设置是否启用采招网消息队列同步 end--------------------
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  