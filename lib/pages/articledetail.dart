import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import '../cubit/articledetail/articledetailcubit.dart';
import '../cubit/articledetail/articledetailstate.dart';


class ArticleDetailedNews extends StatefulWidget {
  String id = "";

  ArticleDetailedNews({Key? key , required this.id,}) : super(key: key);

  @override
  State<ArticleDetailedNews> createState() => _ArticleDetailedNewsState();
}



class _ArticleDetailedNewsState extends State<ArticleDetailedNews> {
  final searchController = TextEditingController();
  late double _rating;
  PageController pageController = PageController();
  int currentIndex = 0;



  final List detailedNewsData = [
    {
      "title": "World vegan day",
      "date": "Jan 3, 2023",
      "other": "Holiday- Featured news",
      "image": "assets/images/detailednews.png",
      "description":
          "Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet. Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.",
    },
  ];

  @override
  void initState() {
    // TODO: implement initState

      BlocProvider.of<ArticleDetailCubit>(context).getArticleDetail();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfffbf8f9),
        appBar: AppBar(
          backgroundColor: const Color(0xffFFFFFF),
          automaticallyImplyLeading: false,
          elevation: 0.8,
          title: const Column(
            children: [
              SizedBox(
                height: 4,
              ),

            ],
          ),
        ),
        body: BlocConsumer<ArticleDetailCubit, ArticleDetailState>(
            listener: (context, state) {
          if (state is ArticleDetailSuccess) {
            Loader.hide();
            //showSnackBar(context, state.response.message.toString());
          }

          if (state is ArticleDetailError) {
            Loader.hide();
           // showSnackBar(context, state.message);
          }

          if (state is ArticleDetailLoading) {
           // loader(context);
          }
        }, builder: (context, state) {
          if (state is ArticleDetailSuccess) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Image.asset(
                            'assets/images/backarrow.png',
                            width: 20,
                            height: 19,
                          )
                      ),
                      // Image.asset(
                      //   'assets/images/save.png',
                      //   width: 19,
                      //   height: 19,
                      // ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                 Expanded(
                   child: SingleChildScrollView(
                    child: Column(
                      children: [

                        MediaQuery.removePadding(
                            context: context,
                            removeTop: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // SizedBox(
                                //   height: 260,
                                //   //    width: MediaQuery.of(context).size.width,
                                //   width: double.infinity,
                                //   child: state.newsDetailResponse.result!
                                //       .media!.isNotEmpty
                                //       ? PageView.builder(
                                //       controller: pageController,
                                //       itemCount: 1,
                                //       onPageChanged: (int index) {
                                //         setState(() {
                                //           currentIndex = index;
                                //         });
                                //       },
                                //       itemBuilder: (_, i) {
                                //         return Column(
                                //           children: [
                                //             Expanded(
                                //               child: CachedNetworkImage(
                                //                 fit: BoxFit.scaleDown,
                                //                 width: double.infinity,
                                //                 imageUrl: state.newsDetailResponse.result!
                                //                     .media??'',
                                //                 progressIndicatorBuilder: (context,
                                //                     url,
                                //                     downloadProgress) =>
                                //                     Padding(
                                //                       padding:
                                //                       const EdgeInsets.symmetric(
                                //                           horizontal: 10,
                                //                           vertical: 10),
                                //                       child:
                                //                       CupertinoActivityIndicator(
                                //                         color: AppColor.primaryColor,
                                //                       ),
                                //                     ),
                                //                 errorWidget: (context, url,
                                //                     error) =>
                                //                 const Icon(Icons.error),
                                //               ),
                                //             ),
                                //
                                //           ],
                                //         );
                                //       })
                                //       : Image.asset(
                                //     detailedNewsData[0]['image'],
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width,
                                //
                                //   child: Row(
                                //     mainAxisAlignment:
                                //     MainAxisAlignment
                                //         .center,
                                //     children: List.generate(
                                //       1,
                                //           (index) => buildDot(
                                //           index, context),
                                //     ),
                                //   ),
                                //
                                // ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 16, right: 16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 4,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),

                                      // Text(
                                      //
                                      //   removeAllHtmlTags(state.articleDetailResponse.result!.description??''),
                                      //   style: GoogleFonts.montserrat(
                                      //     color: const Color(0xff000000),
                                      //     fontStyle: FontStyle.normal,
                                      //     fontSize: 12,
                                      //     fontWeight: FontWeight.w400,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),















                              ],
                            )),
                      ],
                    ),

                ),
                 ),

                // MediaQuery.removePadding(
                //   context: context,
                //   removeTop: true,
                //   child: Flexible(
                //     child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: 1,
                //       scrollDirection: Axis.vertical,
                //       physics: const NeverScrollableScrollPhysics(),
                //       itemBuilder: (context, index) {
                //         return Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //
                //             children: [
                //
                //               Flexible(
                //                 child: PageView.builder(
                //                       controller: pageController,
                //                       physics: BouncingScrollPhysics(),
                //                       itemCount: state.guidesDetailResponse.result!.post!.length,
                //                       scrollDirection: Axis.horizontal,
                //                       onPageChanged: (int index) {
                //                         setState(() {
                //                          // currentIndex = index;
                //                         });
                //                       },
                //                       itemBuilder: (_, i) {
                //                         return Column(
                //                           children: [
                //                             SizedBox(
                //                               height: 300,
                //                               width:MediaQuery.of(context).size.width,
                //                               child: CachedNetworkImage(
                //                                 imageUrl: state.guidesDetailResponse.result!.post![i],
                //                                 progressIndicatorBuilder: (context,
                //                                     url,
                //                                     downloadProgress) =>
                //                                     CircularProgressIndicator(
                //                                         color: AppColor.primaryColor,
                //                                         value:
                //                                         downloadProgress
                //                                             .progress),
                //                                 errorWidget: (context, url,
                //                                     error) =>
                //                                 const Icon(Icons.error),
                //                               ),
                //                             ),
                //
                //                           ],
                //                         );
                //                       }),
                //               ),
                //
                //               Padding(
                //                 padding:
                //                     const EdgeInsets.only(left: 16, right: 16),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     const SizedBox(
                //                       height: 12,
                //                     ),
                //                     Text(
                //                       removeAllHtmlTags(state.guidesDetailResponse.result!.title??''),
                //                       style: GoogleFonts.montserrat(
                //                         color: const Color(0xff000000),
                //                         fontStyle: FontStyle.normal,
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.w600,
                //                       ),
                //                       maxLines: 3,
                //                       overflow: TextOverflow.ellipsis,
                //                     ),
                //                     const SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       state.guidesDetailResponse.result!.wpRegisteredDate??'',
                //                       style: GoogleFonts.montserrat(
                //                         color: const Color(0xff000000),
                //                         fontStyle: FontStyle.normal,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 4,
                //                     ),
                //                     Text(
                //                       detailedNewsData[0]['other'],
                //                       style: GoogleFonts.montserrat(
                //                         color: const Color(0xff000000),
                //                         fontStyle: FontStyle.normal,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                     const SizedBox(
                //                       height: 12,
                //                     ),
                //                     Text(
                //                       removeAllHtmlTags(state.guidesDetailResponse.result!.description??''),
                //                       style: GoogleFonts.montserrat(
                //                         color: const Color(0xff000000),
                //                         fontStyle: FontStyle.normal,
                //                         fontSize: 12,
                //                         fontWeight: FontWeight.w400,
                //                       ),
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ],
                //           );
                //
                //       },
                //     ),
                //   ),
                // ),
              ],
            );
          }else if(state is ArticleDetailLoading){
            return const Center(
                child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.black)));
          }
          return Container();
        }));
  }



}
