-- Enable foreign keys (redundant if in schema.sql, but safe to include)
PRAGMA foreign_keys = ON;

-- 1. Add sample recipes
INSERT INTO Recipes (name, cuisine, cooking_time, instructions, servings)
VALUES ('Spaghetti Carbonara','Italian', 20, 'Boil pasta, cook pancetta, mix with eggs and cheese', 4),
       ('Chicken Tacos', 'Mexican', 30, 'Grill chicken, chop veggies, assemble tacos', 3);

-- 2. Add sample ingredients
INSERT INTO Ingredients (name, category)
VALUES ('Pasta', 'Grain'),
       ('Eggs', 'Dairy'),
       ('Parmesan', 'Dairy'),
       ('Pancetta', 'Meat'),
       ('Chicken Breast', 'Meat'),
       ('Tortilla', 'Bread'),
       ('Lettuce', 'Vegetable');

-- 3. Link ingredients to recipes
INSERT INTO Recipe_Ingredients (recipe_id, ingredient_id, quantity, unit)
VALUES (1, 1, 200, 'g'),
       (1, 2, 2, ''),
       (1, 3, 50, 'g'),
       (1, 4, 100, 'g'),
       (2, 5, 300, 'g'),
       (2, 6, 6, ''),
       (2, 7, 1, 'cup');

-- 4. Add initial pantry stock
INSERT INTO Pantry (ingredient_id, quantity, unit, expiration_date)
VALUES (1, 100, 'g', '2025-04-01'),
       (2, 6, '', '2025-03-15'),
       (3, 25, 'g', '2025-05-01'),
       (5, 150, 'g', '2025-03-10');

-- 5. Schedule meals
INSERT INTO Meal_Plan (recipe_id, date, meal_type)
VALUES (1, '2025-03-01', 'Dinner'),
       (2, '2025-03-02', 'Dinner');

-- 6. View all recipes
SELECT recipe_id, name, cuisine, cooking_time, servings
FROM Recipes;

-- 7. List ingredients for a recipe (recipe_id = 1)
SELECT i.name, ri.quantity, ri.unit
FROM Recipe_Ingredients ri
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
WHERE ri.recipe_id = 1;

-- 8. Check pantry stock
SELECT i.name, p.quantity, p.unit, p.expiration_date
FROM Pantry p
JOIN Ingredients i ON p.ingredient_id = i.ingredient_id;

-- 9. Update pantry stock (add 50g Pasta)
UPDATE Pantry
SET quantity = quantity + 50
WHERE ingredient_id = 1;

-- 10. Generate shopping list for March 1-7, 2025
SELECT i.name, SUM(ri.quantity) - COALESCE(p.quantity, 0) AS needed, ri.unit
FROM Recipe_Ingredients ri
JOIN Meal_Plan mp ON ri.recipe_id = mp.recipe_id
JOIN Ingredients i ON ri.ingredient_id = i.ingredient_id
LEFT JOIN Pantry p ON ri.ingredient_id = p.ingredient_id
WHERE mp.date BETWEEN '2025-03-01' AND '2025-03-07'
GROUP BY i.name, ri.unit
HAVING needed > 0;

-- 11. Delete a meal plan entry (plan_id = 1)
DELETE FROM Meal_Plan
WHERE plan_id = 1;
