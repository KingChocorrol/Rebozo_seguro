from flask import Flask
from config import Config
from extensions import db, login_manager #Importación corregida

app = Flask(__name__)
app.config.from_object(Config)

db.init_app(app)
login_manager.init_app(app)
login_manager.login_view = 'login'

from models import User, TokenAcceso, RegistroActividad, Droga, TipoDroga, Efecto, Riesgo, Tratamiento, DrogaEfecto, DrogaRiesgo, DrogaTratamiento
from routes import *

@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
    app.run(debug=True)