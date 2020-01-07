drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
    -- ==================================================================================
    -- mysql升级版本
    -- ==================================================================================


    -- ---2018-07-26 hejw start-------------
    set @num=0;
    select count(0) into @num from SYS_INFO ;
    if @num = 0 then
        insert into SYS_INFO values ('00000',0.001,sysdate());
    end if;

    set @num=0;
    select count(0) into @num from SHORT_URL ;
    if @num = 0 then
        insert into
            SHORT_URL(SHORT_URL,LONG_URL,PATH_URL,C_DATE,REDIRCT_TIME)
        values ('D_1VP67YXynb','http://www.asyysy.cn','1VP67YXynb',sysdate(),0);
    end if;

    -- ==================================================================================
end
$$
CALL P_IM_UPGRADE();