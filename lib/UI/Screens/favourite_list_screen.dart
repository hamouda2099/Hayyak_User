import 'package:flutter/material.dart';
import 'package:hayyak/Config/constants.dart';
import 'package:hayyak/Dialogs/loading_screen.dart';
import 'package:hayyak/Logic/Services/api_manger.dart';
import 'package:hayyak/Models/fav_list_model.dart';
import 'package:hayyak/UI/Components/bottom_nav_bar.dart';
import 'package:hayyak/UI/Components/fav_row_component.dart';
import 'package:hayyak/UI/Components/seccond_app_bar.dart';

class FavListScreen extends StatelessWidget {
  const FavListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(currentScreen: 'Favourites'),
      body: SafeArea(
        child: Column(
          children: [
            SecondAppBar(title: 'Favourites ',shareAndFav: false,),
            FutureBuilder<FavListModel>(
              future: ApiManger.getFavList(),
              builder:
                  (BuildContext context, AsyncSnapshot<FavListModel> snapShot) {
                switch (snapShot.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: ScreenLoading());
                    }
                  default:
                    if (snapShot.hasError) {
                      return Text('Error: ${snapShot.error}');
                    } else {
                      return  Expanded(
                          child: ListView.builder(
                            itemCount: snapShot.data!.data.length,
                            itemBuilder: (context, index) {
                              return FavRow(
                                item: snapShot.data!.data[index],
                              );
                            },
                          )) ;
                    }
                }
              },
            )


          ],
        ),
      ),
    );
  }
}
