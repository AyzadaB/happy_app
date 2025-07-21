import 'package:intl/intl.dart';

final List<Map<String, String>> cardsData = [
  {
    'image': 'assets/images/taskPic.png',
    'title': 'Morning Ritual',
    'desc':
        'Start your day with something that\n brings you joy — a cup of you\n r favorite coffee, meditation, or a\n morning walk.',
  },
  {
    'image': 'assets/images/taskPic1.png',
    'title': 'Positive Notes',
    'desc': 'Write 3 things you’re grateful for\ntoday.',
  },
  {
    'image': 'assets/images/taskPic2.png',
    'title': 'Inspiring Book ',
    'desc': 'Read a book or article that motivates and brings joy',
  },

  {
    'image': 'assets/images/taskPic4.png',
    'title': 'Gift to Nature ',
    'desc':
        'Spend time outdoors — in a park\n, forest, or by the\n water. Notice the beauty around you',
  },
  {
    'image': 'assets/images/taskPic5.png',
    'title': 'Musical Inspiration ',
    'desc': 'Listen to music that uplifts your mood or helps you relax',
  },
  {
    'image': 'assets/images/taskPic6.png',
    'title': 'Gratitude to Loved Ones',
    'desc':
        'Say thank you or surprise a family\n member or friend with a kind gesture',
  },
  {
    'image': 'assets/images/taskPic7.png',
    'title': 'Capture the Moment',
    'desc': 'Take a photo of something that brings you joy right now',
  },
  {
    'image': 'assets/images/taskPic8.png',
    'title': 'Meet with Friends',
    'desc':
        'Organize or spend time with close\n friends, sharing good vibes and\n laughter',
  },
  {
    'image': 'assets/images/taskPic9.png',
    'title': 'Walk in Silence',
    'desc':
        'Take a walk without your phone, fully\n focusing on the world around you',
  },
  {
    'image': 'assets/images/taskPic10.png',
    'title': 'Social Media Detox',
    'desc':
        'Spend a day without social media to\n better connect with the present\n moment',
  },
  {
    'image': 'assets/images/taskPic11.png',
    'title': 'Cozy Evening  ',
    'desc': 'Create a cozy evening with a book, movie, or favorite music',
  },
  {
    'image': 'assets/images/taskPic12.png',
    'title': 'Little Creativity ',
    'desc':
        'Draw, craft, or write a short story —\n create something with your own\n hands',
  },
  {
    'image': 'assets/images/taskPic13.png',
    'title': 'Self-Care Moment ',
    'desc':
        'Do something nice for yourself — a\n face mask, a warm bath, or yoga',
  },
  {
    'image': 'assets/images/taskPic14.png',
    'title': 'Nature Encounter ',
    'desc': 'Visit a place with a beautiful view —\n mountains, lake, or beac',
  },
  {
    'image': 'assets/images/taskPic15.png',
    'title': 'Smile at a Stranger',
    'desc':
        'Share a smile with a stranger — a\n simple way to brighten the day',
  },
  {
    'image': 'assets/images/taskPic16.png',
    'title': 'Tasty Moment ',
    'desc': 'Cook or try a new dish that lifts your\n mood',
  },
  {
    'image': 'assets/images/taskPic17 .png',
    'title': 'New Experience',
    'desc': 'Try something new — a new route,\n hobby, or recipe',
  },
  {
    'image': 'assets/images/taskPic19.png',
    'title': 'Create Your Happy Corner ',
    'desc':
        'Decorate or tidy your space to make it pleasing to your eyes and soul',
  },
];

final List<Map<String, dynamic>> completedData = [
  {
    'image': 'assets/images/taskPic.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Morning Ritual',
    'desc':
        'Start your day with something that\n brings you joy — a cup of you\n r favorite coffee, meditation, or a\n morning walk.',
  },
  {
    'image': 'assets/images/taskPic1.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Positive Notes',
    'desc': 'Write 3 things you’re grateful for\ntoday.',
  },
  {
    'image': 'assets/images/taskPic2.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,

    'title': 'Inspiring Book ',
    'desc': 'Read a book or article that motivates\n and brings joy',
  },

  {
    'image': 'assets/images/taskPic4.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Gift to Nature ',
    'desc':
        'Spend time outdoors — in a park\n, forest, or by the\n water. Notice the beauty around you',
  },
  {
    'image': 'assets/images/taskPic5.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Musical Inspiration ',
    'desc': 'Listen to music that uplifts your mood\n or helps you relax',
  },
  {
    'image': 'assets/images/taskPic6.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Gratitude to Loved Ones',
    'desc':
        'Say thank you or surprise a family\n member or friend with a kind gesture',
  },
  {
    'image': 'assets/images/taskPic7.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Capture the Moment',
    'desc': 'Take a photo of something that\n brings you joy right now',
  },
  {
    'image': 'assets/images/taskPic8.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Meet with Friends',
    'desc':
        'Organize or spend time with close\n friends, sharing good vibes and\n laughter',
  },
  {
    'image': 'assets/images/taskPic9.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Walk in Silence',
    'desc':
        'Take a walk without your phone, fully\n focusing on the world around you',
  },
  {
    'image': 'assets/images/taskPic10.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Social Media Detox',
    'desc':
        'Spend a day without social media to\n better connect with the present\n moment',
  },
  {
    'image': 'assets/images/taskPic11.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Cozy Evening  ',
    'desc': 'Create a cozy evening with a book,\n movie, or favorite music',
  },
  {
    'image': 'assets/images/taskPic12.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Little Creativity ',
    'desc':
        'Draw, craft, or write a short story —\n create something with your own\n hands',
  },
  {
    'image': 'assets/images/taskPic13.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Self-Care Moment ',
    'desc':
        'Do something nice for yourself — a\n face mask, a warm bath, or yoga',
  },
  {
    'image': 'assets/images/taskPic14.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Nature Encounter ',
    'desc': 'Visit a place with a beautiful view —\n mountains, lake, or beac',
  },
  {
    'image': 'assets/images/taskPic15.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Smile at a Stranger',
    'desc':
        'Share a smile with a stranger — a\n simple way to brighten the day',
  },
  {
    'image': 'assets/images/taskPic16.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Tasty Moment ',
    'desc': 'Cook or try a new dish that lifts your\n mood',
  },
  {
    'image': 'assets/images/taskPic17 .png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'New Experience',
    'desc': 'Try something new — a new route,\n hobby, or recipe',
  },
  {
    'image': 'assets/images/taskPic19.png',
    'completedAt': DateTime.now().millisecondsSinceEpoch,
    'title': 'Create Your Happy Corner ',
    'desc':
        'Decorate or tidy your space to make\n it pleasing to your eyes and soul',
  },
];
