from hashlib import new
from db import db
from flask import Flask
from db import User
from db import BookClub
from db import Book

import json
from flask import request
import os
import datetime
import users_dao
import bcrypt

app = Flask(__name__)
db_filename = "cms.db"

app.config["SQLALCHEMY_DATABASE_URI"] = "sqlite:///%s" % db_filename
app.config["SQLALCHEMY_TRACK_MODIFICATIONS"] = False
app.config["SQLALCHEMY_ECHO"] = True

db.init_app(app)
with app.app_context():
    db.create_all()

# generalized response formats
def success_response(data, code=200):
    return json.dumps(data), code

def failure_response(message, code=404):
    return json.dumps({"error":message}), code

def extract_token(request):
    """
    Helper function that extracts the token from the header of a request
    """
    auth_header = request.headers.get("Authorization")
    if auth_header is None:
        return False, failure_response("Missing authorization header.", 400)
    bearer_token = auth_header.replace("Bearer ", "").strip()
    if bearer_token is None or not bearer_token:
        return False, failure_response("Invalid authorization header.", 400)
    return True, bearer_token

# -- Landing Route __
@app.route("/")
def land():
    """
    Endpoint for landing page
    """
    return "BookClub" #


# -- User Routes --
@app.route("/users/")
def get_users():
    """
    Endpoint for getting all users
    """
    users = [user.pass_serialize() for user in User.query.all()]
    return success_response({"users": users})

@app.route("/users/register/", methods=["POST"])
def register_account():
    """
    Endpoint for registering a new user
    Authentication
    """
    body = json.loads(request.data)
    name = body.get("name")
    username = body.get("username")
    password = body.get("password")
    if name is None or username is None or password is None:
        return failure_response("Missing name, username or password.", 400)
    success, user = users_dao.create_user(name, username, password)
    if not success:
        return failure_response("User already exists.", 400)
    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "user_id": user.id
    })

@app.route("/users/login/", methods=["POST"])
def login():
    """
    Endpoint for logging in a user
    Authentication
    """
    body = json.loads(request.data)
    username = body.get("username")
    password = body.get("password")

    if username is None or password is None:
        return failure_response("Mising username or password!", 400)
    
    success, user = users_dao.verify_credentials(username,password)

    if not success:
        return failure_response("Incorrect username or password.", 401)

    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "user_id": user.id
    })

@app.route("/users/session/", methods=["POST"])
def update_session():
    """
    Endpoint for updating a user's session
    Authentication
    """
    success, update_token = extract_token(request)
    if not success:
        return failure_response("Could not extract session token", 400)
    success_user, user = users_dao.renew_session(update_token)
    if not success_user:
        return failure_response("Invalid update token", 400)
    return success_response({
        "session_token": user.session_token,
        "session_expiration": str(user.session_expiration),
        "update_token": user.update_token,
        "user_id": user.id
    })

@app.route("/users/logout/", methods=["POST"])
def logout():
    """
    Endpoint for logging out a user
    """
    success, session_token = extract_token(request)

    if not success:
        return failure_response("Could not extract session token", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)

    user.session_token = ""
    user.session_expiration = datetime.datetime.now()
    user.update_token = ""
    db.session.commit()

    return success_response({"message": "You have successfully logged out."})

@app.route("/users/<int:user_id>/")
def get_user(user_id):
    """
    Endpoint for getting a user by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    return success_response(user.serialize())

@app.route("/users/<int:user_id>/name/", methods=["POST"])
def update_name(user_id):
    """
    Endpoint for updating a user's name 
    Authentication: Verifies session token and returns confirmation message
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Session token invalid", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    body = json.loads(request.data)
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    new_name = body.get("name")
    if new_name is None:
        return failure_response("Must enter new name.", 400)
    user.name = new_name
    db.session.commit()
    return success_response({"message": "You have successfully updated your name!"})

@app.route("/users/<int:user_id>/username/", methods=["POST"])
def update_username(user_id):
    """
    Endpoint for updating username
    Authentication: Verifies session token and returns confirmation message
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Session token invalid", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    body = json.loads(request.data)
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    new_username = body.get("username")
    if new_username is None:
        return failure_response("Must enter new username.", 400)
    user.username = new_username
    db.session.commit()
    return success_response({"message": "You have successfully updated your username!"})

# might need to change this
@app.route("/users/<int:user_id>/password/", methods=["POST"])
def update_password(user_id):
    """
    Endpoint for updating password
    Authentication: Verifies session token and returns confirmation message
    """
    success, session_token = extract_token(request)
    if not success:
        return failure_response("Session token invalid", 400)
    user = users_dao.get_user_by_session_token(session_token)
    if user is None or not user.verify_session_token(session_token):
        return failure_response("Invalid session token", 400)
    body = json.loads(request.data)
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    new_password = body.get("password")
    if new_password is None:
        return failure_response("Must enter new password.", 400)
    user.password_digest = bcrypt.hashpw(new_password.encode("utf8"), bcrypt.gensalt(rounds=13))
    db.session.commit()
    return success_response({"message": "You have successfully updated your password!"})

@app.route("/users/<int:user_id>/", methods=["DELETE"])
def delete_user(user_id):
    """
    Endpoint for deleting a user by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    db.session.delete(user)
    db.session.commit()
    return success_response(user.serialize())

