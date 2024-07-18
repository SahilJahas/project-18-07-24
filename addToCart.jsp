<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>

<%
// Get the session object
HttpSession httpsession = request.getSession();

// Get the productId from the request
int productId = Integer.parseInt(request.getParameter("productId"));

// Get the cart from the session, create a new cart if it doesn't exist
Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
if (cart == null) {
    cart = new HashMap<>();
    session.setAttribute("cart", cart);
}

// Add the product to the cart or update the quantity if it already exists
cart.put(productId, cart.getOrDefault(productId, 0) + 1);

// Redirect to the cart page
response.sendRedirect("viewCart.jsp");
%>
