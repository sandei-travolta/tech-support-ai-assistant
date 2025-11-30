import 'package:admin_panel/utils/colors.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  Loginpage({super.key});
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: 15.0,
            left: 10.0,
            right: 10.0
          ),
          height: MediaQuery.heightOf(context)*0.6,
          width: MediaQuery.heightOf(context)*0.5,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
                width: 2,
                color: AppColors.grey1,
            ),
            borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(60, 64, 67, 0.3),
                  blurRadius: 2,
                  spreadRadius: 0,
                  offset: Offset(0, 1),
                ),
                BoxShadow(
                  color: Color.fromRGBO(60, 64, 67, 0.15),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 2),
                )
              ]
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: .start,
              mainAxisAlignment: .center,
              spacing: 15.0,
              children: [
                Text("Sign In",style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: .bold
                ),
                ),
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "email cant be null";
                    }
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hint: Text("email"),
                    prefixIcon: Icon(Icons.email)
                  ),
                ),
                TextFormField(
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return "Password cant be null";
                    }
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Password"),
                      prefixIcon: Icon(Icons.lock_outline)
                  ),
                ),
                Text("Forgot Password"),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: MediaQuery.widthOf(context)*0.8,
                  child: ElevatedButton(
                      onPressed: (){
                  }, child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: .w600
                    ),),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black
                    )
                  ),

                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
