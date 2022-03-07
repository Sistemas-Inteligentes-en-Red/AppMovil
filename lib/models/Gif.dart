class Gif {
  int id;
  String ruta;
  double tiempo;
  double distancia = null;
  String fecha;
  int visit;

  Gif(id, ruta, tiempo, distancia, fecha, visit) {
    this.id = id;
    this.ruta = ruta;
    this.tiempo = tiempo;
    //this.distancia = distancia;
    this.fecha = fecha;
    this.visit = visit;
  }
}
