abstract class AllStates{

}
class InitialState extends AllStates{

}
class LoadingState extends AllStates{

}
class LoadedState extends AllStates{
  late List<dynamic> data;
  LoadedState({required this.data});
}
class ErrorState extends AllStates {
  late String e;
  ErrorState({required this.e});
}