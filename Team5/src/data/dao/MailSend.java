package data.dao;

import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class MailSend {
   
   public static String RandomPass() {
      Random rnd =new Random();

      StringBuffer buf =new StringBuffer();

      for(int i=0;i<10;i++){

          // rnd.nextBoolean() 는 랜덤으로 true, false 를 리턴. true일 시 랜덤 한 소문자를, false 일 시 랜덤 한 숫자를 StringBuffer 에 append 한다.

          if(rnd.nextBoolean()){

              buf.append((char)((int)(rnd.nextInt(26))+97));

          }else{

              buf.append((rnd.nextInt(10)));
          }
      }
      
      return buf.toString();
      
   }   
   
   public static String naverMailSend(String email) {
      String host = "smtp.naver.com"; // 네이버일 경우 네이버 계정, gmail경우 gmail 계정
      String user = "acorn555@naver.com"; // 패스워드
      String password = "osklj1234!@";
      String newPass = RandomPass();
      
      // SMTP 서버 정보를 설정한다.
      Properties props = new Properties();
      props.put("mail.smtp.host", host);
      props.put("mail.smtp.port", 587);
      props.put("mail.smtp.auth", "true");
      Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
               return new javax.mail.PasswordAuthentication(user, password);
            }
      }); 
      
      try {
         MimeMessage message = new MimeMessage(session);
         message.setFrom(new InternetAddress(user));
         message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
         
         // 메일 제목
         message.setSubject("라봉펜션 임시비밀번호 발송");
         
         // 메일 내용
         message.setText(newPass);
         
         // send the message
         Transport.send(message);
         //System.out.println("Success Message Send");
         return newPass;
      } catch (MessagingException e) {
         e.printStackTrace();
      }
      
      return null;
   }      
      
}