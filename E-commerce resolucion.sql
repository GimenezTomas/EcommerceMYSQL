SET SQL_SAFE_UPDATES = 0;
SET foreign_key_checks = 0; 
/*Procedures*/
/*1*/
DELIMITER //
CREATE PROCEDURE buscarPublicacion(IN productoNombre VARCHAR(60))
BEGIN
	DECLARE productoID INT;
	DECLARE x INT;
	DECLARE categorias VARCHAR(200);
	DECLARE i VARCHAR(200);
	DECLARE cursor_ CURSOR FOR
	SELECT categoria.nombre FROM publicacion INNER JOIN producto ON publicacion.Producto_idProducto=producto.idProducto INNER JOIN publicacion_has_categoria ON publicacion.idPublicacion=publicacion_has_categoria.publicacion_idPublicacion INNER JOIN categoria ON publicacion_has_categoria.categoria_idCategoria=categoria.idCategoria  WHERE publicacion.Producto_idProducto=(select idProducto from producto where nombre=productoNombre) ORDER BY categoria.idCategoria;
	OPEN cursor_;
	SET productoID = (SELECT idProducto FROM Producto WHERE productoNombre=producto.nombre);
	SET x=(SELECT count(categoria.nombre) FROM publicacion INNER JOIN producto ON publicacion.Producto_idProducto=producto.idProducto INNER JOIN publicacion_has_categoria ON publicacion.idPublicacion=publicacion_has_categoria.publicacion_idPublicacion INNER JOIN categoria ON publicacion_has_categoria.categoria_idCategoria=categoria.idCategoria  WHERE publicacion.Producto_idProducto=productoID);
	SET categorias = '';
	SET i = '';
	IF(productoID is not null) THEN
		WHILE x>0 DO
			FETCH NEXT FROM cursor_ INTO i;
			IF(x !=1 ) THEN
				SET categorias=CONCAT(categorias,i,',');
			ELSE 
				SET categorias=CONCAT(categorias,i);
			END IF;
			SET x=x-1;
		END WHILE;
		CLOSE  cursor_;
		SELECT publicacion.idPublicacion, productoNombre, categorias, publicacion.precio FROM publicacion WHERE publicacion.Producto_idProducto=productoID;
	ELSE
		SELECT "El producto no se encuentra disponible";
	END IF;
END //
DELIMITER ;
CALL buscarPublicacion("Auriculares");

/*2*/
DELIMITER // 
CREATE PROCEDURE crearPublicacion(idUser int, venta varchar(45), price decimal, stk int, prodct int, fechaLmSub datetime)  
BEGIN  
	if exists(select * from usuario where idUsuario = idUser) then 
		if(venta = 'Subasta') then 
			INSERT INTO publicacion VALUES (null, now(), 'Activa','Bronce', venta, price, stk,fechaLmSub,prodct,null,idUser);  
		else
			INSERT INTO publicacion VALUES (null, now(), 'Activa','Bronce', venta, price, stk,null,prodct,null,idUser);
		end if;
	end if;
END //  
DELIMITER ; 
call crearPublicacion(5,'Venta Directa',1660,30,5,'2020-06-23');

/*3*/
DELIMITER // 
CREATE PROCEDURE verPreguntas(IN CODPublicacion INT) 
BEGIN 
     SELECT pregunta_respueta.* FROM pregunta_respueta INNER JOIN publicacion_has_pregunta_respueta ON pregunta_respueta.idPregunta_respueta=publicacion_has_pregunta_respueta.pregunta_respueta_idPregunta_respueta INNER JOIN publicacion ON publicacion_has_pregunta_respueta.publicacion_idPublicacion=publicacion.idPublicacion WHERE publicacion.idPublicacion=CODPublicacion; 
END // 
DELIMITER ; 
CALL verPreguntas(1);

