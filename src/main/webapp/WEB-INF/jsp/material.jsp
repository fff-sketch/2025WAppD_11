
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
    <h3>Download File : </h3>
    <c:choose>
        <c:when test="${empty files}">
            <p>No lecture notes available.</p>
        </c:when>
        <c:otherwise>
            <ul>
                <c:forEach var="file" items="${files}">
                    <li>
                        <a href="/pj/materials/${materialId}/download/${file.id}">${file.fileName}</a>
                        (Uploaded: <fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd HH:mm:ss"/>)
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
</div>
<div>
    <h3>Upload Lecture Notes</h3>
    <form action="/pj/materials/${materialId}/upload" method="post" enctype="multipart/form-data">
        <input type="file" name="file" accept=".pdf,.doc,.docx,.txt" required />
        <input type="submit" value="Upload File" />
    </form>
    <c:if test="${not empty uploadMessage}">
        <p style="color: green;">${uploadMessage}</p>
    </c:if>
    <c:if test="${not empty uploadError}">
        <p style="color: red;">${uploadError}</p>
    </c:if>
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
