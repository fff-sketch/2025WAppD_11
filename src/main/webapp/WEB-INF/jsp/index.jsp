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

<h3>list of lectures :</h3>

    <ul>
        <c:forEach var="lecture" items="${lectures}">
            <li>
                <a href="lectures/${lecture.key}">Lecture ${lecture.key}: ${lecture.value}</a>
            </li>
        </c:forEach>
    </ul>
<security:authorize access="hasRole('USER')">
</security:authorize>
<security:authorize access="hasRole('ADMIN')">
    <button onclick="toggleForm()">Add New Lecture</button>
    <div id="addLectureForm" style="display: block;">
        <form action="addLecture" method="post">
            Lecture ID: <input type="text" name="lectureId"><br>
            Lecture Title: <input type="text" name="lectureTitle"><br>
            <button type="submit">Submit</button>
        </form>
    </div>

    <ul>
        <c:forEach var="lecture" items="${lectures}">
            <li>
                <a href="lectures">Lecture ${lecture.key}: ${lecture.value}</a>
                <a href="#">delete</a>
            </li>
        </c:forEach>
    </ul>
</security:authorize>

<h3>list of multiple-choice (MC) polls :</h3>
<ul>
    <c:forEach var="mcQuestion" items="${mcQuestions}">
        <li>
            <a href="mc/${mcQuestion.key}">Question ${mcQuestion.key}: ${mcQuestion.value}</a>
        </li>
    </c:forEach>
</ul>

<security:authorize access="hasRole('ADMIN')">
    <a href="list"><h1>List of User</h1></a>
</security:authorize>

</body>
</html>