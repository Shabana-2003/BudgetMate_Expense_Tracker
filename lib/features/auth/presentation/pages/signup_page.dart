// import 'package:budgetmate/features/auth/domain/usecases/create_user_with_email_and_password.dart';
// import 'package:flutter/material.dart';

// class SignupPage extends StatefulWidget {
//   final CreateUserWithEmailAndPassword createUser;

//   const SignupPage({Key? key, required this.createUser}) : super(key: key);

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final _name = TextEditingController();
//   final _email = TextEditingController();
//   final _password = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _name.dispose();
//     _email.dispose();
//     _password.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         fit: StackFit.expand,
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 150),
//                 const Text(
//                   'JOIN BUDGETMATE NOW',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromARGB(255, 0, 0, 0),
//                   ),
//                 ),
//                 const SizedBox(height: 50),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           controller: _name,
//                           decoration: const InputDecoration(labelText: 'Name'),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your name';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           controller: _email,
//                           decoration: const InputDecoration(labelText: 'Email'),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           controller: _password,
//                           decoration: const InputDecoration(labelText: 'Password'),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your password';
//                             }
//                             return null;
//                           },
//                           obscureText: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 85),
//                 ElevatedButton(
//                   onPressed: _signup,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 47, 125, 121),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 60, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'SIGNUP',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 0, 0, 0),
//                         fontFamily: "Gruppo-Regular"),
//                   ),
//                 ),
//                 const SizedBox(height: 155),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Already have an account? ",
//                       style: TextStyle(
//                         fontFamily: "Gruppo-Regular",
//                         color: Color.fromARGB(255, 62, 62, 62),
//                         fontSize: 15,
//                       ),
//                     ),
//                     InkWell(
//                       onTap: () => Navigator.pop(context),
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           fontFamily: "Gruppo-Regular",
//                           color: Color.fromARGB(255, 59, 59, 247),
//                           fontSize: 15,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _signup() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       await widget.createUser(_email.text, _password.text);
//       Navigator.pop(context);
//     }
//   }
// }
import 'package:budgetmate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:budgetmate/features/auth/presentation/pages/login_page.dart';
import 'package:budgetmate/features/finance/presentation/pages/home_page/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _auth = AuthRemoteDataSource();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 150), // Adjust the height as needed
                const Text(
                  'JOIN BUDGETMATE NOW',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
                const SizedBox(height: 50),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _name,
                          decoration: const InputDecoration(
                            labelText: 'Name',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _password,
                          decoration: const InputDecoration(
                            labelText: 'Password',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }

                            return null;
                          },
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 85,
                ),

                ElevatedButton(
                  onPressed: _signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 47, 125, 121),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'SIGNUP',
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontFamily: "Gruppo-Regular"),
                  ),
                ),
                const SizedBox(height: 155),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontFamily: "Gruppo-Regular",
                      color: Color.fromARGB(255, 62, 62, 62),
                      fontSize: 15,
                    ),
                  ),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: "Gruppo-Regular",
                        color: Color.fromARGB(255, 59, 59, 247),
                        fontSize: 15,
                      ),
                    ),
                  )
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );

  _signup() async {
    await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    Navigator.pop(context);
  }
}
