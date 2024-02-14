import Foundation

class CommonDateTime {

    public static func GetUnixTimestamp () -> Int64 {
        return Int64 (Date().timeIntervalSince1970)
    }
    
}

