import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../cubit/articles/articlescubit.dart';
import '../../cubit/articles/articlesstate.dart';


class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {

  // final List articlesData = [
  //   {
  //     "title": "World vegan day",
  //     "image": "assets/images/articles1.png",
  //     "date": "Jan 5,2023",
  //     "details": "Holiday - Featured News",
  //   },
  //   {
  //     "title":
  //         "Wild Earth Produces ‘First- ever’ cell-Based chicken broth for pets",
  //     "image": "assets/images/articles2.png",
  //     "date": "Jan 31,2023",
  //     "details": "Environment - Featured News",
  //   },
  //   {
  //     "title": "1 million europeans vote to ban shark fin trade",
  //     "image": "assets/images/articles3.png",
  //     "date": "Mar 16,2023",
  //     "details": "Environment - Featured News",
  //   },
  //   {
  //     "title": "los angeless city council approves global plant-base treaty",
  //     "image": "assets/images/articles4.png",
  //     "date": "Feb 2,2023",
  //     "details": "Holiday - Featured News",
  //   },
  //   {
  //     "title": "World vegan day",
  //     "image": "assets/images/articles5.png",
  //     "date": "Jan 2,2023",
  //     "details": "Environment - Featured News",
  //   },
  // ];

  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ArticlesCubit>(context).articles();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<ArticlesCubit, ArticlesState>(
            listener: (context, state) async {
              print(state);
      if (state is ArticlesSuccess) {
        Loader.hide();

      }

      if (state is ArticlesError) {
        Loader.hide();
      }
      if (state is ArticlesLoading) {
       // loader(context);
      }
    }, builder: (context, state) {
      if (state is ArticlesSuccess) {
       return Column(
         children: [
           SizedBox(
             height: 30,
           ),
           Padding(
             padding: const EdgeInsets.all(5.0),
             child: SizedBox(
               width: MediaQuery.of(context).size.width,
               child: Align(
                 alignment: Alignment.center,
                 child: const Text(
                   "Art List",
                   maxLines: 3,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                       decoration: TextDecoration.none,
                       color: Colors.black,
                       fontSize: 25,
                       fontWeight: FontWeight.bold),
                 ),
               ),
             ),
           ),
           
           Expanded(
             child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.articleResponse.length,
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CachedNetworkImage(
                            imageUrl: "http://41.76.108.115/file/image/${state.articleResponse[index].pk}",
                            height: 140,
                            width: MediaQuery.of(context).size.width,
                            imageBuilder: (context, imageProvider) =>
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            progressIndicatorBuilder: (context, url,
                                downloadProgress) =>
                            const Padding(
                              padding:
                              EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 10),
                              child:
                              CupertinoActivityIndicator(
                                color: Colors.black,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        state.articleResponse[index].fields.title,
                                        style: TextStyle(
                                          color: const Color(0xff000000),
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      state.articleResponse[index].fields.description,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // Text(
                                    //   articlesData[0]['details'],
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
                              GestureDetector(
                                onTap: (){
                                  openWhatsApp();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 30,
                                    width: 50,
                                    decoration:  const BoxDecoration(
                                      color: Color(0xff000000),
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                    ),
                                    child: Container(
                                      //   constraints: const BoxConstraints(minWidth: 88.0, minHeight: 36.0), // min sizes for Material buttons
                                      alignment: Alignment.center,
                                      child:  Text(
                                        'Buy',
                                        style: TextStyle(color: const Color(0xffFFFFFF),fontSize: 16,
                                            fontWeight: FontWeight.w600,fontStyle: FontStyle.normal),),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                      ],
                    );
                  }),
           ),
         ],
       );
      }
      else if(state is ArticlesLoading) {
        return const Center(
            child: CircularProgressIndicator(
                valueColor:
                AlwaysStoppedAnimation<Color>(Colors.black)));
      }
      return Container();
    }));
  }
}

void openWhatsApp() async {
  var phoneNumber = "+27 824033900";
  final url = 'https://wa.me/$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


