import Vapor
import HTTP

let drop = Droplet()

drop.get("ping") { _ in "pong" }

enum Role {
    case Admin, Guest
}

extension Request {
    var role: Role {
        if query?["role"]?.string == "admin" {
            return .Admin
        }

        return .Guest
    }
}

struct AuthMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        guard request.role == .Admin else {
            throw Abort.custom(status: .imATeapot, message: "")
        }

        return try next.respond(to: request)
    }
}

drop.group(AuthMiddleware()) { auth in
    auth.get("admin") { _ in "secret" }
}

drop.serve()
