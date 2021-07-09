from datetime import datetime
from blog import db, login_manager
from flask import current_app
from werkzeug.security import generate_password_hash, check_password_hash
from flask_login import UserMixin
from blog.search import add_to_index, remove_from_index, query_index
from flask_moment import Moment

class SearchableMixin(object):
    @classmethod
    def search(cls, expression, page, per_page):
        ids, total = query_index(cls.__tablename__, expression, page, per_page)
        if total == 0:
            return cls.query.filter_by(id=0), 0
        when = []
        for i in range(len(ids)):
            when.append((ids[i], i))
        return cls.query.filter(cls.id.in_(ids)).order_by(
            db.case(when, value=cls.id)), total

    @classmethod
    def before_commit(cls, session):
        session._changes = {
            'add': list(session.new),
            'update': list(session.dirty),
            'delete': list(session.deleted)
        }

    @classmethod
    def after_commit(cls, session):
        for obj in session._changes['add']:
            if isinstance(obj, SearchableMixin):
                add_to_index(obj.__tablename__, obj)
        for obj in session._changes['update']:
            if isinstance(obj, SearchableMixin):
                add_to_index(obj.__tablename__, obj)
        for obj in session._changes['delete']:
            if isinstance(obj, SearchableMixin):
                remove_from_index(obj.__tablename__, obj)
        session._changes = None

    @classmethod
    def reindex(cls):
        for obj in cls.query:
            add_to_index(cls.__tablename__, obj)

db.event.listen(db.session, 'before_commit', SearchableMixin.before_commit)
db.event.listen(db.session, 'after_commit', SearchableMixin.after_commit)
class Post(SearchableMixin, db.Model):
  __searchable__ = ['post']
  id = db.Column(db.Integer, primary_key=True)
  date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
  title = db.Column(db.Text, nullable=False)
  content = db.Column(db.Text, nullable=False)
  image_file = db.Column(db.String(40), nullable=False, default='default.jpg')
  author_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)

  likes = db.relationship('PostLike', backref='post', lazy='dynamic')

  def __repr__(self):
    return f"Post('{self.date}', '{self.title}', '{self.content}')"


  likers = db.Table('likers',
      db.Column('user_id', db.Integer, db.ForeignKey('post.id')),
      db.Column('user_id', db.Integer, db.ForeignKey('post.id'))
      )

  def likes_total(likes):
    return PostLike.query.filter(
        PostLike.post_id == likes.id).count() > 0

class Policy(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
  content = db.Column(db.Text, nullable=False)
  title = db.Column(db.Text, nullable=False)

  def __repr__(self):
    return f"Policy('{self.date}', '{self.title}', '{self.content}')"    

class About(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
  content = db.Column(db.Text, nullable=False)
  title = db.Column(db.Text, nullable=False)

  def __repr__(self):
    return f"About('{self.date}', '{self.title}', '{self.content}')"

class Contact(db.Model):
  id = db.Column(db.Integer, primary_key=True)
  date = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
  content = db.Column(db.Text, nullable=False)
  title = db.Column(db.Text, nullable=False) 

  def __repr__(self):
    return f"Contact('{self.date}', '{self.title}', '{self.content}')"        

class User(UserMixin,db.Model):
  id=db.Column(db.Integer,primary_key=True)
  username=db.Column(db.String(15),unique=True,nullable=False)
  first_name=db.Column(db.String(20),unique=True,nullable=False)
  last_name=db.Column(db.String(20),unique=True,nullable=False)
  email=db.Column(db.String(120),unique=True,nullable=False)
  password_hash=db.Column(db.String(128))
  password=db.Column(db.String(60),nullable=False)
  post=db.relationship('Post',backref='user',lazy=True)
  comment=db.relationship('Comment',backref='user',lazy=True)
  is_admin=db.Column(db.Boolean,nullable=False,default=False)
  liked=db.relationship('PostLike',foreign_keys='PostLike.user_id',backref='user', lazy='dynamic')

  def like_post(self, post):
      if not self.has_liked_post(post):
          like = PostLike(user_id=self.id, post_id=post.id)
          db.session.add(like)

  def unlike_post(self, post):
      if self.has_liked_post(post):
          PostLike.query.filter_by(
              user_id=self.id,
              post_id=post.id).delete()

  def has_liked_post(self, post):
      return PostLike.query.filter(
          PostLike.user_id == self.id,
          PostLike.post_id == post.id).count() > 0

  def __repr__(self):
    return f"User('{self.username}','{self.email}')"

  @property
  def password(self):
    raise AttributeError('password is not a readable attribute')

  @password.setter
  def password(self,password):
    self.password_hash=generate_password_hash(password)

  def verify_password(self,password):
    return check_password_hash(self.password_hash,password)

  @login_manager.user_loader
  def load_user(user_id):
    return User.query.get(int(user_id))

class PostLike(db.Model):
    __tablename__ = 'post_like'
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'))
    post_id = db.Column(db.Integer, db.ForeignKey('post.id'))      
class Comment(db.Model):
  id = db.Column(db.Integer,primary_key=True)
  date = db.Column(db.DateTime,nullable=False,default=datetime.utcnow)
  content = db.Column(db.Text,nullable=False)
  parent_id = db.Column(db.Integer,db.ForeignKey('comment.id'),nullable=True)
  post_id = db.Column(db.Integer,db.ForeignKey('post.id'),nullable=False)
  author_id = db.Column(db.Integer,db.ForeignKey('user.id'),nullable=False)
  parent = db.relationship('Comment',backref='comment_parent',remote_side=id,lazy=True)

  def __repr__(self):
    return f"Post('{self.date}','{self.content}')"