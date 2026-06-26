import os

basedir = os.path.abspath(os.path.dirname(__file__))
dotenv_path = os.path.join(basedir, '.env')

env_vars = {}

try:
    with open(dotenv_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line and not line.startswith('#'):
                if '=' in line:
                    key, value = line.split('=', 1)
                    env_vars[key.strip()] = value.strip()
except FileNotFoundError:
    print(f"Advertencia: El archivo .env no se encontró en {dotenv_path}. Usando valores por defecto o variables de entorno del sistema.")
except Exception as e:
    print(f"Error al leer el archivo .env: {e}")

print("--- Depuración de .env (Carga Manual) ---")
print(f"MYSQL_HOST: {env_vars.get('MYSQL_HOST')}")
print(f"MYSQL_USER: {env_vars.get('MYSQL_USER')}")
print(f"MYSQL_PASSWORD: {env_vars.get('MYSQL_PASSWORD')}")
print(f"MYSQL_DB: {env_vars.get('MYSQL_DB')}")
print(f"SECRET_KEY: {env_vars.get('SECRET_KEY')}")
print("--- Fin de Depuración (Carga Manual) ---")

class Config:
    SECRET_KEY = env_vars.get('SECRET_KEY', 'UnaCadenaSecretaPorDefectoSiNoEstaEnEnv') 
    SQLALCHEMY_DATABASE_URI = (
        f"mysql+mysqlconnector://{env_vars.get('MYSQL_USER')}:{env_vars.get('MYSQL_PASSWORD')}"
        f"@{env_vars.get('MYSQL_HOST')}/{env_vars.get('MYSQL_DB')}?charset=utf8mb4"
    )
    SQLALCHEMY_TRACK_MODIFICATIONS = False