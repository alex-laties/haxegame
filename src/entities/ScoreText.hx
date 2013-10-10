package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import event.EventManager;

class ScoreText extends Entity{
    private var current_score:Int;

    public function new(x, y) {
        super(x, y);
        current_score =  0;
        graphic = new Text(Std.string(current_score));
        EventManager.onEvent("score", function () {
            current_score += 1;
        });
    }

    public override function update() {
        cast(graphic, Text).text = Std.string(current_score);
    }
}
