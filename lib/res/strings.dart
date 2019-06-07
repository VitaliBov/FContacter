class AppStrings {
  static const appName = "Contacter";

  //Welcome screen
  static const welcomeTitle = "Contacter";
  static const welcomeDescription = "Powered by Teamwork";
  static const welcomeButtonTitle = "Connect";

  //Create status screen
  static const createStatusHint = "Write something";
  static String createStatusMaxSymbols(String count) => "Max symbols: $count";
  static const createStatusButtonSend = "Send";

  //User screen
  static const userNoPhone = "No phone";
  static const userNoEmail = "No Email";

  //Errors
  static const errorNetwork = "Сheck your Internet connection";
  static const errorAuth = "Login error";
  static const errorNotFound = "Oops…Not found";
  static const errorServer = "Server side error";
  static const errorUnknown = "Unknown error";
  static const errorContactsEmpty = "No contacts found";

  //Profile screen
  static const profileScreenName = "Profile";
  static const profileDefaultStatus = "string/default_status";
  static const profileLogout = "Log out";
  static const profileLogoutDescription = "Are you sure you want to quit?";


  //Default
  static String defaultStatus(String name) => "Why not prompt $name to update their status?";
  static const yes = "Yes";
  static const no = "No";

  //Contacts screen
  static const contactsScreenName = "Contacts";
  static String contactsHeaderTitle(String name) => "Hello, $name";
  static String contactsHeaderDescription(String name) => "$name wishes you a nice day :)";
  static const contactsActionSearch = "Search";

  //Contact screen
  static const contactDefaultStatus = "string/default_status";
  static const contactButtonSave = "Save contact";
  static const contactPhoneInvalid = "Invalid phone";
  static const contactEmailInvalid = "Invalid Email";

  //News screen
  static const newsScreenName = "Team's news";
  static String newsDefaultStatus(String name) => defaultStatus(name);
  static const newsUpdateToday = "Today";
  static const newsUpdateYesterday = "Yesterday";
  static const newsUpdateLongTimeAgo = "A long time ago";
  static const newsMenuChangeStatus = "Change status";
}