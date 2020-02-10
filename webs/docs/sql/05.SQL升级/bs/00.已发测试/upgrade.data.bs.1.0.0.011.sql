DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.11'; -- 本升级文件的版本，每个升级文件必须修改
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
 
 
  
  num:=0; -- 注意：查询前必须初始化此变量
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='quote' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','quote','2','招标管理-项目包管理-供应商报价','1','M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='saveQuote' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','saveQuote','2','招标管理-项目包管理-供应商报价','1','M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='scoreList' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','scoreList','2','招标管理-项目包管理-供应商评分','1','M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='score' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','score','2','招标管理-项目包管理-供应商评分','1','M00004');
    END IF;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/tdp/dev/package' and method='saveScore' and styp='1' and sid='M00004';       
  if num = 0 then 
    insert into bs_qxmx(pkid,mkid,action,method,accesstag,remark,styp,sid)
    values(bs_qxmx_0.nextval,'M01051510','/tdp/dev/package','saveScore','2','招标管理-项目包管理-供应商评分','1','M00004');
    END IF;
 
	update bs_qxsz set inurl='/tdp/fee/manager/list.do#/tdp/fee/manager/toEdit.do#/tdp/fee/manager/toView.do'where sid='M00004' and styp=1 and mkid='M022005';
   
    
    
    --合同跟踪导出 by add zhuchunhong 2014-01-03
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M01550510' and action='/tdp/trail/pay' and method='exportExcel' and sid='M00004';     
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values (bs_qxmx_0.nextval, 'M01550510', '/tdp/trail/pay', 'exportExcel', 2, '支付合同导出', 1, 'M00004');
    END IF;
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M01300120' and action='/tdp/trail/pccontract' and method='exportExcel' and sid='M00004';     
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values (bs_qxmx_0.nextval, 'M01300120', '/tdp/trail/pccontract', 'exportExcel', 2, '合同导出', 1, 'M00004');
    END IF;
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M015515' and action='/tdp/trail/payInfo' and method='exportExcel' and sid='M00004';     
    if num = 0 then 
        insert into bs_qxmx (PKID, MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
	values (bs_qxmx_0.nextval, 'M015515', '/tdp/trail/payInfo', 'exportExcel', 2, '支付明细导出', 1, 'M00004');
    END IF;
    ---------------------------------------------------------------
    num:=0;
    select count(1) into num from bs_qxmx where mkid='M011505' and action='/tdp/puc/req' and method='export2AesFile' and sid='M00004';     
    if num = 0 then 
       insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
       values('M011505','/tdp/puc/req','export2AesFile',2,'加密导出',1,'M00004');
    END IF;
    ---------------------------------------------------------------
    -------------------------------------------------------------
    -- 升级文件到此结束
     -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  