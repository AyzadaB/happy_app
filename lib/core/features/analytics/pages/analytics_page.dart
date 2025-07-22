import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happy_app/core/features/analytics/widgets/moments_card.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_cubit.dart';
import 'package:happy_app/core/features/tasks/logic/cubit/task_state.dart';
import 'package:happy_app/core/src/colors/app_colors.dart';
import 'package:happy_app/core/src/typography/app_text_styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        if (state is TaskLoaded) {
          final totalTasks =
              state.activeTasks.length + state.completedTasks.length;
          final completedCount = state.completedTasks.length;

          final percent = totalTasks == 0 ? 0.0 : completedCount / totalTasks;
          final isAllCompleted =
              completedCount == totalTasks && totalTasks != 0;

          return Scaffold(
            backgroundColor: AppColors.backLevel1,
            appBar: AppBar(
              backgroundColor: AppColors.backLevel1,
              title: Text('Analytics', style: AppTextStyles.titleBold),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const MomentsCard(),
                  const SizedBox(height: 24),
                  CircularPercentIndicator(
                    radius: 155,
                    header: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Progress on tasks",
                        style: AppTextStyles.titleBold,
                      ),
                    ),
                    lineWidth: 60,
                    percent: percent.clamp(0.0, 1.0),
                    center: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(percent * 100).toStringAsFixed(0)}%',
                          style: AppTextStyles.titleBold.copyWith(
                            fontSize: 24,
                            color: AppColors.primary,
                          ),
                        ),
                        if (isAllCompleted) ...[
                          const SizedBox(height: 8),
                          Image.asset(
                            'assets/images/congratulations.png',
                            width: 100,
                            height: 100,
                          ),
                        ],
                      ],
                    ),
                    progressColor: AppColors.success,
                    backgroundColor: const Color(0xFFE54D4D),
                    circularStrokeCap: CircularStrokeCap.butt,
                    animation: true,
                    animationDuration: 315,
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
