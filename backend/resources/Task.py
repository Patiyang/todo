from flask_restful import Resource
from flask import request
from models import db, User, Task, TaskSchema
import random
import string

tasks_schema = TaskSchema(many=True)
task_schema = TaskSchema()


class Tasks(Resource):
    def post(self):
        header = request.headers["Authorization"]
        json_data = request.get_json(force=True)
        if not header:
            return {'message':'No Api Key'}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                tasks = Task(
                    user_id= user.id,
                    done= json_data['done'],
                    repeats= json_data['repeats'],
                    deadline= json_data['deadline'],
                    reminder= json_data['reminder'],
                    note= json_data['note'],
                    title= json_data['title']
                )
                db.session.add(tasks)
                db.session.commit()

                result = task_schema.dump(tasks).data
                return{'status':'success', 'data':result}, 201
            else:
                return {'Message':'No user with that api key'}, 400


    def get(self):
        header = request.headers['Authorization']
        if not header:
            return {'message':'No Api Key'}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
        if user:
            tasks = Task.query.filter_by(user_id = user.id).all()
            tasks = tasks_schema.dump(tasks).data

            return{'status': 'success', 'data': tasks}, 201

   

class Single(Resource):

    def put(self, id):
        header = request.headers['Authorization']
        json_data = request.get_json(force = True)
        if not json_data:
            return{'message':'no valid input data provided'}, 400
        if not header:
            return{'message':'No api key has been found'}, 400

        data, errors = task_schema.load(json_data)
        if errors:
            return errors, 422
        
        else:
            task = Task.query.get(id)
            if not task:
                return {'message': 'the task does not exist'}
        
        done= json_data['done']
        repeats= json_data['repeats']
        deadline= json_data['deadline']
        reminder= json_data['reminder']
        note= json_data['note']
        title= json_data['title']
        
        task.done = done
        task.repeats = repeats
        task.deadline = deadline
        task.reminder = reminder
        task.note = note
        task.title = title

        db.session.commit()
        result = task_schema.dump(task)
        return{'status':'success', 'data':result}, 204
        
    def delete(self, id):
        header = request.headers['Authorization']
        if not header:
            return{'message':'No api key has been found'}, 402
        else:
            task = Task.query.get(id)
            if not task:
                return{'message':'that task is not here bruh'}

        db.session.delete(task)
        db.session.commit()
        result = task_schema.dump(task)

        return{'status':'deleted', 'data': result}, 204

    def get(self, id):
        header = request.headers['Authorization']
        json_data = request.get_json(force = True)
        if not json_data:
            return{'message':'no valid input data provided'}, 400
        if not header:
            return {'message':'No Api Key'}, 400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user: 
                task = Task.query.get(id)
        return task_schema.dump(task).data