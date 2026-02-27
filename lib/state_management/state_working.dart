import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/http/get_data.dart';
import 'package:to_do_app/state_management/all_states.dart';

class StateWorking extends Cubit <AllStates>{
  StateWorking() : super(InitialState());
  working() async{
    try{
      emit (LoadingState());
      final data = await getData();
      emit(LoadedState(data: data));
    }
    catch(e){
      emit(ErrorState(e: e.toString()));
    }
  }
}