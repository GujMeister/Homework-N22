class NetworkConstants {
    
    public static var shared: NetworkConstants = NetworkConstants()
    
    public var apiKey: String {
        get {
            return ""
        }
    }
    
    public var serverAddress: String {
        get {
            return "https://restcountries.com/v3.1/all"
        }
    }
}
