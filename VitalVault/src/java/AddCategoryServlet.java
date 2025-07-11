import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/AddCategoryServlet")
public class AddCategoryServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String name = request.getParameter("categoryName");

        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            Connection conn = DriverManager.getConnection("jdbc:derby://localhost:1527/VitalVaultDB", "app", "app");
            PreparedStatement ps = conn.prepareStatement("INSERT INTO Category (categoryName) VALUES (?)");
            ps.setString(1, name);
            ps.executeUpdate();
            ps.close();
            conn.close();
            response.sendRedirect("category.jsp");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
