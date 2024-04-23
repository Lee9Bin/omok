package com.gyub.omok.domain;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

// 방 생성 및 목록 관리 서블릿 만들기 - 클라이언트로부터 방 생성 요청 수신, 새로운 방 만들어 방 목록에 추가
@WebServlet("/createRoom")
public class CreateRoomServlet extends HttpServlet {
    List<Room> roomList = new ArrayList<Room>();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("반응");
        request.setCharacterEncoding("utf-8");
        // HTML이 UTF-8 형식이라는 것을 브라우저에게 전달
        response.setContentType("text/html; charset=utf-8");
        // 클라이언트에서 보낸 방 이름 가져오기
        String roomTitle = request.getParameter("title");
        // 사용자가 입력한 닉네임을 가져옵니다.
        String userNickname = request.getParameter("userNickname");
        // 방을 생성한 후, 방 목록을 업데이트하고 세션에 저장
        HttpSession session = request.getSession();
        session.setAttribute("rooms", roomList);
//        session.setAttribute("rooms", roomList);

        //닉네임 생성 서블릿
        if (userNickname != null && roomTitle == null) {
            System.out.println("닉네임: "+userNickname);
            session.setAttribute("userNickname", userNickname);
            session.setAttribute("rooms", roomList);

            String encodedChatId = URLEncoder.encode(userNickname, StandardCharsets.UTF_8);
            String redirectURL = "room-list.jsp?chatId=" + encodedChatId;
            response.sendRedirect(redirectURL);

            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 Bad Request
        }

        // 방 생성 서블릿
        if (roomTitle != null) {
            // userNickname을 session에서 가져옴
            String userNickname1 = (String) session.getAttribute("userNickname");
            // 방 생성 로직 (서버 데이터베이스에 방 추가 등)
            System.out.println("방이름: " + roomTitle + "생성 됐습니다.");
            System.out.println(userNickname1);

            // 성공적으로 방을 생성한 후, 클라이언트에 응답으로 성공 메시지를 보내거나 새로운 방 정보를 JSON으로 반환
            response.setCharacterEncoding("UTF-8");
            // HTML이 UTF-8 형식이라는 것을 브라우저에게 전달
            response.setContentType("text/html; charset=utf-8");;
//            String successMessage = "방이 성공적으로 생성되었습니다.";
//            response.getWriter().write(successMessage);
            Room room = new Room(roomTitle, 2);
            roomList.add(room);

            // userNickname이 null이면 기본값을 사용하거나 다른 처리를 할 수 있음


            String encodedChatId = URLEncoder.encode(userNickname1, StandardCharsets.UTF_8);
            String encodedRoomId = URLEncoder.encode(roomTitle, StandardCharsets.UTF_8);
            String redirectURL = "OmokAndChat.jsp?roomName="+encodedRoomId + "&chatId=" + encodedChatId;
            response.sendRedirect(redirectURL);

        }
    }
}