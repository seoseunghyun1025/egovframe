package egovframework.role.enums;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedTypes;
import org.apache.ibatis.type.TypeHandler;

import egovframework.role.enums.Auth.Role;

@MappedTypes(Role.class)
public class RoleTypeHandler implements TypeHandler<Role> {

	@Override
	public void setParameter(PreparedStatement ps, int i, Role parameter, JdbcType jdbcType) throws SQLException {
		// TODO Auto-generated method stub
		ps.setString(i, parameter.getKey());
	}

	@Override
	public Role getResult(ResultSet rs, String columnName) throws SQLException {
		// TODO Auto-generated method stub
		String roleKey = rs.getString(columnName);
		return getRole(roleKey);
	}

	@Override
	public Role getResult(ResultSet rs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		String roleKey = rs.getString(columnIndex);
        return getRole(roleKey);		
	}

	@Override
	public Role getResult(CallableStatement cs, int columnIndex) throws SQLException {
		// TODO Auto-generated method stub
		String roleKey = cs.getString(columnIndex);
		return getRole(roleKey);
	}
	
	private Role getRole(String roleKey) {
        Role role = null;
        switch (roleKey) {
        case "ROLE_USER":
            role = Role.USER;
            break;

        default:
            role = Role.ADMIN;
            break;
        }
        return role;
    }
}