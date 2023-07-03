import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:todo_quest/resources/auth_methods.dart';
import 'package:todo_quest/screens/login_screen.dart';
import 'package:todo_quest/screens/mobile_screen_layout.dart';
import 'package:todo_quest/utils/utils.dart';
import 'package:todo_quest/widgets/text_field_input.dart';
Uint8List? _image;
bool _isLoading=false;
class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() {
    // TODO: implement createState
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  String dropdownvalue = 'Where are you coming from';

  // List of items in our dropdown menu
  var items = [
    'Where are you coming from',
    'Facebook',
    'Organic',
    'Friend',
    'Google',
    'Instagram'
  ];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }


  Future<void> signUpUser() async {
    setState(() {
      _isLoading=true;
    });
    String res= await AuthMethods().signUpUser(email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      bio: _bioController.text,
      );
    setState(() {
      _isLoading=false;
    });
    if(res!='success'){
showSnackBar(res , context);
    }else{
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
          (context)=>const MobileScreenLayout(),),
      );

    }
  }
  void navigateToLogin(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(

            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 64),

                const SizedBox(height: 64),

                const SizedBox(height: 24),
                TextFieldInput(
                    textEditingController: _usernameController,
                    textInputType: TextInputType.text,
                    hintText: "Enter Your username"),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                    textEditingController: _emailController,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Enter Your email"),
                const SizedBox(
                  height: 24,
                ),
                TextFieldInput(
                  textEditingController: _passwordController,
                  textInputType: TextInputType.text,
                  hintText: "Enter Your password",
                  isPass: true,
                ),
                const SizedBox(
                  height: 24,
                ),

                Container(

                  child: DropdownButton(


                    // Initial Value
                    value: dropdownvalue,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvalue = newValue!;
                        _bioController.text=newValue!;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),

                InkWell(
                  onTap:signUpUser,
    child: Container(
                    child: _isLoading? const Center(child: CircularProgressIndicator(
                      color: Colors.white,
                    ),) :const Text("Sign up"),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                        ),
                        color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(

                  height: 24,
                ),
                const SizedBox(height: 64),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text("Already have an account?"),
                      padding: const EdgeInsets.symmetric(vertical: 8,),
                    ),
                    GestureDetector(
                      onTap: navigateToLogin,
                      child: Container(
                        child: const Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8,),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
