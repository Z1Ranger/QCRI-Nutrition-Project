import json
import requests
from key import *  # initialize app-id and app-key by client in file named keys


api_url_base = 'https://api.edamam.com/api/food-database/parser'


def get_info(food):
    api_url = '{}?ingr={}&app_id={}&app_key={}'.format(api_url_base, food, '8af249e7', '88adad540b364311466af7546d50d07d')
    response = requests.get(api_url)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


data = get_info(input('Enter a food item\n'))

print(data)

