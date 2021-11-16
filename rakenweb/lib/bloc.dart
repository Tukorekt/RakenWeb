import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'endpage.dart';
import 'main.dart';

abstract class CounterEvent {}

class GetCount extends CounterEvent {}
class Update extends CounterEvent {}
class NextStageBloc extends CounterEvent {}
class GetEnd extends CounterEvent {}
class OnCreate extends CounterEvent {}

class StringBloc extends Bloc<CounterEvent, Set<String>> {
  var i=-1;
  StringBloc(initialState) : super(initialState){

    on<Update>((event,emit){
      i+=1;
      emit({"$i", uniqueList.elementAt(i*2), uniqueList.elementAt(i*2+1)});
    });

    on<GetCount>((event,emit) async {
      var _temp =
          await http.get(Uri.parse('https://raken.000webhostapp.com/unique.php'));
      var _data = _temp.body;
      uniqueList = _data.split('<p>');
      uniqueList.removeAt(0);
      uniqueList = uniqueList.sublist(0, 64);
    });

    on<NextStageBloc>((event, emit){
      i = 0;
      Set<String> a = {};
      uniqueList.clear();
      uniqueList = chosenList.sublist(0);
      switch (uniqueList.length){
        case 8:
          for (var n in chosenList) {
            resp += n.toString()+",";
          }
          resp = resp.replaceAll(" ", "+");
          resp = resp.replaceRange(resp.lastIndexOf(","), resp.length, "");
          a = {"0","truee"," "};
      }
      round++;
      chosenList.clear();
      if (a.isEmpty) {
        a = {"$i", uniqueList.elementAt(i*2), uniqueList.elementAt(i*2+1)};
      }
      emit(a);
    });

    on<OnCreate>((event,emit) async {
      var _ss = await http.get(Uri.parse('https://raken.000webhostapp.com/chosen.php?Chosen=$resp'));
      data = _ss.body;
      print(data);
      data = data.replaceFirst("<p>", "");
      src = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      name = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      date = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      country = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      rating = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      kinds = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      pg = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      time = data.substring(0,data.indexOf("<p>"));
      data = data.replaceRange(0, data.indexOf("<p>")+3,"");
      print(data);
    });

    on<GetEnd>((event,emit) {
      src = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      name = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      date = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      country = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      rating = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      kinds = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      pg = data.substring(0,data.indexOf("*"));
      data = data.replaceRange(0, data.indexOf("*")+1,"");
      time = data.substring(0,data.indexOf("<p>"));
      data = data.replaceRange(0, data.indexOf("<p>")+3,"");
    });

  }
}

class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('${bloc.runtimeType} $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}