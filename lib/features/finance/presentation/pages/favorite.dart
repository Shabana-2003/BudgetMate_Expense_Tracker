import 'package:budgetmate/features/finance/data/models/finances_data.dart';
import 'package:budgetmate/features/finance/presentation/pages/add/add_screen.dart';
import 'package:budgetmate/features/finance/presentation/widgets/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<Favorite> {
  final Box<FinancesData> box = Hive.box<FinancesData>('data');
  List<FinancesData> searchResults = [];
  final List<String> day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainNavigationBar(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Color.fromARGB(255, 11, 11, 11),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Favorites',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: const Color.fromARGB(255, 33, 119, 70),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    List<FinancesData> favoriteList =
                        box.values.where((data) => data.isFavorite).toList();
                    if (favoriteList.isEmpty) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 45,
                            ),
                            Image.asset(
                              'assets/images/search.png',
                              height: 300,
                              width: 300,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                'No favorite transactions found \nAdd to Favorites for quick access and insights.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 78, 78, 78),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainNavigationBar(),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<
                                        Color>(
                                    const Color.fromARGB(255, 47, 125, 121)),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  const Size(200, 70),
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Add to Favorite',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: favoriteList.length,
                      itemBuilder: (context, index) {
                        return getList(favoriteList[index], index);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getList(FinancesData history, int index) {
    if (history.type == 'profile') {
      return const SizedBox.shrink();
    }
    return Slidable(
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
          caption: 'Edit',
          color: const Color.fromARGB(255, 250, 250, 250),
          icon: Icons.edit,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(editData: history),
              ),
            );
          },
        ),
        IconSlideAction(
          caption: 'Delete',
          color: const Color.fromARGB(255, 253, 253, 253),
          icon: Icons.delete,
          onTap: () {
            _showDeleteConfirmationDialog(history);
          },
        ),
      ],
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddScreen(editData: history),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            right: 15,
            bottom: 4,
            top: 4,
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color.fromARGB(255, 235, 236, 236),
                width: 3.0,
              ),
            ),
            child: get(index, history),
          ),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(FinancesData history) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Delete",
              style: TextStyle(color: Color.fromARGB(255, 249, 248, 248))),
          backgroundColor: const Color.fromARGB(255, 2, 116, 106),
          content: const Text(
            "Are you sure you want to delete this transaction?",
            style: TextStyle(color: Color.fromARGB(255, 206, 199, 199)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 194, 187, 187))),
            ),
            TextButton(
              onPressed: () {
                history.delete();
                Navigator.pop(context, true);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  ListTile get(int index, FinancesData history) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image.asset('assets/images/${history.name}.png', height: 40),
      ),
      title: Text(
        history.name,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '${DateFormat('MMMM').format(history.dateTime)} ${history.dateTime.day}, ${history.dateTime.year}',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      trailing: Text(
        '\₹ ${history.amount}',
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 19,
          color:
              history.transactionType == 'Income' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
