<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Home -</h2>
<security:authorize access="isAuthenticated()">
    <p>Hello, <security:authentication property="principal.username"/>!</p>
    <c:url var="logoutUrl" value="/logout"/>
    <form action="${logoutUrl}" method="post">
        <input type="submit" value="Log out"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</security:authorize>

<security:authorize access="!isAuthenticated()">
    <h3>Login</h3>
    <c:if test="${param.error != null}">
        <p style="color: red;">Invalid username or password</p>
    </c:if>
    <c:if test="${param.logout != null}">
        <p>You have been logged out</p>
    </c:if>
    <c:url var="loginUrl" value="/perform_login"/>
    <form action="${loginUrl}" method="POST">
        User: <input type="text" name="username"><br />
        Password: <input type="password" name="password" /><br />
        Remember Me: <input type="checkbox" name="remember-me" /><br />
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <input name="submit" type="submit" value="Log In" /><br />
        <a href="<c:url value='/register'/>">Register</a>
    </form>
</security:authorize>

<h3>List of lectures :
    <a href="editMaterial"> Edit </a>
</h3>
<security:authorize access="hasRole('USER')">
</security:authorize>
<security:authorize access="hasRole('ADMIN')">
</security:authorize>
<ul>
    <c:forEach var="material" items="${materials}">
        <li>
            <a href="materials/${material.lectureId}">Lecture ${material.lectureId}: ${material.lectureTitle}</a>
        </li>
    </c:forEach>
</ul>

<h3>List of polling :
    <a href="editPolling"> Edit </a>
</h3>
<security:authorize access="hasRole('USER')">
</security:authorize>
<security:authorize access="hasRole('ADMIN')">
</security:authorize>
<ul>
    <c:forEach var="polling" items="${pollings}">
        <li>
            <a href="polling/${polling.pollingId}">Question ${polling.pollingId}: ${polling.question}</a>
        </li>
    </c:forEach>
</ul>

<security:authorize access="hasRole('ADMIN')">
</security:authorize>
<h3>Comment History : <a href="commentHistory"> Go </a></h3>
<h3>Voting History : <a href="votingHistory"> Go </a></h3>
<h3>List of User : <a href="userList"> Go </a></h3>

</body>
</html>