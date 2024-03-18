import 'package:appwrite_todo/presentation/provider/select_category.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:appwrite_todo/presentation/widgets/avatar_widget.dart';
import 'package:appwrite_todo/presentation/widgets/in_progress_widget.dart';
import 'package:appwrite_todo/presentation/widgets/progress_widget.dart';
import 'package:appwrite_todo/presentation/widgets/task_groups.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(taskNotifierProvider.notifier).getListTask();
      ref.read(taskCategoryNotifierProvider.notifier).getListCategory();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectCategory = ref.read(selectCategoryProvider);
    print(selectCategory);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bg.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const AvatarWigets(),
              const SizedBox(height: 20.0),
              const ProgressWidget(),
              const SizedBox(height: 15.0),
              const InProgress(),
              const SizedBox(height: 30.0),
              const TaskGroups()
            ],
          ),
        ),
      ),
    );
  }
}
