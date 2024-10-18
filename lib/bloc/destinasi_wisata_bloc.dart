import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pariwisata/helpers/api.dart';
import 'package:pariwisata/helpers/api_url.dart';
import 'package:pariwisata/model/destinasi_wisata.dart';

class DestinasiWisataBloc {
  // Mendapatkan daftar destinasi wisata
  static Future<List<DestinasiWisata>> getDestinasiWisata() async {
    String apiUrl = ApiUrl.listDestinasi;

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        var jsonObj = json.decode(response.body);
        List<dynamic> listDestinasiWisata = (jsonObj as Map<String, dynamic>)['data'];
        return listDestinasiWisata.map((item) => DestinasiWisata.fromJson(item)).toList();
      } else {
        var errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to load destinasi wisata');
      }
    } catch (e) {
      throw Exception('Failed to fetch destinasi wisata: $e');
    }
  }

  // Menambahkan destinasi wisata
  static Future<bool> addDestinasiWisata({required DestinasiWisata destinasi}) async {
    String apiUrl = ApiUrl.createDestinasi;
    var body = json.encode(destinasi.toMap());

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Mengizinkan status code 200 atau 201 (Created)
      if (response.statusCode == 200 || response.statusCode == 201) {
        var jsonObj = json.decode(response.body);
        return jsonObj['status']; 
      } else {
        var errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to add destinasi wisata');
      }
    } catch (e) {
      throw Exception('Failed to add destinasi wisata: $e');
    }
  }

  // Memperbarui destinasi wisata
  static Future<bool> updateDestinasiWisata({required DestinasiWisata destinasi}) async {
    String apiUrl = ApiUrl.updateDestinasi(destinasi.id!);
    var body = json.encode(destinasi.toMap());

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // Mengizinkan status code 200 atau 204 (No Content)
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Jika status 204, tidak ada konten untuk diparsing
        if (response.statusCode == 200) {
          var jsonObj = json.decode(response.body);
          return jsonObj['status'];
        }
        return true; // 204 dianggap sukses tanpa body
      } else {
        var errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to update destinasi wisata');
      }
    } catch (e) {
      throw Exception('Failed to update destinasi wisata: $e');
    }
  }

  // Menghapus destinasi wisata
  static Future<bool> deleteDestinasiWisata({required int id}) async {
    String apiUrl = ApiUrl.deleteDestinasi(id);

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      // Mengizinkan status 200 atau 204
      if (response.statusCode == 200 || response.statusCode == 204) {
        // Tidak ada konten pada 204
        if (response.statusCode == 200) {
          var jsonObj = json.decode(response.body);
          return jsonObj['status'];
        }
        return true;
      } else {
        var errorResponse = json.decode(response.body);
        throw Exception(errorResponse['message'] ?? 'Failed to delete destinasi wisata');
      }
    } catch (e) {
      throw Exception('Failed to delete destinasi wisata: $e');
    }
  }
}
