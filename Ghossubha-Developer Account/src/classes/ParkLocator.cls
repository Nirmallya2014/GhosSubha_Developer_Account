public class ParkLocator {
    public static List<String> Country(string cName) {
        ParkService pService = new ParkService();
        ParkService.byCountry byCoun = new ParkService.byCountry();
        byCoun.arg0 = cName;
        ParkService.ParksImplPort callWSDL = new ParkService.ParksImplPort();
        List<string> response = callWSDL.byCountry(cName);
        system.debug('@Response@'+response);
        return response;
    }
}