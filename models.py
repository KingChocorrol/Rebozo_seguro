from flask_login import UserMixin
from werkzeug.security import generate_password_hash, check_password_hash
from extensions import db

class User(UserMixin, db.Model):
    __tablename__ = 'usuarios' # Nombre real de la tabla en la DB
    id = db.Column(db.Integer, primary_key=True)
    nombre_usuario = db.Column(db.String(50), unique=True, nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)
    password_hash = db.Column(db.String(255), nullable=False) # Contraseña hasheada
    rol = db.Column(db.Enum('admin', 'editor', 'consultor'), nullable=False, default='consultor')
    activo = db.Column(db.Boolean, nullable=False, default=True)
    fecha_creacion = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    fecha_ultimo_login = db.Column(db.TIMESTAMP, nullable=True)


    tokens = db.relationship('TokenAcceso', backref='usuario', lazy='dynamic')
    actividades = db.relationship('RegistroActividad', backref='usuario', lazy='dynamic')
    drogas_creadas = db.relationship('Droga', foreign_keys='Droga.creado_por', backref='creador', lazy='dynamic')
    drogas_modificadas = db.relationship('Droga', foreign_keys='Droga.modificado_por', backref='modificador', lazy='dynamic')


    def set_password(self, password):
        self.password_hash = generate_password_hash(password) 

    def check_password(self, password):
        return check_password_hash(self.password_hash, password) 

    def __repr__(self):
        return f'<User {self.nombre_usuario}>'

# Modelo para la tabla 'tokens_acceso'
class TokenAcceso(db.Model):
    __tablename__ = 'tokens_acceso' # Nombre real de la tabla en la DB
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    token = db.Column(db.String(255), unique=True, nullable=False)
    tipo_token = db.Column(db.String(50), default='sesion')
    fecha_expiracion = db.Column(db.DateTime, nullable=True)
    fecha_creacion = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    dispositivo = db.Column(db.String(100), nullable=True) 
    ip = db.Column(db.String(45), nullable=True) 

    def __repr__(self):
        return f'<Token {self.token[:20]}... para user_id {self.usuario_id}>'

class RegistroActividad(db.Model):
    __tablename__ = 'registro_actividad' # Nombre real de la tabla en la DB
    id = db.Column(db.Integer, primary_key=True)
    usuario_id = db.Column(db.Integer, db.ForeignKey('usuarios.id'), nullable=False)
    registro_id = db.Column(db.Integer, nullable=True) 
    tipo_actividad = db.Column(db.String(100), nullable=False)
    tabla_afectada = db.Column(db.String(255), nullable=True) 
    detalles = db.Column(db.Text, nullable=True) 
    ip_address = db.Column(db.String(45), nullable=True)
    fecha_actividad = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())

    def __repr__(self):
        return f'<Actividad {self.tipo_actividad} por user_id {self.usuario_id}>'

class TipoDroga(db.Model):
    __tablename__ = 'tipos_drogas'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(50), nullable=False)
    descripcion = db.Column(db.Text)
    legal = db.Column(db.Boolean, default=False)
    fecha_creacion = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    drogas = db.relationship('Droga', backref='tipo_droga', lazy='dynamic')

    def __repr__(self):
        return f'<TipoDroga {self.nombre}>'

