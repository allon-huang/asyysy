drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
	set @CurVersion='1.0.0.1';
	set @msg='';
  	CALL P_VERSION('EX',@CurVersion,@msg,0);
  	if @msg<>'success' then
  		select @msg;
    	LEAVE RUN_LABEL;
  	end if;
  	
  	set @num=0;
 	select count(0) into @num from SYS_SYSINFO where sysid='EX';
  	if @num = 0 then
    	select '当前升级脚本与数据库不匹配================>';
    	LEAVE RUN_LABEL;
  	end if;
	-- ------------------------------------------------------------------------------------------------------------------------
	-- -- 本文件为写法实例，请勿执行！！！
	-- ------------------------------------------------------------------------------------------------------------------------
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_SP_MB_CHANNEL_TMP(
				   CN_PKID              VARCHAR(100) not null,
				   HYDM                 VARCHAR(30) not null,
				   TEMPLATE_ID          VARCHAR(50) not null,
				   CHANNEL_ID           VARCHAR(50) not null,
				   SEQ_NO               smallint not null,
				   IS_INDEX             smallint,
				   ORDER_NO             smallint,
				   URL_PARAM            VARCHAR(250),
				   DIS_NAME             VARCHAR(100),
				   primary key (CN_PKID)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
		
		-- 索引
		set @dsql = '
				create index IN_EX_SP_MB_CHANNEL_TMP on EX_SP_MB_CHANNEL_TMP(
				   TEMPLATE_ID,
				   CHANNEL_ID,
				   SEQ_NO,
				   HYDM
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_SP_MB_CHANNEL_COLUMN_TMP (
				   CN_PKID              VARCHAR(100) not null,
				   TMPCOL_ID            varchar(50) not null,
				   SEQ_NO               smallint not null,
				   HYDM                 VARCHAR(30) not null,
				   DIS_NAME             VARCHAR(250),
				   ORDER_NO smallint,
				   URL_PARAM VARCHAR(250),
				   primary key (CN_PKID, TMPCOL_ID, SEQ_NO)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_TEMPLATE_VALUE_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_SP_MB_TEMPLATE_VALUE_TMP (
				   TMPCOL_ID            varchar(50) not null,
				   SEQ_NO               smallint not null default 1,
				   HYDM                 VARCHAR(30) not null,
				   DAT_KEY              VARCHAR(50) not null,
				   DAT_VALUE            text,
				   primary key (TMPCOL_ID, HYDM, DAT_KEY)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN';
	set @columnName='MODEL_AREA';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN_TMP';
	set @columnName='MODEL_AREA';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_TEMPLATE_VALUE_TMP';
	set @columnName='TEMPLATE_ID';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_TEMPLATE_VALUE';
	set @columnName='TEMPLATE_ID';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN_TMP';
	set @columnName='TEMPLATE_ID';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN';
	set @columnName='TEMPLATE_ID';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' VARCHAR(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SHOPSTORE';
	set @columnName='DQ3';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SHOPSTORE';
	set @columnName='DQ3CODE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(10)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SHOP_MSG_TYPE';
	set @columnName='HYDM';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QXFP_MB';
	set @columnName='MENBER';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' modify column ',@columnName,' varchar(50)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_CUG_ACCBALANCE';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_ACCBALANCE (
			   PKID                 bigint not null auto_increment,
			   MBCODE               varchar(30),
			   BANKID               varchar(30),
			   DZRQ                 datetime,
			   FSRQ                 datetime,
			   SYACCAMT             dec(20,2),
			   STACCINAMT           dec(20,2),
			   STACCINEXAMT         dec(20,2),
			   STACCOUTAMT          dec(20,2),
			   STACCOUTEXAMT        dec(20,2),
			   STACCAMT             dec(20,2),
			   BYACCAMT             dec(20,2),
			   BTACCINAMT           dec(20,2),
			   BTACCINEXAMT         dec(20,2),
			   BTACCOUTAMT          dec(20,2),
			   BTACCOUTEXAMT        dec(20,2),
			   BACCAMT              dec(20,2),
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_CUG_BKINOUTAMT';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_BKINOUTAMT (
			   PKID                 bigint not null auto_increment,
			   STRANID              VARCHAR(32),
			   BKID                 VARCHAR(10),
			   BTRANID              VARCHAR(32),
			   AMT                  DEC(20,2),
			   IOTYP                smallint,
			   FTYP                 smallint,
			   DATE1                datetime,
			   DATE5                datetime,
			   DATE4                datetime,
			   DATE3                datetime,
			   DATE2                datetime,
			   TRANCODE             VARCHAR(32),
			   MBCODE               VARCHAR(30),
			   BSTA                 VARCHAR(30),
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	
	set @num=0;
	set @tableName='EX_CUG_INOUTAMT';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_INOUTAMT (
			   STRANID              VARCHAR(32) not null,
			   MBCODE               VARCHAR(30) not null,
			   BKID                 VARCHAR(10) not null,
			   BTRANID              VARCHAR(32),
			   AMT                  DEC(20,2),
			   BSTA                 VARCHAR(30),
			   SSTA                 VARCHAR(30),
			   IOTYP                smallint,
			   FTYP                 smallint,
			   ISCHECK              smallint,
			   CHECKMSG             VARCHAR(250),
			   SERRMSG              VARCHAR(250),
			   BERRMSG              VARCHAR(250),
			   DATE1                datetime,
			   DATE5                datetime,
			   DATE4                datetime,
			   DATE3                datetime,
			   DATE2                datetime,
			   DEPID                VARCHAR(30),
			   EXTBILLNO1           VARCHAR(32),
			   EXTBILLNO2           VARCHAR(32),
			   primary key (STRANID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	
	set @num=0;
	set @tableName='EX_CUG_MBLICENSE';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_MBLICENSE (
			   MBCODE               VARCHAR(30) not null,
			   BKID                 VARCHAR(10) not null,
			   KHNAME               VARCHAR(200),
			   BCUSTACCT            VARCHAR(30),
			   OBNAME               VARCHAR(130),
			   OBCODE               VARCHAR(30),
			   KHZH1                VARCHAR(30),
			   KHZH2                VARCHAR(30),
			   KHZH3                VARCHAR(30),
			   KHZH4                VARCHAR(30),
			   KHZH5                VARCHAR(30),
			   KHZH6                VARCHAR(30),
			   KHZH7                VARCHAR(30),
			   KHZH8                VARCHAR(30),
			   KHZH9                VARCHAR(30),
			   KHZH0                VARCHAR(30),
			   MTYP                 VARCHAR(10),
			   CARDTYPE             VARCHAR(10),
			   VCARDNO              VARCHAR(30),
			   FLAG1                smallint,
			   FLAG2                smallint,
			   FLAG3                smallint,
			   FLAG4                smallint,
			   FLAG5                smallint,
			   DATE1                datetime,
			   DATE2                datetime,
			   DATE3                datetime,
			   DATE4                datetime,
			   DATE5                datetime,
			   DATE6                datetime,
			   DATE7                datetime,
			   DATE8                datetime,
			   DATE9                datetime,
			   DATE0                datetime,
			   STATUS               smallint,
			   BAOSTA               smallint,
			   BSTR00               VARCHAR(30),
			   BSTR01               VARCHAR(30),
			   BSTR02               VARCHAR(30),
			   BSTR03               VARCHAR(30),
			   BSTR04               VARCHAR(30),
			   BSTR05               VARCHAR(30),
			   BSTR06               VARCHAR(30),
			   BSTR07               VARCHAR(30),
			   BSTR08               VARCHAR(30),
			   BSTR09               VARCHAR(30),
			   BSTR10               VARCHAR(80),
			   BSTR11               VARCHAR(80),
			   BSTR12               VARCHAR(80),
			   BSTR13               VARCHAR(80),
			   BSTR14               VARCHAR(80),
			   BSTR15               VARCHAR(80),
			   BSTR16               VARCHAR(100),
			   BSTR17               VARCHAR(100),
			   BSTR18               VARCHAR(100),
			   BSTR19               VARCHAR(200),
			   BSTR21               VARCHAR(200),
			   BSTR20               VARCHAR(200),
			   BSTR22               VARCHAR(200),
			   BSTR23               VARCHAR(200),
			   BSTR24               VARCHAR(200),
			   BSTR25               VARCHAR(200),
			   primary key (MBCODE)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_CUG_MBLICENSE_BAK';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_MBLICENSE_BAK (
			   MBCODE               VARCHAR(30) not null,
			   BKID                 VARCHAR(10) not null,
			   KHNAME               VARCHAR(200),
			   BCUSTACCT            VARCHAR(30),
			   OBNAME               VARCHAR(130),
			   OBCODE               VARCHAR(30),
			   KHZH1                VARCHAR(30),
			   KHZH2                VARCHAR(30),
			   KHZH3                VARCHAR(30),
			   KHZH4                VARCHAR(30),
			   KHZH5                VARCHAR(30),
			   KHZH6                VARCHAR(30),
			   KHZH7                VARCHAR(30),
			   KHZH8                VARCHAR(30),
			   KHZH9                VARCHAR(30),
			   KHZH0                VARCHAR(30),
			   MTYP                 VARCHAR(10),
			   FLAG1                smallint,
			   FLAG2                smallint,
			   FLAG3                smallint,
			   FLAG4                smallint,
			   FLAG5                smallint,
			   CARDTYPE             VARCHAR(10),
			   VCARDNO              VARCHAR(30),
			   DATE1                datetime,
			   DATE2                datetime,
			   DATE3                datetime,
			   DATE4                datetime,
			   DATE5                datetime,
			   DATE6                datetime,
			   DATE7                datetime,
			   DATE8                datetime,
			   DATE9                datetime,
			   DATE0                datetime,
			   STATUS               smallint,
			   BAOSTA               smallint,
			   BSTR00               VARCHAR(30),
			   BSTR01               VARCHAR(30),
			   BSTR02               VARCHAR(30),
			   BSTR03               VARCHAR(30),
			   BSTR04               VARCHAR(30),
			   BSTR05               VARCHAR(30),
			   BSTR06               VARCHAR(30),
			   BSTR07               VARCHAR(30),
			   BSTR08               VARCHAR(30),
			   BSTR09               VARCHAR(30),
			   BSTR10               VARCHAR(80),
			   BSTR11               VARCHAR(80),
			   BSTR12               VARCHAR(80),
			   BSTR13               VARCHAR(80),
			   BSTR14               VARCHAR(80),
			   BSTR15               VARCHAR(80),
			   BSTR16               VARCHAR(100),
			   BSTR17               VARCHAR(100),
			   BSTR18               VARCHAR(100),
			   BSTR19               VARCHAR(200),
			   BSTR21               VARCHAR(200),
			   BSTR20               VARCHAR(200),
			   BSTR22               VARCHAR(200),
			   BSTR23               VARCHAR(200),
			   BSTR24               VARCHAR(200),
			   BSTR25               VARCHAR(200),
			   primary key (MBCODE)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	

	set @num=0;
	set @tableName='EX_CUG_SENDBUF';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_SENDBUF (
			   STRANID              VARCHAR(32) not null,
			   BTRANID              VARCHAR(32),
			   BKID                 VARCHAR(10) not null,
			   SHOPNO               VARCHAR(30),
			   TRANCODE             VARCHAR(32),
			   DATE1                datetime,
			   DATE2                datetime,
			   DATE3                datetime,
			   DATE4                datetime,
			   DATE5                datetime,
			   SERRMSG              VARCHAR(250),
			   BERRMSG              VARCHAR(250),
			   BSTA                 VARCHAR(30),
			   SSTA                 VARCHAR(30),
			   STATUS               VARCHAR(30),
			   FTYP                 smallint,
			   primary key (STRANID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	


	set @num=0;
	set @tableName='EX_CUG_SIGNOUTAPPLY';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_CUG_SIGNOUTAPPLY (
			   FPHM                 VARCHAR(32) not null,
			   MBCODE               VARCHAR(30) not null,
			   BKID                 VARCHAR(10) not null,
			   DATE1                datetime,
			   DATE2                datetime,
			   DATE3                datetime,
			   DATE4                datetime,
			   DATE5                datetime,
			   OPT1                 VARCHAR(30),
			   OPT2                 VARCHAR(30),
			   OPT3                 VARCHAR(30),
			   OPT4                 VARCHAR(30),
			   STATUS               smallint,
			   OTYP                 smallint,
			   primary key (FPHM)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_DB_BKACCOUNT';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_BKACCOUNT (
			   ZWDATE               datetime not null,
			   BKID                 VARCHAR(10) not null,
			   CDATE                datetime,
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, BKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	
	set @num=0;
	set @tableName='EX_DB_BKACCOUNT_DAY';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_BKACCOUNT_DAY (
			   ZWDATE               datetime not null,
			   BKID                 VARCHAR(10) not null,
			   CDATE                datetime,
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, BKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_DB_BKACCOUNT_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_BKACCOUNT_TMP (
			   ZWDATE               datetime not null,
			   BKID                 VARCHAR(10) not null,
			   CDATE                datetime,
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, BKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_DB_LOGS';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_LOGS (
			   PKID                 bigint not null auto_increment,
			   CDATE                datetime,
			   MSG                  VARCHAR(250),
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;	
	
	set @num=0;
	set @tableName='EX_DB_MBACCOUNT';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_MBACCOUNT (
			   ZWDATE               datetime not null,
			   MBCODE               VARCHAR(30) not null,
			   CDATE                datetime,
			   QCSD                 DEC(20,2),
			   SDR                  DEC(20,2),
			   SDC                  DEC(20,2),
			   QMSD                 DEC(20,2),
			   QCKY                 DEC(20,2),
			   KYR                  DEC(20,2),
			   KYC                  DEC(20,2),
			   QMKY                 DEC(20,2),
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, MBCODE)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_DB_MBACCOUNT_DAY';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_MBACCOUNT_DAY (
			   ZWDATE               datetime not null,
			   MBCODE               VARCHAR(30) not null,
			   CDATE                datetime,
			   QCSD                 DEC(20,2),
			   SDR                  DEC(20,2),
			   SDC                  DEC(20,2),
			   QMSD                 DEC(20,2),
			   QCKY                 DEC(20,2),
			   KYR                  DEC(20,2),
			   KYC                  DEC(20,2),
			   QMKY                 DEC(20,2),
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, MBCODE)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;

	set @num=0;
	set @tableName='EX_DB_MBACCOUNT_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_DB_MBACCOUNT_TMP (
			   ZWDATE               datetime not null,
			   MBCODE               VARCHAR(30) not null,
			   CDATE                datetime,
			   QCSD                 DEC(20,2),
			   SDR                  DEC(20,2),
			   SDC                  DEC(20,2),
			   QMSD                 DEC(20,2),
			   QCKY                 DEC(20,2),
			   KYR                  DEC(20,2),
			   KYC                  DEC(20,2),
			   QMKY                 DEC(20,2),
			   QCYE                 DEC(20,2),
			   YER                  DEC(20,2),
			   YEC                  DEC(20,2),
			   QMYE                 DEC(20,2),
			   primary key (ZWDATE, MBCODE)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SYSTEM_INFO';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_SYSTEM_INFO(
			   PKID                 tinyint not null,
			   MALL_NAME            varchar(200),
			   LAST_BALANCE_DATE    datetime,
			   NOW_BALANCE_DATE     datetime,
			   BAL_ERR_MSG          varchar(200),
			   FLAG00               smallint,
			   FLAG01               smallint,
			   FLAG02               smallint,
			   FLAG03               smallint,
			   FLAG04               smallint,
			   FLAG05               smallint,
			   FLAG06               smallint,
			   FLAG07               smallint,
			   FLAG08               smallint,
			   FLAG09               smallint,
			   FLAG10               smallint,
			   FLAG11               int,
			   FLAG12               int,
			   FLAG13               int,
			   FLAG14               int,
			   FLAG15               int,
			   FLAG16               int,
			   FLAG17               int,
			   FLAG18               int,
			   FLAG19               int,
			   FLAG20               int,
			   STR00                varchar(30),
			   STR01                varchar(30),
			   STR02                varchar(30),
			   STR03                varchar(30),
			   STR04                varchar(32),
			   STR05                varchar(32),
			   STR06                varchar(32),
			   STR07                varchar(32),
			   STR08                varchar(32),
			   STR09                varchar(32),
			   STR10                varchar(50),
			   STR11                varchar(50),
			   STR12                varchar(50),
			   STR13                varchar(80),
			   STR14                varchar(80),
			   STR15                varchar(80),
			   STR16                varchar(80),
			   STR17                varchar(100),
			   STR18                varchar(100),
			   STR19                varchar(200),
			   STR20                varchar(200),
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_FD_KXMX_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_FD_KXMX_TMP (
			   PKID                 bigint not null,
			   BKID                 VARCHAR(10) not null,
			   HYDM               VARCHAR(30) not null,
			   RQ                   datetime not null,
			   AMT                  DEC(20,2) not null,
			   TYP                  smallint,
			   FLAG                 smallint not null,
			   EXTBILL              VARCHAR(32),
			   BKZH1                VARCHAR(32),
			   BKZH2                VARCHAR(32),
			   KHNAME               VARCHAR(250),
			   KHH                  VARCHAR(100),
			   REMARK               VARCHAR(250),
			   FKHM                 VARCHAR(250),
			   FKZH                 VARCHAR(30),
			   FKBK                 VARCHAR(250),
			   FKFS                 VARCHAR(30),
			   OPT                  VARCHAR(30),
			   DATE1                datetime,
			   DATE2                datetime,
			   DATE3                datetime,
			   DATE4                datetime,
			   PRINTTIMES           smallint,
			   PRINTTIMESJYZX       smallint,
			   DATE5                datetime,
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='EX_FD_ACCLIST_TMP';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
			create table EX_FD_ACCLIST_TMP (
			   PKID                 bigint not null,
			   HYDM                 varchar(30) not null,
			   DFDM                 varchar(30),
			   BKID                 varchar(10),
			   RQ                   datetime,
			   AMT                  DEC(20,2),
			   EXTBILL              varchar(32),
			   TYP                  tinyint,
			   REMARK               varchar(200),
			   OPT                  varchar(30),
			   BUS_TP               tinyint,
			   primary key (PKID)
			)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='EX_SYSTEM_INFO';
	set @columnName='BAL_FLAG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' tinyint');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SHOPSTORE';
	set @columnName='COMPANY_IMG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(250)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN';
	set @columnName='HYDM';
	select count(0) into @num from information_schema.KEY_COLUMN_USAGE where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' DROP PRIMARY KEY, add primary key(CN_PKID,TMPCOL_ID,SEQ_NO,HYDM)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SP_MB_CHANNEL_COLUMN_TMP';
	set @columnName='HYDM';
	select count(0) into @num from information_schema.KEY_COLUMN_USAGE where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' DROP PRIMARY KEY, add primary key(CN_PKID,TMPCOL_ID,SEQ_NO,HYDM)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='EX_MB_BANK';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_MB_BANK (
				   MBCODE               VARCHAR(30) not null,
				   YHDM                 VARCHAR(10) not null,
				   KHZH                 VARCHAR(30),
				   KHNAME               VARCHAR(150),
				   KHBANK               VARCHAR(80),
				   IS_DEFAULT_NO		smallint,
				   primary key (MBCODE, YHDM)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_MB_BANK';
	set @columnName='REMARK';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(150)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	-- 询比价建表 add zhminfu 20150113
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_QUERY_INFO (
				  FPHM    VARCHAR(30) not null,
				  HYDM    VARCHAR(30),
				  OPT1    VARCHAR(30) not null,
				  OPT2    VARCHAR(30),
				  STATUS  smallint not null,
				  DQ1     VARCHAR(100),
				  DQ2     VARCHAR(100),
				  DQ3     VARCHAR(100),
				  DQCODE  VARCHAR(6) not null,
				  DQNAME  VARCHAR(100) not null,
				  XJCODE  VARCHAR(6),
				  XJNAME  VARCHAR(100),
				  WZADDR  VARCHAR(100),
				  DATE1   datetime not null,
				  DATE2   datetime,
				  DATE3   datetime,
				  DATE4   datetime,
				  DATE5   datetime,
				  DATE6   datetime,
				  DATE7   datetime,
				  DATE8   datetime,
				  DATE9   datetime,
				  DATE0   datetime,
				  FLAG00  smallint,
				  FLAG01  smallint,
				  FLAG02  smallint,
				  FLAG03  smallint,
				  FLAG04  smallint,
				  FLAG05  smallint,
				  FLAG06  smallint,
				  FLAG07  smallint,
				  FLAG08  smallint,
				  FLAG09  smallint,
				  FLAG10  smallint,
				  BZJ     DEC(16,3),
				  DEPID   VARCHAR(30),
				  DEPNAME VARCHAR(100),
				  BSGID   VARCHAR(30),
				  CSGID   VARCHAR(30),
				  CTYCODE VARCHAR(4),
				  primary key (FPHM)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_SOURCE';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_QUERY_SOURCE (
				  FPHM   VARCHAR(30) not null,
				  XH     smallint not null,
				  WZID   VARCHAR(32) not null,
				  HYDM   VARCHAR(30) not null,
				  SL1    DEC(20,3),
				  SL2    DEC(20,6),
				  MINSL  DEC(20,6),
				  DLCODE VARCHAR(30),
				  DLNAME VARCHAR(80),
				  PMCODE VARCHAR(30),
				  PM     VARCHAR(80),
				  CZ     VARCHAR(80),
				  GG     VARCHAR(80),
				  CD     VARCHAR(80),
				  FLAG00 smallint,
				  FLAG01 smallint,
				  FLAG02 smallint,
				  FLAG03 smallint,
				  FLAG04 smallint,
				  FLAG05 smallint,
				  FLAG06 smallint,
				  FLAG07 smallint,
				  FLAG08 smallint,
				  FLAG09 smallint,
				  FLAG10 smallint,
				  primary key (FPHM, XH)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_BAK';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_QUERY_PRICE_BAK (
				  PKID    bigint not null auto_increment,
				  FPHM    VARCHAR(30) not null,
				  XH      smallint not null,
				  WZID    VARCHAR(32) not null,
				  HZDM    VARCHAR(30),
				  PRICE   DEC(16,3),
				  SL1     DEC(16,3),
				  SL2     DEC(16,6),
				  PM      VARCHAR(80),
				  CZ      VARCHAR(80),
				  GG      VARCHAR(80),
				  CD      VARCHAR(80),
				  OPT1    VARCHAR(30),
				  SL00    DEC(16,6),
				  SL01    DEC(16,6),
				  SL02    DEC(16,6),
				  SL03    DEC(16,6),
				  SL04    DEC(16,6),
				  SL05    DEC(16,6),
				  FLAG00  smallint,
				  FLAG01  smallint,
				  FLAG02  smallint,
				  FLAG03  smallint,
				  FLAG04  smallint,
				  FLAG05  smallint,
				  DATE1   datetime,
				  DATE2   datetime,
				  DATE3   datetime,
				  DATE4   datetime,
				  DEPID   VARCHAR(30),
				  DEPNAME VARCHAR(30),
				  BSGID   VARCHAR(30),
				  CSGID   VARCHAR(30),
				  DLNAME  VARCHAR(30),
				  PMCODE  VARCHAR(30),
				  CJFPHM  VARCHAR(30),
				  primary key (PKID)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_SOURCE';
	set @columnName='SLDW1';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(10)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_SOURCE';
	set @columnName='SLDW2';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(10)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_SOURCE';
	set @columnName='CPNAME';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(80)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_SOURCE';
	set @columnName='CPMS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	set @columnName='TITLE';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	set @columnName='LXFLAG';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' smallint');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	set @columnName='LXR';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(100)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	set @columnName='LXTEL';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(32)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_INFO';
	set @columnName='REASON';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(500)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE';
	set @columnName='PKFPHM';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=1 then
		drop table if exists EX_QUERY_PRICE;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_QUERY_PRICE (
				  FPHM    VARCHAR(30) not null,
				  HZDM    VARCHAR(30),
				  OPT1    VARCHAR(30),
				  OPT2    VARCHAR(30),
				  XJBH    VARCHAR(30),
				  STATUS  smallint,
				  DATE0   datetime,
				  DATE1   datetime,
				  DATE2   datetime,
				  DATE3   datetime,
				  DATE4   datetime,
				  DATE5   datetime,
				  DATE6   datetime,
				  DATE7   datetime,
				  DATE8   datetime,
				  DATE9   datetime,
				  FLAG00  smallint,
				  FLAG01  smallint,
				  FLAG02  smallint,
				  FLAG03  smallint,
				  FLAG04  smallint,
				  FLAG05  smallint,
				  FLAG06  smallint,
				  FLAG07  smallint,
				  FLAG08  smallint,
				  FLAG09  smallint,
				  FLAG10  smallint,
				  DEPID   VARCHAR(30),
				  DEPNAME VARCHAR(30),
				  BSGID   VARCHAR(30),
				  CSGID   VARCHAR(30),
				  REASON  VARCHAR(500),
				  HTHM    VARCHAR(3000),
				  primary key (FPHM)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	select count(0) into @num from information_schema.tables where table_name=@tableName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql = '
				create table EX_QUERY_PRICE_MX (
				  FPHM   VARCHAR(30) not null,
				  XH     smallint not null,
				  WZID   VARCHAR(32) not null,
				  HZDM   VARCHAR(30) not null,
				  PRICE  DEC(16,3),
				  SL1    DEC(20,3),
				  SL2    DEC(20,6),
				  SL3    DEC(20,6),
				  MINSL  DEC(20,6),
				  SLDW1  VARCHAR(10),
				  SLDW2  VARCHAR(10),
				  DLCODE VARCHAR(30),
				  DLNAME VARCHAR(80),
				  PMCODE VARCHAR(30),
				  PM     VARCHAR(80),
				  CZ     VARCHAR(80),
				  GG     VARCHAR(80),
				  CD     VARCHAR(80),
				  FLAG00 smallint,
				  FLAG01 smallint,
				  FLAG02 smallint,
				  FLAG03 smallint,
				  FLAG04 smallint,
				  FLAG05 smallint,
				  FLAG06 smallint,
				  FLAG07 smallint,
				  FLAG08 smallint,
				  FLAG09 smallint,
				  FLAG10 smallint,
				  CPMS   VARCHAR(500),
				  CPNAME VARCHAR(80),
				  HTHM   VARCHAR(3000),
				  primary key (FPHM, XH)
				)
		';
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL4';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL5';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL6';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL7';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL8';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_QUERY_PRICE_MX';
	set @columnName='SL9';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' DEC(20,6)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	set @num=0;
	set @tableName='EX_SHOPSTORE';
	set @columnName='CHECK_STATUS';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' int');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
	
	
	set @num=0;
	set @tableName='EX_SHOPSTORE';
	set @columnName='CHECK_OPT';
	select count(0) into @num from information_schema.COLUMNS where TABLE_NAME=@tableName and COLUMN_NAME=@columnName and TABLE_SCHEMA=DATABASE();
	if @num=0 then
		set @dsql=concat('alter table ',@tableName,' add ',@columnName,' varchar(30)');
		PREPARE drun from @dsql; -- 动态执行
		EXECUTE drun;
		DEALLOCATE PREPARE drun;
	end if;
end
$$
CALL P_IM_UPGRADE();