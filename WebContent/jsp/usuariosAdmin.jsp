

<%
	HttpSession sesion = request.getSession();
	String baseJsp = (String) request.getAttribute("baseJsp");
	String error = (String) request.getAttribute("error");
	HashMap<String, Usuarios> mapUsuario = (HashMap<String, Usuarios>) sesion.getAttribute("mapUsuarios");
	pageContext.setAttribute("listaUsers", mapUsuario);
	if (sesion.getAttribute("usuarioLogueado") != null && (Integer) sesion.getAttribute("codAdmin") == 1) {
%>
<!DOCTYPE html>
<%@page
	import="java.time.format.DateTimeFormatter,java.util.HashMap,java.util.Set,modelo.hibernate.Usuarios,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html>
<head>
<title>Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Your description">
<meta name="keywords" content="Your keywords">
<meta name="author" content="Your name">

<link rel="stylesheet" href="boot/css/style.css" type="text/css"
	media="screen">
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="css/estilos.css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
<script type="text/javascript" src="js/camera.js"></script>
<script src="js/jquery-3.2.1.min.js" type="text/javascript"></script>
<script type="text/javascript" src="js/jquery.mobile.customized.min.js"></script>
<script>
	$(document).ready(function() {
		$("#mytable #checkall").click(function() {
			if ($("#mytable #checkall").is(':checked')) {
				$("#mytable input[type=checkbox]").each(function() {
					$(this).prop("checked", true);
				});

			} else {
				$("#mytable input[type=checkbox]").each(function() {
					$(this).prop("checked", false);
				});
			}
		});

		$("[data-toggle=tooltip]").tooltip();
	});
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
		style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); width: 70%; margin: auto; height: 400px">
		<legend style="font-size: 28px;">Panel de Control</legend>
		<div class="table-responsive">

			<table class="table table-fixed" cellspacing="0" width="100%">
				<thead>
					<tr>
						<th>E-mail</th>
						<th>Nombre</th>
						<th>Apellido</th>
					</tr>
				</thead>

				<tbody>

					<c:forEach items="${listaUsers}" var="list">
						<tr>
							<td>${list.key}</td>
							<td>${list.value.nombre}</td>
							<td>${list.value.apellidos}</td>
							<td><a class="btn btn-sm btn-danger" id="delete_product">
							<i class="glyphicon glyphicon-trash"></i></a></td>
						</tr>
						  <tr>
        <td class="col-xs-3">John</td>
        <td class="col-xs-3">Doe</td>
        <td class="col-xs-6">johndoe@email.com</td>
      </tr>
        <tr>
        <td class="col-xs-3">John</td>
        <td class="col-xs-3">Doe</td>
        <td class="col-xs-6">johndoe@email.com</td>
      </tr>
        <tr>
        <td class="col-xs-3">John</td>
        <td class="col-xs-3">Doe</td>
        <td class="col-xs-6">johndoe@email.com</td>
      </tr>
        <tr>
        <td class="col-xs-3">John</td>
        <td class="col-xs-3">Doe</td>
        <td class="col-xs-6">johndoe@email.com</td>
      </tr>
					</c:forEach>




				</tbody>
			</table>

		</div>
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