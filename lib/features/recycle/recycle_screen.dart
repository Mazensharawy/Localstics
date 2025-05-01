import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';

class RecycleScreen extends StatefulWidget {
  const RecycleScreen({super.key});

  @override
  State<RecycleScreen> createState() => _RecycleScreenState();
}

class _RecycleScreenState extends State<RecycleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
                'assets/bag.png',
                width: 48,
                height: 48,
              ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),  
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              Text('Recycle Now',
               style: getTextStyle(fontSize: 26, fontweight: FontWeight.bold),),
              Text('Shop more, waste less!',
               style: getTextStyle(color: AppColors.lightgrey, fontSize: 15),),
              const Gap(15),
              const RecycleForm(text: 'Full Name', label: 'Enter your full name'),
              const RecycleForm(text: 'Email', label: 'Enter your email address'),
              const RecycleForm(text: 'Phone Number', label: 'Enter your number'),
              const RecycleForm(text: 'Your Address', label: 'Enter your address'),
              const RecycleForm(text: 'Items Type', label: 'Enter type of items'),
              const RecycleForm(text: 'Recycle Amount', label: 'Enter recycle amount'),
              const Gap(8),
              Text('By submitting you agree that your data is being collected and stored.',
               style: getTextStyle(fontSize: 15, fontweight: FontWeight.bold),
              ),
              const Gap(25),
              BlackButton(text: 'Submit', width: double.infinity, height: 60, onPressed: (){},),
              const Gap(15),
            ],
          ),
        ),
      ),
    );
  }
}

class RecycleForm extends StatelessWidget {
  final String text;
  final String label;
  const RecycleForm({
    super.key, required this.text, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text,
         style: getTextStyle(fontSize: 16),
        ),
        const Gap(5),
        TextFormField(
          decoration: InputDecoration(
                        hintText: label,
                        hintStyle: getTextStyle(
                          color: AppColors.lightgrey, 
                          fontSize: 15,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide (color: AppColors.lightt,),
                            borderRadius: const BorderRadius.all(Radius.circular(12))
                      ),
                      focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide (color: AppColors.lightt,),
                    borderRadius: const BorderRadius.all(Radius.circular(12))
              ),
                      ),
        ),
        const Gap(18),
      ],
    );
  }
}