import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


@immutable
class LogInState {
 var result;
  String token = '';
}



class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInState());
  void login(Map<String, dynamic> data) {
    
  }


}
