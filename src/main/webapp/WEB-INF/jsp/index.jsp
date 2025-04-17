<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP - HH</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<security:authorize access="isAuthenticated()">
    <p>Hello, <security:authentication property="principal.username"/>!</p>
    <c:url var="logoutUrl" value="/logout"/>
    <form action="${logoutUrl}" method="post">
        <input type="submit" value="Log out"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</security:authorize>

<security:authorize access="!isAuthenticated()">
    <h2>Login</h2>
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
<a href="lectures"><h1>list of lectures</h1></a>
<ul>
    <li>Lecture 1: HelloWorld</li>
    <li>Lecture 2: ByeWorld</li>
    <li>Lecture 3: Login/Logout</li>
    <li>Lecture 4: 2nd last Lecture</li>
    <li>Lecture 5: Last Lecture</li>
</ul>
<a href="mc"><h1>list of multiple-choice (MC) polls</h1></a>
<ul>
    <li>What is your favourite University?</li>
    <li>How you rate your Ulife in HKMU?</li>
    <li>Which public transport you perfer to take to school?</li>
    <li>What facilities you want to have in HKMU?</li>
    <li>How old are you?</li>
</ul>
<security:authorize access="hasRole('ADMIN')">
    <a href="list">list</a>
</security:authorize>
<br/>
</body>
</html>