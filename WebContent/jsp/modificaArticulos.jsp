

<%
	ArrayList<Genero> lista = (ArrayList<Genero>) request.getAttribute("arrayGenero");
	String baseJsp = (String) request.getAttribute("baseJsp");
	String error = (String) request.getAttribute("error");
	Articulo juego = (Articulo) request.getAttribute("articuloElegido");
	HttpSession sesion = request.getSession();
	if (sesion.getAttribute("usuarioLogueado") != null && (Integer) sesion.getAttribute("codAdmin") == 1) {
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<%@page
	import="java.time.format.DateTimeFormatter,java.util.HashMap,java.util.Set,modelo.hibernate.Usuarios,modelo.hibernate.Genero,modelo.hibernate.Articulo, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>

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
<link rel="stylesheet" href="boot/css/responsive.css" type="text/css"
	media="screen">
<link rel="stylesheet" href="boot/css/camera.css" type="text/css"
	media="screen">
<link rel="stylesheet" href="boot/css/style.css" type="text/css"
	media="screen">
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/estilos.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/camera.js"></script>
<script src="js/jquery.ui.totop.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.mobile.customized.min.js"></script>
<script type="text/javascript" src="js/bootstrap.js"></script>
<script>
	function mensajeExito() {
		document.getElementById("form2").visibility = "hidden";
	}
</script>
</head>

<body>
	<!--==============================header=================================-->
	<header class="p0">
		<div style="padding-left: 16px">
			<h2>DIGITALGAME e-SHOP</h2>
		</div>
		<div class="topnav" id="myTopnav">
			<a style="cursor: pointer" onclick="openNav()">&#9776;</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <b>Admin</b> <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a> <a
				href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a> <a
				href="javascript:void(0);" style="font-size: 15px;" class="icon"
				onclick="myFunction()">&#9776;</a>
		</div>
	</header>
	<div
		style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; height: 600px">

		<form id="form"
			action="<%=baseJsp%>?action=botonModificaArticulo&idProd=<%=juego.getCodigoArticulo()%>"
			method="POST" class="form-horizontal" enctype="multipart/form-data">
			<fieldset>

				<!-- Form Name -->
				<legend>
					<h2>Articulo</h2>
				</legend>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Nombre:</label>
					<div class="controls">
						<input id="nombreReg" name="nombreReg" type="text"
							value="<%=juego.getNombre()%>" placeholder="Nombre"
							class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Plataforma:</label>
					<div class="controls">
						<input id="plataformaU" name="plataformaU" type="text"
							value="<%=juego.getPlataforma()%>" pattern="[A-Za-z]{3,15}"
							title="Al menos 3 caracteres" placeholder="plataforma"
							class="input-xlarge" required>

					</div>
				</div>

				<!-- Text input-->
				<div class="control-group">
					<label class="control-label" for="textinput">Información
						adicional</label>
					<div class="controls">
						<input id="infoU" name="infoU" type="text"
							value="<%=juego.getInformacionAdicional()%>" placeholder="info"
							class="input-xlarge" required>

					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="stockU">Género</label>
					<div class="controls">
						<select id="generoU" name="generoU"  title="solo se permiten números"
							type="text" placeholder="stock" class="input-medium" required>
							<%for(int i =0;i<lista.size();i++){ %>
							<option value="<%=lista.get(i).getCodigoGenero()%>"><%=lista.get(i).getNombre() %></option>
							<%} %>
							</select>
					</div>
				</div>
				<!-- Password input-->
				<div class="control-group">
					<label class="control-label" for="stockU">Stock</label>
					<div class="controls">
						<input id="stockU" name="stockU" pattern="[0-9]{1,4}"
							value="<%=juego.getStock()%>" title="solo se permiten números"
							type="text" placeholder="stock" class="input-medium" required>
					</div>
				</div>


				<div class="control-group">
					<label class="control-label" for="appendedcheckbox">Fecha
						de Lanzamiento</label>
					<div class="controls">
						<div class="input-append">

							<input type="date" id="fechaU"
								value="<%=juego.getFechaDeLanzamiento()%>" name="fechaU"
								required>
						</div>

					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="stockU">Precio</label>
					<div class="controls">
						<input id="precioU" value="<%=juego.getPrecio()%>" name="precioU"
							pattern="[0-9]{1,5}[.][0-9]{0,2}"
							title="solo se permiten números" type="text" placeholder="precio"
							class="input-medium" required>
					</div>
				</div>

				<div class="control-group">
					<label class="control-label" for="appendedcheckbox">Insertar
						imagen</label>
					<div class="controls">
						<div class="input-append">
							<input type="file" id="imagenU" name="imagenU">
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


</body>
</html>
<%
	} else {
%>
<html>
<head></head>
<body>
	<h1 style="margin: auto">NO TIENES PERMISOS SUFICIENTES PARA
		ENTRAR A ESTA ZONA!</h1>
</body>
</html>
<%
	}
%>