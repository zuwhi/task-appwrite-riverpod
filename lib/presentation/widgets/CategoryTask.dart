import 'package:appwrite_todo/data/static/data_static.dart';
import 'package:appwrite_todo/presentation/provider/select_category.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class CategoryTask extends ConsumerStatefulWidget {
  const CategoryTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryTaskState();
}

class _CategoryTaskState extends ConsumerState<CategoryTask> {
  int _selected = -1;
  String? categoryId;

  void _onSelect(index, catId) {
    setState(() {
      _selected = index;
    });

    ref.read(selectCategoryProvider.notifier).changeCategory(catId);
    ref.read(taskNotifierProvider.notifier).getListBySelectCategory();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Consumer(
        builder: (context, ref, child) {
          TaskCategoryGroups state = ref.watch(taskCategoryNotifierProvider);
          ref.read(taskCategoryNotifierProvider.notifier).getListNameCategory();

          if (state.status == '') return const SizedBox.shrink();
          if (state.status == 'loading') {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.status == 'failed') {
            return Center(
              child: Text(state.message),
            );
          }
          if (state.status == 'success') {
            List data = state.data;
            int startingIndex = 1;

            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length + startingIndex,
                itemBuilder: (context, index) {
                  final actualIndex = index - startingIndex;

                  if (actualIndex < 0 || actualIndex >= data.length) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          _onSelect(-1, 'all');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              color: _selected == -1
                                  ? const Color(0xFF5F33E1)
                                  : const Color(0xFF5F33E1).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Center(
                            child: Text(
                              'All',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.0,
                                  color: _selected == -1
                                      ? Colors.white
                                      : const Color(0xFF5F33E1),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {
                        _onSelect(actualIndex, data[actualIndex].id);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                            color: _selected == actualIndex
                                ? const Color(0xFF5F33E1)
                                : const Color(0xFF5F33E1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text(
                            '${data[actualIndex].name}',
                            style: GoogleFonts.poppins(
                                fontSize: 15.0,
                                color: _selected == actualIndex
                                    ? Colors.white
                                    : const Color(0xFF5F33E1),
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
          return Container();
        },
      ),
    );
  }
}
