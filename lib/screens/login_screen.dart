import 'package:flutter/material.dart';

import 'package:todo_quest/resources/auth_methods.dart';
import 'package:todo_quest/screens/mobile_screen_layout.dart';
import 'package:todo_quest/screens/signup_screen.dart';
import 'package:todo_quest/utils/utils.dart';
import 'package:todo_quest/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() {
    // TODO: implement createState
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
bool _isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
Future<void> loginUser() async {
    setState(() {
      _isLoading=true;
    });
    String res=await AuthMethods().loginUser(email: _emailController.text
        , password: _passwordController.text);
    if(res=='success'){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder:
          (context)=>const MobileScreenLayout()),
      );

    }else{
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading=false;
    });
}
void navigateToSignup(){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
          EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),

              const SizedBox(height: 64),
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
              InkWell(
                onTap: loginUser,
                child: Container(
                  child: _isLoading? Center(child: CircularProgressIndicator(
                    color: Colors.white,
                  ),):  const Text("Login"),
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
              Flexible(
                child: Container(),
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Don't have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8,),
                  ),
                  GestureDetector(
                    onTap: navigateToSignup,
                    child: Container(
                      child: const Text("Sign up",
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
    );
  }
}
