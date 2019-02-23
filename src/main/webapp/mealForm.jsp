<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Meal</title>
    <style>
        dl {
            background: none repeat scroll 0 0 #FAFAFA;
            margin: 8px 0;
            padding: 0;
        }

        dt {
            display: inline-block;
            width: 170px;
        }

        dd {
            display: inline-block;
            margin-left: 8px;
            vertical-align: top;
        }
    </style>
</head>
<body>
<section>
    <h3><a href="index.html">Home</a></h3>
    <%--9) если action create тогда заголовок 'Create meal' иначе 'Edit meal'--%>
    <h2>${param.action == 'create' ? 'Create meal' : 'Edit meal'}</h2>
    <hr>
    <%--//в методе toGet установили  простую еду без exceed атрибут meal и тут просвоили ей класс--%>
    <jsp:useBean id="meal" type="ru.javawebinar.topjava.model.Meal" scope="request"/>
    <%--метод отправки post(doPost) |action Указывает, куда отправить форму данные при отправке формы(мапинг на сервлет /meals) --%>
    <form method="post" action="meals">  <%--в меторд doPost в сервлет MealServlet--%>
        <input type="hidden" name="id" value="${meal.id}"> <%--поле id скрыто--%>
        <dl>
            <dt>DateTime:</dt>  <%--поля для изменения--%>
            <%-- type что вводим          параметр какой установим еде    имя какае будет в методе doPost доставаться из параметра и присваеваться Meal meal = new Meal            --%>
            <dd><input type="datetime-local" value="${meal.dateTime}" name="dateTime" required></dd>
        </dl>
        <dl>
            <dt>Description:</dt>
            <dd><input type="text" value="${meal.description}" size=40 name="description" required></dd>
        </dl>
        <dl>
            <dt>Calories:</dt>
            <dd><input type="number" value="${meal.calories}" name="calories" required></dd>
        </dl>
        <%-- тип кнопки submit(подчинить) надпись на ней Save  --%>
        <button type="submit">Save</button>

        <%--Перейти на предыдущую страницу,
         как если бы посетитель нажал на кнопку браузера "Назад".--%>
        <button onclick="window.history.back()" type="button">Cancel</button>
    </form>
</section>
</body>
</html>
