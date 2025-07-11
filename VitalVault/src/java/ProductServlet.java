import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.util.*;

public class ProductServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:derby://localhost:1527/VitalVaultDB";
    private static final String DB_USER = "app";
    private static final String DB_PASS = "app";

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<Map<String, String>> products = new ArrayList<>();

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM Product");

            while (rs.next()) {
                Map<String, String> p = new HashMap<>();
                p.put("id", rs.getString("UniqueID"));
                p.put("name", rs.getString("productName"));
                p.put("price", rs.getString("price"));
                p.put("stock", rs.getString("stockQuantity"));
                p.put("categoryID", rs.getString("categoryID"));
                p.put("supplierID", rs.getString("supplierID"));
                products.add(p);
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        req.setAttribute("products", products);
        RequestDispatcher dispatcher = req.getRequestDispatcher("product.jsp");
        dispatcher.forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        String id = req.getParameter("id");
        String name = req.getParameter("name");
        String price = req.getParameter("price");
        String stock = req.getParameter("stock");
        String categoryID = req.getParameter("categoryID");
        String supplierID = req.getParameter("supplierID");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);

            if ("create".equals(action)) {
                String sql = "INSERT INTO Product (productName, price, stockQuantity, categoryID, supplierID) VALUES (?, ?, ?, ?, ?)";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setInt(3, Integer.parseInt(stock));
                ps.setInt(4, Integer.parseInt(categoryID));
                ps.setInt(5, Integer.parseInt(supplierID));
                ps.executeUpdate();
                ps.close();
                System.out.println("Product created: " + name);
            } else if ("update".equals(action)) {
                String sql = "UPDATE Product SET productName=?, price=?, stockQuantity=?, categoryID=?, supplierID=? WHERE UniqueID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, name);
                ps.setDouble(2, Double.parseDouble(price));
                ps.setInt(3, Integer.parseInt(stock));
                ps.setInt(4, Integer.parseInt(categoryID));
                ps.setInt(5, Integer.parseInt(supplierID));
                ps.setInt(6, Integer.parseInt(id));
                ps.executeUpdate();
                ps.close();
                System.out.println("Product updated: ID = " + id);
            } else if ("delete".equals(action)) {
                String sql = "DELETE FROM Product WHERE UniqueID=?";
                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(id));
                ps.executeUpdate();
                ps.close();
                System.out.println("Product deleted: ID = " + id);
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        res.sendRedirect("ProductServlet");
    }
}
