<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF- 8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorite University Poll</title>
</head>
<body>
<c:set var="question" value="${questions[1]}"/> <!-- Correctly use 'value' instead of 'values' -->

<div class="poll">
    <h1>${question}</h1><!-- Display the question -->

    <form method="post" action="mc2/vote">
        <input type="hidden" name="questionId" value="1"> <!-- Set to 0 for the first question -->

        <c:if test="${not empty options[1]}">
            <c:forEach var="option" items="${options[1]}" varStatus="oStatus"> <!-- Loop through the options for the first question -->
                <div class="option">
                    <input type="radio" name="optionId" value="${oStatus.index}" id="opt_${oStatus.index}"> <!-- Use index for value -->
                    <label for="opt_${oStatus.index}">${option} <span>(${votes[1][oStatus.index]} votes)</span></label> <!-- Display vote count -->
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