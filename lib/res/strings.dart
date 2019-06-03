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

//  <!--Contacts screen-->
//  <string name="contacts_screen_name">Contacts</string>
//  <string name="contacts_header_title">Hello, %1$s</string>
//  <string name="contacts_header_description">%1$s wishes you a nice day :)</string>
//  <string name="contacts_action_search">Search</string>
//
//  <!--Contact screen-->
//  <string name="contact_default_status">@string/default_status</string>
//  <string name="contact_button_save">+ Save contact</string>
//  <string name="contact_phone_invalid">Invalid phone</string>
//  <string name="contact_email_invalid">Invalid Email</string>
//
//  <!--News screen-->
//  <string name="news_screen_name">Team\'s news</string>
//  <string name="news_default_status">@string/default_status</string>
//  <string name="news_update_today">Today</string>
//  <string name="news_update_yesterday">Yesterday</string>
//  <string name="news_update_long_time_ago">A long time ago</string>
//  <string name="news_menu_change_status">Change status</string>
}