@app.route("/users/<int:user_id>/bookclubs/", methods=["GET"])
def get_user_bookclubs(user_id):
    """
    Endpoint for getting a book club by id
    """
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    return success_response(user.bookclubs_serialize())

@app.route("/users/<int:user_id>/bookclubs/", methods=["POST"])
def user_create_bookclub(user_id):
    """
    Endpoint for creating a new book club
    """
    body = json.loads(request.data)
    new_bookclub = BookClub(name = body.get("name"))
    if new_bookclub.name is None: 
        return failure_response("Must enter book club name", 400)
    db.session.add(new_bookclub)
    db.session.commit()
    user = User.query.filter_by(id=user_id).first()
    if user is None:
        return failure_response("User not found!")
    new_bookclub.users.append(user)
    user.user_bookclubs.append(new_bookclub)
    db.session.commit()
    return success_response(new_bookclub.serialize())


# --BookClub Routes --
@app.route("/bookclubs/")
def get_bookclubs():
    """
    Endpoint for getting all book clubs
    """
    bookClubs = [bookclub.serialize() for bookclub in BookClub.query.all()]
    return success_response({"bookclubs": bookClubs})

@app.route("/bookclubs/", methods=["POST"])
def create_bookclub():
    """
    Endpoint for creating a new book club
    """
    body = json.loads(request.data)
    new_bookclub = BookClub(name = body.get("name"))
    if new_bookclub.name is None: 
        return failure_response("Must enter book club name", 400)
    db.session.add(new_bookclub)
    db.session.commit()
    return success_response(new_bookclub.serialize(), 201)

@app.route("/bookclubs/<int:bookclub_id>/")
def get_bookclub(bookclub_id):
    """
    Endpoint for getting a book club by id
    """
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/", methods=["DELETE"])
def delete_bookclub(bookclub_id):
    """
    Endpoint for deleting a book club by id
    """
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    db.session.delete(bookClub)
    db.session.commit()
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/name/", methods=["POST"])
def update_bookclub_name(bookclub_id):
    """
    Endpoint for updating a book club's name
    """
    body = json.loads(request.data)
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    new_name = body.get("name")
    if new_name is None:
        return failure_response("Must enter new name.", 400)
    bookClub.name = new_name
    db.session.commit()
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/users/add/", methods=["POST"])
def add_user_to_bookclub(bookclub_id):
    """
    Endpoint for adding a user to a book club
    """
    body = json.loads(request.data)
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    user = User.query.filter_by(id=(body.get("user_id"))).first()
    if user is None:
        return failure_response("User not found!")

    bookClub.users.append(user)
    user.user_bookclubs.append(bookClub)
    db.session.commit()
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/users/remove/", methods=["POST"])
def remove_user_from_bookclub(bookclub_id):
    """
    Endpoint for removing a user from a book club
    """
    body = json.loads(request.data)
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    user = User.query.filter_by(id=(body.get("user_id"))).first()
    if user is None:
        return failure_response("User not found!")
    bookClub.users.remove(user)
    db.session.commit()
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/users/", methods=["GET"])
def get_users_from_bookclub(bookclub_id):
    """
    Endpoint for getting the users from a book club
    """
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    return success_response(bookClub.users_serialize())

#-- Book Routes --
@app.route("/books/", methods=["POST"])
def create_book():
    """
    Endpoint for creating a new book club
    """
    body = json.loads(request.data)
    new_book = Book(title = body.get("title"),
    author = body.get("author"),
    publishedDate = body.get("publishedDate"),
    pageCount = body.get("pageCount"),
    smallThumbnail = body.get("smallThumbnail"),
    thumbnail = body.get("thumbnail"))

    if (new_book.title is None or new_book.author is None or
        new_book.publishedDate is None or new_book.pageCount is None or
        new_book.smallThumbnail is None or
        new_book.thumbnail is None): 
        return failure_response("Missing argument", 400)
    db.session.add(new_book)
    db.session.commit()
    return success_response(new_book.serialize(), 201)

@app.route("/bookclubs/<int:bookclub_id>/books/add/", methods=["POST"])
def add_book_to_bookclub(bookclub_id):
    """
    Endpoint for adding a book to a book club
    """
    body = json.loads(request.data)
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    book = Book.query.filter_by(id=(body.get("book_id"))).first()
    if book is None:
        return failure_response("Book not found!")

    bookClub.books.append(book)
    db.session.commit()
    return success_response(bookClub.serialize())

@app.route("/bookclubs/<int:bookclub_id>/books/", methods=["GET"])
def get_books(bookclub_id):
    """
    Endpoint for getting all books in a specific book club
    """
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    return success_response(bookClub.books_serialize())

@app.route("/bookclubs/<int:bookclub_id>/books/<int:book_id>/", methods=["DELETE"])
def delete_book_from_bookclub(bookclub_id, book_id):
    """
    Endpoint for deleting a book from a book club
    """
    bookClub = BookClub.query.filter_by(id=bookclub_id).first()
    if bookClub is None:
        return failure_response("Book club not found!")
    book = Book.query.filter_by(id=book_id).first()
    if book is None:
        return failure_response("Book not found!")
    bookClub.books.remove(book)
    db.session.commit()
    return success_response(bookClub.serialize())
    
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)