import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neostore/authentication/login/viewmodel/login_bloc/login_bloc.dart';


class SocialMediaFooter extends StatelessWidget {
  const SocialMediaFooter(
      {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          child: IconButton(onPressed: (){
            BlocProvider.of<LoginBloc>(context).add(GoogleSignInEvent());
          }, icon: const Icon(FontAwesomeIcons.google)),
        )),
            Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          child: IconButton(onPressed: (){
            BlocProvider.of<LoginBloc>(context).add(FacebookSignInEvent());
          }, icon: const Icon(FontAwesomeIcons.facebook)),
        )),
            Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: CircleAvatar(
          backgroundColor: Colors.white70,
          child: IconButton(onPressed: (){}, icon: const Icon(FontAwesomeIcons.twitter)),
        )),
          ],
          ),
    );
  }
}

