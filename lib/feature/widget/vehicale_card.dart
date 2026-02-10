import 'package:flutter/material.dart';
import 'package:velozaje/core/utils/app_colors.dart';
import 'package:velozaje/res/common_image.dart';
import 'package:velozaje/res/common_text.dart';

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    super.key,
    required this.image,
    required this.brand,
    required this.vehicleModel,
    required this.year,
    required this.licensePlateNumber,
  });
  final String image;
  final String brand;
  final String vehicleModel;
  final String year;
  final String licensePlateNumber;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          spacing: 16,
          children: [
            Expanded(
              child: CommonImage(
                path: image,
                sourceType: ImageSourceType.network,
                height: 60,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText("${brand} ${vehicleModel}", size: 14),
                  CommonText(year, size: 14),
                  CommonText(
                    licensePlateNumber,
                    size: 12,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
