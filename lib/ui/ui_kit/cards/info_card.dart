import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:quit_smart_app/ui/theme/ui_constants.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.width,
    required this.height,
  });

  final IconData icon;
  final String title;
  final String description;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(CardConstants.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(icon, size: CardConstants.cardIconSize),
              const SizedBox(height: CardConstants.cardTitleSpacing),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w500, // Keep title slightly bolder
                    ),
              ),
              const SizedBox(height: CardConstants.cardDescriptionSpacing),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
