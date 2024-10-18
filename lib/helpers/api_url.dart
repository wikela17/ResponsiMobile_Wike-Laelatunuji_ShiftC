class ApiUrl {
  static const String baseUrl = 'http://responsi.webwizards.my.id/api'; // Base URL untuk API
  static const String registrasi = baseUrl + '/registrasi'; // Endpoint untuk registrasi
  static const String login = baseUrl + '/login'; // Endpoint untuk login
  static const String listDestinasi = baseUrl + '/pariwisata/destinasi_wisata'; // Endpoint untuk daftar catatan kehamilan
  static const String createDestinasi = baseUrl + '/pariwisata/destinasi_wisata'; // Endpoint untuk menambahkan catatan kehamilan

  static String updateDestinasi(int id) {
    return '$baseUrl/pariwisata/destinasi_wisata/$id/update'; // Endpoint untuk memperbarui catatan kehamilan
  }

  static String showDestinasi(int id) {
    return '$baseUrl/pariwisata/destinasi_wisata/$id'; // Endpoint untuk menampilkan catatan kehamilan
  }

  static String deleteDestinasi(int id) {
    return '$baseUrl/pariwisata/destinasi_wisata/$id/delete'; // Endpoint untuk menghapus catatan kehamilan
  }
}