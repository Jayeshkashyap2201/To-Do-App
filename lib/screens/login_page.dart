import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/screens/to_do_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupPassword = TextEditingController();
  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    signupEmail.dispose();
    signupPassword.dispose();
    super.dispose();
  }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1A237E),
              Color(0xFF6A1B9A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
          child:CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("Login yourself",textAlign:TextAlign.start,style: TextStyle(color: Colors.blueGrey,fontSize: size.width * 0.055),),
                  collapseMode: CollapseMode.parallax,
                ),
                floating: true,
                pinned: true,
                elevation: 4,
                expandedHeight: 200,
                collapsedHeight: 100,
                shadowColor: Colors.grey,
                backgroundColor: Colors.transparent,
                actions: [
                  //Image(image: NetworkImage(""))
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.1,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white.withOpacity(0.95),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: size.height * 0.031,),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: emailController,
                                decoration: InputDecoration(
                                  labelText: "email",
                                  hintText: "enter your email",
                                  prefixIcon: Icon(Icons.email,color: Colors.deepPurple,),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.031,),
                              TextFormField(
                                keyboardType: TextInputType.text,
                                controller: passwordController,
                                decoration: InputDecoration(
                                    labelText: "password",
                                    hintText: "enter your password",
                                    prefixIcon: Icon(Icons.password,color: Colors.deepPurple,),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.deepPurple, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: BorderSide(color: Colors.indigo, width: 2),
                                  ),
                                ),
                              ),
                              SizedBox(height: size.height * 0.031,),


                              SizedBox(
                                width: double.infinity,
                                height: size.height * 0.05,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () async{
                                    try{
                                      FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Successfully")));
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoScreen()));
                                    }
                                    catch(e){
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text("Login Failed"),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  child: Ink(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF6A1B9A),
                                          Color(0xFF1A237E),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )
                                ),
                              ),
                              SizedBox(height: size.height * 0.031,),
                              Row(
                                children: [
                                  Text("Are you a new User?",style: TextStyle(fontSize: size.width*0.04,),),
                                  TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return SizedBox(
                                            width: size.width * 0.9,
                                            child: AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              title: const Text(
                                                "Create User",
                                                style: TextStyle(fontWeight: FontWeight.bold),
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextField(
                                                    controller: signupEmail,
                                                    decoration: InputDecoration(
                                                      labelText: "Email",
                                                      prefixIcon: Icon(Icons.email),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 15),
                                                  TextField(
                                                    controller: signupPassword,
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      labelText: "Password",
                                                      prefixIcon: Icon(Icons.lock),
                                                      border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Cancel"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    try {
                                                      await FirebaseAuth.instance
                                                          .createUserWithEmailAndPassword(
                                                        email: signupEmail.text.trim(),
                                                        password: signupPassword.text.trim(),
                                                      );
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ToDoScreen()));
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        const SnackBar(
                                                          content: Text("Account Created Successfully"),
                                                          backgroundColor: Colors.green,
                                                        ),
                                                      );
                                                    } catch (e) {
                                                      print(e.toString());
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text("Something went wrong please try again!"),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: const Text("Signup"),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Text("Signup",style: TextStyle(fontSize: size.width*0.04, fontWeight: FontWeight.bold,),)
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}
