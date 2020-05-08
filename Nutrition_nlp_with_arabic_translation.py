import json
import requests
from key import *  # initialize app-id and app-key by client in file named keys
from ibm_watson import LanguageTranslatorV3
from ibm_cloud_sdk_core.authenticators import IAMAuthenticator

nutrition_api_url_base = 'https://trackapi.nutritionix.com/v2/'
nutrition_headers = {'x-app-id': nutrition_app_id,   # protecting client app-id
            'x-app-key': nutrition_app_key,    # protecting client app-key
        'x-remote-user-id': '0'}

ibm_headers = {"Content-Type": "application/json", "apikey": ibm_api_key}


def get_info(food):
    api_url = '{}natural/nutrients'.format(nutrition_api_url_base)
    query = {"query": food}
    response = requests.post(api_url, query, headers=nutrition_headers)

    if response.status_code == 200:
        repositories = json.loads(response.content.decode('utf-8'))
        return repositories
    else:
        print('[!] HTTP {0} calling [{1}]'.format(response.status_code, api_url))
        return None


food_consumed = input()
food_list = get_info(food_consumed)['foods']

if food_list is not None:
    tot_cal = 0
    food_str_list = []
    for i in range(len(food_list)):
        tot_cal += food_list[i]['nf_calories']
        food_item_str = str(food_list[i]['serving_qty']) + ' ' + \
            food_list[i]['serving_unit'].split(' ')[0] + ' ' + \
            food_list[i]['food_name']
        food_str_list.append(food_item_str)

    food_str = ', '.join(food_str_list)

    print(food_list)
    calorie_count_txt = "Calorie Count for {} is {}".format(food_str, tot_cal)
    print(calorie_count_txt)
else:
    calorie_count_txt = 'Wrong input/ No repo found'
    print(calorie_count_txt)


def convert_en_to_ar(text):

    authenticator = IAMAuthenticator(ibm_api_key)
    language_translator = LanguageTranslatorV3(
        version='2018-05-01',
        authenticator=authenticator
    )

    language_translator.set_service_url(ibm_url)
    translation = language_translator.translate(
        text=text,
        model_id='en-ar').get_result()

    ar_translation = translation['translations'][0]['translation']
    return ar_translation


calorie_count_in_ar = convert_en_to_ar(calorie_count_txt)
print(calorie_count_in_ar)



