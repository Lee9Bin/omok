package com.gyub.omok.websocket;
import com.gyub.omok.domain.Board;
import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.PathParam;
import jakarta.websocket.server.ServerEndpoint;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;


@ServerEndpoint("/omok/{room}/{chatId}")
public class OmokServer {

    // 방 정보를 저장하는 맵 (동시성 지원)
    private static Map<String, Map<Session, String>> roomMap = new ConcurrentHashMap<>();
    // 각 방에 대한 오목판을 저장하는 맵
    private static Map<String, Board> roomBoards = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session, @PathParam("room") String room, @PathParam("chatId") String chatId) throws IOException {
        System.out.println("session id: " + session.getId() + " chatId: " + chatId + "님이 " + room + " 방에 들어왔습니다.");

        // 방에 대한 세션과 chatId를 묶어서 저장할 맵을 가져오거나 생성
        Map<Session, String> roomSessions = roomMap.get(room);

        // 방 정보가 없으면 새로운 맵을 생성하여 추가
        if (roomSessions == null) {
            roomSessions = new ConcurrentHashMap<>();
            roomMap.put(room, roomSessions);

            // 방에 대한 오목판을 생성하고 맵에 추가
            Board board = new Board();
            roomBoards.put(room, board);
        }

        roomSessions.put(session, chatId);

        // 방에 2명까지만 들어갈 수 있도록 크기를 체크하고 추가
        if (roomSessions.size() > 2) {
            // 2명 초과 시 메시지 전송 및 연결 종료
            session.getAsyncRemote().sendText("방에 이미 2명이 있습니다. 입장이 불가능합니다.");
            // jsp 소켓 세션 종료 -> jsp의 socket.close 메서드 실행
            session.close();
        }
    }

    @OnMessage
    public void onMessage(String message, Session senderSession, @PathParam("room") String room) {
        System.out.println(room + "번방에서 " + getChatId(senderSession, room) + "님이 보내온 메세지: " + message);

        // //메세지 처리하기
        // JsonParser jsonParser = new JsonParser();
        // JsonObject jsonObject = jsonParser.parse(message).getAsJsonObject();
        //
        // String event = jsonObject.get("event").getAsString();
        // if(event.equals("place_stone")) {
        //     String row = jsonObject.get("row").getAsString();
        //     String col = jsonObject.get("col").getAsString();
        //     String stone = jsonObject.get("stone").getAsString();
        //     System.out.println(row+","+col+","+stone);
        //
        //
        //     // 해당 방에 속한 오목판에 좌표 전달
        //     Board board = roomBoards.get(room);
        //     if (board != null) {
        //         System.out.println("돌을 두는 이벤트 발생");
        //         board.setStone(stone, row, col);
        //         if (board.check(stone)) {
        //             // 승자 정보 얻기
        //             String winner = getChatId(senderSession, room);
        //             System.out.println("경기종료");
        //             // 승자에게 알리기
        //             broadcastToRoom(room,winner);
        //             return;
        //         }
        //
        //     }
        //
        // }
        //
        // if(event.equals("msg")) {
        //     String chatId = jsonObject.get("chatId").getAsString();
        //     String content = jsonObject.get("content").getAsString();
        // }
        // Map<Session, String> roomSessions = roomMap.get(room);
        // if (roomSessions != null) {
        //     for (Map.Entry<Session, String> entry : roomSessions.entrySet()) {
        //         Session session = entry.getKey();
        //         if (!session.equals(senderSession)) {
        //             session.getAsyncRemote().sendText(message);
        //         }
        //     }
        // }
    }

    @OnClose
    public void onClose(Session session, @PathParam("room") String room) {
        System.out.println("클라이언트가 " + room + " 방을 나갔습니다.");

        // 방에 대한 세션 목록을 가져오고, 해당 세션을 제거
        Map<Session, String> roomSessions = roomMap.get(room);
        if (roomSessions != null) {
            roomSessions.remove(session);
        }
    }

    //보내온 세션의 chatId를 구하는 메서드
    private String getChatId(Session session, String room) {
        Map<Session, String> roomSessions = roomMap.get(room);
        if (roomSessions != null) {
            return roomSessions.get(session);
        }
        return null;
    }

    //승패 여부가 결정되면 메세지 전송
    private void broadcastToRoom(String room, String message) {
        // 방에 대한 세션 목록을 가져오기
        Map<Session, String> roomSessions = roomMap.get(room);
        // if (roomSessions != null) {
        //     // JSON 객체 생성
        //     JsonObject jsonMessage = new JsonObject();
        //     jsonMessage.addProperty("event", "end");
        //     jsonMessage.addProperty("winner", message);
        //
        //     String jsonString = jsonMessage.toString();
        //     // 방에 속한 모든 세션에게 메시지 전송
        //     for (Session session : roomSessions.keySet()) {
        //         session.getAsyncRemote().sendText(jsonString);
        //     }
        // }
    }
}