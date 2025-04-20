import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_list_hive/home.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
                
                
      }, backgroundColor: Colors.grey
      ,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)), child: Icon(IconlyBold.arrow_right_2 ),
      ),
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Column(
          children: [
            Lottie.asset("assets/lottie/ani2.json", width: 700),
            Text("TODO LIST", style: TextStyle(color: Colors.white, fontFamily: "myfont" ,fontSize: 34),),
          
          ],
        ),
      ),
    );
  }
}
