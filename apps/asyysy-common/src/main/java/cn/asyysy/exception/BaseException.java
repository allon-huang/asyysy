package cn.asyysy.exception;

import lombok.Data;

/**
 * BaseException 封装异常类
 */
@Data
public class BaseException extends RuntimeException {

    private String message;
    private int code = 500;

    public BaseException(String message){
        super(message);
        this.message = message;
    }

    public BaseException(String message, Throwable e){
        super(message,e);
        this.message = message;
    }

    public BaseException(String message, int code){
        super(message);
        this.message = message;
        this.code = code;
    }

    public BaseException(String message, int code, Throwable e){
        super(message,e);
        this.message = message;
        this.code = code;
    }
}
