package modelo.control;

import modelo.hibernate.Articulo;

public class CarritoItem {
private Articulo articulo;
private int cantidad;

public CarritoItem(Articulo articulo, int cantidad) {
	this.articulo = articulo;
	this.cantidad = cantidad;
}


public CarritoItem() {
	// TODO Auto-generated constructor stub
}


public Articulo getArticulo() {
	return articulo;
}
public void setArticulo(Articulo articulo) {
	this.articulo = articulo;
}
public int getCantidad() {
	return cantidad;
}
public void setCantidad(int cantidad) {
	this.cantidad = cantidad;
}
}
