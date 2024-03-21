from flask import Blueprint
from WeCook.controllers import *

blueprint = Blueprint('blueprint', __name__)

blueprint.route('/', methods=['GET'])(Index.root)
blueprint.route('/user/register',
                methods=['PUT', 'POST'])(UserController.register)
blueprint.route('/user/login', methods=['PUT', 'POST'])(UserController.login)
blueprint.route('/user/logout', methods=['PUT', 'POST'])(UserController.logout)
blueprint.route('/user/home', methods=['PUT', 'POST'])(UserController.home)
blueprint.route('/user/home/newrecipe',
                methods=['PUT', 'POST'])(UserController.new_recipe)
blueprint.route('/user/home/deleterecipe',
                methods=['PUT', 'POST'])(UserController.delete_recipe)
blueprint.route('/user/edit',methods=["PUT","POST"])(UserController.editUser)

blueprint.route('/images/pfp', methods=['GET'])(ImageController.getUserImage)
blueprint.route('/images/pfp', methods=['PUT',"POST"])(ImageController.setUserImage)
blueprint.route('/images/recipe',
                methods=['GET'])(ImageController.getRecipeImage)
blueprint.route('/images/recipe',
                methods=["POST", "PUT"])(ImageController.setRecipeImage)