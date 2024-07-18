<!-- userwelcome.jsp -->
<%@ page import="javax.servlet.http.*, javax.servlet.*"%>
<%
HttpSession httpSession = request.getSession(false);
if (session == null || session.getAttribute("user") == null) {
	response.sendRedirect("login.jsp");
	return;
}
String user = (String) session.getAttribute("user");
%>
<!doctype html>

<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<title>Vegefoods</title>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<style>


.product-card {
    transition: transform 0.2s, box-shadow 0.2s;
}

.product-card:hover {
    transform: scale(1.05);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}


.profile-icon {
	display: inline-block;
	font-size: 1.5em; /* Adjust size as needed */
}

.card-img-container {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 200px; /* Ensure this matches the height of the image */
	overflow: hidden;
}

.card-img-container img {
	max-width: 100%;
	max-height: 100%;
	object-fit: cover;
}
</style>
<!-- Bootstrap CSS -->
</head>
<body class="p-3 m-0 border-0 bd-example m-0 border-0">

	<!-- Example Code -->


	<nav class="navbar navbar-expand-lg bg-body-tertiary">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">FRESH FEEL RAW FOODS</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNavDropdown">
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Edit Profile</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Your
							Orders</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Payment</a>
					</li>
					<li class="nav-item "><a
						class="nav-link" href="viewCart.jsp" > Cart </a>



						
						</li>
				</ul>
			</div>
			<li class="nav-item"><a class="nav-link" href="logout.jsp">Logout</a>
			</li>
		</div>
	</nav>


	<%@ page import="java.sql.*"%>
	<%@ page import="java.util.*"%>
  <div class="container">
        <div class="row">
            <%
            // Database connection parameters
            String url = "jdbc:mysql://192.168.18.245:3306/javadb_168";
            String username = "javadb_168";
            String password = "Sp3cJa5A2k24";
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                // Load the JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Establish the connection
                conn = DriverManager.getConnection(url, username, password);

                // Create a statement
                stmt = conn.createStatement();

                // Execute the query
                String sql = "SELECT * FROM products";
                rs = stmt.executeQuery(sql);

                // Iterate through the result set and display the data
                while (rs.next()) {
                    String name = rs.getString("name");
                    int price = rs.getInt("price");
                    String image_url = rs.getString("image_url");
                    int productId = rs.getInt("id");
            %>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm bg-light product-card">
                    <a href="productDetails.jsp?productId=<%=productId%>" class="card-img-container">
                        <img alt="<%=name%>" src="<%=image_url%>">
                    </a>
                    <div class="card-body">
                        <h5 class="card-title"><%=name%></h5>
                        <p class="card-text">
                            <strong>Price:</strong> <%=price%><br>
                        </p>
                        <div class="d-flex justify-content-between">
                            <form action="addToCart.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="productId" value="<%=productId%>">
                                <button type="submit" class="btn btn-primary">Add to Cart</button>
                            </form>
                            <form action="buyNow.jsp" method="post" style="display: inline;">
                                <input type="hidden" name="productId" value="<%=productId%>">
                                <button type="submit" class="btn btn-success">Buy Now</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the resources
                if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
            }
            %>
        </div>
    </div>



</body>
</html>