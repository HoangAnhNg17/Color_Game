import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('C',style: TextStyle(fontSize: 30,color: Colors.red, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('O',style: TextStyle(fontSize: 30,color: Colors.yellow, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('L',style: TextStyle(fontSize: 30,color: Colors.green, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('O',style: TextStyle(fontSize: 30,color: Colors.brown, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('R',style: TextStyle(fontSize: 30,color: Colors.blue, fontWeight: FontWeight.w700),),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('G',style: TextStyle(fontSize: 30,color: Colors.grey, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('A',style: TextStyle(fontSize: 30,color: Colors.teal, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('M',style: TextStyle(fontSize: 30,color: Colors.amber, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('E',style: TextStyle(fontSize: 30,color: Colors.cyanAccent, fontWeight: FontWeight.w700),),
            ),
          ],
        ),
      ],
    );
  }
}
