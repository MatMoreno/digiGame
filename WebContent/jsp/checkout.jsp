

<!DOCTYPE html>
<%
	HttpSession sesion = request.getSession();
	String baseJsp = (String) request.getAttribute("baseJsp");
	HashMap<Integer, CarritoItem> carrito = (HashMap<Integer, CarritoItem>) sesion.getAttribute("carrito");
	int carritoSize = 0;
	carritoSize=carrito.size();
%>
<%@page
	import="java.util.HashMap,modelo.hibernate.Usuarios,modelo.control.CarritoItem, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<html>
<head>
<title>Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Your description">
<meta name="keywords" content="Your keywords">
<meta name="author" content="Your name">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css"
	media="screen">
	<link rel="stylesheet" href="boot/css/bootstrap.css" type="text/css"
	media="screen">
<link rel="stylesheet" href="boot/css/style.css" type="text/css"
	media="screen">
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/estilos.css">
<script src="js/jquery-3.2.1.min.js"></script>
<script src="js/jquery.validate.js"></script>

<script src="js/jquery.validate.min.js"></script>

</head>

<body id="fondo">
	<!--==============================header=================================-->

	<header class="p0">
		<div style="padding-left: 16px">
			<h2>DIGITALGAME e-SHOP</h2>
		</div>
		<div class="topnav" id="myTopnav">
			<a href="<%=baseJsp%>?action=irInicioLog">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Catálogo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a href="<%=baseJsp%>?action=irCarrito">Carrito(<%=carritoSize%>)</a>
				<a href="<%=baseJsp%>?action=irMisCompras">Mis Compras</a>
				 <a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a> <a
				href="javascript:void(0);" style="font-size: 15px;" class="icon"
				onclick="myFunction()">&#9776;</a>
		</div>
	</header>

	<script>
		function myFunction() {
			var x = document.getElementById("myTopnav");
			if (x.className === "topnav") {
				x.className += " responsive";
				document.getElementById("mySidenav").style.marginTop = "400px";
			} else {
				document.getElementById("mySidenav").style.marginTop = "143px";
				x.className = "topnav";
			}
		}
	</script>

	<div
		style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; height: 600px">

		<form id="form" action="<%=baseJsp%>?action=botonCheckout"
			method="POST" class="form-horizontal">
			<fieldset>

				<!-- Form Name -->
				<legend>
					<h2>Datos para realizar pedido</h2>
				</legend>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Nombre del receptor</label>
					<div class="controls">
						<input id="nombreCheck" name="nombreCheck" type="text"
							pattern="[A-Za-z ]{5,25}[A-Za-z]" title="Al menos dos palabras"
							placeholder="Ej: Pepe Moreno Perez" class="input-xlarge" required>

					</div>
				</div>


				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Correo
						Electrónico al que se enviara la clave del juego</label>
					<div class="controls">
						<input id="correoCheck" name="correoCheck" type="email"
							placeholder="Ej:Digital@gmail.com" class="input-xlarge" required>

					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="textinput">País</label>
					<div class="controls">
						<input id="pais" name="paisCheck" type="text"
							pattern="[A-Za-zñ]{3,30}" title="Al menos 3 caracteres"
							placeholder="Ej:España" class="input-xlarge" required>

					</div>
				</div>



				<div class="control-group">
					<label class="control-label" for="textinput">Tipo de
						tarjeta de crédito</label>
					<div class="controls">
						<select name="tipoTarjeta">
							<option>Visa</option>
							<option>MasterCard</option>
						</select>

					</div>
				</div>
				<!-- Password input-->
				<div class="control-group">
					<label class="control-label">Numero de la Tarjeta de
						Crédito</label>
					<div class="controls">
						<input name="numeroTarjeta" placeholder="XXXX XXXX XXXX XXXX"
							type="text" pattern="[0-9]{16}" class="input-medium" required>

					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="appendedcheckbox">Fecha
						cad. Tarjeta</label>
					<div class="controls">
						<div class="input-append">

							<input type="text" title="Debe seguir el modelo xx/xx"
								id="fechaCad" name="fechaCad" pattern="[0-9]{2}/[0-9]{2}"
								placeholder="Ej: 05/18" required>
						</div>

					</div>
				</div>


				<!-- Button -->
				<div class="control-group">
					<div class="controls">
						<input type="submit" id="btn" name="singlebutton"
							class="btn btn-success"></input>
					</div>
				</div>
		
			</fieldset>
		</form>
	</div>
	<div class="container">
    <section style="height:80px;"></section>
    <!----------- Footer ------------>
    <footer class="footer-bs">
        <div class="row">
        	<div class="col-md-3 footer-brand animated fadeInLeft">
            	<h2 style="color: white">DG e-shop</h2>
                
                <p>  2017 Mat Moreno.  All rights reserved</p>
            </div>
        	<div class="col-md-4 footer-nav animated fadeInUp">
            	<h4>Menu </h4>
            	
            	<div class="col-md-6">
                    <ul class="list">
                        <li><a href="#">sobre nosotros</a></li>
                        <li><a href="#">Contacto</a></li>
                        <li><a href="#">Terminos y condiciones</a></li>
                        <li><a href="#">Política de privacidad</a></li>
                    </ul>
                </div>
            </div>
        	<div class="col-md-2 footer-social animated fadeInDown">
            	<h4 style="color: white">Siguenos</h4>
            	<ul>
                	<li><a href="#">Facebook</a></li>
                	<li><a href="#">Twitter</a></li>
                	<li><a href="#">Instagram</a></li>
                	<li><a href="#">RSS</a></li>
                </ul>
            </div>
        	<div class="col-md-3 footer-ns animated fadeInRight">
            	<h4 style="color: white">Noticias</h4>
                <p>Semana de descuentos en todos los articulos</p>
                <p>
                    <div class="input-group">
                      <input style="height: 34px;" type="text" class="form-control" placeholder="Search for...">
                      <span class="input-group-btn">
                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-envelope"></span></button>
                      </span>
                    </div><!-- /input-group -->
                 </p>
            </div>
        </div>
    </footer>

</div>
</body>
</html>
