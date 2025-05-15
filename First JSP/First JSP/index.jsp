<%@ page import="java.sql.*" %>
<html>
<body>

<% 
String action = request.getParameter("action");

try {
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/pragati", "root", "");
    Statement stmt = con.createStatement();

    if (action != null) {
        if (action.equals("addSubmit")) {
            int book_id = Integer.parseInt(request.getParameter("book_id"));
            String book_title = request.getParameter("book_title");
            String book_author = request.getParameter("book_author");
            int book_price = Integer.parseInt(request.getParameter("book_price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            String sql = "INSERT INTO ebookshop (book_id, book_title, book_author, book_price, quantity) VALUES (" 
                          + book_id + ", '" + book_title + "', '" + book_author + "', " + book_price + ", " + quantity + ")";
            stmt.executeUpdate(sql);
            out.println("<p>Book Added Successfully!</p>");
        } else if (action.equals("updateSubmit")) {
            int book_id = Integer.parseInt(request.getParameter("book_id"));
            String book_title = request.getParameter("book_title");
            String book_author = request.getParameter("book_author");
            int book_price = Integer.parseInt(request.getParameter("book_price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            String sql = "UPDATE ebookshop SET book_title='" + book_title + "', book_author='" + book_author + "', book_price=" + book_price + ", quantity=" + quantity + " WHERE book_id=" + book_id;
            stmt.executeUpdate(sql);
            out.println("<p>Book Updated Successfully!</p>");
        } else if (action.equals("deleteSubmit")) {
            int book_id = Integer.parseInt(request.getParameter("book_id"));

            String sql = "DELETE FROM ebookshop WHERE book_id=" + book_id;
            stmt.executeUpdate(sql);
            out.println("<p>Book Deleted Successfully!</p>");
        }
    }
    
    ResultSet rs = stmt.executeQuery("SELECT * FROM ebookshop");
%>

<h1>Books List</h1>
<table border='5'>
<tr>
    <th>Book ID</th>
    <th>Title</th>
    <th>Author</th>
    <th>Price</th>
    <th>Quantity</th>
</tr>

<%
    while (rs.next()) {
        out.println("<tr><td>" + rs.getInt("book_id") + "</td><td>" + rs.getString("book_title") + "</td><td>" + rs.getString("book_author") + "</td><td>" + rs.getInt("book_price") + "</td><td>" + rs.getInt("quantity") + "</td></tr>");
    }
    con.close();
} catch (Exception e) {
    out.println(e);
}
%>

<h2>Choose Operation</h2>

<form method="get" action="">
    <input type="submit" name="action" value="add" />
    <input type="submit" name="action" value="update" />
    <input type="submit" name="action" value="delete" />
</form>

<%
    String showForm = request.getParameter("action");

    if (showForm != null) {
        if (showForm.equals("add")) {
%>
<h2>Add New Book</h2>
<form action="" method="get">
    <input type="hidden" name="action" value="addSubmit" />
    Book ID: <input type="text" name="book_id" required><br>
    Title: <input type="text" name="book_title" required><br>
    Author: <input type="text" name="book_author" required><br>
    Price: <input type="text" name="book_price" required><br>
    Quantity: <input type="text" name="quantity" required><br>
    <input type="submit" value="Add Book">
</form>
<%
        } else if (showForm.equals("update")) {
%>
<h2>Update Book</h2>
<form action="" method="get">
    <input type="hidden" name="action" value="updateSubmit" />
    Book ID (to update): <input type="text" name="book_id" required><br>
    New Title: <input type="text" name="book_title" required><br>
    New Author: <input type="text" name="book_author" required><br>
    New Price: <input type="text" name="book_price" required><br>
    New Quantity: <input type="text" name="quantity" required><br>
    <input type="submit" value="Update Book">
</form>
<%
        } else if (showForm.equals("delete")) {
%>
<h2>Delete Book</h2>
<form action="" method="get">
    <input type="hidden" name="action" value="deleteSubmit" />
    Book ID (to delete): <input type="text" name="book_id" required><br>
    <input type="submit" value="Delete Book">
</form>
<%
        }
    }
%>

</body>
</html>
