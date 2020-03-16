from flask import Blueprint
from flask_restful import Api
from backend.resources.user import User
from backend.resources.register import Register
from backend.resources.signin import SignIn
from backend.resources.Task import Tasks, Single

api_bp = Blueprint('v1', __name__)
api = Api(api_bp)

# Route
api.add_resource(Register, '/register')
api.add_resource(SignIn, '/signin')
api.add_resource(Tasks, '/tasks')
api.add_resource(Single, '/tasks/<id>')
