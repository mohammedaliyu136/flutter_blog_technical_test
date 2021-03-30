import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_tech_test/authentication/bloc/auth_bloc.dart';

import 'authentication/login.dart';
import 'post/bloc/post_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PostsBloc>(
          create: (context) => PostsBloc()..add(LoadPostsEvent())),
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage()//PostList()//MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}