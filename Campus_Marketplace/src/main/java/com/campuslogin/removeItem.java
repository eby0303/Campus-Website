package com.campuslogin;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/cart")
public class removeItem extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        // Retrieve the product ID from the request
        String productId = request.getParameter("productId");

        if (productId != null) {
            try {
                // Establish a database connection
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useSSL=false", "root", "mysql0303");

                // Prepare a statement to delete the item from the cart
                String deleteQuery = "DELETE FROM cart WHERE productId=?";
                PreparedStatement preparedStatement = connection.prepareStatement(deleteQuery);
                preparedStatement.setString(1, productId);

                // Execute the delete statement
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    // If the deletion was successful
                    out.println("Item removed successfully");
                } else {
                    out.println("Item not found or couldn't be removed");
                }

                // Close resources
                preparedStatement.close();
                connection.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("Error removing item");
            }
        } else {
            out.println("Invalid request");
        }
    }
}


