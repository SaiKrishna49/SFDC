public class CalculatorApexClass 
{
    public static integer Sum(Integer Aval, Integer Bval)
    {	
        Integer SumRes;
        SumRes= Aval+ Bval;
        return SumRes;
      //  system.debug('SumRes='+SumRes);
        
    }
    public static void Mul(Integer Aval, Integer Bval)
    {
        Integer MulRes;
        MulRes= Aval*Bval;
        system.debug('MulRes='+MulRes);
    }
}