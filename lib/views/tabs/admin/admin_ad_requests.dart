import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:iconnect/core/services/database.dart';
import 'package:iconnect/locator.dart';
import 'package:iconnect/models/ad_request.dart';
import 'package:iconnect/widgets/admin_ad_request_list_item.dart';
import 'package:iconnect/widgets/appbar.dart';
import 'package:iconnect/widgets/shared_appbar_buttons.dart';

class AdminAdRequests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildSharedAppBar(context, '',
          leading: buidSharedBackButton(context)),
      body: FutureBuilder(
        future: locator<Database>().getAllAdRequests(),
        builder: (ctx, AsyncSnapshot<List<AdRequest>> snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return SpinKitFadingCircle(
              color: Colors.white,
              size: 50,
            );
          else {
            var list = snap.data;
            if (list == null || list.isEmpty)
              return Center(child: Text('No Requests Found'));
            else
              return ListView.builder(
                itemBuilder: (ctx, index) {
                  return AdRequestListItem(
                    adRequest: list[index],
                  );
                },
                itemCount: list.length,
              );
          }
        },
      ),
    );
  }
}
