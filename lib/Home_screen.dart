//import 'dart:ffi';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ui/News%20%20View%20Model/News_view_model.dart';
import 'package:intl/intl.dart';
import 'package:ui/View/Categories.dart';

enum FilterList { bbcNews, Arynews, independents, reuters, cnn, alJazeera }

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = 'bbc-news';
  @override
  Widget build(BuildContext context) {
    // List<String> names=['bbc-news','ary-news'];
    FilterList? selected;
    final dateformat = DateFormat('MMMM dd,yyyy');
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    const horizontalPadding = 20.0;
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () =>
              MaterialPageRoute(builder: (context) => Categories_view()),
          child: const Image(image: AssetImage('assets/images/Leading.png')),
        ),
        title: Center(
            child: Text(
          'News',
          style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
        )),
        actions: [
          PopupMenuButton<FilterList>(
            initialValue: selected,
            itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
              PopupMenuItem(
                child: Text('bbc news'),
                value: FilterList.bbcNews,
              ),
              const PopupMenuItem(
                child: Text('Ary news'),
                value: FilterList.Arynews,
              ),
              const PopupMenuItem(
                child: const Text('Al Jazeera'),
                value: FilterList.bbcNews,
              ),
            ],
            onSelected: (FilterList item) {
              // ignore: unrelated_type_equality_checks
              if (FilterList.bbcNews == item) {
                name = 'bbc-news';
              }
              // ignore: unrelated_type_equality_checks
              else if (FilterList.Arynews == item) {
                name = 'ary-news';
              } else if (FilterList.cnn == item) {
                name = 'cnn';
              }
              setState(() {
                // View_Model().Fetch_api_data(name.toString());
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              // color: Colors.red,
              height: height * .5,
              width: width * .5,
              child: FutureBuilder(
                future: View_Model().Fetch_api_data(name),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.articles?.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return Container(
                            height: double.infinity,
                            width: width * .4,
                            padding:
                                const EdgeInsets.only(left: horizontalPadding),
                            child: Stack(
                              children: [
                                Container(
                                  //color: Colors.blue,
                                  height: double.infinity,
                                  width: width * .42,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(snapshot
                                          .data!.articles![index].urlToImage
                                          .toString()),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 25,
                                  left: 15,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    alignment: Alignment.center,
                                    height: height * .2,
                                    width: height * .35,
                                    child: Column(
                                      children: [
                                        Text(
                                          snapshot.data!.articles![index].title
                                              .toString(),
                                          maxLines: 2,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              snapshot.data!.articles![index]
                                                  .source!.name
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                            Text(
                                              dateformat.format(dateTime),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  } else {
                    return SpinKitCircle(
                      size: 30,
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
