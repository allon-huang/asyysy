DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.10'; -- 本升级文件的版本，每个升级文件必须修改
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
    ------------add by songw 2017年7月3日 start-----------------
    -- 初始化招标项目终止公告状态，将12-已发布更改为19-已发布(正式环境执行过后注释掉此初始化，避免以后有人使用fbstatus为12的状态)
    --update bd_zbstopgg t set t.fbstatus = 19 where t.fbstatus = 12;
    ------------add by songw 2017年7月3日 end-----------------
    
    ------------add by songw 2017年7月31日 start----------------
    -- 将澄清数据的ggfile赋给sealpathfile02（正式环境执行过后必须注释掉）
    --update bd_ccnotice set sealpathfile02 = ggfile where state = '8' and ggfile is not null and sealpathfile02 is null and typ = '1';
    ------------add by songw 2017年7月31日 end----------------
    
    ------------add by songw 2017年8月16日 start----------------
    -- 将专家信息BdExpert的身份证件类型统一由1改为01
    --update bd_expert set card_type = '01' where card_type = '1';
    
    -- 将招标参数设置中最高投标限价单位为万元的数据，将tbxj乘以10000，并将单位更改为元
    --update bd_fb_zbcssz set tbxj = tbxj*10000, tbxjdw='1' where tbxjdw = '2' and cstype = '2' and tbxj is not null ;
    ------------add by songw 2017年8月16日 end----------------
    -----------------------专家自荐数据平移 add by lijb 2017年9月29日 start--------------------------
	--insert into bd_expert_zj(zjdm,zjmc,age,cdate,birth_date,sex,card_type,card_num,lxtel,dq_code1,dq_name1,dq_code2,dq_name2,dq_code3,dq_name3,email,
	--address,postcode,czydm,unit_name,position,resume,lastschool,degree,major,work_years,hydm,zjly,is_job,bonus_malus,qyflag,xlzsbh,zjbh,card_num_tmp,
	--origin,idcardfile,creditcode,graduationdate,diplomafile,majorinstudy,nowmajor,worktel,hometel,fax,subsystem,username,password)
	--select b.zjdm,b.zjmc,b.age,b.cdate,b.birth_date,b.sex,b.card_type,b.card_num,b.lxtel,b.dq_code1,b.dq_name1,b.dq_code2,b.dq_name2,b.dq_code3,b.dq_name3,
	--b.email,b.address,b.postcode,b.czydm,b.unit_name,b.position,b.resume,b.lastschool,b.degree,b.major,b.work_years,b.hydm,b.zjly,b.is_job,b.bonus_malus,
	--b.qyflag,b.xlzsbh,b.zjbh,b.card_num,b.origin,b.idcardfile,b.creditcode,b.graduationdate,b.diplomafile,b.majorinstudy,b.nowmajor,b.worktel,
	--b.hometel,b.fax,b.subsystem,b.lxtel,'6846860684F05029ABCCC09A53CD66F1' from bd_expert b where 
	--b.zjdm not in (select k.zjdm from bd_expert_zj k);
	----------------------add by lijb 2017年9月29日 end---------------------------

---投标保证金|履约保证金 分标段包设置 start-----------------------------------------
----默认要求递交投标保证金--------------------------
--update bd_fb_zbcssz set isdjtbbzj='1' where cstype='2' and nvl(isdjtbbzj, '1')='1';
--默认不需要支付履约保证金
--update bd_fb_zbcssz set sfzflvbzj='0' where cstype='2' and nvl(sfzflvbzj, '0')='0';

---初始化值按标段参数设置值
-- insert into bd_package_cssz (bdid,packname,probid,ISDJTBBZJ,tbbzjxs,tbbzjzffs,tbbzjpercent,
--   TBBZJPERCENT_MIN,tbbzjpercentMax,tbbzjje,
--   tbbzjjedw,tbbzjbz,sfzflvbzj,lydbpercent,
--   lydbje,lydbjedw,lydbfs,lydbbz,lydbxs)
-- select f.bdid,f.packname,f.probid,t.ISDJTBBZJ,t.tbbzjxs,t.tbbzjzffs,t.tbbzjpercent,t.TBBZJPERCENT_MIN,t.tbbzjpercentMax,
--         t.tbbzjje,t.tbbzjjedw,t.tbbzjbz,t.sfzflvbzj,t.lydbpercent,t.lydbje,t.lydbjedw,t.lydbfs,t.lydbbz,t.lydbxs
--    from bd_package f left join (select * from  bd_fb_zbcssz where cstype='2') t on nvl(f.probid, '|') = nvl(t.probid, '-'); 
  ----投标保证金|履约保证金 分标段包设置 end-----------------------------------------
  
  --代理服务费及扣款明细信息 start---------
