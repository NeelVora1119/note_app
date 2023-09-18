class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}

List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Work',
    content: 'Do coding....',
    modifiedTime: DateTime(2022, 1, 1, 34, 5),
  ),
  Note(
    id: 1,
    title: 'Digital marketing',
    content: 'Mail \n whatsapp \n instagram\n facebook',
    modifiedTime: DateTime(2022, 1, 1, 34, 5),
  ),
  Note(
    id: 2,
    title: 'Books to Read',
    content:
        '1. To Kill a Mockingbird\n2. 1984\n3. The Great Gatsby\n4. The Catcher in the Rye',
    modifiedTime: DateTime(2023, 3, 1, 19, 5),
  ),
  Note(
    id: 3,
    title: 'Shoping',
    content: '1. Jewelry box\n2. Scarf\n4. Spa day gift card',
    modifiedTime: DateTime(2023, 1, 4, 16, 53),
  ),
  Note(
    id: 4,
    title: 'Movie',
    content: 'Movie time...',
    modifiedTime: DateTime(2023, 5, 1, 11, 6),
  ),
  Note(
    id: 5,
    title: 'Meeting Notes',
    content:
        'Attendees: John, Mary, David\nAgenda:\n- Budget review\n- Project updates\n- Upcoming events',
    modifiedTime: DateTime(2023, 1, 6, 13, 9),
  ),
  Note(
    id: 6,
    title: 'Little pigs',
    content:
        "Once upon a time there were three little pigs who set out to seek their fortune.",
    modifiedTime: DateTime(2023, 3, 7, 11, 12),
  ),
  Note(
    id: 7,
    title: 'Bucket List',
    content:
        '1. Travel to Japan\n2. Learn to play the guitar\n3. Write a novel\n4. Run a marathon\n5. Start a business',
    modifiedTime: DateTime(2023, 2, 1, 15, 14),
  ),
  Note(
    id: 8,
    title: 'Ideas for Vacation',
    content:
        '1. Visit Grand Canyon\n2. Go on a hot air balloon ride\n3. Try local cuisine\n4. Attend a concert',
    modifiedTime: DateTime(2023, 2, 1, 12, 34),
  ),
];
