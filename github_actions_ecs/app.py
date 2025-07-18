from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello from ECS")

if __name__ == "__main__":
    server = HTTPServer(("", 8000), Handler)
    server.serve_forever()
