import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ui/News%20%20View%20Model/Categories_view_model.dart';

class Categories_view extends StatefulWidget {
  @override
  State<Categories_view> createState() => _Categories_viewState();
}

class _Categories_viewState extends State<Categories_view> {
  final dateformat = DateFormat('MMMM dd,yyyy');

  List<String> categories_list = [
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'Business',
    'Technology'
  ];

  late String category = 'General';

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).height * 1;
    // final height = MediaQuery.of(context).size.height * 1;
    // final width = MediaQuery.of(context).size.width * 1;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categores',
          style: GoogleFonts.poppins(
              textStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      category = categories_list[index];
                      //(category);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: category == categories_list[index]
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(14)),
                      height: 50,
                      width: 100,
                      child: Center(
                        child: Text(categories_list[index].toString()),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            // height: height * .5,
            // width: width * .5,
            child: FutureBuilder(
              future: Categories_View_Model().fetch_api_data(category),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SpinKitCircle(
                    size: 40,
                    color: Colors.blue,
                  );
                } else {
                  return ListView.builder(itemBuilder: (context, index) {
                    DateTime dateTime = DateTime.parse(
                        snapshot.data!.articles![index].publishedAt.toString());
                    return Row(
                      children: [
                        ClipRRect(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CachedNetworkImage(
                                height: height * .18,
                                width: width * .2,
                                imageUrl: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString()),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: height * .10,
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.articles![index].title
                                      .toString(),
                                  maxLines: 3,
                                  style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold)),
                                ),
                                const Spacer(),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          '${snapshot.data?.articles![index].source!.name.toString()}'),
                                      Text(dateformat.format(dateTime)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
