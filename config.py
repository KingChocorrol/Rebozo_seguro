import os
from dotenv import load_dotenv

# Esto carga tu archivo .env cuando trabajas localmente en tu Mac.
# Cuando está en Render, simplemente lo ignora y toma las variables del panel.
load_dotenv()

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY', 'UnaCadenaSecretaMuySeguraParaElProyecto') 
    
    # Se utiliza os.environ.get() para leer desde el servidor de Render
    SQLALCHEMY_DATABASE_URI = (
        f"mysql+mysqlconnector://{os.environ.get('MYSQL_USER')}:{os.environ.get('MYSQL_PASSWORD')}"
        f"@{os.environ.get('MYSQL_HOST')}:{os.environ.get('MYSQL_PORT', '24339')}/{os.environ.get('MYSQL_DB')}?charset=utf8mb4"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False