<!DOCTYPE html>
<html>
<head>
    <title>Add Polling Page</title>
</head>
<body>
<h1>Add New Polling :</h1>
<form:form method="POST" modelAttribute="adPEntry">
    <label>Polling Id:</label><br/>
    <form:input path="pollingId"/><br/><br/>
    <label>Question:</label><br/>
    <form:input path="question"/><br/><br/>
    <label>Option:</label><br/>
    <form:input path="option1"/><br/>
    <form:input path="option2"/><br/>
    <form:input path="option3"/><br/>
    <form:input path="option4"/><br/><br/>
    <input type="submit" name="add" value="Add"/>
</form:form><br/>
<a href="/pj/index">Back to Home</a>
</body>
</html>