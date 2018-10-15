import 'dart:async';

import 'package:flutter/material.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../../models/nasa/nasa_image.dart';
import '../../../widgets/photo_card.dart';

class NasaMoreImages extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<Null> _onRefresh(NasaImagesModel model) {
    Completer<Null> completer = Completer<Null>();
    model.refresh().then((_) => completer.complete());
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('More images'), centerTitle: true),
      body: ScopedModel<NasaImagesModel>(
        model: NasaImagesModel(),
        child: ScopedModelDescendant<NasaImagesModel>(
          builder: (context, child, model) => RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: () => _onRefresh(model),
                child: model.isLoading
                    ? NativeLoadingIndicator(center: true)
                    : Scrollbar(
                        child: ListView.builder(
                          key: PageStorageKey('nasa'),
                          itemCount: model.getSize,
                          itemBuilder: (context, index) =>
                              PhotoCardCompact(model.list[index]),
                        ),
                      ),
              ),
        ),
      ),
    );
  }
}
