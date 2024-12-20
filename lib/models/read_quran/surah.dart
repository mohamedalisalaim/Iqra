class Surah {
  final String name;
  final String name_en;
  final String name_translation;
  final int words;
  final int letters;
  final int verses;
  final String type;
  final String type_en;
  final String ar;
  final String en;
  final List<dynamic> array;
  final List<String> path;
  final List<String> word_by_word_ar;
  final List<String> word_by_word_en;

  Surah({
    required this.name,
    required this.name_en,
    required this.name_translation,
    required this.words,
    required this.letters,
    required this.type,
    required this.type_en,
    required this.ar,
    required this.en,
    required this.verses,
    required this.array,
    required this.path,
    required this.word_by_word_ar,
    required this.word_by_word_en,
  });
}
