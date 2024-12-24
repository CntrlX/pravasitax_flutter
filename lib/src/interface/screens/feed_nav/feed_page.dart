import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pravasitax_flutter/src/data/models/article_model.dart';
import 'package:pravasitax_flutter/src/data/providers/articles_provider.dart';
import 'package:pravasitax_flutter/src/interface/screens/i_hub_nav/article_detail_page.dart';
import 'dart:developer';

class FeedPage extends ConsumerStatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends ConsumerState<FeedPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      ref.read(articlesListProvider.notifier).loadMoreArticles();
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(articlesListProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final hasMore = ref.watch(hasMoreArticlesProvider);
    final isLoading = articles.isEmpty || categoriesAsync is AsyncLoading;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(articlesListProvider.notifier).refresh();
        },
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    categoriesAsync.when(
                      data: (categories) => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildTagButton(
                              'All',
                              isActive: selectedCategory == null,
                              onTap: () {
                                ref
                                    .read(selectedCategoryProvider.notifier)
                                    .state = null;
                                ref
                                    .read(articlesListProvider.notifier)
                                    .refresh();
                              },
                            ),
                            ...categories.map((category) => Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: _buildTagButton(
                                    category.category,
                                    isActive:
                                        selectedCategory == category.category,
                                    onTap: () {
                                      ref
                                          .read(
                                              selectedCategoryProvider.notifier)
                                          .state = category.category;
                                      ref
                                          .read(articlesListProvider.notifier)
                                          .refresh();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      loading: () => const SizedBox.shrink(),
                      error: (error, stack) =>
                          const Text('Error loading categories'),
                    ),
                    const SizedBox(height: 16),
                    ...articles.map((article) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: _buildArticleCard(context, article),
                        )),
                    if (hasMore)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        alignment: Alignment.center,
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildTagButton(String text,
      {bool isActive = false, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        decoration: BoxDecoration(
          color: isActive ? Color(0x66A9F3C7) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive ? Colors.transparent : Colors.grey,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Color(0xFF0F7036) : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (article.thumbnail != null)
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(article.thumbnail!),
                fit: BoxFit.cover,
              ),
            ),
          ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: Color(0xFF66A9F3C7),
          child: Text(
            article.category.toUpperCase(),
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFF0F7036),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          article.title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        if (article.shortDescription != null) ...[
          SizedBox(height: 4),
          Text(
            article.shortDescription!,
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
        SizedBox(height: 8),
        Row(
          children: [
            CircleAvatar(backgroundColor: Colors.grey, radius: 15),
            SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (article.author != null)
                  Text(article.author!, style: TextStyle(color: Colors.black)),
                if (article.postedDate != null)
                  Text(
                    '${article.postedDate!.day} ${_getMonthName(article.postedDate!.month)} ${article.postedDate!.year}',
                    style: TextStyle(color: Colors.black),
                  ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        if (article.id != null)
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFF9B406),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArticleDetailPage(articleId: article.id),
                ),
              );
            },
            child: Text('Read more', style: TextStyle(color: Colors.black)),
          ),
      ],
    );
  }
}
