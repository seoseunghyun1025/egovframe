package egovframework.email.dto;

import lombok.Data;

@Data
public class PasswordVerificationRequest {
	private String email;
	private String tempPassword;
}
