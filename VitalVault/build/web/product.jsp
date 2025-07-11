<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
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
    <h2>Product List</h2>
    <table border="1">
        <tr>
            <th>ID</th><th>Name</th><th>Price</th><th>Stock</th><th>Category ID</th><th>Supplier ID</th><th>Actions</th>
        </tr>

        <%
            List<Map<String, String>> products = (List<Map<String, String>>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Map<String, String> p : products) {
        %>
        <tr>
            <form action="ProductServlet" method="post">
                <td><input type="text" name="id" value="<%= p.get("id") %>" readonly></td>
                <td><input type="text" name="name" value="<%= p.get("name") %>" required></td>
                <td><input type="number" name="price" value="<%= p.get("price") %>" step="0.01" required></td>
                <td><input type="number" name="stock" value="<%= p.get("stock") %>" required></td>
                <td><input type="number" name="categoryID" value="<%= p.get("categoryID") %>" required></td>
                <td><input type="number" name="supplierID" value="<%= p.get("supplierID") %>" required></td>
                <td>
                    <button type="submit" name="action" value="update">Update</button>
                    <button type="submit" name="action" value="delete">Delete</button>
                </td>
            </form>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="7">No products found or error fetching data.</td></tr>
        <%
            }
        %>
    </table>

    <h3>Add New Product</h3>
    <form action="ProductServlet" method="post">
        Name: <input type="text" name="name" required><br>
        Price: <input type="number" name="price" step="0.01" required><br>
        Stock Quantity: <input type="number" name="stock" required><br>
        Category ID: <input type="number" name="categoryID" required><br>
        Supplier ID: <input type="number" name="supplierID" required><br>
        <button type="submit" name="action" value="create">Add Product</button>
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