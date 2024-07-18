package dao;
import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;
import bean.Product;

public class ProductDAO {
    private static final String URL = "jdbc:mysql://192.168.18.245:3306/javadb_168";
    private static final String USER = "javadb_168";
    private static final String PASSWORD = "Sp3cJa5A2k24";
    private static final String DRIVER_CLASS = "com.mysql.jdbc.Driver";

    public ProductDAO() {
        try {
            Class.forName(DRIVER_CLASS);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT id, name, price, availability, quantity, specification, image_url FROM products";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getInt("price"));
                product.setAvailability(rs.getInt("availability"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSpecification(rs.getString("specification"));
                product.setImage_url(rs.getString("image_url"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductById(int id) {
        Product product = null;
        String query = "SELECT id, name, price, availability, quantity, specification, image_url FROM products WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setPrice(rs.getInt("price"));
                product.setAvailability(rs.getInt("availability"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSpecification(rs.getString("specification"));
                product.setImage_url(rs.getString("image_url"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE products SET name = ?, price = ?, availability = ?, quantity = ?, specification = ?, image_url = ? WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(query)) {
            
            stmt.setString(1, product.getName());
            stmt.setInt(2, product.getPrice());
            stmt.setInt(3, product.getAvailability());
            stmt.setInt(4, product.getQuantity());
            stmt.setString(5, product.getSpecification());
            stmt.setString(6, product.getImage_url());
            stmt.setInt(7, product.getId());
            
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static Map<Integer, Product> getProductsByIds(Set<Integer> productIds) throws SQLException {
        Map<Integer, Product> products = new HashMap<>();
        if (productIds.isEmpty()) {
            return products;
        }

        String ids = productIds.stream().map(String::valueOf).collect(Collectors.joining(","));
        String query = "SELECT * FROM products WHERE id IN (" + ids + ")";

        try (Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                Product product = new Product(id, name, price);
                products.put(id, product);
            }
        }

        return products;
    }
}
