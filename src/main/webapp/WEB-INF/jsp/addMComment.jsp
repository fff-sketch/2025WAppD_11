<!DOCTYPE html>
<html>
<head>
    <title>Add Comment</title>
</head>
<body>
<h1>Add Comment for Lecture ${materialId}</h1>
<form:form method="POST" modelAttribute="mCmEntry">
    <label>Name:</label><br/>
    <form:input path="name" value="${currentUser}" readonly="true"/><br/><br/>
    <label>Message:</label><br/>
    <form:textarea path="message"/><br/><br/>
    <input type="submit" name="add" value="Add"/>
</form:form><br/>
<a href="/pj/index">Back to Home</a><br/><br/>
<a href="/pj/materials/${materialId}">Back to Edit Material</a>
</body>
</html>