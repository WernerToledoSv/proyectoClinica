--CRUD para el proveedor

--crear
CREATE OR REPLACE FUNCTION func_proveedor_insert(
    p_nombres VARCHAR,
    p_apellidos VARCHAR,
    p_cel VARCHAR,
    p_email VARCHAR,
    p_nombreempresa VARCHAR
) RETURNS proveedor AS $$  -- Cambia el tipo de retorno a 'proveedor'
DECLARE
    nuevo_proveedor proveedor; -- Variable para almacenar el nuevo proveedor
BEGIN
    -- Insertar el nuevo proveedor y obtener todos los datos
    INSERT INTO proveedor (nombres, apellidos, cel, email, nombreempresa)
    VALUES (p_nombres, p_apellidos, p_cel, p_email, p_nombreempresa)
    RETURNING * INTO nuevo_proveedor; -- Obtener todos los datos del nuevo proveedor

    RETURN nuevo_proveedor; -- Devolver el nuevo proveedor
END;
$$ LANGUAGE plpgsql;

--para probar
--SELECT func_proveedor_insert('Juan', 'Pérez', '123456789', 'juan@example.com', 'Empresa XYZ');

--Actualizar
CREATE OR REPLACE FUNCTION func_proveedor_update(
    p_id INT,
    p_nombres VARCHAR,
    p_apellidos VARCHAR,
    p_cel VARCHAR,
    p_email VARCHAR,
    p_nombreempresa VARCHAR
) RETURNS proveedor AS $$ -- Retorna un registro de la tabla proveedor
DECLARE
    proveedor_actualizado proveedor; -- Variable para almacenar el proveedor actualizado
BEGIN
    -- Actualizar el proveedor existente
    UPDATE proveedor
    SET 
        nombres = p_nombres,
        apellidos = p_apellidos,
        cel = p_cel,
        email = p_email,
        nombreempresa = p_nombreempresa
    WHERE id = p_id
    RETURNING * INTO proveedor_actualizado; -- Obtener todos los datos del proveedor actualizado

    RETURN proveedor_actualizado; -- Devolver el proveedor actualizado
END;
$$ LANGUAGE plpgsql;

--para probar
--SELECT func_proveedor_update(1, 'Juan @', 'Pérez', '987654321', 'juan_nuevo@example.com', 'Nueva Empresa XYZ');

--Eliminar proveedor
CREATE OR REPLACE FUNCTION func_proveedor_delete(
    p_id INT
) RETURNS proveedor AS $$ -- Retorna un registro de la tabla proveedor
DECLARE
    proveedor_eliminado proveedor; -- Variable para almacenar el proveedor actualizado
BEGIN
    -- Actualizar el estado del proveedor a 'no disponible'
    UPDATE proveedor
    SET estado = 'no disponible'
    WHERE id = p_id
    RETURNING * INTO proveedor_eliminado; -- Obtener todos los datos del proveedor actualizado

    RETURN proveedor_eliminado; -- Devolver el proveedor con el estado actualizado
END;
$$ LANGUAGE plpgsql;

--para probar
--select func_proveedor_delete(1);

--cambiar el estado a disponible
CREATE OR REPLACE FUNCTION func_proveedor_activar(
    p_id INT
) RETURNS proveedor AS $$ -- Retorna un registro de la tabla proveedor
DECLARE
    proveedor_actualizado proveedor; -- Variable para almacenar el proveedor actualizado
BEGIN
    -- Actualizar el estado del proveedor a 'no disponible'
    UPDATE proveedor
    SET estado = 'disponible'
    WHERE id = p_id
    RETURNING * INTO proveedor_actualizado; -- Obtener todos los datos del proveedor actualizado

    RETURN proveedor_actualizado; -- Devolver el proveedor con el estado actualizado
END;
$$ LANGUAGE plpgsql;
 

--para probar
--select func_proveedor_activar(1);

--para mostrar los proveedores
CREATE OR REPLACE FUNCTION func_proveedor_read()
RETURNS SETOF proveedor AS $$ -- Retorna un conjunto de registros de la tabla proveedor
BEGIN
    RETURN QUERY SELECT * FROM proveedor;
END;
$$ LANGUAGE plpgsql;

--para probar
--select func_proveedor_read();


