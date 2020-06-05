import json
import requests
from keys import *  # initialize app-id and app-key by client in file named keys
from flask import Flask, request, jsonify
from flask_restful import Resource, Api

app = Flask(__name__)


api_url_base = 'https://trackapi.nutritionix.com/v2/'
headers = {'x-app-id': nutrition_app_id,      # protecting client app-id
           'x-app-key': nutrition_app_key,    # protecting client app-key
           'x-remote-user-id': '0'}


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


# food_consumed = input()


if __name__ == "__main__":
    app.run(debug=True)
