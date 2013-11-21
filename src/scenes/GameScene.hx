package scenes;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.Scene;

import entities.enemy.EnemySpawner;
import entities.Player;
import entities.TimerText;
import entities.ScoreText;

import event.EventManager;

class GameScene extends Scene {
    private var player:Entity;
    private var spawnTimer:Float;
    private var spawner:EnemySpawner;
    public var gameOver:Bool;

    public function new() {
        super();
    }

    public override function begin() {
        gameOver = false;
        player = new entities.Ship(HXP.halfWidth - 16, HXP.height);
        add(player);
        add(new TimerText("Start", HXP.halfWidth, 0));

        spawner = new EnemySpawner();

        EventManager.onEvent("playerHit", function() {
            gameOver = true;
        });
    }

    public function reset() {
        removeAll();
        EventManager.reset();
        begin();
    }

    public override function update() {
        EventManager.update();
        if (gameOver) {
            reset();
        }

        if (spawner.timeToSpawn()) {
            add(spawner.spawn());
        }
        super.update();
    }

    public function getPlayer() {
        return player;
    }
}
