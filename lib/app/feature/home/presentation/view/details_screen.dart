import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widget/simulated_map_widget.dart';
import '../../domain/entity/user_entity.dart';

@RoutePage()
class DetailsScreen extends StatelessWidget {
  final UserEntity userData;

  const DetailsScreen({
    super.key,
    required this.userData,
  });

  Color _parseColor(String colorStr) {
    try {
      return Color(int.parse(colorStr));
    } catch (e) {
      return Colors.blue;
    }
  }

  void _showFullScreenMap(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          child: Stack(
            children: [
              // Interactive Map covering full screen
              Positioned.fill(
                child: SimulatedMapWidget(
                  userData: userData,
                  isFullScreen: true,
                ),
              ),
              
              // Top Safe Area overlay for title & closing button
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 10,
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton.small(
                        heroTag: 'close_fullscreen_dialog',
                        backgroundColor: Colors.white.withValues(alpha: 0.9),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.close_rounded, color: Colors.black87),
                      ),
                    ],
                  ),

                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final avatarColor = _parseColor(userData.avatarColor);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Color(0xFF1E1B4B)),
        title: Text(
          userData.name,
          style: const TextStyle(
            color: Color(0xFF1E1B4B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Details Segment
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Avatar Card
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        color: avatarColor.withOpacity(0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: avatarColor,
                          width: 2.0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: avatarColor.withOpacity(0.1),
                            blurRadius: 16,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          userData.name.trim().split(' ').map((e) => e[0]).join().toUpperCase(),
                          style: TextStyle(
                            color: avatarColor,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      userData.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF).withOpacity(0.08),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Premium Dispatch Agent',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF0066FF),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Structured Info Cards
                    _buildInfoCard(
                      title: 'Contact Information',
                      items: [
                        _buildInfoItem(Icons.email_outlined, 'Email Address', userData.email),
                        _buildInfoItem(Icons.phone_outlined, 'Phone Number', userData.phone),
                        _buildInfoItem(Icons.location_on_outlined, 'Home Base Address', userData.address),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom Map Panel Title
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.route_rounded, color: Color(0xFF0066FF), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Route Routing (A → B)',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E1B4B),
                      ),
                    ),
                  ],
                ),
              ),

              // Map Window Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                height: 240,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      // Map View
                      Positioned.fill(
                        child: SimulatedMapWidget(userData: userData),
                      ),
                      
                      // Full screen floating command button
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: FloatingActionButton.small(
                            heroTag: 'trigger_fullscreen',
                            backgroundColor: Colors.white,
                            onPressed: () => _showFullScreenMap(context),
                            child: const Icon(Icons.fullscreen_rounded, color: Colors.black87),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> items}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 15,
            offset: const Offset(0, 5),
          )
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          ...items,
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF0066FF).withOpacity(0.06),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF0066FF), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF1E1B4B),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
