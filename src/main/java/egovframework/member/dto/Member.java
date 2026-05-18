package egovframework.member.dto;

import java.time.LocalDateTime;

import egovframework.member.exception.WrongIdPasswordException;

public class Member {
	
	private Long memberId;
	private String email;
	private String password;
	private String name;
	private LocalDateTime registerDateTime;
	
	public Member(String email, String password, String name, LocalDateTime registerDateTime) {
		this.email = email;
		this.password = password;
		this.name = name;
		this.registerDateTime = registerDateTime;
	}
	
	
	
	public Long getMemberId() {
		return memberId;
	}



	public void setMemberId(Long memberId) {
		this.memberId = memberId;
	}



	public String getEmail() {
		return email;
	}



	public String getPassword() {
		return password;
	}



	public String getName() {
		return name;
	}



	public LocalDateTime getRegisterDateTime() {
		return registerDateTime;
	}



	public void changePassword(String oldPassword, String newPassword) {
		if(!password.equals(oldPassword)) throw new WrongIdPasswordException();
		this.password = newPassword;
	}
}
