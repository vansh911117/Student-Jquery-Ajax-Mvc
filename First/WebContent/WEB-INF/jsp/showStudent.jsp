<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


<div id="tableContent">
<table border="1" align="center" id="table">
<thead>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Mobile</th>
        <th>Class</th>
        <th>Action</th>
    </tr>
    </thead>
    <tbody id="tbody"> 
    <!-- Use JSTL to iterate over the student list -->
    <c:forEach var="student" items="${student}" end="9">
        <tr>
            <td id="td">${student.id}</td>
            <td id="name${student.id}">${student.name}</td>
            <td id="email${student.id}">${student.email}</td>
            <td id="mobile${student.id}">${student.mobile}</td>
            <td id="clas${student.id}">${student.clas}</td>
            <td><button class="action" onclick="updateRow(${student.id})">Action</button></td>
        </tr>
         <tr id="newRow${student.id}" class="newRow" style="display: none;">
            <td><input type="text" size="2" value="${student.id}" id="id${student.id}" readOnly/></td>
            <td><input type="text" size="2" value="${student.name}" id="name1${student.id}"/></td>
             <td><input type="text"  value="${student.email}" id="email1${student.id}"/></td>
            <td><input type="number" size="2" value="${student.mobile}" id="mobile1${student.id}"/></td>
            <td><input type="number" size="2" value="${student.clas}" id="clas1${student.id}"/></td>
            
            <td><button id="update" size="2" onclick="update('${student.id}')">Update</button></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>
<br>
 <div align="center">
  
<c:if test="${index > 0}">
<button onclick="first()">First</button>
<button onclick="previous()">Previous</button>
</c:if>
  <input type="text" id="show" value="${index +1}" style="width: 30px;">
  <button onclick="show()">show</button>
  <c:if test="${studentsize > 10}">
    <button onclick="next()" id="next">Next</button>
    <button onclick="last()" id="last">Last</button>
  </c:if>

  </div>
  

<input type="hidden" id="last_page" value="${lastpage}" />
<input type="hidden" id="index" value="${index}" />
<%-- <input type="hidden" id="inputText" value="${inputText}" />
<input type="hidden" id="selectedoption" value="${selectedoption}" /> --%>
<script>
	
function first() {
    var index = 0;
    var input = $("#input").val();
    var selectedoption = $("#class").val();
    var inputText = $("#searchInput").val();
    $.ajax({
        type: "GET",
        url: "/First/page",
        data:{
        	index : index,
        	input : input,
        	selectedoption : selectedoption,
        	inputText : inputText,
        } ,
        success: function (data) {
            $("#fetchStudent").html(data);
            $("#index").val(index);
        }
    });
}

function previous() {
	 var index =$("#index").val();
     index=parseInt(index);
     var input = $("#input").val();
     var selectedoption = $("#class").val();
     var inputText = $("#searchInput").val();
    console.log(index , " previous");
    index = index - 1;
    $.ajax({
        type: "GET",
        url: "/First/page",
        data:{
        	index : index,
        	input : input,
        	selectedoption : selectedoption,
        	inputText : inputText,
        } ,
        success: function (data) {
            $("#fetchStudent").html(data);
            $("#index").val(index);
        }
    });
}

function next() {
	 var index = $("#index").val();
	 index=parseInt(index);
    var input = $("#input").val();
    var inputText = $("#searchInput").val();
    var selectedoption = $("#class").val();
   	index++;
   	console.log(index , " next");
   	$.ajax({
        type: "GET",
        url: "/First/page",
        data:{
        	index : index,
        	input : input,
        	selectedoption : selectedoption,
        	inputText : inputText,
        } ,
        success: function (data) {
            $("#fetchStudent").html(data);
        
        }
    });
}

function last() {
    var index =$("#index").val();
    index=parseInt(index);
    var input = $("#input").val();
    var selectedoption = $("#class").val();
    var inputText = $("#searchInput").val();
    console.log(index , " last");
   	
    var lastpage= true;
    console.log(index)
    $.ajax({
        type: "GET",
        url: "/First/page",
        data:{
				index : index,
				lastpage : lastpage,
				input : input,
	        	selectedoption : selectedoption,
	        	inputText : inputText,
        },
        success: function (data) {
            $("#fetchStudent").html(data);
            $("#index").val(index);
        }
    });
}

function show() {
	var value=$("#show").val();
	value=parseInt(value);
	var index = $("#index").val();
	index=parseInt(index);
	 var input = $("#input").val();
	    var selectedoption = $("#class").val();
	    var inputText = $("#searchInput").val();
	index=value-1;
    console.log(value , index , " show ke lie");
    $.ajax({
        type: "GET",
        url: "/First/page",
        data: {
        	index : index,
        	input : input,
        	selectedoption : selectedoption,
        	inputText : inputText,
        } ,
        success: function (data) {
            $("#fetchStudent").html(data);
            $("#index").val(index);
        }
    });
}

function updateRow(id) {
    // Hide all elements with class 'newRow'
    $(".newRow").hide();

    // Show the specific element with ID 'newRow' + email
    $("#newRow" + $.escapeSelector(id)).show();
}



function update(studentId) {
    var data = {
        id: $("#id" + studentId).val(),
        name: $("#name1" + studentId).val(),
        email: $("#email1" + studentId).val(),
        mobile: $("#mobile1" + studentId).val(),
        clas: $("#clas1" + studentId).val()
    };
console.log(data);
    // Prepare data object with student details

    $.ajax({
        type: "POST", // Using POST method
        url: "/First/update", // URL to your Spring MVC controller method
        contentType: "application/json", // Sending JSON data
        data: JSON.stringify(data), // Convert data object to JSON string
        success: function(response) {
            console.log("Student updated successfully:");
            $("#newRow" + studentId).hide();
            fetchStudent();
        },
        
        error: function(xhr, status, error) {
            console.error("Error updating student:", error);
        }
        
    });
}



/* function searchClass(){
var selectedoption = $("#class").val();
var inputText = $("#searchInput").val();
 $.ajax({
        url: "/First/page",
        type: "GET",
        data: { 
               selectedoption : selectedoption,
               inputText : inputText,
               isPageRequest : 1
        },
        success: function(data) {
        	$("#table").html(data);
        },
        error: function(xhr, status, error) {
            console.error("Error searching:", error);
        }
    });
}
$(document).ready(function () {
var index = parseInt($("#index").val());
// $("#number").val(index + 1);
});

$(document).ready(function() {

// Bind keyup event to the search input
$("#searchInput").keyup(function(event) {
 var clas = $("#class").val();
// Check if the pressed key is Enter (key code 13)
if (event.keyCode === 13) {
    // Trigger search regardless of input length
    searchStudents($("#searchInput").val() );
} else {
    // If it's not the Enter key, check input length
    var inputLength = $("#searchInput").val().length;
    if (inputLength >= 3) {
        // If input length is at least 3, trigger search
        searchStudents($("#searchInput").val() );
    }
}
});
});

function searchStudents(inputText ) {
var clas = $("#class").val();
$.ajax({
url: "/First/page",
type: "GET",
data: { inputText: inputText},
success: function(data) {
	$("#table").html(data);
},
error: function(xhr, status, error) {
    console.error("Error searching:", error);
}
});
} 

*/



   
</script>

