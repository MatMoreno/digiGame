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
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css" media="screen">
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
<a   href="<%=baseJsp%>?action=irCuenta">Perfil de <b>Admin</b> <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irPanelAdmin">Panel de Control</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>
<div style="background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); width: 70%;margin:auto;height: 400px">
<legend style="font-size:28px;">Panel de Control</legend>
<span style="width: 22%" >
<input onClick="window.location.href='<%=baseJsp%>?action=irUsuariosAdmin'" style="margin-top:10%;margin-left:5%;font-size: 22px" class="btn " type="button" id="gestionUsuarios" value="Administrar Usuarios" ></input>
</span>
<span style="width: 22%">
<input onClick="window.location.href='<%=baseJsp%>?action=irModificarGeneros'"  style="margin-top:10%;margin-left:10%;font-size: 22px" type="button"   class="btn " id="gestionGeneros" value="Administrar Generos" ></input>
</span>
<span style="width: 22%">
<input onClick="window.location.href='<%=baseJsp%>?action=irArticulosAdmin'"   style="margin-top:10%;margin-left:10%;font-size: 22px" class="btn " type="button" id="GestionArticulos" value="Administrar Articulos" ></input>
</span>
</div>
<div class="container">
    <section style="height:80px;"></section>
    <!----------- Footer ------------>
    <footer class="footer-bs">
        <div class="row">
        	<div class="col-md-3 footer-brand animated fadeInLeft">
            	<h2 style="color: white">DG e-shop</h2>
                
                <p>  2017 Mat Moreno.  All rights reserved</p>
            </div>
        	<div class="col-md-4 footer-nav animated fadeInUp">
            	<h4>Menu </h4>
            	
            	<div class="col-md-6">
                    <ul class="list">
                        <li><a href="#">About Us</a></li>
                        <li><a href="#">Contacts</a></li>
                        <li><a href="#">Terms & Condition</a></li>
                        <li><a href="#">Privacy Policy</a></li>
                    </ul>
                </div>
            </div>
        	<div class="col-md-2 footer-social animated fadeInDown">
            	<h4 style="color: white">Follow Us</h4>
            	<ul>
                	<li><a href="#">Facebook</a></li>
                	<li><a href="#">Twitter</a></li>
                	<li><a href="#">Instagram</a></li>
                	<li><a href="#">RSS</a></li>
                </ul>
            </div>
        	<div class="col-md-3 footer-ns animated fadeInRight">
            	<h4 style="color: white">Newsletter</h4>
                <p>A rover wearing a fuzzy suit doesn't alarm the real penguins</p>
                <p>
                    <div class="input-group">
                      <input style="height: 30px;" type="text" class="form-control" placeholder="Search for...">
                      <span class="input-group-btn">
                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-envelope"></span></button>
                      </span>
                    </div><!-- /input-group -->
                 </p>
            </div>
        </div>
    </footer>

</div>

</body>
</html>


</body>
</html>
  <% }else{%>
  <html>
  <head></head>
  <body>
  <h1 style="margin:auto">NO TIENES PERMISOS SUFICIENTES PARA ENTRAR A ESTA ZONA!</h1>
  </body>
  </html>
   <%} %>