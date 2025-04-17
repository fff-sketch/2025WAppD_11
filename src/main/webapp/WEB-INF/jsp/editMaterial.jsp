<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Material Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Edit Material -</h2>
<a href="/pj/index">Back to Home</a><br><br>

<h3>Add New Lecture :</h3>
<div>
    <!--<form action="addLecture" method="post">-->
    <form action="editMaterial/addLecture" method="post">
        Lecture ID: <input type="text" name="lectureId"><br>
        Lecture Title: <input type="text" name="lectureTitle"><br>
        <button type="submit">Submit</button>
    </form>
</div>

<table>
    <caption><h3>list of lectures :</h3></caption>
    <thead>
    <th>Lecture No.</th>
    <th>Lecture Title</th>
    <th>Delete</th>
    </thead>
    <tbody>
    <c:forEach var="lecture" items="${lectures}">
        <tr>
            <td>${lecture.key}</td>
            <td>${lecture.value}</td>
            <td><a href="editMaterial/removeLecture" modelAttribute="${lecture.key}">delete</a></td>
            <!--<td><a href="/editMaterial/${lecture.key}">delete</a></td>-->
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>