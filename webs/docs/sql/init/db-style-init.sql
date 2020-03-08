drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin

    -- 短网址
    set @num=0;
    set @tableName='short_url';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table short_url
        (
            pkid         bigint(20)   not null auto_increment comment '主键',
            short_url    varchar(255) not null comment '短网址路径',
            long_url     varchar(255) not null comment '长网址路径',
            short_code     varchar(100) not null comment '短网址唯一标识',
            c_date       datetime     not null comment '创建时间',
            redirct_time bigint(20) default 0 comment '转发次数',
            primary key (pkid,short_code)
        ) auto_increment = 1 comment '短网址';
    end if;

    -- 微信回复模板
    set @num=0;
    set @tableName='wx_reply_model';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table wx_reply_model
        (
            pkid        bigint(20)   not null auto_increment comment '主键',
            type        varchar(255) not null comment '类型',
            keyword     varchar(255) not null comment '关键词',
            reply_text  varchar(255) not null comment '回复信息',
            send_sum    integer      not null comment '接收数量',
            create_time datetime comment '创建时间',
            primary key (pkid)
        ) auto_increment = 1 comment '微信回复模板';
    end if;

    -- 系统信息
    set @num=0;
    set @tableName='sys_info';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table sys_info
        (
            sid     varchar(10) NOT NULL COMMENT '系统标识',
            version binary(10)  NOT NULL COMMENT '系统版本',
            date    DATETIME    NOT NULL COMMENT '时间'
        ) comment '系统信息';
    end if;


    -- 收到的微信消息
    set @num=0;
    set @tableName='wx_message';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table wx_message
        (
            pkid        bigint(20)   not null auto_increment comment '主键',
            open_id        varchar(255) not null comment 'openId',
            message     varchar(255) not null comment '消息内容',
            all_message  varchar(255) not null comment '整体报文',
            type    varchar(255)      not null comment '消息类型',
            date datetime comment '创建时间',
            primary key (pkid)
        ) auto_increment = 1 comment '收到的微信消息';
    end if;

    -- 收到的微信消息
    set @num=0;
    set @tableName='user';
    select count(*) into @num from information_schema.TABLES where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num = 0 then
        create table user
        (
            pkid        bigint(20)   not null auto_increment comment '主键',
            user_name        varchar(255) not null comment '用户名',
            password     varchar(255) not null comment '密码',
            e_mail  varchar(255) not null comment '邮箱',
            qq    varchar(255)      not null comment 'QQ号',
            telphone    varchar(255)      not null comment '手机号',
            qq_open_id        varchar(255) not null comment 'qq登录openid',
            qq_access_token        varchar(255) not null comment 'qq登录accessToken',
            create_date datetime comment '创建时间',
            type    varchar(255)      not null comment '类型',
            update_date datetime comment '更新时间',
            primary key (pkid)
        ) auto_increment = 1 comment '收到的微信消息';
    end if;

end
$$
CALL P_IM_UPGRADE();