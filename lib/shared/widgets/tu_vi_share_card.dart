import 'package:flutter/material.dart';

class TuViShareCard extends StatelessWidget {
  final String hoTen;
  final String namSinh;
  final String gioiTinh;
  final String ngaySinhAmLich;
  final String gioSinh;
  final int tuoiMu;
  final String menhChinhTinh;
  final String menhCung;
  final String tomTat;
  final double diemSo;

  const TuViShareCard({
    super.key,
    required this.hoTen,
    required this.namSinh,
    required this.gioiTinh,
    required this.ngaySinhAmLich,
    required this.gioSinh,
    required this.tuoiMu,
    required this.menhChinhTinh,
    required this.menhCung,
    required this.tomTat,
    required this.diemSo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1080,
      padding: const EdgeInsets.all(48),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F0C29),
            Color(0xFF1A1045),
            Color(0xFF24243E),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0xFF38BDF8), Color(0xFF6366F1)],
                  ),
                ),
                child: const Center(
                  child: Text(
                    'TC',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'THIÊN CƠ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 6,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'TỬ VI',
                  style: TextStyle(
                    color: Color(0xFF38BDF8),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 28),
          _infoRow('Họ tên', hoTen),
          const SizedBox(height: 12),
          _infoRow('Năm sinh', '$namSinh • $gioiTinh'),
          const SizedBox(height: 12),
          _infoRow('Âm lịch', ngaySinhAmLich),
          const SizedBox(height: 12),
          _infoRow('Giờ sinh', gioSinh),
          const SizedBox(height: 12),
          _infoRow('Tuổi mụ', '$tuoiMu'),
          const SizedBox(height: 24),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF38BDF8).withValues(alpha: 0.1),
                  const Color(0xFF6366F1).withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF38BDF8).withValues(alpha: 0.15),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'MỆNH',
                      style: TextStyle(
                        color: Color(0xFF38BDF8),
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$menhChinhTinh tại $menhCung',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (tomTat.isNotEmpty) ...[
                  const SizedBox(height: 14),
                  Text(
                    tomTat,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                      fontSize: 15,
                      height: 1.5,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const Spacer(),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.12)),
          const SizedBox(height: 20),
          Row(
            children: [
              const Text(
                'Kết quả được tạo bởi',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 6),
              const Text(
                'THIÊN CƠ',
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Text(
                '✦',
                style: TextStyle(
                  color: const Color(0xFF38BDF8).withValues(alpha: 0.4),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.45),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
