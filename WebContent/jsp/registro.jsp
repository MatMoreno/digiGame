

<!DOCTYPE html>
<%
	String baseJsp = (String) request.getAttribute("baseJsp");
	ArrayList<Genero> lista = (ArrayList<Genero>) request.getAttribute("arrayGenero");
%>
<%@page
	import="modelo.hibernate.Usuarios,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<html>
<head>
<title>Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Your description">
<meta name="keywords" content="Your keywords">
<meta name="author" content="Your name">
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
			<a style="cursor: pointer" onclick="openNav()">&#9776;</a> <a
				href="<%=baseJsp%>?action=irInicio">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Catálogo</a> <a
				href="<%=baseJsp%>?action=irLogin">Login</a> <a
				href="<%=baseJsp%>?action=irRegistro">Registrarse</a> <a
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

		<form id="form" action="<%=baseJsp%>?action=botonRegistro"
			method="POST" class="form-horizontal">
			<fieldset>

				<!-- Form Name -->
				<legend>
					<h2>Regístrate</h2>
				</legend>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Nombre</label>
					<div class="controls">
						<input id="nombreReg" name="nombreReg" type="text"
							pattern="[A-Za-z]{3,15}" title="Al menos 3 caracteres"
							placeholder="Nombre" class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Apellidos</label>
					<div class="controls">
						<input id="apellidosReg" name="apellidosReg" type="text"
							pattern="[A-Za-z ]{5,15}[A-Za-z]" title="Al menos 5 caracteres"
							placeholder="apellidos" class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Correo
						Electronico</label>
					<div class="controls">
						<input id="correoReg" name="correoReg" type="email"
							placeholder="placeholder" class="input-xlarge" required>

					</div>
				</div>

				<!-- Password input-->
				<div class="control-group">
					<label class="control-label" for="passReg">Contraseña</label>
					<div class="controls">
						<input id="passReg" name="passReg" pattern=".{6,}"
							title="6 o más caracteres" type="password"
							placeholder="placeholder" class="input-medium" required>

					</div>
				</div>

				<!-- Password input-->
				<!-- 				<div class="control-group"> -->
				<!-- 					<label class="control-label" for="contraseñaRegistro">Repita -->
				<!-- 						la Contraseña</label> -->
				<!-- 					<div class="controls"> -->
				<!-- 						<input id="passReg2" name="passReg2" type="password" -->
				<!-- 							placeholder="placeholder" class="input-medium" required/> -->

				<!-- 					</div> -->
				<!-- 				</div> -->

				<!-- Appended checkbox -->
				<div class="control-group">
					<label class="control-label" for="appendedcheckbox">Fecha
						de Nacimiento</label>
					<div class="controls">
						<div class="input-append">

							<input type="date" id="fechaReg" name="fechaReg" required>
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
				<%
					HttpSession sesion = request.getSession();
					String error = (String) sesion.getAttribute("errorReg");
					if (error == "1") {
				%>
				<p style="margin-left: 10%; color: red">Este correo electrónico	ya esta registrado en nuestra base de datos</p>
				<%
					}
					sesion.invalidate();
				%>
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
                      <input style="height: 30px;" type="text" class="form-control" placeholder="Search for...">
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
