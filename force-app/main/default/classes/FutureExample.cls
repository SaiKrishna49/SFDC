public class FutureExample {
    @future
    public static void callme(){
        system.debug('callme 1');
        system.debug('callme 2');
        system.debug('callme 3');
    }
    @future
    public static void invoke(){
        system.debug('invoke 1');
        system.debug('invoke 2');
        system.debug('invoke 3');
    }
    public static void show(){
        system.debug('Show 1');
        callme();
        system.debug('Show 2');
        invoke();
        system.debug('Show 3');
    }
}