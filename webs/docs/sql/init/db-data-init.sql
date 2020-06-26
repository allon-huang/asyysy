drop procedure if exists P_IM_UPGRADE;

delimiter $$

CREATE PROCEDURE P_IM_UPGRADE()
RUN_LABEL:
begin
    -- mysql升级版本
    set @num=0;
    select count(0) into @num from sys_info ;
    if @num = 0 then
        insert into sys_info values ('00000',0.001,sysdate());
    end if;

    set @num=0;
    select count(0) into @num from short_url where short_code = '111';
    if @num = 0 then
        insert into
            short_url(short_url,long_url,short_code,c_date,redirct_time)
        values ('D_111','http://www.asyysy.cn','111',sysdate(),0);
    end if;

    set @num=0;
    select count(0) into @num from wx_reply_model where keyword = '微信';
    if @num = 0 then
        insert into
            wx_reply_model(type,keyword,reply_text,send_sum,create_time)
        values ('text','微信','<a href="http://support.weixin.qq.com/cgi-bin/mmsupport-bin/readtemplate?t=page/android_exp__index">--->>申请微信内测版本客户端</a>',0,sysdate());
    end if;

end
$$
CALL P_IM_UPGRADE();