<!DOCTYPE html>
<html>
<head>
    <title>Voting History Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Voting History -</h2>

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

<a href="/pj/index">Back to Home</a><br/>

<security:authorize access="isAuthenticated()">
    <c:set var="currentUser">
        <security:authentication property="principal.username"/>
    </c:set>
    <c:set var="hasVotes" value="false" />
    <c:forEach var="vote" items="${votes}">
        <c:if test="${vote.userName == currentUser}">
            <c:set var="hasVotes" value="true" />
        </c:if>
    </c:forEach>
    <c:choose>
        <c:when test="${not hasVotes}">
            <h3>Your voting record :</h3>
            <p>You have not voting.</p>
        </c:when>
        <c:otherwise>
            <table>
                <caption><h3>Your voting record :</h3></caption>
                <thead>
                <tr>
                    <th>Question No.</th>
                    <th>Question</th>
                    <th>Your Choice</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="vote" items="${votes}">
                    <c:if test="${vote.userName == currentUser}">
                    <tr>
                        <td>${vote.pollingId}</td>
                        <td>${vote.question}</td>
                        <td>${vote.option}</td>
                        <td><fmt:formatDate value="${vote.date}" pattern="yyyy-MM-dd"/></td>
                        <td><fmt:formatDate value="${vote.date}" pattern="hh:mm:ss"/></td>
                    </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</security:authorize>
</body>
</html>