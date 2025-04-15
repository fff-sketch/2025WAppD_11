<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF- 8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorite University Poll</title>
</head>
<body>
<c:set var="question" value="${questions[0]}"/> <!-- Correctly use 'value' instead of 'values' -->

<div class="poll">
    <h1>${question}</h1><!-- Display the question -->

    <form method="post" action="mc1/vote">
        <input type="hidden" name="questionId" value="0"> <!-- Set to 0 for the first question -->

        <c:if test="${not empty options[0]}">
            <c:forEach var="option" items="${options[0]}"> <!-- Loop through the options for the first question -->
                <div class="option">
                    <input type="radio" name="optionId" value="${option}" id="${option}">
                    <label for="${option}">${option}</label>
                </div>
            </c:forEach>
        </c:if>

        <input type="submit" value="Vote"/>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> <!-- CSRF token for security -->
    </form>
</div>

<a href="index">Back to Home</a> <!-- Link to go back to home -->
</body>
</html>