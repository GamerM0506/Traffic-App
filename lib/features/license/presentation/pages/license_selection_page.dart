import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../../../config/routes/app_routes.dart';
import '../bloc/license_bloc.dart';
import '../bloc/license_event.dart';
import '../bloc/license_state.dart';
import '../widgets/license_card.dart';

class LicenseSelectionPage extends StatelessWidget {
  const LicenseSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final bool isRandomMode = args?['isRandomMode'] ?? false;

    return BlocProvider(
      create: (_) => sl<LicenseBloc>()..add(LicenseFetchData()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            isRandomMode ? "Chọn hạng thi ngẫu nhiên" : "Chọn hạng bằng lái",
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<LicenseBloc, LicenseState>(
          builder: (context, state) {
            if (state is LicenseLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is LicenseFailure) {
              return Center(child: Text("Lỗi: ${state.message}"));
            } else if (state is LicenseLoaded) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: state.licenses.length,
                  itemBuilder: (context, index) {
                    final license = state.licenses[index];
                    return LicenseCard(
                      license: license,
                      isRandomMode: isRandomMode,
                      onTap: () {
                        if (isRandomMode) {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.doExam,
                            arguments: {
                              'type': license.type,
                              'isRandom': true,
                              'id': 0,
                            },
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            AppRoutes.examList,
                            arguments: license.type,
                          );
                        }
                      },
                    );
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
