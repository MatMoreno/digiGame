package modelo.hibernate;
// Generated 23-oct-2017 11:55:10 by Hibernate Tools 5.2.5.Final

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "compra")
public class Compra implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "codigo_compra")
	private int codigoCompra;
	@Column(name = "email_usuario")
	private String emailUsuario;
	@Column(name = "nombre_destino")
	private String nombreDestino;
	@Column(name = "email_destino")
	private String emailDestino;
	@Column(name = "fecha_hora")
	private LocalDateTime fechaHora;
	@Column(name = "tipo_tarjeta")
	private String tipo_tarjeta;
	@Column(name = "numero_tarjeta")
	private String numeroTarjeta;
	@Column(name = "pais")
	private String pais;
	@Column(name = "fecha_cad")
	private String fechaCaducidadTarjeta;

	public Compra(String emailUsuario, String emailDestino, String nombre,  LocalDateTime fechaHora, String tipo_tarjeta, String numeroTarjeta,
			String pais, String fechaCaducidadTarjeta) {
		super();
		this.nombreDestino = nombre;
		this.emailUsuario = emailUsuario;
		this.emailDestino=emailDestino;
		this.fechaHora = fechaHora;
		this.tipo_tarjeta = tipo_tarjeta;
		this.numeroTarjeta = numeroTarjeta;
		this.pais = pais;
		this.fechaCaducidadTarjeta = fechaCaducidadTarjeta;
	}
	public Compra() {
		
	}

	public int getCodigoCompra() {
		return this.codigoCompra;
	}

	public void setCodigoCompra(int codigoCompra) {
		this.codigoCompra = codigoCompra;
	}

	public String getNombre() {
		return nombreDestino;
	}

	public void setNombre(String nombre) {
		this.nombreDestino = nombre;
	}

	public String getEmailUsuario() {
		return this.emailUsuario;
	}

	public void setEmailUsuario(String emailUsuario) {
		this.emailUsuario = emailUsuario;
	}

	

	public LocalDateTime getFechaHora() {
		return fechaHora;
	}

	public void setFechaHora(LocalDateTime fechaHora) {
		this.fechaHora = fechaHora;
	}

	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}

	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}

	public String getPais() {
		return pais;
	}

	public void setPais(String pais) {
		this.pais = pais;
	}

	public String getTipo_tarjeta() {
		return tipo_tarjeta;
	}

	public void setTipo_tarjeta(String tipo_tarjeta) {
		this.tipo_tarjeta = tipo_tarjeta;
	}

	public String getFechaCaducidadTarjeta() {
		return fechaCaducidadTarjeta;
	}

	public void setFechaCaducidadTarjeta(String fechaCaducidadTarjeta) {
		this.fechaCaducidadTarjeta = fechaCaducidadTarjeta;
	}

}
