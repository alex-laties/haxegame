package entities.enemy;

import com.haxepunk.HXP;

import entities.enemy.Enemy;
import event.EventManager;

import haxe.Timer;


class EnemySpawner {
    private var spawned:Int;
    private var lastSpawned:Float;
    private var radian:Float;

    public function new() {
        spawned = 0;
        lastSpawned = 0;
        radian = 0.15;

        EventManager.onEvent("playerHit", reset);

        EventManager.onEvent("score", decrementSpawned);
        EventManager.onEvent("enemyRemoved", decrementSpawned);

    }

    public function reset() {
        spawned = 0;
        lastSpawned = 0;
        radian = 0.15;
    }

    public function timeToSpawn() {
        var curr = Timer.stamp();
        if (curr - lastSpawned > .1 && spawned < 10) {
            lastSpawned = curr;
            return true;
        }
        return false;
    }
            


    public function spawn() {
        spawned += 1;
        radian += 0.15;
        var y = Math.sin(radian) * HXP.height;
        return new Enemy(HXP.width, Math.abs(y));
    }


    private function decrementSpawned () {
        spawned -= 1;
    }
}
