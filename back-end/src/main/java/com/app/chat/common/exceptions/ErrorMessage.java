package com.app.chat.common.exceptions;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ErrorMessage {

    private int statusCode;

    private String message;

    public ErrorMessage() {
    }

    public static ErrorMessage fromApiException(ApiException exception){
        ErrorMessage errorMessage = new ErrorMessage();
        errorMessage.message = exception.getMessage();
        errorMessage.statusCode = exception.getHttpStatus().value();
        return errorMessage;
    }

}
