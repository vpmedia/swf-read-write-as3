package {
    import flash.display.Sprite;
    import org.osflash.signals.*;
    public class Main extends Sprite {
        public function Main() {
            var signal:ISignal = new Signal();
            signal.dispatch();
        }
    }
}