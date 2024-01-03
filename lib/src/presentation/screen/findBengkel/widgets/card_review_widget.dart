import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardReviewWidget extends StatelessWidget {
  final String imageUrl;
  final String username;
  final String comments;
  final dynamic timeUpload;
  final double rating;
  const CardReviewWidget({
    super.key,
    required this.imageUrl,
    required this.username,
    required this.comments,
    required this.timeUpload,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedTime =
        (timeUpload is String) ? timeUpload : getTimeAgo(timeUpload);
    return Column(
      children: [
        Row(
          children: [
            Image.network(imageUrl, width: 50, height: 50),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        username,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 15.0,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    ignoreGestures: true,
                    onRatingUpdate: (double value) {},
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Text(
          comments,
          textAlign: TextAlign.justify,
        )
      ],
    );
  }

  String getTimeAgo(dynamic timestamp) {
    if (timestamp == null) {
      return 'Unknown time';
    }

    DateTime currentTime = DateTime.now();
    DateTime uploadTime = (timestamp as Timestamp).toDate();

    Duration difference = currentTime.difference(uploadTime);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      int minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 1) {
      int hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 7) {
      int days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}