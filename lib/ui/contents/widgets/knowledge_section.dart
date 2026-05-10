import 'package:flutter/material.dart';

import '../knowledge_detail_screen.dart';

class KnowledgeHomeSection extends StatefulWidget {
  const KnowledgeHomeSection({super.key});

  @override
  State<KnowledgeHomeSection> createState() => _KnowledgeHomeSectionState();
}

class _KnowledgeHomeSectionState extends State<KnowledgeHomeSection> {
  // 模拟数据列表
  final List<Map<String, dynamic>> bookData = [
    {
      'title': 'The Great Gatsby',
      'image': 'https://covers.openlibrary.org/b/isbn/9780743273565-L.jpg',
      'isAsset': false,
      'url': 'https://item.jd.com/12591872.html',
    },
    {
      'title': '本地书籍示例',
      'image': 'assets/images/book_0.png',
      'isAsset': true,
      'url': 'https://item.jd.com/100014348492.html',
    },
    {
      'title': '1984 - George Orwell',
      'image': 'https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg',
      'isAsset': false,
      'url': 'https://item.jd.com/12615413.html',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Knowledge (Recommended)',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var book in bookData) ...[
                  KnowledgeItem(
                    title: book['title'],
                    imageUrl: book['image'],
                    isAsset: book['isAsset'],
                    url: book['url'],
                  ),
                  const SizedBox(width: 8),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class KnowledgeItem extends StatelessWidget {
  const KnowledgeItem({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.url,
    this.isAsset = true,
  });

  final String imageUrl;
  final String title;
  final String url;
  final bool isAsset;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => KnowledgeDetailScreen(
              imageUrl: imageUrl,
              title: title,
              url: url,
              isAsset: isAsset,
            ),
          ),
        );
      },
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outlineVariant),
          boxShadow: [
            BoxShadow(
              color: colorScheme.shadow.withValues(alpha: .1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: SizedBox(
                  width: 60.0,
                  child: AspectRatio(
                    aspectRatio: 1 / 1.618,
                    child: Hero(
                      tag: 'knowledge-$imageUrl',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: colorScheme.surfaceContainerHighest,
                                child: Icon(
                                  Icons.book,
                                  size: 30,
                                  color: colorScheme.primary,
                                ),
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
