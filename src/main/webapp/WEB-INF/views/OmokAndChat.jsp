<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
    <link href="https://fonts.googleapis.com/css2?family=East+Sea+Dokdo&display=swap" rel="stylesheet">

    <title>오목 게임 및 채팅</title>
    <style>
        *{
            background-color: oldlace;
            text-align: center;
            box-sizing: border-box;
        }
        #container{
            width: 1440px;
            /*height: 1024px;*/
            margin: 4px auto;
            background-color: oldlace;
        }
        .omok-board{
            width: 100%;
            height: 80%;
            /*margin-left: 120px;*/
            /*margin-top: 20px;*/
            display: grid;
            grid-template-columns: repeat(19, 30px);
            grid-template-rows: repeat(19, 30px);
        }
        .omok-cell {
            width: 30px;
            height: 30px;
            /*border: 1px solid orange;*/
            position: relative; /* 상대적인 위치 설정 */

            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 18px;
            color: #000;
        }

        .omok-cell::before,
        .omok-cell::after {
            content: "";
            position: absolute; /* 절대적인 위치 설정 */
            background-color: orange;
        }

        /* 수평 가로선 */
        .omok-cell::before {
            width: 100%;
            height: 1px; /* 가로선의 두께 */
            top: 50%; /* 가운데 정렬을 위해 50%로 설정 */
            left: 0;
            transform: translateY(-50%);
        }

        /* 수직 세로선 */
        .omok-cell::after {
            width: 1px; /* 세로선의 두께 */
            height: 100%;
            top: 0;
            left: 50%; /* 가운데 정렬을 위해 50%로 설정 */
            transform: translateX(-50%);
        }




        .header{
            width: 100%;
            height: 140px;
            margin: 0 auto;
            text-align: center;
            font-size: 10px;
            color: orange;
            font-family: 'East Sea Dokdo', sans-serif;
        }

        h1{
            font-family: 'East Sea Dokdo', sans-serif;
            font-size: 80px;
            color: orange;
        }
        h2{
            font-family: 'East Sea Dokdo', sans-serif;
            font-size: 55px;
            text-align: center;
            color: orange;
        }
        h3{
             font-family: 'East Sea Dokdo', sans-serif;
             font-size: 35px;
             text-align: center;
             color: orange;
         }
        #left-sidebar{
            width: 20%;
            height: 600px;
            text-align: center;
            float: left;
            margin-top: 10px;
        }
        #contents{
            width: 60%;
            height: 600px;
            border: 10px solid orange;
            border-radius:100px;
            background-color: oldlace;
            float: left;
            justify-content: center;
            padding-top: 5px;
        }
        #right-sidebar{
            width: 20%;
            height: 600px;
            text-align: center;
            background-color: oldlace;
            float: right;
            margin-top: 10px;
        }
        #footer{
            width: 100%;
            height: 500px;

            margin:0 auto;
            background-color: oldlace;
            clear: left;
        }

        #chatWindow {
            border: 5px solid orange;
            border-radius:20px;
            width: 1200px;
            height: 310px;
            overflow: scroll;
            padding: 7px;
            margin:0 auto;

        }

        #chatMessage {
            width: 235px;
            height: 30px;
        }

        #sendBtn {
            height: 30px;
            position: relative;
            top: 2px;
            left: -2px;
        }

        #closeBtn {
            width: 100%;
            height: 50%;
            font-size:1rem;
            font-family: 'East Sea Dokdo', sans-serif;
            border: 1px solid orange;
            background-color: orange;
            text-align: center;
            margin-top: 50%;
            border-radius: 30px;

        }

        #chatId {
            width: 100px;
            height: 100%;
            border: none;
            border-radius: 100px;
            color:orange;
            font-size:3rem;
            justify-items: center;
            justify-content: center;
            text-align: left;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        #sendbox{
            margin:0 auto;
            text-align: center;
        }
        .myMsg {
            text-align: right;
            font-size:2rem;
            color:black;
            font-family:'Orbit', sans-serif;
        }
        .yourMsg{
            text-align: left;
            font-size:2rem;
            color:black;
            font-family:'Orbit', sans-serif;
        }
        #chatMessage {
            width: 500px;
            height: 50px;
            border: 2px solid orange;
            margin:0 auto;
        }
        #sendBtn {
            width: 120px;
            height: 50px;
            top: 2px;
            left: -2px;
            border: 0px solid orange;
            color:orange;
            font-size:40px;
            font-family: 'East Sea Dokdo', sans-serif;


        }
        #playbtn{
            margin-top: 60%;
            width: 90px;
            height: 50px;
            text-align: center;
            font-size: 1rem;
            font-weight: 300;
            border: 0px solid black;
            border-radius: 100px;
            background-image:url(webapp/img/orangeColor.jpeg);
            color:white;
            font-family: 'East Sea Dokdo', sans-serif;
        }
        #chatName{
            display: flex;
            justify-content: center;
        }

        #chatName > div:first-child{
            display: flex;
            margin-right: 20px;
        }
        .occupied .blackStone{
            width: 100%;
            height: 100%;
            background-color: black;
            border-radius: 50%;
            z-index: 100;
        }
        .occupied .whiteStone{
            width: 100%;
            height: 100%;
            background-color: white;
            border-radius: 50%;
            z-index: 100;
        }

    </style>
