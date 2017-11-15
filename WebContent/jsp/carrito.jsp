
<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
<%
	HttpSession sesion = request.getSession();
	int carritoSize = 0;

	if (sesion.getAttribute("usuarioLogueado") == null) {
		response.sendRedirect("/DigitalGame/servlet?action=irInicioLog");
		out.print("ERROOOOOOOOOOOOOOOOOOR USUARIO NO LOGUEADOO");
	}

	String baseJsp = (String) request.getAttribute("baseJsp");
	HashMap<Integer, CarritoItem> carrito = (HashMap<Integer, CarritoItem>) sesion.getAttribute("carrito");
	if (carrito != null) {
		carritoSize = carrito.size();
		pageContext.setAttribute("listCarrito", carrito);
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@page
	import="modelo.hibernate.Usuarios,modelo.control.CarritoItem, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
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

<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:400,600,700"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" href="css/estilos.css">
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
			<a href="<%=baseJsp%>?action=irInicioLog">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Cat�logo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a href="<%=baseJsp%>?action=irCarrito">Carrito(<%=carritoSize%>)
			</a> <a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesi�n</a> <a
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

	<%
		int totalJuego = 0;
			int total = 0;
	%>

	<div
		style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 54%;">
		<div class="container">
			<div class="row">
				<div class="col-xs-8">
					<div class="panel panel-info">
						<div class="panel-heading">
							<div class="panel-title">
								<div class="row">
									<div class="col-xs-6">
										<h5>
											<span class="glyphicon glyphicon-shopping-cart"></span>
											Carrito
										</h5>
									</div>
									<div class="col-xs-6">
										<button
											onClick="window.location.href='<%=baseJsp%>?action=irArticulos'"
											type="button" class="btn btn-primary btn-sm btn-block">
											<span class="glyphicon glyphicon-share-alt"></span> Continuar
											comprando
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="panel-body">
							<%
								if (carritoSize == 0)
										out.print("<h4>Carrito vac�o...</h4>");
							%>
							<c:set var="total" value="0" />
							<c:forEach var="cart" items="${listCarrito}">
								<div class="row">
									<div class="col-xs-2">
										<img class="img-responsive"
											src="img/imgArticulos/${cart.value.articulo.getCodigoArticulo()}.jpg">
									</div>
									<div class="col-xs-4">
										<h4 class="product-name">
											<strong>${cart.value.articulo.getNombre() }</strong>
										</h4>
										<h4>
											<small>${cart.value.articulo.getPlataforma() }</small>
										</h4>
									</div>
									<div class="col-xs-6">
										<div class="col-xs-6 text-right">
											<h6>
												<strong>${cart.value.articulo.getPrecio() }&euro; <span
													class="text-muted">x</span></strong>
											</h6>
										</div>

										<div class="col-xs-4">
											<input type="hidden" name="codigo"
												value="${cart.value.articulo.getCodigoArticulo()}">
											<input name="cantidadItem" type="text"
												class="form-control input-sm"
												value="${cart.value.cantidad }">
										</div>
										<div class="col-xs-1">
											<form>
												<input type="hidden" name="action"
													value="aumentarCantidadItemCarrito"> <input
													type="hidden" name="codigo"
													value="${cart.value.articulo.getCodigoArticulo()}">
												<button type="submit" class="btn btn-link btn-xs">
													<span class="glyphicon glyphicon-plus"> </span>
												</button>
											</form>
										</div>
										<form>
											<div class="col-xs-1">
												<input type="hidden" name="action" value="deleteItemCarrito">
												<input type="hidden" name="codigo"
													value="${cart.value.articulo.getCodigoArticulo()}">
												<button type="submit" class="btn btn-link btn-xs">
													<span class="glyphicon glyphicon-trash"> </span>
												</button>
											</div>
										</form>

									</div>
								</div>
								<hr>
								<c:set var="precio" value="${cart.value.articulo.getPrecio()}" />
								<c:set var="total"
									value="${total+( cart.value.cantidad*precio)}" />
							</c:forEach>

						</div>
						<div class="panel-footer">
							<div class="row text-center">
								<div class="col-xs-9">
									<h4 class="text-right">
										Total <strong>${total}&euro;</strong>
									</h4>
								</div>
								<div class="col-xs-3">
									<form>
										<input type="hidden" name="action"
											value="irCheckout"> <input
											type="hidden" name="codigo"
											value="${cart.value.articulo.getCodigoArticulo()}">
										<button type="button" class="btn btn-success btn-block">
											Pagar ahora</button>
									</form>

								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
			} else {
		%>
		<div class="container">
			<div class="row">
				<div class="col-xs-8">
					<div class="panel panel-info">
						<div class="panel-heading">
							<div class="panel-title">
								<div class="row">
									<div class="col-xs-6">
										<h5>
											<span class="glyphicon glyphicon-shopping-cart"></span>
											Carrito
										</h5>
									</div>
									<div class="col-xs-6">
										<button
											onClick="window.location.href='<%=baseJsp%>?action=irArticulos'"
											type="button" class="btn btn-primary btn-sm btn-block">
											<span class="glyphicon glyphicon-share-alt"></span> Continuar
											comprando
										</button>
									</div>
								</div>
							</div>
						</div>
						<div class="panel-body">

							<h4>CARRITO VAC�O</h4>

						</div>
						<div class="panel-footer">
							<div class="row text-center">
								<div class="col-xs-9">
									<h4 class="text-right">
										Total <strong>${total}</strong>
									</h4>
								</div>
								<div class="col-xs-3">
									<button type="button" class="btn btn-success btn-block">
										Pagar ahora</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<%
			}
		%>
	</div>
	<script>
		print
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

</body>
</html>