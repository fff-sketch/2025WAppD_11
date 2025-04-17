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
    <h3>Lecture Number : ${lectureId}</h3>
    <h3>Lecture Title : ${lectureTitle}</h3>
    <h3>Download File : <a href="#">Download lecture notes</a></h3>
</div>
<h3>Comments : </h3>
<div>
    <ul>

    </ul>
</div>
</body>
</html>
