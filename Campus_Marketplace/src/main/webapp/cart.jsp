<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Marketplace</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link rel="stylesheet" href="css/cart.css">
    <script type="text/javascript" src="js/cart.js"></script>
</head>
<body>
     <section id="header">
        <a href="index.jsp"><img src="fcrit.ico" class="logo" alt="hello"></a>
        <div>
            <ul id="nav">
                
                    <div class="top-bar-items">
                        <select class="selectinput" name="" id="">
                            <option class="selectinput" value="mech">MECHANICAL</option>
                            <option value="it">IT</option>
                            <option value="comp">COMPUTER</option>
                            <option value="elec">ELECTRICAL</option>
                            <option value="extc">EXTC</option>
                            <option value="faculty">FACULTY</option>
                        </select>
                   
                    <div class="top-bar-items">
                        <input class="selectinput search" type="search" name="" id="" placeholder="Search"/>
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </div>
                </div>
                <li><a href="elec.jsp">Electronics</a></li>
                <li><a href="books.jsp">Books</a></li>
                <li><a href="cart.jsp"><i class="fa-solid fa-bag-shopping"></i></a></li>
                <li><a href="login.jsp">Logout</a></li>
            </ul>
        </div>
    </section>

    <section class="cart">
        <table id="cartTable">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total Price</th>
                    <th>Action</th> 
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
                        resultSet = statement.executeQuery("SELECT * FROM cart");

                        // Displaying product details in the table
                        double grandTotal = 0.0; // To store the total price of all products
                        while (resultSet.next()) {
                            int id = resultSet.getInt("productId");
                            String name = resultSet.getString("productName");
                            double price = resultSet.getDouble("productPrice");
                            int quantity = resultSet.getInt("productQty"); // You can fetch this value from user input or session

                            // Calculating total price for each product
                            double totalPrice = price * quantity;
                            grandTotal += totalPrice; // Add to the grand total

                            // Displaying product details in the table rows
                            out.println("<tr>");
                            out.println("<td>" + id + "</td>");
                            out.println("<td>" + name + "</td>");
                            out.println("<td>" + price + "</td>");
                            out.println("<td>" + quantity + "</td>");
                            out.println("<td>" + totalPrice + "</td>");
                            // Add a Remove button
                            out.println("<td><button class='remove-item' data-product-id='" + id + "'>Remove</button></td>");
                            out.println("</tr>");
                        }

                        // Display the grand total row
                        out.println("<tr>");
                        out.println("<td colspan='4'>Grand Total</td>");
                        out.println("<td colspan='2'>" + grandTotal + "</td>");
                        out.println("</tr>");

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
    </section>
    
    <section class="checkout-button">
    <button id="checkoutButton" onclick="checkout()">Checkout</button>
</section>


</body>
</html>
