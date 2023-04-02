<%@page import="com.saif.e_commerce.helper.Helper"%>
<%@page import="com.saif.e_commerce.dao.CategoryDao"%>
<%@page import="com.saif.e_commerce.entities.Category"%>
<%@page import="com.saif.e_commerce.entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.saif.e_commerce.dao.ProductDao"%>
<%@page import="com.saif.e_commerce.helper.FactoryProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-commerce</title>

        <%@include file="components/common_css_js.jsp" %>

    </head>
    <body>

        <%@include file="components/navbar.jsp" %>

        <div class="container-fluid">
            <div class="row mt-3 mx-2">

                <%
                    String cat= request.getParameter("category");
                    
                    ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                    List<Product> plist=null;
                    if(cat==null || cat.trim().equals("all"))
                    {
                        plist = pdao.getAllProducts();
                    }
                    else
                    {
                        int cid=Integer.parseInt(cat.trim());
                        plist=pdao.getAllProductsById(cid);
                    }
                    
                    CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                    List<Category> clist = cdao.getCategories();
                %>

                <!--show categories-->
                <div class="col-md-2">

                    <div class="list-group mt-4">
                        <a href="index.jsp?category=all" class="list-group-item list-group-item-action active" style="background: #D3D3D3;border-color: #D3D3D3;" aria-current="true">
                            All Products
                        </a>

                        <%
                            for (Category category : clist) {
                        %>    
                        <a href="index.jsp?category=<%=category.getCategoryId()%>" class="list-group-item list-group-item-action"><%=category.getCategoryTitle()%></a>
                        <%
                            }
                        %>
                    </div>

                </div>

                <!--show products-->
                <div class="col-md-10">

                    <!--row-->
                    <div class="row mt-4">

                        <!--col:12-->
                        <div class="col-md-12">

                            <div class="card-columns">

                                <!--traversing products-->
                                <%
                                    for (Product product : plist)
                                    {
                                %>

                                <div class="card product-card">

                                    <div class="container text-center">
                                        <img src="img/products/<%=product.getProductPhoto()%>" style="max-height: 200px; max-width: 100%; width: auto;" class="card-img-top m-2" alt="...">
                                    </div>

                                    <div class="card-body">
                                        <h5 class="card-title"><%=Helper.get07Words(product.getProductName())%></h5>
                                        <p class="card-text">
                                            <%=Helper.get10Words(product.getProductDescription())%>
                                        </p>
                                    </div>

                                    <div class="card-footer text-center">
                                        <button class="btn custom-bg" onclick="addToCart(<%=product.getProductId()%>,'<%=Helper.get07Words(product.getProductName())%>',<%=product.getPriceAfterApplyingDiscount()%>)">Add to Cart</button>
                                        <button class="btn custom-bg">&#8377; <%=product.getPriceAfterApplyingDiscount()%>/- <span class="text-secondary discount-label"> &#8377; <%=product.getProductPrice()%> , -<%=product.getProductDiscount()%>% off</span></button>
                                    </div>    
                                </div>

                                <%
                                    }
                                    if(plist.size()==0)
                                    {
                                        out.println("<h3>No item in this category</h3>");
                                    }
                                %>

                            </div>

                        </div>

                    </div>

                </div>

            </div>
        </div>
                                
        <%@include file="components/common_modals.jsp" %>

    </body>
</html>
