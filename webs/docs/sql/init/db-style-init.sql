drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin

    -- 短网址
    set @num=0;
    set @tableName='SHORT_URL';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table SHORT_URL
        (
            PKID         BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键',
            SHORT_URL    VARCHAR(255) NOT NULL COMMENT '短网址路径',
            LONG_URL     VARCHAR(255) NOT NULL COMMENT '长网址路径',
            PATH_URL     VARCHAR(255) NOT NULL COMMENT '请求的路径',
            C_DATE       DATETIME     NOT NULL COMMENT '创建时间',
            REDIRCT_TIME BIGINT(20) DEFAULT 0 COMMENT '转发次数',
            PRIMARY KEY (PKID)
        ) AUTO_INCREMENT = 1 comment '短网址';
    end if;

    -- 微信回复模板
    set @num=0;
    set @tableName='WX_REPLY_MODEL';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table WX_REPLY_MODEL
        (
            PKID        BIGINT(20)   NOT NULL AUTO_INCREMENT COMMENT '主键',
            TYPE        VARCHAR(255) NOT NULL COMMENT '类型',
            KEYWORD     VARCHAR(255) NOT NULL COMMENT '关键词',
            REPLY_TEXT  VARCHAR(255) NOT NULL COMMENT '回复信息',
            SEND_SUM    integer      NOT NULL COMMENT '接收数量',
            CREATE_TIME DATETIME COMMENT '创建时间',
            PRIMARY KEY (PKID)
        ) AUTO_INCREMENT = 1 comment '微信回复模板';
    end if;

    -- 系统信息
    set @num=0;
    set @tableName='SYS_INFO';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table SYS_INFO
        (
            SID     varchar(10) NOT NULL COMMENT '系统标识',
            VERSION binary(10)  NOT NULL COMMENT '系统版本',
            DATE    DATETIME    NOT NULL COMMENT '时间'
        ) comment '系统信息';
    end if;

end
$$
CALL P_IM_UPGRADE();