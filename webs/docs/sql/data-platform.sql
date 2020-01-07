drop procedure if exists P_IM_UPGRADE;

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
    -- ==================================================================================
    -- mysql升级版本
    -- ==================================================================================
    set @num=0;
    select count(0) into @num from SYS_INFO;
    if @num = 0 then
        INSERT INTO SYS_INFO(SID,VERSION,DATE)
        VALUES ('S00000',0.0001,sysdate());
    end if;
    -- ==================================================================================
end;
CALL P_IM_UPGRADE();