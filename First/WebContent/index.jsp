<html>  
<body>  
<form action="login" onsubmit="return validate(this)">  
UserName : <input type="text" name="name"/> <br><br>   
Password : <input type="text" name="password"/> <br><br>   
<input type="submit" value="Login">  
</form>  
<br>
<hr>
<a href="signup">Signup</a>

<script type="text/javascript">
	function validate(formData){
		debugger;	
		var username = formData.name.value;
		var password = formData.password.value;
		
		if (username == null || username == "") {
			alert("Please Enter username..");
			return false;
		}
		
		if (password == null || password == "") {
			alert("Please Enter password..");
			return false;
		}
		
		return true;
	}
</script>

</body>  
</html>  