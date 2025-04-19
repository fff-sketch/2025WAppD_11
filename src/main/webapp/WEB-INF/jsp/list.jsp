<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HKMU Poll System</title>
</head>
<body>
<a href="index">Back to Home</a>
<a href="addUser">add user</a>
<table>
    <tr>
        <th>user name</th>
        <th>password</th>
        <th>full name</th>
        <th>email</th>
        <th>phone</th>
        <th>edit</th>
        <th>delete</th>
    </tr>
    <c:forEach items="${users}" var="user">
        <tr>
            <td>${user.username}</td>
            <td>${user.password}</td>
            <td>${user.fullName}</td>
            <td>${user.email}</td>
            <td>${user.phone}</td>
            <td><a href="<c:url value="/editUser/${user.username}"/>">edit</a> </td>
            <td><a href="<c:url value="/delete/${user.username}" />">delete</a> </td>
        </tr>
    </c:forEach>
</table>
</body>
</html>