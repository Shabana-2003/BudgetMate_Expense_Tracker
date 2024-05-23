// import 'package:budgetmate/features/auth/domain/usecases/send_password_reset_link.dart';
// import 'package:flutter/material.dart';

// class ForgotPasswordPage extends StatefulWidget {
//   final SendPasswordResetLink sendPasswordResetLink;

//   const ForgotPasswordPage({Key? key, required this.sendPasswordResetLink}) : super(key: key);

//   @override
//   State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
// }

// class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   final _email = TextEditingController();

//   @override
//   void dispose() {
//     super.dispose();
//     _email.dispose();
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
//                 const SizedBox(height: 200),
//                 const Text(
//                   'FORGOT PASSWORD',
//                   style: TextStyle(
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 13, 0, 0)),
//                 ),
//                 const SizedBox(height: 161),
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: TextFormField(
//                           controller: _email,
//                           decoration: const InputDecoration(
//                             labelText: 'Email',
//                           ),
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter your email';
//                             }
//                             return null;
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 97),
//                 ElevatedButton(
//                   onPressed: _sendPasswordResetLink,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color.fromARGB(255, 47, 125, 121),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 60, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'SEND MAIL',
//                     style: TextStyle(
//                         color: Color.fromARGB(255, 255, 255, 255),
//                         fontFamily: "Gruppo-Regular"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   _sendPasswordResetLink() async {
//     if (_formKey.currentState?.validate() ?? false) {
//       await widget.sendPasswordResetLink(_email.text);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Password reset email sent")),
//       );
//       Navigator.pop(context);
//     }
//   }
// }
import 'package:budgetmate/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter/material.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _auth = AuthRemoteDataSource();
  final _email =TextEditingController();

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
                const SizedBox(height: 200),
                const Text(
                  'FORGOT PASSWORD',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:Color.fromARGB(255, 13, 0, 0),
                      ),
                ),
                const SizedBox(height: 161),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextFormField(
                          controller: _email,
                          decoration:const InputDecoration(
                            labelText: 'Email',
                            
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            
                            return null;
                          },
                          style:const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              ),
                        ),
                      ),
                     
                    ],
                  ),
                ),
                const SizedBox(
                  height: 97,
                ),

                ElevatedButton(
                  onPressed: () async{
                 await _auth.sendPasswordResetLink(_email.text);
                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An email for password has been sent to your email")));
                 Navigator.pop(context);
                  },
                 
                  style: ElevatedButton.styleFrom(
                    backgroundColor:const Color.fromARGB(255, 47, 125, 121),
                     
                    padding:const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                   child:const Text(
                    'SEND MAIL',
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255), fontFamily: "Gruppo-Regular"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
