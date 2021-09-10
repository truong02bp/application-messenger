package com.app.chat.services.impl;

import com.app.chat.services.MailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import java.util.Random;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private JavaMailSender javaMailSender;

    @Override
    public String sendOtp(String name, String email) {
        SimpleMailMessage message = new SimpleMailMessage();
        Random random = new Random();
        String otp = String.valueOf(random.nextInt(8999) + 1000);
        message.setFrom("Người trồng cà chua");
        message.setTo(email);
        message.setSubject("Hi " + name + ", you have notification");
        String content = "Hi " + name + "\n" + "Your otp code is : " + otp;
        message.setText(content);
        javaMailSender.send(message);
        return otp;
    }
}
