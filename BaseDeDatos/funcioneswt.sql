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




