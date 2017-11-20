package modelo.control;
import java.time.LocalDateTime;
import java.util.ArrayList;

import modelo.hibernate.Articulo;

public class CompraItem {
private ArrayList<CarritoItem> articulos;
private LocalDateTime fechaHora;
private int codigoCompra;
private float precio;

public CompraItem(ArrayList<CarritoItem> articulos, LocalDateTime fechaHora, int codigoCompra,
		float precio) {
	super();
	this.articulos = articulos;
	this.fechaHora = fechaHora;
	this.codigoCompra = codigoCompra;
	this.precio = precio;
}

public CompraItem() {
	super();
	// TODO Auto-generated constructor stub
}

public ArrayList<CarritoItem> getArticulos() {
	return articulos;
}
public void setArticulos(ArrayList<CarritoItem> articulos) {
	this.articulos = articulos;
}

public LocalDateTime getFechaHora() {
	return fechaHora;
}
public void setFechaHora(LocalDateTime fechaHora) {
	this.fechaHora = fechaHora;
}
public int getCodigoCompra() {
	return codigoCompra;
}
public void setCodigoCompra(int codigoCompra) {
	this.codigoCompra = codigoCompra;
}
public float getPrecio() {
	return precio;
}
public void setPrecio(float precio) {
	this.precio = precio;
}
}
