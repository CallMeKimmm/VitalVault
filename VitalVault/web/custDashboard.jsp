<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard - VitalVault</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <style>

    </style>
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
    <h1>Welcome to VitalVault! A Healthcare Equipment Inventory & Sales System

</h1>
    <div class="button-grid">
        <a href="ViewProductServlet" class="dashboard-btn">Browse Products</a>
        <a href="cart.jsp" class="dashboard-btn">View Cart & Checkout</a>
        <a href="PaymentHistoryServlet" class="dashboard-btn">Payment History</a>
        <a href="custCategory.jsp" class="dashboard-btn">Category</a>
        <a href="custProfile.jsp" class="dashboard-btn">My Profile</a>
        <a href="home.jsp" class="dashboard-btn">Logout</a>
    </div>
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
