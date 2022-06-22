import 'package:flutter/material.dart';

class CardView extends StatelessWidget {
  const CardView({
    Key? key,
    this.text = "Card View",
    this.image = "assets/image_1.jpg",

  }) : super(key: key);
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: <Widget>[
          // SizedBox.expand(
          //   child: Material(
          //     borderRadius: BorderRadius.circular(15),
          //     child: Container(
          //       color: Colors.blueAccent,
          //     ),
          //   ),
          // ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.fitHeight,
                    alignment: Alignment.topCenter,
                  ),
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter)
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text("$text details",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}