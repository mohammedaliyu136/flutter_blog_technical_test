import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_tech_test/post/bloc/bloc.dart';
import 'package:flutter_blog_tech_test/post/post_list.dart';

import 'bloc/auth_bloc.dart';
import 'bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if(state is AuthenticatingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is AuthenticatedState){
              return PostList();
            }else if(state is NotAuthenticatedState || state is AuthInitial){
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login", style: TextStyle(color: Colors.black, fontSize: 60,fontWeight: FontWeight.w600)),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:4.0, horizontal: 20.0),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Email'
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red[500],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:4.0, horizontal: 20.0),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter Password'
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.red[500],
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(child: RaisedButton(
                          onPressed: (){
                            BlocProvider.of<AuthBloc>(context).add(LoginEvent(emailController.text, passwordController.text));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text("Login", style: TextStyle(fontSize: 20),),
                          ),
                          color: Colors.red[500],
                          textColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        )),
                      ],
                    )
                  ],),
              );
            }else{
              return Container();
            }

        }
      ),
    );
  }
}