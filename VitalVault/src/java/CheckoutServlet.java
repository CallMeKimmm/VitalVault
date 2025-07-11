import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    private static final String DB_URL  = "jdbc:derby://localhost:1527/VitalVaultDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Map cart = (Map) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            res.sendRedirect("cart.jsp");
            return;
        }

        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdateStock = null;
        PreparedStatement psInsertOrder = null;
        PreparedStatement psInsertOrderProduct = null;
        ResultSet generatedKeys = null;

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            conn.setAutoCommit(false);  // Start transaction

            int userID = ((Integer) session.getAttribute("userID")).intValue();
            double totalAmount = 0;

            // For calculating total
            psSelect = conn.prepareStatement("SELECT price, stockQuantity FROM Product WHERE UniqueID = ?");
            Iterator cartIterator = cart.entrySet().iterator();
            while (cartIterator.hasNext()) {
                Map.Entry entry = (Map.Entry) cartIterator.next();
                int pid = ((Integer) entry.getKey()).intValue();
                int qty = ((Integer) entry.getValue()).intValue();

                psSelect.setInt(1, pid);
                ResultSet rs = psSelect.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stockQuantity");

                    if (qty > stock) {
                        throw new ServletException("Not enough stock for product ID: " + pid);
                    }

                    totalAmount += price * qty;
                }
                rs.close();
            }

            // Insert order
            psInsertOrder = conn.prepareStatement(
                "INSERT INTO Orders (orderDate, status, totalAmount, userID) VALUES (?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS
            );

            psInsertOrder.setDate(1, new java.sql.Date(System.currentTimeMillis()));
            psInsertOrder.setString(2, "Paid");
            psInsertOrder.setDouble(3, totalAmount);
            psInsertOrder.setInt(4, userID);
            psInsertOrder.executeUpdate();

            generatedKeys = psInsertOrder.getGeneratedKeys();
            int orderID = -1;
            if (generatedKeys.next()) {
                orderID = generatedKeys.getInt(1);
            } else {
                throw new ServletException("Order ID not generated.");
            }

            // Prepare statements for stock update and order-product insert
            psUpdateStock = conn.prepareStatement("UPDATE Product SET stockQuantity = ? WHERE UniqueID = ?");
            psInsertOrderProduct = conn.prepareStatement(
                "INSERT INTO OrderProduct (quantity, price, orderID, productID) VALUES (?, ?, ?, ?)"
            );

            // Reprocess cart to insert order-product and update stock
            cartIterator = cart.entrySet().iterator();
            while (cartIterator.hasNext()) {
                Map.Entry entry = (Map.Entry) cartIterator.next();
                int pid = ((Integer) entry.getKey()).intValue();
                int qty = ((Integer) entry.getValue()).intValue();

                psSelect.setInt(1, pid);
                ResultSet rs = psSelect.executeQuery();
                if (rs.next()) {
                    double price = rs.getDouble("price");
                    int stock = rs.getInt("stockQuantity");

                    // Insert into OrderProduct
                    psInsertOrderProduct.setInt(1, qty);
                    psInsertOrderProduct.setDouble(2, price);
                    psInsertOrderProduct.setInt(3, orderID);
                    psInsertOrderProduct.setInt(4, pid);
                    psInsertOrderProduct.executeUpdate();

                    // Update stock
                    int newStock = stock - qty;
                    psUpdateStock.setInt(1, newStock);
                    psUpdateStock.setInt(2, pid);
                    psUpdateStock.executeUpdate();
                }
                rs.close();
            }

            conn.commit(); // Everything okay, commit
            session.removeAttribute("cart");

            // Show confirmation
            res.setContentType("text/html");
            PrintWriter out = res.getWriter();
            out.println("<h2>Payment Successful!</h2>");
            out.println("<p>Your order ID is: " + orderID + "</p>");
            out.println("<a href='ViewProductServlet' class=\"dashboard-btn\">Back to Products</a>");

        } catch (Exception e) {
            try {
                if (conn != null) conn.rollback();
            } catch (SQLException ignored) {}
            throw new ServletException("Checkout failed: " + e.getMessage(), e);
        } finally {
            try { if (psSelect != null) psSelect.close(); } catch (Exception ignored) {}
            try { if (psUpdateStock != null) psUpdateStock.close(); } catch (Exception ignored) {}
            try { if (psInsertOrder != null) psInsertOrder.close(); } catch (Exception ignored) {}
            try { if (psInsertOrderProduct != null) psInsertOrderProduct.close(); } catch (Exception ignored) {}
            try { if (generatedKeys != null) generatedKeys.close(); } catch (Exception ignored) {}
            try { if (conn != null) conn.close(); } catch (Exception ignored) {}
        }
    }
}
