package egovframework.role.enums;

import org.springframework.core.convert.converter.Converter;

import egovframework.role.enums.Auth.Role;

public class StringToRoleConverter implements Converter<String, Role> {
    @Override
    public Role convert(String source) {
        if (source == null || source.isEmpty()) {
            return null;
        }
        
        return Role.fromKey(source);
    }
}
