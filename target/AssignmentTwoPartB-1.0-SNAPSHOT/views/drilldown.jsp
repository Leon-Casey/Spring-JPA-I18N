<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
    <head>
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
    <title><spring:message code="drilldown.title"/></title>
</head>
<body>
    <h1>${beer.name}</h1>
    <p><img src="assets/images/${beer.image}" alt="${beer.image}" width="100" height="100"/></p>
    <p><spring:message code="label.id"/>: ${beer.id}</p>
    <p><spring:message code="label.abv"/>: ${beer.abv}</p>
    <p><spring:message code="label.buyPrice"/>: ${beer.buyPrice}</p>
    <p><spring:message code="label.sellPrice"/>: ${beer.sellPrice}</p>
    <p><spring:message code="label.lastModified"/>:${beer.lastMod}</p>
    <p><spring:message code="label.desc"/>: ${beer.description}</p>
    <p><spring:message code="label.category"/>: ${cat.catName}</p>
    <p><spring:message code="label.style"/>: ${style.styleName}</p>

    <h3><spring:message code="drilldown.h3"/></h3>
    <form:form method="POST" action="ChangeSellPrice">
        <div>
            <input type="hidden" name="id" value="${beer.id}">
            <input type="text" name="value" required>
            %
            <form:errors path="name"/>
        </div>
        <div>
            <input type="radio" name="process" value="Add" required>
            <label for="Add"><spring:message code="label.add"/></label>
            <br>
            <input type="radio" name="process" value="Minus">
            <label for="Minus"><spring:message code="label.minus"/></label>
            <br>
            <input type="submit" value="<spring:message code="submit.button"/>">
        </div>
    </form:form>
</body>
</html>
