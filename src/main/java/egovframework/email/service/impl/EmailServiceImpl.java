package egovframework.email.service.impl;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import egovframework.email.serivce.EmailService;
import egovframework.member.dto.Member;
import egovframework.member.service.impl.MemberMapper;
import jakarta.annotation.Resource;
import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;

@Service("emailService")
@RequiredArgsConstructor
public class EmailServiceImpl implements EmailService {
	
	private final JavaMailSender javaMailSender;
	
	private static final String senderEmail = "seunghyun.seo101@gmail.com";
	
	private static final Map<String, Integer> verificationCodes = new HashMap<>();
	
	@Resource(name = "bcryptPasswordEncoder")
    private BCryptPasswordEncoder encoder;
	
	@Resource(name="memberMapper")
    private MemberMapper memberMapper;
	
	private static String generateRandomPassword() {
        int length = 8;
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

        for (int i = 0; i < length; i++) {
            sb.append(characters.charAt(random.nextInt(characters.length())));
        }
        
        return sb.toString();
    }
	
	@Override
	public String createTemoraryPassword(String email) throws Exception {
		// TODO Auto-generated method stub
		String tempPassword = generateRandomPassword();
		
		Member member = null;
		try {
			member = memberMapper.select(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("존재하지 않는 메일입니다.");
		}
		
		member.setPassword(encoder.encode(tempPassword));
		
		try {
			memberMapper.update(member);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("비밀번호를 수정할 수 없습니다.");
		}
        return tempPassword;
	}

	//임시 비밀번호 검증
	@Override
	public boolean verifyTemporaryPassword(String email, String tempPassword) throws Exception {
		// TODO Auto-generated method stub
		
		Member member = null;
		try {
			member = memberMapper.select(email);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new Exception("아이디를 찾을 수 없습니다.");
		}
		
	    return encoder.matches(tempPassword, member.getPassword());
	}

	@Override
	public void sendTemporaryPasswordEmail(String email, String tempPassword) {
		// TODO Auto-generated method stub
		MimeMessage message = javaMailSender.createMimeMessage();
        try {
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
            helper.setFrom(senderEmail);
            helper.setTo(email);
            helper.setSubject("investment 임시 비밀번호");
            String body = "<h2>investment에 오신걸 환영합니다!</h2><p>아래의 임시 비밀번호를 사용하세요.</p><h1>" + tempPassword + "</h1><h3>반드시 비밀번호를 재설정하세요.</h3>";
            helper.setText(body, true);
            javaMailSender.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException("임시 비밀번호 전송 오류", e);
        }
	}

}
