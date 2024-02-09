package pp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
@Controller
public class MyController {
	@Autowired
	Edao edao;

	@RequestMapping("/login")
	public String login(@RequestParam("name")String userName,@RequestParam("password")String password,Emp e,Model m)
	{
		List<Emp> isValid = null;
		try {
			isValid = edao.searchEmp(e.getName(), e.getPassword());
		} catch (Exception e2) {
			isValid = null;
		}
		
		if(isValid.isEmpty())
		{
			String msg="Sorry "+ userName+". You entered an incorrect password";  
            m.addAttribute("message", msg);  
		return "errorpage";
		}else
		{
			String msg="Hello "+ userName;  
            m.addAttribute("message", msg); 
		return "viewpage";
			
			 
		}
		
		}
  
	@RequestMapping("/signup")
	public String signUp()
	{
		return "signup";
	}
	@RequestMapping("/addemp")
	public String addEmp(Emp e)
	{
		int i=edao.addEmp(e);
		return "addedEmp";
	}
	@RequestMapping("/addstudent")
	public String addStudent()
	{
		return "addstudent";
	}
	
	 @PostMapping("/update")
	    public String updateStudentDetails(@RequestBody Student student,Model m)
	    {
	        
	      edao.updateStudent(student);
	      return "showStudent";
	    }
	

	
	@RequestMapping(path = "/adstudent", method = RequestMethod.POST)
	public String addStudents(@RequestBody List<Student> students, Model model) {
	    edao.saveAll(students);
	    model.addAttribute("message", "Students added successfully");
	    return "addedStudent"; // This should correspond to the name of your view (JSP, Thymeleaf, etc.)
	}
	
	
	@RequestMapping(value="/page", method = RequestMethod.GET)
    public String studentPagination(Model m,@RequestParam(defaultValue = "null",required= false) String selectedoption,@RequestParam(defaultValue = "",required= false) String inputText,@RequestParam( defaultValue = "0",required=false) int index, @RequestParam(required= false, defaultValue = "false") boolean lastpage, @RequestParam(required= false, defaultValue = "0") int isPageRequest) 
    {
		
		System.out.println("hello all");
       int pagesize = 10;
       int count = edao.count(inputText,selectedoption);
       System.out.println(count+" : count ");
       int last = count / pagesize;
       System.out.println(index+" after next");
       if(index<last){
    	   if(index<=0)
    	   {
    		   index=0;
    	   }else
    	   {
    		   index = index;
    		   System.out.println(index+" isme ghusa");
    	   }
       }else
       {
    	   index = last;
       }
       if(lastpage)
       {
    	   index = last;
       }
       System.out.println("index : " + index);
       System.out.println(selectedoption+" "+inputText+" filter mein");
       List<Student> student= edao.showsStudent(selectedoption,inputText, index *10);
      
       if(student !=null && student.size() > 0)
       {
    	   m.addAttribute("studentsize", student.size());
       }
       System.out.println("Data list size : " + student.size());
       System.out.println(index);
       m.addAttribute("student",student);
       m.addAttribute("index", index);
       m.addAttribute("lastpage", lastpage);
       m.addAttribute("inputText", inputText);
       m.addAttribute("selectedoption", selectedoption);
      if(isPageRequest == 1 && inputText.isEmpty()){
    	   return "showStudent";
       }else{
    	   return "showStudent";
       }
        
    }

	   
}
