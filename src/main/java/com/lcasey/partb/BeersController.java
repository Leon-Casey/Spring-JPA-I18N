/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.lcasey.partb;

import java.text.NumberFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.RequestContextUtils;

/**
 *
 * @author Leon
 */
@Controller
public class BeersController {

    @Autowired
    BeersService service;

    @RequestMapping(value = "/SearchForm")
    public ModelAndView searchBeersForm() {
        return new ModelAndView("/search", "beer", new Beers());
    }

    @RequestMapping(value = "/Search")
    public ModelAndView searchBeers(HttpServletRequest request, @RequestParam String name) {
        List<Beers> results = service.searchBeersByName(name);

//        Locale locale = LocaleContextHolder.getLocale();
//
//        NumberFormat currencyFrmt = NumberFormat.getCurrencyInstance(locale);
//
//        for (Beers b : results) {
//            Double formatted = Double.parseDouble(currencyFrmt.format(b.getBuyPrice()));
//
//            b.setBuyPrice(formatted);
//        }

        return new ModelAndView("/displayBeers", "beersList", results);
    }

    @RequestMapping(value = "/Drilldown")
    public ModelAndView getBeerDetails(@RequestParam int id) {
        Beers beer = service.getBeerById(id);

        Categories cat = service.getCategoryByCatId(beer.getCatId());

        Styles style = service.getStyleByStyleId(beer.getStyleId());

        ModelAndView mav = new ModelAndView();

        mav.addObject("beer", beer);
        mav.addObject("cat", cat);
        mav.addObject("style", style);
        mav.setViewName("/drilldown");

        return mav;
    }

    @RequestMapping(value = "/ChangeSellPrice")
    public ModelAndView changeSellPrice(@RequestParam int id, @RequestParam double value, @RequestParam String process) {

        Beers beer = service.getBeerById(id);

        if (process.equals("Add")) {
            value = value / 100;
            double valueToAdd = beer.getSellPrice() * value;

            beer.setSellPrice(beer.getSellPrice() + valueToAdd);

        } else if (process.equals("Minus")) {
            value = value / 100;
            double valueToMinus = beer.getSellPrice() * value;

            beer.setSellPrice(beer.getSellPrice() - valueToMinus);
        }

        if (beer.getSellPrice() < 0) {
            beer.setSellPrice(0);
        }

        beer.setLastMod(new Date());

        service.updateBeerWithNewSellPrice(beer);

        return new ModelAndView("redirect:/SearchForm");
    }

    @RequestMapping(value = "/language")
    public ModelAndView changeLanguage(HttpServletRequest request, HttpServletResponse response, @RequestParam String selected) {
        LocaleResolver lr = RequestContextUtils.getLocaleResolver(request);

        lr.setLocale(request, response, StringUtils.parseLocaleString(selected));

        String referer = request.getHeader("Referer");

        return new ModelAndView("redirect:" + referer);
    }
}
