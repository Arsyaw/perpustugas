class Perpus {
  int id;
  String Judul;
  double? Rating;
  String Cover;
  String Sinopsis;
  int Stock;
  Perpus({
    required this.id,
    required this.Judul,
    this.Rating,
    required this.Cover,
    required this.Sinopsis,
    required this.Stock,
  });
}
