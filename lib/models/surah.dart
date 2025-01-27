class Surah {
  final String name;
  final String name_translation;

  final int words;
  final int letters;
  final int verses;

  final String type;

  final String ar;
  final String en;
  final List<dynamic> array;

  Surah({
    required this.name,
    required this.name_translation,
    required this.words,
    required this.letters,
    required this.verses,
    required this.type,
    required this.ar,
    required this.en,
    required this.array,
  });
}
