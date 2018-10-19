import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/rockets/spacex_company.dart';
import '../../../util/colors.dart';
import '../../../widgets/row_item.dart';

class SpacexCompanyTab extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) => Scaffold(
            key: _scaffoldKey,
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text('About ${model.company.name}'),
                    background: Image.network(
                      "https://www.teslarati.com/wp-content/uploads/2017/06/spacex-headquarters-hawthorne.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildBody(),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildBody() {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) => Scrollbar(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        model.company.fullName,
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Container(height: 12.0),
                      Text(
                        model.company.getFounderDate,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      ),
                      Container(height: 12.0),
                      RowItem.textRow('CEO', model.company.ceo),
                      Container(height: 12.0),
                      RowItem.textRow('CTO', model.company.cto),
                      Container(height: 12.0),
                      RowItem.textRow('COO', model.company.coo),
                      Container(height: 12.0),
                      RowItem.textRow('Valuation', model.company.getValuation),
                      Container(height: 12.0),
                      RowItem.textRow('Location', model.company.getLocation),
                      Container(height: 12.0),
                      RowItem.textRow('Employees', model.company.getEmployees),
                      Container(height: 12.0),
                      Text(
                        model.company.details,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(color: secondaryText),
                      ),
                    ],
                  ),
                ),
                Container(height: 12.0),
                const Divider(),
                ListView.builder(
                  itemCount: model.getSize,
                  itemBuilder: _buildAchievement,
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildAchievement(BuildContext context, int index) {
    return ScopedModelDescendant<SpacexCompanyModel>(
      builder: (context, child, model) {
        final Achievement achievement = model.getItem(index);
        return Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: accentColor,
                child: Text('#$index'),
              ),
              title: Text(achievement.name),
              subtitle: Text(achievement.details),
              onTap: () async => await FlutterWebBrowser.openWebPage(
                    url: achievement.url,
                    androidToolbarColor: primaryColor,
                  ),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
