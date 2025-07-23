import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:happy_app/core/features/moments/data/moment_model.dart';
import 'package:happy_app/core/features/moments/logic/moment_cubit.dart';
import 'package:happy_app/core/features/moments/pages/add_moment_page.dart';
import 'package:happy_app/core/features/moments/pages/moment_detail_bottom_sheet.dart';
import 'package:happy_app/core/features/moments/widgets/app_bar_widget.dart';
import 'package:happy_app/core/src/components/icon_toggle_button.dart';
import 'package:happy_app/core/src/src.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _selectedFilterTag;
  String _currentSortOption = 'date_desc';
  ViewMode _currentViewMode = ViewMode.grid;

  @override
  void initState() {
    super.initState();
    // Загрузка моментов теперь инициируется в кубите,
    // но если нужно можно вызвать кубит явно:
    // context.read<MomentCubit>().loadMoments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBarWidget(title: 'My moments'),
      body: BlocBuilder<MomentCubit, MomentState>(
        builder: (context, state) {
          if (state is MomentInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MomentLoaded) {
            final allMoments = state.moments;
            final filteredMoments = _applyFiltersAndSorting(allMoments);
            final isMomentsEmpty = allMoments.isEmpty;
            final isFilteredMomentsEmpty = filteredMoments.isEmpty;

            String sortButtonTitle = _currentSortOption == 'date_desc'
                ? 'New'
                : 'Old';
            SvgPicture sortButtonIcon = _currentSortOption == 'date_desc'
                ? SvgPicture.asset('assets/icons/new.svg')
                : SvgPicture.asset('assets/icons/old.svg');

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuoteCard(
                    quote:
                        'The brightest moments are found in simple things: a smile, morning light, a warm cup of tea',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text('Moments', style: AppTextStyles.titleBold),
                  ),
                  const SizedBox(height: 16),
                  if (isMomentsEmpty)
                    Column(
                      children: [
                        Image.asset(
                          'assets/images/camera.png',
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Take the Challenge',
                          style: AppTextStyles.titleBold,
                          textAlign: TextAlign.center,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10,
                          ),
                          child: Text(
                            'Set a goal to take 100 photos of things/ moments that bring you joy, over the course of a year.',
                            style: AppTextStyles.footnote.copyWith(
                              color: AppColors.grey1,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  else
                    Column(
                      children: [
                        ListOfTags(
                          selectedTags: _selectedFilterTag != null
                              ? {_selectedFilterTag!}
                              : {},
                          onTagSelected: _onTagFilterChanged,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SortingButton(
                              onTap: () {
                                _onSortOptionChanged(
                                  _currentSortOption == 'date_desc'
                                      ? 'date_asc'
                                      : 'date_desc',
                                );
                              },
                              title: sortButtonTitle,
                              icon: sortButtonIcon,
                            ),
                            IconToggleButton(
                              currentViewMode: _currentViewMode,
                              onChanged: (mode) {
                                _onViewModeChanged(mode);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (isFilteredMomentsEmpty)
                          Column(
                            children: [
                              const SizedBox(height: 50),
                              Image.asset('assets/images/search.png'),
                              const SizedBox(height: 20),
                              Text(
                                'Nothing was found for these filters',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        else if (_currentViewMode == ViewMode.grid)
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 8.0,
                                  mainAxisSpacing: 8.0,
                                  childAspectRatio: 1.0,
                                ),
                            itemCount: filteredMoments.length,
                            itemBuilder: (context, index) {
                              final moment = filteredMoments[index];
                              return GestureDetector(
                                onTap: () {
                                  _showMomentDetails(context, moment);
                                },
                                child: Card(
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  child: moment.imageFile != null
                                      ? Image.file(
                                          moment.imageFile!,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  color: AppColors.grey2,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      color: AppColors.primary,
                                                    ),
                                                  ),
                                                );
                                              },
                                        )
                                      : (moment.imageAssetPath != null
                                            ? Image.asset(
                                                moment.imageAssetPath!,
                                                fit: BoxFit.cover,
                                                errorBuilder:
                                                    (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        color: AppColors.grey2,
                                                        child: const Center(
                                                          child: Icon(
                                                            Icons.broken_image,
                                                            color: AppColors
                                                                .primary,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                              )
                                            : Container(
                                                color: AppColors.grey2,
                                                child: const Center(
                                                  child: Icon(
                                                    Icons.no_photography,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              )),
                                ),
                              );
                            },
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredMoments.length,
                            itemBuilder: (context, index) {
                              final moment = filteredMoments[index];
                              return VerticalCard(
                                moment: moment,
                                onTap: () {
                                  _showMomentDetails(context, moment);
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          } else {
            // Можно обработать ошибочное состояние, если есть MomentError
            return const Center(child: Text('Error loading moments'));
          }
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: CustomAddButton(
          title: 'Add moment',
          onPressed: () async {
            final newMomentData = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddMomentPage()),
            );
            if (newMomentData != null &&
                newMomentData is Map<String, dynamic>) {
              final newMoment = MomentModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: newMomentData['name'],
                date: newMomentData['date'],
                tag: newMomentData['tag'],
                imageFilePath: newMomentData['imageFile']?.path,
                imageAssetPath: null,
              );
              context.read<MomentCubit>().addMoment(newMoment);
            }
          },
          activeColor: AppColors.accentPrymary,
          activeTextColor: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<MomentModel> _applyFiltersAndSorting(List<MomentModel> moments) {
    List<MomentModel> result = List.from(moments);

    if (_selectedFilterTag != null && _selectedFilterTag != 'All') {
      result = result
          .where((moment) => moment.tag == _selectedFilterTag)
          .toList();
    }

    result.sort((a, b) {
      if (_currentSortOption == 'date_desc') {
        return b.date.compareTo(a.date);
      } else if (_currentSortOption == 'date_asc') {
        return a.date.compareTo(b.date);
      }
      return 0;
    });

    return result;
  }

  void _onTagFilterChanged(String? tag) {
    setState(() {
      if (_selectedFilterTag == tag) {
        _selectedFilterTag = null;
      } else {
        _selectedFilterTag = tag;
      }
    });
  }

  void _onSortOptionChanged(String option) {
    setState(() {
      _currentSortOption = option;
    });
  }

  void _onViewModeChanged(ViewMode mode) {
    setState(() {
      _currentViewMode = mode;
    });
  }

  void _showMomentDetails(BuildContext context, MomentModel moment) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.backLevel2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => MomentDetailBottomSheet(
        moment: moment,
        onDelete: () {
          context.read<MomentCubit>().deleteMoment(moment.id);
          Navigator.pop(bottomSheetContext);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Moment deleted!')));
        },
        onMomentUpdated: (updatedMoment) {
          context.read<MomentCubit>().addMoment(
            updatedMoment,
          ); // update by add with same id
          Navigator.pop(bottomSheetContext);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Moment updated!')));
        },
      ),
    );
  }
}
