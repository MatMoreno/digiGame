
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="java.util.HashMap,java.time.format.DateTimeFormatter ,modelo.control.CarritoItem,modelo.hibernate.Usuarios,modelo.hibernate.Articulo,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<%
	String baseJsp = (String) request.getAttribute("baseJsp");
	ArrayList<Genero> lista = (ArrayList<Genero>) request.getAttribute("arrayGenero");
	HttpSession sesion = request.getSession();
	HashMap<Integer, CarritoItem> carrito = (HashMap<Integer, CarritoItem>) sesion.getAttribute("carrito");
	int carritoSize = 0;
	if (carrito != null)
		carritoSize = carrito.size();
	ArrayList<Articulo> listaJuegos = (ArrayList<Articulo>) request.getAttribute("arrayJuegos");
	Articulo juego = (Articulo) request.getAttribute("articuloElegido");
	if (request.getAttribute("articuloGenero") != null) {
		out.print(request.getAttribute("articuloGenero"));
		listaJuegos = (ArrayList<Articulo>) request.getAttribute("articuloGenero");
	}
%>

<html>
<head>
<title>Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Your description">
<meta name="keywords" content="Your keywords">
<meta name="author" content="Your name">

<link rel="stylesheet" href="bootstrap/css/bootstrap.css"
	type="text/css" media="screen">
<link rel="stylesheet" href="boot/css/style.css" type="text/css"
	media="screen">
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/estilos.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script src="js/jquery.ui.totop.js" type="text/javascript"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>

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
	var numCarrito = 0;
	function sumCarrito() {
		numCarrito++;
		document.getElementById("numeroCarrito").innerHTML = "Carrito("
				+ numCarrito + ")";

	}
