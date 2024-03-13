import 'package:appwrite_todo/presentation/pages/add_task.dart';
import 'package:appwrite_todo/presentation/pages/dashboard_page.dart';
import 'package:appwrite_todo/presentation/pages/list_todo_page.dart';
import 'package:appwrite_todo/presentation/pages/task_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // DatabaseInstance databaseInstance = DatabaseInstance();
  Widget currentPage = const DashboardPage();
  int currentTab = 1;
  Color custPurple = const Color(0xFF5F33E1);
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPage,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5F33E1),
        tooltip: 'Increment',
        mini: true,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          height: 60,
          color: const Color.fromARGB(172, 255, 255, 255),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            // color: Colors.amber,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  MaterialButton(
                    minWidth: 70,
                    elevation: 500,
                    onPressed: () {
                      setState(() {
                        currentPage = const DashboardPage();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.home_filled,
                      color: currentTab == 1
                          ? const Color(0xFF5F33E1)
                          : Colors.grey,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 70,
                    elevation: 10,
                    onPressed: () {
                      setState(() {
                        currentPage = const TaskPage();
                        currentTab = 2;
                      });
                    },
                    child: Icon(
                      Icons.calendar_month_rounded,
                      color: currentTab == 2 ? Colors.deepPurple : Colors.grey,
                    ),
                  ),
                ]),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  MaterialButton(
                    minWidth: 70,
                    elevation: 500,
                    onPressed: () {
                      setState(() {
                        currentPage = const DashboardPage();
                        currentTab = 1;
                      });
                    },
                    child: Icon(
                      Icons.home_filled,
                      color: currentTab == 1 ? Colors.deepPurple : Colors.grey,
                    ),
                  ),
                  MaterialButton(
                    minWidth: 70,
                    elevation: 10,
                    onPressed: () {
                      setState(() {
                        currentPage = const DashboardPage();
                        currentTab = 2;
                      });
                    },
                    child: Icon(
                      Icons.home_filled,
                      color: currentTab == 2 ? Colors.deepPurple : Colors.grey,
                    ),
                  ),
                ]),
              ],
            ),
          )),
    );
  }
}
