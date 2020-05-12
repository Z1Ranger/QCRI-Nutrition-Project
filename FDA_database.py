import json
import requests
from key import *  # initialize app-id and app-key by client in file named keys


api_url_base = 'https://api.nal.usda.gov/fdc/v1/foods'
headers = {'Content-Type': 'application/json', 'X-Api-Key': 'fh0Slu6FpneO5wXGvxeE6Cvh8cIxR2I4xgdsFyYP'}


def get_info(food):
    api_url = '{}/search?&query={}'.format(api_url_base, food)
    response = requests.get(api_url, headers=headers)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


data = get_info(input('Enter a food item\n'))

possible_results = []
print(data)
for result in data['foods']:
    if result['dataType'] == 'Branded':
        possible_results.append((result['fdcId'], result['description'], result['brandOwner']))
    else:
        possible_results.append((result['fdcId'], result['description']))

print(possible_results)


