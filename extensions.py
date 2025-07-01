from flask import Flask
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:hfy201612@localhost:3306/media-player'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.secret_key = '123456'

db = SQLAlchemy(app)