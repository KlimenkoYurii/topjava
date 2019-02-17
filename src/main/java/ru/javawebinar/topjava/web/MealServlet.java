package ru.javawebinar.topjava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.javawebinar.topjava.util.MealsUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
//CONTROLLER
//"meals" MODEL
public class MealServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(MealServlet.class);

    @Override // принимаем запрос HTTP get
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        log.info("getAll");
// кладём атрибут запроса с именем meals(список еды с полем excess) |список простой еды|     2000калл
        request.setAttribute("meals", MealsUtil.getWithExcess(MealsUtil.MEALS, MealsUtil.DEFAULT_CALORIES_PER_DAY));
//                                           //вообщем второй параметр setAttribute спиок еды с превышением
//
        request.getRequestDispatcher("/meals.jsp").forward(request, response);
        // список meals(еда с полем excess) передаем в "/meals.jsp"
    }
}
