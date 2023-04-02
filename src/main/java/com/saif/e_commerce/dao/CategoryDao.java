package com.saif.e_commerce.dao;

import com.saif.e_commerce.entities.Category;
import java.util.List;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

public class CategoryDao
{
    private SessionFactory factory;

    public CategoryDao(SessionFactory factory)
    {
        this.factory = factory;
    }
    
    //save the category to database
    public int saveCategory(Category category)
    {
        Session session = this.factory.openSession();
        Transaction tx = session.beginTransaction();
        int catId=(int) session.save(category);
        session.close();
        return catId;
    }
    
    public List<Category> getCategories()
    {
        Session s = this.factory.openSession();
        Query query = s.createQuery("from Category");
        List<Category> list = query.list();
        return list;
    }
    
    public Category getCategoryById(int cid)
    {
        Category cat=null;
        try
        {
            Session session = this.factory.openSession();
            cat = session.get(Category.class, cid);
            session.close();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        return cat;
    }
}
