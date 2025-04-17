<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Polling Page</title>
    <script src="editPolling.java"></script>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Edit Polling -</h2>
<a href="/pj/index">Back to Home</a><br><br>

<h3>Add New Polling :</h3>
<div>
    <!--<form action="addPolling" method="post">-->
    <form action="editMaterial/addPolling" method="post">
        question: <input type="text" name="question"><br>
        option1: <input type="text" name="option1"><br>
        option2: <input type="text" name="option2"><br>
        option3: <input type="text" name="option3"><br>
        option4: <input type="text" name="option4"><br>
        <button type="submit">Submit</button>
    </form>
</div>

<table>
    <caption><h3>list of multiple-choice (MC) polls :</h3></caption>
    <thead>
        <th>Question No.</th>
        <th>Question</th>
        <th>Delete</th>
        </thead>
    <tbody>
    <c:forEach var="mcQuestion" items="${mcQuestions}">
        <tr>
            <td>${mcQuestion.key}</td>
            <td>${mcQuestion.value}</td>
            <td><a href="editMaterial/removeLecture" modelAttribute="${mcQuestion.key}">delete</a></td>
            <!--<td><a href="/editMaterial/${mcQuestion.key}">delete</a></td>-->
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>