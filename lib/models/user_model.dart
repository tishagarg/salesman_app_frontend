class UserModel {
  final String id;
  final String nip;
  final String nama;
  final String role;

  UserModel({
    required this.id,
    required this.nip,
    required this.nama,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      nip: json['nip']?.toString() ?? '',
      nama: json['nama']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
    );
  }
}
