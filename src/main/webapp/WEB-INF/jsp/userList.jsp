<!DOCTYPE html>
<html>
<head>
    <title>User List Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- User List -</h2>

<security:authorize access="isAuthenticated()">
    <c:set var="currentUser">
        <security:authentication property="principal.username"/>
    </c:set>
    <p>Hello, <c:out value="${currentUser}"/>!</p>
    <c:url var="logoutUrl" value="/logout"/>
    <form action="${logoutUrl}" method="post">
        <input type="submit" value="Log out"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</security:authorize><br/>

<a href="/pj/index">Back to Home</a><br/><br/>
<a href="addUser">add user</a><br/>
<table>
    <caption>List of User :</caption>
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