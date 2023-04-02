<%@page import="java.util.Map"%>
<%@page import="com.saif.e_commerce.helper.Helper"%>
<%@page import="java.util.List"%>
<%@page import="com.saif.e_commerce.entities.Category"%>
<%@page import="com.saif.e_commerce.helper.FactoryProvider"%>
<%@page import="com.saif.e_commerce.dao.CategoryDao"%>
<%@page import="com.saif.e_commerce.entities.User"%>
<%
    User adminUser = (User) session.getAttribute("current-user");
    if (adminUser == null) {
        session.setAttribute("message", "You are not logged in !! Login first");
        response.sendRedirect("login.jsp");
        return;
    } else {
        if (adminUser.getUserType().equals("normal")) {
            session.setAttribute("message", "You are not admin ! Do not access this page");
            response.sendRedirect("login.jsp");
            return;
        }
    }
%>

<%
    CategoryDao cdao= new CategoryDao(FactoryProvider.getFactory());
    List<Category> list= cdao.getCategories();
    
    //Getting count
    Map<String,Long> m=Helper.getCounts(FactoryProvider.getFactory());
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Panel</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container admin">
            
            <div class="container-fluid mt-3">
                <%@include file="components/message.jsp" %>
            </div>
            
            <!--first row-->
            <div class="row mt-3">

                <!--first col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid" src="img/users.png" alt="user-icon">
                            </div>
                            <h2><%=m.get("userCount")%></h2>
                            <h2 class="text-uppercase text-muted">Users</h2>
                        </div>
                    </div>
                </div>

                <!--second col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid" src="img/categories.png" alt="user-icon">
                            </div>
                            <h2><%=list.size()%></h2>
                            <h2 class="text-uppercase text-muted">Categories</h2>
                        </div>
                    </div>
                </div>

                <!--third col-->
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid" src="img/products.png" alt="user-icon">
                            </div>
                            <h2><%=m.get("productCount")%></h2>
                            <h2 class="text-uppercase text-muted">Products</h2>
                        </div>
                    </div>
                </div>

            </div>

            <!--second row-->
            <div class="row mt-3">

                <!--first col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-category-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid" src="img/add_category.png" alt="user-icon">
                            </div>
                            <p class="mb-2">Click here to add new category</p>
                            <h2 class="text-uppercase text-muted">Add Category</h2>
                        </div>
                    </div>
                </div>

                <!--second col-->
                <div class="col-md-6">
                    <div class="card" data-toggle="modal" data-target="#add-product-modal">
                        <div class="card-body text-center">
                            <div class="container">
                                <img style="max-width: 125px;" class="img-fluid" src="img/add_product.png" alt="user-icon">
                            </div>
                            <p class="mb-2">Click here to add new product</p>
                            <h2 class="text-uppercase text-muted">Add Product</h2>
                        </div>
                    </div>
                </div>

            </div>

        </div>
        
        <!--add category modal -->
        <div class="modal fade" id="add-category-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg">
                        <h5 class="modal-title fs-5" id="exampleModalLabel">Fill category details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form action="ProductOperationServlet" method="post">
                            
                            <input type="hidden" name="operation" value="addcategory">
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="catTitle" placeholder="Enter category title" required>
                            </div>
                            
                            <div class="form-group mt-3">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter category description" name="catDescription" required></textarea>
                            </div>
                            
                            <div class="container text-center mt-3">
                                <button class="btn custom-bg">Add Category</button>
                                <button type="button" class="btn custom-bg" data-bs-dismiss="modal">Close</button>
                            </div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
        
        <!--add product modal -->
        <div class="modal fade" id="add-product-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header custom-bg">
                        <h5 class="modal-title fs-5" id="exampleModalLabel">Product details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        
                        <form action="ProductOperationServlet" method="post" enctype="multipart/form-data">
                            
                            <input type="hidden" name="operation" value="addproduct">
                            
                            <div class="form-group">
                                <input type="text" class="form-control" name="pName" placeholder="Enter title of product" required>
                            </div>
                            
                            <div class="form-group mt-3">
                                <textarea style="height: 150px;" class="form-control" placeholder="Enter product description" name="pDescription" required></textarea>
                            </div>
                            
                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pPrice" placeholder="Enter price of product" required>
                            </div>
                            
                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pDiscount" placeholder="Enter product discount" required>
                            </div>
                            
                            <div class="form-group mt-3">
                                <input type="number" class="form-control" name="pQuantity" placeholder="Enter product quantity" required>
                            </div>
                            
                            
                            <div class="form-group mt-3">
                                <select name="catId" class="form-control" id="">
                                    <%
                                        for(Category c:list)
                                        {
                                    %>
                                    <option value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>
                            
                            <div class="form-group mt-3">
                                <label for="pPic">Select picture of product</label>
                                <br>
                                <input type="file" id="pPic" name="pPic" required>
                            </div>
                            
                            <div class="container text-center mt-3">
                                <button class="btn custom-bg">Add Product</button>
                                <button type="button" class="btn custom-bg" data-bs-dismiss="modal">Close</button>
                            </div>
                        </form>
                        
                    </div>
                </div>
            </div>
        </div>
                                
        <%@include file="components/common_modals.jsp" %>

    </body>
</html>
