package egovframework.role.enums;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
public @interface Auth{
	Role[] role();
	
	@Getter
	@RequiredArgsConstructor
	enum Role{
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
}
/*
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
*/