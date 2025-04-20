<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Edit Material Page</title>
</head>
<body>
<h1>Web Applications: Design and Development!</h1>
<h2>- Edit Material -</h2>

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
<a href="editMaterial/addLecture">Add new lecture</a><br>
<table>
    <caption><h3>List of lectures :</h3></caption>
    <thead>
        <th>Lecture No.</th>
        <th>Lecture Title</th>
        <th>Delete</th>
    </thead>
    <tbody>
        <c:forEach var="material" items="${materials}">
            <tr>
                <td>${material.lectureId}</td>
                <td>${material.lectureTitle}</td>
                <td>
                    <c:url value="/editMaterial/removeLecture/${material.lectureId}" var="myURL"/>
                    <a href="${myURL}"> [ Delete ] </a><br/>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table><br/>

<form action="/pj/editMaterial/upload" method="post" enctype="multipart/form-data">
    <input type="file" name="file" accept=".pdf,.doc,.docx,.txt" multiple required/>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    <input type="submit" value="Upload File" />
</form>
<div>
    <table>
        <captiop><h3>List of files :</h3></captiop>
        <thead>
        <tr>
            <th>id</th>
            <th>name</th>
            <th>download link</th>
            <th>delete</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${files}" var="file">
            <tr>
                <td>${index = index + 1}</td>
                <td>${file.fileName}</td>
                <td><a href="<c:url value="/download/${file.id}"/>">download</a></td>
                <td>
                    <c:url value="/editMaterial/remove/${file.id}" var="myURL"/>
                    <a href="${myURL}"> [ Delete ] </a><br/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<c:if test="${fn:length(mcomments) == 0}">
    <h3>List of comments from the material :</h3>
    <p>There is no comments from the material yet.</p>
</c:if>
<c:if test="${fn:length(mcomments) > 0}">
    <table>
        <caption><h3>List of comments from the material :</h3></caption>
        <thead>
            <tr>
                <th>No.</th>
                <th>Lecture No.</th>
                <th>Message</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach var="mComment" items="${mcomments}">
            <tr>
                <td>#${index = index + 1}</td>
                <td> - ${mComment.materialId} - </td>
                <td>
                    @${mComment.name} (<fmt:formatDate value="${mComment.date}" pattern="yyyy-MM-dd, hh:mm:ss"/>) said :<br/>
                    <c:out value="${mComment.message}" escapeXml="true"/>
                </td>
                <td>
                    <c:url value="/editMaterial/deleteMaterialComment/${mComment.id}" var="myURL"/>
                    <a href="${myURL}"> [ Delete ] </a><br/>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</c:if>
</body>
</html>