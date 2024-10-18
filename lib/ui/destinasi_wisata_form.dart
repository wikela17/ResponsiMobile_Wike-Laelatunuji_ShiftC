import 'package:flutter/material.dart';
import 'package:pariwisata/bloc/destinasi_wisata_bloc.dart';
import 'package:pariwisata/model/destinasi_wisata.dart';
import 'package:pariwisata/ui/destinasi_wisata_page.dart';
import 'package:pariwisata/widget/warning_dialog.dart';

class DestinasiWisataForm extends StatefulWidget {
  final DestinasiWisata? destinasiWisata; // Make this a final property

  DestinasiWisataForm({Key? key, this.destinasiWisata}) : super(key: key);

  @override
  _DestinasiWisataFormState createState() => _DestinasiWisataFormState();
}

class _DestinasiWisataFormState extends State<DestinasiWisataForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String judul = "TAMBAH DESTINASI WISATA";
  String tombolSubmit = "SIMPAN";

  // Text editing controllers for each field
  final _destinationTextboxController = TextEditingController();
  final _locationTextboxController = TextEditingController();
  final _attractionTextboxController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isUpdate();
  }

  // Check if the form is for updating an existing destination
  void isUpdate() {
    if (widget.destinasiWisata != null) {
      setState(() {
        judul = "UBAH DESTINASI WISATA";
        tombolSubmit = "UBAH";
        _destinationTextboxController.text = widget.destinasiWisata!.destination!;
        _locationTextboxController.text = widget.destinasiWisata!.location!;
        _attractionTextboxController.text = widget.destinasiWisata!.attraction!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(judul)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _destinationTextField(),
                _locationTextField(),
                _attractionTextField(),
                _buttonSubmit(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TextField for Destination
  Widget _destinationTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Destination"),
      controller: _destinationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Destination harus diisi";
        }
        return null;
      },
    );
  }

  // TextField for Location
  Widget _locationTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Location"),
      controller: _locationTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Location harus diisi";
        }
        return null;
      },
    );
  }

  // TextField for Attraction
  Widget _attractionTextField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: "Attraction"),
      controller: _attractionTextboxController,
      validator: (value) {
        if (value!.isEmpty) {
          return "Attraction harus diisi";
        }
        return null;
      },
    );
  }

  // Submit Button for Save/Update
  Widget _buttonSubmit() {
    return OutlinedButton(
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(tombolSubmit),
      onPressed: _isLoading ? null : () {
        if (_formKey.currentState!.validate()) {
          if (widget.destinasiWisata != null) {
            // Update the destination
            ubah();
          } else {
            // Add a new destination
            simpan();
          }
        }
      },
    );
  }

  // Function to save a new destination
  void simpan() {
    setState(() {
      _isLoading = true;
    });
    
    DestinasiWisata newDestinasiWisata = DestinasiWisata(
      destination: _destinationTextboxController.text,
      location: _locationTextboxController.text,
      attraction: _attractionTextboxController.text,
    );

    DestinasiWisataBloc.addDestinasiWisata(destinasi: newDestinasiWisata).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const DestinasiWisataPage()));
      } else {
        _showErrorDialog("Simpan gagal, silahkan coba lagi");
      }
    }).catchError((error) {
      _showErrorDialog("Simpan gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Function to update an existing destination
  void ubah() {
    setState(() {
      _isLoading = true;
    });

    widget.destinasiWisata!.destination = _destinationTextboxController.text;
    widget.destinasiWisata!.location = _locationTextboxController.text;
    widget.destinasiWisata!.attraction = _attractionTextboxController.text;

    DestinasiWisataBloc.updateDestinasiWisata(destinasi: widget.destinasiWisata!).then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const DestinasiWisataPage()));
      } else {
        _showErrorDialog("Ubah gagal, silahkan coba lagi");
      }
    }).catchError((error) {
      _showErrorDialog("Ubah gagal, silahkan coba lagi");
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  // Show Error Dialog
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => WarningDialog(
        description: message,
      ),
    );
  }
}
