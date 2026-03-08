
import 'package:fake_assigment_1/cubit/new_cubit.dart';
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Text('HOme Page'),

            ElevatedButton(
              onPressed: () {
                context.read<NewsCubit>().displayOnlineNews();
                Navigator.pushNamed(context, RouteGenetaror.news);
                

              },
              child: Text('New News'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<NewsCubit>().displaySaved();
                Navigator.pushNamed(context, RouteGenetaror.news);
              },
              child: Text('Saved News'),
            ),
          ],
        ),
      ),
    );
  }
}