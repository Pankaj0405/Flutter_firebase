import 'package:flutter/material.dart';


class Card1 extends StatefulWidget {
  final snap;
  const Card1({Key? key,
    required this.snap}) : super(key: key);

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [

          Expanded(
            child: Padding(
              padding:EdgeInsets.only(left: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 70,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: RichText(
                      textAlign: TextAlign.start,
                      
                      text: TextSpan(
                      children:[ TextSpan(
                        text: widget.snap['username'],
                        style: TextStyle(

                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                        ),
                      ),
                        TextSpan(
                          text: '  ${widget.snap['email']}',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20
                          )

                        ),
                      ],
                    ),
                    ),
                  ),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
