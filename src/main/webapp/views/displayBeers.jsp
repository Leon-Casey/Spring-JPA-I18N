<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.min.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script> 
        <script>
            $(document).ready(function () {
                $('#beers').DataTable();
            });
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js">
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $("#locales").change(function () {
                    var selectedOption = $('#locales').val();
                    if (selectedOption != '') {
                        window.location.replace('language?selected=' + selectedOption);
                    }
                });
            });
        </script>
    <span><spring:message code="label.change"/></span>:
    <select id="locales">
        <option value=""></option>
        <option value="en"><spring:message code="label.en"/></option>
        <option value="ga"><spring:message code="label.ga"/></option>
        <option value="de"><spring:message code="label.de"/></option>
    </select>
    <title><spring:message code="displayBeers.title"/></title>
</head>
<body>
    <h1><spring:message code="displayBeers.h1"/></h1>
    <table id="beers" class="display compact stripe order-column">
        <thead>
            <tr>
                <th><spring:message code="label.name"/></th>
                <th><spring:message code="label.abv"/></th>
                <th><spring:message code="label.ibu"/></th>
                <th><spring:message code="label.desc"/></th>
                <th><spring:message code="label.image"/></th>
                <th><spring:message code="label.buyPrice"/></th>
                <th><spring:message code="label.sellPrice"/></th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items = "${beersList}" var = "beer"> 
                <tr>
                    <td><a href="Drilldown?id=${beer.id}">${beer.name}</a></td>
                    <td>${beer.abv}</td>
                    <td>${beer.ibu}</td>
                    <td>${beer.description}</td>
                    <td><img src="assets/images/${beer.image}" alt="${beer.image}" width="50" height="50"/></td>
                    <td>${beer.buyPrice}</td>
                    <td>${beer.sellPrice}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
