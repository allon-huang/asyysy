drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	set @CurVersion='1.0.0.00';
	set @msg='';
  	CALL P_VERSION('BD',@CurVersion,@msg,0);
  	if @msg<>'success' then
  		select @msg;
    	LEAVE RUN_LABEL;
  	end if;
  	
  	set @num=0;
 	select count(0) into @num from SYS_SYSINFO where sysid='BD';
  	if @num = 0 then
    	select '当前升级脚本与数据库不匹配================>';
    	LEAVE RUN_LABEL;
  	end if;
	
	-- ==================================================================================

	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='XMJL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE() and CHARACTER_MAXIMUM_LENGTH <> 50;
	if @num=1 then
		set @dsql=concat('alter table ',@tableName,' DROP column  ',@columnName,'');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='BD_OFFER_MX';
	set @columnName='XMJL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_JURY';
	set @columnName='ZJSHBH';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(32)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_CONTRACT_ITEM';
	set @columnName='DJDATE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DATETIME');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_REWARD';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table BD_REWARD (
				  PKID    bigint not null auto_increment,
				  HYDM    VARCHAR(30) ,
				  SJQX    VARCHAR(100) ,
				  CONTENT text ,
				  CDATE	  datetime ,
				  COPT	  VARCHAR(100),
				  primary key (PKID)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_TB_SIGNUP';
	set @columnName='viewStatus';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int(2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_zbgg';
	set @columnName='TZFL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(5)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_zbgg';
	set @columnName='TZLQDZ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_tbyqsbz';
	set @columnName='TZFL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(5)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_tbyqsbz';
	set @columnName='TZLQDZ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_tbyqsbz';
	set @columnName='TZYJ';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	
	
	
	set @num=0;
	set @tableName='BD_FB_ZBCSSZ';
	set @columnName='tbbzjpercentMax';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(5)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_MB_PBMB_TK_MX';
	set @columnName='tkbz';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' modify column ',@columnName,' varchar(2000)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_MB_PBMB_TK_MX_BAK';
	set @columnName='tkbz';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' modify column ',@columnName,' varchar(2000)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='reason';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' text');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='BD_PACKAGE_EXT';
	set @columnName='reasonpath';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_jury';
	set @columnName='timesdw';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' NUMBER(10,1)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_zbgg';
	set @columnName='ggnr';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' CLOB');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_db_zbjggg';
	set @columnName='ggnr';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' CLOB');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_cc_receipt';
	set @columnName='hztyp';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_jury_sign';
	set @columnName='cardnum';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_subproject';
	set @columnName='zbrzbdm';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_tb_signup';
	set @columnName='flag05';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_tb_signup';
	set @columnName='res';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(2000)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
		set @num=0;
	set @tableName='BD_FB_ZBCSSZ';
	set @columnName='tbbzjpercent_Min';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(5)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_subproject_ext';
	set @columnName='ZFGLBF';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(10)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='kpflag';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(2)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='fptype';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(3)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='dwmc';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(250)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='nsrsbh';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='fpjsr';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(250)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='jsrtel';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(20)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='bd_td_dd';
	set @columnName='jsraddr';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(200)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='bd_fjjbxx';
	set @columnName='guid';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' modify column ',@columnName,' varchar2(60)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='BD_JURY';
	set @columnName='autoerror';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(400)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='bd_tbyqsbz';
	set @columnName='qtmj';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' modify column ',@columnName,' varchar2(400)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
    set @num=0;
    set @tableName='BD_JURY_REQUIRE';
    set @columnName='SAMPLE_TIME';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' NUMBER');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if; 
    
    set @num=0;
    set @tableName='BD_JURY_MEMBER';
    set @columnName='PKREQUIRE';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' NUMBER');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if; 
    
    set @num=0;
    set @tableName='bd_package';
    set @columnName='cjkbjlsj';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
	
	set @num=0;
    set @tableName='bd_package';
    set @columnName='yskqjlcjsj';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package';
    set @columnName='pbqtsm';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' CLOB');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_tb_signup';
    set @columnName='ysyqdate';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_subproject';
    set @columnName='sealdata01';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR2(200)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package_item';
    set @columnName='jhdd';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(200)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package_item';
    set @columnName='jhq';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(200)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='Bd_Zbgg';
    set @columnName='jsdd';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(50)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='Bd_Zbgg';
    set @columnName='jhgq';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(10)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='Bd_Tbyqsbz';
    set @columnName='jhgq';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(10)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='Bd_Tbyqsbz';
    set @columnName='jsdd';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(50)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    
    set @num=0;
    set @tableName='BD_TD_DD';
    set @columnName='startRecord';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'NUMBER');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_subproject';
    set @columnName='optid1';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(80)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package_record';
    set @columnName='opt006';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(60)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package_record';
    set @columnName='date006';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_zbgg';
    set @columnName='isdlstb';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(1)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_zbgg';
    set @columnName='dlstbyq';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'CLOB');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_tbyqsbz';
    set @columnName='dlstbyq';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'CLOB');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    set @num=0;
    set @tableName='bd_ws_task';
    set @columnName='IFPHM';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,'VARCHAR2(50)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='BD_WS_TASK_BAK';
    set @columnName='IFPHM';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,'VARCHAR2(50)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_hgzjtzs';
    set @columnName='autosms';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(200)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_tbyqsbz';
    set @columnName='oldname';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_objection';
    set @columnName='filename';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(90)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='Bd_Tbyqsbz';
    set @columnName='preult';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' modify ',@columnName,'VARCHAR2(2000)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_objection';
    set @columnName='filename1';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(90)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_package';
    set @columnName='filename01';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_zbstopgg';
    set @columnName='accessoryname';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_zb_file';
    set @columnName='yswjqrsj';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_fb_tb_file';
    set @columnName='zbwjqrsj';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'DATE');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
    set @num=0;
    set @tableName='bd_contract';
    set @columnName='htjsdw';
    select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
    if @num=0 then
        set @dsql=concat('alter table ',@tableName,' add ',@columnName,'VARCHAR2(100)');
        PREPARE drun from @dsql; -- 动态执行
        EXECUTE drun;
        DEALLOCATE PREPARE drun;
    end if;
    
	-- ==================================================================================
end
$$
CALL P_IM_UPGRADE();