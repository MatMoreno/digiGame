package modelo.hibernate;
// Generated 23-oct-2017 11:55:10 by Hibernate Tools 5.2.5.Final

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Usuarios generated by hbm2java
 */
@Entity
@Table(name="usuarios")
public class Usuarios implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	@Id
	@Column(name="email_usuario")
	private String emailUsuario;
	@Column(name="nombre")
	private String nombre;
	@Column(name="apellidos")
	private String apellidos;
	@Column(name="contrasena")
	private String contrasena;
	@Column(name="fecha_de_nac")
	private Date fechaDeNac;
	@Column(name="admin")
	private int admin;
	public Usuarios() {
	}

	public Usuarios(String emailUsuario, String nombre, String apellidos, String contrasena, Date fechaDeNac,
			int admin) {
		this.emailUsuario = emailUsuario;
		this.nombre = nombre;
		this.apellidos = apellidos;
		this.contrasena = contrasena;
		this.fechaDeNac = fechaDeNac;
		this.admin = admin;
	}

	public String getEmailUsuario() {
		return this.emailUsuario;
	}

	public void setEmailUsuario(String emailUsuario) {
		this.emailUsuario = emailUsuario;
	}

	public String getNombre() {
		return this.nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getApellidos() {
		return this.apellidos;
	}

	public void setApellidos(String apellidos) {
		this.apellidos = apellidos;
	}

	public String getContrasena() {
		return this.contrasena;
	}

	public void setContrasena(String contrasena) {
		this.contrasena = contrasena;
	}

	public Date getFechaDeNac() {
		return this.fechaDeNac;
	}

	public void setFechaDeNac(Date fechaDeNac) {
		this.fechaDeNac = fechaDeNac;
	}

	public int isAdmin() {
		return this.admin;
	}

	public void setAdmin(int admin) {
		this.admin = admin;
	}

}