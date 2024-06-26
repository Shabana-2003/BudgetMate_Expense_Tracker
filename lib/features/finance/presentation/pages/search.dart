import 'package:budgetmate/features/finance/data/models/finances_data.dart';
import 'package:budgetmate/features/finance/presentation/pages/add/add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class Searchh extends StatefulWidget {
  const Searchh({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Searchh> {
  var history;
  final TextEditingController _searchController = TextEditingController();
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
  void initState() {
    super.initState();

    searchResults = box.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Search',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchTextChanged,
              decoration:const InputDecoration(
                hintText: 'Search transactions...',
                focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 47, 125, 121)),
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, value, child) {
                List<FinancesData> reversedHistoryList =
                    box.values.toList().reversed.toList();

                if (searchResults.isEmpty && reversedHistoryList.isEmpty) {
                
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/search.png',
                            height: 300,
                            width: 300,
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            'Search for transactions to fill \n your financial insights',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 46, 46, 46),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (searchResults.isEmpty) {
                  
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/four.png',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'No matching transactions found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  // User has searched, display the matching transactions
                  return ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      history = searchResults[index];
                      return getList(history, index);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  void _onSearchTextChanged(String text) {
    setState(() {
      searchResults = text.isEmpty
          ? box.values.toList()
          : box.values
              .where((data) =>
                  data.name.toLowerCase().contains(text.toLowerCase()))
              .toList();

      print('Search Text: $text');
      print('Search Results Length: ${searchResults.length}');
      print('Search Results: $searchResults');
    });
  }

  Widget getList(FinancesData history, int index) {
    if (history.type == 'profile') {
      return const SizedBox.shrink();
    }
    return Slidable(
      actionPane:const SlidableDrawerActionPane(),
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
                  color: Color.fromARGB(255, 235, 236, 236),
                  width: 3.0,
                ),
              ),
              child: get(index, history)),
        ),
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(FinancesData history) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text("Confirm Delete",
              style: TextStyle(color: Color.fromARGB(255, 249, 248, 248))),
          backgroundColor:const Color.fromARGB(255, 2, 116, 106),
          content:const Text(
            "Are you sure you want to delete this transaction?",
            style: TextStyle(color: Color.fromARGB(255, 206, 199, 199)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child:const Text("Cancel",
                  style: TextStyle(color: Color.fromARGB(255, 194, 187, 187))),
            ),
            TextButton(
              onPressed: () {
                history.delete();
                Navigator.pop(context, true);
              },
              child:const Text("Delete", style: TextStyle(color: Colors.red)),
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
        style:const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
     subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '${DateFormat('MMMM').format(history.dateTime)} ${history.dateTime.day}, ${history.dateTime.year}',
          style:const TextStyle(
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
