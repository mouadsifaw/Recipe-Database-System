PRAGMA foreign_keys = ON;

-- Stores recipe details
CREATE TABLE Recipes (
    recipe_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    cuisine TEXT,
    cooking_time INTEGER,
    instructions TEXT,
    servings INTEGER
);

-- Stores ingredient details
CREATE TABLE Ingredients (
    ingredient_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category TEXT
);

-- Junction table linking recipes to their ingredients
CREATE TABLE Recipe_Ingredients (
    recipe_id INTEGER,
    ingredient_id INTEGER,
    quantity REAL,
    unit TEXT,
    PRIMARY KEY (recipe_id, ingredient_id),
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id),
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Tracks pantry inventory
CREATE TABLE Pantry (
    pantry_id INTEGER PRIMARY KEY AUTOINCREMENT,
    ingredient_id INTEGER,
    quantity REAL,
    unit TEXT,
    expiration_date DATE,
    FOREIGN KEY (ingredient_id) REFERENCES Ingredients(ingredient_id)
);

-- Schedules meals with recipes
CREATE TABLE Meal_Plan (
    plan_id INTEGER PRIMARY KEY AUTOINCREMENT,
    recipe_id INTEGER,
    date DATE,
    meal_type TEXT,
    FOREIGN KEY (recipe_id) REFERENCES Recipes(recipe_id)
);

-- Indexes for faster joins in Recipe_Ingredients
CREATE INDEX idx_recipe ON Recipe_Ingredients(recipe_id);
CREATE INDEX idx_ingredient ON Recipe_Ingredients(ingredient_id);
