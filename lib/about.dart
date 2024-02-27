import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Image.asset('assets/ailogo.png',width: 240,height: 200,)),
          Container(
            height: 44,
            width:282,
            color: const Color.fromRGBO(3, 67, 1, 1),
            child: const Center(child: Text('About Us',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 25,color: Colors.white),)),
          ),

          Container(
            margin: const EdgeInsets.only(left: 10,right: 10,top: 50),
            child: const Text('There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour,'
                ' or randomised words which dont look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isnt anything embarrassing hidden in the middle of '
                'text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the'
                ' Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.'
                ,textAlign: TextAlign.justify,),
          )
        ],
      )
    );
  }
}
