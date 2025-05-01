import 'package:flutter/material.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/categories.dart';


// ignore: must_be_immutable
class ListViewCategory extends StatelessWidget {
 ListViewCategory({
    super.key,
  });
  List<CategoryModel> categories= [
    CategoryModel(text: "Woman", image: 'assets/woman.png'),
    CategoryModel(text: "Men", image: 'assets/men.png'),
    CategoryModel(text: "Teens", image: 'assets/teens.png'),
    CategoryModel(text: "Kids", image: 'assets/kids.png'),
    CategoryModel(text: "Toddlers", image: 'assets/toddler.png'),
 ];
  @override
  Widget build(BuildContext context) {
   
    return SizedBox(
      height: 120,
      width: double.infinity,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return  Column(
            children: [
               CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(categories[index].image),
              ),
              const SizedBox(height: 10,),
              Text(categories[index].text, style: getTextStyle(fontweight: FontWeight.w500, fontSize: 16), 
              overflow: TextOverflow.ellipsis,),
            ],
          );
        }, 
        separatorBuilder: (context,index)=> const SizedBox(width: 18,), 
        itemCount: categories.length),
    );
  }
}
