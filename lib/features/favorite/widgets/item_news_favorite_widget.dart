import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/core/routers/router_name.dart';
import 'package:news_app/core/utils/constant/app_colors.dart';
import 'package:news_app/features/home/domain/entities/news_model.dart';
import 'package:shimmer/shimmer.dart';

class ItemNewsFavoriteWidget extends StatelessWidget {
  final NewsModel news;
  final VoidCallback onTap;
  const ItemNewsFavoriteWidget(
      {super.key, required this.news, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.lightModePurple : AppColor.lightModePurple,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.pushNamed(RouterName.detailNews, extra: news),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // **Thumbnail Gambar**
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: news.urlToImage ?? '',
                width: 90,
                height: 70,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 90,
                    height: 70,
                    color: Colors.grey[300],
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 90,
                  height: 70,
                  color: Colors.grey[300],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // **Judul & Sumber Berita**
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title ?? 'No Title',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode
                          ? AppColor.darkModeBlack
                          : AppColor.darkModeBlack,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    news.source?.name ?? "Unknown Source",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // **Tombol Hapus Favorit**
            IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
