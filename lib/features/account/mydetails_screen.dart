import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:localsticss/core/functions/functions.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/widgets/black_button.dart';
import 'package:localsticss/features/account/account_screen.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  String? selectedGender;
  TextEditingController dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Default date
      firstDate: DateTime(1980), // Earliest selectable date
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Header background color
            hintColor: AppColors.black,
            colorScheme: ColorScheme.light(primary: AppColors.black),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            dialogTheme: const DialogTheme(elevation: 0),
            shadowColor: Colors.transparent, // Removes any shadow effect
            highlightColor: Colors.transparent, // Removes highlight effect
            splashColor: Colors.transparent, 
             hoverColor: Colors.transparent, 
          ), 
          
          child: child!);
      }, // Latest selectable date
    );

    if (pickedDate != null) {
      setState(() {
        dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: (){
            pop(context, const AccountScreen());
          }, 
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          ),
          centerTitle: true,
          title: Text('My Details', 
           style: getTextStyle(fontweight: FontWeight.bold, fontSize: 24),),
          actions: [
            SvgPicture.asset(
            'assets/chatbotsvg.svg',
            width: 30,
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
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
              const Gap(15),
              Text('Full Name',
               style: getTextStyle(fontSize: 16, fontweight: FontWeight.w500),
              ),
              const Gap(3),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightt),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 20),
                  child: Text(' Cody Fisher',
                   style: getTextStyle(fontSize: 16,),
                  ),
                ),
              ),
              const Gap(18),
              Text('Email Address', style: getTextStyle(fontSize: 16, fontweight: FontWeight.w500),),
              const Gap(3),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightt),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 20),
                  child: Text('cody.fisher45@example',
                   style: getTextStyle(fontSize: 16,),
                  ),
                ),
              ),
              const Gap(15),
              Text('Gender', style: getTextStyle(fontSize: 16),),
              const Gap(3),
              DropdownButtonFormField<String>(
                value: selectedGender,
                hint: Text('Select Gender', style: getTextStyle(),),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightt),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightt), 
                  ),
                  focusedBorder: OutlineInputBorder(
                   borderRadius: BorderRadius.circular(10),
                   borderSide: BorderSide(color: AppColors.lightt), 
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                icon: const Icon(Icons.arrow_drop_down),
                dropdownColor: AppColors.bgColor,
                items: ["Male", "Female"].map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(value, style: getTextStyle(fontSize: 16),),
                    ),);}).toList(),
                onChanged: (newValue){
                  setState(() {
                    selectedGender=newValue;
                  });
                }
              ),
              const Gap(15),
              Text('Date of Birth', style: getTextStyle(fontSize: 16),),
              const Gap(3),
              TextFormField(
                controller: dateController,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightt),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightt),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.lightt),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  suffixIcon:IconButton(
                    onPressed: () => _selectDate(context), 
                    icon: const Icon(Icons.calendar_today),),
                ),
              ),
              const Gap(15),
              Text('Phone Number', style: getTextStyle(fontSize: 16),),
              const Gap(3),
              Container(
                width: double.infinity,
                height: 52,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.lightt),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 14, left: 20),
                  child: Text('01002347394',
                   style: getTextStyle(fontSize: 16,),
                  ),
                ),
              ),
              const Gap(60),
              BlackButton(text: 'Submit', width: double.infinity, height: 60,
               onPressed: () {},),
            ],
          ),
        ),
        ),
    );
  }
}