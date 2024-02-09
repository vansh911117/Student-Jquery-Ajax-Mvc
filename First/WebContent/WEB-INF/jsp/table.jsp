<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
    <c:forEach var="student" items="${student}">
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

<input type="hidden" id="last_page" value="${lastpage}" />
<input type="hidden" id="index" value="${index}" />
<input type="hidden" id="input" value="${input}" />