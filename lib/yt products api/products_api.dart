import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:repractice/yt%20products%20api/products_model.dart';

class ProductsApi extends StatelessWidget {
  const ProductsApi({super.key});

  Future<ProductsModel> getProducts() async {
    // final url = 'https://webhook.site/38841b62-06e7-412a-a602-67e1bb00ad88';
    final response = await http.get(
        Uri.parse('https://webhook.site/c96a41a4-7090-4c68-b7c2-951b71cc8b25'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Products Api',
          style: TextStyle(color: Colors.white, letterSpacing: 5.0),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductsModel>(
                future: getProducts(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index) {
                          final shopDetails = snapshot.data!.data![index].shop;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(shopDetails!.name.toString()),
                                subtitle:
                                    Text(shopDetails.shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      shopDetails.image.toString()),
                                ),
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height * .3,
                                width: MediaQuery.of(context).size.width * 1,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot
                                        .data!.data![index].images!.length,
                                    itemBuilder: (context, position) {
                                      final images =
                                          snapshot.data!.data![index].images;

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            right: 10, bottom: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .25,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  images![position]
                                                      .url
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                      );
                                    }),
                              )
                            ],
                          );
                        });
                  } else if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Text('something went wrong');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
