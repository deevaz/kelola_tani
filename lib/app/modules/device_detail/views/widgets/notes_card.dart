import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kelola_tani/app/core/theme/app_fonts.dart';
import 'package:kelola_tani/app/core/theme/app_style.dart';
import 'package:kelola_tani/app/services/dialog_service.dart';
import 'package:kelola_tani/app/shared/widgets/app_material_round.dart';

class NotesCard extends StatelessWidget {
  final String time;
  final String content;
  const NotesCard({super.key, required this.time, required this.content});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => DialogService.showDetail(
        title: 'Detail Catatan',
        details: {'Waktu': time, 'Isi': content},
      ),
      child: AppMaterialRound(
        paddingValue: 0,
        radius: 15.r,
        color: AppStyle.white,
        elevation: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Slidable(
            key: ValueKey(0),
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.45,
              children: [
                _buildCustomSlidableAction(
                  icon: Ionicons.pencil_outline,
                  color: AppStyle.secondary,
                  label: 'Edit',
                  onTap: () {
                    DialogService.noteForm(
                      title: 'Edit Catatan',
                      initialTime: DateTime.now(),
                      initialContent:
                          'Ini adalah catatan untuk perangkat Prgkt 1.',
                      onConfirm: (time, content) {},
                    );
                  },
                ),
                _buildCustomSlidableAction(
                  icon: Ionicons.trash_outline,
                  color: AppStyle.danger,
                  label: 'Hapus',
                  onTap: () {
                    DialogService.confirmation(
                      title: 'Hapus Catatan',
                      message: 'Apakah Anda yakin ingin menghapus catatan ini?',
                      onConfirm: () {},
                    );
                  },
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1 Maret 2026 - 14:45', style: AppFonts.lgSemiBold),
                    SizedBox(height: 8.h),
                    Text(
                      'Ini adalah catatan untuk perangkat Prgkt 1.',
                      style: AppFonts.mdRegular,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildCustomSlidableAction({
  required IconData icon,
  required Color color,
  required String label,
  required VoidCallback onTap,
}) {
  return CustomSlidableAction(
    backgroundColor: color,
    onPressed: (context) => onTap(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: AppStyle.white, size: 20.sp),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: AppStyle.white,
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}
