import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:p2_flutter/utils/colors.dart';
import 'package:p2_flutter/utils/dimensions.dart';
import 'package:p2_flutter/widgets/app_icon.dart';
import 'package:p2_flutter/widgets/big_text.dart';
import 'package:p2_flutter/widgets/exandable_text_widget.dart';
import 'package:like_button/like_button.dart';
import '../../routes/route_helper.dart';
import '../constants.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_model.dart';
import 'favorite_list.dart';
import 'article.dart';

class Informations extends StatelessWidget {
 // final Information info;
  final Article article;
  bool isLiked=false;
  
   Informations(this.article);
  //int get favoriteBtn=>_favoriteBtn;
 // const Informations({Key? key,required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(create: (context)=>FavoriteModel()),
    ],
    child: Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //pour eleminer le button de routeur par defaut
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:()
                    {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear,size: 30.0,)),
                Row(
                  children: [
                    Text("  0  ",),
                    GestureDetector(
                      onTap:()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>FavoriteListArticles()));
                      },
                      child: Icon(
                        Icons.favorite,
                        size: 30.0,
                        //color:AppColors.mainColor,
                      ),

                    ),

                  ],
                ),

              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                //margin: EdgeInsets.only(left: Dimensions.width20,right:Dimensions.width20),
                child: Center(child: BigText(text: article.titre,size: Dimensions.font26,),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom:10),
                decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    )
                ),

              ),
            ),
            pinned:true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                article.image,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(

              child: Column(
                children: [
                  Container(
                    child:ExpandableTextWidget(text:article.text ) ,
                    margin: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20),
                  )
                ],
              )
          ),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,

        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              bottom: Dimensions.height10,
              top: Dimensions.height10,
            ),

          ),
          Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(top: Dimensions.height30,bottom: Dimensions.height30,left: Dimensions.width20,right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(

                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,

                  ),
                  child: GestureDetector(

                    // je suis tramper et ajouter Gestu(c'est un Container a l'origine)... et on Tap
                    onTap: (){
                      //FavoriteModel.;

                    },
                    child: LikeButton(
                      size: 40,
                      isLiked: isLiked,
                      padding: EdgeInsets.only(bottom:28),
                      likeBuilder: (isLiked){
                        final color = isLiked? Colors.red:AppColors.mainColor;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width20,right: Dimensions.width20),

                  child: BigText(text: "voir la vidéo",color: Colors.white,size: 15,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
