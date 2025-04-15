<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Favorite University Poll</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
        }
        h1 {
            font-size: 24px;
            font-weight: bold;
        }
        .vote-button {
            margin-top: 20px;
            padding: 10px 20px;
            font-size: 16px;
        }
    </style>
</head>
<body>

<h1>What is your favourite University?</h1>

<form id="universityPoll">
    <label>
        <input type="radio" name="university" value="MU"> MU (0 votes)
    </label><br>
    <label>
        <input type="radio" name="university" value="MUHK"> MUHK (0 votes)
    </label><br>
    <label>
        <input type="radio" name="university" value="Metropolitan University"> Metropolitan University (0 votes)
    </label><br>
    <label>
        <input type="radio" name="university" value="HKMU"> HKMU (0 votes)
    </label><br>

    <button type="button" class="vote-button" onclick="alert('Thank you for voting!')">Vote</button>
</form>

</body>
</html>