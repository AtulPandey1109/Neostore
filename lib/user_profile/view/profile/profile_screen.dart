import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/core/routes/routes.dart';
import 'package:neostore/user_profile/viewmodel/profile_bloc/profile_bloc.dart';
import 'package:neostore/utils/app_local_storage.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/utils/responsive_size_helper.dart';
import 'package:neostore/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/widgets/app_rounded_button.dart';
import 'package:neostore/widgets/app_rounded_text_field.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ValueNotifier<bool> isEditing = ValueNotifier(false);
  final TextEditingController _firstnameController = TextEditingController();

  final TextEditingController _lastnameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context).add(ProfileInitialEvent());
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
        actions: [
          IconButton(
              onPressed: () {
                isEditing.value = !isEditing.value;
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.orange,
              )),
        ],
      ),
      body: SafeArea(child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (BuildContext context, state) {
          if (state is ProfileInitialState) {
            if (state.isLoading) {
              return const AppCustomCircularProgressIndicator(
                color: Colors.orange,
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: kPaddingSide),
              child: Center(
                child: SizedBox(
                  width: SizeConfig.isMobile()?SizeConfig.screenWidth:SizeConfig.screenWidth*0.7,
                  child: ValueListenableBuilder(
                    valueListenable: isEditing,
                    builder: (BuildContext context, bool value, Widget? child) {
                      _firstnameController.text =
                          state.userDetail?.firstName ?? '';
                      _lastnameController.text = state.userDetail?.lastName ?? '';
                      _emailController.text = state.userDetail?.email ?? '';
                      _phoneNumberController.text = state.userDetail?.phone ?? '';
                      final ValueNotifier<String> selectedGender =
                          ValueNotifier(state.userDetail?.gender ?? '');
                      return isEditing.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: SizeConfig.isMobile()
                                      ? MediaQuery.sizeOf(context).width * 0.8
                                      : MediaQuery.sizeOf(context).width * .3,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Container(
                                          width: 100,
                                          height: 200,
                                          constraints: BoxConstraints.tight(
                                              const Size(100, 100)),
                                          child: Image.asset(
                                            'assets/images/monkey_profile_pic.webp',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: AppRoundedTextField(
                                          controller: _firstnameController,
                                          labelText: 'First name',
                                        ),
                                      ),
                                      AppRoundedTextField(
                                        controller: _lastnameController,
                                        labelText: 'Last name',
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: AppRoundedTextField(
                                          controller: _emailController,
                                          labelText: 'Email',
                                        ),
                                      ),
                                      AppRoundedTextField(
                                        controller: _phoneNumberController,
                                        labelText: 'Phone No.',
                                      ),
                                      ValueListenableBuilder(
                                        valueListenable: selectedGender,
                                        builder: (BuildContext context, value,
                                            Widget? child) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16.0,
                                                horizontal: kPaddingSide),
                                            child: Column(
                                              children: [
                                                 const Align(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      'Gender',
                                                      style: kHeader4TextStyle,
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Radio(
                                                            value: 'male',
                                                            groupValue:
                                                                selectedGender
                                                                    .value,
                                                            onChanged: (value) {
                                                              selectedGender
                                                                  .value = value!;
                                                            }),
                                                        const Text(
                                                          'Male',
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Radio(
                                                            value: 'female',
                                                            groupValue:
                                                                selectedGender
                                                                    .value,
                                                            onChanged: (value) {
                                                              selectedGender
                                                                  .value = value!;
                                                            }),
                                                        const Text('Female',
                                                            style: TextStyle(
                                                                fontSize: 16))
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AppRoundedElevatedButton(
                                      onPressed: () async {
                                        BlocProvider.of<ProfileBloc>(context).add(
                                            ProfileUpdateEvent(
                                                _firstnameController.text,
                                                _lastnameController.text,
                                                _emailController.text,
                                                _phoneNumberController.text,
                                                selectedGender.value));
                                        isEditing.value=false;
                                      },
                                      label: const Text('Save')),
                                )
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: 100,
                                        height: 200,
                                        constraints: BoxConstraints.tight(
                                            const Size(100, 100)),
                                        child: Image.asset(
                                          'assets/images/monkey_profile_pic.webp',
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${state.userDetail?.firstName} ${state.userDetail?.lastName}",
                                        style: kHeader4TextStyle,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Personal Details",
                                              style: kHeader3TextStyle.copyWith(
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Full Name'),
                                                Text(
                                                  '${state.userDetail?.firstName ?? " "} ${state.userDetail?.lastName ?? ''}',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Email ID'),
                                                Text(
                                                  state.userDetail?.email ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Mobile No.'),
                                                Text(
                                                  state.userDetail?.phone ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text('Gender'),
                                                Text(
                                                  state.userDetail?.gender ?? '',
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const Divider()
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: AppRoundedElevatedButton(
                                      onPressed: () async {
                                        AppLocalStorage.removeToken();
                                        Navigator.pushNamedAndRemoveUntil(
                                            context,
                                            AppRoutes.loginScreen,
                                            (Route<dynamic> route) => false);
                                      },
                                      label: const Text('Logout')),
                                )
                              ],
                            );
                    },
                  ),
                ),
              ),
            );
          } else {
            return const Text('Unable to load');
          }
        },
      )),
    );
  }
}
