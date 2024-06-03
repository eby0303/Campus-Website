package com.campuslogin;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@WebServlet("/addPrd")
@MultipartConfig
public class addPrd extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String productDesc = request.getParameter("productDesc");

        InputStream inputStream = null; // Input stream of the upload file

       
        Part filePart = request.getPart("productImage");

        if (filePart != null) {
            // Prints out some information for debugging
            System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());

            // Obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }

        Connection conn = null; // Connection to the database
        String message = null; // Message will be sent back to the JSP page

        try {
        	
            // Log the values for debugging
        	   
           
            // Load the JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish the connection
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useSSL=false", "root",
                "mysql0303");

            // SQL query to insert data into the products table
            String sql = "INSERT INTO products (productName, productPrice, productDesc, imagePath) VALUES (?, ?, ?, ?)";
           
            try (PreparedStatement statement = conn.prepareStatement(sql)) {
                statement.setString(1, productName);
                statement.setString(2, productPrice);
                statement.setString(3, productDesc);

                if (inputStream != null) {
                    // Fetches the default file name of the client's file
                    String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                    statement.setString(4, fileName);

                    // Saves the file on server
                    Path path = Paths.get(getServletContext().getRealPath("/uploads") + File.separator + fileName);
                    Files.copy(inputStream, path, StandardCopyOption.REPLACE_EXISTING);
                   
                }

                // Execute the statement
                int rows = statement.executeUpdate();
                if (rows > 0) {
                    message = "Product added successfully!";
                } else {
                    message = "Failed to add product.";
                }
           
           
            }
      
        } catch (Exception e) {
            message = "Error: " + e.getMessage();
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (inputStream != null) {
                inputStream.close();
            }
        }

        // Set message in request scope
        request.setAttribute("message", message);

        // Forward to the message page
        getServletContext().getRequestDispatcher("/admin.jsp").forward(request, response);
    }
}





