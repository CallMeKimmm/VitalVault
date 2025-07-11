<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
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
    <h1>Welcome Admin!</h1>
    <div class="button-grid">
        <a href="ProductServlet" class="dashboard-btn">Manage Products</a>
        <a href="PaymentHistoryServlet" class="dashboard-btn">Payment History</a>
        <a href="category.jsp" class="dashboard-btn">Category</a>
        <a href="supplier.jsp" class="dashboard-btn">Suppliers</a>
        <a href="profile.jsp" class="dashboard-btn">My Profile</a>
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