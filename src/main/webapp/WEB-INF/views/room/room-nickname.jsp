<%--
  Created by IntelliJ IDEA.
  User: kky
  Date: 2023/11/07
  Time: 2:03 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR&family=Orbit&display=swap" rel="stylesheet">
    <title>Title</title>
    <style>
        *{
            background-color: oldlace;
            text-align: center;
        }
        .main{
            text-align: center;
        }
        p:first-child{
            width: 100%;
            height: 50px;
            font-size: 90px;
            background-color: white;
            font-weight: 400;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        p:nth-child(2){
            font-size: 35px;
            background-color: white;
            font-weight: 400;
            font-family: 'East Sea Dokdo', sans-serif;

        }
        h2{
            background-color: white;
            text-align: left;
            margin-left: 50px;
        }
        .loginLine{
            width: 600px;
            height: 600px;
            margin: 0 auto;
            text-align: center;
            border: 0px solid black;
            border-radius: 100px;
            background-color: white;
            color: orange;
        }
        #chatId{
            width: 400px;
            height: 60px;
            text-align: center;
            border: 0px solid black;
            border-radius: 100px;
            background-color: cornsilk;
            color: orange;
        }
        #playbtn{
            width: 200px;
            height: 50px;
            text-align: center;
            font-size: 40px;
            font-weight: 300;
            border: 0px solid black;
            border-radius: 100px;
            background-image:url(webapp/img/monarch-2873979_1280.png);
            color:white;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        .foot{
            font-size: 15px;
            font-family: 'Orbit', sans-serif;
        }
    </style>
</head>
<body>

<form action="/createRoom" method="POST">
    <div class="main">

        <img src="../../../img/orange-1618917_1280.png" width="80px">
        <img src="../../../img/orange-1618917_1280.png" width="80px">
        <img src="../../../img/orange-1618917_1280.png" width="80px">
        <img src="../../../img/orange-1618917_1280.png" width="80px">
        <img src="../../../img/orange-1618917_1280.png" width="80px">
        <fieldset class="loginLine">
            <p>모두의 오목</p>
            <p>사용할 닉네임</p>
<%--            <p>--%>
<%--            <label for="chatId">사용자 닉네임:</label>--%>
<%--            </p>--%>
            <input type="text" id="chatId" name="userNickname" placeholder="ID를 입력하세요" required><br>
            <br>
            <br>
<%--            <input type="submit" id="playbtn" value="게임시작" onclick="gameStart();">--%>
            <button type="submit" id="playbtn">게임 들어가기</button>
        </fieldset>
        <br>
    </div>

</form>

</body>
</html>
