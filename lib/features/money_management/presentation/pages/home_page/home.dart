import 'dart:io';
import 'package:budgetmate/features/money_management/data/models/finances_data.dart';
import 'package:budgetmate/features/money_management/presentation/pages/add/add_screen.dart';
import 'package:budgetmate/features/money_management/presentation/pages/favorite.dart';
import 'package:budgetmate/features/money_management/presentation/pages/profile.dart';
import 'package:budgetmate/features/money_management/presentation/pages/statistics.dart';
import 'package:budgetmate/utils/finance_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  var history;
  final box = Hive.box<FinancesData>('data');
  final List<String> day = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    'Friday',
    'Saturday',
    'Sunday'
  ];
  @override
   Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 254, 255, 255),
          child: Column(
            children: [
              SizedBox(height: 350, child: _head()),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Transactions History',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 19,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Amount',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              GlowingOverscrollIndicator(
                axisDirection: AxisDirection.down,
                color: Color.fromARGB(255, 2, 116, 106),
                child: ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (context, value, child) {
                    List<FinancesData> historyList = box.values.toList();
                    historyList.sort((a, b) => b.dateTime.compareTo(a.dateTime));

                    var groupedByDate = groupBy(historyList, (FinancesData data) {
                      return DateFormat('yyyy-MM-dd').format(data.dateTime);
                    });

                    if (historyList.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Image.asset(
                              'assets/images/four.png',
                              height: 250,
                              width: 250,
                            ),
                            const Text(
                              'Empty wallet, add transactions to fill',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 49, 48, 48),
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: groupedByDate.length,
                      itemBuilder: (context, index) {
                        String date = groupedByDate.keys.elementAt(index);
                        List<FinancesData> transactions = groupedByDate[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
                              child: Text(
                                DateFormat('MMMM d, yyyy').format(DateTime.parse(date)),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            ...transactions.map((history) => getList(history, index)).toList(),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget getList(FinancesData history, int index) {
    if (history.type == 'profile') {
      return SizedBox.shrink();
    }
    return Slidable(
      actionPane:const SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
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
    );
  }

  Future<bool> _showDeleteConfirmationDialog(FinancesData history) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title:const Text("Confirm Delete",
              style: TextStyle(color: Color.fromARGB(255, 249, 248, 248))),
          backgroundColor: Color.fromARGB(255, 2, 116, 106),
          content: Text(
            "Are you sure you want to delete this transaction?",
            style: TextStyle(color: Color.fromARGB(255, 206, 199, 199)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text("Cancel",
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
        child: Image.asset('assets/images/${history.name}.png', height: 50),
      ),
      title: Text(
        history.name,
        style: TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          '${DateFormat('MMMM').format(history.dateTime)} ${history.dateTime.day}, ${history.dateTime.year}',
          style: TextStyle(
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

  Widget _head() {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              height: 240,
              decoration: BoxDecoration(
                color: Color(0xff368983),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 40,
                    right: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 45,
                        width: 45,
                        color: Color.fromRGBO(250, 250, 250, 0.1),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen()),
                            );
                          },
                          child: ValueListenableBuilder(
                            valueListenable: Hive.box<ProfileData>('profileBox')
                                .listenable(),
                            builder:
                                (context, Box<ProfileData> profileBox, child) {
                              ProfileData profileData = profileBox.isNotEmpty
                                  ? profileBox.getAt(0) ??
                                      ProfileData('', '', '', '')
                                  : ProfileData('', '', '', '');

                              return CircleAvatar(
                                radius: 18,
                                backgroundColor: Color(0xff368983),
                                backgroundImage:
                                    profileData.profilePhotoPath.isNotEmpty
                                        ? FileImage(
                                            File(profileData.profilePhotoPath))
                                        :const AssetImage('assets/images/profile.png')
                                            as ImageProvider,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello!!',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color.fromARGB(255, 224, 223, 223),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable:
                              Hive.box<ProfileData>('profileBox').listenable(),
                          builder: (context, value, child) {
                            if (Hive.box<ProfileData>('profileBox').isEmpty) {
                              return Text(
                                'PocketBuddies',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            } else {
                              ProfileData profileData =
                                  Hive.box<ProfileData>('profileBox').getAt(0)!;

                              String nickname = profileData.nickName;

                              return Text(
                                nickname.isNotEmpty
                                    ? nickname
                                    : 'PocketBuddies',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            }
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 140,
          left: (MediaQuery.of(context).size.width - 306) / 2,
          bottom: (MediaQuery.of(context).size.width - 336) / 2,
          child: Container(
            height:MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width*0.8,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(47, 125, 121, 0.3),
                  offset: Offset(0, 6),
                  blurRadius: 12,
                  spreadRadius: 6,
                ),
              ],
              color: Color.fromARGB(255, 47, 125, 121),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Balance',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      //     Icon(Icons.abc_outlined),

                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Statistics()),
                          );
                        },
                        child: Icon(
                          Icons.bar_chart_outlined,
                          size: 30,
                          color: Color.fromARGB(255, 225, 222, 222),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 7),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\₹ ${total()}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16.0, top: 8),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Favorite()),
                            );
                          },
                          child: Icon(
                            Icons.star,
                            size: 30,
                            color: Color.fromARGB(255, 225, 222, 222),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_downward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Income',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 216, 216, 216),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 13,
                            backgroundColor: Color.fromARGB(255, 85, 145, 141),
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 19,
                            ),
                          ),
                          SizedBox(width: 7),
                          Text(
                            'Expenses',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color.fromARGB(255, 216, 216, 216),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\₹ ${income()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '\₹ ${expenses()}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
