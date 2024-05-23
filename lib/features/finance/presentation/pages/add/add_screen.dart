import 'package:budgetmate/features/finance/data/models/finances_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart' as intl;

class AddScreen extends StatefulWidget {
  final FinancesData? editData;

  const AddScreen({super.key, this.editData});

  @override
  State<AddScreen> createState() => AddScreenState();
}

class AddScreenState extends State<AddScreen> {
  final box = Hive.box<FinancesData>('data');
  DateTime date = DateTime.now();
  TextEditingController dateController = TextEditingController();
  String? selctedItem;
  final TextEditingController _textEditingController = TextEditingController();

  String? selctedItemi;
  final TextEditingController expalinC = TextEditingController();
  FocusNode ex = FocusNode();
  final TextEditingController amountC = TextEditingController();
  FocusNode amount_ = FocusNode();
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountController = TextEditingController();
  bool isFavorite = false;

  final List<String> _itemei = [
    'Income',
    "Expense",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.editData != null) {
      print('Editing: ${widget.editData}');
      selctedItemi = widget.editData!.type;
      selctedItem = widget.editData!.name;
      _textEditingController.text = widget.editData!.name;
      amountC.text = widget.editData!.amount;
      expalinC.text = widget.editData!.purpose;
      date = widget.editData!.dateTime;
      updateDateText();
      print('Populated data for editing');
      isFavorite = widget.editData!.isFavorite;
    }
  }

  void updateDateText() {
    String formattedDate = intl.DateFormat.yMMMMd().format(date);
    dateController.text = 'Date: $formattedDate';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                backgroundContainer(context),
                mainContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container mainContainer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      height: 650,
      width: 340,
      child: Column(
        children: [
          const SizedBox(height: 10),
          transactionCategory(),
          const SizedBox(height: 10),
          amount(),
          const SizedBox(height: 30),
          cashFlow(),
          const SizedBox(height: 30),
          purpose(),
          const SizedBox(height: 30),
          selectDate(),
          const SizedBox(height: 55),
          save(),
          const SizedBox(height: 0),
        ],
      ),
    );
  }

  GestureDetector save() {
    return GestureDetector(
      onTap: () {
        if (_formKey.currentState!.validate()) {}
        if (widget.editData != null) {
          widget.editData!.delete();
        }
        var add = FinancesData(
          selctedItemi!,
          amountC.text,
          date,
          expalinC.text,
          selctedItem!,
          isFavorite: isFavorite,
        );
        final box = Hive.box<FinancesData>('data');
        box.add(add);
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color(0xff368983),
        ),
        width: 120,
        height: 50,
        child: const Text(
          'Save',
          style: TextStyle(
            fontFamily: 'f',
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 17,
          ),
        ),
      ),
    );
  }

//
  Widget selectDate() {
    String formattedDate = intl.DateFormat.yMMMMd().format(date);
    var _ = formattedDate;
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: const Color(0xffC5C5C5))),
      width: 300,
      child: Column(
        children: [
          TextButton(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
                builder: (BuildContext context, Widget? child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: const Color.fromARGB(255, 54, 137, 131),
                      colorScheme: const ColorScheme.light(
                          primary: Color.fromARGB(255, 54, 137, 131)),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
              );
              if (newDate == Null) return;
              setState(() {
                date = newDate!;
                updateDateText();
              });
            },
            child: TextFormField(
              controller: dateController,
              style: const TextStyle(
                fontSize: 17,
                color: Colors.black,
              ),
              decoration: const InputDecoration(
                hintText: 'Select Date',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 158, 158, 158),
                ),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabled: false,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding transactionCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: SizedBox(
        width: 300,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8, bottom: 4, left: 8),
              child: Text(
                'Select Transaction Category',
                style: TextStyle(color: Color.fromARGB(255, 122, 122, 122)),
              ),
            ),
            Column(
              children: _itemei
                  .map(
                    (e) => RadioListTile(
                      title: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 103, 103, 103)),
                      ),
                      value: e,
                      groupValue: selctedItemi,
                      activeColor: const Color(0xff368983),
                      onChanged: (value) {
                        setState(() {
                          selctedItemi = value as String;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Padding amount() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        focusNode: amount_,
        controller: amountC,
        onChanged: (value) {
          if (value.isNotEmpty) {
            try {
              double.parse(value);
            } catch (e) {
              showValidationDialog('Please enter a valid number');
            }
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Amount is required';
          }
          try {
            double.parse(value);
          } catch (e) {
            return 'Please enter a valid number';
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Amount',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 2, color: Color(0xff368983)),
          ),
        ),
      ),
    );
  }

  void showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Validation Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Padding purpose() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        focusNode: ex,
        controller: expalinC,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          labelText: 'Purpose',
          labelStyle: TextStyle(fontSize: 17, color: Colors.grey.shade500),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xffC5C5C5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 2, color: Color(0xff368983))),
        ),
      ),
    );
  }

  Padding cashFlow() {
    // cash flow
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: 300,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 2,
              color: const Color(0xffC5C5C5),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TypeAheadField(
                noItemsFoundBuilder: (context) => const SizedBox(
                  height: 50,
                  child: Center(
                    child: Text('No Item Found'),
                  ),
                ),
                debounceDuration: const Duration(milliseconds: 400),
                textFieldConfiguration: TextFieldConfiguration(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _textEditingController.text.isNotEmpty
                        ? _textEditingController.text
                        : 'Cash Flow',
                    hintStyle: TextStyle(
                      color: _textEditingController.text.isNotEmpty
                          ? Colors.black
                          : Colors.grey,
                      fontSize: 17,
                    ),
                    contentPadding: const EdgeInsets.only(top: 9, left: 0),
                    suffixIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 30,
                      ),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      selctedItem = null;
                    });
                  },
                ),
                suggestionsCallback: (value) {
                  return StateService.getSuggestions(value);
                },
                itemBuilder: (context, String suggestion) {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        '•',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xff368983),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text(
                            suggestion,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    selctedItem = suggestion;
                    _textEditingController.text = suggestion;
                  });
                },
              ),
            ],
          )),
    );
  }

  Column backgroundContainer(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 100,
          decoration: const BoxDecoration(
            color: Color(0xff368983),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const Text(
                      'Add Finances',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        color: isFavorite ? Colors.yellow : Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class StateService {
  static final List<String> _item = [
    "Childcare",
    "Clothing",
    "Debt Payments",
    "Education",
    "Emergency Fund",
    "Entertainment",
    "Food and Groceries",
    "Gifts",
    "Healthcare",
    "Home Improvement",
    "Housing",
    "Insurance",
    "Miscellaneous",
    "Other",
    "Personal Care",
    "Pet Expenses",
    "Savings",
    "Subscriptions",
    "Taxes",
    "Transportation",
    "Travel",
    "Utilities"
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = [];
    matches.addAll(_item);
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}
