
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:flutter/material.dart';


class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Homepage')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            Text('Home Page'),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenetaror.news);
                

              },
              child: Text('New News'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenetaror.savedNews);
              },
              child: Text('Saved News'),
            ),
          ],
        ),
      ),
    );
  }
}