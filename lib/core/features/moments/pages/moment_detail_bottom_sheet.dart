import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/pages/edit_moment_page.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:intl/intl.dart';

class MomentDetailBottomSheet extends StatelessWidget {
  final MomentModel moment;
  final VoidCallback? onDelete;
  final ValueChanged<MomentModel>? onMomentUpdated;

  const MomentDetailBottomSheet({
    super.key,
    required this.moment,
    this.onDelete,
    this.onMomentUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backLevel2,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(32.0),
          topRight: Radius.circular(32.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                  child: moment.imageFile != null
                      ? Image.file(
                          moment.imageFile!,
                          height: 300,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 300,
                              width: double.infinity,
                              color: AppColors.grey2,
                              child: const Center(
                                child: Icon(
                                  Icons.broken_image,
                                  color: AppColors.primary,
                                  size: 50,
                                ),
                              ),
                            );
                          },
                        )
                      : (moment.imageAssetPath != null
                          ? Image.asset(
                              moment.imageAssetPath!,
                              height: 300,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 300,
                                  width: double.infinity,
                                  color: AppColors.grey2,
                                  child: const Center(
                                    child: Icon(
                                      Icons.broken_image,
                                      color: AppColors.primary,
                                      size: 50,
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              height: 300,
                              width: double.infinity,
                              color: AppColors.grey2,
                              child: const Center(
                                child: Icon(
                                  Icons.no_photography,
                                  color: AppColors.primary,
                                  size: 50,
                                ),
                              ),
                            )),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext innerContext) =>
                            CupertinoActionSheet(
                          actions: <CupertinoActionSheetAction>[
                            CupertinoActionSheetAction(
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  color: CupertinoColors.activeBlue,
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditMomentPage(
                                      moment: moment,
                                      onSave: (updatedMoment) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);

                                        if (onMomentUpdated != null) {
                                          onMomentUpdated!(updatedMoment);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                            ),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                Navigator.pop(
                                    innerContext);
                                showDeleteConfirmationDialog(
                                  context,
                                  onDeleteConfirmed: () {
                                    if (onDelete != null) {
                                      onDelete!();
                                    }
                                    print('Moment deleted: ${moment.name}');
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  color: CupertinoColors.systemRed,
                                ),
                              ),
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: CupertinoColors.activeBlue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(
                                  innerContext);
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        moment.tag,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      Text(
                        DateFormat('dd.MM.yyyy').format(moment.date),
                        style: AppTextStyles.footnote.copyWith(
                          color: AppColors.grey2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    moment.name,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(
    BuildContext context, {
    required VoidCallback onDeleteConfirmed,
  }) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Delete moment'),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              onPressed: () {
                Navigator.pop(context);
                onDeleteConfirmed();
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: CupertinoColors.systemRed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}