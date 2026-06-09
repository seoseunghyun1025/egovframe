package egovframework.email.serivce;

import jakarta.mail.internet.MimeMessage;

public interface EmailService {
	String createTemoraryPassword(String email) throws Exception;
	
	boolean verifyTemporaryPassword(String email, String tempPassword) throws Exception;
	
	void sendTemporaryPasswordEmail(String email, String tempPassword);
	
	MimeMessage createEmail(String email);
	
	boolean verifyCode(String email, int code);
}