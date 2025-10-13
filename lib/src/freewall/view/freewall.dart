import 'package:flutter/material.dart';

class FreeWallPage extends StatelessWidget {
    const FreeWallPage({super.key});

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('FreeWall'),
            ),
            body: Center(
                child: Text('FreeWall'),
            ),
        );
    }
}