import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/logout_bloc.dart';
import 'package:pariwisata/bloc/destinasi_wisata_bloc.dart'; // Ensure you have this bloc for destinasi
import 'package:pariwisata/model/destinasi_wisata.dart'; // Make sure to import the correct model
import 'package:pariwisata/ui/login_page.dart';
import 'package:pariwisata/ui/destinasi_wisata_detail.dart'; // Create a detail page for destinasi
import 'package:pariwisata/ui/destinasi_wisata_form.dart'; // Create a form page for destinasi

class DestinasiWisataPage extends StatefulWidget {
  const DestinasiWisataPage({Key? key}) : super(key: key);

  @override
  _DestinasiPageState createState() => _DestinasiPageState();
}

class _DestinasiPageState extends State<DestinasiWisataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Destinasi Wisata'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: const Icon(Icons.add, size: 26.0),
              onTap: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DestinasiWisataForm()));
              },
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Logout'),
              trailing: const Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => LoginPage()),
                          (route) => false)
                    });
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder<List<DestinasiWisata>>(
        future: DestinasiWisataBloc.getDestinasiWisata(), // Ensure you have this method in the bloc
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListDestinasi(list: snapshot.data)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListDestinasi extends StatelessWidget {
  final List<DestinasiWisata>? list;

  const ListDestinasi({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list!.length,
      itemBuilder: (context, i) {
        return ItemDestinasi(destinasi: list![i]);
      },
    );
  }
}

class ItemDestinasi extends StatelessWidget {
  final DestinasiWisata destinasi;

  const ItemDestinasi({Key? key, required this.destinasi}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinasiWisataDetail(destinasiWisata: destinasi), // Make sure you have this detail page
          ),
        );
      },
      child: Card(
        child: ListTile(
          title: Text(destinasi.destination!),
          subtitle: Text(destinasi.location!),
        ),
      ),
    );
  }
}
