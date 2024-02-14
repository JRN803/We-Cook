import os
from dotenv import load_dotenv
from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_bcrypt import Bcrypt

load_dotenv()

app = Flask(__name__) # Init app
app.config["SQLALCHEMY_DATABASE_URI"] = f'mysql+pymysql://{os.environ["DB_USERNAME"]}:{os.environ["DB_PASSWORD"]}@{os.environ["DB_URI"]}/{os.environ["DB_NAME"]}' #Connect DB
app.app_context().push()
db = SQLAlchemy(app) #Run DB
bcrypt = Bcrypt(app)

from WeCook.routes import blueprint
app.register_blueprint(blueprint, url_prefix='/api')
db.drop_all()
db.create_all()
