import json
import requests
from key import *  # initialize app-id and app-key by client in file named keys


api_url_base = 'https://{}:{}@www.nutritics.com/api/v1.1/LIST/'.format(nutritics_username, nutritics_password)


def get_info(food):
    api_url = '{}&food={}&attr=energyKcal,carbohydrate,protein,fat,water,' \
              'starch,fibre,sugars,freesugars,glucose,galactose,fructose,' \
              'sucrose,maltose,lactose,trans,cholesterol,sodium,potassium,' \
              'chloride,calcium,phosphorus,magnesium,iron,zinc,copper,' \
              'manganese,selenium,iodine'.format(api_url_base, food)

    response = requests.get(api_url)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


print(get_info(input('Enter a food item\n')))


