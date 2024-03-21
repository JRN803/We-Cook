from datetime import date
import json
import os
import random
from WeCook.middleware import *
from flask import request, jsonify, send_file
import sqlalchemy
from WeCook.models import *
from WeCook import db
from WeCook.utils import *
import base64
# =========== Index Controller ===========


class Index:
    def root():
        return jsonify({"Message": "In Home Route"}), 200
# ========================================

# =========== User Controller ============


class UserController:

    def login():

        body = request.json

        if "cookie" in body and "id" in body:
            token = Tokens.query.filter_by(uid=body["id"]).first()
            cookie = body["cookie"]
            if (token and
                match_hash(token.hashedToken, cookie) and
                    token.expDate < datetime.datetime.now()):
                # cookie expires after 7 days of no login
                cookie = reissue_token(user.id, 7)
                return jsonify({"Message": "Login Successful",
                            "cookie": cookie, "id": user.id,
                            "fName": user.first_name,
                            "lName": user.last_name,
                            "email": user.email,
                            "pfp": user.pfp,
                            "bio": user.bio}), 200

            else:
                invalidate_token(token)

        try:
            password = body["password"]
            email = body['email']
            remember = body['remember']
        except KeyError:
            return jsonify({"Message": "Missing Fields"}), 401

        user = Users.query.filter_by(email=email).first()

        if user and match_hash(user.password, password):
            existingToken = Tokens.query.filter_by(uid=user.id).first()
            if existingToken:
                invalidate_token(existingToken)
            if remember:
                # cookie expires after 7 days of no login
                cookie = reissue_token(user.id, 7)
            else:
                # cookie expires after 1 day
                cookie = reissue_token(user.id, 1)
            return jsonify({"Message": "Login Successful",
                            "cookie": cookie, "id": user.id,
                            "fName": user.first_name,
                            "lName": user.last_name,
                            "email": user.email,
                            "pfp": user.pfp,
                            "bio": user.bio}), 200

        return jsonify({"Message": "Invalid Login"}), 403

    def logout():
        body = request.json
        try:
            user = Users.query.filter_by(id=body['id']).first()
            if not user:
                raise KeyError()
            if user.loginToken:
                invalidate_token(user.loginToken)
            return jsonify({"Message": "Logged Out"}), 200
        except KeyError:
            return jsonify({"Message": "No User Found"}), 401

    def register():
        body = request.json

        # ========== Parsing Body ===========
        try:
            password = get_hash(body["password"]).decode("utf-8")
            email = body['email']
            first_name = body['fName']
            last_name = body['lName']
        except KeyError:
            return jsonify({"Message": "Missing Fields"}), 401
        # ===================================

        # =========== Saving User ==============
        try:
            user = Users(email=email,
                         password=password,
                         first_name=first_name,
                         last_name=last_name)
            db.session.add(user)
            db.session.commit()
            return jsonify({"Message": "Account Created"}), 201

        except sqlalchemy.exc.IntegrityError:
            return jsonify({"Message": "Email is taken"}), 400
        # ======================================
    
    @auth
    def editUser(user):
        try:
            body = request.json
            user.first_name = body["fName"]
            user.last_name = body["lName"]
            user.email = body["email"]
            user.bio = body["bio"]
            db.session.commit()
            return jsonify({"Message": "Login Successful",
                            "cookie": body["cookie"], "id": user.id,
                            "fName": user.first_name,
                            "lName": user.last_name,
                            "email": user.email,
                            "pfp": user.pfp,
                            "bio": user.bio}), 200
        except Exception as e:
            print("Error line 120",e)
            return jsonify({"Message": "User could not be updated"}), 400

    @auth
    def home(user):

        recipes = []
        for r in user.recipes:

            ingredients = []
            ingredientLinks = r.ingredientLinks
            for link in ingredientLinks:
                ingredients.append(Ingredients.query.filter_by(
                    id=link.ingredientId).first().name)

            meals = []
            mealLinks = r.meals
            for m in mealLinks:
                meals.append(Meals.query.filter_by(id=m.mealId).first().name)

            recipes.append(format_recipe(r, ingredients, meals))
        return jsonify({"Recipes": recipes}), 200

    @auth
    def new_recipe(user):

        body = request.json

        try:
            name = body["name"]
            # array of objects with name, whole, numerator, denominator, unit
            ingredients = body["ingredients"]
            meals = body["meals"]
            uri = body["uri"] if ("uri" in body and body["uri"]) else None
            instructions = body["instructions"] if "instructions" in body else None
            time = body["time"] if ("time" in body and body["time"]) else None

        except KeyError:
            return jsonify({"Message": "Missing Fields"}), 400

        # Create new recipe entry
        recipe = Recipes(name=name, ownerId=user.id,
                         instructions=instructions, uri=uri,
                         time=time)
        db.session.add(recipe)
        db.session.commit()
        db.session.refresh(recipe)

        # Create meal entry and link with Recipe
        for m in meals:
            meal = add_to_db(Meals, {"name": m})

            try:
                db.session.add(MealsRecipes(
                    mealId=meal.id, recipeId=recipe.id))
            except:
                return jsonify({"Message": "An Error Occured"}), 500

        for ingredient in ingredients:
            ingredient = add_to_db(Ingredients, {"name": ingredient})

            newRecipeIngredients = RecipesIngredients(
                recipeId=recipe.id, ingredientId=ingredient.id)
            db.session.add(newRecipeIngredients)
        db.session.commit()

        return {"id": recipe.id}, 201

    @auth
    def delete_recipe(user):

        # delete recipe delete associated recipemeals and recipeingredients
        try:
            id = request.args.get("id")
            recipe = Recipes.query.filter_by(id=id).first()
            db.session.delete(recipe)
            db.session.commit()
            return jsonify({"Message": "Recipe Deleted"}), 200
        except Exception as error:
            print(error)
            return jsonify({"Message": "No Recipe Found"}), 404

# ========================================

# =========== Images Controller ===========


class ImageController:

    def getUserImage():
        try:
            id = request.args.get("id")
            user = Users.query.filter_by(id=id).first()
            imageName = user.pfp
            return send_file(f"../Images/{imageName}"), 200
        except Exception as e:
            print(e)
            return send_file("../Images/defaultUser.png"), 404

    @auth
    def setUserImage(user):

        try:
            body = request.json
            base64Data = str.encode(body["imageData"])
            imageName = f"{date.today()}{user.id}.png"
            with open(os.path.join("Images", imageName), "wb") as newImage:
                newImage.write(base64.decodebytes(base64Data))
            user.pfp = imageName
            db.session.commit()
            return jsonify({"Message": "Success"}), 201
        except Exception as e:
            print(e)
            return jsonify({"Message": "Failed"}), 400

    def getRecipeImage():
        try:
            name = request.args.get("name")
            return send_file(f"../Images/{name}"), 200
        except:
            return send_file("../Images/defaultRecipe.jpeg"), 404

    @auth
    def setRecipeImage(user):
        body = request.json
        try:
            recipeId = body["recipeId"]
            base64Data = str.encode(body["imageData"])
            recipe = Recipes.query.filter_by(
                id=recipeId, ownerId=user.id).first()
            imageName = f"{recipeId}{date.today()}{user.id}.png"
            with open(os.path.join("Images", imageName), "wb") as newImage:
                newImage.write(base64.decodebytes(base64Data))
            recipe.image = imageName
            db.session.commit()
            return jsonify({"Message": "Success"}), 201
        except Exception as e:
            print(e)
            return jsonify({"Message": "Failed"}), 400

# =========================================
