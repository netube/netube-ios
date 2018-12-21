extension Optional where Wrapped == String {
        var hasCharacters: Bool {
                if (self == nil) || (self?.isEmpty ?? true) {
                        return false
                } else {
                        return true
                }
                // return !(self == nil || (self?.isEmpty ?? true))
        }
        
        var convertToInteger: Int {
                return Int(self ?? "0") ?? 0
        }
}
