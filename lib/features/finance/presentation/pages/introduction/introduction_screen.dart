import 'package:budgetmate/features/auth/presentation/widgets/wrapper_functiondart.dart';
import 'package:flutter/material.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});


  @override
  IntroductionScreenState createState() => IntroductionScreenState();
}

class IntroductionScreenState extends State<IntroductionScreen> {
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0; 
  final List<IntroductionItem> _introductionItems = [
    IntroductionItem(
      image: 'assets/images/image11.jpeg',
      title: 'Welcome to BudgetMate',
      description:
          'Your one-stop financial hub for managing, tracking, and growing your money.',
    ),
    IntroductionItem(
      image: 'assets/images/image22.jpeg',
      title: 'Join BudgetMate',
      description: 'With BudgetMate, financial empowerme is at your fingertips.',
    ),
    IntroductionItem(
      image: 'assets/images/image33.jpeg',
      title: 'Explore BudgetMate',
      description:
          'Are you ready to take charge of your financial future? increasing your financial assets.',
    ),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration:const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          PageView.builder(
            controller: _controller,
            itemCount: _introductionItems.length, 
            onPageChanged: (page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildIntroductionPage(_introductionItems[index]);
            },
          ),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildIntroductionPage(IntroductionItem item) {
    return Container(
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           const SizedBox(
              height: 150,
            ),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 50.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(item.image),
              ),
            ),
           const SizedBox(
              height: 50,
            ),
            Text(
              item.title,
              style:const TextStyle(
                fontSize: 20,
                color:Color.fromARGB(255, 11, 11, 11),
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(
              height: 15,
            ),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                item.description,
                style:const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 171, 166, 166),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(70.0),
        child: ElevatedButton(
          onPressed: () {
            if (_currentPage < _introductionItems.length - 1) {
              _controller.nextPage(
                duration:const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            } else {
              Navigator.of(context).pushReplacement(
                 MaterialPageRoute(builder: (context) =>const 
                 WrapperFunction()),
              );
            }
          },
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
           const EdgeInsets.symmetric(
                  horizontal: 50.0,
                  vertical: 15.0
                  ), 
            ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(15.0), 
              ),
            ),

            backgroundColor: MaterialStateProperty.all<Color>(
             const Color.fromARGB(255, 47, 125, 121)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_currentPage == _introductionItems.length - 1
                  ? 'Get Started'
                  : 'Next', style:const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255), 
      ),),
            ],
          ),
        ),
      ),
    );
  }
}

class IntroductionItem {
  final String image;
  final String title;
  final String description;

  IntroductionItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

void main() {
  runApp(const MaterialApp(
    home: IntroductionScreen(),
  ));
}
