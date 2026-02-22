import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/traffic_sign_helper.dart';
import '../../../../injection_container.dart';
import '../bloc/category/traffic_sign_category_bloc.dart';
import '../bloc/category/traffic_sign_category_event.dart';
import '../bloc/category/traffic_sign_category_state.dart';
import '../widgets/traffic_sign_list_page.dart';

class TrafficSignPage extends StatelessWidget {
  const TrafficSignPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TrafficSignCategoryBloc>()..add(GetTrafficSignCategoriesEvent()),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50, // Màu nền xám nhạt cho toàn trang
        body: BlocBuilder<TrafficSignCategoryBloc, TrafficSignCategoryState>(
          builder: (context, state) {
            if (state is TrafficSignCategoryLoading || state is TrafficSignCategoryInitial) {
              return Scaffold(
                appBar: AppBar(title: const Text("Hệ thống biển báo"), centerTitle: true),
                body: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is TrafficSignCategoryFailure) {
              return Scaffold(
                appBar: AppBar(title: const Text("Hệ thống biển báo"), centerTitle: true),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Lỗi: ${state.message}", style: const TextStyle(color: Colors.red)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<TrafficSignCategoryBloc>().add(GetTrafficSignCategoriesEvent()),
                        child: const Text("Thử lại"),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is TrafficSignCategoryLoaded) {
              final categories = state.categories;

              if (categories.isEmpty) {
                return Scaffold(
                  appBar: AppBar(title: const Text("Hệ thống biển báo"), centerTitle: true),
                  body: const Center(child: Text("Dữ liệu đang được cập nhật...")),
                );
              }

              return DefaultTabController(
                length: categories.length,
                child: Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  appBar: AppBar(
                    title: const Text(
                        "Hệ thống biển báo",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                    ),
                    centerTitle: true,
                    elevation: 0, // Bỏ bóng mờ
                    backgroundColor: Colors.blue.shade700, // Màu nền xanh đậm sang trọng
                    foregroundColor: Colors.white,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                        child: TabBar(
                          isScrollable: true,
                          tabAlignment: TabAlignment.start,
                          dividerColor: Colors.transparent, // Bỏ cái gạch xám dưới đáy TabBar
                          indicatorSize: TabBarIndicatorSize.tab, // Bọc nền theo size của Tab
                          indicatorPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                          // --- ĐỘ TAB THÀNH VIÊN THUỐC ---
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))
                              ]
                          ),
                          labelColor: Colors.blue.shade800, // Chữ xanh khi được chọn
                          unselectedLabelColor: Colors.white.withOpacity(0.8), // Chữ trắng mờ khi chưa chọn
                          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
                          tabs: categories.map((category) {
                            return Tab(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                child: Text(TrafficSignHelper.translateCategory(category.code)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: categories.map((category) {
                      return TrafficSignListPage(categoryCode: category.code);
                    }).toList(),
                  ),
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