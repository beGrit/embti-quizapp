import 'package:flutter/material.dart';

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
    },
    {'title': '本地书籍示例', 'image': 'assets/images/book_0.png', 'isAsset': true},
    {
      'title': '1984 - George Orwell',
      'image': 'https://covers.openlibrary.org/b/isbn/9780451524935-L.jpg',
      'isAsset': false,
    },
    // ... 更多书籍
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. 栏目标题 (可选)
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Knowledge (Recommended)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // 2. 横向滚动区域
        // 横向滚动：由内容撑开高度
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // 确保所有卡片顶部对齐
            children: [
              for (var book in bookData) ...[
                KnowledgeItem(
                  title: book['title'],
                  imageUrl: book['image'],
                  isAsset: book['isAsset'],
                ),
                const SizedBox(width: 12), // 每个卡片之间的间距
              ],
            ],
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
    this.isAsset = true,
  });

  final String imageUrl;
  final String title;
  final bool isAsset;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;

    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 1. 顶部：图片区域（带间距和居中）
          Padding(
            padding: const EdgeInsets.only(top: 16.0), // 顶部留出一点距离
            child: Center(
              child: SizedBox(
                width: 80.0, // 限制封面宽度为 80
                child: AspectRatio(
                  aspectRatio: 1 / 1.618, // 维持黄金比例
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4), // 书籍本身的圆角可以小一点
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
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

          // 2. 底部：书名区域
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              textAlign: TextAlign.center, // 书名也建议居中对齐，视觉更统一
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
    );
  }
}
