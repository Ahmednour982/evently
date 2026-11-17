// lib/utils/category_images.dart

class CategoryImages {
  // Light Mode Images
  static const Map<String, String> lightImages = {
    'sport': 'assets/images/sport_light.png',
    'book_club': 'assets/images/book_club_light.png',
    'birthday': 'assets/images/birthday_light.png',
    'meeting': 'assets/images/meeting_light.png',
    'exhibition': 'assets/images/exhibition_light.png',
  };

  // Dark Mode Images
  static const Map<String, String> darkImages = {
    'sport': 'assets/images/sport_dark.png',
    'book_club': 'assets/images/book_club_dark.png',
    'birthday': 'assets/images/birthday_dark.png',
    'meeting': 'assets/images/meeting_dark.png',
    'exhibition': 'assets/images/exhibition_dark.png',
  };

  // Get image based on theme
  static String getImage(String category, bool isDarkMode) {
    final images = isDarkMode ? darkImages : lightImages;
    return images[category.toLowerCase()] ?? images['meeting']!;
  }
}