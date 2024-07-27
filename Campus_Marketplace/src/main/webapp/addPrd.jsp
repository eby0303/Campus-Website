<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <link rel="stylesheet" href="css/addPrd.css">
</head>
<body>
    <form action="addPrd" method="post" enctype="multipart/form-data" onsubmit="return redirectToAdminPage();">
        Product Name: <input type="text" name="productName" placeholder="Product Name" required><br>
        Product Price: <input type="text" name="productPrice" placeholder="Product Price" required><br>
        Product Description: <input type="text" name="productDesc" placeholder="Product Description" required><br>
        Image: <input type="file" name="productImage" required><br>
        <input type="submit" value="Add Product">
    </form>


    <script>
        function redirectToAdminPage() {
         
            // Redirect to the admin page
            var adminPageUrl = "<%= request.getContextPath() %>/admin.jsp";
            window.location.href = adminPageUrl;

           
            return true;
        }
    </script>
    
    
</body>
</html>
