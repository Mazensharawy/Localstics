import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';

class WithdrawPinScreen extends StatefulWidget {
  const WithdrawPinScreen({super.key});

  @override
  State<WithdrawPinScreen> createState() => _WithdrawPinScreenState();
}

class _WithdrawPinScreenState extends State<WithdrawPinScreen> {
  final List<String> _pin = List.filled(6, '');
  int _currentIndex = 0;

  void onKeyTap(String value) {
    setState(() {
      if (_currentIndex < 6) {
        _pin[_currentIndex] = value;
        _currentIndex++;
      }
    });
  }

  void onBackspace() {
    setState(() {
      if (_currentIndex > 0) {
        _currentIndex--;
        _pin[_currentIndex] = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(40),
              Text('Please enter your Localstics pin',
                style: getTextStyle(
                  fontweight: FontWeight.w400,
                  fontSize: 16,),
              ),
              const Gap(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(6, (index) {
                  return Container(
                    width: 48,
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      _pin[index].isEmpty ? (index + 1).toString() : _pin[index],
                      style:  getTextStyle(
                        fontweight: FontWeight.w400,
                        fontSize: 18,),
                    ),
                  );
                }),
              ),
              const Spacer(),
              BlackButton(text: 'Withdraw', width: double.infinity, height: 48, onPressed: (){
                push(context, const WithdrawSuccessScreen());
              },),
              const Gap(30),
            ],
          ),
        ),
      ),
    );
  }
}

class WithdrawSuccessScreen extends StatelessWidget {
  const WithdrawSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.verified_outlined,
                size: 80,),
              const Gap(24),
              Text('Money Sent',
                style: getTextStyle(
                  fontweight: FontWeight.w600,
                  fontSize: 20,),
              ),
              const Gap(8),
              Text('Your fund is on its way to you',
                style: getTextStyle(
                  fontweight: FontWeight.w500,
                  fontSize: 15,),
                textAlign: TextAlign.center,
              ),
              const Gap(40),
              BlackButton(text: 'Return', width: double.infinity, height: 48, onPressed: (){
                Navigator.of(context).popUntil((route) => route.isFirst);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
