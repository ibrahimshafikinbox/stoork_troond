import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @inputHint.
  ///
  /// In en, this message translates to:
  /// **'What are you looking for?'**
  String get inputHint;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get login;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'ُError'**
  String get error;

  /// No description provided for @passwordUpdated.
  ///
  /// In en, this message translates to:
  /// **'Password updated !'**
  String get passwordUpdated;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get checkYourEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgotYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password'**
  String get forgotYourPassword;

  /// No description provided for @lognCapital.
  ///
  /// In en, this message translates to:
  /// **'LOG IN'**
  String get lognCapital;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @verifyYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Verify your password'**
  String get verifyYourPassword;

  /// No description provided for @pleaseEnterTheFourDigitCode.
  ///
  /// In en, this message translates to:
  /// **'Please Enter The four digit code sent to your mail'**
  String get pleaseEnterTheFourDigitCode;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendCode;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'SEND'**
  String get send;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create new password'**
  String get createNewPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @sbmit.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT'**
  String get sbmit;

  /// No description provided for @pleaseEnterYourEmai.
  ///
  /// In en, this message translates to:
  /// **'Please Enter your email address to receive a verification'**
  String get pleaseEnterYourEmai;

  /// No description provided for @createAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Create an account '**
  String get createAnAccount;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password !'**
  String get enterYourPassword;

  /// No description provided for @createAnAccountCapital.
  ///
  /// In en, this message translates to:
  /// **'CREATE AN ACCOUNT'**
  String get createAnAccountCapital;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAnAccount;

  /// No description provided for @superSaleDiscount.
  ///
  /// In en, this message translates to:
  /// **'Super Sale Discount Up to 40%'**
  String get superSaleDiscount;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @addToAnotherList.
  ///
  /// In en, this message translates to:
  /// **'Add to another list'**
  String get addToAnotherList;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @chooseType.
  ///
  /// In en, this message translates to:
  /// **'Choose Type'**
  String get chooseType;

  /// No description provided for @chooseState.
  ///
  /// In en, this message translates to:
  /// **'Choose State'**
  String get chooseState;

  /// No description provided for @chooseCity.
  ///
  /// In en, this message translates to:
  /// **'Choose City'**
  String get chooseCity;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add address'**
  String get addAddress;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @state.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get state;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New address'**
  String get addNewAddress;

  /// No description provided for @default2.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get default2;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit address'**
  String get editAddress;

  /// No description provided for @errorTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Error , try again !'**
  String get errorTryAgain;

  /// No description provided for @beSupplier.
  ///
  /// In en, this message translates to:
  /// **'Be Supplier'**
  String get beSupplier;

  /// No description provided for @generalInfo.
  ///
  /// In en, this message translates to:
  /// **'General Info'**
  String get generalInfo;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country/Region'**
  String get country;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'Company name'**
  String get companyName;

  /// No description provided for @iAlreadyHaveTheActivationCode.
  ///
  /// In en, this message translates to:
  /// **'I already have the activation code !'**
  String get iAlreadyHaveTheActivationCode;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @bankAccount.
  ///
  /// In en, this message translates to:
  /// **'Bank account'**
  String get bankAccount;

  /// No description provided for @bankName.
  ///
  /// In en, this message translates to:
  /// **'Bank name'**
  String get bankName;

  /// No description provided for @accountName.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get accountName;

  /// No description provided for @accountNumber.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get accountNumber;

  /// No description provided for @iban.
  ///
  /// In en, this message translates to:
  /// **'IBAN'**
  String get iban;

  /// No description provided for @swift.
  ///
  /// In en, this message translates to:
  /// **'SWIFT'**
  String get swift;

  /// No description provided for @companyInfo.
  ///
  /// In en, this message translates to:
  /// **'Company Info'**
  String get companyInfo;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @numberOfEmployees.
  ///
  /// In en, this message translates to:
  /// **'Number of Employees'**
  String get numberOfEmployees;

  /// No description provided for @areYouAManufacturerOrADistributor.
  ///
  /// In en, this message translates to:
  /// **'Are you a manufacturer or a distributor?'**
  String get areYouAManufacturerOrADistributor;

  /// No description provided for @manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get manufacturer;

  /// No description provided for @distributor.
  ///
  /// In en, this message translates to:
  /// **'Distributor'**
  String get distributor;

  /// No description provided for @thankYouVeryMuch.
  ///
  /// In en, this message translates to:
  /// **'Thank you very much for your interest in the data supplement'**
  String get thankYouVeryMuch;

  /// No description provided for @verifiy.
  ///
  /// In en, this message translates to:
  /// **'Verifiy'**
  String get verifiy;

  /// No description provided for @pleaseEnterTheFourDigit.
  ///
  /// In en, this message translates to:
  /// **'Please Enter The four digit code sent to your mail'**
  String get pleaseEnterTheFourDigit;

  /// No description provided for @verificationCode.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCode;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @allProduct.
  ///
  /// In en, this message translates to:
  /// **'All product'**
  String get allProduct;

  /// No description provided for @bestSeller.
  ///
  /// In en, this message translates to:
  /// **'Best seller'**
  String get bestSeller;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @deletedToCart.
  ///
  /// In en, this message translates to:
  /// **'deleted to cart'**
  String get deletedToCart;

  /// No description provided for @yourShoppingCartLooksEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your shopping cart looks empty!'**
  String get yourShoppingCartLooksEmpty;

  /// No description provided for @whatAreYouWaitingFor.
  ///
  /// In en, this message translates to:
  /// **'What are you waiting for?'**
  String get whatAreYouWaitingFor;

  /// No description provided for @startShopping.
  ///
  /// In en, this message translates to:
  /// **'Start shopping'**
  String get startShopping;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @chooseAtLeastOneProduct.
  ///
  /// In en, this message translates to:
  /// **'Choose at least one product'**
  String get chooseAtLeastOneProduct;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get checkOut;

  /// No description provided for @fromYourFavorite.
  ///
  /// In en, this message translates to:
  /// **'From your Favorite'**
  String get fromYourFavorite;

  /// No description provided for @exploreMore.
  ///
  /// In en, this message translates to:
  /// **'Explore more'**
  String get exploreMore;

  /// No description provided for @shopOnBrand.
  ///
  /// In en, this message translates to:
  /// **'Shop on Brand'**
  String get shopOnBrand;

  /// No description provided for @shopByCategories.
  ///
  /// In en, this message translates to:
  /// **'Shop by Categories'**
  String get shopByCategories;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @thankYouForOrderFrom.
  ///
  /// In en, this message translates to:
  /// **'Thank you for order from trendwey'**
  String get thankYouForOrderFrom;

  /// No description provided for @yourOrderIsBeingProcessed.
  ///
  /// In en, this message translates to:
  /// **'Your order is being processed, You ‘ll receive an email at '**
  String get yourOrderIsBeingProcessed;

  /// No description provided for @onceYourOrderIsConfirmed.
  ///
  /// In en, this message translates to:
  /// **' once your order is confirmed'**
  String get onceYourOrderIsConfirmed;

  /// No description provided for @shippingDetails.
  ///
  /// In en, this message translates to:
  /// **'Shipping Details'**
  String get shippingDetails;

  /// No description provided for @dateShipping.
  ///
  /// In en, this message translates to:
  /// **'Date Shipping'**
  String get dateShipping;

  /// No description provided for @dateShopping.
  ///
  /// In en, this message translates to:
  /// **'Date Shopping'**
  String get dateShopping;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get items;

  /// No description provided for @delivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get delivery;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @trackTheOrder.
  ///
  /// In en, this message translates to:
  /// **'track the order'**
  String get trackTheOrder;

  /// No description provided for @chooseAnAddressFirst.
  ///
  /// In en, this message translates to:
  /// **'Choose an address first !'**
  String get chooseAnAddressFirst;

  /// No description provided for @shippingAddress.
  ///
  /// In en, this message translates to:
  /// **'Shipping Address'**
  String get shippingAddress;

  /// No description provided for @changeAddress.
  ///
  /// In en, this message translates to:
  /// **'Change Address'**
  String get changeAddress;

  /// No description provided for @yourOrder.
  ///
  /// In en, this message translates to:
  /// **'Your Order'**
  String get yourOrder;

  /// No description provided for @shipment.
  ///
  /// In en, this message translates to:
  /// **'Shipment'**
  String get shipment;

  /// No description provided for @deliveryBy.
  ///
  /// In en, this message translates to:
  /// **'Delivery by'**
  String get deliveryBy;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on delivery'**
  String get cashOnDelivery;

  /// No description provided for @extraCharge.
  ///
  /// In en, this message translates to:
  /// **'Extra charge :'**
  String get extraCharge;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order summary'**
  String get orderSummary;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'added to Favorites'**
  String get addedToFavorites;

  /// No description provided for @removedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'removed to Favorites'**
  String get removedToFavorites;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'Favorite'**
  String get favorite;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @colors.
  ///
  /// In en, this message translates to:
  /// **'Colors'**
  String get colors;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'MIN'**
  String get min;

  /// No description provided for @to.
  ///
  /// In en, this message translates to:
  /// **'TO'**
  String get to;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'MAX'**
  String get max;

  /// No description provided for @sortingBy.
  ///
  /// In en, this message translates to:
  /// **'Sorting by'**
  String get sortingBy;

  /// No description provided for @popularity.
  ///
  /// In en, this message translates to:
  /// **'Popularity'**
  String get popularity;

  /// No description provided for @highToLow.
  ///
  /// In en, this message translates to:
  /// **'Price : High to Low'**
  String get highToLow;

  /// No description provided for @lowToHigh.
  ///
  /// In en, this message translates to:
  /// **'Price : Low to High'**
  String get lowToHigh;

  /// No description provided for @newArrivais.
  ///
  /// In en, this message translates to:
  /// **'New Arrivais'**
  String get newArrivais;

  /// No description provided for @bestRated.
  ///
  /// In en, this message translates to:
  /// **'Best Rated'**
  String get bestRated;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search results'**
  String get searchResults;

  /// No description provided for @supportTeam.
  ///
  /// In en, this message translates to:
  /// **'Support Team'**
  String get supportTeam;

  /// No description provided for @askMeAnything.
  ///
  /// In en, this message translates to:
  /// **'Ask me anything... '**
  String get askMeAnything;

  /// No description provided for @dailyBestSells.
  ///
  /// In en, this message translates to:
  /// **'Daily Best Sells'**
  String get dailyBestSells;

  /// No description provided for @popularBrands.
  ///
  /// In en, this message translates to:
  /// **'Popular Brands'**
  String get popularBrands;

  /// No description provided for @popularProducts.
  ///
  /// In en, this message translates to:
  /// **'Popular Products'**
  String get popularProducts;

  /// No description provided for @showOtherCategory.
  ///
  /// In en, this message translates to:
  /// **'Show other Category'**
  String get showOtherCategory;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @addNewList.
  ///
  /// In en, this message translates to:
  /// **'add new list'**
  String get addNewList;

  /// No description provided for @editList.
  ///
  /// In en, this message translates to:
  /// **'edit a list'**
  String get editList;

  /// No description provided for @deletedList.
  ///
  /// In en, this message translates to:
  /// **'deleted a list'**
  String get deletedList;

  /// No description provided for @addItemToList.
  ///
  /// In en, this message translates to:
  /// **'add item to list'**
  String get addItemToList;

  /// No description provided for @removeItemToList.
  ///
  /// In en, this message translates to:
  /// **'remove item to list'**
  String get removeItemToList;

  /// No description provided for @createNewList.
  ///
  /// In en, this message translates to:
  /// **'Create new list'**
  String get createNewList;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @listName.
  ///
  /// In en, this message translates to:
  /// **'List name'**
  String get listName;

  /// No description provided for @enterYourListName.
  ///
  /// In en, this message translates to:
  /// **'Enter your List name'**
  String get enterYourListName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @process.
  ///
  /// In en, this message translates to:
  /// **'Process'**
  String get process;

  /// No description provided for @arriving.
  ///
  /// In en, this message translates to:
  /// **'Arriving'**
  String get arriving;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @shipping.
  ///
  /// In en, this message translates to:
  /// **'Shipping'**
  String get shipping;

  /// No description provided for @giveUsFeedback.
  ///
  /// In en, this message translates to:
  /// **'Give us feedback'**
  String get giveUsFeedback;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @youHaveNoPreviousOrders.
  ///
  /// In en, this message translates to:
  /// **'You have no previous orders'**
  String get youHaveNoPreviousOrders;

  /// No description provided for @noOrderHint.
  ///
  /// In en, this message translates to:
  /// **'We have thousands of items available across our wide range of sellers.Start ordering today!'**
  String get noOrderHint;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'continue shopping'**
  String get continueShopping;

  /// No description provided for @orderN.
  ///
  /// In en, this message translates to:
  /// **'Order N'**
  String get orderN;

  /// No description provided for @orderAt.
  ///
  /// In en, this message translates to:
  /// **'Order at'**
  String get orderAt;

  /// No description provided for @orderStatus.
  ///
  /// In en, this message translates to:
  /// **'Order Status'**
  String get orderStatus;

  /// No description provided for @itemsPurchased.
  ///
  /// In en, this message translates to:
  /// **'Items purchased'**
  String get itemsPurchased;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @rateHint.
  ///
  /// In en, this message translates to:
  /// **'Thank you for sharing your feedback on our product. We appreciate your input!'**
  String get rateHint;

  /// No description provided for @productReview.
  ///
  /// In en, this message translates to:
  /// **'Product review'**
  String get productReview;

  /// No description provided for @addReview.
  ///
  /// In en, this message translates to:
  /// **'Add review'**
  String get addReview;

  /// No description provided for @yourOverAllRating.
  ///
  /// In en, this message translates to:
  /// **'Your over all rating of this product'**
  String get yourOverAllRating;

  /// No description provided for @setYourReview.
  ///
  /// In en, this message translates to:
  /// **'Set your review'**
  String get setYourReview;

  /// No description provided for @whatDidYouLikeOrDeslike.
  ///
  /// In en, this message translates to:
  /// **'what did you like or deslike'**
  String get whatDidYouLikeOrDeslike;

  /// No description provided for @thankYouForSharing.
  ///
  /// In en, this message translates to:
  /// **'Thank you for sharing your feedback on our product. We appreciate your input!'**
  String get thankYouForSharing;

  /// No description provided for @review.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get review;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart  '**
  String get addToCart;

  /// No description provided for @cartTotal.
  ///
  /// In en, this message translates to:
  /// **'Cart Total'**
  String get cartTotal;

  /// No description provided for @addToCart2.
  ///
  /// In en, this message translates to:
  /// **'Add To Cart'**
  String get addToCart2;

  /// No description provided for @material.
  ///
  /// In en, this message translates to:
  /// **'Material'**
  String get material;

  /// No description provided for @overallRating.
  ///
  /// In en, this message translates to:
  /// **'Overall Rating'**
  String get overallRating;

  /// No description provided for @customerReviews.
  ///
  /// In en, this message translates to:
  /// **'Customer Reviews'**
  String get customerReviews;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get viewMore;

  /// No description provided for @relatedItems.
  ///
  /// In en, this message translates to:
  /// **'Related items'**
  String get relatedItems;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @marketPlace.
  ///
  /// In en, this message translates to:
  /// **'Market place '**
  String get marketPlace;

  /// No description provided for @specification.
  ///
  /// In en, this message translates to:
  /// **'Specification'**
  String get specification;

  /// No description provided for @chooseCode.
  ///
  /// In en, this message translates to:
  /// **'Choose code'**
  String get chooseCode;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @passwordsDoNOTMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do NOT match'**
  String get passwordsDoNOTMatch;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @updateInfo.
  ///
  /// In en, this message translates to:
  /// **'UPDATE INFO'**
  String get updateInfo;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'Preferred language'**
  String get preferredLanguage;

  /// No description provided for @securityNumber.
  ///
  /// In en, this message translates to:
  /// **'Security number'**
  String get securityNumber;

  /// No description provided for @changePhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Change Phone Number'**
  String get changePhoneNumber;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountHint.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to delete your account!?'**
  String get deleteAccountHint;

  /// No description provided for @setUpYourPrimaryNumber.
  ///
  /// In en, this message translates to:
  /// **'Set up your primary number'**
  String get setUpYourPrimaryNumber;

  /// No description provided for @pleaseEnterPin.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number,and we’ll send you a PIN'**
  String get pleaseEnterPin;

  /// No description provided for @enterYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your number'**
  String get enterYourNumber;

  /// No description provided for @changeNumber.
  ///
  /// In en, this message translates to:
  /// **'Change number'**
  String get changeNumber;

  /// No description provided for @tapToLoginOrCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Tap to login or create an account !'**
  String get tapToLoginOrCreateAccount;

  /// No description provided for @myList.
  ///
  /// In en, this message translates to:
  /// **'My list'**
  String get myList;

  /// No description provided for @beSubblier.
  ///
  /// In en, this message translates to:
  /// **'Be Subblier'**
  String get beSubblier;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logoutHint.
  ///
  /// In en, this message translates to:
  /// **'Are you sure to log out!?'**
  String get logoutHint;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @viewProduct.
  ///
  /// In en, this message translates to:
  /// **'View product'**
  String get viewProduct;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @youShouldCreateProductFirst.
  ///
  /// In en, this message translates to:
  /// **'you should create a product first !'**
  String get youShouldCreateProductFirst;

  /// No description provided for @chooseCategory.
  ///
  /// In en, this message translates to:
  /// **'Choose Category !'**
  String get chooseCategory;

  /// No description provided for @chooseBrand.
  ///
  /// In en, this message translates to:
  /// **'Choose Brand !'**
  String get chooseBrand;

  /// No description provided for @emptyValue.
  ///
  /// In en, this message translates to:
  /// **'ُEmpty value !'**
  String get emptyValue;

  /// No description provided for @addSuggestion.
  ///
  /// In en, this message translates to:
  /// **'add suggestion'**
  String get addSuggestion;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @itemAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Item Added Successfully'**
  String get itemAddedSuccessfully;

  /// No description provided for @youHaveAddTheItemSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'You have add the item successfully'**
  String get youHaveAddTheItemSuccessfully;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @sizeColor.
  ///
  /// In en, this message translates to:
  /// **'Size & color'**
  String get sizeColor;

  /// No description provided for @additionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Additional info'**
  String get additionalInfo;

  /// No description provided for @header.
  ///
  /// In en, this message translates to:
  /// **'Header'**
  String get header;

  /// No description provided for @productDescription.
  ///
  /// In en, this message translates to:
  /// **'Product Description'**
  String get productDescription;

  /// No description provided for @addNewOverview.
  ///
  /// In en, this message translates to:
  /// **'Add new Overview'**
  String get addNewOverview;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addNewSection.
  ///
  /// In en, this message translates to:
  /// **'+ Add New section'**
  String get addNewSection;

  /// No description provided for @specifications.
  ///
  /// In en, this message translates to:
  /// **'Specifications'**
  String get specifications;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @addNewSpecification.
  ///
  /// In en, this message translates to:
  /// **'Add new Specification'**
  String get addNewSpecification;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @enterProductName.
  ///
  /// In en, this message translates to:
  /// **'Enter product name'**
  String get enterProductName;

  /// No description provided for @subCategory.
  ///
  /// In en, this message translates to:
  /// **'Sub Category'**
  String get subCategory;

  /// No description provided for @enterProductDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter product description'**
  String get enterProductDescription;

  /// No description provided for @priceUnit.
  ///
  /// In en, this message translates to:
  /// **'Price & Unit'**
  String get priceUnit;

  /// No description provided for @basePrice.
  ///
  /// In en, this message translates to:
  /// **'Base price'**
  String get basePrice;

  /// No description provided for @beforeDiscount.
  ///
  /// In en, this message translates to:
  /// **'Before Discount'**
  String get beforeDiscount;

  /// No description provided for @afterDiscount.
  ///
  /// In en, this message translates to:
  /// **'After Discount'**
  String get afterDiscount;

  /// No description provided for @unit.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get unit;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @orDropFilesToUpload.
  ///
  /// In en, this message translates to:
  /// **' or drop files to \n upload'**
  String get orDropFilesToUpload;

  /// No description provided for @addNewColor.
  ///
  /// In en, this message translates to:
  /// **'Add new Color'**
  String get addNewColor;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @pickColor.
  ///
  /// In en, this message translates to:
  /// **'Pick a color!'**
  String get pickColor;

  /// No description provided for @addNewSize.
  ///
  /// In en, this message translates to:
  /// **'Add new size'**
  String get addNewSize;

  /// No description provided for @sizeName.
  ///
  /// In en, this message translates to:
  /// **'Size Name'**
  String get sizeName;

  /// No description provided for @addNewSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Add new Suggestion'**
  String get addNewSuggestion;

  /// No description provided for @categoryName.
  ///
  /// In en, this message translates to:
  /// **'Category Name'**
  String get categoryName;

  /// No description provided for @yourNote.
  ///
  /// In en, this message translates to:
  /// **'Your note'**
  String get yourNote;

  /// No description provided for @subCategoryName.
  ///
  /// In en, this message translates to:
  /// **'Sub Category Name'**
  String get subCategoryName;

  /// No description provided for @id.
  ///
  /// In en, this message translates to:
  /// **'ID'**
  String get id;

  /// No description provided for @itemName.
  ///
  /// In en, this message translates to:
  /// **'Item Name'**
  String get itemName;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit product'**
  String get editProduct;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @emptyFavoriteTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Wishlist is Empty'**
  String get emptyFavoriteTitle;

  /// No description provided for @emptyFavoriteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore our products and save your favorites to easily find them later and catch the best deals!'**
  String get emptyFavoriteSubtitle;

  /// No description provided for @exploreProducts.
  ///
  /// In en, this message translates to:
  /// **'Explore Products Now'**
  String get exploreProducts;

  /// No description provided for @accountAndActivity.
  ///
  /// In en, this message translates to:
  /// **'Account & Activity'**
  String get accountAndActivity;

  /// No description provided for @merchantAndSupplierHub.
  ///
  /// In en, this message translates to:
  /// **'Merchant & Supplier Hub'**
  String get merchantAndSupplierHub;

  /// No description provided for @settingsAndHelp.
  ///
  /// In en, this message translates to:
  /// **'Settings & Support'**
  String get settingsAndHelp;

  /// No description provided for @activeAccount.
  ///
  /// In en, this message translates to:
  /// **'Active Account'**
  String get activeAccount;

  /// No description provided for @verifiedSupplier.
  ///
  /// In en, this message translates to:
  /// **'Verified Supplier'**
  String get verifiedSupplier;

  /// No description provided for @joinNow.
  ///
  /// In en, this message translates to:
  /// **'Join Now'**
  String get joinNow;

  /// No description provided for @guestProfileHint.
  ///
  /// In en, this message translates to:
  /// **'Log in to enjoy full features and track your orders'**
  String get guestProfileHint;

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get noCategoriesAvailable;

  /// No description provided for @mainDepartments.
  ///
  /// In en, this message translates to:
  /// **'Main Departments'**
  String get mainDepartments;

  /// No description provided for @subcategories.
  ///
  /// In en, this message translates to:
  /// **'Subcategories'**
  String get subcategories;

  /// No description provided for @categoryCountSuffix.
  ///
  /// In en, this message translates to:
  /// **'subcategories'**
  String get categoryCountSuffix;

  /// No description provided for @noSubcategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No subcategories available'**
  String get noSubcategoriesAvailable;

  /// No description provided for @browseAllProducts.
  ///
  /// In en, this message translates to:
  /// **'Browse all products'**
  String get browseAllProducts;
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
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
