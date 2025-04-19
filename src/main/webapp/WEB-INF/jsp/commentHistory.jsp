<!DOCTYPE html>
<html>
<head>
    <title>Comment History Page</title>
</head>
<body>
<div>
    <c:if test="${fn:length(mcomments) == 0}">
        <p>There is no Material message yet.</p>
    </c:if>
    <c:if test="${fn:length(mcomments) > 0}">
        <table>
            <thead>
                <tr>Material</tr>
                <tr>
                    <td>No.</td>
                    <td>Message</td>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="mComment" items="${mcomments}">
                    <tr>
                        <td>#${mindex = mindex + 1}
                        </td>
                        <td>
                            @${mComment.name} (<fmt:formatDate value="${mComment.date}" pattern="yyyy-MM-dd"/>) said :<br/>
                            <c:out value="${mComment.message}" escapeXml="true"/>
                        </td>
                        <td>
                            <c:url value="/commentHistory/deleteMaterial/${mComment.id}" var="myURL"/>
                            [<a href="${myURL}">Delete</a>]<br/></td>
                    </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
    <c:if test="${fn:length(pcomments) == 0}">
        <p>There is no Polling message yet.</p>
    </c:if>
    <c:if test="${fn:length(pcomments) > 0}">
        <table>
            <thead>
                <tr>Polling</tr>
                <tr>
                    <td>No.</td>
                    <td>Message</td>
                </tr>
            </thead>
            <tbody>
            <c:forEach var="pComment" items="${pcomments}">

                <tr>
                    <td>#${pindex = pindex + 1}
                    </td>
                    <td>
                        @${pComment.name} (<fmt:formatDate value="${pComment.date}" pattern="yyyy-MM-dd"/>) said :<br/>
                        <c:out value="${pComment.message}" escapeXml="true"/>
                    </td>
                    <td>
                        <c:url value="/commentHistory/deletePolling/${pComment.id}" var="myURL"/>
                        [<a href="${myURL}">Delete</a>]<br/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </c:if>
</div>
<a href="/pj/index">Back to Home</a>
</body>
</html>