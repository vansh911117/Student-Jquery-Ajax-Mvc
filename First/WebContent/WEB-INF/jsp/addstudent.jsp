<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<button id="showstudentform">Add Student</button>

<div id="formContainer" style="display: none;">
    <div class="formRow">
        <input type="text" class="name" placeholder="Name" required>
        <input type="text" class="mobile" placeholder="Mobile" required>
        <input type="email" class="email" placeholder="Email" required>
        <button type="button" id="addRow">+</button>
		<button type="button" id="submitForm">Submit</button>
    </div>
</div>


<script>
    $(document).ready(function () {
        $("#showstudentform").click(function () {
            $("#formContainer").toggle();
            $("#showstudentform").toggle();
        });

        $("#submitForm").click(function () {
            // ... (existing code for form submission)

            // Hide the form container after successful submission
            $("#formContainer").hide();
            // Show the "Add Student" button
            $("#showstudentform").show();
        });

        $("#addRow").click(function () {
            var newRow = $(".formRow:first").clone();
            newRow.find('input').val('');
            $("#formContainer").append(newRow);
        });
    });
        $(document).on("click", ".removeRow", function () {
            $(this).closest('.formRow').remove();
        });
    })
        $("#submitForm").click(function () {
            var contacts = [];

            $(".formRow").each(function () {
                var contact = {
                	id: $(this).find('.id').val(),
                	name: $(this).find('.name').val(),
                    mobile: $(this).find('.mobile').val(),
                    email: $(this).find('.email').val()
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
                    console.log("Contacts added successfully!");
                    $(".formRow:gt(0)").remove(); // Remove all additional rows except the first one
                    $(".formRow input").val(''); // Clear input values in the first row
                    alert("Contacts added successfully!"); // Show a success message
                },
                error: function (error) {
                    console.log("Error adding contacts: " + error);
                    alert("Error adding contacts: " + error.responseText); // Show an error message
                }
            });
        });
    });
</script>
