<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Home Page</title>
</head>
<body>

<h1>Web Applications: Design and Development!</h1>
<h2>- Home -</h2>

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
    <security:authorize access="hasRole('ADMIN')">
        <a href="editMaterial"> Edit </a>
    </security:authorize>
</h3>

<ul>
    <c:forEach var="material" items="${materials}">
        <li>
            <security:authorize access="hasAnyRole('USER', 'ADMIN')">
                <a href="materials/${material.lectureId}">Lecture ${material.lectureId}: ${material.lectureTitle}</a>
            </security:authorize>
            <security:authorize access="!hasAnyRole('USER', 'ADMIN')">
                <a href="loginNotice">Lecture ${material.lectureId}: ${material.lectureTitle}</a>
            </security:authorize>
        </li>
    </c:forEach>
</ul>

<h3>List of polling :
    <security:authorize access="hasRole('ADMIN')">
        <a href="editPolling"> Edit </a>
    </security:authorize>
</h3>

<ul>
    <c:forEach var="polling" items="${pollings}">
        <li>
            <security:authorize access="hasAnyRole('USER', 'ADMIN')">
                <a href="polling/${polling.pollingId}">Question ${polling.pollingId}: ${polling.question}</a>
            </security:authorize>
            <security:authorize access="!hasAnyRole('USER', 'ADMIN')">
                <a href="loginNotice">Question ${polling.pollingId}: ${polling.question}</a>
            </security:authorize>
        </li>
    </c:forEach>
</ul>

<security:authorize access="isAuthenticated()">
    <c:set var="currentUser">
        <security:authentication property="principal.username"/>
    </c:set>
    <h3>Comment History : <a href="commentHistory/${currentUser}"> Go </a></h3>
    <h3>Voting History : <a href="votingHistory/${currentUser}"> Go </a></h3>
</security:authorize>

<security:authorize access="hasRole('ADMIN')">
    <h3>List of User : <a href="userList"> Go </a></h3>
</security:authorize>
<!--
<div>
<form action="/pj/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="file" accept=".pdf,.doc,.docx,.txt" multiple required/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="Upload File" />
</form>
</div>
<div>
    <table>
        <thead>
            <tr>
                <th>id</th>
                <th>name</th>
                <th>download link</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${files}" var="file">
            <tr>
                <td>${file.id}</td>
                <td>${file.fileName}</td>
                <td><a href="<c:url value="/download/${file.id}"/>">download</a></td>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
            </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
-->
</body>
</html>