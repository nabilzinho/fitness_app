// return todays date as yyyymmdd
String todaysDateYYYYMMDD(){
// today
var dateTimeObject = DateTime.now();

// year in the format yyyy
String year = dateTimeObject.year.toString();

// month in the format mm
String month = dateTimeObject.month.toString();
if (month.length == 1) {
month = '0$month';
}

// day in the format dd
String day = dateTimeObject.day.toString();
if (day.length == 1) {
day = '0$day';
}

// final format
String yyyymmdd = year + month + day;

return yyyymmdd;
}
