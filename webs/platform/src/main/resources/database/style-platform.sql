drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	-- ==================================================================================
    -- mysql升级版本
	-- ==================================================================================
    set @num=0;
    set @tableName='SHORT_URL';
    select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql = '
				create table SHORT_URL (
					PKID              BIGINT(20)      NOT NULL AUTO_INCREMENT    COMMENT ''主键'',
                   SHORT_URL          VARCHAR(255)    NOT NULL                   COMMENT ''短网址路径'',
                   LONG_URL           VARCHAR(255)    NOT NULL                   COMMENT ''长网址路径'',
                   PATH_URL           VARCHAR(255)    NOT NULL                   COMMENT ''请求的路径'',
                   C_DATE             DATETIME        NOT NULL                   COMMENT ''创建时间'',
                   REDIRCT_TIME       BIGINT(20)      DEFAULT 0                  COMMENT ''转发次数'',
                   PRIMARY KEY (PKID)
				) ENGINE=INNODB AUTO_INCREMENT=1 COMMENT = ''短网址''
		';
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;

end
DELIMITER ;
CALL P_IM_UPGRADE();