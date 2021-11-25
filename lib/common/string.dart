class Strings {
  static final Strings _singleton = Strings._internal();



  Strings._internal();

  factory Strings() {
    return _singleton;
  }

  String oops = 'Sad, No Results!';
  String notFound = 'We could not find any item you are searching for.';
  String appName = 'Article';
  String saveForLater = 'Save For Later';
  String learn = 'Learn';
}