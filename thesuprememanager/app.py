import time
from flask import Flask, render_template, request, jsonify, send_file
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from bs4 import BeautifulSoup
import requests
import firebase_admin
from firebase_admin import credentials
from firebase_admin import firestore
from selenium.webdriver.firefox.options import Options
from docxtpl import DocxTemplate
from datetime import date

def create_app():
    # create and configure the app
    app = Flask(__name__)

    cred = credentials.Certificate("../firebase-key.json")
    firebase_admin.initialize_app(cred, {
    'projectId': 'thesupremehacks',
    })
    db = firestore.client()

    @app.route('/')
    def index():
        return render_template('index.html')

    @app.route('/year', methods=['GET'])
    def year():
        return render_template('year.html')

    @app.route('/docket')
    def docket():
        cases_collection = db.collection('cases').stream()
        cases = []
        for case in cases_collection:
            cases.append(case.to_dict())
        return render_template('docket.html', cases = cases)

    @app.route('/docket/<string:docket>')
    def update_docket(docket):
        case = db.collection('cases').document(docket).get()
        return render_template('case.html', case = case.to_dict())
    
    @app.route('/docket/<string:docket>/opinions')
    def opinions(docket):
        case = db.collection('cases').document(docket).get()
        opinions = db.collection('cases').document(docket).collection('opinions').stream()
        users = []
        for opinion in opinions:
            thought = opinion.to_dict()
            user = db.collection('users').document(opinion.id).get()
            if user.exists:
                user = user.to_dict()
            else:
                print("this should never happen")
                print('opinion stored uid', opinion.id)
                continue
            user.update({'thought': thought})
            count = user['voteCount']
            if count < 3:
                user.update({'activity': 'Low'})
            elif count < 6:
                user.update({'activity': 'Medium'})
            elif count < 9:
                user.update({'activity': 'High'})
            elif count < 12:
                user.update({'activity': 'Very High'})
            else:
                user.update({'activity': 'Extreme'})
            users.append(user)
        return render_template('opinions.html', case = case.to_dict(), users=users)

    @app.route('/docket/<string:docket>/override', methods=['POST'])
    def override(docket):
        overridetext = request.get_data(as_text=True)
        case = db.collection('cases').document(docket).set({'override': overridetext}, merge = True)
        return 'done'

    @app.route('/docket/<string:docket>/generate')
    def generate(docket):
        doc = DocxTemplate("template2.docx")
        case = db.collection('cases').document(docket).get()
        datestr = date.today().strftime("%b-%d-%Y")
        opinions = db.collection('cases').document(docket).collection('opinions').stream()
        users = []
        for opinion in opinions:
            thought = opinion.to_dict()
            user = db.collection('users').document(opinion.id).get()
            if user.exists:
                user = user.to_dict()
            else:
                print("this should never happen")
                print('opinion stored uid', opinion.id)
                continue
            user.update({'thought': thought})
            users.append(user)
        if (len(users)==0):
            return 'not enough data'
        case = case.to_dict()
        doc.render({'users': users, 'date': datestr, 'case': case, 'supportedgroup': case['respondent'] if (case['totalCount'] - case['plantiffCount'] > case['plantiffCount']) else case['petitioner']})
        title = "generated_doc.docx"
        doc.save(title)
        return send_file(title, attachment_filename=(docket + '-amicus.docx'))

    @app.route('/api/year/<string:year>')
    def update_year(year):
        if 2+3 == 5:
            time.sleep(4)
            return 'done'
        def repair(string):
            string = BeautifulSoup(string, 'html.parser').text
            string = string.replace(u'\xa0', u' ')
            return string

        # show the post with the given id, the id is an integer
        options = Options()
        options.headless = True
        driver = webdriver.Firefox(options=options)
        YEAR = year
        try:
            driver.get('https://www.oyez.org/cases/' + YEAR)
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, 'a[href^="cases/'+ YEAR +'/"]'))
            )

            DATE_TYPES = ['granted', 'argued', 'decided', 'citation']

            elements = driver.find_elements(By.CSS_SELECTOR, 'ul.index.ng-scope li.ng-scope')
            print('here')
            cases = []
            for ele in elements:
                info = {}
                title = ele.find_element(By.TAG_NAME, 'h2')
                link = ele.find_element(By.CSS_SELECTOR, 'a[href^="cases/'+ YEAR +'/"]')
                id = link.get_attribute('href').split('/')[-1]
                description = ele.find_element(By.CLASS_NAME, 'description')
                dates = []
                for date in DATE_TYPES:
                    val = ele.find_element(By.CLASS_NAME, date).find_elements(By.TAG_NAME, 'div')[0]
                    if val == '':
                        val = ele.find_element(By.CLASS_NAME, date).find_elements(By.TAG_NAME, 'div')[-1]
                    dates.append(val.text)
                info.update({'title': title.text, 'id': id, 'description': description.text, 'dates': dates})
                response = requests.get('https://api.oyez.org/cases/'+YEAR+'/'+id).json()
                info.update({'petitioner': response['first_party'], 'respondent': response['second_party'], 'lower_court': response['lower_court']['name'], 'facts': repair(response['facts_of_the_case']), 'question': repair(response['question'])})
                cases.append(info)
                
            print('here3')
            cases_collection = db.collection('cases')
            print('here2')
            for case in cases:
                cases_collection.document(case['id']).set(case, merge=True)
        finally:
            driver.quit()
        return jsonify(cases)
    return app