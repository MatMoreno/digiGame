

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
<script
	src="https://cdn.jsdelivr.net/npm/jquery-validation@1.17.0/dist/jquery.validate.min.js"
	type="text/javascript"></script>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"
	type="text/javascript"></script>
<script src="js/main.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/jquery.ui.totop.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

</head>

<body id="fondo">
	<!--==============================header=================================-->

	<header class="p0">
		<div style="padding-left: 16px">
			<h2>DIGITALGAME e-SHOP</h2>
		</div>
		<div class="topnav" id="myTopnav">
			<a style="font-size: 30px; cursor: pointer" onclick="openNav()">&#9776;</a>
			<a href="<%=baseJsp%>?action=irInicio">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Juegos</a> <a href="<%=baseJsp%>?action=irLogin">Login</a>
			<a href="<%=baseJsp%>?action=irRegistro">Registrarse</a> <a
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
		style="background-color: white; margin: auto; width: 70%; height: 600px">
		<div id="mySidenav" class="sidenav">
			<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
			<p href="#">Generos</p>
			<legend></legend>
			<%
				for (int i = 0; i < lista.size(); i++) {
					out.print(" <a href=''> " + lista.get(i).getNombre() + "</a>");
				}
			%>
			<a href="#">Services</a>
		</div>
		<form id="form" style="background-color: white"	<%-- action="<%=baseJsp%>?action=botonRegistro" --%>
			action="javascript:void(0)"method="POST" class="form-horizontal">
			<fieldset>

				<!-- Form Name -->
				<legend>
					<h2>Regístrate</h2>
				</legend>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Nombre</label>
					<div class="controls">
						<input id="nombre" name="nombre" type="text"
							placeholder="placeholder" class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Apellidos</label>
					<div class="controls">
						<input id="apellidos" name="apellidos" type="text"
							placeholder="placeholder" class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Correo
						Electronico</label>
					<div class="controls">
						<input id="correo" name="correo" type="text"
							placeholder="placeholder" class="input-xlarge" required>

					</div>
				</div>

				<!-- Password input-->
				<div class="control-group">
					<label class="control-label" for="password">Contraseña</label>
					<div class="controls">
						<input id="password" name="password" type="password"
							placeholder="placeholder" class="input-medium" required>

					</div>
				</div>

				<!-- Password input-->
				<div class="control-group">
					<label class="control-label" for="contraseñaRegistro">Repita
						la Contraseña</label>
					<div class="controls">
						<input id="passwordRe" name="passwordRe" type="password"
							placeholder="placeholder" class="input-medium" required>

					</div>
				</div>

				<!-- Appended checkbox -->
				<div class="control-group">
					<label class="control-label" for="appendedcheckbox">Fecha
						de Nacimiento</label>
					<div class="controls">
						<div class="input-append">

							<input type="date" id="fechaNac" name="fechaNac" required>
						</div>

					</div>
				</div>


				<!-- Button -->
				<div class="control-group">
					<div class="controls">
						<button id="singlebutton" name="singlebutton"
							class="btn btn-success">Enviar</button>
					</div>
				</div>

			</fieldset>
		</form>
	</div>
	<script>
		var bool = true;
		function openNav() {
			if (bool == true) {
				document.getElementById("mySidenav").style.width = "15%";
				bool = false;
			} else {
				bool = true;
				closeNav();
			}
		}

		function closeNav() {
			document.getElementById("mySidenav").style.width = "0";
		}
	</script>
	<script>
		$(function() {
			$("#form").datepicker({
				changeMonth : true,
				changeYear : true
			});
		});
	</script>
	<!-- Validaciones-->
	<script>

	</script>

</body>
</html>
