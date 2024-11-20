import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:perpus/bottom_nav.dart';
import 'package:perpus/modal.dart';
import 'package:perpus/perpus.dart';
import 'package:perpus/perpus_controllers.dart';

class EbookView extends StatefulWidget {
  EbookView({super.key});

  @override
  State<EbookView> createState() => _EbookViewState();
}

class _EbookViewState extends State<EbookView> {
  final PerpusControllers perpusController = PerpusControllers();
  TextEditingController IdInput = TextEditingController();
  TextEditingController JudulInput = TextEditingController();
  TextEditingController CoverInput = TextEditingController();
  TextEditingController Rating = TextEditingController();
  TextEditingController SinopsisInput = TextEditingController();
  TextEditingController StockInput = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ModalWidget modal = ModalWidget();

  List<Perpus>? buku;

  @override
  void initState() {
    super.initState();
    getFilm();
  }

  void getFilm() {
    setState(() {
      buku = perpusController.perpus;
    });
  }

  void addFilm(Perpus data) {
    buku!.add(data);
    getFilm();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Perpus"),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              JudulInput.clear();
              CoverInput.clear();
              Rating.clear();
              SinopsisInput.clear();
              StockInput.clear();
              modal.showFullModal(context, fromTambah(null));
            },
            icon: Icon(Icons.add_sharp),
          ),
        ],
      ),
      body: buku != null && buku!.isNotEmpty
          ? Padding(
              padding: EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 10,
                    childAspectRatio: 3 / 5),
                itemCount: buku!.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[350],
                    child: Container(
                      height: 200,
                      width: 100,
                      child: Column(
                        children: [
                          Text(
                            buku![index].id.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          Padding(padding: EdgeInsets.all(10)),
                          Image(
                            image: AssetImage(buku![index].Cover),
                            width: 200,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            buku![index].Judul,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(buku![index].Sinopsis),
                          SizedBox(
                            height: 20,
                          ),
                          RatingBar.builder(
                            minRating: 0,
                            maxRating: 5,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                buku![index].Rating = rating;
                              });
                            },
                          ),
                          Text('Stock : ' + buku![index].Stock.toString()),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(child: Text("Data Kosong")),
      bottomNavigationBar: BottomNav(2),
    );
  }

  Widget fromTambah(index) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
              controller: IdInput,
              decoration: InputDecoration(label: Text('ID')),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'harus diisi';
                }
                return null;
              }),
          TextFormField(
            controller: JudulInput,
            decoration: InputDecoration(label: Text("Title")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              }
              return null;
            },
          ),
          TextFormField(
            controller: CoverInput,
            decoration: InputDecoration(label: Text("Gambar")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              }
              return null;
            },
          ),
          RatingBar.builder(
            minRating: 0,
            maxRating: 5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              Rating.text = rating.toString();
            },
          ),
          TextFormField(
            controller: SinopsisInput,
            decoration: InputDecoration(label: Text("Sinopsis")),
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              }
              return null;
            },
          ),
          TextFormField(
            controller: StockInput,
            decoration: InputDecoration(label: Text("Stock")),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value!.isEmpty) {
                return 'harus diisi';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                double ratingValue = double.parse(Rating.text);
                if (ratingValue < 0 || ratingValue > 5) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Rating harus antara 0 hingga 5')),
                  );
                  return;
                }

                if (index != null) {
                  buku![index].id = int.parse(IdInput.text);
                  buku![index].Judul = JudulInput.text;
                  buku![index].Cover = CoverInput.text;
                  buku![index].Rating = ratingValue;
                  buku![index].Sinopsis = SinopsisInput.text;
                  buku![index].Stock = int.parse(StockInput.text);
                } else {
                  Perpus data = Perpus(
                    id: buku!.length + 1,
                    Judul: JudulInput.text,
                    Cover: CoverInput.text,
                    Rating: ratingValue,
                    Sinopsis: SinopsisInput.text,
                    Stock: int.parse(StockInput.text),
                  );
                  addFilm(data);
                }
                Navigator.pop(context);
              }
            },
            child: Text("Simpan"),
          ),
        ],
      ),
    );
  }
}
