
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
    <h3>lecture Number : ${lectureId}</h3>
    <h3>lecture title : ${lectureTitle}</h3>
    <h3>Download File : <a href="#">Download lecture notes</a></h3>
</div>
<h3>Comments : </h3>
<div>
    <c:if test="${fn:length(entries) == 0}">
        <p>There is no message yet.</p>
    </c:if>
    <c:if test="${fn:length(entries) > 0}">
        <ul>
            <c:forEach var="entry" items="${entries}">
                <c:url value="/GuestBook/EditComment/${entry.id}" var="myURL"/>
                <li>
                    #${entry.id} - ${entry.name} (<fmt:formatDate value="${entry.date}" pattern="yyyy-MM-dd"/>):
                    [<a href="${myURL}">Edit</a>] <br/>
                    <c:out value="${entry.message}" escapeXml="true"/><br/>
                </li>
            </c:forEach>
        </ul>
    </c:if>

    <p><a href="lectures/addComment">Add Comment</a></p>
</div>
</body>
</html>
