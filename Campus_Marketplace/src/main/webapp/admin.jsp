<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Marketplace Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link rel="stylesheet" href="css/admin.css">
</head>
<body>
    <header>
        <div class="logo-container">
            <a href="admin.jsp"><img src="fcrit.ico" class="logo" alt="hello"></a>
        </div>
        <h1 class="admin-title">ADMIN PAGE</h1>
        <button class="logout-button" onclick="location.href='login.jsp';">Logout</button>
    </header>

    <section class="admin">
        <!-- Add Product section -->
        <div class="add-product-section">
            <h2>Add Product</h2>
            <!-- Add your form for adding a product here -->
            <button class="add-product-button" onclick="location.href='addPrd.jsp';">Add Product</button>
        </div>

        <!-- View Products section -->
        <div class="view-products-section">
            <h2>View Products</h2>
            <table id="adminTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Image Path</th>
                        <th>Action</th> <!-- New column for Remove button -->
                    </tr>
                </thead>
                <tbody>
                    <%
                    // Establishing a database connection
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet resultSet = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/login?useSSL=false", "root", "mysql0303");
                        statement = connection.createStatement();

                        // Fetching product details from the database
                        resultSet = statement.executeQuery("SELECT * FROM products");

                        // Displaying product details in the table
                        while (resultSet.next()) {
                            int id = resultSet.getInt("productId");
                            String name = resultSet.getString("productName");
                            double price = resultSet.getDouble("productPrice");
                            String desc = resultSet.getString("productDesc");
                            String imagePath = resultSet.getString("imagePath");

                            // Displaying product details in the table rows
                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + name + "</td>");
                            out.println("<td>" + price + "</td>");
                            out.println("<td>" + desc + "</td>");
                            out.println("<td>" + imagePath + "</td>");
                            // Add a Remove button
                            out.println("<td><button class='remove-item' data-product-id='" + id + "'>Remove</button></td>");
                            out.println("</tr>");
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        // Closing database resources
                        try {
                            if (resultSet != null) resultSet.close();
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                    %>
                </tbody>
            </table>
        </div>
    </section>
    
    <!-- Add this JavaScript code at the end of your JSP file, before the </body> tag -->
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Add a click event listener to all elements with class 'remove-item'
            document.querySelectorAll('.remove-item').forEach(function (button) {
                button.addEventListener('click', function () {
                    // Get the product ID from the 'data-product-id' attribute
                    var productId = this.getAttribute('data-product-id');

                    // Perform an asynchronous request to the server to remove the product
                    var xhr = new XMLHttpRequest();
          
                    xhr.open("POST", "http://localhost:5055/campus/admin", true);

                    // Set up the request header
                    xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                    xhr.onload = function () {
                        if (xhr.status === 200) {
                            // Product removed successfully, you can update the UI as needed
                            alert('Product removed successfully');
                            location.reload(); // Refresh the page for simplicity (you might want to update the UI dynamically)
                        } else {
                            // Display an error message or handle the error accordingly
                            alert('Error removing product');
                        }
                    };
                    // Send the product ID as a parameter to the server
                    xhr.send('productId=' + productId);
                });
            });
        });
    </script>
</body>
</html>
