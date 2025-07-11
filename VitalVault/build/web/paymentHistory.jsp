<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment History</title>
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
    List orders = (List) request.getAttribute("orders");
    String role = (String) session.getAttribute("role");
%>
    <h2>Payment History</h2>
    <table border="1" cellpadding="8">
        <tr>
            <th>Order ID</th>
            <th>Date</th>
            <th>Total Amount</th>
            <% if ("admin".equals(role)) { %><th>User</th><% } %>
        </tr>
    <%
        for (int i = 0; i < orders.size(); i++) {
            Map o = (Map) orders.get(i);
    %>
        <tr>
            <td><%= o.get("orderID") %></td>
            <td><%= o.get("date") %></td>
            <td><%= String.format("%.2f", o.get("total")) %></td>
            <% if ("admin".equals(role)) { %>
            <td><%= o.get("user") %></td>
            <% } %>
        </tr>
    <% } %>
    </table>

    <a href="<%= "admin".equals(role) ? "dashboard.jsp" : "custDashboard.jsp" %>" class="dashboard-btn">Back</a>
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