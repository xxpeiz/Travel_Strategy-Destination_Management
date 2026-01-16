package com.tools;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;

public class FileUpload {

    //作用：混合上传 文件  普通数据
    // IO流 文件 写入到指定为止
    // 服务器发布路径中，路径 + 文件名称
    // 1.地址上  2.信息 存储数据库  ， 得到

    // list map
    public static HashMap<String, Object> getValues(HttpServletRequest request){

        //创建MAp 临时 数据
        HashMap<String, Object> map = new HashMap<>();

        try {
            request.setCharacterEncoding("utf-8");
            //1.磁盘文件项工厂，接受刚刚提交的数据
            DiskFileItemFactory factory = new DiskFileItemFactory();
            //2.服务文件应用上传，解析factory缓存的数据
            ServletFileUpload upload = new ServletFileUpload(factory);

            //3.文件迭代器，upload对象  得到 访问每一个数据的能力
            FileItemIterator itemIterator = upload.getItemIterator(request);

            //4.文件项流，取出的每一个数据  都是一个文件项流
            while (itemIterator.hasNext()){
                //文件 输出流，读写到每一个文件
                FileItemStream stream = itemIterator.next();

                //输出流 读取的是  file
                InputStream inputStream = stream.openStream();

                // form表单  name属性 -- key值    value -- 输入的数据
                // Map集合  存储 最合理
                //key
                String key = stream.getFieldName();


                //区分，  账号 密码  得到value值 就行  但是  文件  上传

                if (stream.isFormField()){
                    //字节流 转为 字符流
                    //字符输入流，得到字符数据
                    InputStreamReader reader = new InputStreamReader(inputStream, "utf-8");

                    //缓冲流 ？？？   IO  提高读写效率
                    BufferedReader bufferedReader = new BufferedReader(reader);

                    String data = bufferedReader.readLine();

                    // 普通数据，文本
                    map.put(key,data);

                }else {
                    //刚刚怎么写的，就怎么写

                    //加一个时间戳
                    String time = DateTimeFormatter.ofPattern("yyyyMMddHHmmss").format(LocalDateTime.now());

                    if (stream.getName() != ""){
                        String fileName = "测试图片_" + time + "_" + stream.getName();

                        map.put(key,fileName);

                        //得到文件 上传地址，out文件下
                        String url = request.getSession().getServletContext().getRealPath("png");

                        map.put("url",url);

                        File file = new File(url + "\\" + fileName);

                        //输出流
                        FileOutputStream outputStream = new FileOutputStream(file);

                        //1byte  创建 字节数组 1024byte
                        byte[] bytes = new byte[1024];
                        int size;

                        //IO对写
                        while ( (size = inputStream.read(bytes)) != -1 ){
                            outputStream.write(bytes,0,size);
                        }
                        outputStream.close();
                    }else {
                        // 没有上传文件
                        map.put(key," ");
                    }
                    inputStream.close();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }
        return map;
    }
}
