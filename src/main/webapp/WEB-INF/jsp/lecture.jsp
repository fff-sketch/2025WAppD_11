<%@ page import="java.util.Map" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.Map" %>

<html>
<head>
    <title>Course Materials</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h1>- Course Materials -</h1>
<div>
    <h3>lecture Number : ${lectureId}</h3>
    <h3>lecture title : ${lectureTitle}</h3>
    <h3>Download File : <a href="#">Download lecture notes</a></h3>
    <h3>Comments : </h3>
    <ul>

    </ul>

<security:authorize access="hasRole('USER')">
</security:authorize>
</div>
<a href="/pj/index">Back to Home</a>
</body>
</html>
