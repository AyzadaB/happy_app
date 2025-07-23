import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/logic/moment_cubit.dart';
import 'package:happy_app/core/features/moments/widgets/app_bar_widget.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/components/custom_add_button.dart';
import 'package:happy_app/core/src/components/custom_text_field.dart';
import 'package:happy_app/core/src/components/custom_text_field_icon.dart';
import 'package:happy_app/core/src/components/list_of_tags.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';

class AddMomentPage extends StatefulWidget {
  const AddMomentPage({super.key});

  @override
  State<AddMomentPage> createState() => _AddMomentPageState();
}

class _AddMomentPageState extends State<AddMomentPage> {
  final TextEditingController _nameController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  File? _imageFile;
  String? _currentSelectedTag;
  bool _hasUnsavedChanges = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateUnsavedChangesStatus);
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateUnsavedChangesStatus);
    _nameController.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _imageFile != null &&
      _currentSelectedTag != null &&
      _selectedDate != null &&
      _nameController.text.trim().isNotEmpty;

  void _updateUnsavedChangesStatus() {
    setState(() {
      _hasUnsavedChanges =
          _imageFile != null ||
          _currentSelectedTag != null ||
          _nameController.text.trim().isNotEmpty ||
          (_selectedDate != null &&
              !_isSameDay(_selectedDate!, DateTime.now()));
    });
  }

  bool _isSameDay(DateTime d1, DateTime d2) =>
      d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;

  void _handleDateSelection(DateTime date) {
    setState(() {
      _selectedDate = date;
      _updateUnsavedChangesStatus();
    });
  }

  void _handleTagSelection(String tag) {
    setState(() {
      _currentSelectedTag = (_currentSelectedTag == tag) ? null : tag;
      _updateUnsavedChangesStatus();
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _updateUnsavedChangesStatus();
      });
    }
  }

  void _addMoment() {
    if (_isFormValid) {
      final moment = MomentModel(
        id: UniqueKey().toString(),
        name: _nameController.text.trim(),
        date: _selectedDate!,
        tag: _currentSelectedTag!,
        imageFilePath: _imageFile!.path,
        imageAssetPath: null,
      );

      context.read<MomentCubit>().addMoment(moment);
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please fill in all fields and add an image.',
            style: AppTextStyles.footnote.copyWith(color: AppColors.primary),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  Future<bool?> _showDiscardChangesDialog() async {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.grey1,
        title: Text(
          'Leave the page?',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyBold.copyWith(color: AppColors.black),
        ),
        content: Text(
          'You have unsaved changes. If you leave, this moment will not be added.',
          style: AppTextStyles.footnote.copyWith(color: AppColors.black),
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'Cancel',
              style: AppTextStyles.body.copyWith(color: AppColors.ratingColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'Leave',
              style: AppTextStyles.body.copyWith(color: AppColors.ratingColor),
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourceActionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: BoxDecoration(
          color: AppColors.backLevel2,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(16),
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
                Navigator.pop(ctx);
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
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            if (_imageFile != null)
              ListTile(
                leading: const Icon(Icons.delete_forever, color: Colors.red),
                title: const Text(
                  'Delete Photo',
                  style: TextStyle(color: AppColors.error),
                ),
                onTap: () {
                  setState(() => _imageFile = null);
                  Navigator.pop(ctx);
                  _updateUnsavedChangesStatus();
                },
              ),
            const Divider(color: Colors.grey),
            ListTile(
              leading: const Icon(Icons.cancel, color: Colors.red),
              title: const Text(
                'Cancel',
                style: TextStyle(color: AppColors.error),
              ),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBarWidget(
        title: 'Add moment',
        customLeading: IconButton(
          onPressed: () async {
            if (_hasUnsavedChanges) {
              final shouldPop = await _showDiscardChangesDialog();
              if (shouldPop == true) Navigator.pop(context);
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
            children: [
              GestureDetector(
                onTap: _showImageSourceActionSheet,
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: AppColors.backLevel2,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.grey3),
                    image: _imageFile != null
                        ? DecorationImage(
                            image: FileImage(_imageFile!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _imageFile == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: AppColors.grey2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Add photo',
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.grey2,
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
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
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: CustomAddButton(
          title: 'Add',
          onPressed: _isFormValid ? _addMoment : null,
          activeColor: AppColors.accentPrymary,
          disabledColor: const Color(0xff995A5E),
          activeTextColor: Colors.white,
          disabledTextColor: AppColors.grey1,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