</head>
<body>
<div id="header">
    <h1>모두의 오목</h1>
</div>

<div id="container">
    <aside id="left-sidebar">
        <img src="/img/white.png" width="150px height= 400px">
        <h3>백돌 님</h3>
    </aside>
    <div id="contents" class="omok-board" >
        <!-- 오목 게임 보드 -->
<%--        <div class="omok-board" id="omok-board"></div>--%>
            <!-- 19x19 게임 보드를 생성. -->
<%--        <p> <div id="currentPlayerMessage" style="font-size: 40px"> </div></p>--%>
    </div>
    <aside id="right-sidebar">
        <img src="/img/black.png" width="150px height= 400px">
        <h3>흑돌 님</h3>
    </aside>

    <footer id="footer">
        <div>
            <div id="chatName">
                <div>
                    <h2>유저 :  </h2>
                    <input type="text" id="chatId" value="${param.chatId}" readonly />
                </div>
                <div>
                <button id="playbtn" onclick="disconnect();">나가기</button>
                </div>
            </div>
            <!-- 채팅 창 -->
            <div id="chatWindow">
                <!-- 채팅 메시지를 표시하는 영역 -->
            </div>
            <div id="sendbox">
                <input type="text" id="chatMessage" onkeyup="enterKey();">
                <button id="sendBtn" onclick="sendMessage();">전송</button>
            </div>
        </div>
    </footer>
