import Foundation

public class LogManager {
    
    public static let IsDebug : Bool = true
    
    enum LogType: String {
        case error
        case warning
        case success
        case action
        case canceled
    }
    
    static func Debug (_ message: String) {
        Log(message, .action)
    }
    
    static func Error (_ message : String) {
        Log (message, .error)
    }
    
    static func Warn (_ message: String) {
        Log (message, .warning)
    }
    
    static func Success (_ message : String) {
        Log (message, .success)
    }
    
    static func Log (_ message: String, _ logType: LogType) {
        if !IsDebug {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string (from: Date())
        let messageFix = "\(message)"
        switch logType {
            case LogType.error:
                print ("[\(dateString)] ER:\(messageFix)")
            case LogType.warning:
                print ("[\(dateString)] WRN:\(messageFix)")
            case LogType.success:
                print ("[\(dateString)] SUC:\(messageFix)")
            case LogType.action:
                print ("[\(dateString)] AC:\(messageFix)")
            case LogType.canceled:
                print ("[\(dateString)] CA:\(messageFix)")
        }
         
    }
    
}

