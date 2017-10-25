<!DOCTYPE html>
<%
  String baseJsp = (String)request.getAttribute("baseJsp");
  String error=(String)request.getAttribute("error");

%>
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
<header  STYLE="width:70%;margin:auto;text-align:center" class="p0">
<div style="padding-left:16px">
  <h2>DIGITALGAME e-SHOP</h2>
</div>
<div class="topnav" id="myTopnav">
<a style="cursor:pointer"   onclick="openNav()">&#9776;</a>
<a href="<%=baseJsp%>?action=irInicio">Home</a>
<a href="index-1.html">Juegos</a>
<a   href="<%=baseJsp%>?action=irLogin">Login</a>
<a href="<%=baseJsp%>?action=irRegistro">Registrarse</a>
<a href="javascript:void(0);" style="font-size:15px;" class="icon" onclick="myFunction()">&#9776;</a>
</div>
</header>
<div id="fondoL">
<div  style="margin:auto;padding:5%;width: 35%;border: 3px black thin; -webkit-box-shadow: 0px 0px 41px 18px white; border-radius:20px;background-color: white">
        
            <form   action="<%=baseJsp%>?action=botonLogin" method="POST">
                <h2>Iniciar Sesión</h2>
                <input type="text" class="input-block-level" placeholder="Email address" name="emailLogin" id='email' required>
                <input type="password" class="input-block-level" placeholder="Password" name="password" id="password" required>
                <label class="checkbox">
                    <input type="checkbox" value="remember-me" id="remember_me"> Remember me
                </label>
                <button  type="submit">Sign in</button><label style="display:inline;margin-left: 5px; "><a style="color: black" href="<%=baseJsp%>?action=irRegistro" >Registrate ahora!</a></label>
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


</body>
</html>