<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>View Products</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</head>
<body>
<header class="site-header">
    <div class="header-container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/image/vitalvaultlogo.png" alt="VitalVault Logo">
        </div>
    </div>
</header>
<%
    List products = (List) request.getAttribute("products");

    Map cart = (Map) session.getAttribute("cart");
    if (cart == null) cart = new LinkedHashMap();
%>
    <h1>Products</h1>
    <table border="1" cellpadding="8">
        <tr><th>Name</th><th>Price</th><th>Stock</th><th>Qty</th><th>Action</th></tr>
    <%
        for (int i = 0; i < products.size(); i++) {
            Map p = (Map) products.get(i);
    %>
        <tr>
            <td><%= p.get("name") %></td>
            <td><%= String.format("%.2f", p.get("price")) %></td>
            <td><%= p.get("stock") %></td>
            <td>
                <form action="ViewProductServlet" method="post">
                    <input type="hidden" name="productId" value="<%= p.get("id") %>">
                    <input type="number" name="quantity" value="1" min="1" max="<%= p.get("stock") %>" required>
            </td>
            <td>
                    <button type="submit">Add to Cart</button>
                </form>
            </td>
        </tr>
    <%
        }
    %>
    </table>

    <h2>Your Cart</h2>
    <%
        if (cart.isEmpty()) {
    %>
    <p>Your cart is empty.</p>
    <%
        } else {
            double total = 0;

            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");
            PreparedStatement ps = conn.prepareStatement("SELECT productName, price FROM Product WHERE UniqueID = ?");

            Set entrySet = cart.entrySet();
            Iterator it = entrySet.iterator();
            while (it.hasNext()) {
                Map.Entry entry = (Map.Entry) it.next();
                int pid = ((Integer) entry.getKey()).intValue();
                int qty = ((Integer) entry.getValue()).intValue();

                ps.setInt(1, pid);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    String name = rs.getString("productName");
                    double price = rs.getDouble("price");
                    double subtotal = price * qty;
                    total += subtotal;
    %>
        <tr>
            <td><%= name %></td>
            <td><%= String.format("%.2f", price) %></td>
            <td><%= qty %></td>
            <td><%= String.format("%.2f", subtotal) %></td>
        </tr>
    <%
                }
                rs.close();
            }

            ps.close();
            conn.close();
    %>
        <tr>
            <td colspan="3" align="right"><strong>Total:</strong></td>
            <td><strong><%= String.format("%.2f", total) %></strong></td>
        </tr>
    </table>
    <%
        }
    %>
    <div class="button-grid">
        <a href="custDashboard.jsp" class="dashboard-btn">Back to Dashboard</a>
    </div>
<footer class="site-footer">
  <div class="footer-container">
    <div class="footer-logo">
      <img src="image/vitalvaultlogo.png" alt="Healthcare Logo" />
      <p>© 2025 VitalVault Team</p>
    </div>

    <div class="footer-nav">
      <h4>Quick Links</h4>
      <ul>
        <li><a href="custDashboard.jsp">Dashboard</a></li>
        <li><a href="ViewProductServlet">Browse Products</a></li>
        <li><a href="PaymentHistoryServlet">Payment History</a></li>
        <li><a href="custCategory.jsp">Category</a></li>
      </ul>
    </div>

    <div class="footer-contact">
      <h4>Contact Us</h4>
      <p>Email: support@vitalvault.com</p>
      <p>Phone: +60 12-345 6789</p>
      <div class="social-icons">
        <a href="#"><img src="image/fb.png" alt="Facebook" /></a>
        <a href="#"><img src="image/igicon.png" alt="Instagram" /></a>
        <a href="#"><img src="image/x.png" alt="X" /></a>
      </div>
    </div>
  </div>
</footer>
</body>
</html>