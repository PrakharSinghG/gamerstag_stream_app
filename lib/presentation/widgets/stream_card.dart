import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StreamCard extends StatelessWidget {
  final String thumbnailUrl;
  final String platformIconAsset;
  final String title;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const StreamCard({
    super.key,
    required this.thumbnailUrl,
    required this.platformIconAsset,
    required this.title,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(thumbnailUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Positioned(
                top: 8,
                right: 8,
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Edit') {
                      onEdit();
                    } else if (value == 'Delete') {
                      onDelete();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      
                    ];
                  },
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

         
          Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1D3C34), 
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: SvgPicture.asset(
                    platformIconAsset,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
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
