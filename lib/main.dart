import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled/Screen/BirdSelection.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

     debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),

      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Padding(
        padding: const EdgeInsets.only(left: 300),
        child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               Lottie.asset('assets/bard.json',height: 400,fit: BoxFit.cover),
                Text(
                  "AI Driven Bangladeshi Bird Recognition",
                  style: GoogleFonts.roboto(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  )
                ),
                SizedBox(height: 20),
               ElevatedButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return BirdSelection();
                 }));
               }, style: ElevatedButton.styleFrom(
                 backgroundColor: Colors.green, // Set the background color here
               ),child:  Padding(
                 padding: EdgeInsets.all(8),
                 child: Text("Lets Explore",style: GoogleFonts.roboto(
                   fontSize: 25,
                   color: Colors.white,
                   fontWeight: FontWeight.bold,
                 ),),
               ),)
              ],
            ),
      ),



    );
  }
}
