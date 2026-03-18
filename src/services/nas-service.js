/**
 * NAS Service
 * 本地存储服务
 */

import fs from 'fs/promises';
import path from 'path';
import { fileURLToPath } from 'url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));

class NASService {
  constructor(config = {}) {
    this.config = {
      storagePath: config.storagePath || '/data/nas',
      maxFileSize: config.maxFileSize || 10 * 1024 * 1024 * 1024, // 10GB
      enableSMB: config.enableSMB !== false,
      enableDLNA: config.enableDLNA !== false
    };

    this.files = new Map();
    this.shares = new Map();
  }

  /**
   * Initialize storage
   */
  async init() {
    console.log('   📁 Initializing NAS storage...');
    
    try {
      await fs.mkdir(this.config.storagePath, { recursive: true });
      await this.scanFiles();
      console.log('   ✅ NAS storage initialized');
    } catch (error) {
      console.error('   ❌ Failed to initialize NAS:', error);
    }
  }

  /**
   * Scan existing files
   */
  async scanFiles() {
    try {
      const entries = await fs.readdir(this.config.storagePath, { withFileTypes: true });
      
      for (const entry of entries) {
        const fullPath = path.join(this.config.storagePath, entry.name);
        
        if (entry.isFile()) {
          const stats = await fs.stat(fullPath);
          this.files.set(fullPath, {
            name: entry.name,
            path: fullPath,
            size: stats.size,
            created: stats.birthtime,
            modified: stats.mtime,
            type: this.getFileType(entry.name)
          });
        } else if (entry.isDirectory()) {
          // Recursively scan directory
          await this.scanDirectory(fullPath);
        }
      }
    } catch (error) {
      console.error('   Error scanning files:', error);
    }
  }

  async scanDirectory(dirPath) {
    try {
      const entries = await fs.readdir(dirPath, { withFileTypes: true });
      
      for (const entry of entries) {
        const fullPath = path.join(dirPath, entry.name);
        
        if (entry.isFile()) {
          const stats = await fs.stat(fullPath);
          this.files.set(fullPath, {
            name: entry.name,
            path: fullPath,
            size: stats.size,
            created: stats.birthtime,
            modified: stats.mtime,
            type: this.getFileType(entry.name)
          });
        }
      }
    } catch (error) {
      // Ignore permission errors
    }
  }

  /**
   * Get file type
   */
  getFileType(filename) {
    const ext = path.extname(filename).toLowerCase();
    const types = {
      '.jpg': 'image',
      '.jpeg': 'image',
      '.png': 'image',
      '.gif': 'image',
      '.mp4': 'video',
      '.avi': 'video',
      '.mkv': 'video',
      '.mp3': 'audio',
      '.wav': 'audio',
      '.pdf': 'document',
      '.doc': 'document',
      '.docx': 'document',
      '.txt': 'document',
      '.zip': 'archive'
    };
    
    return types[ext] || 'other';
  }

  /**
   * List files
   */
  async listFiles(options = {}) {
    let files = Array.from(this.files.values());

    if (options.type) {
      files = files.filter(f => f.type === options.type);
    }

    if (options.folder) {
      const folderPath = path.join(this.config.storagePath, options.folder);
      files = files.filter(f => f.path.startsWith(folderPath));
    }

    return files;
  }

  /**
   * Upload file
   */
  async uploadFile(fileBuffer, filename, folder = '') {
    const folderPath = path.join(this.config.storagePath, folder);
    await fs.mkdir(folderPath, { recursive: true });
    
    const fullPath = path.join(folderPath, filename);
    await fs.writeFile(fullPath, fileBuffer);
    
    const stats = await fs.stat(fullPath);
    const fileInfo = {
      name: filename,
      path: fullPath,
      size: stats.size,
      created: stats.birthtime,
      modified: stats.mtime,
      type: this.getFileType(filename)
    };
    
    this.files.set(fullPath, fileInfo);
    return fileInfo;
  }

  /**
   * Download file
   */
  async downloadFile(filePath) {
    const file = this.files.get(filePath);
    if (!file) {
      throw new Error('File not found');
    }
    
    return await fs.readFile(filePath);
  }

  /**
   * Delete file
   */
  async deleteFile(filePath) {
    await fs.unlink(filePath);
    this.files.delete(filePath);
    return { success: true };
  }

  /**
   * Create folder
   */
  async createFolder(folderName, parent = '') {
    const fullPath = path.join(this.config.storagePath, parent, folderName);
    await fs.mkdir(fullPath, { recursive: true });
    return { success: true, path: fullPath };
  }

  /**
   * Get storage stats
   */
  async getStorageStats() {
    let totalSize = 0;
    let fileCount = this.files.size;
    
    for (const file of this.files.values()) {
      totalSize += file.size;
    }

    return {
      totalFiles: fileCount,
      totalSize: totalSize,
      storagePath: this.config.storagePath
    };
  }

  /**
   * Enable SMB sharing
   */
  async enableSMBShare(shareName, folderPath) {
    this.shares.set(shareName, {
      path: folderPath,
      enabled: true,
      type: 'smb'
    });
    
    // In production, would configure Samba
    console.log(`   ✅ SMB share enabled: ${shareName}`);
    return { success: true, shareName };
  }

  /**
   * Enable DLNA
   */
  async enableDLNA() {
    // In production, would configure MiniDLNA
    console.log('   ✅ DLNA media server enabled');
    return { success: true };
  }
}

export { NASService };