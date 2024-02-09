<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<button id="showstudentform">Add Student</button>
<div id="formContainer" style="display: none;">
    <div class="formRow">
        <input type="text" class="name" placeholder="Name" required>
        <input type="text" class="mobile" placeholder="Mobile" required>
        <input type="email" class="email" placeholder="Email" required>
        <input type="number" class="clas" placeholder="Class" required>
        <button type="button" class="removeRow">-</button><br>
        
    </div>
    
</div>
<button type="button" id="addRow">+</button>
		<button type="button" class="submitForm">Submit</button>
		<br>
		
Search<input type="text" id="searchInput" onkeyup="myFunction()">
Filter By Class <select name="class" id="class" onchange="searchClass()">
  <option value="clas">Select Class</option>
    <option value="12">12</option>
  <option value="11">11</option>
  <option value="10">10</option>
  
</select>
<div id="fetchStudent">
<jsp:include page="showStudent.jsp"></jsp:include>
</div>
<script>

    $(document).ready(function () {
    	fetchStudent()
    	
        $("#showstudentform").click(function () {
            $("#formContainer").show();
       });
    	 $(".submitForm").click(function () {
             $("#formContainer").hide();
        });
        $(".submitForm").click(function () {
            var contacts = [];

            $(".formRow").each(function () {
                var contact = {
                    id: $(this).find('.id').val(),
                    name: $(this).find('.name').val(),
                    mobile: $(this).find('.mobile').val(),
                    email: $(this).find('.email').val(),
                    clas: $(this).find('.clas').val()
                };
                contacts.push(contact);
            });

            // Validation: Check if any required field is empty
            var isValid = true;
            $(".formRow input[required]").each(function () {
                if ($(this).val().trim() === '') {
                    isValid = false;
                    return false; // Break out of the loop if any field is empty
                }
            });

            if (!isValid) {
                alert("Please fill in all the required fields.");
                return; // Do not proceed with the submission
            }

            $.ajax({
                type: "POST",
                contentType: "application/json",
                url: "/First/adstudent",
                data: JSON.stringify(contacts),
                success: function () {
                    console.log("Student added successfully!");
                    $(".formRow:gt(0)").remove(); // Remove all additional rows except the first one
                    $(".formRow input").val(''); // Clear input values in the first row
                    alert("Student added successfully!"); // Show a success message
                },
                error: function (error) {
                    console.log("Error adding student: " + error);
                    alert("Error adding student: " + error.responseText); // Show an error message
                }
            });
        });

        $("#addRow").click(function () {
            var newRow = $(".formRow:first").clone();
            newRow.find('input').val('');
            newRow.find('.removeRow').show();
            $("#formContainer").append(newRow);
        });

        $(document).on("click", ".removeRow", function () {
            $(this).closest('.formRow').remove();
        });
    });
    function fetchStudent() {
    	// Fetch employee data from the server with AJAX
    	$.ajax({
    	type : 'GET',
    	url : '/First/page?isPageRequest=1',
    	success : function(response) {
    	// Display updated employee data
    	$('#fetchStudent').html(response);
    	},
    	error : function(error) {
    	console.error('Error:', error);
    	}
    	});
    	}
    $(document).ready(function() {
        // Bind keyup event to the search input
        $("#searchInput").keyup(function(event) {
            // Check if the pressed key is Enter (key code 13)
            if (event.keyCode === 13) {
                // Trigger search regardless of input length
                searchStudents($("#searchInput").val());
            } else {
                // If it's not the Enter key, check input length
                var inputLength = $("#searchInput").val().length;
                if (inputLength >= 3) {
                    // If input length is at least 3, trigger search
                    searchStudents($("#searchInput").val());
                }
            }
        });
    });

    function searchStudents(input) {
    	var inputText = $("#searchInput").val();
        $.ajax({
            url: "/First/page",
            type: "GET",
            data: {
            	index : index,
            	inputText : inputText,
            } ,
            success: function(data) {
            	$("#fetchStudent").html(data);
            },
            error: function(xhr, status, error) {
                console.error("Error searching:", error);
            }
        });
    }
    function searchClass(){
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
		        	$("#fetchStudent").html(data);
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
        	$("#fetchStudent").html(data);
        },
        error: function(xhr, status, error) {
            console.error("Error searching:", error);
        }
    });
} 


</script>
