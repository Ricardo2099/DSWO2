INSERT INTO departamentos (clave, nombre)
VALUES
    ('RH', 'Recursos Humanos'),
    ('TI', 'Tecnologia de Informacion'),
    ('FIN', 'Finanzas'),
    ('OPE', 'Operaciones'),
    ('MKT', 'Marketing')
ON CONFLICT (clave) DO UPDATE
SET nombre = EXCLUDED.nombre;

INSERT INTO empleados (
    prefijo_clave,
    numero_clave,
    nombre,
    direccion,
    telefono,
    activo,
    email,
    password_hash,
    departamento_id
)
VALUES
    ('EMP-', 2001, 'Valeria Castillo', 'Av. Reforma 210', '555200101', TRUE, 'valeria.castillo@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'RH')),
    ('EMP-', 2002, 'Sergio Navarro', 'Av. Insurgentes 211', '555200102', TRUE, 'sergio.navarro@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'TI')),
    ('EMP-', 2003, 'Camila Ortega', 'Av. Universidad 212', '555200103', TRUE, 'camila.ortega@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'FIN')),
    ('EMP-', 2004, 'Adrian Silva', 'Av. Patriotismo 213', '555200104', TRUE, 'adrian.silva@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'OPE')),
    ('EMP-', 2005, 'Lucia Mendoza', 'Calle Cedro 214', '555200105', TRUE, 'lucia.mendoza@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'MKT')),
    ('EMP-', 2006, 'Mario Perez', 'Calle Nube 215', '555200106', TRUE, 'mario.perez@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'RH')),
    ('EMP-', 2007, 'Natalia Flores', 'Calle Lago 216', '555200107', TRUE, 'natalia.flores@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'TI')),
    ('EMP-', 2008, 'Hector Ramirez', 'Calle Mar 217', '555200108', TRUE, 'hector.ramirez@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'FIN')),
    ('EMP-', 2009, 'Paola Herrera', 'Calle Rio 218', '555200109', TRUE, 'paola.herrera@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'OPE')),
    ('EMP-', 2010, 'Diego Vargas', 'Calle Bosque 219', '555200110', TRUE, 'diego.vargas@example.com', NULL, (SELECT id FROM departamentos WHERE clave = 'MKT'))
ON CONFLICT (email) WHERE email IS NOT NULL DO UPDATE
SET
    nombre = EXCLUDED.nombre,
    direccion = EXCLUDED.direccion,
    telefono = EXCLUDED.telefono,
    activo = EXCLUDED.activo,
    departamento_id = EXCLUDED.departamento_id,
    updated_at = CURRENT_TIMESTAMP;

SELECT setval(
    'empleado_numero_clave_seq',
    (SELECT COALESCE(MAX(numero_clave), 1) FROM empleados),
    true
);
