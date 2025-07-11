import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/AddSupplierServlet")
public class AddSupplierServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("supplierName");
        String contact = request.getParameter("contactInfo");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Supplier (supplierName, contactInfo) VALUES (?, ?)");
            ps.setString(1, name);
            ps.setString(2, contact);
            ps.executeUpdate();
            ps.close();
            conn.close();
            response.sendRedirect("supplier.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
