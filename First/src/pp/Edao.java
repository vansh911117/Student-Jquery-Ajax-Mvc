package pp;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;  
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

public class Edao {
private JdbcTemplate template;


public JdbcTemplate getTemplate() {
	return template;
}

public void setTemplate(JdbcTemplate template) {
	this.template = template;
}

public int addEmp(Emp emp)
{
	/*String sql = "insert into emp values(?,?)";
	Object object[] = new Object[]{emp.getName(), emp.getPassword()};
	return template.update(sql, object);*/ 
	return template.update("", new PreparedStatementSetter() {
		
		@Override
		public void setValues(PreparedStatement ps) throws SQLException {
			ps.setString(1, emp.getName());
			ps.setString(2, emp.getPassword());
		}
	});
	
}

@SuppressWarnings("deprecation")
public List<Emp> searchEmp(String name,String password)
{
	Object []obj=new Object[] {name,password};
	return template.query("select * from emp where name=? and password=?", obj, new ResultSetExtractor<List<Emp>>() {
		List<Emp> list=new ArrayList<>();
		
		@Override
		public List<Emp> extractData(ResultSet rs) throws SQLException, DataAccessException {
			while(rs.next())
			{
				Emp emp=new Emp();
				emp.setName(rs.getString("name"));
				emp.setPassword(rs.getString("password"));
				list.add(emp);
			}
			return list;
		}
	});
}

public int deleteStudent(int id)
{
	return template.update("delete from student where id=?", new PreparedStatementSetter() {
		
		@Override
		public void setValues(PreparedStatement ps) throws SQLException {
			ps.setInt(1, id);
		}
	});
}

public int updateStudent(Student student)
{
	return template.update("update student set name=?,email=?,mobile=?,clas=? where id=? ", new PreparedStatementSetter() {
		
		@Override
		public void setValues(PreparedStatement preparedstatement) throws SQLException {
			preparedstatement.setString(1, student.getName());
			preparedstatement.setString(2, student.getEmail());
			preparedstatement.setString(3, student.getMobile());
			preparedstatement.setInt(4, student.getClas());
			preparedstatement.setInt(5, student.getId());
		}
	});
}

public void saveAll(List<Student> students) {
    String sql = "INSERT INTO student VALUES ( ?, ?, ?, ?, ?)";

    template.batchUpdate(sql, new BatchPreparedStatementSetter() {
        @Override
        public void setValues(PreparedStatement preparedStatement, int i) throws SQLException {
            Student student = students.get(i);
            preparedStatement.setInt(1, student.getId());
            preparedStatement.setString(2, student.getName());
            preparedStatement.setString(3, student.getMobile());
            preparedStatement.setString(4, student.getEmail());
            preparedStatement.setInt(5, student.getClas());
        }

        @Override
        public int getBatchSize() {
            return students.size();
        }
    });
}
@SuppressWarnings("deprecation")
public List<Student> showsStudent(String clasname,String keyword, int pageno)
{
	if(clasname.equalsIgnoreCase("null") || clasname.equalsIgnoreCase("clas")){
	String sql = "SELECT * FROM student WHERE id LIKE ? OR name LIKE ? OR mobile LIKE ? OR email LIKE ? OR clas LIKE ? limit "+pageno+",11";
    System.out.println(sql+" upr wali");
	StringBuilder builder = new StringBuilder();
    builder.append("%");
    builder.append(keyword);
    builder.append("%");
    return template.query(sql, new Object[]{builder,builder,builder,builder,builder},
            new StudentRowMapper());
	}else{
		String sql = "SELECT * FROM student WHERE (id LIKE ? OR name LIKE ? OR mobile LIKE ? OR email LIKE ? )AND clas =? limit "+pageno+",11";
	   System.out.println(sql+" niche wali");
		StringBuilder builder = new StringBuilder();
	    builder.append("%");
	    builder.append(keyword);
	    builder.append("%");
	    return template.query(sql, new Object[]{builder,builder,builder,builder,clasname},
	            new StudentRowMapper());
	}
}

public int count(String keyword,String selectedoption)
{
	if(selectedoption.equalsIgnoreCase("null") || selectedoption.equalsIgnoreCase("clas")){
    String sql = "SELECT COUNT(*) FROM student WHERE id LIKE ? OR name LIKE ? OR mobile LIKE ? OR email LIKE ? OR clas LIKE ?";
    StringBuilder builder = new StringBuilder();
    builder.append("%");
    builder.append(keyword);
    builder.append("%");
    return template.queryForObject(sql,new Object[]{builder,builder,builder,builder,builder}, Integer.class);
	}else
	{
		String sql = "SELECT COUNT(*) FROM student WHERE (id LIKE ? OR name LIKE ? OR mobile LIKE ? OR email LIKE ?) And clas = ?";
	    StringBuilder builder = new StringBuilder();
	    builder.append("%");
	    builder.append(keyword);
	    builder.append("%");
	    return template.queryForObject(sql,new Object[]{builder,builder,builder,builder,selectedoption}, Integer.class);
	}
}

private static class StudentRowMapper implements RowMapper<Student> {
    public Student mapRow(ResultSet resultSet, int rowNum) throws SQLException {
        Student Student = new Student();
        Student.setId(resultSet.getInt("id"));
        Student.setName(resultSet.getString("name"));
        Student.setMobile(resultSet.getString("mobile"));
        Student.setEmail(resultSet.getString("email"));
        Student.setClas(resultSet.getInt("clas"));
        return Student;
    }
}





}
 
	

	

	