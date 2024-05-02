import 'package:flutter/material.dart';
import 'package:yellowline/view/screens/add_car_screen/vehicle_list_screen.dart';
import 'package:yellowline/view/screens/authentication/login_screen/login_screen.dart';
import '../../global_widgets/app_bar_colors.dart';
import '../../view/screens/My Request/view/my_request_main_screen.dart';
import '../../view/screens/add_car_screen/add_new_vehicle_screen.dart';
import '../../view/screens/add_car_screen/vehicle_added_sceen.dart';
import '../../view/screens/add_car_screen/vehicle_detail_screen.dart';
import '../../view/screens/authentication/otp_screen/otp_screen.dart';
import '../../view/screens/home_page/home_screen.dart';
import '../../view/screens/recovery_screens/view/drop_off_screen.dart';
import '../../view/screens/recovery_screens/recovery_confirmed_screen.dart';
import '../../view/screens/update_profile/view/update_user_profile.dart';
import 'router_path.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  print("setting......${settings.name}");
  switch (settings.name) {
    case RouterPath.Home_Screen:
      return MaterialPageRoute(
        builder: (context) => statusBarStyle(child: HomeScreen()),
      );

    case RouterPath.loginRout:
      return MaterialPageRoute(
        builder: (context) => LogInScreen(),
      );
    case RouterPath.Vehicle_List_Screen:
      return MaterialPageRoute(
        builder: (context) => VehicleListScreen(),
      );
    case RouterPath.Add_New_Vehicle_Screen:
      return MaterialPageRoute(
        builder: (context) => AddNewVehicleScreen(),
      );
    case RouterPath.Vehicle_Added_Screen:
      return MaterialPageRoute(
        builder: (context) => VehicleAddedScreen(),
      );
    case RouterPath.Vehicle_Detail:
      return MaterialPageRoute(
        builder: (context) => VehicleDetail(),
      );
    case RouterPath.Otp_Screen:
      return MaterialPageRoute(
        builder: (context) => OtpScreen(),
      );
    case RouterPath.add_request_screen_one:
      return MaterialPageRoute(
        builder: (context) => DropOffScreen(),
      );
    case RouterPath.complete_request_screen:
      return MaterialPageRoute(
        builder: (context) => RecoveryConfirmedScreen(),
      );
    case RouterPath.request_view_screen:
      return MaterialPageRoute(
        builder: (context) => MyRequestMainScreen(),
      );
    case RouterPath.UpdateUserProfileScreen:
      return MaterialPageRoute(
        builder: (context) => UpdateUserProfileScreen(),
      );
    // case RouterPath.business_home_Rout:
    //   return MaterialPageRoute(
    //     builder: (context) => BusinessHomeScreen(),
    //   );
    // case RouterPath.driver_home_Rout:
    //   return MaterialPageRoute(
    //     builder: (context) => DriverHomeScreen(),
    //   );
    // case RouterPath.busiess_driver_Rout:
    //   return MaterialPageRoute(
    //     builder: (context) => DriverListScreen(),
    //   );
    // case RouterPath.busiess_add_driver_Rout:
    //   return MaterialPageRoute(
    //     builder: (context) => AddNewDriverScreen(),
    //   );
    // case RouterPath.busiess_add_driver_approval_Rout:
    //   return MaterialPageRoute(
    //     builder: (context) => DriverApprovelScreen(),
    //   );
    //   case RouterPath.Business_Add_Vehicle_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => BusinessAddVehicleScreen(),
    //   );
    //   case RouterPath.Business_Vehicle_Detail:
    //   return MaterialPageRoute(
    //     builder: (context) => BusinessVehicleDetail(),
    //   );
    //   case RouterPath.Business_Vehicle_Added:
    //   return MaterialPageRoute(
    //     builder: (context) => BusinessVehicleAdded(),
    //   );

    // case RouterPath.onboardRout:
    //   return MaterialPageRoute(
    //     builder: (context) => OnBoardScreen(),
    //   );
    // case RouterPath.signupRout:
    //   return MaterialPageRoute(
    //     builder: (context) => SignUp(),
    //   );
    // case RouterPath.Search_Screen_Shop:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => SearchScreenShop(index: v),
    //   );
    // case RouterPath.Drafts_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => DraftsScreen(),
    //   );
    // case RouterPath.Edit_Profile_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => EditProfileScreen(),
    //   );
    // case RouterPath.chat_gpt_screen:
    //   return MaterialPageRoute(
    //     builder: (context) => CollectDataForRequestAI(),
    //   );
    // case RouterPath.Update_bio_screen:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => UpdateBio(from_edit: v),
    //   );
    // case RouterPath.WalkthrowScreenForTabDamo:
    //   return MaterialPageRoute(
    //     builder: (context) => WalkthrowScreenForTabDamo(),
    //   );
    // case RouterPath.Book_Mark_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => BookMarkScreen(),
    //   );
    // case RouterPath.Smart_Pin_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => SmartPinScreen(),
    //   );
    // case RouterPath.chooseAvatarRout:
    //   return MaterialPageRoute(
    //     builder: (context) => AvatarScreen(
    //         signUpPayload: settings.arguments as Map<String, dynamic>),
    //   );
    // case RouterPath.bottom_sheet:
    //   return MaterialPageRoute(
    //     builder: (context) => BottomSheetCustom(),
    //   );
    // case RouterPath.Notification_Screenn:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => NotificationScreenn(from_rating: v),
    //   );
    // case RouterPath.My_Published_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => MyPublishedScreen(),
    //   );
    // case RouterPath.Help_And_Support:
    //   return MaterialPageRoute(
    //     builder: (context) => HelpAndSupport(),
    //   );
    // case RouterPath.Change_Password_Profile:
    //   return MaterialPageRoute(
    //     builder: (context) => ChangePasswordProfile(),
    //   );
    // case RouterPath.ForgotPasswordScreen:
    //   return MaterialPageRoute(
    //     builder: (context) => ForgotPasswordScreen(),
    //   );
    // case RouterPath.friend_route:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => FriendsScreen(current_index: v),
    //   );
    // case RouterPath.syncContactRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => AddFriendScreen(),
    //   );
    // case RouterPath.created_itinerary_route:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => CreateItinerary(model: v),
    //   );
    // case RouterPath.public_itinerary_page_route:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => PublicItineraryPage(show_packing_budget: v),
    //   );
    // case RouterPath.add_new_destination_route:
    //   dynamic data = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => AddNewDestination(pre_selected_cities: data),
    //   );
    // case RouterPath.add_transportation:
    //   return MaterialPageRoute(
    //     builder: (context) =>
    //         AddTransportation(cities: settings.arguments as List<Destinations>),
    //   );
    // case RouterPath.day_details_collection:
    //   return MaterialPageRoute(
    //     builder: (context) => DayDetailsCollection(
    //         selected_city_index: settings.arguments as int),
    //   );
    // case RouterPath.create_summry_view:
    //   return MaterialPageRoute(
    //     builder: (context) => CreateSummryView(),
    //   );
    // case RouterPath.search_for_day:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => SearchPlaceForDay(is_update_location: v ?? null),
    //   );
    // case RouterPath.selected_place_for_day:
    //   var v = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => SelectedPlaceForTheDay(
    //         info: v.containsKey('info') ? v['info'] : null,
    //         activity: v.containsKey('activity') ? v['activity'] : null),
    //   );
    // case RouterPath.wallet_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => WalletScreenNew(),
    //   );
    // case RouterPath.Terms_And_Condition:
    //   return MaterialPageRoute(
    //     builder: (context) => TermsAndCondition(),
    //   );
    // case RouterPath.verify_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => WalletVerifyAccount(),
    //   );
    // case RouterPath.verify_account_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => AddBankDetail(),
    //   );
    // case RouterPath.Wallet_Otp_Screen:
    //   return MaterialPageRoute(
    //     builder: (context) => WalletOtpScreen(
    //         verifyModelRequest: settings.arguments as VerifyModelRequest),
    //   );
    // case RouterPath.add_packing_category:
    //   return MaterialPageRoute(
    //     builder: (context) => AddPackingCategory(),
    //   );
    // case RouterPath.add_budget_category:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => AddBudget(budget: v),
    //   );
    // case RouterPath.add_packing_sub_category:
    //   dynamic data = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => AddPackingSubCategory(
    //       packing: data,
    //     ),
    //   );
    // case RouterPath.Discover_Land:
    //   return MaterialPageRoute(
    //     builder: (context) => DiscoverLand(),
    //   );
    // case RouterPath.create_list:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => CreateList(model: v),
    //   );
    // case RouterPath.list_day_details_collection:
    //   return MaterialPageRoute(
    //     builder: (context) => ListDayDetailsCollection(),
    //   );
    // case RouterPath.list_selected_place_for_day:
    //   var v = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => ListSelectedPlaceForTheDay(
    //         info: v.containsKey('info') ? v['info'] : null,
    //         activity: v.containsKey('activity') ? v['activity'] : null),
    //   );
    // case RouterPath.AllRatingScreen:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => AllRatingScreen(
    //       id: v['id'],
    //       rating: v['rating'],
    //       user_name: v['user_name'],
    //       itinerary_name: v['itinerary_name'],
    //       rate: v['rate'],
    //       previous_rating: v['previous_rating'],
    //     ),
    //   );
    // case RouterPath.list_search_place_for_day:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => ListSearchPlaceForDay(is_update_location: v),
    //   );
    // case RouterPath.Itinerary_detail__home_view:
    //   var v = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => ItineraryHomeView(
    //         id: v['id'],
    //         purchased: v['purchased'],
    //         is_back: v.containsKey('back') ? v['back'] : true),
    //   );
    // case RouterPath.other_user_profile:
    //   var v = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => OtherUserProfile(
    //         userName: v.containsKey('UserName') ? v['UserName'] : v['id'],
    //         is_back: v.containsKey('back') ? v['back'] : true),
    //   );
    // case RouterPath.details_public_itinerary_page:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => DetailsPublicItineraryPage(info: v),
    //   );
    // case RouterPath.itinerary_detail_day_detail_collection:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) =>
    //         ItineraryDetailDayDetailsCollection(selected_city_index: v),
    //   );
    // case RouterPath.buy_itinerary_view:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => BuyItineraryView(),
    //   );
    // case RouterPath.buy_list_view:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => BuyListView(),
    //   );
    // case RouterPath.destination_detail_for_one_category:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => DestinationDetailForOneCategory(
    //       activity_info: v,
    //     ),
    //   );
    // case RouterPath.detail_list_day_details_collection:
    //   var v = settings.arguments as Map<String, dynamic>;
    //   return MaterialPageRoute(
    //     builder: (context) => DetailListDayDetailsCollection(
    //       id: v['id'],
    //       purchased: v['purchased'],
    //       is_back: v.containsKey('back') ? v['back'] : true,
    //     ),
    //   );
    // case RouterPath.view_user_profile:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //     builder: (context) => YourFriends(
    //         avatar: v['avatar'],
    //         firstName: v['firstName'],
    //         lastName: v['lastName'],
    //         status: v['status'],
    //         userId: v['userId'],
    //         userName: v['userName']),
    //   );
    // case RouterPath.storyViewRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => StoryViewModel(
    //             images: settings.arguments as List<String>,
    //           ));
    // case RouterPath.main_budget_packing:
    //   return MaterialPageRoute(builder: (context) => MainBudgetPacking());
    // case RouterPath.detail_packing_sub_category:
    //   dynamic v = settings.arguments;
    //   return MaterialPageRoute(
    //       builder: (context) => DetailPackingSubCategory(
    //             packing: v,
    //           ));

    // case routes.forgetRout:
    //   return MaterialPageRoute(
    //     builder: (context) => ForgetPasswordScreen(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.resetRout:
    //   return MaterialPageRoute(
    //     builder: (context) => ResetPasswordScreen(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.dashboardRout:
    //   return MaterialPageRoute(
    //     builder: (context) => MainPage(
    //       map: settings.arguments == null ? null : settings.arguments as Map,
    //     ),
    //   );
    // case routes.termRout:
    //   return MaterialPageRoute(
    //     builder: (context) => const TermsAndConditions(
    //       isFromSignUp: false,
    //     ),
    //   );
    // case routes.termRoutSecond:
    //   return MaterialPageRoute(
    //     builder: (context) => const TermsAndConditions(
    //       isFromSignUp: true,
    //     ),
    //   );
    // case routes.successRout:
    //   return MaterialPageRoute(
    //     builder: (context) => const SuccessScreen(),
    //   );
    // case routes.chooseAvatarRout:
    //   return MaterialPageRoute(
    //       builder: (context) => ChooseAvatar(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.updateAvatarRout:
    //   return MaterialPageRoute(
    //       builder: (context) => UpdateAvatar(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.avatarRout:
    //   return MaterialPageRoute(
    //       builder: (context) => AvatarsTypesScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.destinationRout:
    //   return MaterialPageRoute(
    //     builder: (context) => SelectDestination(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.summaryRoutStart:
    //   return MaterialPageRoute(
    //     builder: (context) => SummaryScreen(
    //       routeName: start,
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.summaryRoutSold:
    //   return MaterialPageRoute(
    //     builder: (context) => SummaryScreen(
    //       routeName: sold,
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.summaryRoutEdit:
    //   return MaterialPageRoute(
    //     builder: (context) => SummaryScreen(
    //       routeName: edit,
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.summaryRoutPurchase:
    //   return MaterialPageRoute(
    //     builder: (context) => SummaryScreen(
    //       routeName: purchase,
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.designIntineraryRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => DesignIntineraryScreen(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.draftIntineraryRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => DraftItineraryScreen(
    //       isFromHome:
    //           settings.arguments == null ? null : settings.arguments as bool,
    //     ),
    //   );
    // case routes.dayDesignRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => DayDesignIntineraryScreen(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.checkListRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => CheckListScreen(
    //       map: settings.arguments as Map,
    //     ),
    //   );
    // case routes.soldIntineraryRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const SoldItineraryScreen(),
    //   );
    // case routes.shareIntineraryRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const ShareIntinerary(),
    //   );
    // case routes.animationRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => ShowAnimation(
    //       signInRequest: settings.arguments as SignInRequest,
    //     ),
    //   );
    // case routes.accountRoute:
    //   return MaterialPageRoute(builder: (context) => const AccountHome());
    // case routes.nameSettingRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const NameScreen(),
    //   );
    // case routes.avatarSettingRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const AvatarScreen(),
    //   );
    // case routes.mobileSettingRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const PhoneScreen(),
    //   );
    // case routes.emailSettingRoute:
    //   return MaterialPageRoute(
    //     builder: (context) => const EmailScreen(),
    //   );
    // case routes.birthdaySettingRoute:
    //   return MaterialPageRoute(builder: (context) => const BirthdayScreen());
    // case routes.passwordSettingRoute:
    //   return MaterialPageRoute(builder: (context) => const PasswordScreen());
    // case routes.bankDetailRoute:
    //   return MaterialPageRoute(builder: (context) => const BankDetail());
    // case routes.bankUpdateRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => UpdateBankDetails(
    //             map: settings.arguments == null
    //                 ? null
    //                 : settings.arguments as Map,
    //           ));
    // case routes.searchPlacesRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => SearchPlacesScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.foodShoppingRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => FoodAndShoppingInformation(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.viewPurchaseItemRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => PurchaseItemDetailScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.searchItineraryRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => const SearchItineraryScreen());
    // case routes.storyViewRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => StoryViewModel(
    //             images: settings.arguments as List<String>,
    //           ));
    // case routes.mapViewRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => StartMainPage(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.soldDetailViewRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => SoldItineraryDetail(
    //             soldAllResult: settings.arguments as SoldAllResult,
    //           ));
    // case routes.tripCompletedRoute:
    //   return MaterialPageRoute(
    //       builder: (context) =>
    //           TripCompleteScreen(map: settings.arguments as Map));
    // case routes.purchaseDetailRoute:
    //   return MaterialPageRoute(
    //       builder: (context) =>
    //           ViewPurchaseItinerary(map: settings.arguments as Map));
    // case routes.viewLocationRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => ViewLocationScreen(
    //           listOfFlag: settings.arguments as List<FlagInformation>));
    // case routes.enabledLocationRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => SeeMyLocation(
    //             type: settings.arguments as String,
    //           ));
    // case routes.publicProfileRoute:
    //   return MaterialPageRoute(
    //       builder: (context) =>
    //           PublicProfileScreen(userName: settings.arguments as String));
    // case routes.friendsRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => MainTabScreen(
    //             type: settings.arguments == null
    //                 ? null
    //                 : settings.arguments as String,
    //           ));
    // case routes.blockRoute:
    //   return MaterialPageRoute(builder: (context) => BlockUserScreen());
    // case routes.rateRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => RateItineraryScreen(
    //             itineraryID: settings.arguments as String,
    //           ));
    // case routes.hoorayRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => TripSuccessScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.viewCreatedRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => CreateItineraryDetailScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.privacyRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => PrivacyPolicy(
    //             isFromSignUp: true,
    //           ));
    // case routes.helpRoute:
    //   return MaterialPageRoute(builder: (context) => HelpScreen());
    // case routes.prefShopRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => ShopPreferenceScreen(
    //             title: '',
    //           ));
    // case routes.recShopRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => RecommendedShopScreen(
    //             title: '',
    //           ));
    // case routes.allShopRoute:
    //   return MaterialPageRoute(builder: (context) => AllItineraryScreen());
    // case routes.addFriendRoute:
    //   return MaterialPageRoute(builder: (context) => AddFriendScreen());
    // case routes.searchFriendRoute:
    //   return MaterialPageRoute(builder: (context) => SearchFriendsScreen());
    // case routes.settingRoute:
    //   return MaterialPageRoute(builder: (context) => SettingHome());
    // case routes.deactivateRoute:
    //   return MaterialPageRoute(builder: (context) => DeactivateAccountScreen());
    // case routes.activateRoute:
    //   return MaterialPageRoute(builder: (context) => ActivateUserAccount());
    // case routes.syncContactRoute:
    //   return MaterialPageRoute(builder: (context) => SyncContactScreen());
    // case routes.purchaseSuccessRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => PurchasedSuccessScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.purchaseSuccessRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => PurchasedSuccessScreen(
    //             map: settings.arguments as Map,
    //           ));
    // case routes.deactivateReasonRoute:
    //   return MaterialPageRoute(builder: (context) => DeactivateReasonsScreen());
    // case routes.deactivatePasswordRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => DeactivatePasswordScreen());
    // case routes.walletRoute:
    //   return MaterialPageRoute(builder: (context) => WalletScreen());
    // case routes.verifyAccountRoute:
    //   return MaterialPageRoute(builder: (context) => VerifyAccountScreen());
    // case routes.smartPinRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => ResetPinScreen(
    //             pin: settings.arguments as String,
    //           ));
    // case routes.previewDocRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => PeiviewDocScreen(
    //             model: settings.arguments as model.ListOfFilesModel,
    //           ));
    // case routes.settingPreviewDocRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => SettingsPreviewDocScreen(
    //         model: settings.arguments as model.ListOfFilesModel,
    //       ));
    // case routes.amountWithdrawRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => AmountWithdrawScreen(
    //             walletResult: settings.arguments as WalletResult,
    //           ));
    //
    // case routes.pinWithdrawRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => WithdrawPinScreen(
    //             withdrawRequest: settings.arguments as WithdrawRequest,
    //           ));
    //
    // case routes.walletSuccessRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => WalletSuccessScreen(
    //             map: settings.arguments as Map,
    //           ));
    //
    // case routes.myBanksRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => MyBankScreen(
    //             verifyBanks: settings.arguments as List<VerifyBank>,
    //           ));
    //
    // case routes.docUploadRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => UploadDocScreen(
    //             listOfFilesModel: settings.arguments as model.ListOfFilesModel,
    //           ));
    //
    // case routes.settingDocUploadRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => SettingUploadDocScreen(
    //         listOfFilesModel: settings.arguments as model.ListOfFilesModel,
    //       ));
    //
    // case routes.walletSettingRoute:
    //   return MaterialPageRoute(builder: (context) => WalletSettingScreen(walletResult:settings.arguments == null? null:settings.arguments as WalletResult,));
    // case routes.oldPinRoute:
    //   return MaterialPageRoute(builder: (context) => OldPinScreen(walletResult: settings.arguments as WalletResult ,));
    //
    // case routes.settingResetPinRoute:
    //   return MaterialPageRoute(builder: (context) => SettingResetPinScreen(walletResult: settings.arguments as WalletResult,));
    // case routes.forgetResetPinRoute:
    //   return MaterialPageRoute(builder: (context) => ForgetPinRest());
    // case routes.updatePasswordRout:
    //   return MaterialPageRoute(builder: (context) => UpdatePasswordScreen());
    // case routes.verifyPasswordRout:
    //   return MaterialPageRoute(builder: (context) => verifyPasswordScreen(map: settings.arguments as Map,));
    // case routes.settingBankUpdateRoute:
    //   return MaterialPageRoute(
    //       builder: (context) => UpdateBankSettings(
    //         map: settings.arguments == null
    //             ? null
    //             : settings.arguments as Map,
    //       ));
    // case routes.myBanksSettingRout:
    //   return MaterialPageRoute(
    //       builder: (context) => MyBanksSettings(
    //         map: settings.arguments as Map,
    //       ));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
