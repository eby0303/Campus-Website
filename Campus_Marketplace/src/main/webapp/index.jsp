<%
if (session.getAttribute("name") == null) {
    System.out.println("Redirecting to login.jsp because the user is not logged in.");
    response.sendRedirect("login.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Campus Marketplace</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link rel="stylesheet" href="css/index.css">
    
</head>
<body>
    <section id="header">
        <a href="index.jsp"><img src="images/fcrit.ico" class="logo" alt="hello"></a>
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

    <section class="products" id="productSection">
        <!-- Product 1 -->
        <div class="product">
            <img src="images/drafterimg.jpg" alt="Drafter" >
            <div class="product-details">
                <h3>Drafter</h3>
                <p>Description: Precision meets creativity with our professional drafter, designed for architects and artists alike. Create detailed sketches and accurate drawings effortlessly.</p>
                <p>Price: ₹150</p>
                <form class="product-form" action="index" method="post">
                    <input type="hidden" name="productId" value="1">
                    <input type="hidden" name="productName" value="Drafter">
                    <input type="hidden" name="productPrice" value="150">
                    <label for="product1Qty">Quantity:</label>
                    <input type="number" id="product1Qty" name="productQty" value="1" min="1">
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </div>

        <div class="product">
            <img src="images/calcimg.jpg" alt="Calculator">
            <div class="product-details">
                <h3>Calculator</h3>
                <p>Description: Enhance your mathematical capabilities with our advanced scientific calculator, featuring functions for complex calculations, statistical analysis, and more</p>
                <p>Price: ₹600</p>
                <form class="product-form" action="index" method="post">
                    <input type="hidden" name="productId" value="2">
                    <input type="hidden" name="productName" value="Calculator">
                    <input type="hidden" name="productPrice" value="600">
                    <label for="product2Qty">Quantity:</label>
                    <input type="number" id="product2Qty" name="productQty" value="1" min="1">
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </div>
        
        
        <div class="product">
            <img src="images/EM3.jpg" alt="EM3">
            <div class="product-details">
                <h3>EM 3 Kumbhojkar</h3>
                <p>Description: . Dive into a world of advanced calculus, differential equations, and linear algebra with this comprehensive guide tailored to meet the specific needs of engineering students. Kumbhojkar's renowned clarity in explanation is your key to mastering complex mathematical concepts, supported by a wealth of examples and real-world applications.</p>
                <p>Price: ₹350</p>
                <form class="product-form" action="index" method="post">
                    <input type="hidden" name="productId" value="3">
                    <input type="hidden" name="productName" value="EM 3 Kumbhojkar">
                    <input type="hidden" name="productPrice" value="350">
                    <label for="product2Qty">Quantity:</label>
                    <input type="number" id="product2Qty" name="productQty" value="1" min="1">
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </div>
        
        
           <div class="product">
            <img src="images/CompNet.jpg" alt="CompNet">
            <div class="product-details">
                <h3>Computer Network Security Sem V</h3>
                <p>Description:  Tailored for the specific needs of advanced students, this comprehensive resource takes you on a journey through the intricacies of securing computer systems and understanding network vulnerabilities. </p>
                <p>Price: ₹750</p>
                <form class="product-form" action="index" method="post">
                    <input type="hidden" name="productId" value="4">
                    <input type="hidden" name="productName" value="Computer Network Security Sem V">
                    <input type="hidden" name="productPrice" value="750">
                    <label for="product2Qty">Quantity:</label>
                    <input type="number" id="product2Qty" name="productQty" value="1" min="1">
                    <button type="submit">Add to Cart</button>
                </form>
            </div>
        </div>
        

    </section>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        var forms = document.querySelectorAll(".product-form");

        forms.forEach(function (form) {
            form.addEventListener("submit", function (event) {
                event.preventDefault(); 

                var formData = new FormData(form);

                var xhr = new XMLHttpRequest();
                xhr.open("POST", "index", true);
                xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
                xhr.onload = function () {
                    if (xhr.status === 200) {
                        console.log(xhr.responseText);
                     
                    } else {
                        console.error(xhr.statusText);
                    }
                };
                xhr.onerror = function () {
                    console.error("Request failed");
                };

                // Convert FormData to URL-encoded format
                var urlEncodedData = new URLSearchParams(formData).toString();

                xhr.send(urlEncodedData);
            });
        });
    });
</script>

</body>
</html>

