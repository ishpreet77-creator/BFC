import NetworkExtension
class HotspotHelper {
    
    func connectToWifi(
        wifiName: String,
        wifiPassword: String,
        wep: Bool,
        completion: @escaping ((_ error: Bool) -> Void) )
    {
        self.clearConfiguredWifi()

        let hotspotConfig = NEHotspotConfiguration(ssid: wifiName, passphrase: wifiPassword, isWEP: wep)
        NEHotspotConfigurationManager.shared.apply(hotspotConfig) { (hotSpotError) in
            if let _ = hotSpotError {
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func disconnectAction( _ wifiName: String ) {
        NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: wifiName)
    }
    
    private func clearConfiguredWifi() {
        NEHotspotConfigurationManager.shared.getConfiguredSSIDs { (wifiList) in
            wifiList.forEach {
                NEHotspotConfigurationManager.shared.removeConfiguration(forSSID: $0)
            }
        }
    }

}
