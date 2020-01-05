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
    ------------add by huangyaoyu 2019年6月21日17:01:11 start 航天APP接口数据初始化sql -------------
    --------招标公告201、中标结果公告202、变更公告203、投标人基本信息表204、中标人205、资格预审公告206、中标候选人公示207
    --招标公告201
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.probid,201,1,'cs' from bd_zbgg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.probid and t.type = 201  )
    and g.typ='1' and s.fbdate is not null and nvl(s.marketFilter, '0') != '1';

    --中标结果公告202
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.packid,202,1,'cs' from bd_db_zbjggg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm = TO_CHAR(g.packid) and t.type = 202 )
    and nvl(s.marketFilter, '0') != '1';

    --变更公告203
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.pkid,203,1,'cs' from bd_ccnotice g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.pkid and t.type = 203 )
    and g.state = '8' and g.typ = '2' and nvl(s.marketfilter, '0') != '1' and s.zbfs = '1';

    -- 投标人基本信息表204
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.pkid,204,1,'cs' from BD_TB_SIGNUP g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.pkid and t.type = 204 )
    and to_number(nvl(g.status,0)) >=5 and nvl(s.marketfilter, '0') != '1' and s.zbfs = '1';

    -- 中标人205
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.bdid,205,1,'cs' from BD_PACKAGE g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.bdid and t.type = 205 )
    and g.winbiddm is not null and nvl(s.marketfilter, '0') != '1' and s.zbfs = '1';

    --资格预审公告206
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.probid,206,1,'cs' from bd_zbgg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.probid and t.type = 206 )
    and g.typ='2' and s.fbdate is not null and nvl(s.marketFilter, '0') != '1';

    --中标候选人207
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.pkid,207,1,'cs' from BD_DB_HXRGS g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm = g.pkid and t.type = 207 )
    and g.status = 5 and nvl(s.marketFilter, '0') != '1';
    ------------add by huangyaoyu 2019年6月21日17:01:16 end 航天APP接口数据初始化sql-------------


    ------------add by huangyaoyu 2019年7月1日16:17:11 start 航天千里马接口数据初始化sql -------------
    --------同步 招标公告 220、资格预审公告 221、变更公告 222、中标结果公告 223
    --招标公告 220
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.probid,220,1,'cs' from bd_zbgg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.probid and t.type = 220  )
    and g.typ='1' and s.fbdate is not null and nvl(s.marketFilter, '0') != '1';

    --资格预审公告 221
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.probid,221,1,'cs' from bd_zbgg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.probid and t.type = 221 )
    and g.typ='2' and s.fbdate is not null and nvl(s.marketFilter, '0') != '1';


    --变更公告 222
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.pkid,222,1,'cs' from bd_ccnotice g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm=g.pkid and t.type = 222 )
    and g.state = '8' and g.typ = '2' and nvl(s.marketfilter, '0') != '1' and s.zbfs = '1';

    --中标结果公告 223
    insert into bd_post_queue (id,fphm,type,status,subsystem)
    select bd_post_queue_0.nextval,g.packid,223,1,'cs' from bd_db_zbjggg g left join bd_subproject s on s.probid=g.probid where
    not exists(select 1 from bd_post_queue t where t.fphm = TO_CHAR(g.packid) and t.type = 223 )
    and nvl(s.marketFilter, '0') != '1';

    ------------add by huangyaoyu 2019年7月1日16:17:16 航天千里马接口数据初始化sql end-------------

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
     P_VERSION(SYSID=>'EC',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;