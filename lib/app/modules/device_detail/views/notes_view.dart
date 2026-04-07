import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/modules/device_detail/controllers/notes_controller.dart';
import 'package:kelola_tani/app/modules/device_detail/views/widgets/notes_card.dart';
import 'package:kelola_tani/app/services/app_refresher.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_header.dart';

class NotesView extends GetView {
  const NotesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppHeader(
            leading: Text(
              'Catatan',
              style: AppFonts.xlSemiBold.copyWith(color: AppStyle.white),
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppStyle.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppStyle.white.withOpacity(0.3),
                  width: 1,
                ),
              ),

              child: Center(
                child: Text(
                  'Perangkat: Prgkt 1',
                  style: AppFonts.smBold.copyWith(color: AppStyle.white),
                ),
              ),
            ),
          ),
          Expanded(child: _buildDashboardGrid()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DialogService.noteForm(
            title: 'Tambah Catatan',
            initialTime: DateTime.now(),
            initialContent: '',
            onConfirm: (time, content) {
              Get.find<NotesController>().addNote(time, content);
            },
          );
        },
        backgroundColor: AppStyle.primary,
        child: Icon(Icons.add, color: AppStyle.white),
      ),
    );
  }
}

Widget _buildDashboardGrid() {
  final controller = Get.find<NotesController>();
  return Obx(() {
    return AppRefresher(
      isEmpty: controller.notesList.isEmpty,
      onRefresh: () async {
        await controller.fetchNotes();
      },
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        itemCount: controller.notesList.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final note = controller.notesList[index];

          return NotesCard(
            time: note['time'].toString(),
            content: note['content'] ?? '',
          );
        },
      ),
    );
  });
}
