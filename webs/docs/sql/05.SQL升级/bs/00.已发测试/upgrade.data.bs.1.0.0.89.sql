DECLARE
  CURDB VARCHAR(255); -- 当前用户（数据名称）
  MSG VARCHAR2(500);
  NUM INT;
  CURVERSION VARCHAR2(30);
  TMP1 VARCHAR2(255);
  TMP2 VARCHAR2(255);
BEGIN
    CURVERSION:='1.0.0.89'; -- 本升级文件的版本，每个升级文件必须修改
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG); -- 判断数据版本
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
	
	 num:=0;
  select count(1) into num from bs_qxsz where sid='M00008' and mkid='M084020' and url='/exp/bidding/buy/kb/packlist.do' and name='开标记录确认';    
  if num = 1 then
    update bs_qxsz set name='开标记录' where sid='M00008' and mkid='M084020' and url='/exp/bidding/buy/kb/packlist.do'  and name='开标记录确认' ;
  end if; 
  
  	
  	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087030' and mid='M0870';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M087030', 'M0870', '合同执行', '合同履约', '/exp/bidding/buy/contract/execute/list.do', '/exp/bidding/buy/contract/execute/list.do#/exp/bidding/buy/contract/execute/showContract.do#/exp/bidding/buy/contract/execute/downLoad.do#/exp/bidding/buy/contract/execute/dowloadBdwFile.do', 1, 300, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='list' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'list', 2, '合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='showContract' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'showContract', 2, '合同详情', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='downLoad' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'downLoad', 2, '下载合同附件', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/buy/contract/execute' and  method='dowloadBdwFile' and mkid='M087030' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M087030', '/exp/bidding/buy/contract/execute', 'dowloadBdwFile', 2, '合同列表-标段包-标的物附件下载', 1, 'M00008');
	end if;
	
	------------------------
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096050' and mid='M0960';
	if num=0 then
		INSERT INTO BS_QXSZ (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, SID) 
		VALUES ('M096050', 'M0960', '签订合同', '合同履约', '/exp/bidding/sell/contract/execute/list.do', '/exp/bidding/sell/contract/execute/list.do#/exp/bidding/sell/contract/execute/showContract.do#/exp/bidding/sell/contract/execute/downLoad.do#/exp/bidding/sell/contract/execute/dowloadBdwFile.do', 1, 300, 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/execute' and  method='list' and mkid='M096050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096050', '/exp/bidding/sell/contract/execute', 'list', 2, '合同列表', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/execute' and  method='showContract' and mkid='M096050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096050', '/exp/bidding/sell/contract/execute', 'showContract', 2, '合同详情', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/execute' and  method='downLoad' and mkid='M096050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096050', '/exp/bidding/sell/contract/execute', 'downLoad', 2, '下载合同附件', 1, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where action='/exp/bidding/sell/contract/execute' and  method='dowloadBdwFile' and mkid='M096050' and  sid='M00008';
	if num=0 then
		INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		VALUES ('M096050', '/exp/bidding/sell/contract/execute', 'dowloadBdwFile', 2, '合同列表-标段包-标的物附件下载', 1, 'M00008');
	end if;


	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087010' and mid='M0870';
	if num=1 then
		update bs_qxsz set name='合同签订', url='/exp/bidding/buy/contract/packageList.do' where sid='M00008' and mkid='M087010' and mid='M0870';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096010' and mid='M0960';
	if num=1 then
		update bs_qxsz set name='合同签订', url='/exp/bidding/sell/contract/packageList.do' where sid='M00008' and mkid='M096010' and mid='M0960';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00008' and mid='M0870';
	if num=1 then
		update bs_xtmk set url00='/exp/bidding/buy/contract/packageList.do' where sid='M00008' and mid='M0870';
	end if;
	
	num:=0;
	select count(1) into num from bs_xtmk where sid='M00008' and mid='M0960';
	if num=1 then
		update bs_xtmk set url00='/exp/bidding/sell/contract/packageList.do' where sid='M00008' and mid='M0960';
	end if;
	
	-------修改投标人 左边菜单--BY.zhminfu
	delete from bs_qxsz where mkid='M091094' and mid='M0910' and name='资格预审文件开启情况';
	UPDATE bs_qxsz SET NAME='招标文件购买' WHERE MKID='M091035' AND MID='M0910' AND NAME='购买招标文件' AND SID='M00008';
	UPDATE bs_qxsz SET NAME='投标文件上传' WHERE MKID='M092005' AND MID='M0920' AND NAME='上传投标文件' AND SID='M00008';
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M091064' and name='资格预审结果通知书' and mid='M0910' ; 
  	if num = 1 then
		delete from bs_qxsz where mkid='M091064' and mid='M0910' and name='资格预审结果通知书';
		UPDATE bs_qxsz SET NAME='资格预审结果',FIXED=NULL,ORDERNO=280, inurl='/exp/bidding/sell/result/list.do#/exp/bidding/sell/result/view.do' 
		WHERE MKID='M091061' AND MID='M0910' AND NAME='预审列表' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='资格预审公告查看及报名' WHERE MKID='M091005' AND MID='M0910' AND NAME='资格预审公告及报名' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='资格预审文件购买' WHERE MKID='M091020' AND MID='M0910' AND NAME='购买资格预审文件' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='招标文件购买' WHERE MKID='M091025' AND MID='M0910' AND NAME='购买招标文件' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='资格预审申请文件上传' WHERE MKID='M091026' AND MID='M0910' AND NAME='上传资格预审文件' AND SID='M00008';
		update bs_qxmx set mkid='M091061' where mkid='M091064' and action='/exp/bidding/sell/result' and method='download';
		update bs_qxmx set mkid='M091061' where mkid='M091064' and action='/exp/bidding/sell/result' and method='view';
	end if;
	
	------
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='doTask' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M020010','/exp/bidding/sell/bidding','doTask',2,'正在投标-继续任务',1,'M00008');
	end if;
	

	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M087030' and mid='M0870';
	if num=1 then
		update bs_qxsz set orderno=150 where sid='M00008' and mkid='M087030' and mid='M0870';
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M096050' and mid='M0960';
	if num=1 then
		update bs_qxsz set orderno=150 where sid='M00008' and mkid='M096050' and mid='M0960';
	end if;
	
	--------------------------------------------mazg start-------------------------------------------------------
	---履约保证金列表以及查看
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M087040' and mid='M0870' and sid='M00008';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M087040', 'M0870', '合同执行', '履约保证金', '/exp/bidding/buy/contract/bidbond/list.do', '/exp/bidding/buy/contract/bidbond/list.do#/exp/bidding/buy/contract/bidbond/showBid.do', 1, 50, 1, '', 'M00008');
    END IF;
	num:=0;
     select count(1) into num from bs_qxmx where mkid='M087040' and action='/exp/bidding/buy/contract/bidbond' and method='list' and sid='M00008';       
     if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M087040', '/exp/bidding/buy/contract/bidbond', 'list', 2, '履约保证金列表', 1, 'M00008');
     END IF;
	 
	 num:=0;
     select count(1) into num from bs_qxmx where mkid='M087040' and action='/exp/bidding/buy/contract/bidbond' and method='showBid' and sid='M00008';       
     if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M087040', '/exp/bidding/buy/contract/bidbond', 'showBid', 2, '履约保证金查看', 1, 'M00008');
     END IF;
	--------------------------------------------mazg end-------------------------------------------------------

	---投标-投标保证金支付  hanglong---
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M092020' and mid='M0920' and sid='M00008';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, PARENT, SID)
		values ('M092020', 'M0920', '投标', '投标保证金支付', '/exp/bidding/sell/bidbond/pay/list.do', '/exp/bidding/sell/bidbond/pay/list.do#/exp/bidding/sell/bidbond/pay/toPayBzj.do#/exp/bidding/sell/bidbond/pay/doPayBzj.do#/exp/bidding/sell/bidbond/pay/showContract.do#/exp/bidding/sell/bidbond/pay/packageView.do#/exp/bidding/sell/bidbond/pay/dowloadBdwFile.do#', 1, 200, 1, '', 'M00008');
    END IF;
    
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='list' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'list', 2, '待支付保证金标段列表', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='toPayBzj' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'toPayBzj', 2, '弹出支付页面', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='doPayBzj' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'doPayBzj', 2, '保证支付保证金', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='showContract' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'showContract', 2, '查看保证金支付生成的订单', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='packageView' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'packageView', 2, '查看标段信息', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092020' and action='/exp/bidding/sell/bidbond/pay' and method='dowloadBdwFile' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092020', '/exp/bidding/sell/bidbond/pay', 'dowloadBdwFile', 2, '标段附件下载', 1, 'M00008');
	END IF;
	
	num:=0;
    select count(1) into num from bs_qxsz where mkid='M092050' and mid='M0920' and sid='M00008';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, fixed, SID)
		values ('M092050', 'M0920', '投标', '费用支付（业务）', '/exp/bidding/sell/bidbond/ypay/ylist.do', '/exp/bidding/sell/bidbond/ypay/ylist.do#/exp/bidding/sell/bidbond/ypay/deleteDd#/exp/bidding/sell/bidbond/ypay/yshowContract.do', 1, 500, 1, '1', 'M00008');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M092050' and action='/exp/bidding/sell/bidbond/ypay' and method='ylist' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092050', '/exp/bidding/sell/bidbond/ypay', 'ylist', 2, '费用支付（业务）订单列表', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092050' and action='/exp/bidding/sell/bidbond/ypay' and method='deleteDd' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092050', '/exp/bidding/sell/bidbond/ypay', 'deleteDd', 2, '费用支付（业务）订单删除', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092050' and action='/exp/bidding/sell/bidbond/ypay' and method='yshowContract' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092050', '/exp/bidding/sell/bidbond/ypay', 'yshowContract', 2, '费用支付（业务）订单查看', 1, 'M00008');
	END IF;
    
    num:=0;
    select count(1) into num from bs_qxsz where mkid='M092060' and mid='M0920' and sid='M00008';       
    if num = 0 then 
		insert into bs_qxsz (MKID, MID, MNAME, NAME, URL, INURL, ISUSE, ORDERNO, STYP, fixed, SID)
		values ('M092060', 'M0920', '投标', '费用支付（财务）', '/exp/bidding/sell/bidbond/cpay/paylist.do', '/exp/bidding/sell/bidbond/cpay/paylist.do#/exp/bidding/sell/bidbond/cpay/toZfBzj.do#/exp/bidding/sell/bidbond/cpay/doZfBzj.do#/exp/bidding/sell/bidbond/cpay/cshowContract.do', 1, 600, 1, '1', 'M00008');
    END IF;
    
    num:=0;
	select count(1) into num from bs_qxmx where mkid='M092060' and action='/exp/bidding/sell/bidbond/cpay' and method='paylist' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092060', '/exp/bidding/sell/bidbond/cpay', 'paylist', 2, '费用支付（财务）订单列表', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092060' and action='/exp/bidding/sell/bidbond/cpay' and method='toZfBzj' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092060', '/exp/bidding/sell/bidbond/cpay', 'toZfBzj', 2, '费用支付（财务）订单支付页面', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092060' and action='/exp/bidding/sell/bidbond/cpay' and method='doZfBzj' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092060', '/exp/bidding/sell/bidbond/cpay', 'doZfBzj', 2, '费用支付（财务）订单支付', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092060' and action='/exp/bidding/sell/bidbond/cpay' and method='cshowContract' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092060', '/exp/bidding/sell/bidbond/cpay', 'cshowContract', 2, '费用支付（财务）订单查看', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxmx where mkid='M092060' and action='/exp/bidding/sell/bidbond/cpay' and method='payment' and sid='M00008';       
	if num = 0 then 
		insert into bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
		values ('M092060', '/exp/bidding/sell/bidbond/cpay', 'payment', 2, '选择支付方式', 1, 'M00008');
	END IF;
	
	num:=0;
	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M092060' and mid='M0920';
	if num=1 then
		num:=0;
		select instr(inurl,'/exp/bidding/sell/bidbond/cpay/payment.do') into num from bs_qxsz where sid='M00008' and mkid='M092060' and mid='M0920';
		if num=0 then
			update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/bidbond/cpay/payment.do') where sid='M00008' and mkid='M092060' and mid='M0920';
		end if;
	end if;

	---投标-投标保证金支付  hanglong---
 num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='tzsFS' and mkid='M08605015' and sid='M00008';    
  if num = 1 then
    update bs_qxmx set mkid='M086050' where action='/exp/bidding/buy/scaling' and method='tzsFS' and mkid='M08605015' and sid='M00008';    
  end if; 

   num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='tzsQT' and mkid='M08605020' and sid='M00008';    
  if num = 1 then
    update bs_qxmx set mkid='M086050' where action='/exp/bidding/buy/scaling' and method='tzsQT' and mkid='M08605020' and sid='M00008';    
  end if;

   num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='tzsSave' and mkid='M08605005' and sid='M00008';    
  if num = 1 then
    update bs_qxmx set mkid='M086050' where action='/exp/bidding/buy/scaling' and method='tzsSave' and mkid='M08605005' and sid='M00008';    
  end if;

   num:=0;
  select count(1) into num from bs_qxmx where action='/exp/bidding/buy/scaling' and method='tzsTJ' and mkid='M08605010' and sid='M00008';    
  if num = 1 then
    update bs_qxmx set mkid='M086050' where action='/exp/bidding/buy/scaling' and method='tzsTJ' and mkid='M08605010' and sid='M00008';    
  end if;
  
    num:=0;
  select count(1) into num from bs_qxsz where mkid='M086050' and mid='M0860' and sid='M00008' and url='/exp/bidding/buy/scaling/listjg.do' and inurl='/exp/bidding/buy/scaling/toHwTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/buy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do';    
  if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do' where mkid='M086050' and mid='M0860' and sid='M00008' and url='/exp/bidding/buy/scaling/listjg.do' and inurl='/exp/bidding/buy/scaling/toHwTzs.do#/ex/exp/bidding/buy/scaling/tzsFS.do#/ex/exp/bidding/buy/scaling/tzsQT.do#/ex/exp/bidding/buy/scaling/tzsSave.do#/ex/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do';
  end if;
  
  num:=0;
  select count(1) into num from bs_qxmx where action='/bdp/market/step' and  method='index' and mkid='0' and  sid='M00008';
  if num=0 then
    INSERT INTO bs_qxmx (MKID, ACTION, METHOD, ACCESSTAG, REMARK, STYP, SID)
    VALUES ('0', '/bdp/market/step', 'index', 0, '招标步骤跳转地址', 1, 'M00008');
	end if;
	
	-- 权限设置 资格预审 资格预审文件确认
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0890' and mkid='M089015' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
		values('M089015','M0890','资格预审','资格预审文件确认','/bdp/bidding/buy/preficfile/toconfirmpacklist.do','/bdp/bidding/buy/preficfile/toconfirmpacklist.do#/bdp/bidding/buy/preficfile/toCofnirmZgyswj.do#/bdp/bidding/buy/preficfile/doCofnirmZgyswj.do',1,150,1,'M00008','008-1-3-2');
	end if;
	-- 权限明细 资格预审文件确认 资格预审文件确认页面 过渡页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toconfirmpacklist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','toconfirmpacklist',2,'资格预审文件确认-资格预审文件确认页面 过渡页面',1,'M00008');
	end if;
	-- 权限明细 资格预审文件确认 资格预审文件确认页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='toCofnirmZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','toCofnirmZgyswj',2,'资格预审文件确认-资格预审文件确认页面',1,'M00008');
	end if;
	-- 权限明细 资格预审文件确认 资格预审文件确认
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/bdp/bidding/buy/preficfile' and METHOD ='doCofnirmZgyswj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089015','/bdp/bidding/buy/preficfile','doCofnirmZgyswj',2,'资格预审文件确认-资格预审文件确认',1,'M00008');
	end if;
	

	--  评标-提问与回复 by zhaiyy-----
	-- 权限设置 提问与回复
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0940' and mkid='M094005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,fixed)
		values('M094005','M0940','评标','提问与回复','/exp/bidding/sell/qureply/list.do','/exp/bidding/sell/qureply/list.do',1,100,1,'M00008',1);
	end if;
	-- 权限明细 提问与回复列表
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/qureply' and METHOD ='list' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M094005','/exp/bidding/sell/qureply','list',2,'提问与回复列表',1,'M00008');
	end if;
	

	
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0890' and mkid ='M089010' and instr(inurl,'#/bdp/bidding/buy/preficfile/saveZgyswj.do')>0;
    if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/bdp/bidding/buy/preficfile/saveZgyswj.do') where sid = 'M00008' and mid = 'M0890' and mkid ='M089010';
    end if;

    
    ------zyy start-------
	num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M095020' and url='/exp/bidding/sell/hitbid/publicity/view.do';    
    if num = 1 then
      update bs_qxsz set url='/exp/bidding/sell/hitbid/publicity/packlist.do' where sid='M00008' and mkid='M095020' and url='/exp/bidding/sell/hitbid/publicity/view.do' ;
    end if;
    
     num:=0;
	 select instr(inurl,'/exp/bidding/sell/hitbid/publicity/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M095020' ; 
	 if num = 0 then
	  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/publicity/packlist.do') where  sid='M00008' and mkid='M095020' ; 
	 end if;
	 
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/hitbid/publicity' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M095020','/exp/bidding/sell/hitbid/publicity','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid='M00008' and mkid='M095040' and url='/exp/bidding/sell/hitbid/result/view.do';    
    if num = 1 then
      update bs_qxsz set url='/exp/bidding/sell/hitbid/result/packlist.do' where sid='M00008' and mkid='M095040' and url='/exp/bidding/sell/hitbid/result/view.do' ;
    end if;
    
     num:=0;
	 select instr(inurl,'/exp/bidding/sell/hitbid/result/packlist.do') into num from bs_qxsz where  sid='M00008' and mkid='M095040' ; 
	 if num = 0 then
	  update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/sell/hitbid/result/packlist.do') where  sid='M00008' and mkid='M095040' ; 
	 end if;
	 
	num:=0;
    select count(1) into num from bs_qxmx where action='/exp/bidding/sell/hitbid/result' and  method='packlist' and  sid='M00008';
    if num=0 then
        insert into bs_qxmx (mkid,action,method,accesstag,remark,styp,sid)
        values('M095040','/exp/bidding/sell/hitbid/result','packlist',2,'标段包列表-过渡页面',1,'M00008');
    end if;
    
    num:=0;
	select count(1) into num from bs_qxsz where mid='M0950' and mkid='M09504005' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,parent,sid)
		values('M09504005','M0950','中标','中标通知书','','',2,410,1,'M095040','M00008');
	end if;
    
    -------修改投标人定标 左边菜单--BY.zyy
	num:=0;
  	select count(1) into num from bs_qxsz where sid='M00008' and mkid='M095030' and name='中标通知书' and mid='M0950' ; 
  	if num = 1 then
		delete from bs_qxsz where mkid='M095030' and mid='M0950' and name='中标通知书';
		update bs_qxsz set isuse=0 where MKID='M095010' AND MID='M0950' AND NAME='信息管理' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='中标候选人公示' WHERE MKID='M095020' AND MID='M0950' AND NAME='中标候选人公示查看' AND SID='M00008';
		UPDATE bs_qxsz SET NAME='招标结果' WHERE MKID='M095040' AND MID='M0950' AND NAME='招标结果公告' AND SID='M00008';
		
		update bs_qxmx set mkid='M09504005' where mkid='M095030' and action='/exp/bidding/sell/hitbid/notice' and method='download';
		update bs_qxmx set mkid='M09504005' where mkid='M095030' and action='/exp/bidding/sell/hitbid/notice' and method='view';
	end if;
    ------zyy end-------

    
    -- 权限设置 发标 招标文件确认
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0830' and mkid='M083020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid,qxrole)
		values('M083020','M0830','发标','招标文件确认','/exp/bidding/buy/zbwjone/toconfirmpacklist.do','/exp/bidding/buy/zbwjone/toconfirmpacklist.do#/exp/bidding/buy/zbwjone/toConfirmZbwj.do#/exp/bidding/buy/zbwjone/doConfirmZbwj.do',1,160,1,'M00008','');
	end if;
	-- 权限明细 招标文件确认 招标文件确认页面 过渡页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toconfirmpacklist' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083020','/exp/bidding/buy/zbwjone','toconfirmpacklist',2,'招标文件确认-招标文件确认页面 过渡页面',1,'M00008');
	end if;
	-- 权限明细 招标文件确认 招标文件确认页面
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='toConfirmZbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083020','/exp/bidding/buy/zbwjone','toConfirmZbwj',2,'招标文件确认-招标文件确认页面',1,'M00008');
	end if;
	-- 权限明细 招标文件确认 招标文件确认
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/zbwjone' and METHOD ='doConfirmZbwj' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M083020','/exp/bidding/buy/zbwjone','doConfirmZbwj',2,'招标文件确认-招标文件确认',1,'M00008');
	end if;
	
	num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0930' and mkid ='M093005';
    if num=1 then
		update bs_qxsz set name='招标文件开启' where sid = 'M00008' and mid = 'M0930' and mkid ='M093005';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxsz where sid = 'M00008' and mid = 'M0930' and mkid ='M093010';
    if num=1 then
		update bs_qxsz set isuse=0 where sid = 'M00008' and mid = 'M0930' and mkid ='M093010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and action = '/exp/bidding/sell/kbqd' and method='confirmRecord' and styp=1 and mkid ='M093010';
    if num=1 then
		update bs_qxmx set mkid='M093005' where sid = 'M00008' and action = '/exp/bidding/sell/kbqd' and method='confirmRecord' and styp=1 and mkid ='M093010';
    end if;
    
    num:=0;
    select count(1) into num from bs_qxmx where sid = 'M00008' and action = '/exp/bidding/sell/kbqd' and method='show' and styp=1 and mkid ='M093010';
    if num=1 then
		update bs_qxmx set mkid='M093005' where sid = 'M00008' and action = '/exp/bidding/sell/kbqd' and method='show' and styp=1 and mkid ='M093010';
    end if;
    
    
    ----by linqingqing start----

    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do#/exp/bidding/buy/scaling/toJgTzs.do'
	    where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do'; 
	end if;

    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do#/exp/bidding/buy/scaling/toJgTzs.do'
	    where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do'; 
	end if;
