import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pravasitax_flutter/src/interface/screens/chat_nav/chat_page.dart';
import 'package:pravasitax_flutter/src/interface/screens/home_cards/tax_filing_adv.dart';
import 'package:pravasitax_flutter/src/interface/screens/home_cards/tax_tools.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/providers/home_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:developer' as developer;
import 'package:pravasitax_flutter/src/interface/screens/common/webview_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    developer.log('Initializing HomePage', name: 'HomePage');
    Future.microtask(() {
      developer.log('Fetching home page data', name: 'HomePage');
      ref.read(homeProvider.notifier).fetchHomePageData();
    });
  }

  void _launchUrl(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(
          url: url,
          title: '', // You can customize this title
        ),
      ),
    );
  }

  String _getIconPathForService(String serviceName) {
    // Map service names to icon paths
    final Map<String, String> iconMap = {
      'Tax Filing': 'assets/icons/tax_filing.svg',
      'Wealth Planning': 'assets/icons/wealth.svg',
      'Property Related Services': 'assets/icons/property.svg',
      'PAN Related Services': 'assets/icons/pan.svg',
      // Add more mappings as needed
    };

    return iconMap[serviceName] ??
        'assets/icons/tax_filing.svg'; // Default icon
  }

  @override
  Widget build(BuildContext context) {
    developer.log('Building HomePage', name: 'HomePage');
    final homeState = ref.watch(homeProvider);

    if (homeState.isLoading) {
      developer.log('HomePage is in loading state', name: 'HomePage');
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (homeState.error != null) {
      developer.log('HomePage encountered error: ${homeState.error}',
          name: 'HomePage');
      return Scaffold(
        body: Center(child: Text('Error: ${homeState.error}')),
      );
    }

    final data = homeState.data;
    if (data == null) {
      developer.log('HomePage has no data', name: 'HomePage');
      return const Scaffold(
        body: Center(child: Text('No data available')),
      );
    }

    developer.log('HomePage data loaded successfully', name: 'HomePage');

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for any services',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Service Cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                ),
                itemCount: data.serviceList.length.clamp(0, 4),
                itemBuilder: (context, index) {
                  final service = data.serviceList[index];
                  return _buildServiceCard(
                    title: service.service,
                    iconPath: _getIconPathForService(service.service),
                    color: const Color(0xFFDCDCDC),
                    textColor: const Color(0xFF003366),
                    onTap: service.url != null
                        ? () => _launchUrl(service.url!)
                        : null,
                  );
                },
              ),
              const SizedBox(height: 24),

              // First Section Banners
              if (data.firstSectionBanners.isNotEmpty)
                _buildBanner(
                  title: data.firstSectionBanners[0].title,
                  description: data.firstSectionBanners[0].label,
                  bgColor: const Color(0xFFFFF9E6),
                  imageUrl: data.firstSectionBanners[0].image,
                  onTap: data.firstSectionBanners[0].url != null
                      ? () => _launchUrl(data.firstSectionBanners[0].url!)
                      : null,
                ),
              const SizedBox(height: 24),

              // Scenarios Section
              const Text(
                'Common Scenarios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.scenarios.length,
                  itemBuilder: (context, index) {
                    final scenario = data.scenarios[index];
                    return _buildPropertyCard(
                      context,
                      scenario.scenario,
                      scenario.url != null
                          ? () => _launchUrl(scenario.url!)
                          : null,
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Tools',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.taxTools.length,
                  itemBuilder: (context, index) {
                    final tool = data.taxTools[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Column(
                        children: [
                          _buildToolCard(
                            context: context,
                            icon: Icons.calculate,
                            title: '',
                            color: const Color(0xFFFFF3F3),
                            onTap: tool.url != null
                                ? () => _launchUrl(tool.url!)
                                : null,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            tool.title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 10, color: Colors.black87),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Event Section
              if (data.event != null)
                _buildEventCard(
                  context: context,
                  isLive: data.event?.type?.toLowerCase() == 'live',
                  tag: data.event?.type ?? '',
                  date: data.event?.date ?? '',
                  time: data.event?.time ?? '',
                  title: data.event?.title ?? '',
                  description: data.event?.location ?? '',
                  imageUrl:
                      data.event?.banner ?? '', // Changed to use network image
                  price: data.event?.price ?? '',
                ),
              const SizedBox(height: 24),

              // Blogs Section
              const Text(
                'Latest Blogs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.blogs.length.clamp(0, 3),
                itemBuilder: (context, index) {
                  final blog = data.blogs[index];
                  return Card(
                    child: ListTile(
                      leading: blog.thumbnail != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                imageUrl: blog.thumbnail!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[200],
                                  child: const Center(
                                    child: SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 60,
                                  height: 60,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.image,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey[200],
                              child: const Icon(
                                Icons.image,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                      title: Text(blog.title),
                      subtitle: Text(blog.shortDescription ?? ''),
                      onTap:
                          blog.url != null ? () => _launchUrl(blog.url!) : null,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        backgroundColor: const Color(0xFF040F4F),
        child: const Icon(Icons.chat, color: Color(0xFFF9B406)),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String iconPath,
    required Color color,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        height: 100,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              iconPath,
              width: 36,
              height: 36,
              placeholderBuilder: (context) => SizedBox(
                width: 36,
                height: 36,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(textColor),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner({
    required String title,
    required String description,
    required Color bgColor,
    required String imageUrl,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey[200],
                  child: const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                      ),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) {
                  developer.log('Error loading image: $error',
                      name: 'HomePage');
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.grey,
                      size: 24,
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPropertyCard(
      BuildContext context, String title, VoidCallback? onTap) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required Color color,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 36, color: Colors.black54), // Placeholder icon
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required BuildContext context,
    required bool isLive,
    required String tag,
    required String date,
    required String time,
    required String title,
    required String description,
    required String imageUrl,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: isLive ? Colors.red : Colors.green,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Date and time row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.yellow[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  date,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              const SizedBox(width: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(time, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Title and description
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 16),

          // Join Now button
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Join Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildCommonDifficultiesBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Common Difficulties in filing taxes',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Help Section Widget
  Widget _buildHelpSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Difficulties in filing taxes?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const Text('Lorem ipsum dolor sit amet consectetur.'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Contact Us'),
        ),
      ],
    );
  }
}
