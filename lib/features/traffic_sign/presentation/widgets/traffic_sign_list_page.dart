import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/list/traffic_sign_list_bloc.dart';
import '../bloc/list/traffic_sign_list_event.dart';
import '../bloc/list/traffic_sign_list_state.dart';

class TrafficSignListPage extends StatelessWidget {
  final String categoryCode;

  const TrafficSignListPage({super.key, required this.categoryCode});

  Color _getBgColor(String code) {
    switch (code) {
      case 'PROHIBITION': return Colors.red.shade50;
      case 'DANGER': return Colors.amber.shade50;
      case 'COMMAND':
      case 'INSTRUCTION': return Colors.blue.shade50;
      default: return Colors.grey.shade100;
    }
  }

  Color _getBorderColor(String code) {
    switch (code) {
      case 'PROHIBITION': return Colors.red.shade100;
      case 'DANGER': return Colors.amber.shade200;
      case 'COMMAND':
      case 'INSTRUCTION': return Colors.blue.shade100;
      default: return Colors.grey.shade300;
    }
  }

  Color _getTextColor(String code) {
    switch (code) {
      case 'PROHIBITION': return Colors.red.shade700;
      case 'DANGER': return Colors.orange.shade900;
      case 'COMMAND':
      case 'INSTRUCTION': return Colors.blue.shade700;
      default: return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TrafficSignListBloc>()..add(GetTrafficSignsEvent(categoryCode)),
      child: BlocBuilder<TrafficSignListBloc, TrafficSignListState>(
        builder: (context, state) {

          if (state is TrafficSignListLoading || state is TrafficSignListInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (state is TrafficSignListFailure) {
            return Center(
              child: Text("Lỗi tải biển báo: ${state.message}", style: const TextStyle(color: Colors.red)),
            );
          }
          else if (state is TrafficSignListLoaded) {
            final signs = state.signs;
            if (signs.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.traffic_outlined, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    Text(
                      "Chưa có biển báo nào trong mục này",
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: signs.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final sign = signs[index];

                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.08),
                        blurRadius: 15,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.grey.shade200, width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                )
                              ]
                          ),
                          child: Image.network(
                            sign.imageUrl,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image, color: Colors.grey.shade300, size: 40);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getBgColor(categoryCode),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: _getBorderColor(categoryCode)),
                                ),
                                child: Text(
                                  sign.code,
                                  style: TextStyle(
                                    color: _getTextColor(categoryCode),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                sign.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Colors.black87,
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(height: 6),

                              // Mô tả
                              Text(
                                sign.description,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}