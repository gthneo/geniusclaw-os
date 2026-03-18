/**
 * GeniusClaw OS - Core Entry Point
 * 正龙虾操作系统 - 主入口
 * 
 * @author Benedict Trump
 * @version 1.0.0
 */

import dotenv from 'dotenv';
import { P2PNetworkService } from './core/p2p-network.js';
import { OpenClawIntegrator } from './core/openclaw-integrator.js';
import { SkillsHubService } from './services/skills-hub.js';
import { ModelManagerService } from './services/model-manager.js';
import { NASService } from './services/nas-service.js';
import { NetworkService } from './services/network-service.js';
import { APIServer } from './api/server.js';

dotenv.config();

class GeniusClawOS {
  constructor(config = {}) {
    this.config = {
      // P2P Configuration
      p2p: {
        port: config.p2p?.port || 4000,
        bootNodes: config.p2p?.bootNodes || [],
        enableRemoteMaintenance: config.p2p?.enableRemoteMaintenance || false
      },
      // OpenClaw Configuration
      openclaw: {
        host: config.openclaw?.host || 'localhost',
        port: config.openclaw?.port || 8080
      },
      // MongoDB Configuration
      mongodb: {
        uri: process.env.MONGODB_URI || 'mongodb://localhost:27017/geniusclaw'
      },
      // Redis Configuration
      redis: {
        url: process.env.REDIS_URL || 'redis://localhost:6379'
      },
      // API Configuration
      api: {
        port: config.api?.port || 3000
      }
    };

    this.services = {};
    this.isRunning = false;
  }

  /**
   * Initialize all services
   */
  async init() {
    console.log('🦞 Initializing GeniusClaw OS...');

    // Initialize P2P Network (Core Feature)
    this.services.p2p = new P2PNetworkService({
      port: this.config.p2p.port,
      bootNodes: this.config.p2p.bootNodes
    });

    // Initialize OpenClaw Integration
    this.services.openclaw = new OpenClawIntegrator({
      host: this.config.openclaw.host,
      port: this.config.openclaw.port
    });

    // Initialize Skills Hub
    this.services.skillsHub = new SkillsHubService({
      p2p: this.services.p2p
    });

    // Initialize Model Manager
    this.services.modelManager = new ModelManagerService();

    // Initialize NAS Service
    this.services.nas = new NASService();

    // Initialize Network Service
    this.services.network = new NetworkService();

    // Initialize API Server
    this.services.api = new APIServer({
      port: this.config.api.port,
      services: this.services
    });

    console.log('✅ All services initialized');
  }

  /**
   * Start the operating system
   */
  async start() {
    if (this.isRunning) {
      console.warn('⚠️ GeniusClaw OS is already running');
      return;
    }

    try {
      console.log('🚀 Starting GeniusClaw OS...');

      // Start P2P Network
      await this.services.p2p.start();
      console.log('✅ P2P Network started');

      // Start API Server
      await this.services.api.start();
      console.log('✅ API Server started');

      this.isRunning = true;
      
      console.log(`
╔═══════════════════════════════════════════════════════════╗
║         🦞 GeniusClaw OS v1.0.0 - Running 🦞           ║
╠═══════════════════════════════════════════════════════════╣
║  P2P Network:   :${this.config.p2p.port}                               ║
║  API Server:     :${this.config.api.port}                               ║
║  OpenClaw:       :${this.config.openclaw.host}:${this.config.openclaw.port}                          ║
╚═══════════════════════════════════════════════════════════╝
      `);

    } catch (error) {
      console.error('❌ Failed to start GeniusClaw OS:', error);
      throw error;
    }
  }

  /**
   * Stop the operating system
   */
  async stop() {
    if (!this.isRunning) {
      return;
    }

    console.log('🛑 Stopping GeniusClaw OS...');

    try {
      // Stop all services
      await this.services.api?.stop();
      await this.services.p2p?.stop();

      this.isRunning = false;
      console.log('✅ GeniusClaw OS stopped');
    } catch (error) {
      console.error('❌ Error stopping GeniusClaw OS:', error);
    }
  }

  /**
   * Get system status
   */
  getStatus() {
    return {
      running: this.isRunning,
      uptime: this.isRunning ? process.uptime() : 0,
      services: {
        p2p: this.services.p2p?.isRunning() || false,
        openclaw: this.services.openclaw?.isConnected() || false,
        api: this.services.api?.isRunning() || false
      },
      config: {
        p2pPort: this.config.p2p.port,
        apiPort: this.config.api.port,
        peerId: this.services.p2p?.getPeerId()
      }
    };
  }
}

// Export for use
export { GeniusClawOS };

// CLI startup
if (import.meta.url === `file://${process.argv[1]}`) {
  const os = new GeniusClawOS();
  
  // Handle graceful shutdown
  process.on('SIGINT', async () => {
    console.log('\n🛑 Received SIGINT, shutting down...');
    await os.stop();
    process.exit(0);
  });

  process.on('SIGTERM', async () => {
    console.log('\n🛑 Received SIGTERM, shutting down...');
    await os.stop();
    process.exit(0);
  });

  // Start the OS
  os.init()
    .then(() => os.start())
    .catch(error => {
      console.error('Fatal error:', error);
      process.exit(1);
    });
}