--buscar por id
CREATE OR REPLACE FUNCTION func_proveedor_buscarid(
	p_id INT
)
RETURNS SETOF proveedor AS $$ -- Retorna un conjunto de registros de la tabla proveedor
BEGIN
    RETURN QUERY SELECT * FROM proveedor where id = p_id;
END;
$$ LANGUAGE plpgsql;

--para probar
--select func_proveedor_buscarid(1);

--buscar por nombre
create or replace function func_proveedor_buscarnombre(
	p_nombre VARCHAR
)
returns setof proveedor as $$
begin 
	--se unen los nombres y apellidos para buscar por nombre completo sin espacion
	--se le quitan los espacion al parametro con TRIM().
	return QUERY select * from proveedor where (nombres || apellidos) ILIKE '%'||TRIM(p_nombre)||'%';
end;
$$LANGUAGE plpgsql;

--para probar
--select func_proveedor_buscarnombre('p');
--CRUD para el proveedor




--Tabla medicamento

--CRUD para medicamento

--funcion para crear
CREATE OR REPLACE FUNCTION func_medicamento_insert(
    p_id_tipomedida INT,
    p_nombre VARCHAR,
    p_descripcion TEXT,
    p_laboratorio VARCHAR,  -- Se eliminó 'not null' de la declaración
    p_cantidad INT
) RETURNS medicamento AS $$ 

DECLARE
    nuevo_medicamento medicamento;  -- Declarar una variable para almacenar el nuevo medicamento
BEGIN
    INSERT INTO medicamento (idtipomedida, nombre, descripcion, laboratorio, cantidad) 
    VALUES (p_id_tipomedida, p_nombre, p_descripcion, p_laboratorio, p_cantidad)
    RETURNING * INTO nuevo_medicamento;  -- Almacenar el nuevo medicamento en la variable

    RETURN nuevo_medicamento;  -- Devolver el nuevo medicamento
END;
$$ LANGUAGE plpgsql;

--para probar
--select func_medicamento_insert(1, 'Aspirina', 'Antiinflamatorio', 'Laboratorio DEF', 30);


--funcion para actualizar
CREATE OR REPLACE FUNCTION func_medicamento_update(
    p_id INT,
    p_id_tipomedida INT,
    p_nombre VARCHAR,
    p_descripcion TEXT,
    p_laboratorio VARCHAR,
    p_cantidad INT
) RETURNS medicamento AS $$ 

DECLARE
    actualizado_medicamento medicamento;  -- Variable para almacenar el medicamento actualizado
BEGIN
    UPDATE medicamento 
    SET 
        idtipomedida = p_id_tipomedida,
        nombre = p_nombre,
        descripcion = p_descripcion,
        laboratorio = p_laboratorio,
        cantidad = p_cantidad
    WHERE id = p_id
    RETURNING * INTO actualizado_medicamento;  -- Almacenar el medicamento actualizado en la variable

    RETURN actualizado_medicamento;  -- Devolver el medicamento actualizado
END;
$$ LANGUAGE plpgsql;

--pruebas
--SELECT * FROM func_medicamento_update(2, 1, 'Aspirina 404', 'Antiinflamatorio mejorado', 'Laboratorio DEF', 250);

--para actualizar el estado a no disponible
CREATE OR REPLACE FUNCTION func_medicamento_delete(
    p_id INT
) RETURNS medicamento AS $$ 

DECLARE
    medicamento_actualizado medicamento;  -- Variable para almacenar el medicamento actualizado
BEGIN
    UPDATE medicamento 
    SET estado = 'no disponible'  -- Cambiar el estado a 'no disponible'
    WHERE id = p_id
    RETURNING * INTO medicamento_actualizado;  -- Almacenar el registro actualizado

    RETURN medicamento_actualizado;  -- Devolver el medicamento actualizado
END;
$$ LANGUAGE plpgsql;



SELECT func_medicamento_delete(2);  -- Cambia el estado del medicamento con id 1

--activar el medicamento
CREATE OR REPLACE FUNCTION func_medicamento_activar(
    p_id INT
) RETURNS medicamento AS $$ 

DECLARE
    medicamento_actualizado medicamento;  -- Variable para almacenar el medicamento actualizado
BEGIN
    UPDATE medicamento 
    SET estado = 'disponible'  -- Cambiar el estado a 'disponible'
    WHERE id = p_id
    RETURNING * INTO medicamento_actualizado;  -- Almacenar el registro actualizado

    RETURN medicamento_actualizado;  -- Devolver el medicamento actualizado
