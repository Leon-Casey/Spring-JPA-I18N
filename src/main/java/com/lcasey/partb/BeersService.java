/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lcasey.partb;

import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityTransaction;
import org.springframework.stereotype.Service;

/**
 *
 * @author Leon
 */
@Service
public class BeersService {

    public List<Beers> searchBeersByName(String name) {
        EntityManager em = DBUtil.getEMF().createEntityManager();
        List<Beers> list = null;
        try {
            list = em.createNamedQuery("Beers.findByNameContaining", Beers.class)
                    .setParameter("name", name)
                    .getResultList();
            if (list == null || list.isEmpty()) {
                list = null;
            }
        } catch (Exception ex) {
            System.out.println("DB: " + ex);
        } finally {
            em.close();
        }
        return list;
    }

    public Beers getBeerById(int id) {
        EntityManager em = DBUtil.getEMF().createEntityManager();
        Beers beer = null;
        try {
            beer = em.createNamedQuery("Beers.findById", Beers.class)
                    .setParameter("id", id)
                    .getSingleResult();
        } catch (Exception ex) {
            System.out.println("DB: " + ex);
        } finally {
            em.close();
        }
        return beer;
    }

    public Categories getCategoryByCatId(int catId) {
        EntityManager em = DBUtil.getEMF().createEntityManager();
        Categories cat = null;
        try {
            cat = em.createNamedQuery("Categories.findById", Categories.class)
                    .setParameter("id", catId)
                    .getSingleResult();
        } catch (Exception ex) {
            System.out.println("DB: " + ex);
        } finally {
            em.close();
        }
        return cat;
    }

    public Styles getStyleByStyleId(int styleId) {
        EntityManager em = DBUtil.getEMF().createEntityManager();
        Styles style = null;
        try {
            style = em.createNamedQuery("Styles.findById", Styles.class)
                    .setParameter("id", styleId)
                    .getSingleResult();
        } catch (Exception ex) {
            System.out.println("DB: " + ex);
        } finally {
            em.close();
        }
        return style;
    }

    public void updateBeerWithNewSellPrice(Beers beer) {
        EntityManager em = DBUtil.getEMF().createEntityManager();
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(beer);
            trans.commit();
        } catch (Exception ex) {
            System.out.println("DB: " + ex);
        } finally {
            em.close();
        }
    }
}