---扣款金额
--insert into Bd_Deductions_Detail (pkid,probid,probmc,bdid,packname,tbdwmc,chargetype,kamt,cdate,hydm,tbdwcode)
--select Bd_Deductions_Detail_0.Nextval,t.probid,t.probname,t.bdid,t.packname,k.hyname,k.fyly,k.kamt,k.date3,t.hydm,k.hydm from 
--(select f.* from Bd_Td_Dd f where  nvl(f.statusback, 0) >= 10 and nvl(f.kamt, 0) > 0) k 
--left join  (select p.bdid,p.packname,p.probid,s.probname,p.hydm from bd_package p,bd_subproject s where p.probid=s.probid) t 
--on nvl(k.bdid, '|') = nvl(t.bdid, '-') ;
--代理服务费
--insert into Bd_Deductions_Detail
--  (pkid,probid,probmc,bdid,packname,tbdwmc,chargetype,kamt,cdate,hydm,tbdwcode)
--select Bd_Deductions_Detail_0.Nextval,t.probid,t.probname,t.bdid,t.packname,d.hyname,'6',t.dlfwf,d.date3,t.hydm,d.hydm from 
--(select p.bdid,p.packname,p.probid,s.probname,p.hydm,p.winbiddm,p.winbidmc,p.dlfwf from bd_package p,bd_subproject s  where p.probid=s.probid and nvl(p.isdlfwf, '0')='1' and nvl(p.dlfwf, 0)> 0) t 
--left join bd_td_dd d on  d.bdid=t.bdid and d.hydm=t.winbiddm where d.fyly='3';
  
  --代理服务费及扣款明细信息 end---------


  -----ca初始化 平台标识 hejw start-------------
    --update bs_ca_cert set syscode='S00000' where hydm in (select m.hydm from bs_menber m where nvl(subsystem, 'S00000')='S00000');
    --update bs_ca_cert_zfqd set syscode='S00000' where hydm in (select m.hydm from bs_menber m where nvl(subsystem, 'S00000')='S00000');
    --update bs_ca_cert set syscode='S00010' where hydm in (select m.hydm from bs_menber m where nvl(subsystem, 'S00000')='S00010');
    --update bs_ca_cert_zfqd set syscode='S00010' where hydm in (select m.hydm from bs_menber m where nvl(subsystem, 'S00000')='S00010');
    -----ca初始化 平台标识 hejw end-------------

    -----ca数据复制 hejw start ------------
    --bs_ca_cert表数据移动
    ---insert into ca_cert_gather(pkid,linknumber,status,certyp,apptyp,sealtyp,userid,username,mobile,hydm,mbname,blr,blrtel,card_type,card_num,
    --cdate,date00,date01,date02,date03,date04,date05,startdate,enddate,pricelx,years,amt0,amt1,amt2,amt3,amt4,amt5,shopt,reason,
    --mcertid,flag00,flag01,flag02,flag03,fphm,keybh,dn,sequenceno,serialno,authcode,clbh,shr,olddn,certstatus,signaturecert,encryptioncert,
    --encryptionprivatekey,unlockremark,unlockflag,status01,contianername,xqfs,shreason,syscode,gxyz,bbreason)
    -- select ca_cert_gather_0.nextval,certid,status,certyp,apptyp,sealtyp,userid,username,mobile,hydm,mbname,blr,blrtel,card_type,card_num,
    --cdate,date00,date01,date02,date03,date04,date05,startdate,enddate,pricelx,years,amt0,amt1,amt2,amt3,amt4,amt5,shopt,reason,
    --mcertid,flag00,flag01,flag02,flag03,fphm,keybh,dn,sequenceno,serialno,authcode,clbh,shr,olddn,certstatus,signaturecert,encryptioncert,
    --encryptionprivatekey,unlockremark,unlockflag,status01,contianername,xqfs,shreason,syscode,gxyz,bbreason from bs_ca_cert k where 
    --k.certid not in (select b.linknumber from ca_cert_gather b);
    
    --ca_cert_gather_zfqd支付清单表数据移动
    --insert into ca_cert_gather_zfqd(fphm,status,copt,cdate,amt0,amt1,amt2,amt3,amt4,amt5,is_invoice,
    --invoice_tit,invoice_acc,shlxr,shlxtel,shaddr,wlmc,wldh,hydm,wbno00,invoicetyp,
    --invoiceemail,invoicemobile,invoiceflag,invoiceremark,zfdate,creditcode,apptyp,mbname,syscode,zflx)
    -- select fphm,status,copt,cdate,amt0,amt1,amt2,amt3,amt4,amt5,is_invoice,
    -- invoice_tit,invoice_acc,shlxr,shlxtel,shaddr,wlmc,wldh,hydm,wbno00,invoicetyp,
    --invoiceemail,invoicemobile,invoiceflag,invoiceremark,zfdate,creditcode,apptyp,mbname,syscode,zflx from bs_ca_cert_zfqd k where 
    --k.fphm not in (select b.fphm from ca_cert_gather_zfqd b);
    -----ca数据复制 hejw end ------------

   ----投标金额初始化到-报名表上 start------
    --update bd_tb_signup a set a.price=(select sum(b.price) from bd_offer_mx b where a.packid=b.bdid and a.hydm=b.tbfdm)
    --where exists (select 1 from bd_offer_mx b where a.packid=b.bdid and a.hydm=b.tbfdm );
   ------end------

  ------2017-11-30-hejw-start- 落地招标文件价格及单位到标段包表--需要测试公告里面的招标文件金额与标段包里面的是否一致--
