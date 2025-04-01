extension CapitiliseandSplit on String {
  String capitalizeAndSplitOnSecondCapital() {
    if (isEmpty) return this;

    RegExp regExp = RegExp(r'(?=[A-Z])');
    List<String> parts = split(regExp);

    String firstPart = parts[0][0].toUpperCase() + parts[0].substring(1);
    String rest = parts.sublist(1).fold("", (pv, ele) => "$pv $ele").toString();
    return parts.length > 1 ? '$firstPart $rest' : firstPart;
  }
}

extension StringValidator on String {
  bool get isValidUrl {
    final urlRegExp = RegExp(
      r'^(https?:\/\/)?' // Optional http or https
      r'([\w.-]+)' // Domain or IP
      r'(\.[a-zA-Z]{2,})' // Domain extension
      r'(:\d+)?' // Optional port
      r'(\/[^\s]*)?$', // Optional path
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(this);
  }
}
