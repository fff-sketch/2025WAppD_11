<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Materials Page</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h2>- Course Materials -</h2>

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
    <h3>Lecture Number : ${materialId}</h3>
    <h3>Lecture Title : ${materialTitle}</h3>
    <h3>Download File : <a href="#">Download lecture notes</a></h3>
</div>
<h3>Comments (about this lecture) : </h3>

<security:authorize access="isAuthenticated()">
    <c:set var="currentUser">
        <security:authentication property="principal.username"/>
    </c:set>
    <!--<a href="${pageContext.request.contextPath}/materials/${materialId}/addMComment">Add Comment</a>-->
    <c:url value="/materials/${materialId}/addMComment/${currentUser}" var="addCommentUrl"/>
    <a href="${addCommentUrl}">Add Comment</a><br/><br/>
</security:authorize>

<div>
    <c:set var="hasComments" value="false" />
    <c:forEach var="mComment" items="${mComments}">
        <c:if test="${mComment.materialId == materialId}">
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
                <c:forEach var="mComment" items="${mComments}">
                    <c:if test="${mComment.materialId == materialId}">
                        <tr>
                            <td>#${index = index + 1}</td>
                            <td>
                                @${mComment.name} (<fmt:formatDate value="${mComment.date}" pattern="yyyy-MM-dd, hh:mm:ss"/>) said :<br/>
                                <c:out value="${mComment.message}" escapeXml="true"/>
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
