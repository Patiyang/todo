from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
ma = Marshmallow()

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True, unique=True, autoincrement = True)
    api_key = db.Column(db.String())
    username = db.Column(db.String(), primary_key=True, unique=True)
    first_name = db.Column(db.String())
    last_name = db.Column(db.String())
    password = db.Column(db.String())
    email = db.Column(db.String(),primary_key=True, unique=True)

    def __init__(self, api_key, username, first_name, last_name, password, email):
        self.api_key = api_key
        self.username = username
        self.first_name = first_name
        self.last_name = last_name
        self.password = password
        self.email = email
    
    
    
class UserSchema(ma.Schema):
    id = fields.Integer(dump_only=True)
    api_key = fields.String()
    username = fields.String()
    first_name = fields.String()
    last_name = fields.String()
    email = fields.String()
    password = fields.String()

    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'id': self.id,
            'api_key':self.api_key,
            'username': self.username,
            'first_name': self.first_name,
            'last_name': self.last_name,
            'email': self.email,
            'password': self.password
        }

class Task(db.Model):
    __table_name__ = 'tasks'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    done = db.Column(db.Boolean(), nullable = False, default = False)
    repeats = db.Column(db.String())
    deadline = db.Column(db.String())
    reminder = db.Column(db.String())
    note = db.Column(db.String())
    title = db.Column(db.String())

    def __init__(self, user_id, done, repeats, deadline, reminder, note, title):
        self.user_id = user_id
        self.done = done
        self.repeats = repeats
        self.deadline = deadline
        self.reminder = reminder
        self.note =note
        self.title = title

class TaskSchema(ma.Schema):
    id = fields.Integer()
    user_id = fields.Integer()
    done = fields.Boolean()
    repeats = fields.String()
    deadline = fields.String()
    reminder = fields.String()
    note = fields.String()
    title = fields.String()
   
def __repr__(self):
        return '<id {}>'.format(self.id)

def serialize(self):
    return{
        'id': self.id,
        'user_id':self.user_id,
        'done': self.done,
        'repeats': self.repeats,
        'deadline': self.deadline,
        'reminder': self.reminder,
        'note': self.note,
        'title':self.title
            # 'password': self.password
        }