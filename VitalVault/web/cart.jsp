<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*,java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
    <title>Your Cart</title>
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
<%-- Rest of the original cart.jsp content remains exactly the same --%>
<%
    Map cart = (Map) session.getAttribute("cart");
    if (cart == null || cart.isEmpty()) {
%>
    <h2>Your cart is empty.</h2>
    <a href="ViewProductServlet" class="dashboard-btn">Back to Products</a>
<%
    return;
    }

    double total = 0;
%>

<h2>Your Cart</h2>
<table border="1" cellpadding="8">
    <tr><th>Product</th><th>Unit Price</th><th>Quantity</th><th>Subtotal</th></tr>
<%
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

<form action="CheckoutServlet" method="post">
    <input type="submit" value="Pay Now">
</form>

    <a href="ViewProductServlet" class="dashboard-btn">Back to Products</a>
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