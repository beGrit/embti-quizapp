import 'package:emombti/ui/contents/view_models/article_viewmodel.dart';
import 'package:emombti/ui/contents/widgets/article_section.dart';
import 'package:emombti/ui/home/widgets/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: HomeAppBar(
        onSearchChanged: (value) {
          print("Searching for: $value");
        },
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ArticleHomeSection(viewModel: ArticleViewModel(context.read())),
    );
  }
}
