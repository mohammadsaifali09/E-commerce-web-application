package com.saif.e_commerce.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class Product
{
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productId;
    private String productName;
    @Column(length = 3000)
    private String productDescription;
    private String productPhoto;
    private int productPrice;
    private int productDiscount;
    private int productQuantity;
    @ManyToOne
    private Category category;

    public Product()
    {
    }

    public Product(String productName, String productDescription, String productPhoto, int productPrice, int productDiscount, int productQuantity, Category category)
    {
        this.productName = productName;
        this.productDescription = productDescription;
        this.productPhoto = productPhoto;
        this.productPrice = productPrice;
        this.productDiscount = productDiscount;
        this.productQuantity = productQuantity;
        this.category=category;
    }

    public Product(int productId, String productName, String productDescription, String productPhoto, int productPrice, int productDiscount, int productQuantity, Category category)
    {
        this.productId = productId;
        this.productName = productName;
        this.productDescription = productDescription;
        this.productPhoto = productPhoto;
        this.productPrice = productPrice;
        this.productDiscount = productDiscount;
        this.productQuantity = productQuantity;
        this.category=category;
    }

    public int getProductId()
    {
        return productId;
    }

    public void setProductId(int productId)
    {
        this.productId = productId;
    }

    public String getProductName()
    {
        return productName;
    }

    public void setProductName(String productName)
    {
        this.productName = productName;
    }

    public String getProductDescription()
    {
        return productDescription;
    }

    public void setProductDescription(String productDescription)
    {
        this.productDescription = productDescription;
    }

    public String getProductPhoto()
    {
        return productPhoto;
    }

    public void setProductPhoto(String productPhoto)
    {
        this.productPhoto = productPhoto;
    }

    public int getProductPrice()
    {
        return productPrice;
    }

    public void setProductPrice(int productPrice)
    {
        this.productPrice = productPrice;
    }

    public int getProductDiscount()
    {
        return productDiscount;
    }

    public void setProductDiscount(int productDiscount)
    {
        this.productDiscount = productDiscount;
    }

    public int getProductQuantity()
    {
        return productQuantity;
    }

    public void setProductQuantity(int productQuantity)
    {
        this.productQuantity = productQuantity;
    }

    public Category getCategory()
    {
        return category;
    }

    public void setCategory(Category category)
    {
        this.category = category;
    }

    @Override
    public String toString()
    {
        return "Product{" + "productId=" + productId + ", productName=" + productName + ", productDescription=" + productDescription + ", productPhoto=" + productPhoto + ", productPrice=" + productPrice + ", productDiscount=" + productDiscount + ", productQuantity=" + productQuantity + ", category=" + category + '}';
    }
    
    //calculate price after discount
    public int getPriceAfterApplyingDiscount()
    {
        int d=(int) ((this.getProductDiscount()/100.0)*this.getProductPrice());
        return this.getProductPrice()-d;
    }
}
