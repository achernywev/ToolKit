import Foundation

public extension Decodable {
    init?(jsonData: Data?) {
        guard let data = jsonData else { return nil }
        do {
            let decoder = JSONDecoder()
            self = try decoder.decode(Self.self, from: data)
        } catch {
            let typeName = String(describing: Self.self)
            print("Error decoding \(typeName): \(error)")
            return nil
        }
    }
    
    init?(url: URL?) {
        guard let url = url else { return nil }
        let data = try? Data(contentsOf: url)
        self.init(jsonData: data)
    }
}
