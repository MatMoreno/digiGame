
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String baseJsp = (String) request.getAttribute("baseJsp");
	ArrayList<Genero> lista = (ArrayList<Genero>) request.getAttribute("arrayGenero");
	HttpSession sesion = request.getSession();
	HashMap<String, Usuarios> mapUsuario = (HashMap<String, Usuarios>) sesion.getAttribute("mapUsuarios");
	Boolean panelEdit = (Boolean) sesion.getAttribute("panelEdit");
	if (sesion.getAttribute("usuarioLogueado") == null) {
		response.sendRedirect("/DigitalGame/servlet?action=irInicioLog");
	} else {
%>
<%@page
	import="java.time.format.DateTimeFormatter,java.util.HashMap,java.util.Set,modelo.hibernate.Usuarios,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
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
	href='http://fonts.googleapis.com/css?family=Open+Sans:500,600,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/estilos.css">
<script type="text/javascript" src="js/jquery.js"></script>
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
	function myFunction() {
		var x = document.getElementById("myTopnav");
		if (x.className === "topnav") {
			x.className += " responsive";
			document.getElementById("mySidenav").style.marginTop = "500px";
		} else {
			document.getElementById("mySidenav").style.marginTop = "143px";
			x.className = "topnav";
		}
	}
</script>

</head>

<body id="fondo">
	<!--==============================header=================================-->

	<header class="p0">
		<div style="padding-left: 16px">
			<h2>DIGITALGAME e-SHOP</h2>
		</div>
		<div class="topnav" id="myTopnav">
			<a style="cursor: pointer" onclick="openNav()">&#9776;</a>
			<%
				if ((Integer) sesion.getAttribute("isAdmin") != 1) {
			%>
			<a href="<%=baseJsp%>?action=irInicioLog">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Catálogo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a href="<%=baseJsp%>?action=irCarrito">Carrito()</a> <a
				href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
			<%
				} else {
			%>
			<a href="">Home</a> <a href="">Catálogo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de Admin <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a> <a
				href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
			<%
				}
			%><a href="javascript:void(0);" style="font-size: 15px;" class="icon"
				onclick="myFunction()">&#9776;</a>
		</div>
	</header>

	<div
		style="margin-top: 0; background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; height: 400px">
		<h2>INFORMACION PERSONAL</h2>
		<legend></legend>
		<%
			Session sesionHib = HibernateUtils.getSessionFactory().openSession();
				Usuarios user = (Usuarios) sesionHib.get(Usuarios.class, (String) sesion.getAttribute("emailLogueado"));
				String fechaNew = user.getFechaDeNac().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
				if (panelEdit == false || panelEdit == null) {
		%>
		<div
			style="margin: auto; width: 80%; height: 500px; overflow: hidden; margin-bottom: 5%">
			<span style="float: left; width: 30%; height: 500px">
				<p>Nombre:</p>
				<p>Apellidos:</p>
				<p>E-mail:</p>
				<p>Fecha de Nacimiento:</p>
			</span> <span style="float: right; width: 70%; height: 500px">
				<p><%=user.getNombre()%></p>
				<p><%=user.getApellidos()%></p>
				<p><%=user.getEmailUsuario()%></p>
				<p><%=fechaNew%></p> <input
				onClick="window.location.href='<%=baseJsp%>?action=irEditarPerfil'"	class="btn:hover" type="button" value="Editar perfil"></input>
			</span>
			<%
				} else {
			%>
			<div
				style="margin: auto; width: 80%; height: 500px; overflow: hidden; margin-bottom: 5%">
				<span style="float: left; width: 30%; height: 500px">
					<p>Nombre:</p>
					<p>Apellidos:</p>
					<p>Fecha de Nacimiento:</p>
					</br>
					<p>Contraseña antigua:</p>
					<p>Nueva Contraseña:</p>
				</span>
				<!-- onsubmit="return valida()" -->
				<form action="<%=baseJsp%>?action=updateUsuario" method="POST"      >
					<span style="float: right; width: 70%; height: 500px"> <input
						type="text" pattern="[A-Za-z]{3,15}" name="nombreUpdate"
						value="<%=user.getNombre()%>" required></input></br> <input type="text"
						pattern="[A-Za-z ]{5,15}[A-Za-z]" name="apellidosUpdate"
						value="<%=user.getApellidos()%>" required></input></br> 
						<%-- <input
						type="email" name="correoUpdate"
						value="<%=user.getEmailUsuario()%>" required disabled></input></br> --%> 
						<input	type="date" name="fechaUpdate" id="fechaUpdate"
						value="<%=user.getFechaDeNac()%>" required></input></br> <a
						style="color: black; cursor: pointer" onclick="cambiaContra()">Cambiar	contraseña</a>
						<div id="vermasdiv" style="display: none;">
							<input type="password" pattern=".{6,}" title="6 o más caracteres" id="passUpdate1" name="passUpdate1"></input></br>
							<input type="password" pattern=".{6,}"  title="6 o más caracteres" id="passUpdate2" name="passUpdate2"></input></br>	
							</div> 
							<input class="btn:hover" type="submit" value="Guardar Cambios"></input>
						
					</span>
				</form>
				<%
					}
				%>
			</div>
		</div>
		<script>
			var abierto = false;
			function cambiaContra() {
				var eldiv = document.getElementById("vermasdiv");

				if (abierto == false) {
					eldiv.style.display = "block";
					abierto = true;
				} else {
					
					eldiv.style.display = "none";
					document.getElementById("passUpdate1").value="";
					document.getElementById("passUpdate2").value="";
					abierto = false;
					
				}

			}
			function valida(){
				if (document.getElementById("passHidden")!=document.getElementById("passUpdate1")){
					return false;
				}else{
					return true;
				}
				
			}
		</script>
</body>
</html>
<%
	}
%>