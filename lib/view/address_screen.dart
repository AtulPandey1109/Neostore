import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neostore/model/order_model/order_summary_model.dart';
import 'package:neostore/utils/constant_styles.dart';
import 'package:neostore/view/widgets/app_custom_circular_progress_indicator.dart';
import 'package:neostore/view/widgets/app_rounded_button.dart';
import 'package:neostore/view/widgets/app_rounded_text_field.dart';
import 'package:neostore/viewmodel/address_bloc/address_bloc.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _houseName = TextEditingController();
  final TextEditingController _houseNo = TextEditingController();
  final TextEditingController _firstLine = TextEditingController();
  final TextEditingController _secondLine = TextEditingController();
  final TextEditingController _city = TextEditingController();
  final TextEditingController _state = TextEditingController();
  final TextEditingController _country = TextEditingController();
  final TextEditingController _pinCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        title: const Text('Add Address'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppRoundedTextField(
                controller: _houseName,
                labelText: 'House name',
              ),
            ),
            AppRoundedTextField(
              controller: _houseNo,
              labelText: 'House No.',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppRoundedTextField(
                controller: _firstLine,
                labelText: 'First Line',
              ),
            ),
            AppRoundedTextField(
              controller: _secondLine,
              labelText: 'Second Line',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppRoundedTextField(
                controller: _city,
                labelText: 'City',
              ),
            ),
            AppRoundedTextField(
              controller: _state,
              labelText: 'State',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: AppRoundedTextField(
                controller: _country,
                labelText: 'Country',
              ),
            ),
            AppRoundedTextField(
              controller: _pinCode,
              labelText: 'Pin code',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: BlocListener<AddressBloc, AddressState>(
                  listener: (BuildContext context, AddressState state) {
                    if (state is AddressAddedState) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Address added successfully')));
                      Navigator.pop(context);
                    }
                  },
                  child: AppRoundedElevatedButton(
                    onPressed: () {
                      Address address = Address(
                          firstLine: _firstLine.text,
                          secondLine: _secondLine.text,
                          houseName: _houseName.text,
                          houseNo: _houseNo.text,
                          city: _city.text,
                          state: _state.text,
                          country: _country.text,
                          pinCode: _pinCode.text);
                      BlocProvider.of<AddressBloc>(context).add(AddressAddEvent(address));
                    },
                    label: BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        if (state is AddressInitialState) {
                          return state.isLoading
                              ? const AppCustomCircularProgressIndicator()
                              : const Text('Save');
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