--公开后审
   --update bd_package p set (p.zbwjprice,p.zbwjjgdw)=(select z.bssj,z.jgdw from bd_zbgg z where  
   --exists (select 1 from bd_subproject s where s.zbfs='1' and s.zgshfs='2' and s.probid=z.probid) and p.probid=z.probid)
   --where exists (select 1 from bd_zbgg z where  
   --exists (select 1 from bd_subproject s where s.zbfs='1' and s.zgshfs='2' and s.probid=z.probid) and p.probid=z.probid);
    
--邀请后审  
   -- update bd_package p set (p.zbwjprice,p.zbwjjgdw)=(select t.price,t.jgdw from BD_TBYQSBZ t where t.typ='1' and  
   -- exists (select 1 from bd_subproject s where s.zbfs='2' and s.zgshfs='2' and s.probid=t.probid ) and p.probid=t.probid)
   -- where exists(select 1 from BD_TBYQSBZ t where t.typ='1' and  
   -- exists (select 1 from bd_subproject s where s.zbfs='2' and s.zgshfs='2' and s.probid=t.probid ) and p.probid=t.probid);
    
    
--公开预审
   -- update bd_package p set (p.zbwjprice,p.zbwjjgdw)=(select t.price,t.jgdw from bd_tbyqsbz t where t.typ='2' and 
   -- exists (select 1 from bd_subproject s where s.zbfs='1' and s.zgshfs='1' and s.probid=t.probid ) and p.probid=t.probid and p.bdid=t.bdid and rownum<=1)
   -- where exists(select 1 from bd_tbyqsbz t where t.typ='2' and 
   -- exists (select 1 from bd_subproject s where s.zbfs='1' and s.zgshfs='1' and s.probid=t.probid ) and p.probid=t.probid and p.bdid=t.bdid);
  ------2017-11-30-hejw-end-----


    
    
    
    
    
    
    
   -------------批量修改会员名称--------------------------------------------------------------------------------------------------------------------------------- 
    --招标项目-批量修改招标人名称
    --update bd_subproject s set s.zbrmc =(select m.mbname from bsdb.bs_menber m where s.zbr=m.hydm and s.zbrmc!=m.mbname)
    --where exists (select 1 from bsdb.bs_menber m where s.zbr=m.hydm and s.zbrmc!=m.mbname);
    --招标项目-批量修改代理机构名称
    --update bd_subproject s set s.dljgname =(select m.mbname from bsdb.bs_menber m where s.dljg=m.hydm and s.dljgname!=m.mbname)
    --where exists (select 1 from bsdb.bs_menber m where s.dljg=m.hydm and s.dljgname!=m.mbname);
    --标段包-批量修改招标人名称
    --update bd_package s set s.zbrmc =(select m.mbname from bsdb.bs_menber m where s.zbr=m.hydm and s.zbrmc!=m.mbname)
    --where exists (select 1 from bsdb.bs_menber m where s.zbr=m.hydm and s.zbrmc!=m.mbname);
    --订单表-会员名称批量修改
    
    --是否缴纳服务费字段从标段包表平移到bd_td_dd表
    --update bd_td_dd a set (a.isdlfwf,a.dlfwf)=
    --(select b.isdlfwf,b.dlfwf from bd_package b where instr(a.bdid,b.bdid)>0 and instr(b.winbiddm,a.hydm)>0 and b.winbiddm is not null and b.isdlfwf is not null and b.dlfwf is not null)
    --where exists ( select 1 from bd_package b where instr(a.bdid,b.bdid)>0 and instr(b.winbiddm,a.hydm)>0 and b.winbiddm is not null and b.isdlfwf is not null and b.dlfwf is not null)
    --and nvl(a.isdlfwf, 0)=0 and a.fyly='3';

    
    --老数据在合同审批的节点批量改成合同履约节点
    --update bd_package set zbstep0='Z0804' where zbstep0='Z0803';
	--update bd_package set tbstep0='T0604' where tbstep0='T0603';
	--update bd_tb_signup set tbstep0='T0604' where tbstep0='T0603';
	--update bd_subproject set zbstep='Z0804' where zbstep='Z0803';
	--update bd_subproject set tbstep='T0604' where tbstep='T0603';

    --为老数据投标邀请书开标时间BD_TBYQSBZ.kbsj赋默认值投标文件递交的截止时间BD_TBYQSBZ.tbotime
   -- tmp1:=upper('BD_TBYQSBZ');
   -- tmp2:=upper('kbsj');
   -- num:=0; -- 注意：查询前必须初始化此变量
   -- select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
   -- if num = 1 then
    --  execute immediate 'update '||tmp1||' set kbsj = tbotime where kbsj is null';
   -- end if;
  -------------add by nieche 2017年12月26日 end-------------   

   --bsbsbs-----------add by hejw 2018年01月17日  start---- 平移赋值CA支付类型---------   
    --
    --  update ca_cert_gather_zfqd a set a.beizhu='2018-01-17',a.zflx=(select decode(nvl(zfqd.enname,buf.enname),'CPCN',2,'ALIPAY',3,'CBHB',6,'WEIXIN',4,'BGCW',5,0) from ebanks.ebk_zfqd zfqd, ebanks.ebk_sendbuf buf
    --  where zfqd.fphm = buf.fphm and buf.status = 0 and zfqd.typ=9 and zfqd.status=9 and a.fphm=zfqd.bfphm and rownum<=1 )
    --  where exists (select zfqd.fphm from ebanks.ebk_zfqd zfqd, ebanks.ebk_sendbuf buf
    --  where zfqd.fphm = buf.fphm and buf.status = 0 and zfqd.typ=9 and zfqd.status=9 and a.fphm=zfqd.bfphm);
    --从CA支付类型---后台订单平移到前台订单的支付类型-----------------------------------
    --  update bs_ca_cert_zfqd a set zflx=(select b.zflx from ca_cert_gather_zfqd b where a.fphm=b.fphm and rownum<=1)
    --   where exists (select 1 from ca_cert_gather_zfqd b where a.fphm=b.fphm );
  ---bsbs----------add by hejw 2018年01月17日  end-------------    
   
    ---bd -2018-01-25 16:28 hejw--批量落地抽取 符合总人数-----start-----
     --/bdp/build/jury/totalBatchGround.do
    ---bd ---批量落地抽取 符合总人数-----end----- 


  -------------add by hejw 2018年01月11日 start--- 批量落地分类代码名称----------   
  --    update bd_package p set fldmname=(select t.name from bd_bidpackage_type t where p.fldm=t.code) where fldmname is null;
  -------------add by hejw 2018年01月11日  end-------------   
  -------------add by hejw 2018年01月15日  start-- 委员会抽取当前专家是否在职状态落地-----------   
  --    update bd_jury_member set is_job='1' where typ in ('1','2') and is_job is null;
  -------------add by hejw 2018年01月15日  end-------------  
    ------2018-01-26 13:58 通过指定的会员代码获取基础的 会员全称---start-----  
       --bd_tb_signup     czydmmc     对应的czydm  subsystem=S00000  -山能-S00010----
    --	update bd_tb_signup b set czydmmc = (select t.username from bsdb.BS_MBOPT t where b.czydm = t.userid and subsystem='S00000' and rownum <= 1)
    --    where exists (select 1 from bsdb.BS_MBOPT t where b.czydm = t.userid and subsystem='S00000');
    ------2018-01-26 13:58 通过指定的会员代码获取基础的 会员全称---end-----

    ---2018-01-29 19:42 start--落地最高分最低分扣除人数-start-------------
    --   update bd_mb_pbmb_bak set ridmaxmin=0 where ridmaxmin is null;
    --   update bd_package set ridmaxmin=0,pre_ridmaxmin=0 where ridmaxmin is null;
    --   update bd_tb_signup set score2=score where score2 is null and score is not null;
    --   update bd_tb_signup set pre_score2=pre_score where pre_score2 is null and pre_score is not null;
    ---2018-01-29 19:42 ---------- end ------------------

    ----批量落地会员分类问题------start---------
    --    update bd_package a set a.hyflmc=(select b.hyflmc from Bd_Bidpackage_Hyfl b where 
    --    exists(select 1 from  Bd_Bidpackage_Type c where c.hyfldm=b.hyfldm and c.code=a.fldm))
    --    where exists (select 1 from Bd_Bidpackage_Type b where a.fldm=b.code );
    ----批量落地会员分类问题------end---------


    -------2018-03-07 15:25 start ----落地线下汇款账号---------------------------
    --update bd_td_dd d set d.bcustacct = ( select t.Bcustacct from bdbank.bk_mblicense t where
   -- t.bkid = '01' and d.hzdm = t.hydm and  t.acc_flag =4 and t.tb_mb_code = d.hydm and d.bdid=t.bd_bill_no)
    --where d.fyly = '5' and d.bcustacct is null and d.zffs = '1' and d.flag1 in ('3','4');

   -- update bd_td_dd d set d.bcustacct = ( select t.Bcustacct from bdbank.bk_mblicense t where
   -- t.bkid = '01' and d.hzdm = t.hydm and  t.acc_flag = 5 and t.tb_mb_code = d.hydm and d.bdid=t.bd_bill_no)
   -- where d.fyly = '4' and d.bcustacct is null  and d.zffs = '1' and d.flag1 in ('3','4');
    
  --  update bd_td_dd d set d.bcustacct = ( select t.Bcustacct from bdbank.bk_mblicense t where
   -- t.bkid = '01' and d.hzdm = t.hydm and  t.acc_flag = 3 and t.tb_mb_code = d.hydm and d.bdid = t.bd_bill_no)
   -- where d.fyly = '3'  and d.bcustacct is null  and d.zffs = '1' and d.flag1 in ('3','4');
    
   -- update bd_td_dd d set d.bcustacct = ( select t.Bcustacct from bdbank.bk_mblicense t where
   -- t.bkid = '01' and d.hzdm = t.hydm and  t.acc_flag = 2 and t.tb_mb_code = d.hydm and instr(d.bdid,t.bd_bill_no)>0)
   -- where d.fyly = '2' and d.bcustacct is null  and d.zffs = '1' and d.flag1 in ('3','4');
    
  --  update bd_td_dd d set d.bcustacct = ( select t.Bcustacct from bdbank.bk_mblicense t where
  --  t.bkid = '01' and d.hzdm = t.hydm and  t.acc_flag = 1 and t.tb_mb_code = d.hydm and instr(d.bdid,t.bd_bill_no)>0)
   -- where d.fyly = '1'  and d.bcustacct is null  and d.zffs = '1' and d.flag1 in ('3','4');
    -------2018-03-07 15:25 end ----落地线下汇款账号---------------------------

------------add by nieche 2018年06月07日 中标候选人公示人数数据平移 start--------------
	--update bd_package p set p.hxrgsrs =(select b.hxrgsrs from BD_DB_HXRGS b  where p.bdid = b.packid and p.hxrgsrs is null and b.hxrgsrs is not null)
    --where exists (select 1 from BD_DB_HXRGS b  where p.bdid = b.packid and p.hxrgsrs is null and b.hxrgsrs is not null);
------------add by nieche 2018年06月07日 中标候选人公示人数数据平移 end--------------





----------------------------------------------------------------------------------------------------
-----------注意问题  （中兵招投标）|（山能招投标）----需要同时执行-------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

	
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  