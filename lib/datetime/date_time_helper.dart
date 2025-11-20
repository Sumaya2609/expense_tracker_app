// convert DateTime obk=ject to a string ddmmyyyy
String convertDateTimeToString (DateTime dateTime) {
     
      // day in the format -> dd
    String day = dateTime.day.toString();
    if (day.length == 1) {
        day = '0' + day;
    }

    // month in the format -> mm
    String month = dateTime.month.toString();
    if(month.length ==1){
        month = '0' + month;
    }
// year in the format -> yyyy
    String year = dateTime.year.toString();

// final format -> ddmmyyyy
String ddmmyyyy = day + month + year;

return ddmmyyyy;
}


/*
DateTime.now -> 18/11/2025

*/