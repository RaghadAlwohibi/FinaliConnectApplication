import 'package:flutter/material.dart';
import 'package:iconnect/_routing/routes.dart';
import 'package:iconnect/views/home.dart';

import 'package:iconnect/views/tabs/Search/Club/club_list.dart';
import 'package:iconnect/views/tabs/Search/Course/coures_list.dart';
import 'package:iconnect/views/tabs/Search/Instructor/instructor_list.dart';
import 'package:iconnect/views/tabs/Search/Major/major_list.dart';
import 'package:iconnect/views/tabs/admin/admin_ad_request_screen.dart';
import 'package:iconnect/views/tabs/admin/admin_ad_requests.dart';
import 'package:iconnect/views/tabs/admin/admin_home_screen.dart';
import 'package:iconnect/views/tabs/admin/admin_new_post.dart';
import 'package:iconnect/views/tabs/feed/feed.dart';

import 'package:iconnect/views/tabs/login/landing.dart';
import 'package:iconnect/views/tabs/login/login.dart';
import 'package:iconnect/views/tabs/notifications/notifications.dart';
import 'package:iconnect/views/tabs/posts/new_post.dart';

import 'package:iconnect/views/tabs/login/register.dart';
import 'package:iconnect/views/tabs/login/reset_password.dart';
import 'package:iconnect/views/tabs/profile/edit_profile.dart';
import 'package:iconnect/views/tabs/profile/profile_page.dart';
import 'package:iconnect/views/tabs/search/ads/adP.dart';
import 'package:iconnect/views/tabs/search/ads/adsitem.dart';
import 'package:iconnect/views/tabs/search/events/evP.dart';
import 'package:iconnect/views/tabs/search/events/eventitem.dart';
import 'package:iconnect/views/tabs/search/lostitem/lostP.dart';
import 'package:iconnect/views/tabs/search/search.dart';

import 'package:iconnect/views/welcome_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
   final args = settings.arguments;
  switch (settings.name) {
    case adminAdReuqests:
      return MaterialPageRoute(builder: (context) => AdminAdRequests());
    case welcomeScreen:
      return MaterialPageRoute(builder: (context) => WelcomeScreen());
    case landingViewRoute:
      return MaterialPageRoute(builder: (context) => LandingPage());
    case loginViewRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case newPostPage:
      return MaterialPageRoute(builder: (context) => NewPost());
    case feedPage:
      return MaterialPageRoute(builder: (context) => FeedsPage());
    case searchPage:
      return MaterialPageRoute(builder: (context) => SearchPage());
    case notificationsPage:
      return MaterialPageRoute(builder: (context) => NotificationsPage());
    case editProfilePage:
      return MaterialPageRoute(builder: (context) => EditProfile());
    case profilePage:
      return MaterialPageRoute(builder: (context) => ProfilePage());
    case registerViewRoute:
      return MaterialPageRoute(builder: (context) => RegisterPage());
    case resetPasswordViewRoute:
      return MaterialPageRoute(builder: (context) => ResetPasswordPage());
    case instructorList:
      return MaterialPageRoute(builder: (context) => InstructorList());
    case courseList:
      return MaterialPageRoute(builder: (context) => CourseList());
    case clubsList:
      return MaterialPageRoute(builder: (context) => ClubList());
    case homeViewRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
   
    case majorList:
      return MaterialPageRoute(builder: (context) => MajorList());
    case AdminHomePage.route:
      return MaterialPageRoute(builder: (context) => AdminHomePage());
    case adminAdsPage:
      return MaterialPageRoute(
          builder: (context) => AdminRequestAdPage(settings.arguments));

    case adminNewPost:
      return MaterialPageRoute(
          builder: (context) => AdminNewPost(
                post: settings.arguments,
              ));
                 case adsPage:
      return MaterialPageRoute(builder: (context) => AdPage());

    case eventsPage:
      return MaterialPageRoute(builder: (context) => EvPage());
    case detailPage:
      return MaterialPageRoute(
        builder: (_) => DetailPage(
          data: args,
        ),
      );
    case detailPage1:
      return MaterialPageRoute(
        builder: (_) => DetailPage1(
          data: args,
        ),
      );

    case evdetailPage:
      return MaterialPageRoute(
        builder: (_) => EvDetailPage(
          data: args,
        ),
      );

    //evdetailPage
    case lostItemPage:
      return MaterialPageRoute(builder: (context) => LostPage());

    default:
      return MaterialPageRoute(builder: (context) => LandingPage());
  }
}