/*Functions*/
/*1*/
DELIMITER // 
CREATE FUNCTION comprarProducto (id INT, publi INT, pago INT, envio int, cantidad int) 
RETURNS VARCHAR(200) 
DETERMINISTIC 
BEGIN 
	 IF NOT EXISTS(SELECT estado FROM publicacion WHERE idPublicacion= publi) THEN
		RETURN (select 'Esta publicacion no existe'); 
     ELSE IF (SELECT estado FROM publicacion WHERE idPublicacion=publi)  = 'Pausada'  THEN 
         RETURN (select 'Esta pausada la publicacion'); 
     ELSE IF (SELECT tipo_de_venta FROM publicacion  where idPublicacion = publi ) ='Subasta' then 
         RETURN (SELECT 'Es una subasta'); 
     ELSE IF (SELECT stock FROM publicacion where idPublicacion = publi) >= cantidad THEN 
         Insert into compra values (null,now(),0,0,publi,envio,pago,id); 
         UPDATE publicacion SET stock = stock - cantidad where idPublicacion = publi; 
         RETURN (SELECT 'Se ha realizado la compra'); 
	ELSE  
         RETURN (SELECT 'No hay stock suficiente'); 
END IF; 
END IF; 
end if; 
end if; 
END// 
DELIMITER ;
SELECT comprarProducto(1, 7, 1, 1, 1);

/*2*/
DELIMITER //  
	CREATE FUNCTION cerrarPublicacion(userr INT, publi INT)  
	RETURNS VARCHAR(200)  
	deterministic 
	BEGIN  
		IF EXISTS(SELECT * FROM publicacion inner join usuario on idUsuario = Usuario_idUsuario WHERE usuario_idUsuario=userr and idPublicacion = publi) THEN  
			IF EXISTS(SELECT * FROM pregunta_respueta INNER JOIN publicacion_has_pregunta_respueta ON pregunta_respueta.idPregunta_respueta=publicacion_has_pregunta_respueta.pregunta_respueta_idPregunta_respueta INNER JOIN publicacion ON publicacion_has_pregunta_respueta.publicacion_idPublicacion=publicacion.idPublicacion WHERE publicacion.idPublicacion=publi AND pregunta_respueta.Respuesta is not null) THEN  
				DELETE FROM publicacion WHERE idPublicacion = publi;   
				RETURN (SELECT 'La publicacion fue eliminada exitosamente');  
			ELSE  
				RETURN (SELECT 'Eliminacion fallida, hay consultas pendientes');  
			END IF;  
		ELSE   
			RETURN (SELECT 'Usuario incorrecto'); 
			end if; 
	END //  
DELIMITER ; 
SELECT cerrarPublicacion(3,2);

/*3*/
DELIMITER // 
	CREATE FUNCTION EliminarProducto (Producto INT) 
		RETURNS VARCHAR (100) 
		DETERMINISTIC  
	BEGIN 
		IF NOT EXISTS(SELECT * FROM producto INNER JOIN publicacion ON producto.idProducto=publicacion.Producto_idProducto WHERE producto.idProducto=Producto) then
			DELETE FROM producto WHERE idProducto=Producto; 
			RETURN (SELECT 'Se ha eliminado el producto');
		ELSE  
			RETURN (SELECT 'Hay publicaciones relacionadas');
		end if;
	END // 
DELIMITER ; 
SELECT EliminarProducto(11);

/*4*/
DELIMITER // 
CREATE FUNCTION pausarPublicacion(publi INT, idVendedor INT) 
RETURNS VARCHAR(100) 
READS SQL DATA 
BEGIN 
	IF EXISTS (SELECT * FROM publicacion WHERE idPublicacion=publi AND Usuario_idUsuario = idVendedor) THEN
		UPDATE publicacion SET estado = "Pausada" where idPublicacion=publi; 
		RETURN(SELECT "Publicacion pausada"); 
    ELSE IF EXISTS(SELECT * FROM publicacion WHERE idPublicacion=publi and Usuario_idUsuario != idVendedor ) THEN
			RETURN (SELECT "El usuario es incorrecto");
		ELSE 
			RETURN (SELECT "No existe la publicacion ");
		END IF;
	END IF;
