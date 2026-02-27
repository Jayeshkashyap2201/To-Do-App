import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/screens/login_page.dart';
import 'package:to_do_app/screens/to_do_screen.dart';
import 'package:to_do_app/state_management/state_working.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider<StateWorking>(
          create: (BuildContext context)=>StateWorking()..working(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            textTheme: TextTheme(titleLarge: TextStyle(color: Colors.black,fontSize: size.width * 0.025,fontWeight: FontWeight.bold))
        ),
        home: const LoginPage(),
      )
    );
  }
}
