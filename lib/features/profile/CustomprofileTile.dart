import 'package:flutter/material.dart';

class CustomProfileTile extends StatelessWidget {
  final String iconAsset;
  final String label;
  final VoidCallback? onTileTap;
  final VoidCallback? onChevronTap;

  const CustomProfileTile({
    super.key,
    required this.iconAsset,
    required this.label,
    this.onTileTap,
    this.onChevronTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onTileTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical:2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Image.asset(iconAsset, width: 30),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.grey[600], size: 28),
                onPressed: onChevronTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}