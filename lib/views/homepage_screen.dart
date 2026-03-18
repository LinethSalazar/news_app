
import 'package:fake_assigment_1/routers/route_generator.dart';
import 'package:flutter/material.dart';


class HomepageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color.fromARGB(255, 0, 108, 7), 
                  Color.fromARGB(255, 107, 0, 0), 
                ],
              ).createShader(bounds),
              child:Column(
                children: [
                    Text(
                    'UPEI News',
                    style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                    color: Colors.white, 
                    )
                  ),
                ]
              ),
            ),
            

            Image.asset("images/logsimple.png", width: 200, height: 200),
            
            SizedBox(height:40),

            ElevatedButton.icon(
              
              onPressed: () {
                Navigator.pushNamed(context, RouteGenetaror.news);
                

              },
              icon: Icon(Icons.feed),
              label: Text('New News'),
                            style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 228, 255, 236),
                foregroundColor: Color.fromARGB(255, 0, 108, 7),
              ),

            ),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenetaror.savedNews);
              },
              icon: Icon(Icons.bookmark),
              label: Text('Saved News'),
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromARGB(255, 255, 210, 210), foregroundColor: Color.fromARGB(255, 107, 0, 0), ),
            ),
            
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.pushNamed(context, RouteGenetaror.sesett),
            ),
            SizedBox(height: 35)


          ],
        ),
      ),
    );
  }
}