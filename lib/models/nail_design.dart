
class NailDesign {

  int imageId;
  double price;

  NailDesign({
    required this.imageId,
    required this.price
  });

  void setPriceFromAPI(double price) {
    this.price = price;
  }

  /* Modificar clase para asegurar la integridad de los datos */
}