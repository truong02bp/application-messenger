package com.app.chat.common.exceptions;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@RestControllerAdvice
public class ExceptionHandlerConfig {

    @ExceptionHandler(ApiException.class)
    ResponseEntity<ErrorMessage> apiException(ApiException e)
    {
        return ResponseEntity.ok(ErrorMessage.fromApiException(e));
    }

}
