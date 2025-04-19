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
<a href="editPolling/addPolling">Add new polling</a><br>
<table>
    <caption><h3>list of multiple-choice (MC) polls :</h3></caption>
    <thead>
        <th>Question No.</th>
        <th>Question</th>
        <th>Delete</th>
    </thead>
    <tbody>
    <c:forEach var="polling" items="${pollings}">
        <tr>
            <td>${polling.pollingId}</td>
            <td>${polling.question}</td>
            <td><a href="editMaterial/removeLecture" modelAttribute="${polling.pollingId}">delete</a></td>
            <!--<td><a href="/editMaterial/${polling.pollingId}">delete</a></td>-->
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>