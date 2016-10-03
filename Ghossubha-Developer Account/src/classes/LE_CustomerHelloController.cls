public class LE_CustomerHelloController {
    // Return a list of data points for a chart
    public List<String> monthSet {get; set;}
    public List<Data> getData() {
        monthSet = new List<String>();
        monthSet.add('Positive');
        monthSet.add('Negetive');
        monthSet.add('Neutral');
        monthSet.add('Neutral');
        
        Set<Integer> intSet = new Set<Integer>();
        intSet.add(30);
        intSet.add(90);
        intSet.add(55);
        
        List<Data> data = new List<Data>();
        integer i=10;
        For(String str : monthSet) {
            data.add(new Data(str, 25+i, 90+i, 55+i));
            i = i + 50;
        }
        //data.add(new Data('', 44, 15, 65));
        //data.add(new Data(monthSet, 25, 32, 75));
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
}