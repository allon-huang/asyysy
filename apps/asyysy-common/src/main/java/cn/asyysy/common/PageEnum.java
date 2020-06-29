package cn.asyysy.common;

//import lombok.Getter;
//import lombok.ToString;

/**
 * 页面枚举
 */
//@ToString
//@Getter
public enum PageEnum {
    /**
     * 首页
     */
    INDEX("index", "/index", "首页");
    

    /**
     * 路径
     */
    private String path;
    /**
     * 页面
     */
    private String page;
    /**
     * 页面备注
     */
    private String remark;


    PageEnum(String path, String page, String remark) {
        this.path = path;
        this.page = page;
        this.remark = remark;
    }
}
