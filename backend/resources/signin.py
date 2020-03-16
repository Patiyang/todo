from flask_restful import Resource
from flask import request
from models import db, User, UserSchema
import random
import string

users_schema = UserSchema(many=True)
user_schema = UserSchema()


class SignIn(Resource):
    def post(self):
        # result = ''
        json_data = request.get_json(force=True)
        header = request.headers['Authorization']
        
        if not header:
            result = self.signIn_Uname_and_Password(json_data)
        else:
            print (header)
            user = User.query.filter_by(api_key=header).first()
            if user:
                result = user_schema.dump(user).data
            else:
                result = self.signIn_Uname_and_Password
        return{'status': 'success', 'data': result}, 201
    
    def signIn_Uname_and_Password(self, json_data):
        json_data = request.get_json(force=True)
        if not json_data:
                return {'message': 'No input data provided'}, 400
            # data desirialization and validation
        data, errors = user_schema.load(json_data)
        if errors:
                return errors, 422
            
        user = User.query.filter_by(username=data['username']).first()
            
        if user.password != json_data['password']:
            return{'message': 'the password or username might be incorrect'}, 400

        return user_schema.dump(user).data
         
    def get_key(self):
        return''.join(random.choice(string.ascii_letters + string.digits) for _ in range(30))