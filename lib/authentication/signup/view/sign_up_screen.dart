import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/authentication/signup/viewmodel/signup_bloc/sign_up_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/utils/app_text_field_validator.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_rounded_button.dart';
import 'package:neostore/widgets/app_rounded_text_field.dart';
import 'package:neostore/widgets/social_media_footer.dart';

enum Gender { male, female }

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  final ValueNotifier<String> selectedGender = ValueNotifier('male');

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignUpBloc>(context).add(SignupInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Register Account', style: kHeaderTextStyle),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: SizeConfig.isMobile()
                      ? MediaQuery.sizeOf(context).width * 0.8
                      : MediaQuery.sizeOf(context).width * .3,
                  child: Column(
                    children: [
                      AppRoundedTextField(
                        controller: _firstnameController,
                        icon: Icons.person_outline,
                        labelText: 'Enter your first name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppRoundedTextField(
                        controller: _lastnameController,
                        icon: Icons.person_outline,
                        labelText: 'Enter your last name',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppRoundedTextField(
                        controller: _phoneNumberController,
                        icon: Icons.phone_android_outlined,
                        labelText: 'Enter your phone number',
                        validator: AppTextFieldValidator.validatePhoneNumber,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              Icons.male_outlined,
                              size: 25,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                'Gender',
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                          ],
                        ),
                      ),
                      ValueListenableBuilder(
                        valueListenable: selectedGender,
                        builder: (BuildContext context, value, Widget? child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                      value: 'male',
                                      groupValue: selectedGender.value,
                                      onChanged: (value) {
                                        selectedGender.value = value!;
                                      }),
                                  const Text(
                                    'Male',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: 'female',
                                      groupValue: selectedGender.value,
                                      onChanged: (value) {
                                        selectedGender.value = value!;
                                      }),
                                  const Text('Female',
                                      style: TextStyle(fontSize: 16))
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      AppRoundedTextField(
                        controller: _emailController,
                        icon: Icons.mail_outline,
                        labelText: 'Enter your email',
                        validator: AppTextFieldValidator.validateEmail,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppRoundedTextField(
                        controller: _passwordController,
                        icon: Icons.lock_outlined,
                        labelText: 'Your password',
                        obscureText: true,
                        validator: AppTextFieldValidator.isValidPassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppRoundedTextField(
                        controller: _confirmPasswordController,
                        icon: Icons.lock_outlined,
                        labelText: 'Confirm password',
                        obscureText: true,
                        validator: AppTextFieldValidator.isValidPassword,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                BlocConsumer<SignUpBloc, SignupState>(
                  builder: (BuildContext context, SignupState state) {
                    if (state is SignUpInitialState) {
                      return AppRoundedElevatedButton(
                        onPressed: () {
                          if (_confirmPasswordController.text ==
                              _passwordController.text) {
                            BlocProvider.of<SignUpBloc>(context).add(
                                SignupClickEvent(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    firstName: _firstnameController.text,
                                    lastName: _lastnameController.text,
                                    phone: _phoneNumberController.text,
                                    gender: selectedGender.value));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("password does not match")));
                          }
                        },
                        label: const Text('Sign up'),
                      );
                    } else if (state is SignUpLoadingState) {
                      return AppRoundedElevatedButton(
                          onPressed: () {},
                          label: const AppCustomCircularProgressIndicator());
                    } else {
                      return AppRoundedElevatedButton(
                        onPressed: () {},
                        label: const Text('Login'),
                      );
                    }
                  },
                  listener: (BuildContext context, SignupState state) {
                    if (state is SignUpSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.response)));
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.loginScreen,
                          (Route<dynamic> route) => false);
                    } else if (state is SignUpFailureState) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: SocialMediaFooter()),
                const Text(
                  'By signing up you confirm that you agree with our Term and Condition',
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ));
  }
}
