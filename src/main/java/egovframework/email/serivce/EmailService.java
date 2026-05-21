package egovframework.email.serivce;

public interface EmailService {
	String createTemoraryPassword(String email) throws Exception;
	
	boolean verifyTemporaryPassword(String email, String tempPassword) throws Exception;
	
	void sendTemporaryPasswordEmail(String email, String tempPassword);
}
