Project: Recipe & Pantry Management
Author: MOUAD AIT KHOUYA
GitHub Username: mouadsifaw
edX Username : mouaduzumaki2001
Location: United States, Virginia
Date : 2/27/2025

Video overview: <https://youtu.be/xka40nfTURQ>

Scope

The purpose of this database is to streamline meal planning and grocery management for individual users. It enables users to store recipes, manage pantry inventory, schedule meals, and create shopping lists by comparing required ingredients with available stock. This system aims to reduce the effort involved in organizing meals and ensure efficient ingredient use.



The database includes:

Recipes: Details such as name, cuisine, cooking time, instructions, and servings.
Ingredients: Names and categories (e.g., "vegetable" or "spice").
Recipe Ingredients: Links between recipes and ingredients, including quantities and units.
Pantry Stock: Tracks available ingredients, quantities, units, and expiration dates.
Meal Plans: Schedules recipes for specific dates and meal types (e.g., "dinner").
Which people, places, things, etc. are outside the scope of your database?

The database excludes:

User authentication or multi-user functionality (designed for a single user).
Nutritional information or dietary restriction tracking.
External integrations (e.g., grocery store APIs or recipe websites).
Advanced analytics (e.g., recipe usage trends or recommendations).
Functional Requirements
What should a user be able to do with your database?

A user should be able to:

Add, view, and modify recipes, including their ingredients and instructions.
Manage pantry inventory by adding, updating, or removing ingredients.
Schedule meals by assigning recipes to specific dates and meal types.
Generate shopping lists for planned meals by comparing required ingredients with pantry stock.
Identify recipes that can be prepared using current pantry ingredients.
What's beyond the scope of what a user should be able to do with your database?

Beyond the scope:

Sharing recipes or meal plans with others.
Automatically updating pantry stock after cooking a meal.
Converting ingredient units (e.g., grams to ounces).
Tracking nutritional data or creating diet-specific meal plans.
Representation
Entities
Which entities will you choose to represent in your database?

The database includes five entities:

Recipes
Ingredients
Recipe_Ingredients (junction table)
Pantry
Meal_Plan



Recipes:
recipe_id (INTEGER, Primary Key, AUTOINCREMENT): Unique identifier.
name (TEXT, NOT NULL): Recipe name.
cuisine (TEXT): Type of cuisine.
cooking_time (INTEGER): Time in minutes.
instructions (TEXT): Cooking steps.
servings (INTEGER): Number of servings.

Ingredients:
ingredient_id (INTEGER, Primary Key, AUTOINCREMENT): Unique identifier.
name (TEXT, NOT NULL): Ingredient name.
category (TEXT): Category (e.g., "dairy").
Recipe_Ingredients:
recipe_id (INTEGER, Foreign Key): References Recipes.
ingredient_id (INTEGER, Foreign Key): References Ingredients.
quantity (REAL): Amount needed.
unit (TEXT): Unit of measurement (e.g., "cups").

Pantry:
pantry_id (INTEGER, Primary Key, AUTOINCREMENT): Unique identifier.
ingredient_id (INTEGER, Foreign Key): References Ingredients.
quantity (REAL): Amount in stock.
unit (TEXT): Unit of measurement.
expiration_date (DATE): Expiration date.

Meal_Plan:
plan_id (INTEGER, Primary Key, AUTOINCREMENT): Unique identifier.
recipe_id (INTEGER, Foreign Key): References Recipes.
date (DATE): Scheduled date.
meal_type (TEXT): Meal type (e.g., "lunch").

Types:

INTEGER for IDs: Efficient for indexing and joining tables.
TEXT for names and instructions: Accommodates varying lengths and descriptive data.
REAL for quantities: Supports decimal values (e.g., 2.5 liters).
DATE for expiration and meal dates: Standard format for date-related data.
Why did you choose the constraints you did?

Primary Key: Ensures each record has a unique identifier.
Foreign Key: Maintains referential integrity (e.g., linking pantry items to ingredients).
NOT NULL: Guarantees critical fields like recipe names are always populated.
AUTOINCREMENT: Simplifies ID generation by automatically assigning unique values.

Entity Relationship Diagram

Here is the ER diagram, created using Mermaid.js:

erDiagram
    RECIPES {
        integer recipe_id PK
        text name
        text cuisine
        integer cooking_time
        text instructions
        integer servings
    }
    INGREDIENTS {
        integer ingredient_id PK
        text name
        text category
    }
    RECIPE_INGREDIENTS {
        integer recipe_id FK
        integer ingredient_id FK
        real quantity
        text unit
    }
    PANTRY {
        integer pantry_id PK
        integer ingredient_id FK
        real quantity
        text unit
        date expiration_date
    }
    MEAL_PLAN {
        integer plan_id PK
        integer recipe_id FK
        date date
        text meal_type
    }
    RECIPES ||--o{ RECIPE_INGREDIENTS : contains
    INGREDIENTS ||--o{ RECIPE_INGREDIENTS : used_in
    INGREDIENTS ||--o{ PANTRY : stocked_as
    RECIPES ||--o{ MEAL_PLAN : planned_as

Relationships Description

Recipes ↔ Ingredients: Many-to-many relationship via Recipe_Ingredients. A recipe requires multiple ingredients, and an ingredient can appear in multiple recipes.
Ingredients → Pantry: One-to-many. An ingredient can have multiple pantry entries (e.g., different quantities or expiration dates).
Recipes → Meal_Plan: One-to-many. A recipe can be scheduled for multiple dates and meal types.

Optimizations

Indexes:
Added to recipe_id and ingredient_id in Recipe_Ingredients to accelerate joins, which are common when generating shopping lists or checking recipe feasibility.
Normalization:
Designed in Third Normal Form (3NF) to eliminate redundancy. For example, ingredient names are stored only in Ingredients, not repeated in related tables.
These optimizations improve query performance for frequent operations like comparing pantry stock to meal plan requirements.

Limitations

Unit Consistency: Assumes users input consistent units across recipes and pantry (e.g., "grams" everywhere), as unit conversion isn’t supported.
Single-User Focus: Lacks multi-user support or access controls.
Manual Updates: Pantry stock must be manually adjusted after cooking; no automatic deduction feature exists.
Scalability: Performance may degrade with very large datasets, especially for complex shopping list queries.
What might your database not be able to represent very well?

Ingredient Substitutions: No mechanism to store or suggest alternative ingredients.
Recipe Variations: Can’t easily handle recipes with optional ingredients or multiple versions.
Dietary Needs: Lacks fields for allergens, dietary restrictions, or nutritional tracking.
