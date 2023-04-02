package com.saif.e_commerce.servlets;

import com.saif.e_commerce.dao.CategoryDao;
import com.saif.e_commerce.dao.ProductDao;
import com.saif.e_commerce.entities.Category;
import com.saif.e_commerce.entities.Product;
import com.saif.e_commerce.helper.FactoryProvider;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet(name = "ProductOperationServlet", urlPatterns = {"/ProductOperationServlet"})
public class ProductOperationServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            //servlet 2:
            //add category
            //add product
            String op = request.getParameter("operation");
            if (op.trim().equals("addcategory")) {
                //add category
                //fetching category data
                String title = request.getParameter("catTitle");
                String description = request.getParameter("catDescription");

                Category category = new Category();
                category.setCategoryTitle(title);
                category.setCategoryDescription(description);

                //category database save:
                CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
                int catId = categoryDao.saveCategory(category);
                //out.println("Category Saved");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Category is added successfully: " + catId);
                response.sendRedirect("admin.jsp");
                return;
            } else if (op.trim().equals("addproduct")) {
                //add product
                String pName = request.getParameter("pName");
                String pDescription = request.getParameter("pDescription");
                int pPrice = Integer.parseInt(request.getParameter("pPrice"));
                int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
                int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
                int catId = Integer.parseInt(request.getParameter("catId"));
                Part part = request.getPart("pPic");

                Product p = new Product();
                p.setProductName(pName);
                p.setProductDescription(pDescription);
                p.setProductPrice(pPrice);
                p.setProductDiscount(pDiscount);
                p.setProductQuantity(pQuantity);
                p.setProductPhoto(part.getSubmittedFileName());

                //get category by id
                CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
                Category category = cdao.getCategoryById(catId);

                p.setCategory(category);

                //product save
                ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
                pdao.saveProduct(p);

                //upload pic
                //path find out for upload photo
                String path = request.getRealPath("img") + File.separator + "products" + File.separator + part.getSubmittedFileName();
                System.out.println(path);

                //codes for uploading
                try
                {
                    FileOutputStream fos = new FileOutputStream(path);
                    InputStream is = part.getInputStream();

                    //data reading
                    byte[] data = new byte[is.available()];
                    is.read(data);

                    //data writing
                    fos.write(data);

                    fos.close();
                }
                catch (Exception e) {
                    e.printStackTrace();
                }

                //out.println("Product Saved");
                HttpSession httpSession = request.getSession();
                httpSession.setAttribute("message", "Product is added successfully");
                response.sendRedirect("admin.jsp");
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