END // 
DELIMITER ;
SELECT pausarPublicacion(3,4);

/*5*/ 
DELIMITER // 
    CREATE FUNCTION pujarProducto(idComprador INT, codPublicacion INT, ofertal DECIMAL)
    returns varchar(200)
    deterministic
    BEGIN  
		declare x decimal;
        if (select max(ofertas.precio_ofertado) from ofertas inner join subasta on ofertas.subasta_idsubasta=subasta.idsubasta inner join publicacion on subasta.idsubasta=publicacion.subasta_idsubasta where publicacion.idPublicacion=codPublicacion) is null then
        set x = 0;
        else
        set x = (select max(ofertas.precio_ofertado) from ofertas inner join subasta on ofertas.subasta_idsubasta=subasta.idsubasta inner join publicacion on subasta.idsubasta=publicacion.subasta_idsubasta where publicacion.idPublicacion=codPublicacion);
        end if;
        IF EXISTS(SELECT * FROM publicacion WHERE idPublicacion=codPublicacion AND estado="Activa" AND tipo_de_venta="Subasta") THEN 
            IF (x < ofertal) THEN 
                INSERT INTO ofertas VALUES (idComprador, (select subasta.idsubasta from subasta inner join publicacion on subasta.idsubasta=publicacion.subasta_idsubasta WHERE publicacion.idPublicacion=codPublicacion), ofertal, NOW()); 
                return(SELECT "La oferta se realizo con exito"); 
            ELSE 
                return(SELECT "La oferta es menor a la actual"); 
			END IF; 
        ELSE 
			return(SELECT "La publicacion no se encuentra disponible o no es una subasta"); 
        END IF; 
    END // 			
DELIMITER ;
SELECT pujarProducto(5,1,1501);

/*6*/
DELIMITER // 
CREATE FUNCTION eliminarCategoria(categoriaNum INT) 
RETURNS VARCHAR(200) 
DETERMINISTIC 
BEGIN 
     IF EXISTS(SELECT * FROM categoria inner join publicacion_has_categoria on categoria.idCategoria=publicacion_has_categoria.categoria_idCategoria inner join publicacion  on publicacion_has_categoria.publicacion_idPublicacion=publicacion.idPublicacion WHERE categoria.idCategoria=categoriaNum AND (publicacion.estado!="Finalizada" OR publicacion.estado is not null)) THEN 
         RETURN (SELECT 'No se puede, hay publicaciones activas en la categoria'); 
     ELSE 
         DELETE FROM categoria WHERE categoria.idCategoria = categoriaNum; 
         RETURN (SELECT 'Eliminacion exitosa'); 
     END IF; 
END// 
DELIMITER ; 
SELECT eliminarCategoria(11);

/*7*/
DELIMITER // 
CREATE FUNCTION puntuarComprador(puntaje int, codCompra INT, usuarioVendedor INT) 
RETURNS VARCHAR(60) 
DETERMINISTIC 
BEGIN 
     IF EXISTS (SELECT * FROM compra INNER JOIN publicacion ON compra.publicacion_idPublicacion=publicacion.idPublicacion WHERE compra.idcompra=codCompra AND publicacion.usuario_idUsuario=usuarioVendedor and puntaje <= 100) then 
         update compra set valoracion_comprador = puntaje  where compra.idcompra = codCompra; 
         RETURN(SELECT 'Puntuado'); 
     ELSE 
         RETURN(SELECT 'Error'); 
     end if; 
END // 
DELIMITER ;
select puntuarComprador(1,3,5);

