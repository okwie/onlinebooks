package com.booksonline.web.util;
import java.io.File;
import java.io.IOException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.booksonline.model.Books;
@Component
public class HandleFiles {
	
	

	 //save file to locale file system
	public void saveImage(Books book) throws IllegalStateException, IOException {
	    try {
		    // save directory
		    String destDir = "C:\\Tutorials\\images\\books\\"+book.getId()+"";                        
		    //initalize file
			File dir = new File(destDir);
			//if folder does not exist create it
			if(!dir.exists()){                                     
				new File(destDir).mkdirs();                                        
			}
			//get file from form
			MultipartFile multipartFile = (MultipartFile) book.getFile(); 
			//set folder to save file system 
			File file = new File(destDir+"/"+ multipartFile.getOriginalFilename());
			//save to file system
			multipartFile.transferTo(file);
		} catch (Exception e) {
			e.printStackTrace();
		}
	 
	   }
	   
	public void removefiles(String image, long id) {
	try {
		File file = new File("C:\\Tutorials\\images\\books\\"+id+"\\"+image+"");    
		    if(file.delete()){
		System.out.println(file.getName() + " is deleted!");	
		    }
	else{
		System.out.println("Delete operation is failed.");
			}
		} 
	catch (Exception e) {
		e.printStackTrace();
			}
	}
    @Autowired
    public JavaMailSender sender;
 
    public String sendMail(String to, String msg, String subject) {
        MimeMessage message = sender.createMimeMessage();
        MimeMessageHelper helper = new MimeMessageHelper(message);
        try {
            helper.setTo(to);
            helper.setText(msg);
            helper.setSubject(subject);
        } catch (MessagingException e) {
            e.printStackTrace();
            return "Error while sending mail ..";
        }
        sender.send(message);
        return "Mail Sent Success!";
    }
}
