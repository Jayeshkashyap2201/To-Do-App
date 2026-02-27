import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/state_management/all_states.dart';
import '../state_management/state_working.dart';
class ToDoScreen extends StatefulWidget {
  const ToDoScreen({super.key});

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen> {
  String filter = "all";
  @override
  void initState(){
    super.initState();
    Future.microtask(() {
      context.read<StateWorking>().working();
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          SizedBox(width: size.width * 0.1,),
          ElevatedButton(
            onPressed: (){
              setState(() {
                filter = "completed";
              });
            },
            child: Text("Completed")
          ),
          Expanded(child: Container()),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  filter = "pending";
                });
              },
              child: Text("Pending")
          ),
          Expanded(child: Container()),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  filter = "all";
                });
              },
              child: Text("All")
          ),
          SizedBox(width: size.width * 0.07,),
        ],

      ),
      body: BlocBuilder<StateWorking, AllStates>(
        builder:(context, state){
          if(state is LoadingState){
            return Center(child: SpinKitThreeBounce(color: Colors.blue,),);
          }
          if(state is LoadedState){
            List filteredList;
            if (filter == "completed"){
              filteredList =
                  state.data.where((e) => e["completed"] == true).toList();
            }
            else if (filter == "pending"){
              filteredList =
                  state.data.where((e) => e["completed"] == false).toList();
            }
            else{
              filteredList = state.data;
            }
            return ListView.separated(
              itemCount: state.data.length,
              separatorBuilder: (context,_){
                return SizedBox(
                  height: size.height * 0.0031,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                bool isDone = filteredList[index]["completed"];
                return Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15.0,top: 10),
                  child: SizedBox(
                    height: size.height * 0.11,
                    width: size.width * 0.5,
                    child: Card(
                      child: ListTile(
                        tileColor: Colors.purple.shade100,
                          leading: CircleAvatar(radius: 25,child: Text(filteredList[index]["userId"].toString()),),
                          title: Text(filteredList[index]["id"].toString()),
                          subtitle: Text(filteredList[index]["title"].toString(),style: TextStyle(fontSize: size.width * 0.027),),
                          trailing: Text(filteredList[index]["completed"] ? "Completed" : "Pending"),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is ErrorState){
            return SnackBar(content: Text("Something went wrong"));
          }
          else{
            return Container();
          }
        }
      ),
    );
  }
}