------by linqingqing end----

	------------------资金管理 hanglong 2016-07-06  start---------------------
	num:=0;
    select count(1) into num from  bs_xtmk where sid='M00008' and mid='M0600'; 
    if num = 0 then
		insert into bs_xtmk(mid,mname,styp,ordby,sid)
		values('M0600', '资金管理', 1, 600, 'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0600' and mkid='M060010' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M060010','M0600','资金管理','我的资金','/exp/bidding/fund/index.do','/exp/bidding/fund/index.do',1,100,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/fund' and METHOD ='index' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060010','/exp/bidding/fund','index',2,'我的资金-首页',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0600' and mkid='M060020' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M060020','M0600','资金管理','会员账户','/exp/bidding/account/index.do','/exp/bidding/account/index.do',1,200,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/account' and METHOD ='index' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060020','/exp/bidding/account','index',2,'会员账户-首页',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mid='M0600' and mkid='M060030' and sid='M00008';
	if num = 0 then
		insert into bs_qxsz(mkid,mid,mname,name,url,inurl,isuse,orderno,styp,sid)
		values('M060030','M0600','资金管理','保证金账户','/exp/bidding/bondaccount/index.do','/exp/bidding/bondaccount/index.do',1,300,1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/bondaccount' and METHOD ='index' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M060030','/exp/bidding/bondaccount','index',2,'保证金账户-首页',1,'M00008');
	end if;


	------------------资金管理 hanglong 2016-07-06  start---------------------


	----------by linqingqing start 删除"邀请确认"---------
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M020030' and mid='M0200' and url='/exp/bidding/sell/invitation/doConfirmYqs.do' and inurl='/exp/bidding/sell/invitation/doConfirmYqs.do' and isuse=1 and orderno=150 and styp=1 and sid='M00008';
	if num=1 then
		delete from bs_qxsz where mkid='M020030' and mid='M0200' and url='/exp/bidding/sell/invitation/doConfirmYqs.do' and inurl='/exp/bidding/sell/invitation/doConfirmYqs.do' and isuse=1 and orderno=150 and styp=1 and sid='M00008';
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do#/exp/bidding/buy/scaling/toJgTzs.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do#/exp/bidding/buy/scaling/toJgTzs.do#/exp/bidding/buy/scaling/toHwTzs.do'
	    where sid='M00008' and mid='M0860' and mkid='M086050'and inurl='/exp/bidding/buy/scaling/toGcTzs.do#/exp/bidding/buy/scaling/tzsFS.do#/exp/bidding/buy/scaling/tzsQT.do#/exp/bidding/buy/scaling/tzsSave.do#/exp/bidding/buy/scaling/tzsTJ.do#/exp/bidding/buy/scaling/listjg.do#/exp/bidding/buy/scaling/toJgTzs.do'; 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'
	    where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do'; 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do'
	    where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do'; 
	end if;
	
	num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do'; 
    if num = 1 then
	    update bs_qxsz set inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do'
	    where sid='M00008' and mid='M0890' and mkid='M089096'and inurl='/exp/bidding/buy/gkys/toEdit.do#/exp/bidding/buy/gkys/toSave.do#//exp/bidding/buy/gkys/toUpdate.do#/exp/bidding/buy/gkys/toRelease.do#/exp/bidding/buy/gkys/tocomnext.do#//exp/bidding/buy/gkys/toDownload.do#/exp/bidding/buy/release/view.do#/exp/bidding/buy/result/edit.do#/exp/bidding/buy/gkys/packlist.do#/exp/bidding/buy/gkys/tonotTg.do#/exp/bidding/buy/gkys/toTg.do'; 
	end if;
	
	----------by linqingqing end---------
	
	---add by xuz start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/prefic' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089005','/exp/bidding/buy/prefic','download',2,'下载附件',1,'M00008');
	end if;
	---add by xuz end---

	---add by zyy start---
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/gkys' and METHOD ='toTg' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089096','/exp/bidding/buy/gkys','toTg',2,'发送代资格审核通知书页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/buy/gkys' and METHOD ='tonotTg' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M089096','/exp/bidding/buy/gkys','tonotTg',2,'发送资格预审通知书页面',1,'M00008');
	end if;
	
	num:=0;
	select count(1) into num from bs_qxsz where mkid='M089096' and sid='M00008' and mid='M0890' and instr(inurl,'/exp/bidding/buy/gkys/toTg.do')>0;
	if num=0 then
		update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/gkys/toTg.do') where  mkid='M089096' and sid='M00008' and mid='M0890';
	end if;
	---add by zyy end---
	
	num:=0;
	select count(1) into num from bs_qxmx where ACTION='/exp/bidding/sell/bidding' and METHOD ='download' and STYP=1 and SID='M00008';
	if num = 0 then
		insert into bs_qxmx(mkid,action,method,accesstag,remark,styp,sid)
		values('M092005','/exp/bidding/sell/bidding','download',2,'下载附件',1,'M00008');
	end if;
	
	-----chenxp start-----
   
   --正在项目
   num:=0;
   select instr(inurl,'/exp/bidding/buy/beingPro/list.do') into num from bs_qxsz where sid = 'M00008' and mkid='M030020' and mid='M0300';
   if num = 1 then
    	 update bs_qxsz set inurl='/exp/bidding/buy/beingPro/list.do' where  sid = 'M00008' and mkid='M030020' and mid='M0300';
  	end if;
    
   --招标委托
   num:=0;
   select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081040' and mid='M0810';
   if num = 0 then 
         insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ,qxrole) 
         values('M081040', 'M0810', '招标方案', '招标委托', '/exp/bidding/buy/beingPro/viewEntrust.do', '/exp/bidding/buy/beingPro/viewEntrust.do' , 1,230, 1, 'M00008',1);
   end if;
   
   select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081040' and mid='M0810';
   if num = 1 then 
        update bs_qxsz set url='/exp/bidding/buy/beingPro/viewEntrust.do' ,inurl='/exp/bidding/buy/beingPro/viewEntrust.do' where  sid = 'M00008' and mkid='M081040' and mid='M0810';
   end if;
  
   num:=0;
   select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='viewEntrust';
   if num = 1 then
      update bs_qxmx set mkid='M081040' where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='viewEntrust';
  	end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='trustReceipt';
  	if num = 1 then
    	 update bs_qxmx set mkid='M081040' where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='trustReceipt';
  	end if;
    
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='saveTrustReceipt';
  	if num = 1 then
    	 update bs_qxmx set mkid='M081040' where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='saveTrustReceipt';
  	end if;
    
    
    num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/trustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081040' and mid='M0810';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/trustReceipt.do') where  sid = 'M00008' and mkid='M081040' and mid='M0810';
  	end if;
   
   
    num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/saveTrustReceipt.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081040' and mid='M0810';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/saveTrustReceipt.do') where  sid = 'M00008' and mkid='M081040' and mid='M0810';
  	end if;
    
   --委托协议签订
   num:=0;
   select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081045' and mid='M0810';
   if num = 0 then 
         insert into bs_qxsz(mkid, mid, mname, name,url,inurl,  isuse, orderno,styp,  sid ,qxrole) 
         values('M081045', 'M0810', '招标方案', '委托协议签订', '/exp/bidding/buy/beingPro/editwtxy.do', '/exp/bidding/buy/beingPro/editwtxy.do' , 1,260, 1, 'M00008',1);
   end if;
   
   num:=0;
   select count(1) into num from bs_qxsz where sid = 'M00008' and mkid='M081045' and mid='M0810';
   if num = 1 then 
        update bs_qxsz set url='/exp/bidding/buy/beingPro/editwtxy.do', inurl='/exp/bidding/buy/beingPro/editwtxy.do' where  sid = 'M00008' and mkid='M081045' and mid='M0810';
   end if;
   
  
   	num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='editwtxy';
  	if num = 1 then
        update bs_qxmx set mkid='M081045' where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='editwtxy';
 	  end if;
    
    num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'   and method='savewtxy';
  	if num = 1 then
    	update bs_qxmx set mkid='M081045' where  action='/exp/bidding/buy/beingPro' and sid = 'M00008'  and method='savewtxy';
  	end if;
    
    
    num:=0;
  	select instr(inurl,'/exp/bidding/buy/beingPro/savewtxy.do') into num from bs_qxsz where sid = 'M00008' and mkid='M081045' and mid='M0810';
  	if num = 0 then
     	update bs_qxsz set inurl=concat(inurl,'#/exp/bidding/buy/beingPro/savewtxy.do') where  sid = 'M00008' and mkid='M081045' and mid='M0810';
  	end if;
    
   -----chenxp end-------	
	    ----权限明细
        num:=0;
  	select count(1) into num from bs_qxmx where  action='/exp/bidding/sell/invitation' and mkid='M020005' and sid = 'M00008'   and method='doQztj';
  	if num = 0 then
	insert into bs_qxmx(mkid, action, method, accesstag,remark,styp,sid) 
        values('M020005', '/exp/bidding/sell/invitation', 'doQztj', 2, '投标邀请-签章提交', 1,'M00008');
 
  	end if;

    ----权限设置修改
    num:=0;
    select count(1) into num from  bs_qxsz where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'; 
    if num = 1 then
    update bs_qxsz set inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do#/exp/bidding/sell/invitation/doQztj.do'
    where sid='M00008' and mid='M0200' and mkid='M020005'and inurl='/exp/bidding/sell/invitation/list.do#/exp/bidding/sell/invitation/toConfirmYqs.do#/exp/bidding/sell/invitation/doConfirmYqs.do'; 
 end if;

    -- 以下不允许出现升级SQL
    -------------------------------------------------------------
    P_VERSION(SYSID=>'BS',NEWVERSION=>CURVERSION,REF_MSG=>MSG,OPT=>1); -- 更新数据中的版本信息
    COMMIT;
END;  
