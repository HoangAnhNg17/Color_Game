// import 'package:color_game/bloc/gameplay.dart';
// import 'package:color_game/widget/logo.dart';
// import 'package:flutter/material.dart';
//
// class LeaderBoard extends StatefulWidget {
//   const LeaderBoard({Key? key,}) : super(key: key);
//   @override
//   State<LeaderBoard> createState() => _LeaderBoardState();
// }
//
// class _LeaderBoardState extends State<LeaderBoard> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: Column(
//         children: [
//           Logo(),
//           Text('SCORE RANKING',style: TextStyle(color: Colors.yellow),),
//           ListView.builder(
//             itemCount: widget.gamePlay.leaderBoard.value.length,
//             itemBuilder: (context, index){
//               return Row(
//                 children: [
//                   Text('$index.'),
//                   Text('${widget.gamePlay.leaderBoard.value[index]}')
//                 ],
//               );
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