END;
$$ LANGUAGE plpgsql;

--probar
--SELECT func_medicamento_activar(2);  -- Cambia el estado del medicamento con id 1 y retorna el registro

--buscar por id 
CREATE OR REPLACE FUNCTION func_medicamento_buscarid(
    p_id INT
) RETURNS medicamento AS $$ 

DECLARE
    medicamento_encontrado medicamento;  -- Variable para almacenar el medicamento encontrado
BEGIN
    SELECT * INTO medicamento_encontrado 
    FROM medicamento 
    WHERE id = p_id;

    RETURN medicamento_encontrado;  -- Devolver el medicamento encontrado
END;
$$ LANGUAGE plpgsql;

--probar
--SELECT * FROM func_medicamento_buscarid(2);  -- Busca el medicamento con id 1

--buscar por nombre
CREATE OR REPLACE FUNCTION func_medicamento_buscarnombre(
    p_nombre VARCHAR
) RETURNS SETOF medicamento AS $$ 

BEGIN
    RETURN QUERY 
    SELECT * 
    FROM medicamento 
    WHERE nombre ILIKE '%' || p_nombre || '%';  -- ILIKE para búsqueda insensible a mayúsculas/minúsculas
END;
$$ LANGUAGE plpgsql;

--probar
--select func_medicamento_buscarnombre('Asp');






--CRUD para medicamento
-- Carlos_Rodriguez_TablaUsers --
--Funcion Agregar usuario--
CREATE OR REPLACE FUNCTION func_usuario_insert (
    p_idrol INT,
    p_idlugar INT,
    p_username VARCHAR,
    p_password TEXT,
    p_nombres VARCHAR,
    p_apellidos VARCHAR,
    p_sexo ty_sexo,
    p_cel VARCHAR,
    p_email VARCHAR,
    p_fechaingreso DATE
) RETURNS usuario AS $$
DECLARE 
    nuevo_usuario usuario;
BEGIN
    INSERT INTO usuario (idrol, idlugar, username, password, nombres, apellidos, sexo, cel, email, fechaingreso)
    VALUES (p_idrol, p_idlugar, p_username, p_password, p_nombres, p_apellidos, p_sexo, p_cel, p_email, p_fechaingreso)
    RETURNING * INTO nuevo_usuario;
    
    RETURN nuevo_usuario;
END;
$$ LANGUAGE plpgsql;
--Funcion agregar usuario--

--Funcion leer todos los usuarios--
CREATE OR REPLACE FUNCTION func_leer_todos_usuarios()
RETURNS SETOF usuario AS $$
BEGIN
    RETURN QUERY
    SELECT * FROM usuario;
END;
$$ LANGUAGE plpgsql;

-- prueba --
-- SELECT * FROM func_leer_todos_usuarios();--

--funcion leer usuario por ID--

CREATE OR REPLACE FUNCTION func_leer_usuario_por_id(p_id INT)
RETURNS usuario AS $$
DECLARE
    usuario_encontrado usuario;
BEGIN
    SELECT *
    INTO usuario_encontrado
    FROM usuario
    WHERE id = p_id;

    RETURN usuario_encontrado;
END;
$$ LANGUAGE plpgsql;

-- prueba--
-- SELECT * FROM func_leer_usuario_por_id(1); --

--Funcion Actualizar usuario--
CREATE OR REPLACE FUNCTION func_actualizar_usuario(
    p_id INT,
    p_idrol INT,
    p_idlugar INT,
    p_username VARCHAR,
    p_password TEXT,
    p_nombres VARCHAR,
    p_apellidos VARCHAR,
    p_sexo ty_sexo,
    p_cel VARCHAR,
    p_email VARCHAR,
    p_fechaingreso DATE,
    p_estado est_users
) RETURNS usuario AS $$
DECLARE
    usuario_actualizado usuario;
BEGIN
    UPDATE usuario
    SET idrol = p_idrol,
        idlugar = p_idlugar,
        username = p_username,
        password = p_password,
        nombres = p_nombres,
        apellidos = p_apellidos,
        sexo = p_sexo,
        cel = p_cel,
        email = p_email,
        fechaingreso = p_fechaingreso,
        estado = p_estado
    WHERE id = p_id
    RETURNING * INTO usuario_actualizado;

    RETURN usuario_actualizado;
