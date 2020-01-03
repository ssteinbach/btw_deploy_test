TODO
=================================

PLAYTEST SPRINT
-----------------
- fix the intro music offset time
- set up playtest

- add high score screen
- add intro
- turn into a library / code clean up so I can use the old outro animation
- detect the show entity bounds switch and use that to toggle the origin stuff
- add better death -> you failed transition (really unclear)

Today:
------
- add message based on how you died ("sploded", "bumped a bad guy")
- bring the zombie back as a melee enemy

- ranged enemy (cursed bow)
    - sprite [x]
    - have it move around and keep distance from you
    - when you get within range on its level, then it stops and charges up its arrow
    - arrow shoots out at you
- hit animation vs swing animation (you can get into a state where an enemy hits you mid swing that seems weird -- invincibility frames might be needed?)
- animation cleanup on the sword swing's smear frames
- probably want to run the updates in a particular order:
    - move enemies
    - draw enemies
    - update player
    - resolve interactions (Stuff getting hit, etc, player takes precedence)
    - draw player
- player sprite has a thing when you go from standing to running - the knee lines disapear
- bug when starting the game if you jam on the arrow key right on the first frame
    - (base frame is not set?)
- more appealing enemy motion
- add in proxy enemies that move towards the player
- overarching problem:
    - tweak the collision system
        - enemies need to grow movement colliders and hitboxes
        - tweak the collision areas
            - not the whole sprite, instead define smaller ones
    - zombies behave as if there are no obstacles or other zombies in the scene, don't interact with the map at all
- bomblin should trail fire sprites from lit end of fuse
- Things to try:
    - add collisions to their lunge attack 
    - after spawning, set an start amount of time into the first cycle (maybe some random 30% of the total time for the current task?)
    - vary the duration of the teleport animation
    - add a minimum time + a variation time (randomness) to the task queue on the zombies
    - add a bit of stun after the zombies finish teleporting
    
- when things spawn they should probably pause for a bit then make their first move
- add an offset or randomness to the time of their first move (random offset into the cycle)
- zombies should probably collide with each other (or use path finding to get to the player), or minimum constraint?  Fix flocking
- add randomness to when zombies make a decision
- zombie attack is broken
- Upgrade system for z-sorting sprites.  Should be on 10-s multiplied by y, so lower on the screen sprites obscure higher on the screen sprites
- allow diagonal attacks
- would be cool if the bomblin barfed out the bomb and then lit it when they spawn

Enemy Design
------------
- enemy that tracks you and throws spears at you

Wizard:
------
- add the wizard to the scene, wandering around near the top
- add exclamations from him when you score hits ( ":("  and "!!" when you take a hit), "@!#AS" when you beat a stage for a second, then teleport in next round
- SFX for the wizard would be cool
- could use a big version of one of the sprites (maybe the brute?)

Level stuff:
------
- add a breather after a level before the next level starts
- after killing all the enemies, have a little breather moment

Enemies:
------
- a few more from the list would be cool
- some kind of telegraphing would be nice - flashing red or something to signal they're about to attack

Juice/SFX
------
- teleports push back everyone
- the slash trail could fade
- blood that stays around on the floor
- sfx when you get hit 
- death effect (sprite goes sideways and flying, sword goes flying, corpse flickers out and wizard cheers?)
- if we're not doing animated sprites, we can still use text to sell stuff, like '!' for a stun frame or two

Player Control
--------------

Experiments:
- switch the attack to a dash forward and attack
- add a dash backwards + block front move (with a cooldown)
- Maybe you can drop a bomb that does damage to enemies + pushes them back?


Done
=====

- stunned sprite for the zombie
- death effect for enemy (if this can be generic, that would be great) - go sideways and slide away
- dust when you move
- Also flash the health bar
- Make health bar flash on hit
- Keep camera centered on arena (limit camera position)
- enemy corpses now stick around.
- make corpses clear when the level ends
- add in a warp effect when enemies are spawned
- limit camera motion so it doesn't run off the edges of the map so much
- wind up time where the enemies are teleported in
- teleport system using action system
- make level transitions not broken
- make enemies unhittable while teleporting
- Make corpses not have health bars and not take damage but be hittable
- knockback should do the correct bounce-off-walls-behavior
- when you die, add a little more stuff
- fix bug on respawn
- remove stray particles on game restart
- fix the projectiles and flash duration thing into functions so that all modes can call them
- explosive barrels
        - add a beat before they blow up
- corpses should not keep attacking... whoops
- add a win condition
- zombie:
    - pre-lunge and walking animation 
    - death animation for zombie when the body parts come apart 
    - less health
    - more zombies
- bug with multiple collisions at once
- celeste style ADSR (ATTACK DECAY SUSTAIN RELEASE) curves for input
- test out arena sizes
- build arena sprites to size
- fix the origin of the enemy so that flipping works the way it oght to.
- running animation should trigger when moving up/down as well (but no dust)
- add some histeresis so that when the player is on the edge the enemy doesn't flip around constantly
- little dust trail for player motion
- bombgoblin
    - spawns and runs at you
    - maybe one spawns every 5 or 10 seconds
    - if it touches you, you take damage
    - if you hit it, it dies
- bombgoblin throw animation
- bombgoblin throw animation spawns new bomb, triggers recharge animation
- switch animation of dude to use duration system
- use duration for the bomb throw and recharge animations
- fix movement target of bombgoblin to get pushed inwards when close the border of the board
- falling into the arena animation
- fix hit boundaries on the bombgoblin
- make the enemy movement target also only show in ^ condition
- add back in title screen
- kill player to go back to menu
- add back in music
- SFX
    - sword swing
    - spawn enemy
    - enemy lands
    - enemy gets hit
    - player gets hit
- fix looping (resetting game state on enter instead of init)
