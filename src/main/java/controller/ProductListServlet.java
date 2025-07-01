package controller;


import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Bean.Brand;
import model.Bean.Category;
import model.Bean.Product;
import service.BrandService;
import service.CategoryService;
import service.ProductService;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "ProductListServlet", value = "/ProductListServlet")
public class ProductListServlet extends HttpServlet {

    private ProductService productService;
    private CategoryService categoryService;
    private BrandService brandService;

    @Override
    public void init(ServletConfig config) throws ServletException {
        super.init(config);
        ServletContext context = config.getServletContext();
        this.productService = new ProductService(context);
        this.categoryService = new CategoryService(context);
        this.brandService = new BrandService(context);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String brandIdParam = request.getParameter("brandId");
        String categoryIdParam = request.getParameter("categoryId");
        String offersParam = request.getParameter("offers");

        ServletContext context = getServletContext();
        RequestDispatcher dispatcher;

        try{
            categoryService.checkCategoryCache();
            Map<Integer, Category> categoryCacheMap = (Map<Integer, Category>) getServletContext().getAttribute("categoryCacheMap");
            request.setAttribute("categoryCacheMap", categoryCacheMap);

            if(brandIdParam == null && categoryIdParam == null && offersParam == null){
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
                return;
            }

            if(brandIdParam != null){
                List<Product> productList = productService.getProductsByBrand(Integer.parseInt(brandIdParam));
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            } else if(categoryIdParam != null){
                List<Product> productList = productService.getProductsByCategory(Integer.parseInt(categoryIdParam));
                List<Category> breadcrumbCategories = categoryService.buildBreadcrumbFromMap(categoryCacheMap, Integer.parseInt(categoryIdParam));
                request.setAttribute("productList", productList);
                request.setAttribute("breadcrumbCategories", breadcrumbCategories);
                dispatcher = request.getRequestDispatcher("/jsp/products/ProductsList.jsp");
                dispatcher.forward(request, response);
            } else if(offersParam != null && offersParam.equals("true")){
                List<Product> productList = productService.getProductsOnSale();
                request.setAttribute("productList", productList);
                dispatcher = request.getRequestDispatcher("/jsp/products/Offers.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            }
        }catch (Exception e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing request");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
