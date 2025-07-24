import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/widgets/app_bar_widget.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/components/custom_add_button.dart';
import 'package:happy_app/core/src/components/custom_text_field.dart';
import 'package:happy_app/core/src/components/custom_text_field_icon.dart';
import 'package:happy_app/core/src/components/list_of_tags.dart';

class EditMomentPage extends StatefulWidget {
  final MomentModel moment;
  final ValueChanged<MomentModel>? onSave;

  const EditMomentPage({super.key, required this.moment, this.onSave});

  @override
  State<EditMomentPage> createState() => _EditMomentPageState();
}

class _EditMomentPageState extends State<EditMomentPage> {
  late TextEditingController _nameController;
  late DateTime _selectedDate;
  File? _imageFile;
  late String? _currentSelectedTag;

  late String _initialName;
  late DateTime _initialDate;
  late String? _initialImageFilePath;
  late String? _initialSelectedTag;

  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: widget.moment.name);
    _selectedDate = widget.moment.date;
    _imageFile = widget.moment.imageFile;
    _currentSelectedTag = widget.moment.tag;

    _initialName = widget.moment.name;
    _initialDate = widget.moment.date;
    _initialImageFilePath = widget.moment.imageFilePath;
    _initialSelectedTag = widget.moment.tag;

    _nameController.addListener(_checkChanges);
  }

  @override
  void dispose() {
    _nameController.removeListener(_checkChanges);
    _nameController.dispose();
    super.dispose();
  }

  void _checkChanges() {
    final currentImagePath = _imageFile?.path;
    final bool currentChanges =
        _nameController.text.trim() != _initialName ||
        _selectedDate != _initialDate ||
        currentImagePath != _initialImageFilePath ||
        _currentSelectedTag != _initialSelectedTag;

    if (_hasChanges != currentChanges) {
      setState(() {
        _hasChanges = currentChanges;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _checkChanges();
    }
  }

  Future<void> _showImageSourceActionSheet(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.backLevel2,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.white),
                title: Text(
                  'Select from Gallery',
                  style: TextStyle(color: AppColors.primary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.white),
                title: Text(
                  'Take Photo',
                  style: TextStyle(color: AppColors.primary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              if (_imageFile != null || widget.moment.imageAssetPath != null)
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: const Text(
                    'Delete Photo',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: () {
                    setState(() {
                      _imageFile = null;
                    });
                    _checkChanges();
                    Navigator.pop(context);
                  },
                ),
              const Divider(color: Colors.grey),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text(
                  'Cancel',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      },
    );
  }

  void _handleDateSelection(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
    _checkChanges();
  }

  void _handleTagSelection(String tag) {
    setState(() {
      _currentSelectedTag = (_currentSelectedTag == tag) ? null : tag;
    });
    _checkChanges();
  }

  void _saveMoment() {
    if (!_hasChanges) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'No changes to save.',
            style: AppTextStyles.footnote.copyWith(color: AppColors.primary),
          ),
          backgroundColor: AppColors.primary,
        ),
      );
      return;
    }

    final updatedMoment = MomentModel(
      id: widget.moment.id,
      name: _nameController.text.trim(),
      date: _selectedDate,
      tag: _currentSelectedTag ?? widget.moment.tag,
      imageFilePath: _imageFile?.path,
      imageAssetPath: widget.moment.imageAssetPath,
    );

    // Важно: вызываем onSave, если он есть
    if (widget.onSave != null) {
      widget.onSave!(updatedMoment);
    }

    Navigator.pop(context);
  }

  Future<bool?> _showDiscardChangesDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.grey1,
        title: Text(
          'Exit editing',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyBold.copyWith(color: AppColors.black),
        ),
        content: Text(
          'If you leave this page, the changes will not be saved.',
          style: AppTextStyles.footnote.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: AppTextStyles.body.copyWith(color: AppColors.ratingColor),
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Exit',
              style: AppTextStyles.body.copyWith(color: AppColors.ratingColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBarWidget(
        title: 'Edit moment',
        customLeading: IconButton(
          onPressed: () async {
            if (_hasChanges) {
              final bool? shouldPop = await _showDiscardChangesDialog(context);
              if (shouldPop == true) {
                Navigator.pop(context);
              }
            } else {
              Navigator.pop(context);
            }
          },
          icon: SvgPicture.asset(
            'assets/icons/arrowLeft.svg',
            colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400,
                decoration: BoxDecoration(
                  color: AppColors.backLevel2,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.grey3, width: 1),
                  image: _imageFile != null
                      ? DecorationImage(
                          image: FileImage(_imageFile!),
                          fit: BoxFit.cover,
                        )
                      : (widget.moment.imageAssetPath != null
                            ? DecorationImage(
                                image: AssetImage(
                                  widget.moment.imageAssetPath!,
                                ),
                                fit: BoxFit.cover,
                              )
                            : null),
                ),
                child:
                    (_imageFile == null && widget.moment.imageAssetPath == null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image,
                            size: 40,
                            color: AppColors.grey2,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'No Image',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.grey2,
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => _showImageSourceActionSheet(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(height: 20),
              ListOfTags(
                selectedTags: _currentSelectedTag != null
                    ? {_currentSelectedTag!}
                    : {},
                onTagSelected: _handleTagSelection,
              ),
              const SizedBox(height: 20),
              CustomTextFieldIcon(
                labelText: 'Date',
                selectedDate: _selectedDate,
                onDateSelected: _handleDateSelection,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: _nameController,
                hintText: 'Enter moment name',
                labelText: 'Name',
                maxLines: null,
              ),
              const SizedBox(height: 20),
              CustomAddButton(
                title: 'Save',
                onPressed: _hasChanges ? _saveMoment : null,
                activeColor: AppColors.accentPrymary,
                disabledColor: const Color(0xff995A5E),
                activeTextColor: Colors.white,
                disabledTextColor: AppColors.grey1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
