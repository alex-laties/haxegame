package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class TimerText extends Entity {
    public function new(text:String, x:Float, y:Float) {
        super(x, y);
        graphic = new Text(text);
        start_timestamp = 0;
        current_timestamp = 0;
        type = "hud";
    }

    public override function update() {
        if (start_timestamp == 0) {
            start_timestamp = haxe.Timer.stamp();
        }

        current_timestamp = haxe.Timer.stamp();

        var duration = current_timestamp - start_timestamp;
        cast(graphic, Text).text = Std.string(duration);
    }

    private var start_timestamp:Float;
    private var current_timestamp:Float;
}
