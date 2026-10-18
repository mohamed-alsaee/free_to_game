import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:free_to_game/helpers/functions.dart';
import 'package:free_to_game/providers/games_provider.dart';
import 'package:free_to_game/widgets/shimmer_widget.dart';
import 'package:fullscreen_image_viewer/fullscreen_image_viewer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GameDetailsScreen extends StatefulWidget {
  const new({super.key, required this.gameId});
  final String gameId;
  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  bool showFullDescription = false;
  @override
  void initState() {
    Provider.of<GamesProvider>(
      context,
      listen: false,
    ).getGameDetails(widget.gameId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GamesProvider>(
      builder: (context, gamesConsumer, _) {
        return Scaffold(
          body: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: gamesConsumer.busy || gamesConsumer.detailedGameModel == null
                ? ShimmerWidget(
                    linesHeights: [getSize(context).height * 0.2, 24, 12, 12],
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              width: getSize(context).width,
                              fit: BoxFit.cover,
                              imageUrl:
                                  gamesConsumer.detailedGameModel!.thumbnail,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                    ),
                                  ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                            // Image.network(
                            //   width: getSize(context).width,
                            //   gamesConsumer.detailedGameModel!.thumbnail,
                            //   fit: BoxFit.cover,
                            // ),

                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: SafeArea(
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                          color: Colors.white.withValues(
                                            alpha: 0.5,
                                          ),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                gamesConsumer.detailedGameModel!.title,
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24),
                              Text(
                                gamesConsumer
                                    .detailedGameModel!
                                    .shortDescription,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(height: 24),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showFullDescription = !showFullDescription;
                                  });
                                },
                                child: Text(
                                  gamesConsumer.detailedGameModel!.description,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: showFullDescription ? null : 6,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    showFullDescription = !showFullDescription;
                                  });
                                },
                                child: Text(
                                  (showFullDescription
                                      ? "show less..."
                                      : "show more..."),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.blueGrey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                  maxLines: showFullDescription ? null : 6,
                                ),
                              ),
                              SizedBox(height: 24),

                              Text(
                                gamesConsumer.detailedGameModel!.developer,
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                // gamesConsumer.detailedGameModel!.releaseDate
                                //     .toIso8601String(),

                                DateFormat.yMMMMd().format(
                                  gamesConsumer.detailedGameModel!.releaseDate,
                                ),
                                // .substring(0, 10)
                                // .replaceAll("-", "/"),
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                gamesConsumer.detailedGameModel!.publisher,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 24),
                              if (gamesConsumer
                                      .detailedGameModel!
                                      .minimumSystemRequirements !=
                                  null)
                                Column(
                                  children: [
                                    Text("Minmum Requirements :"),
                                    SizedBox(height: 24),

                                    RequirmentRow(
                                      title: "CPU :",
                                      value: gamesConsumer
                                          .detailedGameModel!
                                          .minimumSystemRequirements!
                                          .processor,
                                    ),
                                    RequirmentRow(
                                      title: "OS :",
                                      value: gamesConsumer
                                          .detailedGameModel!
                                          .minimumSystemRequirements!
                                          .os,
                                    ),
                                    RequirmentRow(
                                      title: "GPU :",
                                      value: gamesConsumer
                                          .detailedGameModel!
                                          .minimumSystemRequirements!
                                          .graphics,
                                    ),
                                    RequirmentRow(
                                      title: "Memory :",
                                      value: gamesConsumer
                                          .detailedGameModel!
                                          .minimumSystemRequirements!
                                          .memory,
                                    ),
                                    RequirmentRow(
                                      title: "Storage :",
                                      value: gamesConsumer
                                          .detailedGameModel!
                                          .minimumSystemRequirements!
                                          .storage,
                                    ),

                                    SizedBox(height: 24),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        GridView.builder(
                          padding: EdgeInsets.all(12),
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gamesConsumer
                              .detailedGameModel!
                              .screenshots
                              .length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 12,
                                crossAxisSpacing: 12,
                              ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                FullscreenImageViewer.open(
                                  context: context,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: gamesConsumer
                                        .detailedGameModel!
                                        .screenshots[index]
                                        .image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Center(
                                              child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                              ),
                                            ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  //  Image.network(
                                  //   gamesConsumer
                                  //       .detailedGameModel!
                                  //       .screenshots[index]
                                  //       .image,
                                  // ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: gamesConsumer
                                      .detailedGameModel!
                                      .screenshots[index]
                                      .image,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                            child: CircularProgressIndicator(
                                              value: downloadProgress.progress,
                                            ),
                                          ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),

                                //                     Image.network(
                                //                     gamesConsumer
                                //                     .detailedGameModel!
                                //                     .screenshots[index]
                                //                     .image,
                                //                     fit: BoxFit.cover,
                                //                     ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}

class RequirmentRow extends StatelessWidget {
  const new({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Text(
                value,

                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(color: Colors.grey.withValues(alpha: 0.33)),
      ],
    );
  }
}
