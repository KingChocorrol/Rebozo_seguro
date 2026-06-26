from flask import render_template, request, redirect, url_for, flash
from flask_login import login_user, logout_user, login_required, current_user
from app import app
from extensions import db
from models import User, Droga, TipoDroga, Efecto, Riesgo, Tratamiento, DrogaEfecto, DrogaRiesgo, DrogaTratamiento, RegistroActividad, TokenAcceso
from datetime import datetime
from werkzeug.security import generate_password_hash
import functools

def role_required(roles):
    def decorator(f):
        @functools.wraps(f)
        @login_required
        def decorated_function(*args, **kwargs):
            if current_user.rol == 'admin':
                return f(*args, **kwargs)

            if isinstance(roles, list):
                if current_user.rol not in roles:
                    flash('No tienes permiso para acceder a esta página.', 'danger')
                    return redirect(url_for('index'))
            else:
                if current_user.rol != roles:
                    flash('No tienes permiso para acceder a esta página.', 'danger')
                    return redirect(url_for('index'))
            return f(*args, **kwargs)
        return decorated_function
    return decorator

@app.route('/')
def index():
    drogas = Droga.query.all()
    return render_template('index.html', drogas=drogas)

@app.route('/login', methods=['GET', 'POST'])
def login():
    if current_user.is_authenticated:
        return redirect(url_for('index'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = User.query.filter_by(nombre_usuario=username).first()
        if user and user.check_password(password):
            login_user(user)
            user.fecha_ultimo_login = datetime.now()
            db.session.commit()

            new_activity = RegistroActividad(
                usuario_id=user.id,
                tipo_actividad='Login',
                detalles=f'Usuario {user.nombre_usuario} ha iniciado sesión.',
                ip_address=request.remote_addr
            )
            db.session.add(new_activity)
            db.session.commit()

            flash('Inicio de sesión exitoso.', 'success')
            return redirect(url_for('index'))
        else:
            flash('Usuario o contraseña inválidos.', 'danger')
    return render_template('login.html')

@app.route('/logout')
@login_required
def logout():
    new_activity = RegistroActividad(
        usuario_id=current_user.id,
        tipo_actividad='Logout',
        detalles=f'Usuario {current_user.nombre_usuario} ha cerrado sesión.',
        ip_address=request.remote_addr
    )
    db.session.add(new_activity)
    db.session.commit()

    logout_user()
    flash('Has cerrado sesión.', 'info')
    return redirect(url_for('index'))

@app.route('/admin')
@role_required('admin')
def admin_dashboard():
    return render_template('admin.html', user=current_user)

@app.route('/editor')
@role_required('editor')
def editor_dashboard():
    return render_template('editor.html', user=current_user)

@app.route('/consultor')
@role_required('consultor')
def consultor_dashboard():
    return render_template('consultor.html', user=current_user)

@app.route('/add_test_user')
def add_test_user():
    with app.app_context():
        admin_user = User.query.filter_by(nombre_usuario='admin').first()
        if not admin_user:
            admin_user = User(nombre_usuario='admin', email='admin@example.com', rol='admin')
            admin_user.set_password('adminpass')
            db.session.add(admin_user)
            flash('Usuario "admin" creado.', 'success')
        else:
            flash('Usuario "admin" ya existe.', 'info')

        editor_user = User.query.filter_by(nombre_usuario='editor').first()
        if not editor_user:
            editor_user = User(nombre_usuario='editor', email='editor@example.com', rol='editor')
            editor_user.set_password('editorpass')
            db.session.add(editor_user)
            flash('Usuario "editor" creado.', 'success')
        else:
            flash('Usuario "editor" ya existe.', 'info')

        consultor_user = User.query.filter_by(nombre_usuario='consultor').first()
        if not consultor_user:
            consultor_user = User(nombre_usuario='consultor', email='consultor@example.com', rol='consultor')
            consultor_user.set_password('consultorpass')
            db.session.add(consultor_user)
            flash('Usuario "consultor" creado.', 'success')
        else:
            flash('Usuario "consultor" ya existe.', 'info')

        db.session.commit()
    return redirect(url_for('index'))

@app.route('/drogas/<int:droga_id>')
@login_required
def ver_droga(droga_id):
    droga = Droga.query.get_or_404(droga_id)
    return render_template('ver_droga.html', droga=droga)

@app.route('/drogas/editar/<int:droga_id>', methods=['GET', 'POST'])
@role_required(['admin', 'editor'])
def editar_droga(droga_id):
    droga = Droga.query.get_or_404(droga_id)
    if request.method == 'POST':
        droga.nombre = request.form['nombre']
        droga.descripcion = request.form['descripcion']
        
        
        droga.modificado_por = current_user.id

        db.session.commit()

        new_activity = RegistroActividad(
            usuario_id=current_user.id,
            tipo_actividad='Editar Droga',
            registro_id=droga.id,
            tabla_afectada='drogas',
            detalles=f'Usuario {current_user.nombre_usuario} editó la droga {droga.nombre} (ID: {droga.id}).',
            ip_address=request.remote_addr
        )
        db.session.add(new_activity)
        db.session.commit()

        flash('Droga actualizada exitosamente.', 'success')
        return redirect(url_for('index'))
    
    return render_template('editar_droga.html', droga=droga)

@app.route('/drogas/eliminar/<int:droga_id>', methods=['POST'])
@role_required('admin')
def eliminar_droga(droga_id):
    droga = Droga.query.get_or_404(droga_id)
    db.session.delete(droga)
    db.session.commit()

    new_activity = RegistroActividad(
        usuario_id=current_user.id,
        tipo_actividad='Eliminar Droga',
        registro_id=droga.id,
        tabla_afectada='drogas',
        detalles=f'Usuario {current_user.nombre_usuario} eliminó la droga {droga.nombre} (ID: {droga.id}).',
        ip_address=request.remote_addr
    )
    db.session.add(new_activity)
    db.session.commit()

    flash('Droga eliminada exitosamente.', 'success')
    return redirect(url_for('index'))

@app.route('/generate_token/<int:user_id>')
@role_required('admin')
def generate_token(user_id):
    user = User.query.get_or_404(user_id)
    import uuid
    new_token_value = str(uuid.uuid4())

    new_token = TokenAcceso(
        usuario_id=user.id,
        token=new_token_value,
        tipo_token='sesion',
        fecha_creacion=datetime.now(),
        dispositivo='Web',
        ip=request.remote_addr
    )
    db.session.add(new_token)
    db.session.commit()

    flash(f'Token generado para {user.nombre_usuario}: {new_token_value}', 'info')
    return redirect(url_for('admin_dashboard'))