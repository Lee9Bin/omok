<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gyub.omok.domain.Room" %>


<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>방 리스트</title>
  <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">
  <style>
    * {
      background-color: oldlace;
      text-align: center;
    }

    #container {
      width: 100%;
      height: 70px;
      margin: 4px auto;
    }

    #header {
      height: 170px;
      margin: 0 auto;
      text-align: center;
      font-size: 10px;
      color: orange;
      font-family: 'East Sea Dokdo', sans-serif;
      background-color: oldlace;
    }

    p {
      font-size: 40px;
      color: orange;
      margin-top: 0;
      margin-bottom: 0;
      text-align: center;
      font-family: 'East Sea Dokdo', sans-serif;
    }

    a {
      text-decoration-line: none;
    }

    #roomTitle {
      width: 200px;
      height: 35px;
      color: white;
      background-color: orange;
      border: 0px orange;
      border-radius: 100px;
      text-align: left;
    }

    #idbox {
      width: 200px;
      height: 35px;
      color: white;
      background-color: orange;
      border: 0px orange;
      border-radius: 100px;
      text-align: center;
    }

    h1 {
      font-family: 'East Sea Dokdo', sans-serif;
      font-size: 80px;
      text-align: center;
    }

    #contents {
      width: 100%;
      height: 900px;
      margin: 0 auto;
      background-color: oldlace;
      float: left;
    }

    #roomList {
      width: 200px;
      height: 100px;
      border: 5px solid orange;
      box-shadow: 10px 10px orange;
      border-radius: 80px;
      float: left;
      margin-left: 10px;
      margin-right: 10px;
      margin-top: 15px;
    }

    #rmname {
      font-size: 30px;
      font-family: 'East Sea Dokdo', sans-serif;
      text-align: center;
      color: orange;
      border-radius: 15px; /* 텍스트 상자를 동그랗게 만드는 속성 */
      display: inline-block; /* 인라인 요소로 텍스트 상자를 감싸기 */
      padding: 5px 10px; /* 내부 여백을 추가하여 텍스트와 테두리 사이의 공백을 만듭니다 */
    }

    .makeroombtn {
      width: 200px;
      height: 50px;
      text-align: center;
      margin-right: 10px;
      line-height: 50px; /* 버튼 높이와 동일한 값으로 설정 */
      font-size: 40px;
      font-weight: 300;
      border: none;
      border-radius: 100px;
      color: gray;
      font-family: 'East Sea Dokdo', sans-serif;
      box-shadow: 0px 0px 10px 0px rgba(128, 128, 128, 1); /* 그림자 효과 */
    }

    .main {
      width: 100%;
      height: 70%;
      padding: 20px 170px;
    }
  </style>

</head>
<body>
<%
  List<Room> rooms = (List<Room>) request.getAttribute("rooms");
  String chatId = request.getParameter("chatId");
  session.setAttribute("userNickname",chatId);

%>

<div id="container">
  <header id="header"><h1>모두의 오목</h1></header>
</div>
<p
        style="font-size: 60px; color: orange; margin-top: 50; margin-bottom: 30; text-align: center; font-family: 'East Sea Dokdo', sans-serif;">
  사용자 닉네임:
  <%=chatId%>
</p>


  <div>
    <!-- 방 만들기 버튼 -->
    <button class="makeroombtn" onclick="goToRoom();">방만들기</button>
    <!-- 새로고침 버튼 -->
    <button class="makeroombtn" onclick="updateRoom();">새로고침</button>
  </div>

  <div class="main">
  <!-- 방 목록 출력 -->
  <c:forEach items="${rooms}" var="room">
    <div class="room">
      <fieldset id="roomList">
        <a
                href="OmokAndChat.jsp?roomName=${room.name}&chatId=${userNickname}">
          <p id="rmname">방 이름: ${room.name}</p>
          <p id="rmname">인원 제한: ${room.capacity}</p>
        </a>
      </fieldset>
    </div>
  </c:forEach>
  </div>



<script>
  // WebSocket 연결
  const socket = new WebSocket("<%= application.getInitParameter("CHAT_ADDR")%>roomWebSocket");
  console.log(socket)

  socket.onmessage = function (event) {
    // 서버에서 전송한 메시지 처리 (방 목록 업데이트)
    let roomList = JSON.parse(event.data);

    // 방 목록 업데이트 함수 호출
    updateRoomList(roomList);
  };
  socket.onclose = function (event) {
    // 연결이 종료될 때의 처리
    console.log("WebSocket closed: " + event.code + ", " + event.reason);
  };

  function updateRoomList(roomList) {
    // 방 목록 업데이트 로직 구현
    let roomListContainer = document.getElementById("roomList");
    roomListContainer.innerHTML = ""; // 기존 목록 비우기

    for (var i = 0; i < roomList.length; i++) {
      let room = roomList[i];
      let roomDiv = document.createElement("div");
      roomDiv.className = "room";

      let roomLink = document.createElement("a");
      roomLink.href = "OmokAndChat.jsp?roomName=" + room.name + "&chatId=" + userNickname;

      let roomNameParagraph = document.createElement("p");
      roomNameParagraph.textContent = "방 이름: " + room.name;

      let capacityParagraph = document.createElement("p");
      capacityParagraph.textContent = "인원 제한: " + room.capacity;

      roomLink.appendChild(roomNameParagraph);
      roomLink.appendChild(capacityParagraph);
      roomDiv.appendChild(roomLink);

      roomListContainer.appendChild(roomDiv);
    }
  }

  function goToRoom(){
    window.location.href = `room-create.jsp?chatId=${userNickname}`;


  }

  function updateRoom() {
    window.location.reload();
  }

</script>
</body>
</html>