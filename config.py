import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    host = os.environ.get('MYSQL_HOST')
    
    if not host:
        raise ValueError("ERROR CRITICO: Render no esta entregando las variables de entorno al codigo.")
        
    SECRET_KEY = os.environ.get('SECRET_KEY', 'UnaCadenaSecretaMuySeguraParaElProyecto') 
    
    SQLALCHEMY_DATABASE_URI = (
        f"mysql+mysqlconnector://{os.environ.get('MYSQL_USER')}:{os.environ.get('MYSQL_PASSWORD')}"
        f"@{host}:{os.environ.get('MYSQL_PORT', '24339')}/{os.environ.get('MYSQL_DB')}?charset=utf8mb4"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False