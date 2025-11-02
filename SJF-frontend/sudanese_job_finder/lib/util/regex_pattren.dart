bool isValidMobileNumber(String number) {
  RegExp mobileRegex = RegExp(r'^\+\d{1,3}\s?\d{3,14}$');
  return mobileRegex.hasMatch(number);
}

String capitalizeWords(String input) {
  if (input.isEmpty) {
    return '';
  }

  List<String> words = input.split(' ');
  for (int i = 0; i < words.length; i++) {
    String word = words[i];
    if (word.isNotEmpty) {
      words[i] = word[0].toUpperCase() + word.substring(1).toLowerCase();
    }
  }

  return words.join(' ');
}