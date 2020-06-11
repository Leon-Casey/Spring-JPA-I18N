<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"  %>  
<%@taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<html lang="en">
    <head>
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
    <title><spring:message code="search.title"/></title>
</head>
<body>
    <form:form method="POST" action="Search" modelAttribute="beer">
        <span>
            <h1><spring:message code="search.h1"/></h1>
        </span>
        <div>
            <form:label path="name"><spring:message code="label.name"/></form:label>
            <form:input path="name" required="true"/>
            <%--<form:errors path="name"/>--%>

        </div>
        <div>
            <input type="submit" value="<spring:message code="submit.button"/>" />
        </div>
    </form:form>
</body>
</html>