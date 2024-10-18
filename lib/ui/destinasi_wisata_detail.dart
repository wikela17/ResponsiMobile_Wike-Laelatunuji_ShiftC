import 'package:flutter/material.dart';
import '/model/destinasi_wisata.dart'; // Update to the new model
import '/ui/destinasi_wisata_form.dart'; // Update the import to your new form
import '../bloc/destinasi_wisata_bloc.dart';
import '../widget/warning_dialog.dart';
import 'destinasi_wisata_page.dart';

// ignore: must_be_immutable
class DestinasiWisataDetail extends StatefulWidget {
  DestinasiWisata? destinasiWisata;

  DestinasiWisataDetail({Key? key, this.destinasiWisata}) : super(key: key);

  @override
  _DestinasiWisataDetailState createState() => _DestinasiWisataDetailState();
}

class _DestinasiWisataDetailState extends State<DestinasiWisataDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Destinasi Wisata'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Destinasi : ${widget.destinasiWisata!.destination}",
              style: const TextStyle(fontSize: 20.0),
            ),
            Text(
              "Lokasi : ${widget.destinasiWisata!.location}",
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              "Atraksi : ${widget.destinasiWisata!.attraction}",
              style: const TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit(),
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        OutlinedButton(
          child: const Text("EDIT"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DestinasiWisataForm(
                  destinasiWisata: widget.destinasiWisata,
                ),
              ),
            );
          },
        ),
        // Tombol Hapus
        OutlinedButton(
          child: const Text("DELETE"),
          onPressed: () => confirmHapus(),
        ),
      ],
    );
  }

  void confirmHapus() {
  AlertDialog alertDialog = AlertDialog(
    content: const Text("Yakin ingin menghapus data ini?"),
    actions: [
      // Tombol hapus
      OutlinedButton(
        child: const Text("Ya"),
        onPressed: () {
          // Pastikan id destinasiWisata ada sebelum menghapus
          if (widget.destinasiWisata!.id != null) {
            DestinasiWisataBloc.deleteDestinasiWisata(id: widget.destinasiWisata!.id!).then((value) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const DestinasiWisataPage(),
              ));
            }, onError: (error) {
              showDialog(
                context: context,
                builder: (BuildContext context) => const WarningDialog(
                  description: "Hapus gagal, silahkan coba lagi",
                ),
              );
            });
          }
        },
      ),
      // Tombol batal
      OutlinedButton(
        child: const Text("Batal"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );

  showDialog(builder: (context) => alertDialog, context: context);
}
}