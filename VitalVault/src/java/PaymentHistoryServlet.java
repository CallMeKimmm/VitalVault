import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/PaymentHistoryServlet")
public class PaymentHistoryServlet extends HttpServlet {
    private static final String DB_URL  = "jdbc:derby://localhost:1527/VitalVaultDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        int userID = (Integer) session.getAttribute("userID");
        String role = (String) session.getAttribute("role");

        List orders = new ArrayList();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            String sql = "SELECT o.orderID, o.orderDate, o.totalAmount, u.username FROM Orders o JOIN Users u ON o.userID = u.userID";
            if ("customer".equalsIgnoreCase(role)) {
                sql += " WHERE o.userID = ?";
            }

            PreparedStatement ps = conn.prepareStatement(sql);
            if ("customer".equalsIgnoreCase(role)) {
                ps.setInt(1, userID);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map o = new HashMap();
                o.put("orderID", rs.getInt("orderID"));
                o.put("date", rs.getDate("orderDate"));
                o.put("total", rs.getDouble("totalAmount"));
                o.put("user", rs.getString("username"));
                orders.add(o);
            }

            rs.close();
            ps.close();
            conn.close();

            req.setAttribute("orders", orders);
            req.getRequestDispatcher("paymentHistory.jsp").forward(req, res);

        } catch (Exception e) {
            throw new ServletException("Failed to load history", e);
        }
    }
}
