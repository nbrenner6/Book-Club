import datetime
import hashlib
import os
import bcrypt
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

# Association Tables
association_table1 = db.Table (
    # Many to Many
    "association1",
    db.Column("user_id", db.Integer, db.ForeignKey("user.id")),
    db.Column("bookclub_id", db.Integer, db.ForeignKey("bookclub.id"))
)

association_table2 = db.Table (
    # Many to Many
    "association2",
    db.Column("bookclub_id", db.Integer, db.ForeignKey("bookclub.id")),
    db.Column("book_id", db.Integer, db.ForeignKey("book.id"))
)

# -- User Class --
class User(db.Model):
    """
    User model
    many to many relationship with BookClub
    """
    __tablename__ = "user"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)

    # User information
    name = db.Column(db.String, nullable = False)
    username = db.Column(db.String, nullable = False)
    password_digest = db.Column(db.String, nullable = False)
    user_bookclubs = db.relationship("BookClub", secondary = association_table1, back_populates = "users")

    # Session information
    session_token = db.Column(db.String, nullable = False, unique = True)
    session_expiration = db.Column(db.DateTime, nullable = False)
    update_token = db.Column(db.String, nullable = False, unique = True)

    def __init__(self, **kwargs):
        """
        Creates User object
        """
        self.name = kwargs.get("name", "")
        self.username = kwargs.get("username", "")
        self.password_digest = bcrypt.hashpw(kwargs.get("password").encode("utf8"), bcrypt.gensalt(rounds=13))
        self.renew_session()

    def _urlsafe_base_64(self):
        """
        Randomly generates hashed tokens (used for session/update tokens)
        """
        return hashlib.sha1(os.urandom(64)).hexdigest()

    def renew_session(self):
        """
        Renews the sessions, i.e.
        1. Creates a new session token
        2. Sets the expiration time of the session to be a day from now
        3. Creates a new update token
        """
        self.session_token = self._urlsafe_base_64()
        self.session_expiration = datetime.datetime.now() + datetime.timedelta(days=1)
        self.update_token = self._urlsafe_base_64()

    def verify_password(self, password):
        """
        Verifies the password of a user
        """
        return bcrypt.checkpw(password.encode("utf8"), self.password_digest)

    def verify_session_token(self, session_token):
        """
        Verifies the session token of a user
        """
        return session_token == self.session_token and datetime.datetime.now() < self.session_expiration

    def verify_update_token(self, update_token):
        """
        Verifies the update token of a user
        """
        return update_token == self.update_token

    def pass_serialize(self):
        """
        Serializes a User object with password
        """
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
            "password": str(self.password_digest),
            "user_bookclubs": [bookclub.simple_serialize() for bookclub in self.user_bookclubs]
        }

    def serialize(self):
        """
        Serializes a User object
        """
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username,
            "user_bookclubs": [bookclub.simple_serialize() for bookclub in self.user_bookclubs]
        }
    
    def simple_serialize(self):
        """
        Simple serializes a User object
        """
        return {
            "id": self.id,
            "name": self.name,
            "username": self.username
        }

    def bookclubs_serialize(self):
        """
        Serializes a BookClub object with its books
        """
        return {
            "user_bookclubs": [bookclub.serialize() for bookclub in self.user_bookclubs]
        }

# -- Book Club Class --
class BookClub(db.Model):
    """
    BookClub model
    many to many relationship with User
    """
    __tablename__ = "bookclub"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    name = db.Column(db.String, nullable = False)
    users = db.relationship("User", secondary = association_table1, back_populates = 'user_bookclubs')
    books = db.relationship("Book", secondary = association_table2, back_populates = 'book_bookclubs')

    def __init__(self, **kwargs):
        """
        Creates Book Club object
        """
        self.name = kwargs.get("name", "")

    def serialize(self):
        """
        Serializes a BookClub object
        """
        return {
            "id": self.id,
            "name": self.name,
            "users": [u.simple_serialize() for u in self.users],
            "books": [book.simple_serialize() for book in self.books]
        }
    
    def books_serialize(self):
        """
        Serializes a BookClub object with its books
        """
        return {
            "books": [book.serialize() for book in self.books]
        }

    def users_serialize(self):
        """
        Serializes a BookClub object with its users
        """
        return {
            "users": [u.serialize() for u in self.users]
        }

    def simple_serialize(self):
        """
        Simple serializes a BookClub object
        """
        return {
            "id": self.id,
            "name": self.name
        }

# -- Book Class --
class Book(db.Model):
    __tablename__ = "book"
    id = db.Column(db.Integer, primary_key = True, autoincrement = True)
    title = db.Column(db.String, nullable = False)
    author = db.Column(db.String, nullable = False)
    publishedDate = db.Column(db.String, nullable = False)
    pageCount = db.Column(db.Integer, nullable = False)
    textSnippet = db.Column(db.String, nullable = False)
    smallThumbnail = db.Column(db.String, nullable = False)
    thumbnail = db.Column(db.String, nullable = False)
    book_bookclubs = db.relationship("BookClub", secondary = association_table2, back_populates = 'books')

    def __init__(self, **kwargs):
        """
        Creates a Book object
        """
        self.title = kwargs.get("title", "")
        self.author = kwargs.get("author", "")
        self.publishedDate = kwargs.get("publishedDate", "")
        self.pageCount = kwargs.get("pageCount", "")
        self.textSnippet = kwargs.get("textSnippet", "")
        self.smallThumbnail = kwargs.get("smallThumbnail", "")
        self.thumbnail = kwargs.get("thumbnail", "")

    def serialize(self):
        """
        Serializes a Book object
        """
        return {
            "id": self.id,
            "title": self.title,
            "author": self.author,
            "publishedDate": self.publishedDate,
            "pageCount": self.pageCount,
            "textSnippet": self.textSnippet,
            "smallThumbnail": self.smallThumbnail,
            "thumbnail": self.thumbnail,
            "book_bookclubs": [bookclub.simple_serialize() for bookclub in self.book_bookclubs]
        }

    def simple_serialize(self):
        """
        Simple serializes a Book object
        """
        return {
            "id": self.id,
            "title": self.title,
            "author": self.author,
            "publishedDate": self.publishedDate,
            "pageCount": self.pageCount,
            "textSnippet": self.textSnippet,
            "smallThumbnail": self.smallThumbnail,
            "thumbnail": self.thumbnail
        }


