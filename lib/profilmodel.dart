class Profil {
  int id;
  String username;
  String nama;
  String alamat;
  String kota;
  String telp;

  Profil(
      {this.id, this.username, this.nama, this.alamat, this.kota, this.telp});

  factory Profil.fromMap(Map<String, dynamic> map) {
    return Profil(
      id: map['id'],
      username: map['username'],
      nama: map['nama'],
      alamat: map['alamat'],
      kota: map['kota'],
      telp: map['telp'],
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this.id;
    map['username'] = username;
    map['nama'] = nama;
    map['alamat'] = alamat;
    map['kota'] = kota;
    map['telp'] = telp;
    return map;
  }
}
