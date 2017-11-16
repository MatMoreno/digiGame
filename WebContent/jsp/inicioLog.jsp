
<!DOCTYPE html>
<%

  String baseJsp = (String)request.getAttribute("baseJsp");
ArrayList<Genero> lista=(ArrayList<Genero>) request.getAttribute("arrayGenero");
HttpSession sesion = request.getSession();
HashMap<Integer, CarritoItem> carrito = (HashMap<Integer, CarritoItem>) sesion.getAttribute("carrito");
  %>
<%@page
	import="java.util.HashMap,java.time.format.DateTimeFormatter ,modelo.control.CarritoItem,modelo.hibernate.Usuarios,modelo.hibernate.Articulo,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%><html>
<head>
    <title>Home</title>
    <meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Your description">
    <meta name="keywords" content="Your keywords">
    <meta name="author" content="Your name">

     <link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css" media="screen">
    <link rel="stylesheet" href="boot/css/style.css" type="text/css" media="screen">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css" media="screen">
    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>
    <link  rel="stylesheet" href="css/estilos.css">
	<script type="text/javascript" src="js/jquery.js"></script>
    <script src="js/jquery.ui.totop.js" type="text/javascript"></script>	
    <script type="text/javascript" src="js/bootstrap.js"></script>
	<script>
var bool=false;
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
</head>

<body id="fondo" >
<!--==============================header=================================-->

<header  class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
<%if(sesion.getAttribute("usuarioLogueado")!=null){ %>
<a href="<%=baseJsp%>?action=irInicioLog">Home</a>
<a href="<%=baseJsp%>?action=irArticulos">Catálogo</a>
<a   href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado") %></a>
<a href="<%=baseJsp%>?action=irCarrito">Carrito[<%if(carrito!=null){out.print(carrito.size());} %>]</a>
<a href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
<%}else{ %>
<a href="<%=baseJsp%>?action=irInicio">Home</a>
<a href="<%=baseJsp%>?action=irArticulos">Catálogo</a>
<a   href="<%=baseJsp%>?action=irLogin">Login</a>
<a href="<%=baseJsp%>?action=irRegistro">Registrarse</a>
<%} %>
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
<script >
$(document).ready(function() {
    $('#Carousel').carousel({
        interval: 5000
    })
});
</script>

	<div id="mySidenav" class="sidenav">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
		<p>Género</p>
		<legend></legend>
		<%
			for (int i = 0; i < lista.size(); i++) {%>
		<a
			href="<%=baseJsp%>?action=irGenero&idGen=<%=lista.get(i).getCodigoGenero()%> "><%= lista.get(i).getNombre() %></a>
		<%
				}
		%>

	</div>
	
</div><!--.container-->
<footer>
<div class="container">
    <section style="height:80px;"></section>
    <!----------- Footer ------------>
    <footer class="footer-bs">
        <div class="row">
        	<div class="col-md-3 footer-brand animated fadeInLeft">
            	<h2>DG e-shop</h2>
                
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
            	<h4>Follow Us</h4>
            	<ul>
                	<li><a href="#">Facebook</a></li>
                	<li><a href="#">Twitter</a></li>
                	<li><a href="#">Instagram</a></li>
                	<li><a href="#">RSS</a></li>
                </ul>
            </div>
        	<div class="col-md-3 footer-ns animated fadeInRight">
            	<h4>Newsletter</h4>
                <p>A rover wearing a fuzzy suit doesn't alarm the real penguins</p>
                <p>
                    <div class="input-group">
                      <input type="text" class="form-control" placeholder="Search for...">
                      <span class="input-group-btn">
                        <button class="btn btn-default" type="button"><span class="glyphicon glyphicon-envelope"></span></button>
                      </span>
                    </div><!-- /input-group -->
                 </p>
            </div>
        </div>
    </footer>

</div>
</footer>

</body>
</html>