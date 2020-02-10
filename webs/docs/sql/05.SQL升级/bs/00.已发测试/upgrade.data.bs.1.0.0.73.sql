DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.73'; -- 本升级文件的版本，每个升级文件必须修改
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

  -- 2014/09/13  合同登记审核-审核结果
  update bs_qxsz set inurl='/tdp/audit/pccontract/list.do#/tdp/audit/pccontract/showInfo.do#/tdp/audit/pccontract/resultList.do' where mkid='M013030' and mid='M0130' and sid='M00004';
  num:=0;
  select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M013030' and action='/tdp/audit/pccontract' and method='resultList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M013030', '/tdp/audit/pccontract', 'resultList', 2, '合同登记审核-审核结果', 1, 'M00004');
    END IF;
  -- end 
  
  -- 2014/09/13  合同登记审核-线下审核登记
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M013030' and action='/tdp/audit/pccontract' and method='toAuditRecord';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M013030', '/tdp/audit/pccontract', 'toAuditRecord', 2, '合同登记审核-进入线下审核登记页面', 1, 'M00004');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00004' and mkid='M013030' and action='/tdp/audit/pccontract' and method='doAuditRecord';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, 'M013030', '/tdp/audit/pccontract', 'doAuditRecord', 2, '合同登记审核-线下审核登记', 1, 'M00004');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/publish' and method='getMinPrice';      
  if num = 0 then 
      insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/sell/publish', 'getMinPrice', 1, '获取最低挂牌价', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/buy/publish' and method='getMaxPrice';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/buy/publish', 'getMaxPrice', 1, '获取最高挂牌价', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/sell/market' and method='edit';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/sell/market', 'edit', 0, '洽谈：标的信息', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getCzList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getCzList', 1, '获得材质列表AJAX', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getPmList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getPmList', 1, '获得品名列表AJAX', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getCdList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getCdList', 1, '获得产地列表AJAX', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getUsList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getUsList', 1, '获得用途列表AJAX', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/test' and method='test';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/test', 'test', 0, '', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/me/home' and method='index';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/me/home', 'index', 1, '我的平台', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='login';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'login', 0, '安卓前台登陆', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='logout';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'logout', 1, '安卓前台登出', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='version';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'version', 0, '安卓前台检测最新版本', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/financing/v10/freeimpawn/manager' and method='preview';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/financing/v10/freeimpawn/manager', 'preview', 1, '解押单预览', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/sms/business' and method='preview';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/sms/business', 'preview', 1, '现金兑换资源点预览', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='edit';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'edit', 0, '洽谈：标的信息', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='edit';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'edit', 0, '洽谈：标的信息', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/sell/market' and method='save';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/sell/market', 'save', 0, '洽谈：新增', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/market' and method='show';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/market', 'show', 0, '洽谈：入口', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='save';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'save', 0, '洽谈：新增', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/hangadmin' and method='getGpAmt';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/sell/hangadmin', 'getGpAmt', 1, '资源发布（卖）：剩余金额和保证金比例', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/nextAction' and method='index';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/nextAction', 'index', 0, '业务向导', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/market/syscode/publicfun' and method='getPwdRandom';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/market/syscode/publicfun', 'getPwdRandom', 0, '获得密码随机数', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='normal';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'normal', 0, '合同模版：正常（无条款）', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/buy/picksource' and method='getShopSourceList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/buy/picksource', 'getShopSourceList', 0, '会员商铺－首页', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/ask' and method='meIsOnline';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/ask', 'meIsOnline', 0, '客户端在线通知', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='showSfkmx';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'showSfkmx', 1, '合同模板：收付款明细', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='showSfkmx';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'showSfkmx', 1, '合同模板：收付款明细', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='showDissent';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'showDissent', 1, '合同模板：异议情况', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='showBreakContract';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'showBreakContract', 1, '合同模板：违约情况', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='pmlist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'pmlist', 1, '通过品种获取品名AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='czlist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'czlist', 1, '通过品名材质AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='cdlist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'cdlist', 1, '通过品名+材质获取厂商', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='uslist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'uslist', 1, '通过品名、材质、厂商获取用途', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/fund/callback' and method='call';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/fund/callback', 'call', 0, '资金平台回调（前台）', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/cache' and method='reflashCache';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/cache', 'reflashCache', 0, '刷新GTEC缓存', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/findPwd' and method='checkID';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/findPwd', 'checkID', 0, '安卓找回密码检查用户名', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/findPwd' and method='sendMobileCode';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/findPwd', 'sendMobileCode', 0, '安卓找回密码发送验证码', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/findPwd' and method='updatePwd';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/findPwd', 'updatePwd', 0, '安卓找回密码修改密码', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getUnitList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getUnitList', 1, '通过名得到几件单位AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getUnitList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getUnitList', 1, '通过名得到几件单位AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/market/menber/mboptQx' and method='save';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/market/menber/mboptQx', 'save', 1, '更新操作员权限', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/market/syscode/publicfun' and method='syscodelist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/market/syscode/publicfun', 'syscodelist', 1, '获取常用代码设置AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='preview';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'preview', 0, '合同模版：预览', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/market/syscode/publicfun' and method='removeFlash';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/market/syscode/publicfun', 'removeFlash', 0, '删除重复的消息提示', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='xllist';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'xllist', 1, '通过大类获得小类AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getCkList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getCkList', 1, '获得仓库列表AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/public/item' and method='getGgByPm';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/public/item', 'getGgByPm', 1, '通过品名得到规格AJAX', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/buy/picksource' and method='getShopJhdList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/buy/picksource', 'getShopJhdList', 0, '会员商铺－交货地列表', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/buy/picksource' and method='getShopPmList';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/hangsource/buy/picksource', 'getShopPmList', 0, '会员商铺－品名列表', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/contract/template' and method='viewPay';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/contract/template', 'viewPay', 1, '支付清单预览', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='editdg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'editdg', 0, '代购洽谈：标的信息', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='savedg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'savedg', 0, '代购洽谈：新增', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/sell/market' and method='editdg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/sell/market', 'editdg', 0, '代购洽谈：标的信息', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/sell/market' and method='updatedg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/sell/market', 'updatedg', 0, '代购洽谈：更新', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/buy/market' and method='updatedg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/buy/market', 'updatedg', 0, '代购洽谈：更新', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/qtbill/sell/market' and method='savedg';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/exp/qtbill/sell/market', 'savedg', 0, '代购洽谈：新增', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='index';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'index', 0, '安卓前面权限控制提示', 1, 'M00103');
   END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='access';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'access', 0, '安卓前台首次访问', 1, 'M00103');
  END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/m' and method='access';      
  if num = 0 then 
    insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    values (bs_qxmx_0.nextval, '0', '/m', 'exit', 0, '安卓前台登出', 1, 'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/hangadmin' and method='setup';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values('M011010','/exp/hangsource/sell/hangadmin','setup',2,'挂牌管理（卖）:统设',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/me/home' and method='index';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/me/home','index','1','我的平台',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/auth' and method='noAuth';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/auth','noAuth','0','我的平台',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/auth' and method='noAuth';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/ask','meIsOnline','0','我的平台',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/auth' and method='noAuth';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/ask','meIsOnline','0','我的平台',2,'B00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='index';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','index','0','我的资源-管理页面',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='save';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','save','0','我的资源-保存',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='save';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','allot','0','我的资源-资源分配',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='saveAllot';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','saveAllot','0','我的资源-保存资源分配信息',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='fileUp';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','fileUp','0','我的资源-文件上传',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='saveFileResourceTemp';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','saveFileResourceTemp','0','我的资源-保存临时数据',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='fileView';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','fileView','0','我的资源-预览',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxmx where sid='M00103' and action='/exp/hangsource/sell/wzdr' and method='fileView';      
  if num = 0 then 
    insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
    values(0,'/exp/hangsource/sell/wzdr','saveFileResource','0','我的资源-临时表保存正式',1,'M00103');
    END IF;
    
    num:=0;
  select count(1) into num from  bs_qxsz where mkid='M011065' and sid='M00103';      
  if num = 0 then 
    insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
    values('M011065','M0110','我是卖家','我的资源','/exp/hangsource/sell/wzdr/index.do','/exp/hangsource/sell/wzdr/index.do#/exp/hangsource/sell/wzdr/add.do#/exp/hangsource/sell/wzdr/index.do#/exp/hangsource/sell/wzdr/fileUp.do#/exp/hangsource/sell/wzdr/fileView.do',1,'220',1,'M00103');
    END IF;



  update bs_system set sname='销售平台',shortname='销售',url04='_ecGoodsSystem' where sid='M00103';
  update bs_system set sname='销售系统',shortname='销售',url04='_ecGoodsSystem' where sid='B00103';

  delete from bs_qxsz where sid='M00103'  and mkid='M010535';
  delete from bs_qxmx where sid='M00103'  and mkid='M010535';
  
  
  
  	num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011065' and action='/exp/hangsource/sell/wzdr' and method='show';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
                VALUES('M011065','/exp/hangsource/sell/wzdr','show','2','我的资源-资源详情','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011065' and action='/exp/hangsource/sell/wzdr' and method='delete';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
                VALUES('M011065','/exp/hangsource/sell/wzdr','delete','2','我的资源-删除资源','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011065' and action='/exp/hangsource/sell/wzdr' and method='export';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
                VALUES('M011065','/exp/hangsource/sell/wzdr','export','2','我的资源-批量导出','1','M00103');
    END IF;
	

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='showDxhys';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','showDxhys','2','挂牌管理(卖):定向维护-定向会员','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='showDxhyz';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','showDxhyz','2','挂牌管理(卖):定向维护-定向会员组','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='saveDxhyz';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','saveDxhyz','2','挂牌管理(卖)：定向维护-保存会员组','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='delDxhyz';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','delDxhyz','2','挂牌管理(卖)：定向维护-删除会员组','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='saveHyzhy';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','saveHyzhy','2','挂牌管理(卖)：定向维护-保存会员组下会员','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='showHyzhy';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','showHyzhy','2','挂牌管理(卖)：定向维护-显示会员组下会员','1','M00103');
    END IF;

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='delHyzhy';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','delHyzhy','2','挂牌管理(卖)：定向维护-删除会员组下会员','1','M00103');
    END IF;


    --hejunwei  end  2014-9-11

    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011010' and action='/exp/hangsource/sell/hangadmin' and method='saveDxhyList';      
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID) 
			VALUES('M011010','/exp/hangsource/sell/hangadmin','saveDxhyList','2','挂牌管理(卖)：定向维护-保存-定向会员信息','1','M00103');
    END IF;
    
    
    num:=0;
  	select count(1) into num from  bs_qxsz where mkid='M011055' and sid='M00103' and name='集中采购';      
  	if num = 0 then 
	    insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid) values('M011055','M0110','我是卖家','集中采购','/exp/collect/caigou/index.do',
       '/exp/collect/caigou/index.do#/exp/collect/caigou/list.do#/exp/collect/caigou/savePurchase.do#/exp/collect/caigou/delPurchase.do#/exp/collect/caigou/export2Excel.do',
       '1','650','1','','M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='index';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','index',2,'供求资源列表',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','list',2,'采购单列表',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='savePurchase';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','savePurchase',2,'保存采购单',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='delPurchase';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','delPurchase',2,'删除采购单信息',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='export2Excel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','export2Excel',2,'导出采购单',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011055' and action='/exp/collect/caigou' and method='viewPurchase';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011055','/exp/collect/caigou','viewPurchase',2,'查看采购单详情',1,'M00103');
    END IF;
    
    
    num:=0;
  	select count(1) into num from  bs_qxsz where mkid='M011060' and sid='M00103' and name='供求管理';      
  	if num = 0 then 
	    insert into bs_qxsz(mkid, mid, mname, name, url, inurl, isuse, orderno, styp, parent, sid) values('M011060','M0110','我是卖家','供求管理','/exp/collect/source/index.do',
       '/exp/collect/source/index.do#/exp/collect/source/list.do#/exp/collect/source/toEdit.do#/exp/collect/source/save.do#/exp/collect/source/viewSource.do#/exp/collect/source/delete.do',
       '1','700','1','','M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='index';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','index',2,'供求资源列表',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='list';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','list',2,'采购单列表',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='toEdit';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','toEdit',2,'跳转新增编辑界面',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='save';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','save',2,'保存资源',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='viewSource';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','viewSource',2,'查看供求信息',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='delete';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','delete',2,'删除资源',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='export2Excel';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','export2Excel',2,'批量导出',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='chooseAppointMember';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','chooseAppointMember',2,'定向维护-选择定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='showAppointMemberList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','showAppointMemberList',2,'定向维护-定向会员列表',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='addAppointMember';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','addAppointMember',2,'定向维护-新增定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='saveAppointMember';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','saveAppointMember',2,'定向维护-保存定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='updateAppointMember';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','updateAppointMember',2,'定向维护-修改定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='delAppointMember';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','delAppointMember',2,'定向维护-删除定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='batchEnableAppoint';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','batchEnableAppoint',2,'定向维护-批量停用定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='batchDisableAppoint';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','batchDisableAppoint',2,'定向维护-批量启用定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='batchDeleteAppoint';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','batchDeleteAppoint',2,'定向维护-批量删除定向会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='getMemberList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','getMemberList',2,'查询会员',1,'M00103');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where sid='M00103' and mkid='M011060' and action='/exp/collect/source' and method='getMemberList';      
	if num = 0 then 
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M011060','/exp/collect/source','setAppointMember',2,'设置定向会员',1,'M00103');
    END IF;

  -- end

    -- 升级文件到此结束
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  

