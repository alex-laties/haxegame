package entities.enemy;

import com.haxepunk.HXP;

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
        var x = Math.sin(radian) * HXP.width;
        return new entities.enemy.PatternEnemy(Math.abs(x), 10);
    }


    private function decrementSpawned () {
        spawned -= 1;
    }
}
