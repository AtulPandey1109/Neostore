import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';
import 'package:neostore/view/widgets/app_rounded_text_field.dart';
import 'package:neostore/view/widgets/social_media_footer.dart';
import 'package:neostore/viewmodel/login_bloc/login_bloc.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<LoginBloc>(context).add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.store_outlined,
                      size: 40,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Welcome Back', style: kHeaderTextStyle),
                    const Text("Sign in with your email and password"),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        AppRoundedTextField(
                          controller: _emailController,
                          icon: Icons.person_outline,
                          labelText: 'Your email',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        AppRoundedTextField(
                          controller: _passwordController,
                          icon: Icons.lock_outlined,
                          labelText: 'Your password',
                          obscureText: true,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.isMobile()
                          ? MediaQuery.sizeOf(context).width * 0.8
                          : MediaQuery.sizeOf(context).width * .3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                    ),
                    BlocConsumer<LoginBloc,LoginState>(
                      builder: (BuildContext context, LoginState state) {
                        if(state is InitialState) {
                          return AppRoundedElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(LoginClickEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            },
                            label:const Text('Login'),
                          );
                        }
                        else if(state is LoadingState){
                          return AppRoundedElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(LoginClickEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            },
                            label:const Center(child: Padding(
                              padding: EdgeInsets.all(4.0),
                              child:  AppCustomCircularProgressIndicator()
                            ),),
                          );
                        }
                        else {
                          return AppRoundedElevatedButton(
                            onPressed: () {
                              BlocProvider.of<LoginBloc>(context).add(LoginClickEvent(
                                  email: _emailController.text,
                                  password: _passwordController.text));
                            },
                            label:const Text('Login'),
                          );
                        }
                      },
                      listener: (BuildContext context, LoginState state) {
                        if (state is LoginSuccessfulState) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text('${state.response.data['message']}')));
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeScreen,(Route<dynamic> route) => false);
                        } else if (state is LoginFailureState) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text(state.message)));
                        }
                      },

                    ),
                    SizedBox(height: SizeConfig.getResponsiveHeight(context, 0.1)),
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: AppConstants.footerIcons.length,
                              itemBuilder: (context, int index) {
                                return SocialMediaFooter(
                                    icon:
                                        Icon(AppConstants.footerIcons[index],));
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Do not have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, AppRoutes.signupScreen);
                                },
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(color: kButtonColor),
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
          }
}
