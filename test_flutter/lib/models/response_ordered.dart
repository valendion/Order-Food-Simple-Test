class ResponseOrdered {
  String nominalDiskon;
  String nominalPesanan;
  List<Items> items;

  ResponseOrdered(
      {required this.nominalDiskon,
      required this.nominalPesanan,
      required this.items});

  factory ResponseOrdered.fromJson(Map<String, dynamic> json) {
    return ResponseOrdered(
        nominalDiskon: json['nominal_diskon'],
        nominalPesanan: json['nominal_pesanan'],
        items: List<Items>.from(json['items'].map((item) {
          return Items.fromJson(item);
        })));
  }

  Map<String, dynamic> toJson() {
    return {
      'nominal_diskon': nominalDiskon,
      'nominal_pesanan': nominalPesanan,
      'items': items
    };
  }
}

class Items {
  int id;
  int harga;
  String catatan;

  Items({required this.id, required this.harga, required this.catatan});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
        id: json['id'], harga: json['harga'], catatan: json['catatan']);
  }

  // Map<String, dynamic> toJson(){
  //   final data = Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['harga'] = this.harga;
  //   data['catatan'] = this.catatan;
  //   return data;
  // }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'harga': this.harga,
      'catatan': this.catatan.toString()
    };
  }
}
