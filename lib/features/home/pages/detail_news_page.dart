import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_app/core/provider/sqlite_provider.dart';
import 'package:news_app/core/helpers/formatters/date_to_string.dart';
import 'package:news_app/core/utils/constant/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';

class DetailNewsPage extends ConsumerStatefulWidget {
  final NewsModel news;
  const DetailNewsPage({super.key, required this.news});

  @override
  ConsumerState<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends ConsumerState<DetailNewsPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  Future<void> _checkIfFavorite() async {
    final result = await DatabaseHelper.isFavorite(widget.news.title ?? '');
    setState(() {
      isFavorite = result;
    });
  }

  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      await DatabaseHelper.deleteNews(widget.news.title ?? '');
    } else {
      await DatabaseHelper.insertNews(widget.news);
    }
    setState(() {
      isFavorite = !isFavorite;
    });

    ref.invalidate(fetchFavoriteNewsProvider); // Refresh daftar favorit
  }

  Future<void> _launchURL() async {
    String? url = widget.news.url;
    if (url == null || url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("URL tidak tersedia.")),
      );
      return;
    }

    if (!url.startsWith('http')) {
      url = 'https://$url';
    }

    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tidak dapat membuka link.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final buttonColor =
        isDarkMode ? AppColor.lightModePurple : AppColor.darkModeBlack;
    final textColor =
        isDarkMode ? AppColor.darkModeBlack : AppColor.lightModePurple;

    return Scaffold(
      body: Stack(
        children: [
          // Hero Image
          Hero(
            tag: widget.news.urlToImage ?? '',
            child: Container(
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.news.urlToImage ?? ''),
                  fit: BoxFit.cover,
                  onError: (_, __) =>
                      const AssetImage('assets/placeholder.jpg'),
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Back & Favorite Button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Back Button
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                      ),
                      child: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),

                  // Favorite Button
                  InkWell(
                    onTap: _toggleFavorite,
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black45,
                      ),
                      child: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content dengan tombol Read More tetap di bawah
          Column(
            children: [
              Expanded(
                child: DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  maxChildSize: 0.9,
                  builder: (context, scrollController) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: isDarkMode ? Colors.black : Colors.white,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(25)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title
                            Text(
                              widget.news.title ?? "No Title",
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Gap(8),

                            // Source & Date
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "📍 ${widget.news.source?.name ?? "Unknown Source"}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.blueGrey),
                                ),
                                Text(
                                  "📅 ${formatNewsPublishedDate(widget.news.publishedAt ?? DateTime.now())}",
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.grey),
                                ),
                              ],
                            ),

                            const Gap(16),

                            // Author
                            if (widget.news.author != null)
                              Text(
                                "✍️ Author: ${widget.news.author}",
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),

                            const Gap(16),

                            // Description
                            if (widget.news.description != null)
                              Text(
                                widget.news.description!,
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.grey),
                              ),

                            const Gap(16),

                            // Content
                            Text(
                              widget.news.content ?? "No content available.",
                              style: const TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Button Read More Selalu di Bawah
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.black : Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: _launchURL,
                  icon: Icon(Icons.open_in_browser, color: textColor),
                  label: const Text("Read More"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: textColor,
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
