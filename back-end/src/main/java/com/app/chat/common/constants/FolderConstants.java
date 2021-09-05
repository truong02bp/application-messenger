package com.app.chat.common.constants;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class FolderConstants {
    private static String time = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")).replaceAll("-", "");
    public static final String IMAGES_FOLDER = "/images/" + time + "/";
    public static final String FILE_FOLDER = "/file/" + time + "/";
    public static final String STICKER_FOLDER = "/sticker/" + time + "/";
    public static final String DEFAULT_FOLDER = "/" + time + "/";

}
