DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.9'; -- 本升级文件的版本，每个升级文件必须修改
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
  
    ------------add by songw 2017年2月8日 start----------------------
    --add 增加会员账户流水页面 ，当前会员为代理机构的流水增加保存备注字段
    tmp1:=upper('BD_TD_DD');
    tmp2:=upper('rjlsbz');
    num:=0; -- 注意：查询前必须初始化此变量
    select count(1) into num from user_tab_columns where table_name=tmp1 and column_name=tmp2;
    if num = 0 then
        execute immediate 'alter table '||tmp1||' add ('||tmp2||' VARCHAR2(250))';
        execute immediate 'comment on column '||tmp1||'.'||tmp2||' is ''入金流水备注''';
    end if; 
    ------------add by songw 2017年2月8日 end----------------------

	----add by zhangzq 2017-02-10  采招网行业对照(旧表) start-------------------
	----行业
	num := 0;
	select count(1) into num from bd_sjdz where typ='行业' and hyfl='G';
	if num = 1 then
		delete from bd_sjdz where typ='行业';
	end if;
	
	num := 0;
	select count(1) into num from bd_sjdz where typ='行业' and hyfl='53';
	if num = 0 then
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','53');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','54');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','55');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','56');

		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','57');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','58');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','59');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','1','交通运输','60');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','33');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','34');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','35');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','36');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','37');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','38');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','40');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','5','机械电子电器','43');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','06');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','07');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','25');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','26');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','29');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','44');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','7','能源化工','45');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','08');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','09');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','10');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','11');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','12');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','30');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','31');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','10','冶金矿产原材料','32');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','2','网络通讯计算机','39');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','2','网络通讯计算机','63');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','2','网络通讯计算机','64');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','2','网络通讯计算机','65');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','46');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','47');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','48');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','49');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','50');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','3','市政房地产建筑','70');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','4','水利桥梁','76');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','6','环保','42');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','6','环保','77');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','8','医疗卫生','27');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','8','医疗卫生','83');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','8','医疗卫生','84');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游','73');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游','74');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游','75');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游','82');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','9','科技文教旅游','87');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','11','出版印刷','23');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','11','出版印刷','85');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','11','出版印刷','86');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','13');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','14');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','15');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','16');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','17');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','18');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','19');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','20');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','21');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','22');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','24');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','12','轻工纺织食品','28');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔','01');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔','02');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔','03');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔','04');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','13','农林牧渔','05');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','51');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','52');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','61');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','62');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','66');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','67');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','68');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','69');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','71');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','72');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','79');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','80');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','81');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','14','商业服务','89');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','41');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','88');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','90');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','91');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','92');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','93');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','94');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','95');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','15','其它','96');
		
		insert into bd_sjdz (pkid,typ,code,mc,hyfl)
		values(BD_SJDZ_0.nextval,'行业','16','园林绿化','78');
	end if;
	----add by zhangzq 2017-02-10  采招网行业对照(旧表)  end-------------------

	----add by zhangzq 2017-02-10  采招网数据对照表插入数据(新表) start------------------
	----------------- 标讯招标
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='标讯类别' and code='1';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'标讯类别','0','国内招标');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'标讯类别','1','国际招标');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'标讯类别','2','政府采购');	
	end if;
	
	----------------- 资金来源
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='资金来源' and code='1';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','0','国内政府资金');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','1','商业融资');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','2','外国政府贷款');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','3','世界银行贷款');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','4','亚洲开发银行');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','5','日元贷款');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','6','非洲开发银行贷款');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','7','欧洲复兴与开发银行贷款');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc)
		values(BD_CZ_SJDZ_0.nextval,'资金来源','10','其它');
	end if;
	
	----------------- 招标类型
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='招标类型' and code='001';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'招标类型','001','工程招标','2','工程招标');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'招标类型','002','货物招标','1','货物招标');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'招标类型','003','服务招标','3','服务招标');	
	end if;
	
	----------------- 行业
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='行业' and code='1';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','1','交通运输','G','交通运输、仓储和邮政业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','5','机械电子电器','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','7','能源化工','D','电力、热力、燃气及水生产和供应业');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','10','冶金矿产原材料','B','采矿业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','2','网络通讯计算机','I','信息传输、软件和信息技术服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','3','市政房地产建筑','E','建筑业');	
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','4','水利桥梁','N','水利、环境和公共设施管理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','6','环保','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','8','医疗卫生','Q','卫生和社会工作');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','9','科技文教旅游','P','教育');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','11','出版印刷','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','12','轻工纺织食品','C','制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','13','农林牧渔','A','农、林、牧、渔业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','14','商业服务','L','租赁和商务服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','15','其它','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'行业','16','园林绿化','','');
	end if;
	
	----------------- 地区
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='地区' and code='1';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','1','北京','110000','北京');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','2','上海','310000','上海');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','3','天津','120000','天津');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','4','重庆','500000','重庆');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','5','河北','130000','河北省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','6','山西','140000','山西省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','7','内蒙古','150000','内蒙古');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','8','辽宁','210000','辽宁省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','9','吉林','220000','吉林省');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','10','黑龙江','230000','黑龙江省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','11','江苏','320000','江苏省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','12','浙江','330000','浙江省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','13','安徽','340000','安徽省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','14','福建','350000','福建省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','15','江西','360000','江西省');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','16','山东','370000','山东省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','17','河南','410000','河南省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','18','湖北','420000','湖北省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','19','湖南','430000','湖南省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','20','广东','440000','广东省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','21','广西','450000','广西');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','22','海南','460000','海南省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','23','贵州','520000','贵州省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','24','云南','530000','云南省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','25','西藏','540000','西藏');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','26','陕西','610000','陕西省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','27','四川','510000','四川省');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','28','甘肃','620000','甘肃省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','29','青海','630000','青海省');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','30','新疆','650000','新疆');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','31','宁夏','640000','宁夏');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','32','香港','','');
	
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','33','澳门','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','34','台湾','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','36','跨省','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','43','亚洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','44','欧洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','45','非洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','46','北美洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','47','南美洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','48','大洋洲','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','50','加勒比','','');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(BD_CZ_SJDZ_0.nextval,'地区','49','中美洲','','');
	end if;
	----add by zhangzq 2017-02-10  采招网数据对照表插入数据  end-------------------
  
	----add by zhangzq 2017-02-10  采招网行业对照(新表) start-------------------
	----行业
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='行业' and dzcode='G';
	if num = 1 then
		delete from bd_cz_sjdz where typ='行业';
	end if;
	
	num := 0;
	select count(1) into num from bd_cz_sjdz where typ='行业' and dzcode='53';
	if num = 0 then
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','53','铁路运输业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','54','道路运输业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','55','水上运输业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','56','航空运输业');

		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','57','管道运输业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','58','装卸搬运和运输代理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','59','仓储业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','1','交通运输','60','邮政业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','33','金属制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','34','通用设备制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','35','专用设备制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','36','汽车制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','37','铁路、船舶、航空航天和其他运输设备制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','38','电气机械和器材制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','40','仪器仪表制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','5','机械电子电器','43','金属制品、机械和设备修理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','06','煤炭开采和洗选业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','07','石油和天然气开采业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','25','石油加工、炼焦和核燃料加工业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','26','化学原料和化学制品制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','29','橡胶和塑料制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','44','电力、热力生产和供应业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','7','能源化工','45','燃气生产和供应业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','08','黑色金属矿采选业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','09','有色金属矿采选业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','10','非金属矿采选业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','11','开采辅助活动');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','12','其他采矿业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','30','非金属矿物制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','31','黑色金属冶炼和压延加工业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','10','冶金矿产原材料','32','有色金属冶炼和压延加工业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','2','网络通讯计算机','39','计算机、通信和其他电子设备制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','2','网络通讯计算机','63','电信、广播电视和卫星传输服务');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','2','网络通讯计算机','64','互联网和相关服务');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','2','网络通讯计算机','65','软件和信息技术服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','46','水的生产和供应业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','47','房屋建筑业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','48','土木工程建筑业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','49','建筑安装业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','50','建筑装饰和其他建筑业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','3','市政房地产建筑','70','房地产业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','4','水利桥梁','76','水利管理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','6','环保','42','废弃资源综合利用业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','6','环保','77','生态保护和环境治理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','8','医疗卫生','27','医药制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','8','医疗卫生','83','卫生');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','8','医疗卫生','84','社会工作');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','9','科技文教旅游','73','研究和试验发展');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','9','科技文教旅游','74','专业技术服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','9','科技文教旅游','75','科技推广和应用服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','9','科技文教旅游','82','教育');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','9','科技文教旅游','87','文化艺术业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','11','出版印刷','23','印刷和记录媒介复制业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','11','出版印刷','85','新闻和出版业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','11','出版印刷','86','广播、电视、电影和影视录音制作业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','13','农副食品加工业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','14','食品制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','15','酒、饮料和精制茶制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','16','烟草制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','17','纺织业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','18','纺织服装、服饰业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','19','皮革、毛皮、羽毛及其制品和制鞋业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','20','木材加工和木、竹、藤、棕、草制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','21','家具制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','22','造纸和纸制品业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','24','文教、工美、体育和娱乐用品制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','12','轻工纺织食品','28','化学纤维制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','13','农林牧渔','01','农业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','13','农林牧渔','02','林业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','13','农林牧渔','03','畜牧业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','13','农林牧渔','04','渔业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','13','农林牧渔','05','农、林、牧、渔服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','51','批发业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','52','零售业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','61','住宿业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','62','餐饮业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','66','货币金融服务');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','67','资本市场服务');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','68','保险业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','69','其他金融业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','71','租赁业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','72','商务服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','79','居民服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','80','机动车、电子产品和日用产品修理业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','81','其他服务业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','14','商业服务','89','娱乐业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','41','其他制造业');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','88','体育');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','90','中国共产党机关');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','91','国家机构');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','92','人民政协、民主党派');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','93','社会保障');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','94','群众团体、社会团体和其他成员组织');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','95','基层群众自治组织');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','15','其它','96','国际组织');
		
		insert into bd_cz_sjdz (pkid,typ,code,mc,dzcode,dzmc)
		values(bd_cz_sjdz_0.nextval,'行业','16','园林绿化','78','公共设施管理业');
	end if;
	----add by zhangzq 2017-02-10  采招网行业对照(新表)  end-------------------

	num:=0;
	select count(1) into num from bd_auto_task where taskid='AutoFundQueue.scan';
	if num = 0 then
		insert into bd_auto_task(taskid, servername, remark, runtyp)
		values('AutoFundQueue.scan','DESKTOP-ZHMINFU','资金处理相关定时任务',1);
	end if;
	
	num:=0;
	select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoTranBaoAmt';
	if num = 1 then
		delete bd_auto_task where  taskid='AutoAuctionAction.autoTranBaoAmt';
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='SHOPNO';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','SHOPNO','002283','机构号');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='POSTURL';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','POSTURL','https://test.cpcn.com.cn/Gateway/InterfaceI','中金提交地址');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='BACKURL';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','BACKURL','http://ym7.vip.steel56.com.cn/bdplatform/cfca/b2b/payment/callback.do','回调通知地址');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='PAGEURL';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','PAGEURL','http://ym7.vip.steel56.com.cn/bdplatform/cfca/b2b/payment/success.do','页面回调通知地址');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='CAKEY_NO';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','CAKEY_NO','3110710027570000004','CA-KEY数字证书附属账户');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='CAKEY_NAME';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','CAKEY_NAME','中国兵器电子招标投标交易平台数字证书账户','CA-KEY数字证书附属账号开户名称');
	end if;
	
	num:=0;
	select count(1) into num from bd_cfca_conf where bkid='CFCA' and ityp='B2B' and key='TXURL';
	if num = 0 then
		insert into bd_cfca_conf(bkid, ityp, key, value,remark)
		values('CFCA','B2B','TXURL','http://www.china-clearing.com/Gateway/InterfaceII','结算指令后台通知地址');
	end if;
  
  --前台增加定时任务
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoRemindSmsTender';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoRemindSmsTender','hejw','定时发送短信-前台',1);
    end if;
    
    ---------add 是否1个单位只能抽取1个专家 后台参数  hejw start----------
    num:=0;
    select count(1) into num from bd_cssz where cskey='CQ_LIMIT';   
    if num = 0 then
        insert into bd_cssz (cskey,csmc,csvalue,mrz,opt,remark,flag0,orderno,csbz)
        values('CQ_LIMIT','是否1个单位只能抽取1个专家','0', '0','系统管理员','若限制，则每个单位只会抽取1个专家',1, 7100,'0-不限制 1-限制(1个单位只能抽取1个)');
    end if;
  
    num:=0;
    select count(1) into num from bd_cssz_ext where typ='CQ_LIMIT';   
    if num < 1 then
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CQ_LIMIT', '0', '不限制');
        insert into bd_cssz_ext (typ, cskey, csvalue) values('CQ_LIMIT', '1', '限制');
    end if;
    ---------add 是否1个单位只能抽取1个专家 后台参数  hejw end----------

    --增加定时任务  hejw 20170323 start --------------------------------
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoJuryMember';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoJuryMember','hejw','定时抽取专家-前台',1);
    end if;
    
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoUpdateOpeningBid';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoUpdateOpeningBid','hejw','new自动更新开标中的标段包状态-前台',1);
    end if;
    
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoReflashOpeingBid';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoReflashOpeingBid','hejw','new将近1小时内要开标的标段包数据写入缓存数据-前台',1);
    end if;    
    
    num:=0;
    select count(1) into num from bd_auto_task where taskid='AutoAuctionAction.autoOpenPackageFile';
    if num = 0 then
        insert into bd_auto_task(taskid, servername, remark, runtyp)
        values('AutoAuctionAction.autoOpenPackageFile','hejw','new自动文件解密-前台',1);
    end if;
    --增加定时任务  hejw 20170323 end --------------------------------

	--add by zhangzq 2017-03-23 公共服务平台管理员电话 start  --
	num:=0;
    select count(1) into num from bd_cssz where cskey='GJPT_ERRORMSG_MOBILE';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('GJPT_ERRORMSG_MOBILE','公共服务平台管理员电话','18810966015','系统管理员','',1,'',7500,'');
	end if;
	 --add by zhangzq 2017-03-23 end  --

    --初始化sql hejw start ----
    update bd_jury t set t.fristdate=t.cdate where nvl(t.status, 0)=3 and t.cdate is not null and t.fristdate is null;
    --初始化sql hejw end ----
  
  --add by zhangjian 2017-5-10 踏勘现场是否需要后台审核 start  --
	num:=0;
    select count(1) into num from bd_cssz where cskey='TKXC_SFHTSH';   
	if num = 0 then
		insert into bd_cssz (cskey,csmc,csvalue,opt,remark,flag0,unit,orderno,csbz)
  		values('TKXC_SFHTSH','踏勘现场是否需要后台审核','1','系统管理员','0-不需要审核 ，1-需要审核',1,'',7600,'踏勘现场是否需要后台审核0-不审核 1-审核');
	end if;
	 --add by zhangjian 2017-5-10 end  --
	
    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  