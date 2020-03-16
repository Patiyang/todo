from flask_restful import Resource
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
ma = Marshmallow()
class User(Resource):

     def __init__(self, id, api_key, username, firstname, lastname, password, email):
        self.id = id
        self.api_key = api_key
        self.username = username
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.email = email

     __tablename__ = 'users'
     __table_args__ = tuple(db.UniqueConstraint('id', 'username', name='to to app'))

     id = db.Column(db.String(), primary_key=True, unique=True)
     api_key = db.Column(db.String(), primary_key=True, unique=True)
     username = db.Column(db.String(), primary_key=True)
     first_name = db.Column(db.String())
     last_name = db.Column(db.String())
     password = db.Column(db.String())
     email = db.Column(db.String())

     def __repr__(self):
        return '<id {}>'.format(self.id)

     def serialize(self):
        return{
            'id': self.id,
            'api_key':self.api_key,
            'username': self.username,
            'firstname': self.firstname,
            'lastname': self.lastname,
            'password': self.password,
            'email': self.email
        }
     def get(self):
        return{"message": "hello patrick"}
