package com.campuslogin;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin")
public class removeProduct extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get product ID from the request
            String productIdStr = request.getParameter("productId");

            // Convert product ID to integer
            int productId = (productIdStr != null && !productIdStr.trim().isEmpty())
                    ? Integer.parseInt(productIdStr)
                    : 0;

            // Delete product from database
            deleteProduct(productId);

            // Sendresponse
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }

    // Method to delete a product from the database
    private void deleteProduct(int productId) throws SQLException, ClassNotFoundException {
        
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Establish a database connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useSSL=false", "root", "mysql0303");

            // Delete product by ID
            String deleteQuery = "DELETE FROM products WHERE productId = ?";
            preparedStatement = connection.prepareStatement(deleteQuery);
            preparedStatement.setInt(1, productId);
            preparedStatement.executeUpdate();
        } finally {
            // Close database resources
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
    }
}
