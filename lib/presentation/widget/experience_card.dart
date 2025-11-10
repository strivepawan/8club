import 'package:flick_tv_ott/domain/entities/experience_entity.dart';
import 'package:flutter/material.dart';

class ExperienceCard extends StatelessWidget {
  final ExperienceEntity experience;
  final bool isSelected;
  final VoidCallback onTap;

  const ExperienceCard({
    super.key,
    required this.experience,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget image = Image.network(
      experience.imageUrl,
      fit: BoxFit.cover,
      // Add loading/error builders for a better UX
      loadingBuilder: (context, child, progress) {
        return progress == null
            ? child
            : const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );

    return GestureDetector(
      onTap: onTap,
      child: Card(
        clipBehavior: Clip.antiAlias, // Ensures image corners are rounded
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(
            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            width: 3.0,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // --- Grayscale Filter ---
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.grey,
                isSelected ? BlendMode.dst : BlendMode.saturation, // Grayscale if NOT selected
              ),
              child: image,
            ),
            
            // --- Gradient Overlay for Text ---
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
            ),
            
            // --- Text Content ---
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experience.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    experience.tagline,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // --- Selection Checkmark ---
            if (isSelected)
              const Positioned(
                top: 8,
                right: 8,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.check, size: 16, color: Colors.blue),
                ),
              ),
          ],
        ),
      ),
    );
  }
}