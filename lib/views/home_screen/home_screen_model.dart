class HomeScreenModel {
  bool loading = false;
    returnDateNames(day) {
    if (day == 1) {
      return dateNames[0];
    } else if (day == 2) {
      return dateNames[1];
    } else if (day == 3) {
      return dateNames[2];
    } else
      return dateNames[3];
  }

    List<String> dateNames = [
    'Aug 25',
    'Aug 26',
    'Sep 2',
    'Sep 3',
  ];
}
