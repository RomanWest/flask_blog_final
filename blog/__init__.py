import os
from flask import Flask, current_app
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager
from elasticsearch import Elasticsearch
from flask_moment import Moment

app = Flask(__name__) 
app.config['SECRET_KEY'] = 
app.config['SQLALCHEMY_DATABASE_URI'] = 
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['ELASTICSEARCH_URL'] = 'http://localhost:9200'
# app.elasticsearch = Elasticsearch([app.config['ELASTICSEARCH_URL']]) \
#         if app.config['ELASTICSEARCH_URL'] else None
# app.config['ELASTICSEARCH_URL'] = os.environ.get('ELASTICSEARCH_URL')
moment = Moment(app)

db = SQLAlchemy(app)
login_manager = LoginManager()
login_manager.init_app(app)

from blog import routes 

from flask_admin import Admin
from blog.views import AdminView
from blog.models import Policy, User, Post, Comment, Contact, About
admin = Admin(app,name='Admin panel',template_mode='bootstrap3')
admin.add_view(AdminView(User, db.session))
admin.add_view(AdminView(Post, db.session))
admin.add_view(AdminView(Comment, db.session))
admin.add_view(AdminView(Policy, db.session))
admin.add_view(AdminView(Contact, db.session))
admin.add_view(AdminView(About, db.session))