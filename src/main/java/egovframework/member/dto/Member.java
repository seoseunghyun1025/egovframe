package egovframework.member.dto;

import java.time.LocalDateTime;

import egovframework.member.exception.WrongIdPasswordException;
import egovframework.role.enums.Auth.Role;
import lombok.NoArgsConstructor;

@NoArgsConstructor
public class Member {
	
	private Long memberId;
	private String email;
	private String password;
	private String name;
	private LocalDateTime registerDateTime;
	private Role role;
		
	
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



	public void setEmail(String email) {
		this.email = email;
	}



	public void setPassword(String password) {
		this.password = password;
	}



	public void setName(String name) {
		this.name = name;
	}



	public void setRegisterDateTime(LocalDateTime registerDateTime) {
		this.registerDateTime = registerDateTime;
	}



	public Role getRole() {
		return role;
	}



	public void setRole(Role role) {
		this.role = role;
	}
}
