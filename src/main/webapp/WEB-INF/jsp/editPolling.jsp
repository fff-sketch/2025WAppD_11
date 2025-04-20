<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Polling Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Edit Polling -</h2>

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

<a href="/pj/index">Back to Home</a><br><br>
<a href="editPolling/addPolling">Add new polling</a><br>
<table>
    <caption><h3>List of multiple-choice (MC) polls :</h3></caption>
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
            <td>
                <c:url value="/editPolling/removePolling/${polling.pollingId}" var="myURL"/>
                <a href="${myURL}"> [ Delete ] </a><br/>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<c:if test="${fn:length(pcomments) == 0}">
    <h3>List of comments from the polling :</h3>
    <p>There is no comments from the polling yet.</p>
</c:if>
<c:if test="${fn:length(pcomments) > 0}">
    <table>
        <caption><h3>List of comments from the polling :</h3></caption>
        <thead>
        <tr>
            <th>No.</th>
            <th>Lecture No.</th>
            <th>Message</th>
            <th>Delete</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="pComment" items="${pcomments}">
            <tr>
                <td>#${index = index + 1}</td>
                <td> - ${pComment.pollingId} - </td>
                <td>
                    @${pComment.name} (<fmt:formatDate value="${pComment.date}" pattern="yyyy-MM-dd, hh:mm:ss"/>) said :<br/>
                    <c:out value="${pComment.message}" escapeXml="true"/>
                </td>
                <td>
                    <c:url value="/editPolling/deletePollingComment/${pComment.id}" var="myURL"/>
                    <a href="${myURL}"> [ Delete ] </a><br/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>
</body>
</html>