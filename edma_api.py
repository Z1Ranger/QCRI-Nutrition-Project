import json
import requests


api_url_base = 'https://nutrition-api.esha.com/'
food_id_headers = {'Accept': 'application/json',
           'Ocp-Apim-Subscription-Key': '5d25cb113f614b79989bbeb9b9fde35a',
           'Content-Type': 'application/json'}

food_info_headers = {'Accept': 'application/json',
           'Ocp-Apim-Subscription-Key': '5d25cb113f614b79989bbeb9b9fde35a',
           'Content-Type': 'application/vnd.com.esha.data.Foods+json'}

food_items_eaten = []


def get_food_id(food):
    api_url = '{}foods?query={}&start=0&count=1&spell=true'.format(api_url_base,
                                                                   food)

    response = requests.get(api_url, headers=food_id_headers)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print(
            '[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


def get_info(query):
    api_url = '{}analysis'.format(api_url_base)
    response = requests.post(api_url, data=str(query), headers=food_info_headers)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


# while input() == 'y':
food_item = input()
query = get_food_id(food_item)

if query:
    food_items_eaten.append(query)

print(food_items_eaten[0])

val = {"items": [{"id": food_items_eaten[0]['items'][0]['id']}]}

print(val)

print(get_info(val))








