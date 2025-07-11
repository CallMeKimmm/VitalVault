import java.io.IOException;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ViewProductServlet")
public class ViewProductServlet extends HttpServlet {
    private static final String DB_URL  = "jdbc:derby://localhost:1527/VitalVaultDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        List products = new ArrayList();

        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM Product");

            while (rs.next()) {
                Map p = new HashMap();
                p.put("id", new Integer(rs.getInt("UniqueID")));
                p.put("name", rs.getString("productName"));
                p.put("price", new Double(rs.getDouble("price")));
                p.put("stock", new Integer(rs.getInt("stockQuantity")));
                products.add(p);
            }

            req.setAttribute("products", products);
            RequestDispatcher dispatcher = req.getRequestDispatcher("viewProduct.jsp");
            dispatcher.forward(req, res);

        } catch (Exception e) {
            throw new ServletException(e);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        int productId = Integer.parseInt(req.getParameter("productId"));
        int qty       = Integer.parseInt(req.getParameter("quantity"));

        HttpSession session = req.getSession();
        Map cart = (Map) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap();
        }

        Integer existingQty = (Integer) cart.get(new Integer(productId));
        if (existingQty != null) {
            cart.put(new Integer(productId), new Integer(existingQty.intValue() + qty));
        } else {
            cart.put(new Integer(productId), new Integer(qty));
        }

        session.setAttribute("cart", cart);
        res.sendRedirect("ViewProductServlet");
    }
}
