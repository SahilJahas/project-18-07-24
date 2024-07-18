<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.ProductDAO, bean.Product"%>
 <% HttpSession httpSession = request.getSession();
if(httpSession==null || httpSession.getAttribute("user")==null){
	response.sendRedirect("login.jsp");
	return;
	
	
}


String user=(String)httpSession.getAttribute("user");

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Vegefoods</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Update Product</h2>
        <%
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int price = Integer.parseInt(request.getParameter("price"));
            int availability = Integer.parseInt(request.getParameter("availability"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String specification = request.getParameter("specification");
            String image_url = request.getParameter("image_url");

            ProductDAO productDAO = new ProductDAO();
            Product product = new Product();
            product.setId(id);
            product.setName(name);
            product.setPrice(price);
            product.setAvailability(availability);
            product.setQuantity(quantity);
            product.setSpecification(specification);
            product.setImage_url(image_url);

            boolean isUpdated = productDAO.updateProduct(product);
            if (isUpdated) {
                out.println("<div class='alert alert-success'>Product updated successfully!</div>");
            } else {
                out.println("<div class='alert alert-danger'>Failed to update product!</div>");
            }
        %>
        <a href="viewproducts.jsp" class="btn btn-primary">Back to Product List</a>
    </div>

    <!-- Bootstrap JS (optional) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
