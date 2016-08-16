import HTTP
import Vapor

struct BlackBox: Middleware {
    enum Error: Swift.Error {
        case BecauseWeCan
    }

    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        throw Error.BecauseWeCan
    }
}
