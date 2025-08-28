
import 'package:flutter/material.dart';

class DetailDefaultCard extends StatelessWidget {
    const DetailDefaultCard({super.key, required this.title, required this.placeholder, required this.value});

    final String title;
    final String? placeholder;
    final String value;


    @override
    Widget build(BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(left: BorderSide(width: 1, color: Colors.grey)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),),
                Text(placeholder ?? '', style: TextStyle(fontWeight: FontWeight.w200, fontSize: 12),),
                Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),),
            ],),
          ),
        );
    }
}