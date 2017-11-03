package controlador;

import modelo.hibernate.*;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import sun.util.calendar.LocalGregorianCalendar;
import utils.HibernateUtils;

import java.io.IOException;
import java.util.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Session;

import jdk.nashorn.internal.ir.RuntimeNode.Request;

/**
 * Servlet implementation class servlet
 */

public class servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	Usuarios user;

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
				listarArticulos(request);
				url = base + "articulosAdmin.jsp";
				break;
			case "irJuegoAdmin":
				request.setAttribute("articuloElegido", articuloPorCod(request));
				sesion.setAttribute("articuloE",articuloPorCod(request));
				url = base + "articulosAdmin.jsp";
				break;
			case "botonBorrarArticulo":
				//mirar
				Articulo articulo = (Articulo) sesion.getAttribute("articuloE");
				deleteArticulo(articulo);
				url = base + "articulosAdmin.jsp";
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
					int admin = listarUsuarios(request).get(emailCaja).isAdmin();
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
				if (añadirUsuario(request) == true) {
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
							lista.get(i).getContrasena(), lista.get(i).getFechaDeNac(), lista.get(i).isAdmin()));
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

	public boolean añadirUsuario(HttpServletRequest request) {
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
			sesion.setAttribute("isAdmin", lista.get(0).isAdmin());
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

}