/*8*/
DELIMITER // 
CREATE FUNCTION responderPregunta(idVendedor int, rsp varchar(200), preg int, publi int) 
RETURNS VARCHAR(200) 
DETERMINISTIC 
BEGIN 
	if exists(select * from publicacion where idPublicacion = publi and usuario_idUsuario = idVendedor ) then 
		if exists(select * from publicacion inner join publicacion_has_pregunta_respueta on idPublicacion = publicacion_idPublicacion inner join pregunta_respueta on pregunta_respueta_idPregunta_respueta = idPregunta_respueta where publicacion.usuario_idUsuario = idVendedor and pregunta_respueta.idPregunta_respueta = preg and pregunta_respueta.Respuesta is null) THEN 
			update pregunta_respueta set Respuesta = rsp where idPregunta_respueta = preg; 
            update pregunta_respueta set fecha_respuesta = now() where idPregunta_respueta = preg;
			return (select 'ok'); 
		else 
			return (select 'No existe pregunta o esta respuesta'); 
		end if; 
	else 
		return(select 'Solo el vendedor puede responder'); 
	End if; 
END // 
DELIMITER ; 
select responderPregunta(5,'hola rey',11,10);

/*Triggers*/
/*1*/
DELIMITER // 
CREATE TRIGGER before_publicacion_delete 
BEFORE DELETE ON publicacion 
FOR EACH ROW 
BEGIN 
	DECLARE x INT; 
	SET x = (old.idPublicacion); 
	DELETE pregunta_respueta.*, publicacion_has_pregunta_respueta.* FROM pregunta_respueta INNER JOIN publicacion_has_pregunta_respueta ON pregunta_respueta.idPregunta_respueta= publicacion_has_pregunta_respueta.pregunta_respueta_idPregunta_respueta WHERE publicacion_has_pregunta_respueta.publicacion_idPublicacion=x; 
END // 
DELIMITER ;

/*2*/
DELIMITER //
CREATE TRIGGER after_compra_update 
	AFTER UPDATE ON compra
	FOR EACH ROW
BEGIN 
	DECLARE usern INT;
	DECLARE reputacionComprador DECIMAL;
	DECLARE reputacionVendedor DECIMAL;
	IF EXISTS(select * from compra where idCompra = new.idCompra AND valoracion_vendedor != 0 AND valoracion_comprador != 0 ) THEN
		SET reputacionComprador= (SELECT AVG(valoracion_comprador) FROM compra where usuario_idUsuario=(select usuario_idUsuario from compra where idcompra=new.idcompra));
		UPDATE usuario SET reputacionUsuario = reputacionComprador WHERE idUsuario=new.usuario_idUsuario;
		SET usern = (SELECT publicacion.usuario_idUsuario FROM compra INNER JOIN publicacion ON compra.publicacion_idPublicacion = publicacion.idPublicacion where compra.idcompra=new.idcompra);
		SET reputacionVendedor = (SELECT AVG(valoracion_vendedor) FROM compra INNER JOIN publicacion ON compra.publicacion_idPublicacion = publicacion.idPublicacion where publicacion.usuario_idUsuario=usern);
		UPDATE usuario SET reputacionUsuario = reputacionVendedor WHERE idUsuario=usern;
	END IF;
END //
DELIMITER ;

/*3*/
DELIMITER //
CREATE TRIGGER after_compra_insert
after INSERT ON compra
FOR EACH ROW
BEGIN
declare j int;
declare x int;
set j = (select usuario_idUsuario from publicacion where idPublicacion=new.publicacion_idPublicacion);
update usuario set cantidad_ventas = cantidad_ventas + 1 where idUsuario = j;
set x = (select cantidad_ventas from usuario where idUsuario = j);
    if (x >= 1 and x <=5 )then
        update usuario set reputacion = 'Normal' where idUsuario = j;
    else if(x >= 6 and x <= 10) then
        update usuario set reputacion = 'Gold' where idUsuario = j;
    else
        update usuario set reputacion = 'Platinium' where idUsuario = j;
    end if;
    end if;
END //
DELIMITER ;

