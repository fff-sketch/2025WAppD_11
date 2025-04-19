<!DOCTYPE html>
<html>
<head>
    <title>Add Lecture Page</title>
</head>
<body>
<h1>Add New Lecture :</h1>
<form:form method="POST" modelAttribute="adLEntry">
    <label>Lecture ID:</label><br/>
    <form:input path="lectureId"/><br/><br/>
    <label>Lecture Title:</label><br/>
    <form:textarea path="lectureTitle"/><br/><br/>
    <input type="submit" name="add" value="Add"/>
</form:form><br/>
<a href="/pj/index">Back to Home</a>
</body>
</html>