import 'dart:io'; 
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/moments/widgets/app_bar_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/components/custom_add_button.dart';
import 'package:happy_app/core/src/components/custom_text_field.dart';
import 'package:happy_app/core/src/components/custom_text_field_icon.dart';
import 'package:happy_app/core/src/components/list_of_tags.dart';

class AddMomentPage extends StatefulWidget {
  const AddMomentPage({super.key});

  @override
  State<AddMomentPage> createState() => _AddMomentPageState();
}

class _AddMomentPageState extends State<AddMomentPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate;
  File? _imageFile;
  String? _currentSelectedTag;

  @override
  void dispose() {
    _nameController.dispose();
    _selectedDate = DateTime.now();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBarWidget(
        title: 'Add moment',
        customLeading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            'assets/icons/arrowLeft.svg',
            color: AppColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Сүрөт кошуу аянты
                  GestureDetector(
                    onTap: () => _showImageSourceActionSheet(
                      context,
                    ), // Диалогду көрсөтүү
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.backLevel1,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: AppColors.grey2, width: 1.0),
                        image: _imageFile != null
                            ? DecorationImage(
                                image: FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              )
                            : null, // Эгер сүрөт тандалган болсо, аны көрсөтүү
                      ),
                      child: _imageFile == null
                          ? Column(
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
                            )
                          : Stack(
                              // Сүрөт тандалганда Stack колдонобуз
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.file(
                                      _imageFile!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 8, // Оң жогорку бурчка жайгаштыруу
                                  right: 8,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _imageFile = null; // Сүрөттү өчүрүү
                                      });
                                      _showImageSourceActionSheet(
                                        context,
                                      ); // Кайра тандоо диалогун ачуу
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54, // Иконканын фону
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.all(6),
                                      child: const Icon(
                                        Icons.edit, // Редакциялоо иконкасы
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ListOfTags(
                    selectedTags: _currentSelectedTag != null
                        ? {_currentSelectedTag!}
                        : {},
                    onTagSelected: _handleTagSelection,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFieldIcon(labelText: 'Date'),
                  SizedBox(height: 16.0),
                  CustomTextField(
                    controller: _nameController,
                    hintText: 'Enter moment name',
                    labelText: 'Name',
                    maxLines: null,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            CustomAddButton(title: 'Add', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  void _handleTagSelection(String tag) {
    setState(() {
      _currentSelectedTag = (_currentSelectedTag == tag) ? null : tag;
    });
  }

  // Сүрөт тандоо же тартуу диалогун көрсөтүү функциясы
  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(
          pickedFile.path,
        ); // Тандалган сүрөттү File объектисине айландыруу
      });
    }
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent, // Фонду тунук кылуу
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[850], // BottomSheet'тин өзүнүн фону
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: const Text(
                  'Галереядан тандоо',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: const Text(
                  'Камерадан сүрөт тартуу',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_imageFile !=
                  null) // Эгерде сүрөт тандалган болсо гана көрсөт
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text(
                    'Сүрөттү өчүрүү',
                    style: TextStyle(color: Colors.red),
                  ),
                  onTap: () {
                    setState(() {
                      _imageFile = null; // Сүрөттү null кылып өчүрүү
                    });
                    Navigator.pop(context); // Диалогду жабуу
                  },
                ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text(
                  'Жокко чыгаруу',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
