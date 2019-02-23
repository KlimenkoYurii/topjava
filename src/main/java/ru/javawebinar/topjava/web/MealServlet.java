package ru.javawebinar.topjava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import ru.javawebinar.topjava.model.Meal;
import ru.javawebinar.topjava.repository.InMemoryMealRepositoryImpl;
import ru.javawebinar.topjava.repository.MealRepository;
import ru.javawebinar.topjava.util.MealsUtil;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Objects;

public class MealServlet extends HttpServlet {
    private static final Logger log = LoggerFactory.getLogger(MealServlet.class);

    private MealRepository repository;

    @Override
    public void init(ServletConfig config) throws ServletException {  // 4) ИНИЦИАЛИЗИРУЕМ repository = new InMemoryMealRepositoryImpl();
        System.out.println("2222222222");
        super.init(config);
        repository = new InMemoryMealRepositoryImpl();
    }
//------------------------------------------------------------------------------------
//10)
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String id = request.getParameter("id");// берем параметр id з запроса клиента

        // создали новую еду дали ей id из запроса
        Meal meal = new Meal(id.isEmpty() ? null : Integer.valueOf(id),
                LocalDateTime.parse(request.getParameter("dateTime")),
                request.getParameter("description"),
                Integer.parseInt(request.getParameter("calories")));

        log.info(meal.isNew() ? "Create {}" : "Update {}", meal);
        repository.save(meal); // и сохранили в репозитории или если такое id есть то обновили еду
        response.sendRedirect("meals"); //и отдаем маппинг на этот же сервелет и попадаем
        // в метод doGet
    }
//---------------------------------------------------------------------------------------------------
    @Override   // 5) ИДЕМ В ЭТОТ МЕТОД
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");//6) вытаскиваем из request (запроса клинта) параметр action

        switch (action == null ? "all" : action) {  //6) ЕСЛИ  action null(тоесть не чего не нажали тогда даем ему all и идем в default)
            case "delete":
                int id = getId(request); // дастаем из request id
                log.info("Delete {}", id);
                repository.delete(id);  // удаляем из мапы id
                response.sendRedirect("meals"); //и маппимся на /meals
                break;
            //8)
            case "create":  // если нужно создать еду то создаем новую еду
            case "update":  // если обновить то берем из репозитория по id из request
                            // устанавливаем на простую еду без exceed атрибут meal
                            // и отправляемся в /mealForm.jsp

             // ложим в еду если action create       новую еду    с таким временем  2019-02-22T14:38 по умолч. без описания  всё можно изменить  с 1000калл  иначе если update ложим из репозитория
                final Meal meal = "create".equals(action) ? new Meal(LocalDateTime.now().truncatedTo(ChronoUnit.MINUTES), "", 1000) : repository.get(getId(request));
                request.setAttribute("meal", meal);
                request.getRequestDispatcher("/mealForm.jsp").forward(request, response);
                break;
            case "all":
            default:
                log.info("getAll");
                // устанавливаем атрибут    meals   |        списку еды с полем exceed
                request.setAttribute("meals", MealsUtil.getWithExcess(repository.getAll(), MealsUtil.DEFAULT_CALORIES_PER_DAY));
                // и кидаем на эту страничку  /meals.jsp
                request.getRequestDispatcher("/meals.jsp").forward(request, response);
                break;
        }
    }
// метод который дастает из request id
    private int getId(HttpServletRequest request) {
        //                     если обьект в параметре null тогда ошибка
        String paramId = Objects.requireNonNull(request.getParameter("id"));
        return Integer.parseInt(paramId);
    }
}
