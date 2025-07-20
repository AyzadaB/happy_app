import 'package:flutter/material.dart';

class AddMomentPage extends StatefulWidget {
  const AddMomentPage({super.key});

  @override
  State<AddMomentPage> createState() => _AddMomentPageState();
}

class _AddMomentPageState extends State<AddMomentPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now(); // Баштапкы датаны учурдагы датага коёбуз

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('Add moment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Сүрөт кошуу аянты
            Container(
              height: 200, // Сүрөттүн бийиктигин белгилейбиз
              decoration: BoxDecoration(
                color: Colors.grey[850], // Сүрөт үчүн фон түсү
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.camera_alt,
                    size: 40,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Add photo',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),

            // Хэштегдер
            Wrap(
              spacing: 8.0, // Горизонталдуу аралык
              runSpacing: 8.0, // Вертикалдык аралык
              children: [
                _buildHashtagChip('#friends'),
                _buildHashtagChip('#family'),
                _buildHashtagChip('#nature'),
                _buildHashtagChip('#food'),
                // Кошумча хэштегдерди бул жерге кошо аласыз
              ],
            ),
            const SizedBox(height: 24.0),

            // Дата тандоо аянты
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(color: Colors.grey[600], fontSize: 12.0),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          '${_selectedDate.day.toString().padLeft(2, '0')}.${_selectedDate.month.toString().padLeft(2, '0')}.${_selectedDate.year}',
                          style: const TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.0),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Аталыш киргизүү аянты
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter a brief description of the moment',
                labelStyle: TextStyle(color: Colors.grey[600]),
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor), // Фокусталганда түсүн өзгөртөбүз
                ),
              ),
              style: const TextStyle(color: Colors.white), // Киргизилген тексттин түсү
            ),
            const SizedBox(height: 32.0),

            // "Add" баскычы
            ElevatedButton(
              onPressed: () {
                // "Add" баскычы басылганда эмне кылуу керектигин бул жерге жазыңыз
                // Мисалы: _nameController.text, _selectedDate маанилерин колдонуу
                print('Moment Name: ${_nameController.text}');
                print('Moment Date: ${_selectedDate}');
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Moment кошулду (симуляция)')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red[800], // Баскычтын фон түсү
                foregroundColor: Colors.white, // Тексттин түсү
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black, // Жалпы фон түсү
    );
  }

  Widget _buildHashtagChip(String tag) {
    return Chip(
      label: Text(
        tag,
        style: TextStyle(color: Colors.grey[400]),
      ),
      backgroundColor: Colors.grey[800],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: Colors.grey[700]!),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    );
  }
}