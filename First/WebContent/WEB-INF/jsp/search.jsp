<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Search Students</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#searchInput").on("keyup", function () {
                var keyword = $(this).val();
                if (keyword.length >= 4) {
                    searchStudents(keyword);
                }
            });

            function searchStudents(keyword) {
                $.ajax({
                    url: "/First/searchStudents",
                    type: "GET",
                    data: {keyword: keyword},
                    success: function (data) {
                        updateTable(data);
                    },
                    error: function (error) {
                        console.error("Error searching students: " + error);
                    }
                });
            }

            function updateTable(data) {
                var tableBody = $("#resultsTableBody");
                tableBody.empty(); // Clear existing rows

                if (data.length === 0) {
                    tableBody.append("<tr><td colspan='4'>No results found</td></tr>");
                } else {
                    $.each(data, function (index, student) {
                        tableBody.append("<tr><td>" + student.id + "</td><td>" + student.name + "</td><td>" + student.mobile + "</td><td>" + student.email + "</td></tr>");
                    });
                }
            }
        });
    </script>
</head>
<body>
    <h2>Search Students</h2>
    <input type="text" id="searchInput" placeholder="Enter search keyword (at least 4 characters)">
    
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Mobile</th>
                <th>Email</th>
            </tr>
        </thead>
        <tbody id="resultsTableBody">
            <!-- Display search results here -->
        </tbody>
    </table>
</body>
</html>