/*Function nuestra 1*/
DELIMITER // 
CREATE FUNCTION preguntar(userr int, prg varchar(200), publi int) 
RETURNS VARCHAR(200) 
DETERMINISTIC 
BEGIN 
	insert into pregunta_respueta values(null,prg,now(),null,null,userr);
    insert into publicacion_has_pregunta_respueta values(publi,(select max(idPregunta_respueta) from pregunta_respueta));
    return (select 'Pregunto correctamente');
END // 
DELIMITER ;
select preguntar(1,'hola???',10);

/*Function nuestra 2*/
DELIMITER // 
CREATE FUNCTION puntuarVendedor(puntaje int, codCompra INT, usuarioComprador INT) 
RETURNS VARCHAR(60) 
DETERMINISTIC 
BEGIN 
     IF EXISTS (SELECT * FROM compra INNER JOIN publicacion ON compra.publicacion_idPublicacion=publicacion.idPublicacion WHERE compra.idcompra=codCompra AND compra.usuario_idUsuario=usuarioComprador  and puntaje <= 100) then 
         update compra set valoracion_vendedor= puntaje  where compra.idcompra = codCompra; 
         RETURN(SELECT 'Puntuado'); 
     ELSE 
         RETURN(SELECT 'Error'); 
     end if; 
END // 
DELIMITER ;
select puntuarVendedor(1, 3, 1);

/*Procedure nuestro 1*/
DELIMITER // 
CREATE PROCEDURE creaUsuario(IN nameU VARCHAR(50), IN surname VARCHAR(50),IN email VARCHAR(100), IN contrasena VARCHAR(50),IN documento INT, IN dire VARCHAR(30),IN numTel INT, IN cod_post INT,IN prov VARCHAR(30)) 
BEGIN 
	IF EXISTS(SELECT * FROM usuario WHERE mail=email) THEN 
		SELECT "Ya existe una cuenta con ese mail"; 
	ELSE 
		INSERT INTO usuario VALUES (null, nameU, surname, email, contrasena,documento, dire, numTel, cod_post, prov, 0, null, null, null); 
		SELECT "La cuenta fue creada exitosamente"; 
	END IF; 
END // 
DELIMITER ; 
CALL creaUsuario('Martin','Barbieri','FDVWVFW@gmail.com','dstwig',00000010,'Triunvirato 159',1135240944,1439,'BOC');

/*Procedure nuestro 2*/
DELIMITER // 
CREATE PROCEDURE borrarUsuario(in email VARCHAR(100), IN contra VARCHAR(50)) 
BEGIN  
	if exists(select * from usuario where mail = email and contrasena = contra) THEN  
		DELETE FROM usuario WHERE mail = email and contrasena = contra; 
		select("La cuenta fue borrada"); 
	ELSE 
		select("Mail o contraseña invalidos"); 
	END IF; 
END // 
DELIMITER ; 
call borrarUsuario('FDVWVFW@gmail.com','dstwig');

/*Trigger nuestro 1*/
DELIMITER //
     CREATE TRIGGER before_publicacion_insert 
         BEFORE INSERT ON publicacion 
         FOR EACH ROW 
     BEGIN 
		DECLARE x VARCHAR(45);
        SET x = new.tipo_de_venta;
         IF ( x ="Subasta") THEN 
			 INSERT INTO subasta VALUES(null, new.fecha_limite_subasta); 
             SET new.subasta_idsubasta=(select max(idsubasta) from subasta); 
         END IF; 
     END // 
DELIMITER ;

/*Trigger nuestro 2*/
DELIMITER //
 CREATE TRIGGER before_producto_insert 
	 BEFORE INSERT ON producto 
	 FOR EACH ROW 
 BEGIN 
	DECLARE x VARCHAR(45);
	SET x = new.nombre;
	 IF exists(select * from producto where nombre= x) THEN 
		signal sqlstate '20300' set message_text ='No se pueden duplicar productos';
	 END IF;
 END // 
DELIMITER ;