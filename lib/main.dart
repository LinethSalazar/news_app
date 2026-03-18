import 'package:fake_assigment_1/Hive/storage.dart';
import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:hive_flutter/hive_flutter.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  runApp(
    BlocProvider(
      create: (_) => NewsCubit()..databaseSingleton(),
      child: MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //to save loong press in the new :)
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      onGenerateRoute: RouteGenetaror.generateRoute,
      initialRoute: RouteGenetaror.home,
    );
  }
}


