package egovframework.email.dto;

import lombok.Data;

@Data
public class EmailVerificationRequest {
	 private String email;
	 private int code;
}
