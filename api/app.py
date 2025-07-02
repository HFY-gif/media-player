from extensions import app, db
from routes import *

if __name__ == '__main__':
    from models import User, PlayRecord
    with app.app_context():
        db.create_all()
    app.run(debug=True)