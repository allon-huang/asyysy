drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
    -- 获取当前数据用户
    -- SELECT MAX(USERNAME) INTO CURDB FROM USER_USERS; -- BSDB、FDDB、ECDB
    -- -----------------------------------------------------------
    -- 日期 人员 功能简单说明，不要写COMMIT，统一由模块提交
    -- 所有SQL升级代码按下面的模版进行增加，不允许超出本模版
    -- 范围的SQL出现。
    -- 模版见：UPGRADE.TEMPLATE.SQL
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- 请注意：不要在本文件中填写对数据库表结构或者存储过程、视图等非数据类操作的脚本
    -- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    -- -----------------------------------------------------------

	-- ----------add by huangyaoyu 2019年5月21日15:14:11 start es数据初始化sql -------------
	INSERT INTO BD_POST_QUEUE (fphm, type, STATUS, subsystem)
	SELECT g.probid, 60, 1, 'cs' FROM BD_ZBGG g
	LEFT JOIN BD_PACKAGE p ON p.bdid = g.bdid
	LEFT JOIN BD_SUBPROJECT s ON s.probid = g.probid
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE t WHERE t.fphm = g.bdid  AND t.type = 60 ) AND g.typ = '1' AND p.ggfbsj IS NOT NULL AND IFNULL(s.marketFilter, '0') != '1';
	--  招标公告

	INSERT INTO BD_POST_QUEUE ( fphm, type, STATUS, subsystem )
	SELECT b.pkid, 62, 1, 'cs' FROM BD_BGGG b
	LEFT JOIN BD_PACKAGE p ON p.bdid = b.bdid
	LEFT JOIN BD_SUBPROJECT s ON s.probid = b.probid
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE t WHERE t.fphm = CONCAT(b.pkid) AND t.type = 62 ) AND b.state = '8' AND IFNULL(s.marketfilter, '0') != '1' AND s.zbfs = '1';
	--  变更公告

	INSERT INTO BD_POST_QUEUE (fphm, type, STATUS, subsystem)
	SELECT g.pkid, 63, 1, 'cs' FROM BD_ZBSTOPGG g
	LEFT JOIN BD_PACKAGE p ON p.bdid = g.bdid
	LEFT JOIN BD_SUBPROJECT s ON s.probid = g.probid
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE t WHERE t.fphm = CONCAT(g.pkid) AND t.type = 63 ) AND g.fbstatus = 19 AND IFNULL(s.marketfilter, '0') != '1' AND s.zbfs = '1';
	--  终止公告

	INSERT INTO BD_POST_QUEUE (fphm, type, STATUS, subsystem)
	SELECT g.pkid, 64, 1, 'cs' FROM BD_HXRGS g
	LEFT JOIN BD_PACKAGE p ON p.bdid = g.packid
	LEFT JOIN BD_SUBPROJECT s ON s.probid = g.probid
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE t WHERE t.fphm = CONCAT(g.pkid) AND t.type = 64 ) AND g.STATUS = 5 AND IFNULL(s.marketFilter, '0') != '1';
	--  中标候选人

	insert into BD_POST_QUEUE (fphm,type,status,subsystem)
	select g.pkid,65,1,'cs' from BD_DB_ZBJGGG g
	LEFT JOIN BD_PACKAGE p ON p.bdid = g.packid
	left join BD_SUBPROJECT s on s.probid=g.probid where
	not exists(select 1 from BD_POST_QUEUE t where t.fphm =  CONCAT(g.pkid) and t.type = 65 )
	and IFNULL(s.marketFilter, '0') != '1';
	--  中标结果公告

	INSERT INTO BD_POST_QUEUE ( fphm, TYPE, STATUS, subsystem )
	SELECT G.BDID, 76, 1, 'cs' FROM BD_PACKAGE G
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE T WHERE T.fphm = G.BDID AND T.TYPE = 76 ) AND ( G.KBSJ < SYSDATE() OR SYSDATE() - G.KBSJ < 1 );
	--  开标

	INSERT INTO BD_POST_QUEUE ( fphm, TYPE, STATUS, subsystem )
	SELECT G.BDID, 77, 1, 'cs' FROM BD_PACKAGE G
	WHERE NOT EXISTS ( SELECT 1 FROM BD_POST_QUEUE T WHERE T.fphm = G.BDID AND T.TYPE = 77 ) AND G.FILEPATH03 IS NOT NULL;
	--  评标结束


	    -- 注意只能执行一次初始化数据操作 ####  start
	insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A000000', '华北地区', null, 'A000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A010000', '北京', 'A000000', 'A000000,A010000', 0, 2, 1, SYSDATE(), SYSDATE(), '110000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A020000', '天津', 'A000000', 'A000000,A020000', 0, 2, 1, SYSDATE(), SYSDATE(), '120000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A030000', '河北', 'A000000', 'A000000,A030000', 0, 2, 1, SYSDATE(), SYSDATE(), '130000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A040000', '山西', 'A000000', 'A000000,A040000', 0, 2, 1, SYSDATE(), SYSDATE(), '140000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('A050000', '内蒙古', 'A000000', 'A000000,A050000', 0, 2, 1, SYSDATE(), SYSDATE(), '150000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('B000000', '东北地区', null, 'B000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('B010000', '辽宁', 'B000000', 'B000000,B010000', 0, 2, 1, SYSDATE(), SYSDATE(), '210000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('B020000', '吉林', 'B000000', 'B000000,B020000', 0, 2, 1, SYSDATE(), SYSDATE(), '220000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('B030000', '黑龙江', 'B000000', 'B000000,B030000', 0, 2, 1, SYSDATE(), SYSDATE(), '230000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C000000', '华东地区', null, 'C000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C010000', '上海', 'C000000', 'C000000,C010000', 0, 2, 1, SYSDATE(), SYSDATE(), '310000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C020000', '江苏', 'C000000', 'C000000,C020000', 0, 2, 1, SYSDATE(), SYSDATE(), '320000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C030000', '浙江', 'C000000', 'C000000,C030000', 0, 2, 1, SYSDATE(), SYSDATE(), '330000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C040000', '安徽', 'C000000', 'C000000,C040000', 0, 2, 1, SYSDATE(), SYSDATE(), '340000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C050000', '福建', 'C000000', 'C000000,C050000', 0, 2, 1, SYSDATE(), SYSDATE(), '350000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('C060000', '山东', 'C000000', 'C000000,C060000', 0, 2, 1, SYSDATE(), SYSDATE(), '370000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('D000000', '华中地区', null, 'D000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('D010000', '江西', 'D000000', 'D000000,D010000', 0, 2, 1, SYSDATE(), SYSDATE(), '360000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('D020000', '河南', 'D000000', 'D000000,D020000', 0, 2, 1, SYSDATE(), SYSDATE(), '410000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('D030000', '湖北', 'D000000', 'D000000,D030000', 0, 2, 1, SYSDATE(), SYSDATE(), '420000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('D040000', '湖南', 'D000000', 'D000000,D040000', 0, 2, 1, SYSDATE(), SYSDATE(), '430000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('E000000', '华南地区', null, 'E000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('E010000', '广东', 'E000000', 'E000000,E010000', 0, 2, 1, SYSDATE(), SYSDATE(), '440000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('E020000', '广西', 'E000000', 'E000000,E020000', 0, 2, 1, SYSDATE(), SYSDATE(), '450000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('E030000', '海南', 'E000000', 'E000000,E030000', 0, 2, 1, SYSDATE(), SYSDATE(), '460000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F000000', '西南地区', null, 'F000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F010000', '重庆', 'F000000', 'F000000,F010000', 0, 2, 1, SYSDATE(), SYSDATE(), '500000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F020000', '四川', 'F000000', 'F000000,F020000', 0, 2, 1, SYSDATE(), SYSDATE(), '510000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F030000', '贵州', 'F000000', 'F000000,F030000', 0, 2, 1, SYSDATE(), SYSDATE(), '520000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F040000', '云南', 'F000000', 'F000000,F040000', 0, 2, 1, SYSDATE(), SYSDATE(), '530000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('F050000', '西藏', 'F000000', 'F000000,F050000', 0, 2, 1, SYSDATE(), SYSDATE(), '540000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G000000', '西北地区', null, 'G000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G010000', '陕西', 'G000000', 'G000000,G010000', 0, 2, 1, SYSDATE(), SYSDATE(), '610000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G020000', '甘肃', 'G000000', 'G000000,G020000', 0, 2, 1, SYSDATE(), SYSDATE(), '620000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G030000', '青海', 'G000000', 'G000000,G030000', 0, 2, 1, SYSDATE(), SYSDATE(), '630000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G040000', '宁夏', 'G000000', 'G000000,G040000', 0, 2, 1, SYSDATE(), SYSDATE(), '640000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('G050000', '新疆', 'G000000', 'G000000,G050000', 0, 2, 1, SYSDATE(), SYSDATE(), '650000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('H000000', '特别行政区', null, 'H000000', 1, 1, 1, SYSDATE(), SYSDATE(), null);

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('H010000', '台湾', 'H000000', 'H000000,H010000', 0, 2, 1, SYSDATE(), SYSDATE(), '710000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('H020000', '香港', 'H000000', 'H000000,H020000', 0, 2, 1, SYSDATE(), SYSDATE(), '810000');

    insert into BD_DQ (CODE, NAME, FATHER, CODES, ISCHILD, PLEVEL, ISSHOW, CDATE, UDATE, BSCODE)
    values ('H030000', '澳门', 'H000000', 'H000000,H030000', 0, 2, 1, SYSDATE(), SYSDATE(), '820000');
	    -- 注意只能执行一次初始化数据操作 ####  start
    -- ----------add by huangyaoyu 2019年5月21日15:14:11 end es数据初始化sql -------------
	
	-- ==================================================================================
end
$$
CALL P_IM_UPGRADE();