import vibe.vibe;

import vibe.vibe;
import uim.apps.dms_web.infrastructure.persistence;
import uim.apps.dms_web.application.usecases;
import uim.apps.dms_web.infrastructure.web.controllers;

@safe:

/**
 * Application entry point - Composition root
 */
void main() @trusted {
  // Setup repositories
  auto documentRepo = new InMemoryDocumentRepository();
  auto folderRepo = new InMemoryFolderRepository();

  // Setup use cases
  auto createDocumentUseCase = new CreateDocumentUseCase(documentRepo);
  auto listDocumentsUseCase = new ListDocumentsUseCase(documentRepo);
  auto createFolderUseCase = new CreateFolderUseCase(folderRepo);

  // Setup controllers
  auto documentController = new DocumentController(createDocumentUseCase, listDocumentsUseCase);
  auto folderController = new FolderController(createFolderUseCase);

  // Setup HTTP server
  auto settings = new HTTPServerSettings;
  settings.port = 8080;
  settings.bindAddresses = ["127.0.0.1"];
  
  auto router = new URLRouter;
  
  // Register API routes
  documentController.registerRoutes(router);
  folderController.registerRoutes(router);
  
  // Serve static files
  router.get("/static/*", serveStaticFiles("public/"));
  
  // Serve main page
  router.get("/", (req, res) {
    res.render!("index.dt");
  });

  logInfo("Starting Document Management System on http://127.0.0.1:8080");
  listenHTTP(settings, router);
  
  runApplication();
}