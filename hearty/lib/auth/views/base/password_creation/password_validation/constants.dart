final hasNumberPattern = RegExp('(?=.*?[0-9])');
final hasUppercasePattern = RegExp('(?=.*?[A-Z])');
final hasLowercasePattern = RegExp('(?=.*?[a-z])');
final hasSpecialCharPattern =
    RegExp(r'(?=.*?[ !"#$%&()*+,-./:;<=>?@[\\\]^_`{|}~\u0027])');
