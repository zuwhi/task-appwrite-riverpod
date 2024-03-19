import 'package:appwrite_todo/data/model/Category.dart';
import 'package:appwrite_todo/data/model/Task.dart';
import 'package:appwrite_todo/main.dart';
import 'package:appwrite_todo/presentation/pages/list_task/list_task.dart';
import 'package:appwrite_todo/presentation/provider/task_category_groups.dart';
import 'package:intl/intl.dart';
import 'package:appwrite_todo/presentation/pages/task_date/task_pages.dart';
import 'package:appwrite_todo/presentation/provider/task_provider.dart';
import 'package:appwrite_todo/presentation/widgets/appColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  final isEdit;
  final task;
  final bool? isByDate;
  const AddTaskPage({super.key, this.isEdit, this.task, this.isByDate = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  TextEditingController titleEdt = TextEditingController();
  TextEditingController descEdt = TextEditingController();
  TextEditingController dateInput = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(taskCategoryNotifierProvider.notifier).getListCategory();
    });
    super.initState();

    if (widget.task != null) {
      initCategory = widget.task.category;
      titleEdt.text = widget.task.title;
      descEdt.text = widget.task.desc;
      dateInput.text = widget.task.date.toString();
      initId = widget.task.id;
      isDone = widget.task.isDone;
      kategori = widget.task.category['\$id'];
    }
  }

  dynamic kategori;
  dynamic initCategory;
  String? initId;
  Category categoryId = Category();
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    // Logger().d(initCategory['\$id']);
    final isEdit = widget.isEdit;
    return Scaffold(
      appBar: AppBar(
        title: Text((isEdit == true) ? "Edit Task" : "Add Task"),
        centerTitle: true,
        actions: const [],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Appcolor.ungu,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
            onPressed: () {
              if (isEdit == true) {
                final taskEdit = Task(
                    id: initId,
                    title: titleEdt.text,
                    desc: descEdt.text,
                    category: kategori ?? initCategory,
                    date: dateInput.text,
                    isDone: isDone);

                widget.isByDate!
                    ? ref
                        .read(taskNotifierProvider.notifier)
                        .updateTask(taskEdit, kategori, true)
                    : ref
                        .read(taskNotifierProvider.notifier)
                        .updateTask(taskEdit, kategori, false);
              } else {
                final task = Task(
                    title: titleEdt.text,
                    desc: descEdt.text,
                    category: kategori ?? initCategory,
                    date: dateInput.text);
                ref
                    .read(taskNotifierProvider.notifier)
                    .addTask(task, context, kategori);
              }

              widget.isByDate!
                  ? Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const Home(pageParams: TaskPage(), tabParams: 2),
                      ),
                      (route) => false)
                  : Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Home(
                            pageParams: ListTaskPage(), tabParams: 3),
                      ),
                      (route) => false);
            },
            child: Text(
              (isEdit == true) ? "Edit Task" : "Save Task",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: titleEdt,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Title Task",
                    hintText: "masukkan title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: TextFormField(
                  controller: descEdt,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: "Deskripsi Task",
                    hintText: "masukkan deskripsi",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),
              Consumer(builder: (context, wiRef, state) {
                TaskCategoryGroups state =
                    wiRef.watch(taskCategoryNotifierProvider);
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
                  List cat = state.data;

                  return DropdownButtonFormField<String>(
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    iconSize: 20,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Colors.black,
                          width: 0.8,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          width: 1,
                        ),
                      ),
                    ),
                    value: kategori,
                    onChanged: (value) {
                      setState(() {
                        kategori = value.toString();
                      });
                      // Logger().d(kategori);
                    },
                    items: cat.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem<String>(
                        value: e.id,
                        child: Text(e.name.toString()),
                      );
                    }).toList(),
                  );
                }
                return Container();
              }),
              Container(
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                  border: Border.all(
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.date_range),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: dateInput,
                        initialValue: null,
                        readOnly: true,
                        decoration: const InputDecoration.collapsed(
                          filled: true,
                          fillColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          hintText: "Masukkan Hari",
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            // print(
                            //     pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            // print(
                            //     formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              (isEdit == true)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //SizedBox
                        const Text(
                          'is done ?',
                          style: TextStyle(fontSize: 17.0),
                        ), //Text
                        Checkbox(
                          value: isDone,
                          onChanged: (value) {
                            setState(() {
                              isDone = value!;
                            });
                          },
                        ), //Checkbox
                      ], //<Widget>[]
                    )
                  : Container()
            ])),
      ),
    );
  }
}
