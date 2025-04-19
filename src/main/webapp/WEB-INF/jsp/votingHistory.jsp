<!DOCTYPE html>
<html>
<head>
    <title>Voting History Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Voting History -</h2>
<a href="/pj/index">Back to Home</a><br/>
<c:set var="hasVotes" value="false" />
<c:forEach var="vote" items="${votes}">
    <c:if test="${vote.userName == vote.userName}"><!-- vote.userName == -->
        <c:set var="hasVotes" value="true" />
    </c:if>
</c:forEach>
<c:choose>
    <c:when test="${not hasVotes}">
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
            </tr>
            </thead>
            <tbody>
            <c:forEach var="vote" items="${votes}">
                <tr>
                    <td>${vote.pollingId}</td>
                    <td>${vote.question}</td>
                    <td>${vote.option}</td>
                    <td><fmt:formatDate value="${vote.date}" pattern="yyyy-MM-dd, hh:mm:ss"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>
</body>
</html>