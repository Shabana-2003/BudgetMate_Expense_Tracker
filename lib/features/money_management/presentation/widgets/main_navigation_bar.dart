import 'package:budgetmate/features/money_management/presentation/pages/add/add_screen.dart';
import 'package:budgetmate/features/money_management/presentation/pages/categories.dart';
import 'package:budgetmate/features/money_management/presentation/pages/home_page/home.dart';
import 'package:budgetmate/features/money_management/presentation/pages/search.dart';
import 'package:budgetmate/features/money_management/presentation/pages/category/category_screen.dart';
import 'package:flutter/material.dart';

class MainNavigationBar extends StatefulWidget {
  const MainNavigationBar({super.key});

  @override
  State<MainNavigationBar> createState() => _MainNavigationBarState();
}
class _MainNavigationBarState extends State<MainNavigationBar> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  int indexColor = 0;
  final List<Widget> screens = [
    const Home(),
    const Searchh(),
    const ViewAll(),
    const CategoryScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[indexColor],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => 
          const AddScreen()
          ));
        },
        backgroundColor:const Color(0xff368983),
        child:const Icon(Icons.add,color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape:const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.only(top: 7.5, bottom: 7.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildAnimatedIcon(Icons.home, 0),
              buildAnimatedIcon(Icons.search, 1),
              const  SizedBox(width: 10),
              buildAnimatedIcon(Icons.calendar_today, 2),
              buildAnimatedIcon(Icons.category, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedIcon(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          indexColor = index;
        });
        _animationController.reset();
        _animationController.forward();
      },
      child: RotationTransition(
        turns: CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
        child: Icon(
          icon,
          size: 30,
          color: indexColor == index ?const Color(0xff368983) : Colors.grey,
        ),
      ),
    );
  }
}
