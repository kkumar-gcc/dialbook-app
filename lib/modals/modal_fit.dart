import 'package:flutter/material.dart';

class ModalFit extends StatelessWidget {
  final Widget child;
  const ModalFit({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
