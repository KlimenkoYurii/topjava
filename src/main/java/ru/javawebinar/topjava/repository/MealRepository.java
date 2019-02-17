package ru.javawebinar.topjava.repository;

import ru.javawebinar.topjava.model.Meal;

import java.util.Collection;
// так как разные методы храние мы делаем интерфейс
public interface MealRepository {
    Meal save(Meal meal);// две функции создание и обновление сущности

    void delete(int id);

    Meal get(int id);

    Collection<Meal> getAll();
}
