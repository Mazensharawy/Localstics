import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:localstics/core/functions/functions.dart';
import 'package:localstics/core/utils/colors.dart';
import 'package:localstics/core/utils/styles.dart';
import 'package:localstics/features/HomePage/product_details.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  //List<Map<String, dynamic>> reviews = [
   // {
   //   "name": "Wade Warren",
   //   "date": "6 days ago",
   //   "rating": 5,
   //   "comment": "The item is very good, my son likes it very much and plays every day."
   // },
   // {
   //   "name": "Guy Hawkins",
   //   "date": "1 week ago",
   //   "rating": 5,
   //   "comment": "The seller is very fast in sending the packet. I just bought it and it arrived in just 1 day!"
   // },
   // {
   //   "name": "Robert Fox",
   //   "date": "2 weeks ago",
   //   "rating": 4,
   //   "comment": "I just bought it and the stuff is really good! I highly recommend it!"
   // }
  //];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: (){
            pop(context, const ProductDetails());
          },
          iconSize: 30,
          highlightColor: Colors.transparent,
          icon: const Icon(Icons.arrow_back),
          ),
          title: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Center(
            child: Text('Reviews', 
             style: getTextStyle(fontweight: FontWeight.bold, fontSize: 24),),
          ),
        ),
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
      body:  Padding(
        padding: const EdgeInsets.only(left: 15, right: 15), 
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const Gap(10),
              const RatingSummary(averageRating: 4.0, totalRatings: 1034,
                ratingDistribution: [0.85, 0.6, 0.3, 0.15, 0.05],
                ),
                const Gap(10),
                const Divider(),
                const Gap(10),
                ReviewsSection(
                  reviews: [
                   Review(
                    reviewerName: "Wade Warren",
                    reviewText: "The item is very good, my son likes it very much and plays every day.",
                    rating: 5,
                    date: DateTime.now().subtract(const Duration(days: 6)),
                    ),
                   Review(
                    reviewerName: "Guy Hawkins",
                    reviewText: "The seller is very fast in sending packet, I just bought it and the item arrived in just 1 day!",
                    rating: 4,
                    date: DateTime.now().subtract(const Duration(days: 7)),
                   ),
                   Review(
                    reviewerName: "Robert Fox",
                    reviewText: "I just bought it and the stuff is really good! I highly recommend it!",
                    rating: 4,
                    date: DateTime.now().subtract(const Duration(days: 14)),
                   ),
                   Review(
                    reviewerName: "Cody Fisher",
                    reviewText: "The quality is more than perfect, I highly recommend it!",
                    rating: 4,
                    date: DateTime.now().subtract(const Duration(days: 25)),
                   ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}


class RatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalRatings;
  final List<double> ratingDistribution; // from 0.0 to 1.0 for each star level

  const RatingSummary({
    super.key,
    required this.averageRating,
    required this.totalRatings,
    required this.ratingDistribution,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top: Average Rating, Stars, and Ratings count
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: getTextStyle(fontSize: 52, fontweight: FontWeight.bold),
            ),
            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    for (int index = 0; index < 5; index++) ...[
                      Icon(
                        Icons.star,
                        color: index < averageRating.round()
                            ? Colors.amber
                            : Colors.grey.shade300,
                        size: 30,
                      ),
                      if (index < 4) const Gap(4),
                    ],
                  ],
                ),
                const Gap(4),
                Text(
                  "$totalRatings Ratings",
                  style: getTextStyle(color: AppColors.lightgrey, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
        const Gap(10),

        // Star Distribution Bars
        Column(
          children: List.generate(5, (i) {
            int ratingLevel = 5 - i;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      5,
                      (j) => Icon(
                        Icons.star,
                        size: 18,
                        color: j < ratingLevel
                            ? Colors.amber
                            : Colors.grey.shade300,
                      ),
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Stack(
                      children: [
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                            color: AppColors.lightt,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: ratingDistribution[i],
                          child: Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}




class Review {
  final String reviewerName;
  final String reviewText;
  final double rating;
  final DateTime date;

  Review({
    required this.reviewerName,
    required this.reviewText,
    required this.rating,
    required this.date,
  });
}
class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  const ReviewsSection({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${reviews.length} Reviews",
              style: getTextStyle(
                fontSize: 16,
                fontweight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              value: 'Most Relevant',
              items: ['Most Relevant', 'Newest', 'Oldest']
                .map((label) => DropdownMenuItem(
                  value: label,
                  child: Text(label)
                  )
                ).toList(),
              onChanged: (value){},
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down),
              ),
          ],
        ),
        const Gap(10),
        Column(
          children: reviews.map((review) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(5, 
                    (index) => Icon(Icons.star, size: 18,
                      color: index < review.rating.round()
                          ? Colors.amber
                          : Colors.grey.shade300,),
                  ),
                ),
                const Gap(6),
                Text(
                  review.reviewText,
                  style: getTextStyle(fontSize: 14),
                ),
                const Gap(8),
                Text(
                  "${review.reviewerName} • ${_timeAgo(review.date)}",
                  style: getTextStyle(
                    fontweight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.black,
                  ),
                ),
                const Divider(height: 24),
              ],
            );
          }
          ).toList(),
        ),
      ],
    );
  }
  String _timeAgo(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);
    if (diff.inDays >= 7) {
      final weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks > 1 ? 's' : ''} ago";
    } else if (diff.inDays > 0) {
      return "${diff.inDays} day${diff.inDays > 1 ? 's' : ''} ago";
    } else {
      return "Today";
    }
  }
}



