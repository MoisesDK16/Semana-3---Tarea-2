--Estoy usando la bdd "jardineria" de la clase 

--Primero elimino la cardinalidad entre la tabla empleado y oficina 
ALTER TABLE jardineria.empleado DROP FOREIGN KEY EMPLEADO_X_OFICINA;

--Eliminar la relación foránea:
ALTER TABLE `empleado` DROP FOREIGN KEY `EMPLEADO_X_OFICINA`;

--Primero toca eliminar relacion Foranea con la tabla quye tiene relacion, en este caso hay una relacion foranea con la tabla empleado 
--Y por eso primero hay que eliminar la relacion foranea para que no surga un conflicto de relacion
ALTER TABLE `empleado` DROP INDEX `codigo_oficina`;

-- Ahora si puedo eliminar la clave primaria existente de la tabla oficina
ALTER TABLE `oficina`
    DROP PRIMARY KEY;

--Añado un nuevo campo que va a ser el campo autonumérico PK
ALTER TABLE `oficina`
    ADD COLUMN `id_oficina` INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

--Borro la columna codigo_oficina como clave primaria y se la mantengo como índice único si es necesario--
ALTER TABLE `oficina`
ADD UNIQUE (`codigo_oficina`);

--Ahora añado nuevamente la relacion Foranea de la tabla empleado con oficina que al principio habia eliminado
ALTER TABLE empleado
ADD CONSTRAINT `EMPLEADO_X_OFICINA`
FOREIGN KEY (`codigo_oficina`)
REFERENCES `oficina`(`codigo_oficina`);

--Ahora puedo hacer un inner join sin problemas, donde extraigo campos de ambas tablas--
SELECT of.id_oficina ,e.codigo_empleado, e.nombre, e.apellido1, of.codigo_oficina, of.ciudad, of.codigo_postal, of.telefono FROM empleado as e 
INNER JOIN oficina of ON e.codigo_oficina= of.codigo_oficina
ORDER BY of.id_oficina ASC
