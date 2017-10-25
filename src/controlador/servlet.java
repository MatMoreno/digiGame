package controlador;

import modelo.hibernate.*;
import utils.HibernateUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		listarGeneros(request);
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
				url = base + "articulos.jsp";
				break;
			case "irCuenta":
				listarUsuarios(request);
				url = base + "perfil.jsp";
				break;
			case "irInicio":
				url = base + "inicioLog.jsp";
				break;
			case "irLogin":
				url = base + "login.jsp";
				break;
			case "irRegistro":
				url = base + "registro.jsp";
				break;

			case "botonLogin":
				error = "false";
				String emailCaja = request.getParameter("email");
				String passCaja = request.getParameter("password");
				System.out.println(emailCaja + "---" + passCaja);

				if (usuarioEnLista(request) == true) {
					HttpSession sesion = request.getSession();
					sesion.setAttribute("emailLogueado", emailCaja);
					String nombreLog=listarUsuarios(request).get(emailCaja).getNombre();
					sesion.setAttribute("usuarioLogueado", nombreLog);
					url = base + "inicioLog.jsp";
				} else {
					url = base + "login.jsp";
					error = "true";
				}

				break;
			case "cerrarSesion":
				HttpSession sesion = request.getSession();
				sesion.invalidate();
				url = base + "inicioLog.jsp";
				break;
			case "botonRegistro":
				url = base + "registro.jsp";
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
		HashMap<String,Usuarios> map=new HashMap<>();
		@SuppressWarnings("unchecked")
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib.createQuery("from Usuarios").list();
		for (int i = 0; i < lista.size(); i++) {
			map.put(lista.get(i).getEmailUsuario(), new Usuarios(lista.get(i).getEmailUsuario(),lista.get(i).getNombre(),lista.get(i).getApellidos(),lista.get(i).getContrasena(),lista.get(i).getFechaDeNac(),lista.get(i).isAdmin()));
		}
		HttpSession sesion = request.getSession();
		sesion.setAttribute("mapUsuarios", map);
		return map; 
			
		
		
	}
	public boolean usuarioEnLista(HttpServletRequest request) {

		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib.createQuery("from Usuarios where emailUsuario='" + request.getParameter("email") + "'").list();
		if (lista.size() != 0) {
			String contra = lista.get(0).getContrasena();
			if (request.getParameter("password").equals(contra)) {
				HttpSession sesion = request.getSession(true);
				sesion.setAttribute("infoUsuario", lista);
				return true;
			}
		}
		sesionHib.close();

		return false;
	}

	public void listarGeneros(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Genero> lista = (ArrayList<Genero>) sesionHib.createQuery("from Genero").list();
		request.setAttribute("arrayGenero", lista);

	}

}
