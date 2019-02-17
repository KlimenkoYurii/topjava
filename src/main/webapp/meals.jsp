<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://topjava.javawebinar.ru/functions" %>
<%--<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>--%>
<html>
<head>
    <title>Meal list</title>
    <style>
        .normal {
            color: green;
        }

        .excess {
            color: red;
        }
    </style>
</head>
<body>
<section>
    <h3><a href="index.html">Home</a></h3>
    <h2>Meals</h2>
    <hr/><%--толщина рамки размер       отталкивания элементов внутри рамки --%>
    <table border="1" cellpadding="8" cellspacing="0">  <%--таблица--%>
        <thead>
        <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Calories</th>
        </tr>
        </thead>
        <%--  в цикле берем meals(список из сервлета) и meal(каждый элемент из этого списка)   --%>
        <c:forEach items="${meals}" var="meal">
            <%--       каждому элементу списка приводим класс MealTo(что бы открылись его методы класса)     --%>
            <jsp:useBean id="meal" scope="page" type="ru.javawebinar.topjava.model.MealTo"/>
            <%--<tr(строка) атрибут class(определяет имя класса для елемента) если meal.excess true тогда имя класса .excess и строка (tr) вся будет красной как описано в <style>   --%>
            <tr class="${meal.excess ? 'excess' : 'normal'}">
                <td>  <%--td отделяная колонка--%>
                        <%--${meal.dateTime.toLocalDate()} ${meal.dateTime.toLocalTime()}--%>
                        <%--<%=TimeUtil.toString(meal.getDateTime())%>--%>
                        <%--${fn:replace(meal.dateTime, 'T', ' ')}--%>
                        ${fn:formatDateTime(meal.dateTime)}<%--идем в фаил functions по formatDateTime и там переходим в метод который дает дату в "yyyy-MM-dd HH:mm" в Stringe  --%>
                </td>
                <td>${meal.description}</td>
                <td>${meal.calories}</td>
            </tr>
        </c:forEach>
    </table>
</section>
</body>
</html>