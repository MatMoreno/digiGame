
<!DOCTYPE html>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="java.util.HashMap,java.time.format.DateTimeFormatter ,modelo.control.CarritoItem,modelo.control.CompraItem,modelo.hibernate.Usuarios,modelo.hibernate.Articulo,modelo.hibernate.Genero, utils.HibernateUtils, org.hibernate.Session, java.util.ArrayList"%>
<%

	String baseJsp = (String) request.getAttribute("baseJsp");
	HttpSession sesion = request.getSession();
	if (sesion.getAttribute("usuarioLogueado") == null ){
		response.sendRedirect("/DigitalGame/servlet?action=irInicioLog");
	}
	HashMap<Integer, CarritoItem> carrito = (HashMap<Integer, CarritoItem>) sesion.getAttribute("carrito");
	int carritoSize=0;
	if(carrito!=null) carritoSize=carrito.size();
	HashMap<Integer,CompraItem> compras =(HashMap<Integer,CompraItem>)request.getAttribute("compras");
	
%>

<html>
<head>
<title>Home</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="Your description">
<meta name="keywords" content="Your keywords">
<meta name="author" content="Your name">

	<link rel="stylesheet" href="bootstrap/css/bootstrap.css" type="text/css"
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

	<header class="p0">
		<div style="padding-left: 16px">
			<h2>DIGITALGAME e-SHOP</h2>
		</div>
		<div class="topnav" id="myTopnav">
			<a style="cursor: pointer" onclick="openNav()">&#9776;</a>
			<a href="<%=baseJsp%>?action=irInicioLog">Home</a> <a
				href="<%=baseJsp%>?action=irArticulos">Catálogo</a> <a
				href="<%=baseJsp%>?action=irCuenta">Perfil de <%=(String) sesion.getAttribute("usuarioLogueado")%></a>
			<a id="numeroCarrito" href="<%=baseJsp%>?action=irCarrito">Carrito[<%=carritoSize %>]</a>
			<a href="<%=baseJsp%>?action=irMisCompras">Mis Compras</a>
			 <a
				href="<%=baseJsp%>?action=cerrarSesion">cerrar sesión</a>
			<a href="javascript:void(0);" style="font-size: 15px;" class="icon"
				onclick="myFunction()">&#9776;</a>
		</div>
	</header>



	<div style="overflow: auto; background: linear-gradient(to right, rgba(255, 255, 255, 1) 0, rgba(239, 239, 239, 1) 100%); margin: auto; width: 70%; padding-top: 2%">
		<h2 style="text-align: center;">Mis compras</h2>
		<legend></legend>
		<%
			if (request.getAttribute("compras") == null ) {
				
				
		%>
		<div
			style="margin: auto; width: 80%; height: 350px; overflow: hidden; margin-bottom: 5%">
			<p>No hay compras realizadas aún!<p>
		</div>
		<%
			
			}else{	
				pageContext.setAttribute("listCompras", compras);
		%>
		<div
			style="margin: auto; width: 80%;  overflow: hidden; margin-bottom: 5%;text-align: center">
			<c:forEach var="compra" items="${listCompras}"> 
			<div class="container" style="margin-bottom: 5%; ">
	<div class="row">
		
		    <div class="col-md-7">
		        <div class="history_wrapper">
		            
		            <div class="history_header">
		                <div class="history_header_product">
		                    Articulo
		                </div> 
		                 <div class="history_header_quantity">
		                    Cantidad
		                </div>   
		                 <div class="history_header_size">
		                    Precio
		                </div>  
		                 <div class="history_header_date">
		                    Fecha
		                </div>    
		            </div>
		            
		           
		              <div class="history_body">
		                    <div class="history_list">
		                        <div class="history_item_name">
		                        <c:forEach var="articulo" items="${compra.value.getArticulos()}" >
		                           <span class="item_name"> ${articulo.getArticulo().getNombre()} </span>
		                       </c:forEach>
		                        </div>
		                        
		                         <div class="history_item_quantity">
		                              <c:forEach var="articulo" items="${compra.value.getArticulos()}" >
	                                <span class="item_quantity">
	                                     ${articulo.getCantidad()}
	                                </span>
	                           </c:forEach>
	                                
		                         </div>
		                           <div class="history_item_size">
		                            <c:forEach var="articulo" items="${compra.value.getArticulos()}" >  
	                                <span class="item_size">
	                                  ${articulo.getArticulo().getPrecio()}&euro;
	                                </span>
	                           </c:forEach>
	                                
		                         </div>
		                         <div class="history_item_date">
		                             
	                                <span class="item_date">
	                                   ${compra.value.getFechaHora()}
	                                </span>
	                                
		                         </div>
		                      
		                         <div class="history_list_footer">
		                            
		                           <span class="label label-success">Recibido</span>
		                             <span class="histroy_total"><b>Total : </b>${compra.value.getPrecio()}&euro;</span>
		                         </div>
		                    </div>
		              </div>
		           
		            
		        </div>
		    </div>
		
	</div>
</div>
 </c:forEach>
	</div>
		<%
			
			}		
		%>
	
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
                        <li><a href="#">sobre nosotros</a></li>
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
                      <input style="height: 34px;" type="text" class="form-control" placeholder="Search for...">
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