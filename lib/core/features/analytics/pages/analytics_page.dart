import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/moments/logic/moment_cubit.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_cubit.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_state.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backLevel1,
      appBar: AppBar(
        backgroundColor: AppColors.backLevel1,
        title: Text('Analytics', style: AppTextStyles.titleBold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("My Moments", style: AppTextStyles.titleBold),
              const SizedBox(height: 12),
              BlocBuilder<MomentCubit, MomentState>(
                builder: (context, state) {
                  if (state is MomentLoaded) {
                    final totalMoments = state.moments.length;
                    final double progress = (totalMoments / 100).clamp(
                      0.0,
                      1.0,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearPercentIndicator(
                          percent: progress,
                          lineHeight: 20,
                          barRadius: const Radius.circular(8),
                          progressColor: AppColors.success,
                          backgroundColor: AppColors.backLevel3,
                          center: Text(
                            "$totalMoments / 100",
                            style: AppTextStyles.footnote.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text("Last Moments", style: AppTextStyles.titleBold),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: state.moments.take(3).map((moment) {
                            return Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: AppColors.backLevel2,
                                ),
                                clipBehavior: Clip.hardEdge,
                                child:
                                    moment.imageFile != null &&
                                        File(
                                          moment.imageFile!.path,
                                        ).existsSync()
                                    ? Image.file(
                                        File(moment.imageFile!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.image),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),

              const SizedBox(height: 32),

              /// --- Диаграмма заданий
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is TaskLoaded) {
                    final totalTasks =
                        state.activeTasks.length + state.completedTasks.length;
                    final completed = state.completedTasks.length;
                    final percent = totalTasks == 0
                        ? 0.0
                        : completed / totalTasks;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Progress on tasks",
                          style: AppTextStyles.titleBold,
                        ),
                        const SizedBox(height: 50),
                        Center(
                          child: CircularPercentIndicator(
                            radius: 150,
                            lineWidth: 35,
                            percent: percent.clamp(0.0, 1.0),
                            center: Text(
                              "${(percent * 100).toStringAsFixed(0)}%",
                              style: AppTextStyles.titleBold.copyWith(
                                fontSize: 24,
                              ),
                            ),
                            progressColor: AppColors.success,
                            backgroundColor: Colors.red.shade300,
                            animation: true,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
