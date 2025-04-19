<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Polling Page</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h2>- Course Polling -</h2>
<a href="/pj/index">Back to Home</a><br><br>
<h3>Question ${pollingId} : ${question}</h3>
<div>
    <form method="post" action="mc/vote">
        <input type="hidden" name="questionId" value="${pollingId}">
        <c:forEach var="option" items="${options}" varStatus="oStatus">
            <div>
                <input type="radio" name="optionId" value="${oStatus.index}" id="opt_${oStatus.index}">
                <label for="opt_${oStatus.index}">
                        ${option}<span> <strong>( ${votes[pollingId-1][oStatus.index]} votes ) </strong> </span>
                </label>
            </div>
        </c:forEach>
        <input type="submit" value="Vote"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>
<h3>Comments (about this polling) : </h3>
<!--<a href="${pageContext.request.contextPath}/polling/${pollingId}/addPComment">Add Comment</a>-->
<c:url value="/polling/${pollingId}/addPComment" var="addCommentUrl"/>
<a href="${addCommentUrl}">Add Comment</a><br/><br/>
<div>
    <c:if test="${fn:length(pComments) == 0}">
        <p>There is no message yet.</p>
    </c:if>
    <c:if test="${fn:length(pComments) > 0}">
        <table>
            <thead>
                <td>No.</td>
                <td>Message</td>
            </thead>
            <tbody>
            <c:forEach var="pComment" items="${pComments}">
                <c:if test="${pComment.pollingId == pollingId}">
                    <tr>
                        <td>#${pindex = pindex + 1}</td>
                        <td>
                            @${pComment.name} (<fmt:formatDate value="${pComment.date}" pattern="yyyy-MM-dd"/>) said :<br/>
                            <c:out value="${pComment.message}" escapeXml="true"/>
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