package cn.asyysy.app.model.common;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import java.io.Serializable;

/**
 * api返回结果响应实体类
 * @author hyy
 */
@ApiModel(value = "api返回结果响应实体类", description = "api返回结果响应实体类")
public class ApiResponse implements Serializable {

    /**
     * 序列化
     */
    private static final long serialVersionUID = -5178560042946902578L;
    /**
     * 成功类型
     */
    private static final String SUCCESS_TYPE = "SUCCESS";
    /**
     * 失败类型
     */
    private static final String FAIL_TYPE = "FAIL";
    /**
     * 没有数据提示
     */
    private static final String NO_DATA = "NO DATA";
    /**
     * 成功信息
     */
    private static final String SUCCESS_MSG = "REQUEST SUCCESS";
    /**
     * 失败信息
     */
    private static final String FAIL_MSG = "REQUEST FAIL";
    /**
     * 类型
     */
    private String type;
    /**
     * 信息
     */
    private String msg;
    /**
     * 数据
     */
    private Object data;

    /**
     * 私有化构造方法
     */
    private ApiResponse() {
    }

    /**
     * 重写toString
     */
    @Override
    public String toString() {
        return "ApiResponse [type=" + type + ", msg=" + msg + ", data=" + data + "]";
    }

    /**
     *
     * @Title: SUCCESS
     * @Description: 成功返回,包含信息和数据
     * @param msg
     * @param data
     * @return
     */
    public static ApiResponse SUCCESS(String msg, Object data) {
        ApiResponse response = new ApiResponse();
        response.setType(SUCCESS_TYPE);
        response.setMsg(msg);
        response.setData(data);
        return response;
    }

    /**
     *
     * @Title: SUCCESS
     * @Description: 成功返回,只包含信息
     * @param msg
     * @return
     */
    public static ApiResponse SUCCESS(String msg) {
        return SUCCESS(msg, NO_DATA);
    }

    /**
     *
     * @Title: SUCCESS
     * @Description: 成功返回,只包含数据
     * @param data
     * @param clazz
     * @return
     */
    public static ApiResponse SUCCESS(Object data, Class<?> clazz) {
        return SUCCESS(SUCCESS_MSG, data);
    }

    /**
     *
     * @Title: ERROR
     * @Description: 失败返回,包含信息和数据
     * @param msg
     * @param data
     * @return
     */
    public static ApiResponse ERROR(String msg, Object data) {
        ApiResponse response = new ApiResponse();
        response.setType(FAIL_TYPE);
        response.setMsg(msg);
        response.setData(data);
        return response;
    }

    /**
     *
     * @Title: ERROR
     * @Description: 失败返回,只包含信息
     * @param msg
     * @return
     */
    public static ApiResponse ERROR(String msg) {
        return ERROR(msg, NO_DATA);
    }

    /**
     *
     * @Title: ERROR
     * @Description: 失败返回,只包含数据
     * @param data
     * @param clazz
     * @return
     */
    public static ApiResponse ERROR(Object data, Class<?> clazz) {
        return ERROR(FAIL_MSG, data);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }
}
