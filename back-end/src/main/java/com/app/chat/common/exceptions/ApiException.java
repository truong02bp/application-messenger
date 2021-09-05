package com.app.chat.common.exceptions;

import lombok.NoArgsConstructor;
import org.springframework.http.HttpStatus;

@NoArgsConstructor
public class ApiException extends RuntimeException {

    private String message;

    private HttpStatus httpStatus;

    public static ApiException builder(){
        return new ApiException();
    }

    public ApiException httpStatus(HttpStatus status){
        this.httpStatus = status;
        return this;
    }

    public ApiException message(String message){
        this.message = message;
        return this;
    }

    @Override
    public String getMessage() {
        return message;
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
