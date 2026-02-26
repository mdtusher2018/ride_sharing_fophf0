import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @confirm_your_details.
  ///
  /// In en, this message translates to:
  /// **'Confirm Your Details'**
  String get confirm_your_details;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @enter_your_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enter_your_email;

  /// No description provided for @contact_phone.
  ///
  /// In en, this message translates to:
  /// **'Contact Phone'**
  String get contact_phone;

  /// No description provided for @enter_your_contact_number.
  ///
  /// In en, this message translates to:
  /// **'Enter your contact number'**
  String get enter_your_contact_number;

  /// No description provided for @full_name.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get full_name;

  /// No description provided for @enter_your_full_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enter_your_full_name;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @enter_your_address.
  ///
  /// In en, this message translates to:
  /// **'Enter your address'**
  String get enter_your_address;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'DOB'**
  String get dob;

  /// No description provided for @select_your_date_of_birth.
  ///
  /// In en, this message translates to:
  /// **'Select your date of birth'**
  String get select_your_date_of_birth;

  /// No description provided for @confirm_data.
  ///
  /// In en, this message translates to:
  /// **'Confirm Data'**
  String get confirm_data;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get create_new_password;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @enter_your_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enter_your_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @enter_your_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your confirm password'**
  String get enter_your_confirm_password;

  /// No description provided for @update_password.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get update_password;

  /// No description provided for @verification_code.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verification_code;

  /// No description provided for @we_ve_sent_a_4_digit_otp_code_to_your_email_address_please_enter_it_below_to_verify_and_continue_with_password_reset.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a 4 digit OTP code to your email address. Please enter it below to verify and continue with password reset.'**
  String
  get we_ve_sent_a_4_digit_otp_code_to_your_email_address_please_enter_it_below_to_verify_and_continue_with_password_reset;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter;

  /// No description provided for @reset_your_password.
  ///
  /// In en, this message translates to:
  /// **'Reset Your Password'**
  String get reset_your_password;

  /// No description provided for @enter_your_registered_email_address_below_we_ll_send_you_a_one_time_password_otp_to_reset_your_password_securely.
  ///
  /// In en, this message translates to:
  /// **'Enter your registered email address below. We’ll send you a one-time password (OTP) to reset your password securely'**
  String
  get enter_your_registered_email_address_below_we_ll_send_you_a_one_time_password_otp_to_reset_your_password_securely;

  /// No description provided for @send_otp_code.
  ///
  /// In en, this message translates to:
  /// **'Send OTP Code'**
  String get send_otp_code;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip >>'**
  String get skip;

  /// No description provided for @referral_code.
  ///
  /// In en, this message translates to:
  /// **'Referral Code'**
  String get referral_code;

  /// No description provided for @have_a_code_enter_it_to_unlock_0_percent_commission_on_your_first_trip_as_a_driver.
  ///
  /// In en, this message translates to:
  /// **'Have a code? Enter it to unlock 0% commission on your first trip as a driver.'**
  String
  get have_a_code_enter_it_to_unlock_0_percent_commission_on_your_first_trip_as_a_driver;

  /// No description provided for @submite.
  ///
  /// In en, this message translates to:
  /// **'Submite'**
  String get submite;

  /// No description provided for @documents_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'Documents Sent Successfully!'**
  String get documents_sent_successfully;

  /// No description provided for @we_will_notify_you_once_your_documents_are_verified.
  ///
  /// In en, this message translates to:
  /// **'We will notify you once your documents are verified.'**
  String get we_will_notify_you_once_your_documents_are_verified;

  /// No description provided for @register_your_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Register Your Vehicle'**
  String get register_your_vehicle;

  /// No description provided for @upload_your_vehicle_image.
  ///
  /// In en, this message translates to:
  /// **'*Upload your vehicle image'**
  String get upload_your_vehicle_image;

  /// No description provided for @select_vehicle_type.
  ///
  /// In en, this message translates to:
  /// **'Select Vehicle Type'**
  String get select_vehicle_type;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Registration'**
  String get registration;

  /// No description provided for @enter_registration_number.
  ///
  /// In en, this message translates to:
  /// **'Enter registration number'**
  String get enter_registration_number;

  /// No description provided for @year_of_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Year of Vehicle'**
  String get year_of_vehicle;

  /// No description provided for @enter_year.
  ///
  /// In en, this message translates to:
  /// **'Enter year'**
  String get enter_year;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @enter_brand.
  ///
  /// In en, this message translates to:
  /// **'Enter brand'**
  String get enter_brand;

  /// No description provided for @model.
  ///
  /// In en, this message translates to:
  /// **'Model'**
  String get model;

  /// No description provided for @enter_model.
  ///
  /// In en, this message translates to:
  /// **'Enter model'**
  String get enter_model;

  /// No description provided for @car_license_plate_number.
  ///
  /// In en, this message translates to:
  /// **'Car license plate number'**
  String get car_license_plate_number;

  /// No description provided for @enter_license_number.
  ///
  /// In en, this message translates to:
  /// **'Enter license number'**
  String get enter_license_number;

  /// No description provided for @welcome_back.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcome_back;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgot_password;

  /// No description provided for @log_in.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get log_in;

  /// No description provided for @you_don_t_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have an account? '**
  String get you_don_t_have_an_account;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_account;

  /// No description provided for @i_accept_the.
  ///
  /// In en, this message translates to:
  /// **'I accept the '**
  String get i_accept_the;

  /// No description provided for @terms_conditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get terms_conditions;

  /// No description provided for @already_have_an_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?  '**
  String get already_have_an_account;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @inbox.
  ///
  /// In en, this message translates to:
  /// **'Inbox'**
  String get inbox;

  /// No description provided for @search_chats.
  ///
  /// In en, this message translates to:
  /// **'Search chats'**
  String get search_chats;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @online.
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// No description provided for @type_a_message.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get type_a_message;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello! 👋'**
  String get hello;

  /// No description provided for @hi_i_uploaded_my_documents.
  ///
  /// In en, this message translates to:
  /// **'Hi, I uploaded my documents.'**
  String get hi_i_uploaded_my_documents;

  /// No description provided for @great_we_are_reviewing_them.
  ///
  /// In en, this message translates to:
  /// **'Great! We are reviewing them.'**
  String get great_we_are_reviewing_them;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @finding_your_drivers.
  ///
  /// In en, this message translates to:
  /// **'Finding your Drivers'**
  String get finding_your_drivers;

  /// No description provided for @pick_up_location.
  ///
  /// In en, this message translates to:
  /// **'Pick-up location'**
  String get pick_up_location;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @generate_search.
  ///
  /// In en, this message translates to:
  /// **'Generate Search'**
  String get generate_search;

  /// No description provided for @where_to.
  ///
  /// In en, this message translates to:
  /// **'Where to?'**
  String get where_to;

  /// No description provided for @find_a_ride_or_send_a_package.
  ///
  /// In en, this message translates to:
  /// **'Find a ride or send a package'**
  String get find_a_ride_or_send_a_package;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @send_package.
  ///
  /// In en, this message translates to:
  /// **'Send Package'**
  String get send_package;

  /// No description provided for @enter_destination.
  ///
  /// In en, this message translates to:
  /// **'Enter destination'**
  String get enter_destination;

  /// No description provided for @saved_places.
  ///
  /// In en, this message translates to:
  /// **'Saved Places'**
  String get saved_places;

  /// No description provided for @time_date.
  ///
  /// In en, this message translates to:
  /// **'Time & Date'**
  String get time_date;

  /// No description provided for @weight_kg.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weight_kg;

  /// No description provided for @l.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get l;

  /// No description provided for @w.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get w;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **'H'**
  String get h;

  /// No description provided for @search_trips.
  ///
  /// In en, this message translates to:
  /// **'Search Trips'**
  String get search_trips;

  /// No description provided for @add_payment.
  ///
  /// In en, this message translates to:
  /// **'Add Payment'**
  String get add_payment;

  /// No description provided for @add_card.
  ///
  /// In en, this message translates to:
  /// **'Add card'**
  String get add_card;

  /// No description provided for @card_information.
  ///
  /// In en, this message translates to:
  /// **'Card information'**
  String get card_information;

  /// No description provided for @card_number.
  ///
  /// In en, this message translates to:
  /// **'Card number'**
  String get card_number;

  /// No description provided for @mm_yy.
  ///
  /// In en, this message translates to:
  /// **'MM/YY'**
  String get mm_yy;

  /// No description provided for @cvc.
  ///
  /// In en, this message translates to:
  /// **'CVC'**
  String get cvc;

  /// No description provided for @billing_address.
  ///
  /// In en, this message translates to:
  /// **'Billing address'**
  String get billing_address;

  /// No description provided for @country_or_region.
  ///
  /// In en, this message translates to:
  /// **'Country or region'**
  String get country_or_region;

  /// No description provided for @zip.
  ///
  /// In en, this message translates to:
  /// **'ZIP'**
  String get zip;

  /// No description provided for @zip_code.
  ///
  /// In en, this message translates to:
  /// **'ZIP Code'**
  String get zip_code;

  /// No description provided for @save_this_card_for_future_payment.
  ///
  /// In en, this message translates to:
  /// **'Save this card for future payment'**
  String get save_this_card_for_future_payment;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @united_states.
  ///
  /// In en, this message translates to:
  /// **'United States'**
  String get united_states;

  /// No description provided for @canada.
  ///
  /// In en, this message translates to:
  /// **'Canada'**
  String get canada;

  /// No description provided for @mexico.
  ///
  /// In en, this message translates to:
  /// **'Mexico'**
  String get mexico;

  /// No description provided for @india.
  ///
  /// In en, this message translates to:
  /// **'India'**
  String get india;

  /// No description provided for @germany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get germany;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @enter_your_current_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password'**
  String get enter_your_current_password;

  /// No description provided for @enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your new password'**
  String get enter_your_new_password;

  /// No description provided for @re_enter_your_new_password.
  ///
  /// In en, this message translates to:
  /// **'Re-enter your new password'**
  String get re_enter_your_new_password;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @email_us.
  ///
  /// In en, this message translates to:
  /// **'Email Us'**
  String get email_us;

  /// No description provided for @facebook.
  ///
  /// In en, this message translates to:
  /// **'Facebook'**
  String get facebook;

  /// No description provided for @instagram.
  ///
  /// In en, this message translates to:
  /// **'Instagram'**
  String get instagram;

  /// No description provided for @payment_method.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get payment_method;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get payment_methods;

  /// No description provided for @add_payments_method.
  ///
  /// In en, this message translates to:
  /// **'Add payments method'**
  String get add_payments_method;

  /// No description provided for @driver_profile.
  ///
  /// In en, this message translates to:
  /// **'Driver Profile'**
  String get driver_profile;

  /// No description provided for @about_me.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get about_me;

  /// No description provided for @lorem_ipsum_is_simply_dummy_text_of_the_printing_and_typesetting_industry_lorem_ipsum_has_been_the_industry_s_standard_dummy_text_ever_since_the_1500s.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s'**
  String
  get lorem_ipsum_is_simply_dummy_text_of_the_printing_and_typesetting_industry_lorem_ipsum_has_been_the_industry_s_standard_dummy_text_ever_since_the_1500s;

  /// No description provided for @verifications.
  ///
  /// In en, this message translates to:
  /// **'Verifications'**
  String get verifications;

  /// No description provided for @verified_id.
  ///
  /// In en, this message translates to:
  /// **'Verified ID'**
  String get verified_id;

  /// No description provided for @confirmed_email.
  ///
  /// In en, this message translates to:
  /// **'Confirmed email'**
  String get confirmed_email;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get photo;

  /// No description provided for @vehicle.
  ///
  /// In en, this message translates to:
  /// **'Vehicle'**
  String get vehicle;

  /// No description provided for @completed_trips.
  ///
  /// In en, this message translates to:
  /// **'Completed Trips'**
  String get completed_trips;

  /// No description provided for @referrals.
  ///
  /// In en, this message translates to:
  /// **'Referrals'**
  String get referrals;

  /// No description provided for @member_since.
  ///
  /// In en, this message translates to:
  /// **'Member Since'**
  String get member_since;

  /// No description provided for @trip_cancellations.
  ///
  /// In en, this message translates to:
  /// **'Trip Cancellations'**
  String get trip_cancellations;

  /// No description provided for @claims.
  ///
  /// In en, this message translates to:
  /// **'Claims'**
  String get claims;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @dec_2020.
  ///
  /// In en, this message translates to:
  /// **'Dec 2020'**
  String get dec_2020;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @leo_messi.
  ///
  /// In en, this message translates to:
  /// **'Leo Messi'**
  String get leo_messi;

  /// No description provided for @leomessi_gmail_com.
  ///
  /// In en, this message translates to:
  /// **'leomessi@gmail.com'**
  String get leomessi_gmail_com;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'GENERAL'**
  String get general;

  /// No description provided for @wallet_transactions.
  ///
  /// In en, this message translates to:
  /// **'Wallet & Transactions'**
  String get wallet_transactions;

  /// No description provided for @app_preferences.
  ///
  /// In en, this message translates to:
  /// **'APP PREFERENCES'**
  String get app_preferences;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @support_legal.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT & LEGAL'**
  String get support_legal;

  /// No description provided for @log_out.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get log_out;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @percent_commission_free.
  ///
  /// In en, this message translates to:
  /// **'100% Commission Free'**
  String get percent_commission_free;

  /// No description provided for @on_your_next_published_trip.
  ///
  /// In en, this message translates to:
  /// **'On your next published trip'**
  String get on_your_next_published_trip;

  /// No description provided for @share_your_code.
  ///
  /// In en, this message translates to:
  /// **'Share your code'**
  String get share_your_code;

  /// No description provided for @send_your_unique_code_to_friends.
  ///
  /// In en, this message translates to:
  /// **'Send your unique code to friends.'**
  String get send_your_unique_code_to_friends;

  /// No description provided for @friend_joins.
  ///
  /// In en, this message translates to:
  /// **'Friend joins'**
  String get friend_joins;

  /// No description provided for @your_friend_records_it_when_signing_up.
  ///
  /// In en, this message translates to:
  /// **'Your friend records it when signing up.'**
  String get your_friend_records_it_when_signing_up;

  /// No description provided for @you_both_win.
  ///
  /// In en, this message translates to:
  /// **'You both win'**
  String get you_both_win;

  /// No description provided for @get_discounts_on_your_trips_automatically.
  ///
  /// In en, this message translates to:
  /// **'Get discounts on your trips automatically.'**
  String get get_discounts_on_your_trips_automatically;

  /// No description provided for @your_code.
  ///
  /// In en, this message translates to:
  /// **'Your Code'**
  String get your_code;

  /// No description provided for @share_code.
  ///
  /// In en, this message translates to:
  /// **'Share Code'**
  String get share_code;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @total_balance.
  ///
  /// In en, this message translates to:
  /// **'TOTAL BALANCE'**
  String get total_balance;

  /// No description provided for @recent_activity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recent_activity;

  /// No description provided for @earned_2500.
  ///
  /// In en, this message translates to:
  /// **'Earned : \$2500'**
  String get earned_2500;

  /// No description provided for @trip_madrid_to_barcelona.
  ///
  /// In en, this message translates to:
  /// **'Trip : Madrid to Barcelona'**
  String get trip_madrid_to_barcelona;

  /// No description provided for @drive_madrid_to_barcelona.
  ///
  /// In en, this message translates to:
  /// **'Drive : Madrid to Barcelona'**
  String get drive_madrid_to_barcelona;

  /// No description provided for @today_10_25_am.
  ///
  /// In en, this message translates to:
  /// **'Today, 10:25 AM'**
  String get today_10_25_am;

  /// No description provided for @from.
  ///
  /// In en, this message translates to:
  /// **'from'**
  String get from;

  /// No description provided for @morelia_avenida_p_calle_12.
  ///
  /// In en, this message translates to:
  /// **'Morelia, Avenida P. Calle 12'**
  String get morelia_avenida_p_calle_12;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get to;

  /// No description provided for @small.
  ///
  /// In en, this message translates to:
  /// **'Small'**
  String get small;

  /// No description provided for @medium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// No description provided for @large.
  ///
  /// In en, this message translates to:
  /// **'Large'**
  String get large;

  /// No description provided for @toyota_corolla.
  ///
  /// In en, this message translates to:
  /// **'TOYOTA COROLLA'**
  String get toyota_corolla;

  /// No description provided for @view_details.
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get view_details;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level'**
  String get level;

  /// No description provided for @stars.
  ///
  /// In en, this message translates to:
  /// **'Stars'**
  String get stars;

  /// No description provided for @features.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get features;

  /// No description provided for @verified_profile.
  ///
  /// In en, this message translates to:
  /// **'Verified Profile'**
  String get verified_profile;

  /// No description provided for @automatic_reservation.
  ///
  /// In en, this message translates to:
  /// **'Automatic Reservation'**
  String get automatic_reservation;

  /// No description provided for @confirm_filters.
  ///
  /// In en, this message translates to:
  /// **'Confirm Filters'**
  String get confirm_filters;

  /// No description provided for @confirm_booking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirm_booking;

  /// No description provided for @wait_for_driver_approval.
  ///
  /// In en, this message translates to:
  /// **'Wait for Driver Approval'**
  String get wait_for_driver_approval;

  /// No description provided for @we_ve_sent_your_request_waiting_for_a_driver_to_accept.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent your request. Waiting for a driver to accept.'**
  String get we_ve_sent_your_request_waiting_for_a_driver_to_accept;

  /// No description provided for @dhm_ga29_5455.
  ///
  /// In en, this message translates to:
  /// **'DHM-GA29-5455'**
  String get dhm_ga29_5455;

  /// No description provided for @toyota_hr_v_white.
  ///
  /// In en, this message translates to:
  /// **'Toyota HR - V | White'**
  String get toyota_hr_v_white;

  /// No description provided for @rides_1000.
  ///
  /// In en, this message translates to:
  /// **'1,000 Rides'**
  String get rides_1000;

  /// No description provided for @rating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// No description provided for @trips.
  ///
  /// In en, this message translates to:
  /// **'Trips'**
  String get trips;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @year_3.
  ///
  /// In en, this message translates to:
  /// **'3 year'**
  String get year_3;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @punctuality_you_could_smoke_i_make_stops_to_go_to_the_bathroom.
  ///
  /// In en, this message translates to:
  /// **'Punctuality. You could smoke. I make stops to go to the bathroom.'**
  String get punctuality_you_could_smoke_i_make_stops_to_go_to_the_bathroom;

  /// No description provided for @recent_reviews.
  ///
  /// In en, this message translates to:
  /// **'Recent Reviews'**
  String get recent_reviews;

  /// No description provided for @maria.
  ///
  /// In en, this message translates to:
  /// **'Maria'**
  String get maria;

  /// No description provided for @great_driver_very_punctual.
  ///
  /// In en, this message translates to:
  /// **'Great Driver, Very Punctual'**
  String get great_driver_very_punctual;

  /// No description provided for @report_user.
  ///
  /// In en, this message translates to:
  /// **'Report User'**
  String get report_user;

  /// No description provided for @please_select_a_reason_for_reporting_osbaldo_garcia_this_is_anonymous_and_helps_keep_our_community_safe.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason for reporting Osbaldo Garcia. This is anonymous and helps keep our community safe.'**
  String
  get please_select_a_reason_for_reporting_osbaldo_garcia_this_is_anonymous_and_helps_keep_our_community_safe;

  /// No description provided for @dangerous_driving.
  ///
  /// In en, this message translates to:
  /// **'Dangerous Driving'**
  String get dangerous_driving;

  /// No description provided for @vehicle_didn_t_match_description.
  ///
  /// In en, this message translates to:
  /// **'Vehicle didn’t match description'**
  String get vehicle_didn_t_match_description;

  /// No description provided for @wrong_drop_off.
  ///
  /// In en, this message translates to:
  /// **'Wrong Drop-off'**
  String get wrong_drop_off;

  /// No description provided for @rude_or_aggressive_behavior.
  ///
  /// In en, this message translates to:
  /// **'Rude or aggressive behavior'**
  String get rude_or_aggressive_behavior;

  /// No description provided for @package_damaged_or_lost.
  ///
  /// In en, this message translates to:
  /// **'Package damaged or lost'**
  String get package_damaged_or_lost;

  /// No description provided for @additional_details.
  ///
  /// In en, this message translates to:
  /// **'Additional Details'**
  String get additional_details;

  /// No description provided for @please_describe_what_happened.
  ///
  /// In en, this message translates to:
  /// **'Please describe what happened...'**
  String get please_describe_what_happened;

  /// No description provided for @submit_report.
  ///
  /// In en, this message translates to:
  /// **'Submit Report'**
  String get submit_report;

  /// No description provided for @trip.
  ///
  /// In en, this message translates to:
  /// **'Trip'**
  String get trip;

  /// No description provided for @passengers.
  ///
  /// In en, this message translates to:
  /// **'Passengers'**
  String get passengers;

  /// No description provided for @see_on_map.
  ///
  /// In en, this message translates to:
  /// **'See on Map'**
  String get see_on_map;

  /// No description provided for @trip_details.
  ///
  /// In en, this message translates to:
  /// **'Trip Details'**
  String get trip_details;

  /// No description provided for @results.
  ///
  /// In en, this message translates to:
  /// **'Results'**
  String get results;

  /// No description provided for @barcelona_to_madrid.
  ///
  /// In en, this message translates to:
  /// **'Barcelona to Madrid'**
  String get barcelona_to_madrid;

  /// No description provided for @sat_oct_18_10_30_pm.
  ///
  /// In en, this message translates to:
  /// **'Sat, Oct 18  •  10:30 PM'**
  String get sat_oct_18_10_30_pm;

  /// No description provided for @passenger_1.
  ///
  /// In en, this message translates to:
  /// **'1 passengers'**
  String get passenger_1;

  /// No description provided for @travel_smarter_together.
  ///
  /// In en, this message translates to:
  /// **'Travel Smarter, Together'**
  String get travel_smarter_together;

  /// No description provided for @find_long_distance_rides_or_send_packages_securely_with_verified_drivers.
  ///
  /// In en, this message translates to:
  /// **'Find long-distance rides or send packages securely with verified drivers.'**
  String
  get find_long_distance_rides_or_send_packages_securely_with_verified_drivers;

  /// No description provided for @verified_people_real_trips.
  ///
  /// In en, this message translates to:
  /// **'Verified People. Real Trips.'**
  String get verified_people_real_trips;

  /// No description provided for @every_driver_and_user_is_id_verified_to_keep_every_journey_safe_and_reliable.
  ///
  /// In en, this message translates to:
  /// **'Every driver and user is ID-verified to keep every journey safe and reliable.'**
  String
  get every_driver_and_user_is_id_verified_to_keep_every_journey_safe_and_reliable;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @where_are_you_going.
  ///
  /// In en, this message translates to:
  /// **'Where are you going?'**
  String get where_are_you_going;

  /// No description provided for @continue_text.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_text;

  /// No description provided for @vehicle_space.
  ///
  /// In en, this message translates to:
  /// **'Vehicle & Space'**
  String get vehicle_space;

  /// No description provided for @empty_seats.
  ///
  /// In en, this message translates to:
  /// **'Empty Seats'**
  String get empty_seats;

  /// No description provided for @trunk_space.
  ///
  /// In en, this message translates to:
  /// **'Trunk Space'**
  String get trunk_space;

  /// No description provided for @set_your_price.
  ///
  /// In en, this message translates to:
  /// **'Set your price'**
  String get set_your_price;

  /// No description provided for @price_per_seat.
  ///
  /// In en, this message translates to:
  /// **'Price per seat'**
  String get price_per_seat;

  /// No description provided for @lorem_ipsum_is_simply_dummy_text_of_the_printing_and_typesetting_industry_lorem_ipsum.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum'**
  String
  get lorem_ipsum_is_simply_dummy_text_of_the_printing_and_typesetting_industry_lorem_ipsum;

  /// No description provided for @barcelona_to_real_madrid.
  ///
  /// In en, this message translates to:
  /// **'Barcelona  →  Real Madrid'**
  String get barcelona_to_real_madrid;

  /// No description provided for @confirmed_passengers.
  ///
  /// In en, this message translates to:
  /// **'Confirmed Passengers'**
  String get confirmed_passengers;

  /// No description provided for @pending_requests_2.
  ///
  /// In en, this message translates to:
  /// **'Pending Requests (2)'**
  String get pending_requests_2;

  /// No description provided for @active_trip.
  ///
  /// In en, this message translates to:
  /// **'Active Trip'**
  String get active_trip;

  /// No description provided for @earning.
  ///
  /// In en, this message translates to:
  /// **'Earning'**
  String get earning;

  /// No description provided for @packages.
  ///
  /// In en, this message translates to:
  /// **'Packages'**
  String get packages;

  /// No description provided for @est_time.
  ///
  /// In en, this message translates to:
  /// **'Est. Time'**
  String get est_time;

  /// No description provided for @seats_2.
  ///
  /// In en, this message translates to:
  /// **'2 Seats'**
  String get seats_2;

  /// No description provided for @cancel_trip.
  ///
  /// In en, this message translates to:
  /// **'Cancel Trip'**
  String get cancel_trip;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @drop_off_code.
  ///
  /// In en, this message translates to:
  /// **'Drop off Code'**
  String get drop_off_code;

  /// No description provided for @give_to.
  ///
  /// In en, this message translates to:
  /// **'Give to'**
  String get give_to;

  /// No description provided for @final_code.
  ///
  /// In en, this message translates to:
  /// **'Final Code'**
  String get final_code;

  /// No description provided for @start_trip.
  ///
  /// In en, this message translates to:
  /// **'Start Trip'**
  String get start_trip;

  /// No description provided for @scheduled.
  ///
  /// In en, this message translates to:
  /// **'scheduled'**
  String get scheduled;

  /// No description provided for @saturday_10_20_25_8_40_am.
  ///
  /// In en, this message translates to:
  /// **'Saturday 10/20/25, 8:40 AM'**
  String get saturday_10_20_25_8_40_am;

  /// No description provided for @seats.
  ///
  /// In en, this message translates to:
  /// **'Seats'**
  String get seats;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @trip_published.
  ///
  /// In en, this message translates to:
  /// **'Trip Published'**
  String get trip_published;

  /// No description provided for @passengers_can_now_book_your_ride_to_madrid.
  ///
  /// In en, this message translates to:
  /// **'Passengers can now book your ride to Madrid'**
  String get passengers_can_now_book_your_ride_to_madrid;

  /// No description provided for @view_my_trips.
  ///
  /// In en, this message translates to:
  /// **'View My Trips'**
  String get view_my_trips;

  /// No description provided for @security_handshake.
  ///
  /// In en, this message translates to:
  /// **'Security Handshake'**
  String get security_handshake;

  /// No description provided for @start_code.
  ///
  /// In en, this message translates to:
  /// **'Start Code'**
  String get start_code;

  /// No description provided for @give_at_pickup.
  ///
  /// In en, this message translates to:
  /// **'Give At Pickup'**
  String get give_at_pickup;

  /// No description provided for @end_code.
  ///
  /// In en, this message translates to:
  /// **'END CODE'**
  String get end_code;

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'claim'**
  String get claim;

  /// No description provided for @cancel_ride.
  ///
  /// In en, this message translates to:
  /// **'Cancel Ride'**
  String get cancel_ride;

  /// No description provided for @keep_my_trip.
  ///
  /// In en, this message translates to:
  /// **'Keep my trip'**
  String get keep_my_trip;

  /// No description provided for @select_wrong_dropoff.
  ///
  /// In en, this message translates to:
  /// **'Select wrong dropoff'**
  String get select_wrong_dropoff;

  /// No description provided for @selected_wrong_pickup.
  ///
  /// In en, this message translates to:
  /// **'Selected wrong pickup'**
  String get selected_wrong_pickup;

  /// No description provided for @selected_wrong_vehicle.
  ///
  /// In en, this message translates to:
  /// **'Selected wrong vehicle'**
  String get selected_wrong_vehicle;

  /// No description provided for @wait_time_was_too_long.
  ///
  /// In en, this message translates to:
  /// **'Wait time was too long'**
  String get wait_time_was_too_long;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @confirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get confirmed;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @saturday_10_20_25.
  ///
  /// In en, this message translates to:
  /// **'Saturday 10/20/25'**
  String get saturday_10_20_25;

  /// No description provided for @publish_trip.
  ///
  /// In en, this message translates to:
  /// **'Publish Trip'**
  String get publish_trip;

  /// No description provided for @rate_your_driver.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Driver'**
  String get rate_your_driver;

  /// No description provided for @write_your_feedback.
  ///
  /// In en, this message translates to:
  /// **'Write your feedback...'**
  String get write_your_feedback;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @driver_name.
  ///
  /// In en, this message translates to:
  /// **'Driver Name'**
  String get driver_name;

  /// No description provided for @map_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Map Placeholder'**
  String get map_placeholder;

  /// No description provided for @volkswagen_jetta.
  ///
  /// In en, this message translates to:
  /// **'volkswagenJetta'**
  String get volkswagen_jetta;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get year;

  /// No description provided for @plate_number.
  ///
  /// In en, this message translates to:
  /// **'Plate Number'**
  String get plate_number;

  /// No description provided for @pay_amount.
  ///
  /// In en, this message translates to:
  /// **'Pay Amount'**
  String get pay_amount;

  /// No description provided for @payment_successful.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get payment_successful;

  /// No description provided for @rate_your_driver_button.
  ///
  /// In en, this message translates to:
  /// **'Rate Your Driver Button'**
  String get rate_your_driver_button;

  /// No description provided for @my_tips.
  ///
  /// In en, this message translates to:
  /// **'My Tips'**
  String get my_tips;

  /// No description provided for @booked.
  ///
  /// In en, this message translates to:
  /// **'Booked'**
  String get booked;

  /// No description provided for @published.
  ///
  /// In en, this message translates to:
  /// **'Published'**
  String get published;

  /// No description provided for @trip_duration.
  ///
  /// In en, this message translates to:
  /// **'Trip Duration'**
  String get trip_duration;

  /// No description provided for @wait_for_other_users_approval.
  ///
  /// In en, this message translates to:
  /// **'Wait for other users Approval'**
  String get wait_for_other_users_approval;

  /// No description provided for @enable_package_delivery.
  ///
  /// In en, this message translates to:
  /// **'Enable Package Delivery'**
  String get enable_package_delivery;

  /// No description provided for @enter_pickup_code.
  ///
  /// In en, this message translates to:
  /// **'Enter Pickup Code'**
  String get enter_pickup_code;

  /// No description provided for @asked_the_passanger_for_the_code_to_confirm_their_pickup.
  ///
  /// In en, this message translates to:
  /// **'Asked the Passanger for the code to confirm their pickup'**
  String get asked_the_passanger_for_the_code_to_confirm_their_pickup;

  /// No description provided for @trip_compleated.
  ///
  /// In en, this message translates to:
  /// **'Trip Compleated'**
  String get trip_compleated;

  /// No description provided for @trip_in_progress.
  ///
  /// In en, this message translates to:
  /// **'Trip in Progress'**
  String get trip_in_progress;

  /// No description provided for @arived_at_destination.
  ///
  /// In en, this message translates to:
  /// **'Arived at destination'**
  String get arived_at_destination;

  /// No description provided for @place_name.
  ///
  /// In en, this message translates to:
  /// **'Place Name'**
  String get place_name;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
