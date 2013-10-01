package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;

class ScoreText extends Entity{
    private var current_score:Int;

    public function new(x, y) {
        super(x, y);
        current_score =  0;
        graphic = new Text(Std.string(current_score));
    }

    public override function update() {
        cast(graphic, Text).text = Std.string(current_score);
    }

    public function increment(amount:Int) {
        current_score += amount;
    }
}
