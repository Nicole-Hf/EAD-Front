// ignore_for_file: use_build_context_synchronously, use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:proy_taller/models/api_response.dart';
import 'package:proy_taller/models/user.dart';
import 'package:proy_taller/screens/forgot_password.dart';
import 'package:proy_taller/screens/home.dart';
import 'package:proy_taller/services/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtEmailController = TextEditingController();
  TextEditingController txtPasswordController = TextEditingController();
  bool loading = false;
  bool passwordVisibility = false;

  void _loginUser() async {
    ApiResponse response = await login(txtEmailController.text, txtPasswordController.text);
    if (response.error == null) {
      _saveAndRedirectToHome(response.data as User);
    }
    else {
      setState(() {
        loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${response.error}'))
      );
    }
  }

  void _saveAndRedirectToHome(User user) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),), (route) => false);
  }

  @override
  void initState() {
    super.initState();
    passwordVisibility = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/fondodos.jpg"),
                fit: BoxFit.fitHeight
              )
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 180, 20, 0),
            child: Form(
              key: formKey,
              child: ListView(
                padding: const EdgeInsets.all(8.0),
                children: [           
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: txtEmailController,
                    validator: (val) => val!.isEmpty ? 'Invalid email address' : null,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Correo electrónico',
                      labelStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'Ingresa tu email...',
                      hintStyle: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, 
                          color: Color(0xFFDBE2E7)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      )
                    )
                  ),
                  const SizedBox(height: 10,),
                  TextFormField(
                    obscureText: !passwordVisibility,
                    controller: txtPasswordController,
                    validator: (val) => val!.length < 6 ? 'Required at least 6 chars' : null,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () => setState(
                          () => passwordVisibility = !passwordVisibility,
                        ),
                        focusNode: FocusNode(skipTraversal: true),
                        child: Icon(
                          passwordVisibility
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                          color: const Color(0xFF95A1AC),
                          size: 22,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: 'Contraseña',
                      labelStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      hintText: 'Ingresa tu contraseña...',
                      hintStyle: const TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Color(0xFF95A1AC),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      contentPadding: const EdgeInsetsDirectional.fromSTEB(16, 24, 0, 24),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2, 
                          color: Color(0xFFDBE2E7)
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    )
                  ),
                  const SizedBox(height: 30,),
                  loading ? const Center(child: CircularProgressIndicator(),)
                  : ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        _loginUser();
                      }
                    },
                    style: ButtonStyle(   
                      elevation: MaterialStateProperty.resolveWith((states) => 2),             
                      backgroundColor: MaterialStateColor.resolveWith((states) => const Color.fromARGB(255, 152, 68, 255)),
                      side: MaterialStateProperty.resolveWith((states) => 
                        const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        )
                      ),
                      padding: MaterialStateProperty.resolveWith((states) => const EdgeInsetsDirectional.fromSTEB(50, 15, 50, 15)),
                    ), 
                    child: const Text('Login', 
                      style: TextStyle(
                        fontFamily: 'Lexend Deca',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Olvidaste tu contraseña? ', 
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      GestureDetector(
                        child: const Text('Ingresa aquí', 
                          style: TextStyle(
                            color: Colors.blue, 
                            decoration: TextDecoration.underline,
                            fontSize: 18
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => ForgotPassword(),), 
                            (route) => false
                          );
                        },
                      )
                    ],
                  )
                ]
              )
            ),
          )
        ]
      )
    );
  }
}