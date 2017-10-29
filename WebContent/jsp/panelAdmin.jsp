

<%
  String baseJsp = (String)request.getAttribute("baseJsp");
  String error=(String)request.getAttribute("error");
  ArrayList<Genero> lista=(ArrayList<Genero>) request.getAttribute("arrayGenero");
  HttpSession sesion = request.getSession();
  if(sesion.getAttribute("usuarioLogueado")!=null && (Integer)sesion.getAttribute("codAdmin")==1){ 
%>
<!DOCTYPE html>
<%@page import="java.time.format.DateTimeFormatter,java.util.HashMap,java.util.Set,modelo.hibernate.Usuarios,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>

<html>
<head>
    <title>Home</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Your description">
    <meta name="keywords" content="Your keywords">
    <meta name="author" content="Your name">
    <link rel="stylesheet" href="boot/css/bootstrap.css" type="text/css" media="screen">
    <link rel="stylesheet" href="boot/css/responsive.css" type="text/css" media="screen">
    <link rel="stylesheet" href="boot/css/camera.css" type="text/css" media="screen"> 
    <link rel="stylesheet" href="boot/css/style.css" type="text/css" media="screen">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
    <link  rel="stylesheet" href="css/estilos.css">
	<script type="text/javascript" src="js/jquery.js"></script>
    <script type="text/javascript" src="js/jquery.easing.1.3.js"></script>
	<script type="text/javascript" src="js/camera.js"></script>
    <script src="js/jquery.ui.totop.js" type="text/javascript"></script>	
    <script type="text/javascript" src="js/jquery.mobile.customized.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
</head>

<body >
<!--==============================header=================================-->
<header  class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
>
<a href="">Home</a>
<a href="">Catálogo</a>
<a   href="<%=baseJsp%>?action=irCuenta">Perfil de <b>Admin</b> <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>
<div style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); width: 70%;margin:auto;height: 400px">

<input style="margin-top:10%;margin-left:20%;margin-right: 8%;font-size: 18px" type="button" id="gestionUsuarios" value="Administrar Usuarios" ></input>
<input style="margin-top:10%;margin-right: 8%;font-size: 18px" type="button"  id="gestionGeneros" value="Administrar Generos" ></input>
<input  style="margin-top:10%;margin-right: 8%;font-size: 18px" type="button" id="GestionArticulos" value="Administrar Articulos" ></input>

</div>


</body>
</html>
  <% }else{ %>
  <html>
  <head></head>
  <body>
  <h1 style="margin:auto">NO TIENES PERMISOS SUFICIENTES PARA ENTRAR A ESTA ZONA!</h1>
  </body>
  </html>
   <%} %>