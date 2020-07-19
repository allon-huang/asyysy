package cn.asyysy.asyysy.app.model;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.baomidou.mybatisplus.activerecord.Model;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author huangyaoyu
 * @since 2020-03-11
 */
public class Cron extends Model<Cron> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "cron_id", type = IdType.AUTO)
    private String cronId;
    private String cron;


    public String getCronId() {
        return cronId;
    }

    public void setCronId(String cronId) {
        this.cronId = cronId;
    }

    public String getCron() {
        return cron;
    }

    public void setCron(String cron) {
        this.cron = cron;
    }

    @Override
    protected Serializable pkVal() {
        return this.cronId;
    }

    @Override
    public String toString() {
        return "Cron{" +
        "cronId=" + cronId +
        ", cron=" + cron +
        "}";
    }
}
