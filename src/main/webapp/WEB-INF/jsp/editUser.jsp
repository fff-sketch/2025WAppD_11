<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit User</title>
</head>
<body>

<h2>Edit User</h2>
<c:url var="editUserUrl" value="/editUser/${username}"/>
<form:form action="${editUserUrl}" method="post" modelAttribute="user">
    <label>Username:${username} </label><br/>
    <label>Password: <form:input path="password"/></label><br/>
    <label>Full Name: <form:input path="fullName"/></label><br/>
    <label>Email Address: <form:input path="email"/></label><br/>
    <label>Phone Number: <form:input path="phone"/></label><br/>

    <input type="submit" value="Edit"/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
</form:form>
</body>
</html>