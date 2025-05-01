import 'package:flutter/material.dart';
import 'package:localsticss/core/utils/colors.dart';
import 'package:localsticss/core/utils/styles.dart';
import 'package:localsticss/features/HomePage/categories.dart';

class FilterViewCategory extends StatefulWidget {
  const FilterViewCategory({super.key});

  @override
  State<FilterViewCategory> createState() => _FilterViewCategoryState();
}

class _FilterViewCategoryState extends State<FilterViewCategory> {
  int selectedIndex = 0; // Track the selected category index

  List<FilterCategories> categories = [
    FilterCategories(text: "All"),
    FilterCategories(text: "Tshirts"),
    FilterCategories(text: "Jeans"),
    FilterCategories(text: "Shoes"),
    FilterCategories(text: "Accessories"),
  ];

  void handleCategoryTap(int index) {
    setState(() {
      selectedIndex = index;
    });

    // Perform different actions based on the selected category
    switch (categories[index].text) {
      case "All":
        print("Showing all items");
        break;
      case "Tshirts":
        print("Filtering by Tshirts");
        break;
      case "Jeans":
        print("Filtering by Jeans");
        break;
      case "Shoes":
        print("Filtering by Shoes");
        break;
      case "Accessories":
        print("Filtering by Accessories");
        break;
      default:
        print("Unknown category");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: GestureDetector(
              onTap: () => handleCategoryTap(index), // Call the function when tapped
              child: Container(
                width: 110,
                height: 20,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : Colors.white, 
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.lightt),
                ),
                alignment: Alignment.center, // Center text inside the box
                child: Text(
                  categories[index].text,
                  style: getTextStyle(
                    color: isSelected ? Colors.white : Colors.black, 
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
