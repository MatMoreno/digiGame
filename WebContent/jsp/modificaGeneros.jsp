

<%
  String baseJsp = (String)request.getAttribute("baseJsp");
  String error=(String)request.getAttribute("error");
  ArrayList<Genero> lista=(ArrayList<Genero>) request.getAttribute("arrayGenero");
  pageContext.setAttribute("listaGenero", lista);
  HttpSession sesion = request.getSession();
  if(sesion.getAttribute("usuarioLogueado")!=null && (Integer)sesion.getAttribute("codAdmin")==1){ 
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %> 
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
    <script>
    function mensajeExito(){
    	document.getElementById("form2").visibility="hidden";
    }
    </script>
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
</head>

<body >
<!--==============================header=================================-->
<header  class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
<a   href="<%=baseJsp%>?action=irCuenta">Perfil de <b>Admin</b> <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>
<div style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); width: 70%;margin:auto;height: 400px">
<legend style="font-size:28px;">Modificar Géneros</legend>
<div style="margin-left: 20px">
<%if(request.getParameter("genero")==null){ %>
<form action="<%=baseJsp%>?action=irCambiarNombreGeneros" method="POST">
<select name="genero" >
 
 <c:forEach items="${listaGenero}" var="list">
          <option value="${list.codigoGenero}" >${list.nombre} </option>
</c:forEach>

</select>
<br><input type="submit" value="Cambiar nombre" >
</form>
<%}else{ %>
<form id="form2" action="<%=baseJsp%>?action=cambiarNombreGenero&genero=<%=request.getParameter("genero")%>" method="POST">
<h2><%=lista.get(Integer.parseInt(request.getParameter("genero"))-1).getNombre()%></h2>
<input name="nuevoNombre" type="text" placeholder="Nuevo nombre" required >
<br><input type="submit" value="enviar" onclick="mensajeExito()" >
</form>
<input type="button" name="volverlistaGeneros" value="volver" onClick="window.location.href='<%=baseJsp%>?action=irModificarGeneros'">
<%}%>
</div>
</div>


</body>
</html>
  <% }else{%>
  <html>
  <head></head>
  <body>
  <h1 style="margin:auto">NO TIENES PERMISOS SUFICIENTES PARA ENTRAR A ESTA ZONA!</h1>
  </body>
  </html>
   <%}
  out.print(request.getParameter("genero"));%>