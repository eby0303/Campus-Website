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

@WebServlet("/index")
public class index extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get form data
            String productId = request.getParameter("productId");
            String productName = request.getParameter("productName");

            // Handle productPrice
            String priceParam = request.getParameter("productPrice");
            double productPrice = (priceParam != null && !priceParam.trim().isEmpty())
                    ? Double.parseDouble(priceParam)
                    : 0.0;

            // Handle productQty 
            String quantityParam = request.getParameter("productQty");
            int productQty = (quantityParam != null && !quantityParam.trim().isEmpty())
                    ? Integer.parseInt(quantityParam)
                    : 0;

            // Log the values for debugging
            // System.out.println("productId: " + productId);
            // System.out.println("productName: " + productName);
            // System.out.println("productPrice: " + productPrice);
            // System.out.println("productQty: " + productQty);

            // Update the cart table with the new data
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useSSL=false", "root",
                    "mysql0303");

            // Check if the product is already in cart
            String selectQuery = "SELECT * FROM cart WHERE productId=?";
            PreparedStatement selectStatement = con.prepareStatement(selectQuery);
            selectStatement.setString(1, productId);

            // Execute the select
            boolean productExists = selectStatement.executeQuery().next();

            if (productExists) {
                // Product already exists in the cart, update the quantity
                String updateQuery = "UPDATE cart SET productQty=? WHERE productId=?";
                PreparedStatement updateStatement = con.prepareStatement(updateQuery);
                updateStatement.setInt(1, productQty);
                updateStatement.setString(2, productId);

                // Execute the update
                updateStatement.executeUpdate();

                // Close the update statement
                updateStatement.close();
            } else {
                // Product not in the cart, insert a new entry
                String insertQuery = "INSERT INTO cart (productId, productName, productPrice, productQty) VALUES (?, ?, ?, ?)";
                PreparedStatement insertStatement = con.prepareStatement(insertQuery);
                insertStatement.setString(1, productId);
                insertStatement.setString(2, productName);
                insertStatement.setDouble(3, productPrice);
                insertStatement.setInt(4, productQty);

                // Execute the insert
                insertStatement.executeUpdate();

                // Close the insert statement
                insertStatement.close();
            }

            // Close the select statement and database connection
            selectStatement.close();
            con.close();

            // Send a success response
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