class Droga(db.Model):
    __tablename__ = 'drogas'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    tipo_id = db.Column(db.Integer, db.ForeignKey('tipos_drogas.id'), nullable=False)
    nombre_cientifico = db.Column(db.String(100))
    forma_consumo = db.Column(db.Enum('Oral','Inhalado','Inyectado','Fumado','Tópico','Otro'))
    riesgo_adiccion = db.Column(db.Enum('Bajo','Moderado','Alto','Muy alto'))
    descripcion = db.Column(db.Text)
    efectos_principales = db.Column(db.Text)
    fecha_creacion = db.Column(db.TIMESTAMP, default=db.func.current_timestamp())
    creado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) 
    modificado_por = db.Column(db.Integer, db.ForeignKey('usuarios.id')) 
    fecha_modificacion = db.Column(db.TIMESTAMP, onupdate=db.func.current_timestamp())

    efectos_relacionados = db.relationship(
        'DrogaEfecto',
        back_populates='droga',
        lazy='dynamic',
        cascade="all, delete-orphan" # Elimina los registros relacionados cuando se elimina la droga
    )
    riesgos_relacionados = db.relationship(
        'DrogaRiesgo',
        back_populates='droga',
        lazy='dynamic',
        cascade="all, delete-orphan" # Elimina los registros relacionados cuando se elimina la droga
    )
    tratamientos_relacionados = db.relationship(
        'DrogaTratamiento',
        back_populates='droga',
        lazy='dynamic',
        cascade="all, delete-orphan" # Elimina los registros relacionados cuando se elimina la droga
    )

    def __repr__(self):
        return f'<Droga {self.nombre}>'

class Efecto(db.Model):
    __tablename__ = 'efectos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    categoria = db.Column(db.Enum('Físico','Psicológico','Social','Comportamental'))
    descripcion = db.Column(db.Text)
    drogas = db.relationship('DrogaEfecto', back_populates='efecto', lazy='dynamic')

    def __repr__(self):
        return f'<Efecto {self.nombre}>'

class Riesgo(db.Model):
    __tablename__ = 'riesgos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    categoria = db.Column(db.Enum('Físico','Mental','Social','Legal','Económico'))
    descripcion = db.Column(db.Text)
    gravedad = db.Column(db.Enum('Baja','Media','Alta','Muy alta'))
    drogas = db.relationship('DrogaRiesgo', back_populates='riesgo', lazy='dynamic')

    def __repr__(self):
        return f'<Riesgo {self.nombre}>'

class Tratamiento(db.Model):
    __tablename__ = 'tratamientos'
    id = db.Column(db.Integer, primary_key=True)
    nombre = db.Column(db.String(100), nullable=False)
    tipo = db.Column(db.Enum('Farmacológico','Terapia','Grupo de apoyo','Internamiento','Otro'))
    descripcion = db.Column(db.Text)
    efectividad = db.Column(db.String(50))
    drogas = db.relationship('DrogaTratamiento', back_populates='tratamiento', lazy='dynamic')

    def __repr__(self):
        return f'<Tratamiento {self.nombre}>'

class DrogaEfecto(db.Model):
    __tablename__ = 'droga_efectos'
    droga_id = db.Column(db.Integer, db.ForeignKey('drogas.id'), primary_key=True)
    efecto_id = db.Column(db.Integer, db.ForeignKey('efectos.id'), primary_key=True)
    intensidad = db.Column(db.Enum('Leve','Moderado','Fuerte'))
    tiempo_inicio = db.Column(db.String(50))
    duracion = db.Column(db.String(50))

    droga = db.relationship('Droga', back_populates='efectos_relacionados')
    efecto = db.relationship('Efecto', back_populates='drogas')

class DrogaRiesgo(db.Model):
    __tablename__ = 'droga_riesgos'
    droga_id = db.Column(db.Integer, db.ForeignKey('drogas.id'), primary_key=True)
    riesgo_id = db.Column(db.Integer, db.ForeignKey('riesgos.id'), primary_key=True)
    probabilidad = db.Column(db.Enum('Baja','Media','Alta'))

    droga = db.relationship('Droga', back_populates='riesgos_relacionados')
    riesgo = db.relationship('Riesgo', back_populates='drogas')

class DrogaTratamiento(db.Model):
    __tablename__ = 'droga_tratamientos'
    droga_id = db.Column(db.Integer, db.ForeignKey('drogas.id'), primary_key=True)
    tratamiento_id = db.Column(db.Integer, db.ForeignKey('tratamientos.id'), primary_key=True)
    recomendado = db.Column(db.Boolean, default=True)

    droga = db.relationship('Droga', back_populates='tratamientos_relacionados')
    tratamiento = db.relationship('Tratamiento', back_populates='drogas')