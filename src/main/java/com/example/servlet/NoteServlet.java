package com.example.servlet;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.*;
import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/notes/*")
public class NoteServlet extends HttpServlet {

    // In-memory storage (for demo purposes - use database in production)
    private static List<Map<String, Object>> notes = Collections.synchronizedList(new ArrayList<>());
    private static int nextId = 1;
    private static Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.addHeader("Access-Control-Allow-Origin", "*");

        // Get all notes
        response.getWriter().write(gson.toJson(notes));
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.addHeader("Access-Control-Allow-Origin", "*");

        try {
            // Read request body
            BufferedReader reader = request.getReader();
            JsonObject jsonRequest = gson.fromJson(reader, JsonObject.class);

            String author = jsonRequest.get("author").getAsString();
            String content = jsonRequest.get("content").getAsString();

            // Create note
            Map<String, Object> note = new HashMap<>();
            note.put("id", nextId++);
            note.put("author", author);
            note.put("content", content);
            note.put("timestamp", LocalDateTime.now().toString());

            notes.add(0, note); // Add to beginning

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(note));

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.addHeader("Access-Control-Allow-Origin", "*");

        try {
            String pathInfo = request.getPathInfo();
            if (pathInfo == null || pathInfo.length() <= 1) {
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                response.getWriter().write("{\"error\": \"Note ID required\"}");
                return;
            }

            int id = Integer.parseInt(pathInfo.substring(1));

            // Find and delete note
            boolean found = notes.removeIf(note -> (int) note.get("id") == id);

            if (found) {
                response.setStatus(HttpServletResponse.SC_OK);
                response.getWriter().write("{\"success\": true}");
            } else {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write("{\"error\": \"Note not found\"}");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\": \"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.addHeader("Access-Control-Allow-Origin", "*");
        response.addHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
        response.addHeader("Access-Control-Allow-Headers", "Content-Type");
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
