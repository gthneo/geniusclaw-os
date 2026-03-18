/**
 * API Server
 * REST API 服务器
 */

import express from 'express';
import { WebSocketServer } from 'ws';
import { createServer } from 'http';

class APIServer {
  constructor(config = {}) {
    this.config = config;
    this.app = express();
    this.server = null;
    this.wss = null;
    this.services = config.services || {};
    this.isRunning = false;
  }

  /**
   * Initialize API server
   */
  init() {
    // Middleware
    this.app.use(express.json());
    this.app.use(express.urlencoded({ extended: true }));

    // CORS
    this.app.use((req, res, next) => {
      res.header('Access-Control-Allow-Origin', '*');
      res.header('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
      res.header('Access-Control-Allow-Headers', 'Content-Type, Authorization');
      if (req.method === 'OPTIONS') {
        return res.sendStatus(200);
      }
      next();
    });

    // Request logging
    this.app.use((req, res, next) => {
      console.log(`   📡 ${req.method} ${req.path}`);
      next();
    });

    // Setup routes
    this.setupRoutes();
    this.setupWebSocket();
  }

  /**
   * Setup API routes
   */
  setupRoutes() {
    // Health check
    this.app.get('/api/health', (req, res) => {
      res.json({ status: 'ok', timestamp: new Date().toISOString() });
    });

    // System status
    this.app.get('/api/status', (req, res) => {
      res.json({
        p2p: {
          running: this.services.p2p?.isP2PRunning() || false,
          peerId: this.services.p2p?.getPeerId(),
          connectedPeers: this.services.p2p?.getConnectedPeers() || []
        },
        openclaw: {
          connected: this.services.openclaw?.isConnectedToOpenClaw() || false,
          currentModel: this.services.openclaw?.getCurrentModel()
        },
        uptime: process.uptime()
      });
    });

    // Skills Hub routes
    this.app.get('/api/skills', async (req, res) => {
      try {
        const { category, search } = req.query;
        const skills = await this.services.skillsHub?.listSkills({ category, search });
        res.json({ success: true, skills });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    this.app.get('/api/skills/:id', async (req, res) => {
      try {
        const skill = await this.services.skillsHub?.getSkill(req.params.id);
        if (!skill) {
          return res.status(404).json({ success: false, error: 'Skill not found' });
        }
        res.json({ success: true, skill });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    this.app.post('/api/skills/:id/install', async (req, res) => {
      try {
        const { userId } = req.body;
        const result = await this.services.skillsHub?.installSkill(req.params.id, userId);
        res.json(result);
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    this.app.get('/api/skills/categories', async (req, res) => {
      try {
        const categories = await this.services.skillsHub?.getCategories();
        res.json({ success: true, categories });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    // Model Manager routes
    this.app.get('/api/models', async (req, res) => {
      try {
        const models = await this.services.openclaw?.getAvailableModels();
        res.json({ success: true, models });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    this.app.post('/api/models/switch', async (req, res) => {
      try {
        const { modelId } = req.body;
        const model = await this.services.openclaw?.switchModel(modelId);
        res.json({ success: true, model });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    // P2P routes
    this.app.get('/api/p2p/peers', (req, res) => {
      try {
        const peers = this.services.p2p?.getConnectedPeers() || [];
        res.json({ success: true, peers });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    this.app.get('/api/p2p/info', (req, res) => {
      try {
        res.json({
          success: true,
          info: {
            peerId: this.services.p2p?.getPeerId(),
            multiaddrs: this.services.p2p?.getMultiaddrs() || []
          }
        });
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    // AI Chat route
    this.app.post('/api/ai/chat', async (req, res) => {
      try {
        const { message, context } = req.body;
        const result = await this.services.openclaw?.processNaturalLanguage(message, context);
        res.json(result);
      } catch (error) {
        res.status(500).json({ success: false, error: error.message });
      }
    });

    // 404 handler
    this.app.use((req, res) => {
      res.status(404).json({ success: false, error: 'Not found' });
    });

    // Error handler
    this.app.use((err, req, res, next) => {
      console.error('   ❌ API Error:', err);
      res.status(500).json({ success: false, error: err.message });
    });
  }

  /**
   * Setup WebSocket
   */
  setupWebSocket() {
    this.wss = new WebSocketServer({ noServer: true });

    this.wss.on('connection', (ws) => {
      console.log('   🔌 WebSocket client connected');

      ws.on('message', async (message) => {
        try {
          const data = JSON.parse(message);
          
          // Handle different message types
          switch (data.type) {
            case 'ai:chat':
              const result = await this.services.openclaw?.processNaturalLanguage(data.message);
              ws.send(JSON.stringify({ type: 'ai:response', data: result }));
              break;
              
            case 'p2p:subscribe':
              // Subscribe to P2P events
              break;
              
            default:
              ws.send(JSON.stringify({ type: 'error', message: 'Unknown message type' }));
          }
        } catch (error) {
          ws.send(JSON.stringify({ type: 'error', message: error.message }));
        }
      });

      ws.on('close', () => {
        console.log('   🔌 WebSocket client disconnected');
      });
    });
  }

  /**
   * Start the API server
   */
  async start() {
    this.init();
    
    return new Promise((resolve, reject) => {
      this.server = createServer(this.app);
      
      // Handle WebSocket upgrade
      this.server.on('upgrade', (request, socket, head) => {
        if (request.url === '/ws') {
          this.wss.handleUpgrade(request, socket, head, (ws) => {
            this.wss.emit('connection', ws, request);
          });
        } else {
          socket.destroy();
        }
      });

      this.server.listen(this.config.port, () => {
        this.isRunning = true;
        console.log(`   ✅ API Server listening on port ${this.config.port}`);
        resolve();
      });

      this.server.on('error', (error) => {
        reject(error);
      });
    });
  }

  /**
   * Stop the API server
   */
  async stop() {
    if (!this.isRunning) return;

    return new Promise((resolve) => {
      this.wss?.close();
      this.server?.close(() => {
        this.isRunning = false;
        console.log('   API Server stopped');
        resolve();
      });
    });
  }

  /**
   * Check if running
   */
  isAPIRunning() {
    return this.isRunning;
  }
}

export { APIServer };