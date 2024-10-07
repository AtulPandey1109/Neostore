import 'package:flutter/material.dart';
import 'package:neostore/utils/app_constants.dart';
import 'package:neostore/utils/constant_styles.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          title: const Text('FAQs'),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
          itemCount: AppConstants.faqs.length,
          itemBuilder: (context, index) {
            String question = AppConstants.faqs.keys.elementAt(index);
            String answer = AppConstants.faqs.values.elementAt(index);
            final ValueNotifier<bool> isExpanded = ValueNotifier(false);
            return ValueListenableBuilder(
              valueListenable: isExpanded,
              builder: (BuildContext context, bool value, Widget? child) {
                return ExpansionTile(
                  title: Text(question),
                  trailing: Icon(isExpanded.value ? Icons.remove : Icons.add),
                  onExpansionChanged: (expanded) {
                      isExpanded.value = expanded;
                  },
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(answer),
                    ),
                  ],
                );
              },
            );
          },
        ));
  }
}