</script>
<script>
	var bool = false;
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
				if (sesion.getAttribute("usuarioLogueado") != null) {
			%>
			<a href="<%=baseJsp%>?action=irInicioLog">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Cat�logo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a id="numeroCarrito" href="<%=baseJsp%>?action=irCarrito">Carrito[<%=carritoSize%>]
			</a> <a href="<%=baseJsp%>?action=irMisCompras">Mis Compras</a> <a
				href="<%=baseJsp%>?action=cerrarSesion">cerrar sesi�n</a>
			<%
				} else {
			%>
			<a href="<%=baseJsp%>?action=irInicio">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Cat�logo</a> <a
				href="<%=baseJsp%>?action=irLogin">Login</a> <a
				href="<%=baseJsp%>?action=irRegistro">Registrarse</a>
			<%
				}
			%>

		</div>
	</header>

	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<p>G�nero</p>
		<legend></legend>

		<%
			for (int i = 0; i < lista.size(); i++) {%>
		<a
			href="<%=baseJsp%>?action=irGenero&idGen=<%=lista.get(i).getCodigoGenero()%> "><%=lista.get(i).getNombre()%></a>
		<%
			}
		%>

	</div>

	<div
		style="overflow: auto; background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; padding-top: 2%">
		<input type="button"
			<%if (request.getAttribute("articuloElegido") == null) {
				out.print("hidden");
			}%>
			style="float: left; font-size: 16px; margin: 5px; font-weight: bold;"
			class="btn:hover" name="volverPanelControl" value="Volver atr�s"
			onClick="window.location.href='<%=baseJsp%>?action=irArticulos'">
		<h2 style="text-align: center;">
			<%
				if (request.getAttribute("articuloElegido") != null) {
					out.print(juego.getNombre());
				} else {
			%>Cat�logo
			de juegos<%
				}
			%>
		</h2>

		<legend></legend>
		<%
			if (request.getAttribute("articuloElegido") != null) {

				String fecha = juego.getFechaDeLanzamiento().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
		%>
		<div
			style="margin: auto; width: 80%; height: 460px; overflow: hidden; margin-bottom: 5%">
			<span style="float: left; width: 30%; height: 400px"> <img
				src="img/imgArticulos/<%=juego.getCodigoArticulo()%>.jpg"
				alt="Cod:WWII" style="width: 100%; height: 100%" />
			</span> <span class="infoJuego"> <legend>
					<h4 style="color: black;">Detalles</h4>
				</legend> <span class="infoJuego1">
					<p>Stock:</p>
					<p>Nombre:</p>
					<p>Plataforma:</p>
					<p>Fecha de Lanzamiento:</p>
					<p>Informacion Adicional:</p> </br>
					<p>Precio</p>
			</span> <span style="float: right; height: 400px; width: 45%;">
					<p><%=juego.getStock()%></p>
					<p><%=juego.getNombre().toUpperCase()%></p>
					<p><%=juego.getPlataforma()%></p>
					<p><%=fecha%></p>
					<p><%=juego.getInformacionAdicional()%></p> </br> </br>
					<p style="font-size: 20px; font-weight: bold"><%=juego.getPrecio() + "&euro;"%></p>
					</br> <%
 	if (sesion.getAttribute("usuarioLogueado") != null) {
 %> <a
					href="<%=baseJsp%>?action=addToCarrito&addIdProd=<%=juego.getCodigoArticulo()%>&cantidad=1"
					style="cursor: pointer; font-size: 16px; color: red;">A�adir
						al carrito</a> <%
 	}
 %>
			</span>
			</span>
		</div>
		<%
			} else {
				if (listaJuegos.size() != 0) {
					for (int i = 0; i < listaJuegos.size(); i++) {
						String fecha = listaJuegos.get(i).getFechaDeLanzamiento()
								.format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
		%>
		<div
			style="margin: auto; width: 80%; height: 400px; overflow: hidden; margin-bottom: 5%">
			<span style="float: left; width: 30%; height: 400px"> <img
				src="img/imgArticulos/<%=listaJuegos.get(i).getCodigoArticulo()%>.jpg"
				style="width: 100%; height: 100%" />
			</span> <span class="infoJuego">
				<h2>Informacion adicional</h2> <legend></legend> <span
				class="infoJuego1">

					<p>Nombre:</p>
					<p>Plataforma:</p>
					<p>Fecha de Lanzamiento:</p> </br>
					<p>Precio:</p>
			</span> <span style="float: right; height: 400px; width: 45%;">

					<p><%=listaJuegos.get(i).getNombre().toUpperCase()%></p>
					<p><%=listaJuegos.get(i).getPlataforma()%></p>
					<p><%=fecha%></p> </br>
					<p style="font-size: 20px; font-weight: bold;color:red"><%=listaJuegos.get(i).getPrecio() + "&euro;"%></p>
					<a
					href="<%=baseJsp%>?action=irJuego&idProd=<%=listaJuegos.get(i).getCodigoArticulo()%>"
					style="cursor: pointer; font-size: 16px; color: red;">Ver m�s
						detalles</a>
			</span>
			</span>
		</div>
		<legend></legend>
		<%
			}
				} else {
		%>
		<div
			style="text-align: center; margin: auto; width: 80%; height: 100px; overflow: hidden; margin-bottom: 5%">
			<p style="font-size: 18px">No hay articulos de este g�nero</p>
		</div>
		<%
			}
			}
		%>
	</div>
	<div class="container">
		<section style="height: 80px;"></section>
		<!----------- Footer ------------>
		<footer class="footer-bs">
			<div class="row">
				<div class="col-md-3 footer-brand animated fadeInLeft">
					<h2 style="color: white">DG e-shop</h2>

					<p>2017 Mat Moreno. All rights reserved</p>
				</div>
				<div class="col-md-4 footer-nav animated fadeInUp">
					<h4>Menu</h4>

					<div class="col-md-6">
						<ul class="list">
							<li><a href="#">sobre nosotros</a></li>
							<li><a href="#">Contacto</a></li>
							<li><a href="#">Terminos y condiciones</a></li>
							<li><a href="#">Pol�tica de privacidad</a></li>
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
						<input style="height: 34px;" type="text" class="form-control"
							placeholder="Search for..."> <span
							class="input-group-btn">
							<button class="btn btn-default" type="button">
								<span class="glyphicon glyphicon-envelope"></span>
							</button>
						</span>
					</div>
					<!-- /input-group -->
					</p>
				</div>
			</div>
		</footer>

	</div>
</body>
</html>