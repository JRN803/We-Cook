from WeCook.models import *
import datetime
from flask import request, jsonify
from WeCook.utils import *


def auth(f):
    def wrapper(*args, **kwargs):
        body = request.json
        try:
            cookie = body["cookie"]
            id = body["id"]
        except KeyError:
            return jsonify({"Message": "No Token or ID provided"}), 403

        user = Users.query.filter_by(id=id).first()

        if not user or not user.loginToken:
            return jsonify({"Message": "Invalid Credentials"}), 401

        if (user.loginToken.expDate < datetime.datetime.now() or
                not match_hash(user.loginToken.hashedToken, cookie)):
            invalidate_token(user.loginToken)
            return jsonify({"Message": "Invalid Credentials"}), 401

        return f(user)
    wrapper.__name__ = f.__name__
    return wrapper
