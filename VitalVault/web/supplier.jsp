<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Supplier Management</title>
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
    List suppliers = new ArrayList();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Supplier");

        while (rs.next()) {
            Map sup = new HashMap();
            sup.put("id", rs.getInt("supplierID"));
            sup.put("name", rs.getString("supplierName"));
            sup.put("contact", rs.getString("contactInfo"));
            suppliers.add(sup);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
    <h2>Suppliers</h2>
    <table border="1">
        <tr><th>ID</th><th>Name</th><th>Contact Info</th></tr>
        <%
            for (int i = 0; i < suppliers.size(); i++) {
                Map sup = (Map) suppliers.get(i);
        %>
        <tr>
            <td><%= sup.get("id") %></td>
            <td><%= sup.get("name") %></td>
            <td><%= sup.get("contact") %></td>
        </tr>
        <% } %>
    </table>

    <h3>Add New Supplier</h3>
    <form action="AddSupplierServlet" method="post">
        <label>Name:</label>
        <input type="text" name="supplierName" required><br>
        <label>Contact Info:</label>
        <input type="text" name="contactInfo" required><br>
        <input type="submit" value="Add">
    </form>

    <br><a href="dashboard.jsp" class="dashboard-btn">Back to Dashboard</a>
<footer class="site-footer">
  <div class="footer-container">
    <div class="footer-logo">
      <img src="${pageContext.request.contextPath}/image/vitalvaultlogo.png" alt="Healthcare Logo" />
      <p>© 2025 VitalVault Team</p>
    </div>

    <div class="footer-nav">
      <h4>Quick Links</h4>
      <ul>
        <li><a href="dashboard.jsp">Dashboard</a></li>
        <li><a href="ProductServlet">Manage Products</a></li>
        <li><a href="PaymentHistoryServlet">Payment History</a></li>
        <li><a href="category.jsp">Category</a></li>
      </ul>
    </div>

    <div class="footer-contact">
      <h4>Contact Us</h4>
      <p>Email: support@vitalvault.com</p>
      <p>Phone: +60 12-345 6789</p>
      <div class="social-icons">
        <a href="#"><img src="${pageContext.request.contextPath}/image/fb.png" alt="Facebook" /></a>
        <a href="#"><img src="${pageContext.request.contextPath}/image/igicon.png" alt="Instagram" /></a>
        <a href="#"><img src="${pageContext.request.contextPath}/image/x.png" alt="X" /></a>
      </div>
    </div>
  </div>
</footer>
</body>
</html>