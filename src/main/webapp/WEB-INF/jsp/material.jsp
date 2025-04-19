
<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.Map" %>

<html>
<head>
    <title>Materials Page</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h2>- Course Materials -</h2>
<a href="/pj/index">Back to Home</a><br><br>
<div>
    <h3>Lecture Number : ${materialId}</h3>
    <h3>Lecture Title : ${materialTitle}</h3>
    <h3>Download File : <a href="#">Download lecture notes</a></h3>
</div>
<h3>Comments (about this lecture) : </h3>
<!--<a href="${pageContext.request.contextPath}/materials/${materialId}/addMComment">Add Comment</a>-->
<c:url value="/materials/${materialId}/addMComment" var="addCommentUrl"/>
<a href="${addCommentUrl}">Add Comment</a><br/><br/>
<div>
    <c:if test="${fn:length(mComments) == 0}">
        <p>There is no message yet.</p>
    </c:if>
    <c:if test="${fn:length(mComments) > 0}">
        <table>
            <thead>
                <td>No.</td>
                <td>Message</td>
            </thead>
            <tbody>
                <c:forEach var="mComment" items="${mComments}">
                    <c:if test="${mComment.materialId == materialId}">
                        <tr>
                            <td>#${mindex = mindex + 1}
                            </td>
                            <td>
                            @${mComment.name} (<fmt:formatDate value="${mComment.date}" pattern="yyyy-MM-dd"/>) said :<br/>
                                <c:out value="${mComment.message}" escapeXml="true"/>
                            </td>

                        </tr>
                    </c:if>

                </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
</body>
</html>
