package controlador;

import modelo.control.CarritoItem;
import modelo.control.EnviarCorreo;
import modelo.hibernate.*;
import java.math.BigInteger;
import java.nio.file.Paths;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sun.util.calendar.LocalGregorianCalendar;
import utils.HibernateUtils;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Scanner;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.logging.Level;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

/**
 * Servlet implementation class servlet
 */
@MultipartConfig
public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void init(HttpServletRequest request) throws ServletException {
		listarGeneros(request);
		super.init();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public servlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		EnviarCorreo eC=new EnviarCorreo();
		eC.createAndSendEmail("matmoreno9@gmail.com", "oli", "hello");
		listarArticulos(request);
		listarGeneros(request);
		HttpSession sesion = request.getSession();
		String error = "false";
		String baseJsp = "/DigitalGame/servlet";
		request.setAttribute("baseJsp", baseJsp);
		String base = "/jsp/";
		String url = base + "inicioLog.jsp";
		String action = request.getParameter("action");
		if (action != null) {
			switch (action) {
			case "irInicioLog":
				url = base + "inicioLog.jsp";
				break;
			case "irArticulos":
				listarArticulos(request);
				url = base + "articulos.jsp";
				break;
			case "irArticulosAdmin":

				url = base + "articulosAdmin.jsp";
				break;
			case "irJuegoAdmin":
				request.setAttribute("articuloElegido", articuloPorCod(request));
				sesion.setAttribute("articuloE", articuloPorCod(request));
				url = base + "articulosAdmin.jsp";
				break;
			case "botonBorrarArticulo":
				Articulo articulo = (Articulo) sesion.getAttribute("articuloE");
				deleteArticulo(articulo);
				listarArticulos(request);
				url = base + "articulosAdmin.jsp";
				break;

			case "irModificaArticulo":
				request.setAttribute("articuloElegido", articuloPorCod(request));
				url = base + "modificaArticulos.jsp";
				break;
			case "botonModificaArticulo":
				updateArticulo(request);
				request.setAttribute("articuloElegido", articuloPorCod(request));
				url = base + "articulosAdmin.jsp";
				break;

			case "irAddArticulo":
				url = base + "addArticulo.jsp";
				break;
			case "addArticulo":
				if (addArticulo(request) == true) {
					imagen(request);
					response.sendRedirect("/DigitalGame/servlet?action=irArticulosAdmin");
					return;
				} else {
					response.sendRedirect("/DigitalGame/servlet?action=irAddArticulo&errorG=true");
					return;
				}

			case "irUsuariosAdmin":
				listarUsuarios(request);
				url = base + "usuariosAdmin.jsp";
				break;

			case "irCuenta":
				sesion.setAttribute("panelEdit", false);
				listarUsuarios(request);
				url = base + "perfil.jsp";
				break;
			case "irEditarPerfil":
				sesion.setAttribute("panelEdit", true);
				url = base + "perfil.jsp";
				break;

			case "updateUsuario":
				updateUsuario(request);
				sesion.setAttribute("panelEdit", false);
				url = base + "perfil.jsp";
				break;

			case "irInicio":
				url = base + "inicioLog.jsp";
				break;

			case "irLogin":
				url = base + "login.jsp";
				break;

			case "irPanelAdmin":
				url = base + "panelAdmin.jsp";
				break;

			case "irRegistro":

				url = base + "registro.jsp";
				break;

			case "cambiarNombreGenero":
				int codGenero = Integer.parseInt(request.getParameter("genero"));
				String nuevoNombre = request.getParameter("nuevoNombre");
				System.out.println(codGenero + " " + nuevoNombre);
				updateGenero(codGenero, nuevoNombre);
				response.sendRedirect("/DigitalGame/servlet?action=irModificarGeneros");
				return;

			case "irCambiarNombreGeneros":
				int genero = Integer.parseInt(request.getParameter("genero"));
				sesion.setAttribute("generoElegido", genero);

				url = base + "modificaGeneros.jsp";
				break;
			case "irModificarGeneros":

				url = base + "modificaGeneros.jsp";
				break;

			case "botonLogin":
				error = "false";
				String emailCaja = request.getParameter("emailLogin");
				String passCaja = request.getParameter("password");
				// System.out.println(emailCaja + "---" + passCaja);
				if (usuarioEnLista(request) == emailCaja) {

					sesion.setAttribute("emailLogueado", emailCaja);
					String nombreLog = listarUsuarios(request).get(emailCaja).getNombre();
					int admin = listarUsuarios(request).get(emailCaja).getAdmin();
					sesion.setAttribute("codAdmin", admin);
					sesion.setAttribute("usuarioLogueado", nombreLog);
					if ((Integer) sesion.getAttribute("isAdmin") == 1) {
						url = base + "panelAdmin.jsp";
					} else
						url = base + "inicioLog.jsp";
				} else {
					url = base + "login.jsp";
					error = "true";
				}

				break;
			case "cerrarSesion":
				sesion.invalidate();
				url = base + "inicioLog.jsp";
				break;

			case "botonRegistro":
				if (addUsuario(request) == true) {
					url = base + "inicioLog.jsp";

				} else {
					sesion.setAttribute("errorReg", "1");
					url = base + "registro.jsp";
				}

				break;

			case "irJuego":
				request.setAttribute("articuloElegido", articuloPorCod(request));
				url = base + "articulos.jsp";
				break;
			case "irGenero":
				ArrayList<Articulo> listaPorGenero = listarArticulosPorGenero(request);
				request.setAttribute("articuloGenero", listaPorGenero);
				url = base + "articulos.jsp";
				break;
			case "irCarrito":
				url = base + "carrito.jsp";
				break;
			case "addToCarrito":
				HashMap<Integer,CarritoItem> cart = addToCarrito(request);
				sesion.setAttribute("carrito", cart);
				System.out.println(cart.toString());
				url = base + "carrito.jsp";
				break;
			case "deleteItemCarrito":
				
				url = base + "carrito.jsp";
				break;

			default:
				break;
			}
		}
		request.setAttribute("error", error);
		request.getRequestDispatcher(url).forward(request, response);
		;
	}

	public HashMap<String, Usuarios> listarUsuarios(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		HashMap<String, Usuarios> map = new HashMap<>();
		@SuppressWarnings("unchecked")
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib.createQuery("from Usuarios").list();
		for (int i = 0; i < lista.size(); i++) {
			map.put(lista.get(i).getEmailUsuario(),
					new Usuarios(lista.get(i).getEmailUsuario(), lista.get(i).getNombre(), lista.get(i).getApellidos(),
							lista.get(i).getContrasena(), lista.get(i).getFechaDeNac(), lista.get(i).getAdmin()));
		}
		HttpSession sesion = request.getSession();
		sesion.setAttribute("mapUsuarios", map);
		return map;

	}

	public void updateUsuario(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		HttpSession sesion = request.getSession();
		Usuarios user = sesionHib.get(Usuarios.class, (String) sesion.getAttribute("emailLogueado"));
		String pass = user.getContrasena();
		/* Arreglar si contraseña esta en la base de datos */
		if (request.getParameter("passUpdate1") != null && request.getParameter("passUpdate2") != null) {
			pass = passMD5(request.getParameter("passUpdate2"));
		}
		System.out.println(pass);
		String nombre = request.getParameter("nombreUpdate");
		String apellidos = request.getParameter("apellidosUpdate");
		/* String email = request.getParameter("correoUpdate"); */

		try {
			String fechaUp = request.getParameter("fechaUpdate");
			System.out.println(fechaUp);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date fecha;

			fecha = (Date) formatter.parse(fechaUp);

			user.setNombre(nombre);
			sesion.setAttribute("usuarioLogueado", nombre);
			user.setApellidos(apellidos);
			user.setFechaDeNac(fecha.toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
			user.setContrasena(pass);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sesionHib.beginTransaction();
		sesionHib.update(user);
		sesionHib.getTransaction().commit();
		sesionHib.close();
	}

	public boolean addUsuario(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		String nombre = request.getParameter("nombreReg");
		String apellidos = request.getParameter("apellidosReg");
		String email = request.getParameter("correoReg");
		String pass = request.getParameter("passReg");
		String fechaReg = request.getParameter("fechaReg");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate fechaNueva = null;
		try {
			Date fecha = (Date) formatter.parse(fechaReg);
			fechaNueva = fecha.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

			// FECHA PASADA DE date "YYYY-MM-DD" A "DD-MM-YYYY"
			/*
			 * SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy"); Date
			 * fecha2=formatter2.parse(formatter.format(fecha)); String fechaBien
			 * =formatter2.format(fecha2);
			 */

		} catch (ParseException e) {
			e.printStackTrace();
		}
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib
				.createQuery("from Usuarios where emailUsuario='" + email + "'").list();

		if (lista.size() == 0) {
			Usuarios user = new Usuarios(email, nombre, apellidos, passMD5(pass), fechaNueva, 0);
			sesionHib.beginTransaction();
			sesionHib.save(user);
			HttpSession sesion = request.getSession();
			sesion.setAttribute("usuarioLogueado", nombre);
			sesion.setAttribute("emailLogueado", email);
			sesion.setAttribute("isAdmin", 0);

			sesionHib.getTransaction().commit();
			sesionHib.close();
			return true;
		} else
			return false;

	}

	public String usuarioEnLista(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		String email = request.getParameter("emailLogin");
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib.createQuery("from Usuarios where emailUsuario='"
				+ email + "' and contrasena=md5('" + request.getParameter("password") + "')").list();

		if (lista.size() != 0) {
			sesion.setAttribute("isAdmin", lista.get(0).getAdmin());
			sesion.setAttribute("infoUsuario", lista);
			return email;

		} else {

			sesionHib.close();

			return "";
		}
	}

	public void listarArticulos(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Articulo> lista = (ArrayList<Articulo>) sesionHib.createQuery("from Articulo").list();
		request.setAttribute("arrayJuegos", lista);

	}

	public Articulo articuloPorCod(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		Articulo articulo = (Articulo) sesionHib.get(Articulo.class, Integer.parseInt(request.getParameter("idProd")));
		return articulo;
	}

	public void listarGeneros(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Genero> lista = (ArrayList<Genero>) sesionHib.createQuery("from Genero").list();
		request.setAttribute("arrayGenero", lista);

	}

	public ArrayList<Articulo> listarArticulosPorGenero(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Articulo> lista = (ArrayList<Articulo>) sesionHib
				.createQuery("from Articulo where codigoGenero=" + request.getParameter("idGen")).list();
		return lista;
	}

	public void updateGenero(int codGenero, String nuevoNombre) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		Genero genero = sesionHib.get(Genero.class, codGenero);
		genero.setNombre(nuevoNombre);
		sesionHib.beginTransaction();
		sesionHib.update(genero);
		sesionHib.getTransaction().commit();
		sesionHib.close();
	}

	public void deleteUsuario(String emailUsuario) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		Usuarios user = sesionHib.get(Usuarios.class, emailUsuario);
		sesionHib.beginTransaction();
		sesionHib.delete(user);
		sesionHib.getTransaction().commit();
		sesionHib.close();

	}

	public void deleteArticulo(Articulo articulo) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		sesionHib.beginTransaction();
		sesionHib.delete(articulo);
		sesionHib.getTransaction().commit();
		sesionHib.close();
	}

	public String passMD5(String input) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] messageDigest = md.digest(input.getBytes());
			BigInteger number = new BigInteger(1, messageDigest);
			String hashtext = number.toString(16);

			while (hashtext.length() < 32) {
				hashtext = "0" + hashtext;
			}
			return hashtext;
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e);
		}
	}

	public boolean addArticulo(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();

		String nombre = request.getParameter("nombreAdd");
		String plataforma = request.getParameter("plataformaAdd");
		int stock = Integer.parseInt(request.getParameter("stockAdd"));
		String info = request.getParameter("infoAdd");
		float precio = Float.parseFloat(request.getParameter("precioAdd"));
		int genero = Integer.parseInt(request.getParameter("generoAdd"));
		int clave = Integer.parseInt(request.getParameter("claveAdd"));
		String fechaLanz = request.getParameter("fechaAdd");
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		LocalDate fechaNueva = null;
		try {
			Date fecha = (Date) formatter.parse(fechaLanz);
			fechaNueva = fecha.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		} catch (ParseException e) {
			e.printStackTrace();
		}
		@SuppressWarnings("unchecked")
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib
				.createQuery("from Articulo where nombre='" + nombre + "'").list();
		if (lista.size() == 0) {
			Articulo articulo = new Articulo(nombre, genero, plataforma, fechaNueva, info, stock, clave, precio);
			sesionHib.beginTransaction();
			sesionHib.save(articulo);
			HttpSession sesion = request.getSession();
			sesionHib.getTransaction().commit();
			sesionHib.close();
			System.out.println(articulo.getCodigoArticulo());
			sesion.setAttribute("idProdNuevo", articulo.getCodigoArticulo());

			return true;
		} else {
			return false;
		}
	}

	public void updateArticulo(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		int idProd = Integer.parseInt(request.getParameter("idProd"));
		System.out.println(" ds" + idProd);
		Articulo articulo = sesionHib.get(Articulo.class, idProd);
		/* Arreglar si contraseña esta en la base de datos */
		String nombre = request.getParameter("nombreU");
		String plataforma = request.getParameter("plataformaU");
		int stock = Integer.parseInt(request.getParameter("stockU"));
		String info = request.getParameter("infoU");
		float precio = Float.parseFloat(request.getParameter("precioU"));
		int genero = Integer.parseInt(request.getParameter("generoU"));
		try {
			String fechaUp = request.getParameter("fechaU");
			System.out.println(fechaUp);
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			Date fecha;
			fecha = (Date) formatter.parse(fechaUp);
			articulo.setNombre(nombre);
			articulo.setPlataforma(plataforma);
			articulo.setInformacionAdicional(info);
			articulo.setCodigoGenero(genero);
			articulo.setPrecio(precio);
			articulo.setFechaDeLanzamiento(fecha.toInstant().atZone(ZoneId.systemDefault()).toLocalDate());
			articulo.setStock(stock);
			imagen(request);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		sesionHib.beginTransaction();
		sesionHib.update(articulo);
		sesionHib.getTransaction().commit();
		sesionHib.close();
	}

	public HashMap<Integer,CarritoItem> addToCarrito(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		HashMap<Integer,CarritoItem> carrito = (HashMap<Integer,CarritoItem>) sesion.getAttribute("carrito");
		if (sesion.getAttribute("carrito") == null) {
			carrito = new HashMap<Integer,CarritoItem>();
		}
		int codProducto = Integer.parseInt(request.getParameter("addIdProd"));
		Articulo articulo = sesionHib.get(Articulo.class, codProducto);
		int cantidad = Integer.parseInt(request.getParameter("cantidad"));
		CarritoItem item = new CarritoItem();
if(carrito.containsKey(articulo.getCodigoArticulo())) {
	item.setArticulo(articulo);
	item.setCantidad(carrito.get(articulo.getCodigoArticulo()).getCantidad()+1);
	carrito.put(item.getArticulo().getCodigoArticulo(), item);
	return carrito;
		}
	
		item.setArticulo(articulo);
		item.setCantidad(cantidad);
		carrito.put(item.getArticulo().getCodigoArticulo(), item);
		return carrito;

	}
	public void updateCarrito(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		HashMap<Integer,CarritoItem> carrito = (HashMap<Integer,CarritoItem>) sesion.getAttribute("carrito");
		try {
			int codigo=Integer.parseInt(request.getParameter("codigo"));
			int cantidad=Integer.parseInt(request.getParameter("cantidadItem"));
			CarritoItem item = carrito.get(codigo);
			if (item != null) {
				item.setCantidad(cantidad);

			}
		} catch (Exception e) {
			// out.println("Error updating shopping cart!");
		}
		
		
	}

	public void imagen(HttpServletRequest request) {
		HttpSession sesion = request.getSession();
		String nombre = "default.jpg";
		Part file = null;
		try {
			if (sesion.getAttribute("idProdNuevo") != null) {
				System.out.println("IDPRODNUEVO");
				nombre = sesion.getAttribute("idProdNuevo") + ".jpg";
				file = request.getPart("imagenAdd");

			} else {
				file = request.getPart("imagenU");
				nombre = request.getParameter("idProd") + ".jpg";
			}

			InputStream is = file.getInputStream();
			File directorio = new File("C:\\Users\\alumno_m\\git\\digiGame\\WebContent\\img\\imgArticulos\\" + nombre);
			FileOutputStream os = new FileOutputStream(directorio);
			int dato = is.read();
			while (dato != -1) {
				os.write(dato);
				dato = is.read();
			}
			os.close();
			is.close();
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}