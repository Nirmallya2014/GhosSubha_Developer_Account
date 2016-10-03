public class TestApexChartsController {

    public List<String> PositivePersonaName {get;set;}
    public List<Integer> PositiveTotalNoOfCustomer {get;set;}
    public List<Data1> getData1() {
        PositiveTotalNoOfCustomer = new List<Integer>();
        PositivePersonaName = new List<String>();
        for(Integer i=0; i < 5; i++) {
            PositivePersonaName.add('Jimmy-'+i);
            PositiveTotalNoOfCustomer.add((i+1)*3);
        }
        
        List<Data1> dataList = new List<Data1>();
        dataList.add(new Data1('Positive', PositivePersonaName, PositiveTotalNoOfCustomer));
        dataList.add(new Data1('Negetive', PositivePersonaName, PositiveTotalNoOfCustomer));
        dataList.add(new Data1('Neutral', PositivePersonaName, PositiveTotalNoOfCustomer));
        return dataList;
    }
    
    public class Data1{
        public String sentimentType{ get; set; }
        public List<String> personaName{ get; set; }
        public List<Integer> totalNoOfCustomer{ get; set; }
        
        public Data1(String sentimentType, List<String> personaName, List<Integer> totalNoOfCustomer) {
            this.sentimentType = sentimentType;
            this.personaName = personaName;
            this.totalNoOfCustomer = totalNoOfCustomer;
        }
    }
   
    /*
    public List<Data> getData() {
        List<Data> data = new List<Data>();
        data.add(new Data('Jan', 30, 90, 55));
        data.add(new Data('Feb', 44, 15, 65));
        data.add(new Data('Mar', 25, 32, 75));
        return data;
    }
    // Wrapper class
    public class Data {
        public String fname { get; set; }
        public Integer data1 { get; set; }
        public Integer data2 { get; set; }
        public Integer data3 { get; set; }
        public Data(String name, Integer data1, Integer data2, Integer data3) {
            this.fname = name;
            this.data1 = data1;
            this.data2 = data2;
            this.data3 = data3;
        }
    }
    */
    
    public List<Data> getData() {
        List<Data> data = new List<Data>();
        data.add(new Data('Jimmy', 30));
        data.add(new Data('Derek', 44));
        data.add(new Data('Maria', 25));
        return data;
    }
    // Wrapper class
    public class Data {
        public String personaName{ get; set; }
        public Integer NPSScore{ get; set; }
        public Data(String personaName, Integer NPSScore) {
            this.personaName = personaName;
            this.NPSScore = NPSScore;
        }
    }
    
    public List<Data2> getData2() {


        List<Data2> data = new List<Data2>();


        data.add(new Data2('Jan', 30, 90, 55));


        data.add(new Data2('Feb', 44, 15, 65));


        data.add(new Data2('Mar', 25, 32, 75));


        data.add(new Data2('Apr', 74, 28, 85));


        data.add(new Data2('May', 65, 51, 95));


        data.add(new Data2('Jun', 33, 45, 99));


        data.add(new Data2('Jul', 92, 82, 60));


        data.add(new Data2('Aug', 87, 73, 45));


        data.add(new Data2('Sep', 34, 65, 55));


        data.add(new Data2('Oct', 78, 66, 56));


        data.add(new Data2('Nov', 80, 67, 53));


        data.add(new Data2('Dec', 17, 70, 70));


        return data;


    }


    // Wrapper class


    public class Data2 {


        public String fname { get; set; }


        public Integer data1 { get; set; }


        public Integer data2 { get; set; }


        public Integer data3 { get; set; }


        public Data2(String name, Integer data1, Integer data2, Integer data3) {


            this.fname = name;


            this.data1 = data1;


            this.data2 = data2;


            this.data3 = data3;


        }


    }
}