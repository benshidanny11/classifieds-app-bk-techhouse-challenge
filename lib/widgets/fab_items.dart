import 'package:classfiedapp/screens/add_product.dart';
import 'package:classfiedapp/screens/welcome.dart';
import 'package:classfiedapp/services/AuthService.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Bubble> getFabItems(animationController, context) {
  return <Bubble>[
    // Floating action menu item
    Bubble(
      title: "Add product",
      iconColor: Colors.white,
      bubbleColor: Theme.of(context).primaryColor,
      icon: FontAwesomeIcons.basketShopping,
      titleStyle: const TextStyle(fontSize: 16, color: Colors.white),
      onPress: () {
        Navigator.pushReplacementNamed(context, ProductForm.id);
        animationController!.reverse();
      },
    ),
    // Floating action menu item
    Bubble(
      title: "Sign out",
      iconColor: Colors.white,
      bubbleColor: Theme.of(context).primaryColor,
      icon: FontAwesomeIcons.arrowRightFromBracket,
      titleStyle: TextStyle(fontSize: 16, color: Colors.white),
      onPress: () async {
        await AuthService.signOut();
        Navigator.pushReplacementNamed(context, Welcome.id);
        animationController!.reverse();
      },
    ),
  ];
}
