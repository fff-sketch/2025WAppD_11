<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Material Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Edit Material -</h2>
<a href="/pj/index">Back to Home</a><br><br>
<a href="editMaterial/addLecture">Add new lecture</a><br>
<table>
    <caption><h3>list of lectures :</h3></caption>
    <thead>
        <th>Lecture No.</th>
        <th>Lecture Title</th>
        <th>Delete</th>
    </thead>
    <tbody>
    <c:forEach var="material" items="${materials}">
        <tr>
            <td>${material.lectureId}</td>
            <td>${material.lectureTitle}</td>
            <td><a href="editMaterial/removeLecture" modelAttribute="${material.lectureId}">delete</a></td>
            <!--<td><a href="/editMaterial/${material.lectureId}">delete</a></td>-->
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>