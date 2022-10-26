import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:like_button/like_button.dart';
import 'package:p2_flutter/utils/colors.dart';
import 'package:p2_flutter/utils/dimensions.dart';
import 'package:p2_flutter/widgets/app_column.dart';
import 'package:p2_flutter/widgets/big_text.dart';
import 'package:p2_flutter/widgets/icon_and_text_widget.dart';
import 'package:p2_flutter/widgets/small_text.dart';
import '../constants.dart';
import '../../routes/route_helper.dart';
import '../constants.dart';
import 'informations.dart';
import 'article.dart';
import 'meet.dart';
import 'meets_detail.dart';

class Part1PageBody extends StatefulWidget {
  const Part1PageBody({Key? key}) : super(key: key);
  @override
  _Part1PageBodyState createState() => _Part1PageBodyState();
}

class _Part1PageBodyState extends State<Part1PageBody> {
  PageController pageController = PageController(viewportFraction: 0.90);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  Future<void> dispose() async {
    pageController.dispose();
  }

  FirebaseFirestore Firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // StreamBuilder<QuerySnapshot>(
        //     stream: Firestore.collection('meets').snapshots(),
        //     builder: (context, snapshot) {
        //       if (snapshot.hasError) {
        //         return Center(
        //           child: Text(snapshot.error.toString()),
        //         );
        //       }

        //       if (!snapshot.hasData ||
        //           snapshot.connectionState == ConnectionState.waiting) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else {
        //         final data = snapshot.requireData;
               // return
                 Container(
                        height: Dimensions.pageView,
                        child: PageView.builder(
                            controller: pageController,
                            itemCount: INFORMATIONS_DATA_List.length,
                            itemBuilder: (context, position) {
                              return GestureDetector(
                                  onTap: () {
                                    // Meet meet = Meet(
                                    //     titre: data.docs[position].get('titre'),
                                    //     date: data.docs[position].get('date'),
                                    //     heure: data.docs[position].get('heure'),
                                    //     lien: data.docs[position].get('lien'),
                                    //     detail:
                                    //         data.docs[position].get('detail'));

                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             MeetsDetail(meet)));
                                  },
                                  child: Container(
                                        height: Dimensions.pageView,
                                      child: _buildPageItem(
                                          position)));
                            })),
                    // ),
                    // )
                    
              //}
          //  }),
        SizedBox(
          height: Dimensions.height2,
        ),

        //dots
        new DotsIndicator(
          dotsCount: 5,
          position: _currPageValue,
          decorator: DotsDecorator(
            activeColor: AppColors.mainColor,
            size: const Size.square(9.0),
            activeSize: const Size(18.0, 9.0),
            activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
          ),
        ),

        //popular text
        SizedBox(
          height: Dimensions.height2,
        ),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "page home"),
              SizedBox(
                width: Dimensions.width5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.width5,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(
                  text: "Les catégories",
                  color: Colors.black26,
                ),
              ),
            ],
          ),
        ),
        //list of images and informations about diabete
        StreamBuilder<QuerySnapshot>(
            stream: // articlesRef.snapshots(),
                Firestore.collection('articles').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }

              if (!snapshot.hasData ||
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                final data = snapshot.requireData;
                return ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        // snapshot.data!.docs.length,
                        /******************************************halima has star */
                        data.docs.length,
                    /******************************************halima has star */
                    itemBuilder: (context, index) {
                      Information information = INFORMATIONS_DATA_List[index];
                      return GestureDetector(
                        onTap: () {
                          /******************************************halima had star */
                          Article article = Article(
                              titre: data.docs[index].get('titre'),
                              date: "20-03-2022",
                              text: data.docs[index].get('text'),
                              image: data.docs[index].get('image'));
                          /******************************************halima has star */

                          print(article.date);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Informations(article)));
                          //Get.toNamed(RouteHelper.getInformations());
                          //Get.to(()=>Informations());
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: Dimensions.width20,
                              right: Dimensions.width20,
                              bottom: Dimensions.height10),
                          child: Row(
                            children: [
                              //image section
                              Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radius20),
                                  color: Colors.white38,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          data.docs[index].get('image'))
                                      //  NetworkImage(data.docs[index].reference as String)
                                      ),
                                ),
                              ),
                              //text Container
                              Expanded(
                                child: Container(
                                  height: Dimensions.listTextContSize,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: Dimensions.width10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text: //information.name
                                                data.docs[index].get('titre')),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                            text: "voir plus d'informations"),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            IconAndTextWidget(
                                                icon: Icons.date_range,
                                                text:
                                                    //data.docs[index].get('date'),
                                                    "20-03-2022",
                                                iconColor:
                                                    AppColors.iconColor1),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              }
            })
      ],
    );
    //   }
    // });
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              //Get.toNamed(RouteHelper.getMeetsDetail());
              Meet meet = Meet(
                  titre: INFORMATIONS_DATA_List[index].name,
                  date:INFORMATIONS_DATA_List[index].date,
                  heure:"08:00",
                  lien: "sujet",
                  detail: INFORMATIONS_DATA_List[index].descreption);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MeetsDetail(meet)));
            },
            child: Container(
                height: Dimensions.pageViewContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width10, right: Dimensions.width10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius30),
                    color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                    image: const DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/img1.png")))),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.height15, left: 15, bottom: 15),
                child: AppColumn(
                    text: INFORMATIONS_DATA_List[index].name as String,
                    date: INFORMATIONS_DATA_List[index].date as String,
                    heure: "08:00",
                    lien: "sujet"
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
