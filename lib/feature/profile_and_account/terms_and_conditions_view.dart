import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velozaje/core/localization/app_localizations.dart';
import 'package:velozaje/core/providers.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:velozaje/res/common_text.dart';

class TermsAndConditionsPage extends ConsumerStatefulWidget {
  const TermsAndConditionsPage({super.key});

  @override
  ConsumerState<TermsAndConditionsPage> createState() =>
      _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState
    extends ConsumerState<TermsAndConditionsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(staticContentControllerProvider.notifier)
          .getTermsAndConditions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final staticContentState = ref.watch(staticContentControllerProvider);
    final staticContentController = ref.read(
      staticContentControllerProvider.notifier,
    );

    return Scaffold(
      appBar: commonAppBar(
        context,
        title: AppLocalizations.of(context)!.terms_conditions,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(staticContentControllerProvider.notifier)
              .getTermsAndConditions();
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ValueListenableBuilder(
            valueListenable: staticContentController.isLoading,
            builder: (_, isLoading, _) {
              if (isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (!isLoading && staticContentState.termsAndCondition.isEmpty) {
                return Center(
                  child: CommonText("No trems and condition found"),
                );
              }
              return SingleChildScrollView(
                child: Html(data: staticContentState.termsAndCondition),
              );
            },
          ),
        ),
      ),
    );
  }
}
