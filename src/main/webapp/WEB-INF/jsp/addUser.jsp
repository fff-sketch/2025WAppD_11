<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%--
  Created by IntelliJ IDEA.
  User: on99
  Date: 8/4/2025
  Time: 23:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add User</title>
</head>
<body>

<h2>Add User</h2>
<c:url var="addUserUrl" value="/addUser"/>
<form:form action="${addUserUrl}" method="post" modelAttribute="user">
    <label>Username: <form:input path="username"/></label><br/>
    <label>Password: <form:password path="password"/></label><br/>
    <label>Full Name: <form:input path="fullName"/></label><br/>
    <label>Email Address: <form:input path="email"/></label><br/>
    <label>Phone Number: <form:input path="phone"/></label><br/>

        <p>User role:</p>
        <input type="radio" id="user" name="role" value="user">
        <label for="user">user</label>
        <input type="radio" id="admin" name="role" value="admin">
        <label for="admin">admin</label>
        <br>
    <input type="submit" value="Add"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</body>
</html>