</div>

    <script>
        //파라미터로 닉네임을 가져온다.
        var chatId = "<%=request.getParameter("chatId")%>";
        var roomName = "<%=request.getParameter("roomName")%>";
        // 이제 chatId 변수를 JavaScript에서 사용할 수 있다
        console.log(chatId);
        ///${param.roomName}/${param.chatId}
        //서버와의 WebSocket 연결을 설정

        // const socket = new WebSocket("ws:192.168.0.107:8070/omok/"+roomName+"/"+chatId);
        const socket = new WebSocket("<%= application.getInitParameter("CHAT_ADDR")%>omok/"+roomName+"/"+chatId);
        console.log(socket);


        // 게임 보드 요소에 대한 참조를 가져온다.
        const board = document.querySelector(".omok-board");
        let gameEnded = false; //게임상태 저장
        // 특정 클래스를 가진 div 엘리먼트를 생성하여 19x19 게임 보드를 만든다
        for (let i = 0; i < 19; i++) {
            for (let j = 0; j < 19; j++) {
                const cell = document.createElement('div');
                cell.classList.add('omok-cell');
                cell.dataset.row = i;
                cell.dataset.col = j;
                board.appendChild(cell);
            }
        }
        //첫번째 플레이어 동그라미
        let currentPlayer = "O";
        let nowTurn = "O";

        document.addEventListener("DOMContentLoaded", function () {
            // 게임 보드의 모든 셀에 대한 참조를 가져오고 초기 게임 변수를 설정.
            const cellLinks = document.querySelectorAll(".omok-cell");

            // 게임 보드의 각 셀에 클릭 이벤트 리스너를 추가
            cellLinks.forEach(link => {
                link.addEventListener("click", function (e) {
                    e.preventDefault();
                    if (gameEnded) {


                        return; // 게임이 종료되었으면 더 이상 움직일 수 없습
                    }

                    if (currentPlayer === nowTurn) {
                        const row = link.dataset.row;
                        const col = link.dataset.col;
                        const stone = currentPlayer;

                        // 흑돌인 경우 blackStone 클래스, 백돌인 경우 whiteStone 클래스 추가
                        const stoneClass = currentPlayer === "O" ? "blackStone" : "whiteStone";

                        if (!link.classList.contains("occupied")) {
                            link.classList.add("occupied");
                            link.innerHTML += `<div class="\${stoneClass}"></div>`;

                            const eventData = {
                                event: "place_stone",
                                row: row,
                                col: col,
                                stone: stone,
                                styleClass: stoneClass
                            };

                            const eventDataStr = JSON.stringify(eventData);
                            socket.send(eventDataStr);
                        }

                        // 턴 전환
                        nowTurn = (nowTurn === "O") ? "X" : "O";
                    }
                });
            });
            function sendCoordinateToServer(stone, row, col) {
                // 누른 위치의 좌표를 JSON형식으로 저장 후 서버로 전송
                const eventData = {
                    event: "place_stone",
                    row: row,
                    col: col,
                    stone: stone
                };
                const eventDataStr = JSON.stringify(eventData);
                socket.send(eventDataStr);
            }
        });


        //--------------------------------------------
        //소켓 이름

        socket.onopen = function(message) {
            console.log(chatId+"님이 서버와 연결됐습니다.")
        };
        // 서버에서 받은 메시지를 처리
        socket.onmessage = function (event) {
            console.log(event)
            const eventData = JSON.parse(event.data);
            console.log(eventData);

            //보내온 이번트명이 끝났음을 알리는
            if (eventData.event === "end"){

                alert(eventData.winner+"님이 승리했습니다.");
                gameEnded = true;
                window.location.href = `/`;
                // room-list.jsp?chatId=\${chatId}

            }

            // 서버에서 받은 돌 놓기 이벤트를 처리합니다.
            if (eventData.event === "place_stone") {
                const row = eventData.row;
                const col = eventData.col;
                const stone = eventData.stone;
                if (currentPlayer === stone){
                    if (stone === "O")
                        currentPlayer = "X";
                    else{
                        currentPlayer = "O";
                    }
                }
                if (nowTurn === "O"){
                    nowTurn = "X";
                }
                else{
                    nowTurn = "O";
                }
                const cell = document.querySelector(`[data-row='\${row}'][data-col='\${col}']`);

                // 흑돌인 경우 blackStone 클래스, 백돌인 경우 whiteStone 클래스 추가
                const stoneClass = eventData.stone === "O" ? "blackStone" : "whiteStone";
                if (!cell.classList.contains("occupied")) {
                    cell.classList.add("occupied");
                    cell.innerHTML += `<div class="\${stoneClass}"></div>`;

                }
            }
            if (eventData.event === "msg"){

                const sender = eventData.chatId;
                const content = eventData.content;

                if (content != "") {
                    if (content.match("/")) {
                        if (content.match(("/" + chatId))) {
                            let temp = content.replace(("/" + chatId), " [귓속말] : ");
                            chatWindow.innerHTML += "<div class='yourMsg'>" + sender + "" + temp + "</div>";
                        }
                    } else {
                        // 일반대화
                        chatWindow.innerHTML += "<div class='yourMsg'>" + sender + " : " + content + "</div>";
                    }
                    chatWindow.scrollTop = chatWindow.scrollHeight;
                }
            }

        };



        // 채팅 관련 JavaScript 코드
        let chatWindow, chatMessage;

        window.onload = () => {
            chatWindow = document.getElementById("chatWindow");
            chatMessage = document.getElementById("chatMessage");
            chatId = document.getElementById("chatId").value;
        }

        function sendMessage() {
            const messageContent = chatMessage.value;
            const message = {
                event: "msg",
                chatId: chatId,
                content: messageContent,
            };

            chatWindow.innerHTML += "<div class='myMsg'> " + messageContent + "</div>";

            // 객체를 JSON 문자열로 변환하여 보냅니다.
            socket.send(JSON.stringify(message));

            chatMessage.value = "";
            chatWindow.scrollTop = chatWindow.scrollHeight;
        }

        function disconnect() {
            socket.close();
            window.location.href = "room-list.jsp?chatId=" + encodeURIComponent(chatId);
        }

        function enterKey() {
            if (event.keyCode == 13) {
                sendMessage();
            }
        }

        // socket.onopen = event => chatWindow.innerHTML += "웹소켓 서버에 연결되었습니다. ";
        socket.onclose = (event) => {
            console.error("WebSocket 생성에 실패했습니다.");
            alert("방이 꽉찼습니다.");
            // chatWindow.innerHTML += "웹소켓 서버가 연결종료되었습니다. ";
            window.location.href = "room-list.jsp?chatId=" + encodeURIComponent(chatId);
        }


        socket.onerror = (event) => {
            alert(event.data);
            window.location.href = "room-list.jsp?chatId=" + encodeURIComponent(chatId);
            chatWindow.innerHTML += "채팅 중 에러가 발생하였습니다.";

        }


    </script>

</body>
</html>