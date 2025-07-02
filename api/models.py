from extensions import db

class User(db.Model):
    __tablename__ = 'users'
    user_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    username = db.Column(db.String(50), unique=True, nullable=False)
    password = db.Column(db.String(100), nullable=False)
    created_at = db.Column(db.DateTime, server_default=db.func.now())

class PlayRecord(db.Model):
    __tablename__ = 'play_records'
    record_id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id', ondelete='CASCADE'), nullable=False)
    media_type = db.Column(db.Enum('video', 'audio'), nullable=False)
    media_id = db.Column(db.String(100), nullable=False)
    media_title = db.Column(db.String(255))
    media_url = db.Column(db.String(500))
    played_at = db.Column(db.DateTime, server_default=db.func.now())
    duration = db.Column(db.Integer)

    user = db.relationship('User', backref=db.backref('play_records', lazy=True))
