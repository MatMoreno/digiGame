
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="java.time.format.DateTimeFormatter ,modelo.hibernate.Usuarios,modelo.hibernate.Articulo,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<%
	String baseJsp = (String) request.getAttribute("baseJsp");
	ArrayList<Genero> lista = (ArrayList<Genero>) request.getAttribute("arrayGenero");
	HttpSession sesion = request.getSession();
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
<link rel="stylesheet" href="boot/css/bootstrap.css" type="text/css"
	media="screen">
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
	var numCarrito=0;
	function sumCarrito(){
		numCarrito++;
		document.getElementById("numeroCarrito").innerHTML="Carrito("+numCarrito+")";
		
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

<header  class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
<a href="<%=baseJsp%>?action=irCuenta">Perfil de <b>Admin</b> <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>

	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<p>Género</p>
		<legend></legend>
	
		<%
			for (int i = 0; i < lista.size(); i++) {%>
		<a
			href="<%=baseJsp%>?action=irGenero&idGen=<%=lista.get(i).getCodigoGenero()%> "><%=lista.get(i).getNombre()%></a>
		<%
			}
		%>

	</div>

	<div style="overflow: auto; background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; padding-top: 2%">
		<h2 style="text-align: center;"><%if (request.getAttribute("articuloElegido") != null) { out.print(juego.getNombre());}else{%>Catálogo de juegos<%} %></h2>
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
					<h3 style="color: black;">Detalles</h3>
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
					<textarea disabled
						style="color: black; background-color: white"><%=juego.getInformacionAdicional()%></textarea> </br> </br>
					<p style="font-size: 20px; font-weight: bold"><%=juego.getPrecio() + "&euro;"%></p>
					</br> 
					<a
					href="<%=baseJsp%>?action=irJuego&idProd=<%=juego.getCodigoArticulo()%>"
					style="cursor: pointer; font-size: 16px; color: red;">Adquirir
						Key&nbsp;</a>
						 <a	onClick="sumCarrito()" style="cursor: pointer; font-size: 16px; color: red;" >Añadir al
						carrito</a>
			</span>
			</span>
		</div>
		<%
			} else {
				if (listaJuegos.size() != 0) {
					for (int i = 0; i < listaJuegos.size(); i++) {
						String fecha = listaJuegos.get(i).getFechaDeLanzamiento().format(DateTimeFormatter.ofPattern("dd-MM-yyyy"));
		%>
		
		<div style="margin: auto; width: 80%; height: 400px; overflow: hidden; margin-bottom: 5%">
			<span style="float: left; width: 30%; height: 400px"> <img
				src="img/imgArticulos/<%=listaJuegos.get(i).getCodigoArticulo()%>.jpg"
				 style="width: 100%; height: 100%" />
			</span> <span class="infoJuego">
				<h2>Informacion adicional</h2> <legend></legend> <span
				class="infoJuego1">
					<p>Stock:</p>
					<p>Nombre:</p>
					<p>Plataforma:</p>
					<p>Fecha de Lanzamiento:</p>
					<p>Informacion Adicional:</p> </br>
					<p>Precio</p>
			</span>
			 <span style="float: right; height: 400px; width: 45%;">
					<p><%=listaJuegos.get(i).getStock()%></p>
					<p><%=listaJuegos.get(i).getNombre().toUpperCase()%></p>
					<p><%=listaJuegos.get(i).getPlataforma()%></p>
					<p><%=fecha%></p> <textarea disabled
						style="color: black; background-color: white"><%=listaJuegos.get(i).getInformacionAdicional()%></textarea>
					<p style="font-size: 20px; font-weight: bold"><%=listaJuegos.get(i).getPrecio() + "&euro;"%></p>
					<a		href="<%=baseJsp%>?action=irJuego&idProd=<%=listaJuegos.get(i).getCodigoArticulo()%>"
					style="cursor: pointer; font-size: 16px; color: red;">Ver más detalles</a>
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
			<p style="font-size: 18px">No hay articulos de este género</p>
		</div>
		<%
			}
			}
		%>
	</div>
</body>
</html>