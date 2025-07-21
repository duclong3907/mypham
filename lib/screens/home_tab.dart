import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _chartAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _chartAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutBack,
    ));

    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _chartAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _chartAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentHour = DateTime.now().hour;
    String greeting = "Chào buổi sáng";
    IconData greetingIcon = Icons.wb_sunny_rounded;

    if (currentHour >= 12 && currentHour < 17) {
      greeting = "Chào buổi chiều";
      greetingIcon = Icons.wb_sunny_outlined;
    } else if (currentHour >= 17) {
      greeting = "Chào buổi tối";
      greetingIcon = Icons.nights_stay_rounded;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16), // Giảm padding từ 20 xuống 16
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header với greeting
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Container(
                      padding: const EdgeInsets.all(20), // Giảm padding từ 24 xuống 20
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.8),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14), // Giảm padding từ 16 xuống 14
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF8D6E63), Color(0xFFA1887F)],
                              ),
                              borderRadius: BorderRadius.circular(18), // Giảm từ 20 xuống 18
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF8D6E63).withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.dashboard_rounded,
                              color: Colors.white,
                              size: 28, // Giảm từ 32 xuống 28
                            ),
                          ),
                          const SizedBox(width: 16), // Giảm từ 20 xuống 16
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      greetingIcon,
                                      color: Color(0xFF8D6E63),
                                      size: 18, // Giảm từ 20 xuống 18
                                    ),
                                    const SizedBox(width: 6), // Giảm từ 8 xuống 6
                                    Text(
                                      greeting,
                                      style: TextStyle(
                                        fontSize: 14, // Giảm từ 16 xuống 14
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 2), // Giảm từ 4 xuống 2
                                const Text(
                                  "Tổng quan hệ thống",
                                  style: TextStyle(
                                    fontSize: 22, // Giảm từ 24 xuống 22
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Giảm padding
                            decoration: BoxDecoration(
                              color: Color(0xFF8D6E63).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10), // Giảm từ 12 xuống 10
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.trending_up_rounded,
                                  color: Color(0xFF8D6E63),
                                  size: 14, // Giảm từ 16 xuống 14
                                ),
                                const SizedBox(width: 3), // Giảm từ 4 xuống 3
                                Text(
                                  "Live",
                                  style: TextStyle(
                                    color: Color(0xFF8D6E63),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11, // Giảm từ 12 xuống 11
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20), // Giảm từ 24 xuống 20

                // Info Cards với animation - FIXED SIZE
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return SizedBox(
                      height: 120, // Giảm từ 140 xuống 120
                      child: Row(
                        children: [
                          _InfoCard(
                            title: "Đơn hàng",
                            value: "120",
                            icon: Icons.receipt_long_rounded,
                            gradientColors: [Color(0xFFFF8A65), Color(0xFFFFAB91)],
                            delay: 0.2,
                            animationController: _animationController,
                          ),
                          const SizedBox(width: 10), // Giảm từ 12 xuống 10
                          _InfoCard(
                            title: "Khách hàng",
                            value: "87",
                            icon: Icons.people_alt_rounded,
                            gradientColors: [Color(0xFF4DB6AC), Color(0xFF80CBC4)],
                            delay: 0.4,
                            animationController: _animationController,
                          ),
                          const SizedBox(width: 10), // Giảm từ 12 xuống 10
                          _InfoCard(
                            title: "Doanh thu",
                            value: "85M",
                            subtitle: "VNĐ",
                            icon: Icons.attach_money_rounded,
                            gradientColors: [Color(0xFF8D6E63), Color(0xFFA1887F)],
                            delay: 0.6,
                            animationController: _animationController,
                          ),
                        ],
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24), // Giảm từ 32 xuống 24

                // Chart Container với animation
                AnimatedBuilder(
                  animation: _chartAnimationController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        0,
                        50 * (1 - _chartAnimationController.value),
                      ),
                      child: Opacity(
                        opacity: _chartAnimationController.value,
                        child: Container(
                          padding: const EdgeInsets.all(20), // Giảm từ 24 xuống 20
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0.95),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 25,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10), // Giảm từ 12 xuống 10
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF8D6E63), Color(0xFFA1887F)],
                                      ),
                                      borderRadius: BorderRadius.circular(14), // Giảm từ 16 xuống 14
                                    ),
                                    child: const Icon(
                                      Icons.trending_up_rounded,
                                      color: Colors.white,
                                      size: 22, // Giảm từ 24 xuống 22
                                    ),
                                  ),
                                  const SizedBox(width: 14), // Giảm từ 16 xuống 14
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Doanh thu 7 ngày gần nhất",
                                          style: TextStyle(
                                            fontSize: 16, // Giảm từ 18 xuống 16
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "Cập nhật: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 12, // Giảm từ 14 xuống 12
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), // Giảm padding
                                    decoration: BoxDecoration(
                                      color: Colors.green.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10), // Giảm từ 12 xuống 10
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.arrow_upward_rounded,
                                          color: Colors.green,
                                          size: 14, // Giảm từ 16 xuống 14
                                        ),
                                        const SizedBox(width: 3), // Giảm từ 4 xuống 3
                                        Text(
                                          "+12%",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11, // Giảm từ 12 xuống 11
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20), // Giảm từ 24 xuống 20
                              SizedBox(
                                height: 260, // Giảm từ 280 xuống 260
                                child: LineChart(
                                  LineChartData(
                                    borderData: FlBorderData(show: false),
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      horizontalInterval: 2000000,
                                      getDrawingHorizontalLine: (value) {
                                        return FlLine(
                                          color: Colors.grey.withOpacity(0.2),
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    titlesData: FlTitlesData(
                                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, _) {
                                            const days = ["T2", "T3", "T4", "T5", "T6", "T7", "CN"];
                                            if (value.toInt() >= 0 && value.toInt() < days.length) {
                                              return Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3), // Giảm padding
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF8D6E63).withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(6), // Giảm từ 8 xuống 6
                                                ),
                                                child: Text(
                                                  days[value.toInt()],
                                                  style: TextStyle(
                                                    color: Color(0xFF8D6E63),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 11, // Giảm từ 12 xuống 11
                                                  ),
                                                ),
                                              );
                                            }
                                            return const SizedBox();
                                          },
                                          reservedSize: 35, // Giảm từ 40 xuống 35
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (value, _) => Padding(
                                            padding: const EdgeInsets.only(right: 6), // Giảm từ 8 xuống 6
                                            child: Text(
                                              "${(value / 1000000).toStringAsFixed(0)}M",
                                              style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 11, // Giảm từ 12 xuống 11
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          reservedSize: 40, // Giảm từ 45 xuống 40
                                          interval: 2000000,
                                        ),
                                      ),
                                    ),
                                    lineBarsData: [
                                      LineChartBarData(
                                        spots: const [
                                          FlSpot(0, 5000000),
                                          FlSpot(1, 6500000),
                                          FlSpot(2, 7000000),
                                          FlSpot(3, 7200000),
                                          FlSpot(4, 9000000),
                                          FlSpot(5, 10000000),
                                          FlSpot(6, 8500000),
                                        ],
                                        isCurved: true,
                                        curveSmoothness: 0.3,
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF8D6E63),
                                            Color(0xFFA1887F),
                                          ],
                                        ),
                                        barWidth: 4,
                                        isStrokeCapRound: true,
                                        dotData: FlDotData(
                                          show: true,
                                          getDotPainter: (spot, percent, bar, index) => FlDotCirclePainter(
                                            radius: 5, // Giảm từ 6 xuống 5
                                            color: Colors.white,
                                            strokeWidth: 2, // Giảm từ 3 xuống 2
                                            strokeColor: Color(0xFF8D6E63),
                                          ),
                                        ),
                                        belowBarData: BarAreaData(
                                          show: true,
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF8D6E63).withOpacity(0.3),
                                              Color(0xFF8D6E63).withOpacity(0.05),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                    minX: 0,
                                    maxX: 6,
                                    minY: 0,
                                    maxY: 12000000,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16), // Giảm từ 20 xuống 16
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String? subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final double delay;
  final AnimationController animationController;

  const _InfoCard({
    required this.title,
    required this.value,
    this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.delay,
    required this.animationController,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(delay, 1.0, curve: Curves.easeOutBack),
    ));

    final slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(delay, 1.0, curve: Curves.easeOutBack),
    ));

    return Expanded(
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: animation,
              child: Transform.scale(
                scale: animation.value,
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.all(12), // Giảm từ 16 xuống 12
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0.9),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18), // Giảm từ 20 xuống 18
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10), // Giảm từ 12 xuống 10
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColors),
                          borderRadius: BorderRadius.circular(12), // Giảm từ 14 xuống 12
                          boxShadow: [
                            BoxShadow(
                              color: gradientColors.first.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(icon, color: Colors.white, size: 20), // Giảm từ 24 xuống 20
                      ),
                      const SizedBox(height: 8), // Giảm từ 12 xuống 8
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 11, // Giảm từ 12 xuống 11
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4), // Giảm từ 6 xuống 4
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Flexible(
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 16, // Giảm từ 18 xuống 16
                                fontWeight: FontWeight.bold,
                                color: gradientColors.first,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (subtitle != null) ...[
                            const SizedBox(width: 1), // Giảm từ 2 xuống 1
                            Text(
                              subtitle!,
                              style: TextStyle(
                                fontSize: 9, // Giảm từ 10 xuống 9
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}