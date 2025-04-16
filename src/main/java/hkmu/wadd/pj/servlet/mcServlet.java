package hkmu.wadd.pj.servlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "mcServlet", value = "/mc-servlet")
public class mcServlet extends HttpServlet {
    private final String[] mcQuestions = {
            "What is your favourite University?",
            "How you rate your Ulife in HKMU?",
            "Which public transport you perfer to take to school?",
            "What facilities you want to have in HKMU?",
            "How old are you?"
    };

    private final String[][] mcOptions = {
            {"MU", "MUHK", "Metropolitan University", "HKMU"},
            {"Very Excellent", "Excellent", "Good", " Very Good"},
            {"MTR", "Bus", "Minibus", "Walking"},
            {"Library", "Gym", "Study Room", "Sports Facility"},
            {"Under 18", "18-20", "21-23", "Over 24"}
    };

    private int[][] votes = new int[5][4];

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>HKMU Poll System</h1>");
        for (int i = 0; i < mcQuestions.length; i++) {
            out.println("<div class='poll'>");
            out.println("<h2>" + mcQuestions[i] + "</h2>");
            out.println("<form method='post' action='mc-servlet'>");
            out.println("<input type='hidden' name='mcId' value='" + i + "'>");

            for (int j = 0; j < mcOptions[i].length; j++) {
                out.println("<input type='radio' name='option' value='" + j + "'> ");
                out.println(mcOptions[i][j] + " (" + votes[i][j] + " votes)<br>");
            }

            out.println("<br><input type='submit' value='Vote'>");
            out.println("</form></div>");
        }

        out.println("</body></html>");
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            String mcIdStr = request.getParameter("mcId");
            String optionStr = request.getParameter("option");

            if (mcIdStr == null || optionStr == null) {
                throw new Exception("Missing required parameters");
            }

            int mcId = Integer.parseInt(mcIdStr);
            int optionId = Integer.parseInt(optionStr);

            votes[mcId][optionId]++;

            out.println("<html><head><title>Vote Submitted</title></head>");
            out.println("<body><h1>Thank you for voting!</h1>");
            out.println("<p>You voted for: <strong>" + mcOptions[mcId][optionId] + "</strong></p>");
            out.println("<p>Question: " + mcQuestions[mcId] + "</p>");
            out.println("<a href='mc-servlet'>Return to polls</a>");

        }catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.println("<html><body><h1>Error</h1>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("<a href='mc-servlet'>Back to polls</a>");
            out.println("</body></html>");}
    }

    public void destroy() {
    }
}