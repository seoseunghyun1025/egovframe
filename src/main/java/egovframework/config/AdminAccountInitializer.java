package egovframework.config;

import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import egovframework.role.enums.Auth.Role;
import jakarta.annotation.PostConstruct;
import egovframework.member.dto.Member;
import egovframework.member.dto.Register;
import egovframework.member.service.impl.MemberMapper; 

@Component("adminAccountInitializer")
@RequiredArgsConstructor 
public class AdminAccountInitializer {

    private final MemberMapper memberMapper;
    private final PasswordEncoder encoder;

    @PostConstruct
    public void initAdminUser() {
        try {
            String adminEmail = "admin@investment.com";
            
            Member member = memberMapper.select(adminEmail);
            
            if (member == null) {
                Register admin = new Register();
                admin.setEmail(adminEmail);
                admin.setPassword(encoder.encode("admin1234")); // 비밀번호 암호화
                admin.setName("관리자");                
                admin.setRole(Role.ADMIN); 
                
                memberMapper.regist(admin);
            }
            
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}