package modelo.control;

import javax.mail.*;
import javax.mail.internet.*;
import java.util.Properties;

public class EnviarCorreo {
 
    private String correoDestino = new String();
    private String asuntoMsg = new String();
    private String mensaje = new String();

    final String miCorreo = "digitalgameinfo@gmail.com";   //User name of the Goole(gmail) account
    final String contraCorreo = "0905141996";  //Password of the Goole(gmail) account
    //final String FROM_ADDRESS = "digitalgameinfo@gmail.com";  //From addresss
 
    public EnviarCorreo() {
    }


    public void createAndSendEmail(String correoDestino, String asuntoMsg, String mensaje) {
        this.correoDestino = correoDestino;
        this.asuntoMsg = asuntoMsg;
        this.mensaje = mensaje;
        sendEmailMessage();
    }
  
    private void sendEmailMessage() {
     
     //Create email sending properties
     Properties props = new Properties();
     props.put("mail.smtp.host", "smtp.gmail.com"); 
		props.put("mail.smtp.port", "25"); 
		props.put("mail.debug", "false"); 
		props.put("mail.smtp.auth", "true"); 
		props.put("mail.smtp.starttls.enable","true"); 
		props.put("mail.smtp.EnableSSL.enable","true");

		props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		props.setProperty("mail.smtp.socketFactory.fallback", "false");   
		props.setProperty("mail.smtp.port", "465");   
		props.setProperty("mail.smtp.socketFactory.port", "465"); 
     
  
    Session session = Session.getInstance(props,
    new javax.mail.Authenticator() {
    protected PasswordAuthentication getPasswordAuthentication() {
    return new PasswordAuthentication(miCorreo, contraCorreo);
   }
    });

  try {

     Message message = new MimeMessage(session);
     message.setFrom(new InternetAddress(miCorreo)); //Set from address of the email
     message.setContent(mensaje,"text/html"); //set content type of the email
     
    message.setRecipients(Message.RecipientType.TO,InternetAddress.parse(correoDestino)); //Set email recipient
    
    message.setSubject(asuntoMsg); //Set email message subject
    Transport.send(message); //Send email message

   System.out.println("Correo Enviado Correctamente!");

  } catch (MessagingException e) {
       throw new RuntimeException(e);
  }
    }

    public void setcorreoDestino(String correoDestino) {
        this.correoDestino = correoDestino;
    }

    public void setSubject(String subject) {
        this.asuntoMsg = subject;
    }

    public void setMessageText(String mensaje) {
        this.mensaje = mensaje;
    }
  
}
