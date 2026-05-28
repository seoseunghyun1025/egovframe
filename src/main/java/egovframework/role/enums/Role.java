package egovframework.role.enums;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public enum Role{
	ADMIN("ROLE_ADMIN", "관리자"),
	USER("ROLE_USER", "사용자");
	
	private final String key;
	private final String title;
	
	public static Role fromKey(String key) {
		for (Role role : Role.values()) {
			if (role.getKey().equals(key)) {
				return role;
			}
		}
		return Role.USER;
	}
}
