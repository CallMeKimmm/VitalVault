<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
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
    <div class="container">
<%
    // Get user ID from session
    Integer userID = (Integer) session.getAttribute("userID");
    String username = "", email = "", role = "";

    if (userID != null) {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");

            String sql = "SELECT * FROM Users WHERE userID = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                username = rs.getString("username");
                email = rs.getString("email");
                role = rs.getString("role");
            }

            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("login.jsp"); // User not logged in
    }
%>
    <h1>My Profile</h1>
    <p><strong>Username:</strong> <%= username %></p>
    <p><strong>Email:</strong> <%= email %></p>
    <p><strong>Role:</strong> <%= role %></p>

    <h2>Quick Links</h2>
        <div class="button-grid">
            <a href="PaymentHistoryServlet" class="dashboard-btn">Payment History</a>
            <a href="supplier.jsp" class="dashboard-btn">Suppliers</a>
            <a href="dashboard.jsp" class="dashboard-btn">Back to Dashboard</a><br>
            <a href="home.jsp" class="dashboard-btn">Logout</a>
        </div>
    </div>
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