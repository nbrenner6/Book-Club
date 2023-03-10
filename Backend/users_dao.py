from db import db
from db import User
import app

def create_user(name, username, password):
    """
    Creates a User object in the database
    Returns if creation was successful, and the User object
    """
    optional_user = get_user_by_username(username)
    if optional_user is not None:
        return False, optional_user
    user = User(name=name, username=username, password=password)
    db.session.add(user)
    db.session.commit()

    return True, user

def get_user_by_username(username):
    """
    Returns a user object from the database given a username
    """
    return User.query.filter(User.username == username).first()


def get_user_by_session_token(session_token):
    """
    Returns a user object from the database given a session token
    """
    return User.query.filter(User.session_token == session_token).first()


def get_user_by_update_token(update_token):
    """
    Returns a user object from the database given an update token
    """
    return User.query.filter(User.update_token == update_token).first()


def verify_credentials(username, password):
    """
    Returns true if the credentials match, otherwise returns false
    """
    optional_user = get_user_by_username(username)
    if optional_user is None:
        return False, None
    return optional_user.verify_password(password), optional_user



def renew_session(update_token):
    """
    Renews a user's session token
    Returns the User object
    """
    optional_user = get_user_by_update_token(update_token)
    if optional_user is None:
        return False, None
    optional_user.renew_session()
    db.session.commit()
    return True, optional_user
