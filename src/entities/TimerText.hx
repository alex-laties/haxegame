package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TimerText extends Entity {
    private var startTimestamp:Float;
    private var currentTimestamp:Float;
    private var lastDuration:Int;

    public function new(text:String, x:Float, y:Float) {
        super(x, y);
        graphic = new Text(text);
        startTimestamp = 0;
        currentTimestamp = 0;
        lastDuration = -1;
        type = "hud";
    }

    public override function update() {
        if (startTimestamp == 0) {
            startTimestamp = haxe.Timer.stamp();
        }

        currentTimestamp = haxe.Timer.stamp();

        var duration = Std.int(currentTimestamp - startTimestamp);

        if (duration > lastDuration) {
            cast(graphic, Text).text = 'Survived: $duration';
            lastDuration = duration;
        }
    }
}
