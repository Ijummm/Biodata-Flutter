import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class AppForm extends StatefulWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController nisController,
      namaController,
      tpController,
      tgController,
      kelaminController,
      agamaController,
      alamatController;

  AppForm({
    required this.formkey,
    required this.nisController,
    required this.namaController,
    required this.tpController,
    required this.tgController,
    required this.kelaminController,
    required this.agamaController,
    required this.alamatController,
  });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  // Variabel penampung internal untuk state dropdown
  String? _kelamin;
  String? _agama;

  final List<String> _status = ["", "Laki-laki", "Perempuan"];
  final List<String> items = [
    "",
    "Islam",
    "Katholik",
    "Protestan",
    "Hindu",
    "Budha",
    "Khonghucu",
    "atheis",
  ];

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai awal untuk dropdown dari controller (berguna saat mode Ubah)
    _kelamin = widget.kelaminController.text;
    _agama = widget.agamaController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            txtNis(),
            const SizedBox(height: 15),
            txtNama(),
            const SizedBox(height: 15),
            txtTempat(),
            const SizedBox(height: 15),
            txtTanggal(),
            const SizedBox(height: 15),
            tbKelamin(),
            const SizedBox(height: 15),
            tbAgama(),
            const SizedBox(height: 15),
            tbAlamat(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // --- Widget Input Sections ---

  Widget txtNis() {
    return TextFormField(
      controller: widget.nisController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "NIS",
        prefixIcon: const Icon(Icons.card_membership),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan NIS Anda.' : null,
    );
  }

  Widget txtNama() {
    return TextFormField(
      controller: widget.namaController,
      decoration: InputDecoration(
        labelText: "NAMA",
        prefixIcon: const Icon(Icons.person),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Nama Anda.' : null,
    );
  }

  Widget txtTempat() {
    return TextFormField(
      controller: widget.tpController,
      decoration: InputDecoration(
        labelText: "Tempat Lahir",
        prefixIcon: const Icon(Icons.location_city),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Kota Kelahiran.' : null,
    );
  }

  Widget txtTanggal() {
    return TextFormField(
      readOnly: true,
      controller: widget.tgController,
      decoration: InputDecoration(
        labelText: 'Tanggal Lahir',
        prefixIcon: const Icon(Icons.calendar_today),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (pickedDate != null) {
          widget.tgController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      },
      validator: (value) => value!.isEmpty ? 'Pilih Tanggal Lahir.' : null,
    );
  }

  Widget tbKelamin() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Jenis Kelamin',
        prefixIcon: const Icon(Icons.people),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: _kelamin != "" ? _kelamin : null,
      hint: const Text('Pilih Jenis Kelamin'),
      items: _status.where((e) => e.isNotEmpty).map((value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _kelamin = newValue;
          widget.kelaminController.text = newValue!;
        });
      },
      validator: (value) => value == null ? 'Pilih Jenis Kelamin.' : null,
    );
  }

  Widget tbAgama() {
    return DropdownButtonFormField2<String>(
      isExpanded: true,
      decoration: InputDecoration(
        labelText: "Agama",
        prefixIcon: const Icon(Icons.mosque),
        contentPadding: const EdgeInsets.symmetric(vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      value: _agama != "" ? _agama : null,
      hint: const Text('Pilih Agama', style: TextStyle(fontSize: 14)),
      items: items.where((e) => e.isNotEmpty).map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: (value) {
        setState(() {
          _agama = value;
          widget.agamaController.text = value!;
        });
      },
      validator: (value) => value == null ? 'Pilih Agama.' : null,
      dropdownStyleData: DropdownStyleData(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget tbAlamat() {
    return TextFormField(
      controller: widget.alamatController,
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Alamat',
        prefixIcon: const Icon(Icons.location_on),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
      ),
      validator: (value) => value!.isEmpty ? 'Masukkan Alamat.' : null,
    );
  }
}