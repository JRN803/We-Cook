from WeCook import db

class Users(db.Model):

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    email = db.Column(db.String(128), unique=True, nullable=False)
    image_file = db.Column(db.String(32), nullable=False, default="default.jpg")
    password = db.Column(db.String(128), nullable=False)
    first_name = db.Column(db.String(128), nullable=False)
    last_name = db.Column(db.String(128), nullable=False)
    loginToken = db.relationship("Tokens",uselist=False,backref='user',lazy=True, cascade="all,delete")
    recipes = db.relationship("Recipes",backref="createdBy",lazy=True)

    def __repr__(self):
        return f"User('{self.email}')"

class Tokens(db.Model):
    
    id = db.Column(db.Integer, primary_key=True)
    hashedToken = db.Column(db.String(256))
    uid = db.Column(db.Integer,db.ForeignKey('users.id'), nullable = False)
    expDate = db.Column(db.DateTime, nullable=False)

class Meals(db.Model):

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(16), nullable=False, unique=True)
    recipes = db.relationship("MealsRecipes",lazy=True, backref="meal")

# ============ Linker Model ============
class MealsRecipes(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    recipeId = db.Column(db.Integer,db.ForeignKey("recipes.id"),nullable=False)
    mealId = db.Column(db.Integer,db.ForeignKey("meals.id"),nullable=False)
# =======================================
    
class Recipes(db.Model):

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(64), nullable=False)
    ingredientLinks = db.relationship("RecipesIngredients", backref="recipe", lazy=True, cascade="all, delete")
    instructions = db.Column(db.Text,nullable=True)
    ownerId = db.Column(db.Integer, db.ForeignKey("users.id"),nullable = False)
    uri = db.Column(db.String(256))
    meals = db.relationship("MealsRecipes",lazy=True, backref="recipe", cascade="all, delete")

# ============ Linker Model ============
class RecipesIngredients(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    recipeId = db.Column(db.Integer,db.ForeignKey("recipes.id"),nullable=False)
    ingredientId = db.Column(db.Integer,db.ForeignKey("ingredients.id"),nullable=False)
# =======================================
    
class IngredientNames(db.Model):
    
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    name = db.Column(db.String(32), nullable = False, unique = True)
    measurements = db.relationship("Ingredients", lazy = True)

# ============ Linker Model ============
class Ingredients(db.Model):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    ingredientNameId = db.Column(db.Integer,db.ForeignKey("ingredient_names.id"), primary_key=True, nullable=False)
    measurementId = db.Column(db.Integer,db.ForeignKey("measurements.id"), primary_key=True, nullable=False)
    recipes = db.relationship("RecipesIngredients", lazy = True, backref="details")
# =======================================
    
class Measurements(db.Model):

    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    unit = db.Column(db.String(16), primary_key=True, default="") # null, g, oz, ...
    whole = db.Column(db.Integer, primary_key=True, default=0)
    numerator = db.Column(db.Integer, primary_key=True, default=0)
    denominator = db.Column(db.Integer, primary_key=True, default=0)
    ingredients = db.relationship("Ingredients", lazy = True)
