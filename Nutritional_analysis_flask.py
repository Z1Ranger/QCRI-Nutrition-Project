import json
import requests
from keys import *  # initialize app-id and app-key by client in file named keys
from flask import Flask, request, jsonify
from flask_restful import Resource, Api
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate

app = Flask(__name__)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://postgres:vishnu@localhost:5432/nutrition"
db = SQLAlchemy(app)
migrate = Migrate(app, db)

api_url_base = 'https://trackapi.nutritionix.com/v2/'
headers = {'x-app-id': nutrition_app_id,      # protecting client app-id
           'x-app-key': nutrition_app_key,    # protecting client app-key
           'x-remote-user-id': '0'}


class NutrientModel(db.Model):
    __tablename__ = 'n_info'

    id = db.Column(db.Integer, primary_key=True)
    date = db.Column(db.String())
    tot_cals = db.Column(db.String())
    tot_carbs = db.Column(db.String())
    tot_proteins = db.Column(db.String())
    tot_fats = db.Column(db.String())



    def __init__(self, date, tot_cals, tot_carbs, tot_proteins, tot_fats):
        self.date = date
        self.tot_cals = tot_cals
        self.tot_carbs = tot_carbs
        self.tot_proteins = tot_proteins
        self.tot_fats = tot_fats

    def __repr__(self):
        return f"<Date {self.date}>"


@app.route('/food', methods=['POST'])
def get_info():
    req_data = request.get_json()
    food = req_data['food']
    api_url = '{}natural/nutrients'.format(api_url_base)
    query = {"query": food}
    response = requests.post(api_url, params=headers, data=query)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        food_list = repositories['foods']
        print(food_list)

        if food_list is not None:
            tot_cals = 0
            tot_fats = 0
            tot_proteins = 0
            tot_carbs = 0
            food_dict = {}
            food_dict['foods'] = []

            for i in range(len(food_list)):
                tot_cals += food_list[i]['nf_calories']
                tot_fats += food_list[i]['nf_total_fat']
                tot_carbs += food_list[i]['nf_total_carbohydrate']
                tot_proteins += food_list[i]['nf_protein']

                food_dict['foods'].append({'food': food_list[i]['food_name'],
                                           'img': food_list[i]['photo']['thumb'],
                                           'cals': food_list[i]['nf_calories'],
                                           'fats': food_list[i]['nf_total_fat'],
                                           'carbs': food_list[i]['nf_total_carbohydrate'],
                                           'proteins': food_list[i]['nf_protein'],
                                           'qty': food_list[i]['serving_qty']})

            food_dict['tot_cals'] = tot_cals
            food_dict['tot_fats'] = tot_fats
            food_dict['tot_carbs'] = tot_carbs
            food_dict['tot_proteins'] = tot_proteins

            return food_dict
        else:
            print('No Repo List Found')
            return {}
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


@app.route('/nutrient_upload', methods=['POST'])
def handle_nutrients():
    if request.is_json:
        data = request.get_json()
        n_info = NutrientModel(date=data['date'], tot_cals=data['tot_cals'], tot_carbs=data['tot_carbs'], tot_proteins=data['tot_proteins'], tot_fats=data['tot_fats'])
        db.session.add(n_info)
        db.session.commit()
        return {"message": f"Date {n_info.date} has been created successfully."}
    else:
        return {"error": "The request payload is not in JSON format"}


@app.route('/nutrient_info', methods=['POST'])
def nutrients_date():
    if request.is_json:
        date = request.get_json()['date']
        nutrient_by_date = NutrientModel.query.filter_by(date = date).all()
        tot_cal = 0
        tot_carb = 0
        tot_fat = 0
        tot_protein = 0
        for n_meal in nutrient_by_date:
            tot_cal += int(n_meal.tot_cals)
            tot_carb += int(n_meal.tot_carbs)
            tot_protein += int(n_meal.tot_proteins)
            tot_fat += int(n_meal.tot_fats)

        return {'tot_cals': tot_cal, 'tot_carbs': tot_carb, 'tot_proteins': tot_protein,'tot_fats': tot_fat}
    else:
        return {"error": "The request payload is not in JSON format"}



if __name__ == "__main__":
    app.run(debug=True)
