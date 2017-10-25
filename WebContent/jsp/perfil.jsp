
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%

  String baseJsp = (String)request.getAttribute("baseJsp");
ArrayList<Genero> lista=(ArrayList<Genero>) request.getAttribute("arrayGenero");
HttpSession sesion = request.getSession();
HashMap<String,Usuarios> mapUsuario=(HashMap<String,Usuarios>)sesion.getAttribute("mapUsuarios");

pageContext.setAttribute("map", mapUsuario);
if(sesion.getAttribute("usuarioLogueado")==null){
	response.sendRedirect("/DigitalGame/servlet?action=irInicioLog");
	}
	
	
  %>
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
    <link rel="stylesheet" href="boot/css/style.css" type="text/css" media="screen">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
    <link  rel="stylesheet" href="css/estilos.css">
	<script type="text/javascript" src="js/jquery.js"></script>
    <script src="js/jquery.ui.totop.js" type="text/javascript"></script>	
    <script type="text/javascript" src="js/bootstrap.js"></script>

</head>

<body id="fondo" >
<!--==============================header=================================-->

<header  class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="font-size:30px;cursor:pointer"   onclick="openNav()">&#9776;</a>
<a href="<%=baseJsp%>?action=irInicioLog">Home</a>
<a href="<%=baseJsp%>?action=irArticulos">Juegos</a>
<a   href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irCarrito">Carrito()</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>

<script>
function myFunction() {
    var x = document.getElementById("myTopnav");
    if (x.className === "topnav") {
        x.className += " responsive";
        document.getElementById("mySidenav").style.marginTop="400px";
    } else {
    	 document.getElementById("mySidenav").style.marginTop="143px";
        x.className = "topnav";
    }
}
</script>


<div id="mySidenav" class="sidenav">
  <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
  <p href="#">Generos</p>
  <legend></legend>
  <%
	for(int i=0;i<lista.size();i++){
		out.print(" <a href=''> "+lista.get(i).getNombre()+"</a>");
	}
  
  %>
  <a href="#">Services</a>
</div>
<div style="margin-top:0;background-color:white;margin:auto;width:70%;height:600px">
<table>
<h2>INFORMACION PERSONAL</j2>
  <legend></legend>
  <% 
 
  Session sesionHib = HibernateUtils.getSessionFactory().openSession();
Usuarios user=(Usuarios)sesionHib.get(Usuarios.class,(String)sesion.getAttribute("emailLogueado")); 
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy");
String fechaNew = user.getFechaDeNac().format(formatter);

  %>
  <table>
<tr>
<td>Nombre:</td>
<td><%=user.getNombre()%></td>
</tr>
<tr>
<td>Apellidos:</td>
<td><%=user.getApellidos() %></td>
</tr>
<tr>
<td>E-mail:</td>
<td><%=user.getEmailUsuario()%></td>
</tr>
<tr>
<td>Fecha de Nacimiento</td>
<td><%=fechaNew%></td>
</tr>



</table>
</div>

<script>
var bool=true;
function openNav() {
if(bool==true){
    document.getElementById("mySidenav").style.width = "15%";
	bool=false;
	}else{
	bool=true;
	closeNav();
	}
}

function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
}
</script>

</body>
</html>