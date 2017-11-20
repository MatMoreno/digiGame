<!DOCTYPE html>

<%
  String baseJsp = (String)request.getAttribute("baseJsp");
  String error=(String)request.getAttribute("error");
  ArrayList<Genero> lista=(ArrayList<Genero>) request.getAttribute("arrayGenero");
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
     <link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css" media="screen">
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
<header  STYLE="width:70%;margin:auto;text-align:center" class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
<a href="<%=baseJsp%>?action=irInicio">Home</a>
<a href="<%=baseJsp%>?action=irArticulos">Catálogo</a>
<a   href="<%=baseJsp%>?action=irLogin">Login</a>
<a href="<%=baseJsp%>?action=irRegistro">Registrarse</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>
<div id="fondoL">
<div  style="margin:auto;margin-top:5%;padding:5%;width: 35%;opacity:0.88 ;border: 3px black thin;  border-radius:20px;background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 50) 80%);">
        
            <form   action="<%=baseJsp%>?action=botonLogin" method="POST">
                <h2>Iniciar Sesión</h2>
                <input type="text" class="input-block-level" placeholder="correo electrónico" name="emailLogin" id='email' required>
                <input type="password" class="input-block-level" placeholder="contraseña" name="password" id="password" required>
                <button  type="submit">Entrar</button><label style="display:inline;margin-left: 5px; "><a style="color: black" href="<%=baseJsp%>?action=irRegistro" >Registrate ahora!</a></label>
            </form>
            <%
          
            if(error.equals("true")){
            	%>
            	<p style="color: red">El email o contraseña introducidos no coinciden</p>
            	<%
            }
            %>
        
</div>
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
                        <li><a href="#">Sobre nosotros</a></li>
                        <li><a href="#">Contacto</a></li>
                        <li><a href="#">Terminos y condiciones</a></li>
                        <li><a href="#">Política de privacidad</a></li>
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