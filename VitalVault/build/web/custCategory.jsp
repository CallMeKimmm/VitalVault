<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Category Management</title>
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
    List categories = new ArrayList();

    try {
        Class.forName("org.apache.derby.jdbc.ClientDriver");
        Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT * FROM Category");

        while (rs.next()) {
            Map cat = new HashMap();
            cat.put("id", rs.getInt("categoryID"));
            cat.put("name", rs.getString("categoryName"));
            categories.add(cat);
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
    <h2>Categories</h2>
    <table border="1">
        <tr><th>ID</th><th>Name</th></tr>
        <%
            for (int i = 0; i < categories.size(); i++) {
                Map cat = (Map) categories.get(i);
        %>
        <tr>
            <td><%= cat.get("id") %></td>
            <td><%= cat.get("name") %></td>
        </tr>
        <% } %>
    </table>

    <br><a href="custDashboard.jsp" class="dashboard-btn">Back to Dashboard</a>
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