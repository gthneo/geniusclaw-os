import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/file_item.dart';

/// 文件管理页面
class FilesScreen extends ConsumerStatefulWidget {
  const FilesScreen({super.key});

  @override
  ConsumerState<FilesScreen> createState() => _FilesScreenState();
}

class _FilesScreenState extends ConsumerState<FilesScreen> {
  String _currentPath = '/';
  final List<String> _pathHistory = ['/'];

  // 示例数据
  final List<FileItem> _mockFiles = [
    FileItem(name: 'Documents', path: '/Documents', isDirectory: true, modified: DateTime.now()),
    FileItem(name: 'Pictures', path: '/Pictures', isDirectory: true, modified: DateTime.now()),
    FileItem(name: 'Videos', path: '/Videos', isDirectory: true, modified: DateTime.now()),
    FileItem(name: 'Music', path: '/Music', isDirectory: true, modified: DateTime.now()),
    FileItem(name: 'report.pdf', path: '/report.pdf', isDirectory: false, size: 1024000, modified: DateTime.now()),
    FileItem(name: 'photo.jpg', path: '/photo.jpg', isDirectory: false, size: 2048000, modified: DateTime.now()),
  ];

  void _navigateTo(String path) {
    setState(() {
      _currentPath = path;
      _pathHistory.add(path);
    });
  }

  void _navigateBack() {
    if (_pathHistory.length > 1) {
      setState(() {
        _pathHistory.removeLast();
        _currentPath = _pathHistory.last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('📁 文件管理'),
        actions: [
          IconButton(
            icon: const Icon(Icons.cloud_upload),
            onPressed: () => _showUploadDialog(),
            tooltip: '上传文件',
          ),
        ],
      ),
      body: Column(
        children: [
          // 路径导航
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.grey[100],
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: _pathHistory.length > 1 ? _navigateBack : null,
                ),
                Expanded(
                  child: Text(
                    _currentPath,
                    style: const TextStyle(fontFamily: 'monospace'),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => setState(() {}),
                ),
              ],
            ),
          ),
          // 文件列表
          Expanded(
            child: _mockFiles.isEmpty
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('📁', style: TextStyle(fontSize: 64)),
                        SizedBox(height: 16),
                        Text('文件夹为空'),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _mockFiles.length,
                    itemBuilder: (context, index) {
                      final file = _mockFiles[index];
                      return ListTile(
                        leading: Icon(file.icon, size: 32, color: Colors.grey),
                        title: Text(file.name),
                        subtitle: Text(
                          file.isDirectory 
                              ? '${_formatDate(file.modified)}'
                              : '${file.sizeFormatted} · ${_formatDate(file.modified)}',
                        ),
                        trailing: file.isDirectory
                            ? const Icon(Icons.chevron_right)
                            : PopupMenuButton(
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 'download',
                                    child: Text('下载'),
                                  ),
                                  const PopupMenuItem(
                                    value: 'delete',
                                    child: Text('删除'),
                                  ),
                                ],
                                onSelected: (value) {
                                  if (value == 'download') {
                                    // 下载文件
                                  } else if (value == 'delete') {
                                    // 删除文件
                                  }
                                },
                              ),
                        onTap: () {
                          if (file.isDirectory) {
                            _navigateTo(file.path);
                          } else {
                            // 预览或打开文件
                          }
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreateFolderDialog(),
        child: const Icon(Icons.create_new_folder),
      ),
    );
  }

  void _showUploadDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('上传文件'),
        content: const Text('选择要上传的文件'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('文件上传功能开发中...')),
              );
            },
            child: const Text('选择文件'),
          ),
        ],
      ),
    );
  }

  void _showCreateFolderDialog() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新建文件夹'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: '文件夹名称',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // 创建文件夹逻辑
            },
            child: const Text('创建'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}