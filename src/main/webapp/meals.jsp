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
    <a href="meals?action=create">Add Meal</a><%--по ссылке /meals(тоесть получаеться в MealServlet) выставляем  action cтатус create --%>
    <hr/>
    <table border="1" cellpadding="8" cellspacing="0">
        <thead>
        <tr>
            <th>Date</th>
            <th>Description</th>
            <th>Calories</th>
            <th></th>
            <th></th>
        </tr>
        </thead> <%--7 выводим все на экран--%>
        <c:forEach items="${meals}" var="meal">  <%--сдесь атрибуту ${meals} в сервлете установлили поле списка еды с полем exceed (где meal это одно знаение этого списка)--%>

            <%--page (страница). Объект, определенный с областью видимости page, доступен до тех пор,
             пока не будет отправлен ответ клиенту или пока запрос к текущей странице JSP не будет
             перенаправлен куда-нибудь еще. Ссылки на объект возможны только в пределах страницы,
              в которой этот объект определен.
             Объекты, объявленные с атрибутом page, сохраняются в объекте pageContext.--%>
            <jsp:useBean id="meal" scope="page" type="ru.javawebinar.topjava.model.MealTo"/><%--meal дали класс чтобы вызвать методы класса--%>
            <tr class="${meal.excess ? 'excess' : 'normal'}"><%--если у еды поле excess true тогда класс у строки будет excess(тоесть красный)  --%>
                <td>
                        <%--${meal.dateTime.toLocalDate()} ${meal.dateTime.toLocalTime()}--%>
                        <%--<%=TimeUtil.toString(meal.getDateTime())%>--%>
                        <%--${fn:replace(meal.dateTime, 'T', ' ')}--%>
                        ${fn:formatDateTime(meal.dateTime)}  <%-- дате устанавливаем строкое значение и выводим ее в колонке--%>
                </td>
                <td>${meal.description}</td>
                <td>${meal.calories}</td>
                <td><a href="meals?action=update&id=${meal.id}">Update</a></td> <%--если нажать на Update  то срабатывает маппинг на /meals идем  в сервлет в метод doGet() с id еды--%>
                <td><a href="meals?action=delete&id=${meal.id}">Delete</a></td>
            </tr>
        </c:forEach>
    </table>
</section>
</body>
</html>