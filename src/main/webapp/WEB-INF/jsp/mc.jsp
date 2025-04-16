<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>HKMU Poll System</title>
</head>
<body>
<h1>Web Applications: Design and Development</h1>
<h1>- Course Polling -</h1>
<h3>Question ${mcId} : ${question}</h3>
<div>
    <form method="post" action="mc/vote">
        <input type="hidden" name="questionId" value="${qStatus.index}">
        <c:forEach var="option" items="${Options[qStatus.index]}" varStatus="oStatus">
            <div>
                <input type="radio" name="optionId" value="${oStatus.index}" id="opt_${qStatus.index}_${oStatus.index}">
                <label for="opt_${qStatus.index}_${oStatus.index}">
                        ${option}
                </label>
            </div>
        </c:forEach>
        <input type="submit" value="Vote"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
</div>


<!--
<c:forEach var="question" items="${questions}" varStatus="qStatus">
    <div class="poll">
        <h2>${question}</h2>
        <form method="post" action="mc/vote">
            <input type="hidden" name="questionId" value="${qStatus.index}">

            <c:forEach var="option" items="${options[qStatus.index]}" varStatus="oStatus">
                <div class="option">
                    <input type="radio" name="optionId" value="${oStatus.index}" id="opt_${qStatus.index}_${oStatus.index}">
                    <label for="opt_${qStatus.index}_${oStatus.index}">
                            ${option} <span>(${votes[qStatus.index][oStatus.index]} votes)</span>
                    </label>
                </div>
            </c:forEach>

            <input type="submit" value="Vote"/>
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        </form>
    </div>
</c:forEach>
-->
<a href="index">Back to Home</a>
</body>
</html>
