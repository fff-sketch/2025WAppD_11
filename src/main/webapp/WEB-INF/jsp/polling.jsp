<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Polling Page</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h2>- Course Polling -</h2>

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
<h3>Question ${pollingId} : ${question}</h3>
<div>
    <security:authorize access="isAuthenticated()">
        <c:set var="currentUser">
            <security:authentication property="principal.username"/>
        </c:set>
        <form method="post" action="mc/vote/${currentUser}">
            <input type="hidden" name="questionId" value="${pollingId}">
            <c:forEach var="option" items="${options}" varStatus="oStatus">
                <div>
                    <input type="radio" name="optionId" value="${oStatus.index}" id="opt_${oStatus.index}">
                    <label for="opt_${oStatus.index}">
                            ${option}<span> <strong>( ${voteCount[oStatus.index]} votes ) </strong> </span>
                    </label>
                </div>
            </c:forEach>
            <input type="submit" value="Vote"/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </security:authorize>
</div>
<h3>Comments (about this polling) : </h3>

<security:authorize access="isAuthenticated()">
    <c:set var="currentUser">
        <security:authentication property="principal.username"/>
    </c:set>
    <!--<a href="${pageContext.request.contextPath}/polling/${pollingId}/addPComment">Add Comment</a>-->
    <c:url value="/polling/${pollingId}/addPComment/${currentUser}" var="addCommentUrl"/>
    <a href="${addCommentUrl}">Add Comment</a><br/><br/>
</security:authorize>

<div>
    <c:set var="hasComments" value="false" />
    <c:forEach var="pComment" items="${pComments}">
        <c:if test="${pComment.pollingId == pollingId}">
            <c:set var="hasComments" value="true" />
        </c:if>
    </c:forEach>
    <c:choose>
        <c:when test="${not hasComments}">
            <p>There are no comments yet.</p>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                <td>No.</td>
                <td>Message</td>
                </thead>
                <tbody>
                <c:forEach var="pComment" items="${pComments}">
                    <c:if test="${pComment.pollingId == pollingId}">
                        <tr>
                            <td>#${index = index + 1}</td>
                            <td>
                                @${pComment.name} (<fmt:formatDate value="${pComment.date}" pattern="yyyy-MM-dd, hh:mm:ss"/>) said :<br/>
                                <c:out value="${pComment.message}" escapeXml="true"/>
                            </td>
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