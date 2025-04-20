<!DOCTYPE html>
<html>
<head>
    <title>Comment History Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Comment History -</h2>

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
<div>
    <c:set var="hasMComments" value="false" />
    <c:forEach var="mComment" items="${mComments}">
        <c:if test="${mComment.name == currentUser}">
            <c:set var="hasMComments" value="true" />
        </c:if>
    </c:forEach>
    <c:choose>
        <c:when test="${not hasMComments}">
            <h3>Your comments record on the material :</h3>
            <p>There is no comments record from the material yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <caption><h3>Your comments on the material :</h3></caption>
                <thead>
                <tr>
                    <th>No.</th>
                    <th>Lecture No.</th>
                    <th>Message</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="mComment" items="${mComments}">
                    <c:if test="${mComment.name == currentUser}">
                        <tr>
                            <td>#${mindex = mindex + 1}</td>
                            <td> - ${mComment.materialId} - </td>
                            <td><c:out value="${mComment.message}" escapeXml="true"/></td>
                            <td><fmt:formatDate value="${mComment.date}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${mComment.date}" pattern="hh:mm:ss"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
    <br/>
    <c:set var="hasPComments" value="false" />
    <c:forEach var="pComment" items="${pComments}">
        <c:if test="${pComment.name == currentUser}">
            <c:set var="hasPComments" value="true" />
        </c:if>
    </c:forEach>
    <c:choose>
        <c:when test="${not hasPComments}">
            <h3>Your comments record on the polling :</h3>
            <p>There is no comments from the polling yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <caption><h3>Your comments record on the polling :</h3></caption>
                <thead>
                <tr>
                    <th>No.</th>
                    <th>Polling No.</th>
                    <th>Message</th>
                    <th>Date</th>
                    <th>Time</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="pComment" items="${pComments}">
                    <c:if test="${pComment.name == currentUser}">
                        <tr>
                            <td>#${pindex = pindex + 1}</td>
                            <td> - ${pComment.pollingId} - </td>
                            <td><c:out value="${pComment.message}" escapeXml="true"/></td>
                            <td><fmt:formatDate value="${pComment.date}" pattern="yyyy-MM-dd"/></td>
                            <td><fmt:formatDate value="${pComment.date}" pattern="hh:mm:ss"/></td>
                        </tr>
                    </c:if>
                </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>