END;
$$ LANGUAGE plpgsql;
-- prueba -- 
/* SELECT * FROM func_actualizar_usuario(
    1, -- ID del usuario
    2, -- Nuevo idrol
    3, -- Nuevo idlugar
    'new_username', -- Nuevo username
    'new_password', -- Nueva password
    'Nuevo Nombre', -- Nuevos nombres
    'Nuevo Apellido', -- Nuevos apellidos
    'M', -- Nuevo sexo
    '123456789', -- Nuevo número de celular
    'nuevoemail@example.com', -- Nuevo email
    '2024-01-01', -- Nueva fecha de ingreso
    'activo' -- Nuevo estado
); */

-- Funcion Elimimnar usuario --
CREATE OR REPLACE FUNCTION func_eliminar_usuario(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM usuario
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
-- prueba --
-- SELECT func_eliminar_usuario(1); --

-- Funcion buscar usuario por nombre--
CREATE OR REPLACE FUNCTION func_buscar_usuario_por_nombres(p_nombres VARCHAR)
RETURNS SETOF usuario AS $$
BEGIN
    RETURN QUERY
    SELECT *
    FROM usuario
    WHERE nombres ILIKE '%' || p_nombres || '%';
END;
$$ LANGUAGE plpgsql;
-- prueba --
-- SELECT * FROM func_buscar_usuario_por_nombres('Juan'); --
-- Carlos_Rodriguez_TablaUsers --



--Carlos_Rodriguez_TablaRol--
--Funcion agregar rol--
CREATE OR REPLACE FUNCTION crear_rol(p_nombre VARCHAR, p_descripcion TEXT)
RETURNS VOID AS $$
BEGIN
    INSERT INTO rol (nombre, descripcion)
    VALUES (p_nombre, p_descripcion);
END;
$$ LANGUAGE plpgsql;
--prueba--
--SELECT crear_rol('Admin', 'Administrador del sistema');--

--funcion leer rol--
CREATE OR REPLACE FUNCTION leer_rol_por_id(p_id INT)
RETURNS TABLE(id INT, nombre VARCHAR, descripcion TEXT) AS $$
BEGIN
    RETURN QUERY 
    SELECT rol.id, rol.nombre, rol.descripcion
    FROM rol
    WHERE rol.id = p_id;
END;
$$ LANGUAGE plpgsql;
--prueba--
--SELECT * FROM leer_rol_por_id(1);--


--funcion leer todos los roles--
CREATE OR REPLACE FUNCTION leer_todos_roles()
RETURNS TABLE(id INT, nombre VARCHAR, descripcion TEXT) AS $$
BEGIN
    RETURN QUERY 
    SELECT rol.id, rol.nombre, rol.descripcion
    FROM rol;
END;
$$ LANGUAGE plpgsql;
--prubea--
--SELECT * FROM leer_todos_roles();--

--funcion actualizar rol--
CREATE OR REPLACE FUNCTION actualizar_rol(p_id INT, p_nombre VARCHAR, p_descripcion TEXT)
RETURNS VOID AS $$
BEGIN
    UPDATE rol
    SET nombre = p_nombre,
        descripcion = p_descripcion
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;

--prueba--
--SELECT actualizar_rol(1, 'Super Admin', 'Administrador Principal del Sistema');--

--funcion eliminar rol--
CREATE OR REPLACE FUNCTION eliminar_rol(p_id INT)
RETURNS VOID AS $$
BEGIN
    DELETE FROM rol
    WHERE id = p_id;
END;
$$ LANGUAGE plpgsql;
--prueba--
--SELECT eliminar_rol(1);--

--funcion buscar rol por nombre--
CREATE OR REPLACE FUNCTION buscar_rol_por_nombre(p_nombre VARCHAR)
RETURNS TABLE(id INT, nombre VARCHAR, descripcion TEXT) AS $$
BEGIN
    RETURN QUERY 
    SELECT rol.id, rol.nombre, rol.descripcion
    FROM rol
    WHERE rol.nombre ILIKE '%' || p_nombre || '%';
END;
$$ LANGUAGE plpgsql;

--prueba--
--SELECT * FROM buscar_rol_por_nombre('Admin');--
--Carlos Rodriguez tabla rol--








