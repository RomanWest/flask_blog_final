from datetime import datetime
from flask import render_template, url_for, request, redirect, flash, g, current_app, session
from blog import app, db
from blog.models import User, Post, Comment, Policy, About, Contact
from blog.forms import RegistrationForm, LoginForm, CommentForm, SearchForm
from flask_login import login_user, logout_user, login_required, current_user
from flask_babel import _, get_locale

@app.route("/") 
@app.route("/home") 
def home():
    posts = Post.query.order_by(Post.date.desc())
    return render_template('home.html', posts=posts, title='Decending')

def my_view1():
    data = None
    if session.new:
         user = User()
         db.session.commit()
         session['anonymous_user_id'] = user.id
    else:
         user = User.query.get(session['anonymous_user_id'])

@app.route("/assend")
def home_assend():
    posts = Post.query.all() 
    return render_template('assend.html', posts=posts, title='Assending')

@app.route("/about") 
def about():
  about = About.query.all() 
  return render_template('about.html', about=about, title='About')

@app.route("/contact") 
def contact():
  contact = Contact.query.all()
  return render_template('contact.html', contact=contact, title='Contact')

@app.route("/policy") 
def policy():
  policy = Policy.query.all()
  return render_template('policy.html', policy=policy, title='Policy')

@app.route("/post/<int:post_id>")
def post(post_id):
  post = Post.query.get_or_404(post_id)
  comments = Comment.query.filter(Comment.post_id==post.id)
  form = CommentForm()
  return render_template('post.html', post=post, comments=comments, form=form)

@app.route('/post/<int:post_id>/comment',methods=['GET','POST'])
@login_required
def post_comment(post_id):
  post=Post.query.get_or_404(post_id)
  form=CommentForm()
  if form.validate_on_submit():
    db.session.add(Comment(content=form.comment.data,post_id=post.id,author_id=current_user.id))
    db.session.commit()
    flash("Your comment has been added to the post","success!")
    return redirect(f'/post/{post.id}')
  comments=Comment.query.filter(Comment.post_id==post.id)
  return render_template('post.html',post=post,comments=comments,form=form)

@app.route('/post/<int:post_id>/<action>')
@login_required
def like_action(post_id, action):
    post = Post.query.get_or_404(post_id)
    if action == 'like':
        current_user.like_post(post)
        db.session.commit()
    if action == 'unlike':
        current_user.unlike_post(post)
        db.session.commit()
    else:
        flash("Please login to like posts")
    return redirect(request.referrer)

@app.route("/register",methods=['GET','POST'])
def register():
  form = RegistrationForm()
  if form.validate_on_submit():
    user = User(username=form.username.data, first_name=form.first_name.data, last_name=form.last_name.data, email=form.email.data, password=form.password.data)
    db.session.add(user)
    db.session.commit()
    flash('Registration successful!')
    return redirect(url_for('home'))
  return render_template('register.html',title='Register',form=form)

@app.route("/login",methods=['GET','POST'])
def login():
  form = LoginForm()
  if form.validate_on_submit():
    user = User.query.filter_by(email=form.email.data).first()
    if user is not None and user.verify_password(form.password.data):
        login_user(user)
        flash('Login successful!')
        return redirect(url_for('home'))
    else:
        flash("Email or password is incorrect")
  return render_template('login.html',title='Login',form=form)

@app.route("/logout")
def logout():
    logout_user()
    flash('Logout successful!')
    return redirect(url_for('home'))



"""
@app.before_app_request
def before_request():
    if current_user.is_authenticated:
        current_user.last_seen = datetime.utcnow()
        db.session.commit()
        g.search_form = SearchForm()
    g.locale = str(get_locale())
"""

@app.route('/search')
@login_required
def search():
    if not g.search_form.validate():
        return redirect(url_for('home'))
    page = request.args.get('page', 1, type=int)
    posts, total = Post.search(g.search_form.q.data, page,
                               current_app.config['POSTS_PER_PAGE'])
    next_url = url_for('Search', q=g.search_form.q.data, page=page + 1) \
        if total > page * current_app.config['POSTS_PER_PAGE'] else None
    prev_url = url_for('Search', q=g.search_form.q.data, page=page - 1) \
        if page > 1 else None
    return render_template('search.html', title=_('Search'), posts=posts,
                           next_url=next_url, prev_url=prev_url)

