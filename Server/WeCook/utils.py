import datetime
import secrets
from WeCook import bcrypt
from WeCook import db
from WeCook.models import Tokens

def get_hash(s): return bcrypt.generate_password_hash(s,10) # Create a hash

def match_hash(h,s): return bcrypt.check_password_hash(h,s) # Check for hash equality

def reissue_token(id, expDays): # Reissue a remember me token
    cookie = secrets.token_hex(16) #create cookie
    # check db for hash of cookie and reissue if it exists
    # =========== Check duplicate ===========
    hashed = get_hash(cookie)
    duplicate = Tokens.query.filter_by(hashedToken=cookie).first()
    if duplicate: return reissue_token(id,expDays)
    # =======================================
    date = datetime.datetime.now() + datetime.timedelta(days=expDays)
    token = Tokens(hashedToken=hashed,uid = id, expDate=date)
    db.session.add(token)
    db.session.commit()
    return cookie

def invalidate_token(token=None):
    if not token: return
    db.session.delete(token)
    db.session.commit()

def format_ingredient(measurement,ingredient):
    res = ""
    if measurement.whole > 0: res += f"{measurement.whole} "
    if measurement.numerator > 0: res += f"{measurement.numerator}/{measurement.denominator} "
    res += measurement.unit + " " + ingredient.name
    return res

def format_recipe(recipe,ingredients,meals):
    res = {
        "Name": recipe.name,
        "Ingredients": ingredients,
        "Instructions": recipe.instructions,
        "URI": recipe.uri,
        "id": recipe.id
    }
    meal = []
    for m in meals: meal.append(m.name)
    res["Meals"] = meal
    return res

def add_to_db(model,data):
    try:
        item = model(**data)
        db.session.add(item)
        db.session.commit()
        db.session.refresh(item)
    except:
        item = model.query.filter_by(**data).first()
    
    return item