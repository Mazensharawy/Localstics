import 'package:flutter/material.dart';

class BrandSlider extends StatelessWidget {
  const BrandSlider({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> brandLogos = [
      'assets/adidas.png',
      'assets/nike (2).png',
      'assets/puma (2).png',
      'assets/adidas.png',
      'assets/nike (2).png',
      'assets/puma (2).png',
    ];
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: brandLogos.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              width: 100, 
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Image.asset(
                        brandLogos[index],
                        width: 50, 
                        height: 50,
                        fit: BoxFit.contain,),
                    ),
            ),
          );
        }
      ),
    );
  }
}