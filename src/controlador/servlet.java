package controlador;

import modelo.hibernate.*;
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
		listarArticulos(request);
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
				String emailCaja = request.getParameter("emailLogin");
				String passCaja = request.getParameter("password");
				//System.out.println(emailCaja + "---" + passCaja);
				if (usuarioEnLista(request) == emailCaja) {
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
				if(añadirUsuario(request)==true) {
					url = base + "inicioLog.jsp";
				}else {
					url = base + "registro.jsp";
				}
		
				break;
			
			case "irJuego":
		request.setAttribute("articuloElegido", articuloPorCod(request));
				
				url = base + "articulos.jsp";
				break;
			case "irGenero":
				ArrayList<Articulo> listaPorGenero=listarArticulosPorGenero(request);
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
	public boolean añadirUsuario(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
	   
	    String nombre=request.getParameter("nombreReg");
	    String apellidos=request.getParameter("apellidosReg");
	    String email=request.getParameter("correoReg");
	    String pass=request.getParameter("passReg");
	    String fechaReg=request.getParameter("fechaReg");
	   // System.out.println(nombre+" "+apellidos+" "+email+" "+pass+" "+fechaReg);
	    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	    LocalDate fechaNueva = null;
	    try {
	    Date fecha = (Date) formatter.parse(fechaReg);
	    fechaNueva = fecha.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            
            //FECHA PASADA DE  date "YYYY-MM-DD" A  "DD-MM-YYYY"
            /* SimpleDateFormat formatter2 = new SimpleDateFormat("dd-MM-yyyy");
               Date fecha2=formatter2.parse(formatter.format(fecha));
            String fechaBien =formatter2.format(fecha2);*/

        } catch (ParseException e) {
            e.printStackTrace();
        }
	   //se inserta en lista si email no existe en la base de datos
	    if(usuarioEnLista(request)=="") {
	    	Usuarios user=new Usuarios(email,nombre,apellidos,pass,fechaNueva, 0); 
	    	sesionHib.save(user);
	    	HttpSession sesion = request.getSession();
			sesion.setAttribute("usuarioLogueado", nombre);
	    	 sesionHib.beginTransaction();
	    	 sesionHib.getTransaction().commit();
	    	 sesionHib.close();
	    	 return true;
	    } else
	    return false;
	    
	}
	public String usuarioEnLista(HttpServletRequest request) {

		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		@SuppressWarnings("unchecked")
		String email=request.getParameter("emailLogin");
		ArrayList<Usuarios> lista = (ArrayList<Usuarios>) sesionHib.createQuery("from Usuarios where emailUsuario='" + email + "'").list();
		if (lista.size() != 0) {
			String contra = lista.get(0).getContrasena();
			if (request.getParameter("password").equals(contra)) {
				HttpSession sesion = request.getSession(true);
				sesion.setAttribute("infoUsuario", lista);
				return email;
			}
		}
		sesionHib.close();

		return "";
	}
	public void listarArticulos(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Articulo> lista = (ArrayList<Articulo>) sesionHib.createQuery("from Articulo").list();
		request.setAttribute("arrayJuegos", lista);
		
		
	}
	public Articulo articuloPorCod(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		Articulo user=(Articulo)sesionHib.get(Articulo.class,Integer.parseInt(request.getParameter("idProd")));
		return user;
	}
	
	

	public void listarGeneros(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Genero> lista = (ArrayList<Genero>) sesionHib.createQuery("from Genero").list();
		request.setAttribute("arrayGenero", lista);

	}
	public ArrayList<Articulo> listarArticulosPorGenero(HttpServletRequest request) {
		Session sesionHib = HibernateUtils.getSessionFactory().openSession();
		ArrayList<Articulo> lista = (ArrayList<Articulo>) sesionHib.createQuery("from Articulo where codigoGenero="+request.getParameter("idGen")).list();
		return lista;
	}
	

}
